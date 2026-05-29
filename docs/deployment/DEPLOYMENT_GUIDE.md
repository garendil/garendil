# Guía de Deployment — Garendil

## Pre-requisitos

- Hetzner VPS (mínimo: 2vCPU, 4GB RAM, 50GB SSD)
- Vercel account
- GitHub repo
- Domain name (ej: garendil.pe)

## Arquitectura de Producción

```
Frontend (Vercel)
  └── Next.js SSR + Static
      └── https://garendil.pe

Backend (Hetzner VPS)
  ├── FastAPI (port 8000)
  ├── PostgreSQL (port 5432)
  ├── Neo4j (port 7687)
  └── Redis (port 6379)
  └── Nginx (reverse proxy, port 80/443)
```

## Deploy Frontend (Vercel)

1. "New Project" → seleccionar repo en Vercel dashboard
2. Framework: "Next.js"
3. Environment variables:
   ```
   NEXT_PUBLIC_API_URL=https://api.garendil.pe
   ```
4. Deploy → asignar dominio personalizado

## Deploy Backend (Hetzner)

### 1. Provisionar VPS

```bash
# Hetzner Cloud: Ubuntu 24.04 LTS, CX22 (2vCPU, 4GB RAM)
ssh root@IP_SERVIDOR
```

### 2. Setup inicial

```bash
apt update && apt upgrade -y
apt install -y docker.io docker-compose curl git nginx
systemctl enable --now docker

useradd -m -s /bin/bash garendil
usermod -aG docker garendil
```

### 3. Clone repo y configurar entorno

```bash
su - garendil
git clone https://github.com/rodhandev/garendil.git
cd garendil/

# Crear .env de producción (NO commitear)
cat > .env.production << 'EOF'
DATABASE_URL=postgresql://garendil:CAMBIAR_PASS@localhost:5432/garendil_prod
NEO4J_URL=neo4j://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=CAMBIAR_PASS
REDIS_URL=redis://localhost:6379
CORS_ORIGINS=https://garendil.pe,https://www.garendil.pe
OSCE_API_KEY=TU_API_KEY
EOF
chmod 600 .env.production
```

### 4. Levantar servicios

```bash
docker-compose -f infra/docker-compose.yml up -d
docker-compose logs -f postgres  # esperar ready
```

### 5. Nginx reverse proxy

```nginx
# /etc/nginx/sites-available/garendil
upstream api {
    server localhost:8000;
}

server {
    listen 80;
    server_name api.garendil.pe;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    server_name api.garendil.pe;

    ssl_certificate /etc/letsencrypt/live/api.garendil.pe/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.garendil.pe/privkey.pem;

    location / {
        proxy_pass http://api;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
ln -s /etc/nginx/sites-available/garendil /etc/nginx/sites-enabled/
nginx -t && systemctl restart nginx
```

### 6. SSL

```bash
apt install -y certbot python3-certbot-nginx
certbot certonly --nginx -d api.garendil.pe
```

## Health checks

```bash
curl https://api.garendil.pe/health
curl https://api.garendil.pe/api/stats
```

## Logs

```bash
docker-compose logs -f api
tail -f /var/log/nginx/error.log
```

## Backups

```bash
# Cron diario 02:00
0 2 * * * pg_dump garendil_prod | gzip > /backups/garendil-$(date +%Y%m%d).sql.gz
```

## Scaling

1. Migrar Docker Compose → Kubernetes (manifests en `infra/k8s/`)
2. HPA: 2–10 replicas según CPU (`infra/k8s/hpa.yaml`)
3. Base de datos externa (RDS / Hetzner Managed DB)
4. Redis en servicio separado
5. CDN (Cloudflare) frente a Vercel
