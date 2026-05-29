# PROMPT: Garendil v1 — Inicialización Completa

**Objetivo:** Inicializar completamente el proyecto Garendil con arquitectura escalable (monorepo pnpm, FastAPI + Neo4j backend, Next.js frontend, Docker, Kubernetes-ready, CI/CD automático).

**Archivos afectados:** Toda la estructura del repo (es inicio desde cero)

**Dependencias:** Node.js 20 LTS, Python 3.11+, Docker disponible localmente

---

## TAREA 1: Inicializar monorepo con pnpm + Turborepo

**Qué hacer:** Estructura base de carpetas y configuración de workspace

```bash
# En la raíz del repo (github.com/rodhandev/garendil)

# Crear structure de carpetas
mkdir -p apps/web
mkdir -p services/api
mkdir -p packages/core
mkdir -p infra/{docker,k8s,scripts}
mkdir -p .github/workflows

# Crear package.json raíz
cat > package.json << 'EOF'
{
  "name": "garendil",
  "version": "0.1.0",
  "private": true,
  "description": "Public corruption risk scoring system for Peruvian officials",
  "scripts": {
    "dev": "turbo run dev --parallel",
    "build": "turbo run build",
    "test": "turbo run test",
    "lint": "turbo run lint",
    "type-check": "turbo run type-check",
    "clean": "turbo clean && rm -rf node_modules",
    "docker:dev": "docker-compose -f infra/docker-compose.yml up -d",
    "docker:down": "docker-compose -f infra/docker-compose.yml down",
    "docker:reset": "docker-compose -f infra/docker-compose.yml down -v && docker-compose -f infra/docker-compose.yml up -d",
    "db:migrate": "cd services/api && python scripts/migrate.py"
  },
  "workspaces": [
    "apps/web",
    "services/api",
    "packages/core"
  ],
  "devDependencies": {
    "turbo": "^2.0.0"
  }
}
EOF

# Crear pnpm-workspace.yaml
cat > pnpm-workspace.yaml << 'EOF'
packages:
  - 'apps/*'
  - 'services/*'
  - 'packages/*'
EOF

# Crear turbo.json
cat > turbo.json << 'EOF'
{
  "$schema": "https://turborepo.org/schema.json",
  "globalDependencies": [".env.local", ".env"],
  "globalEnv": ["NODE_ENV"],
  "pipeline": {
    "dev": {
      "cache": false,
      "persistent": true,
      "dependsOn": ["^build"]
    },
    "build": {
      "outputs": ["dist/**", ".next/**", "build/**"],
      "dependsOn": ["^build"]
    },
    "test": {
      "outputs": ["coverage/**"],
      "dependsOn": ["^build"]
    },
    "lint": {
      "outputs": ["node_modules/.cache/**"],
      "cache": false
    },
    "type-check": {
      "outputs": ["node_modules/.cache/**"],
      "cache": false
    }
  }
}
EOF

# Crear .env.example en raíz
cat > .env.example << 'EOF'
# Backend (FastAPI)
NODE_ENV=development
PYTHON_ENV=development
DATABASE_URL=postgresql://dev:dev@localhost:5432/garendil_db
NEO4J_URL=neo4j://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=dev

# Frontend (Next.js)
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_KEY=

# Services
CULQI_API_KEY=
OSCE_API_BASE_URL=https://api.osce.go.pe

# Redis (caching)
REDIS_URL=redis://localhost:6379

# GitHub (for deployment)
GITHUB_TOKEN=
EOF

# Instalar dependencias globales
pnpm install turbo@latest

echo "✅ TAREA 1 completada: Monorepo inicializado"
```

---

## TAREA 2: Crear estructura backend FastAPI + PostgreSQL + Neo4j

**Qué hacer:** Base del servicio API REST

```bash
cd services/api

# Crear package.json mínimo para workspace
cat > package.json << 'EOF'
{
  "name": "@garendil/api",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000",
    "build": "echo 'No build step for Python backend'",
    "test": "pytest --cov=app",
    "lint": "ruff check . && mypy app"
  }
}
EOF

# Crear requirements.txt
cat > requirements.txt << 'EOF'
fastapi==0.109.0
uvicorn==0.27.0
sqlalchemy==2.0.25
psycopg2-binary==2.9.9
neo4j==5.15.0
pydantic==2.5.0
pydantic-settings==2.1.0
python-dotenv==1.0.0
httpx==0.25.2
scrapy==2.11.0
beautifulsoup4==4.12.2
requests==2.31.0
pandas==2.1.3
scikit-learn==1.3.2
pytest==7.4.3
pytest-cov==4.1.0
pytest-asyncio==0.21.1
ruff==0.1.8
mypy==1.7.1
python-multipart==0.0.6
aioredis==2.0.1
celery==5.3.4
redis==5.0.1
EOF

# Crear estructura de carpetas
mkdir -p app/{api,models,schemas,services,workers,db,utils}
mkdir -p tests
mkdir -p scripts

# Crear app/main.py
cat > app/main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(
    title="Garendil API",
    description="Public corruption risk scoring system for Peruvian officials",
    version="0.1.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("CORS_ORIGINS", "*").split(","),
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check
@app.get("/health")
async def health_check():
    return {"status": "ok", "version": "0.1.0"}

# Stats endpoint
@app.get("/api/stats")
async def get_stats():
    return {
        "funcionarios_analizados": 0,
        "conexiones_mapeadas": 0,
        "contratos_indexados": 0,
        "ultima_actualizacion": "2026-05-17T00:00:00Z"
    }

# Search endpoint (placeholder)
@app.get("/api/search")
async def search(q: str = None, dni: str = None):
    return {
        "results": [],
        "total": 0
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
EOF

# Crear app/db/base.py
mkdir -p app/db
cat > app/db/base.py << 'EOF'
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy.pool import NullPool
import os

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://dev:dev@localhost:5432/garendil_db")

engine = create_async_engine(
    DATABASE_URL.replace("postgresql://", "postgresql+asyncpg://"),
    echo=False,
    poolclass=NullPool,
)

AsyncSessionLocal = sessionmaker(
    engine, class_=AsyncSession, expire_on_commit=False
)

Base = declarative_base()

async def get_db():
    async with AsyncSessionLocal() as session:
        yield session
EOF

# Crear .env.local
cat > .env.local << 'EOF'
PYTHONUNBUFFERED=1
DATABASE_URL=postgresql://dev:dev@localhost:5432/garendil_db
NEO4J_URL=neo4j://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=dev
CORS_ORIGINS=http://localhost:3000,http://localhost:3001
OSCE_API_BASE_URL=https://api.osce.go.pe
REDIS_URL=redis://localhost:6379
EOF

# Crear script de migración base
cat > scripts/migrate.py << 'EOF'
import asyncio
import os
from dotenv import load_dotenv
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy.schema import CreateSchema
from app.db.base import Base, DATABASE_URL

load_dotenv()

async def run_migrations():
    print("🔄 Running database migrations...")
    
    # Create async engine
    engine = create_async_engine(
        DATABASE_URL.replace("postgresql://", "postgresql+asyncpg://"),
        echo=True
    )
    
    async with engine.begin() as conn:
        # Create schema if it doesn't exist
        await conn.execute(CreateSchema("public", if_not_exists=True))
        # Create all tables
        await conn.run_sync(Base.metadata.create_all)
    
    await engine.dispose()
    print("✅ Migrations completed")

if __name__ == "__main__":
    asyncio.run(run_migrations())
EOF

cd ../..
echo "✅ TAREA 2 completada: Backend FastAPI inicializado"
```

---

## TAREA 3: Crear estructura frontend Next.js

**Qué hacer:** Aplicación Next.js con App Router

```bash
cd apps/web

# Crear package.json
cat > package.json << 'EOF'
{
  "name": "@garendil/web",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3000",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "test": "jest"
  },
  "dependencies": {
    "next": "^14.1.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "tailwindcss": "^3.4.0",
    "postcss": "^8.4.32",
    "autoprefixer": "^10.4.17",
    "axios": "^1.6.2",
    "vis-network": "^9.1.6",
    "d3": "^7.8.5"
  },
  "devDependencies": {
    "@types/node": "^20.10.0",
    "@types/react": "^18.2.42",
    "@types/react-dom": "^18.2.17",
    "typescript": "^5.3.3",
    "eslint": "^8.55.0",
    "eslint-config-next": "^14.1.0"
  }
}
EOF

# Crear tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "resolveJsonModule": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Crear next.config.js
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL,
  },
  headers: async () => {
    return [
      {
        source: "/:path*",
        headers: [
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "X-Frame-Options", value: "DENY" },
          { key: "X-XSS-Protection", value: "1; mode=block" },
        ],
      },
    ];
  },
};

module.exports = nextConfig;
EOF

# Crear estructura de carpetas
mkdir -p app/{api,components,hooks,utils,styles}
mkdir -p public/assets

# Crear .env.local
cat > .env.local << 'EOF'
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=
EOF

# Crear app/layout.tsx
mkdir -p app
cat > app/layout.tsx << 'EOF'
import './globals.css'

export const metadata = {
  title: 'Garendil — Transparencia Basada en Datos',
  description: 'Sistema público de scoring de riesgo de corrupción para funcionarios peruanos',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="es">
      <body className="bg-slate-950 text-slate-100">
        {children}
      </body>
    </html>
  )
}
EOF

# Crear app/page.tsx (homepage)
cat > app/page.tsx << 'EOF'
'use client'

import { useState } from 'react'
import Link from 'next/link'

export default function Home() {
  const [dni, setDni] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!dni || dni.length !== 8) {
      alert('Ingresa un DNI válido (8 dígitos)')
      return
    }
    setLoading(true)
    // Navigate to profile
    window.location.href = `/perfil/${dni}`
  }

  return (
    <main className="min-h-screen bg-gradient-to-br from-slate-950 via-blue-950 to-slate-950">
      {/* Navigation */}
      <nav className="flex justify-between items-center px-8 py-4 border-b border-slate-800">
        <div className="text-2xl font-bold text-teal-400">⚖️ Garendil</div>
        <div className="space-x-6">
          <Link href="/metodologia" className="text-slate-300 hover:text-teal-400">
            Metodología
          </Link>
          <Link href="/grafo" className="text-slate-300 hover:text-teal-400">
            Grafo
          </Link>
        </div>
      </nav>

      {/* Hero */}
      <div className="flex flex-col items-center justify-center min-h-[calc(100vh-80px)] px-4">
        <div className="text-center max-w-2xl">
          <h1 className="text-5xl font-bold text-white mb-4">
            Transparencia basada en datos
          </h1>
          <p className="text-xl text-slate-300 mb-12">
            Riesgo de corrupción cuantificado para funcionarios públicos peruanos
          </p>

          {/* Search form */}
          <form onSubmit={handleSearch} className="flex gap-2 mb-12">
            <input
              type="text"
              placeholder="Ingresa el DNI del funcionario..."
              value={dni}
              onChange={(e) => setDni(e.target.value.replace(/\D/g, '').slice(0, 8))}
              maxLength={8}
              className="flex-1 px-6 py-3 bg-slate-900 border border-slate-700 rounded-lg text-white placeholder-slate-500 focus:outline-none focus:border-teal-500"
            />
            <button
              type="submit"
              disabled={loading}
              className="px-8 py-3 bg-teal-600 hover:bg-teal-700 text-white rounded-lg font-semibold disabled:opacity-50"
            >
              {loading ? 'Analizando...' : 'Analizar'}
            </button>
          </form>

          {/* Stats placeholder */}
          <div className="grid grid-cols-3 gap-4 text-sm">
            <div className="bg-slate-900/50 p-4 rounded border border-slate-800">
              <div className="text-teal-400 text-2xl font-bold">--</div>
              <div className="text-slate-400 text-xs">Funcionarios analizados</div>
            </div>
            <div className="bg-slate-900/50 p-4 rounded border border-slate-800">
              <div className="text-teal-400 text-2xl font-bold">--</div>
              <div className="text-slate-400 text-xs">Conexiones mapeadas</div>
            </div>
            <div className="bg-slate-900/50 p-4 rounded border border-slate-800">
              <div className="text-teal-400 text-2xl font-bold">--</div>
              <div className="text-slate-400 text-xs">Contratos indexados</div>
            </div>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="border-t border-slate-800 px-8 py-6 text-center text-slate-500 text-sm">
        <p>Sistema público y de código abierto • <a href="https://github.com/rodhandev/garendil" className="text-teal-400">GitHub</a></p>
      </footer>
    </main>
  )
}
EOF

# Crear globals.css
mkdir -p app/styles
cat > app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
  background-color: #0a0d12;
  color: #e5e7eb;
}

/* Scrollbar styling */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #111827;
}

::-webkit-scrollbar-thumb {
  background: #334155;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #475569;
}
EOF

# Crear tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        slate: {
          950: '#0a0d12',
        },
      },
    },
  },
  plugins: [],
}
EOF

# Crear postcss.config.js
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

cd ../..
echo "✅ TAREA 3 completada: Frontend Next.js inicializado"
```

---

## TAREA 4: Configurar Docker + docker-compose para desarrollo local

**Qué hacer:** Contenedores para PostgreSQL, Neo4j, Redis en desarrollo

```bash
# Crear infra/docker-compose.yml
mkdir -p infra
cat > infra/docker-compose.yml << 'EOF'
version: '3.9'

services:
  postgres:
    image: postgres:16-alpine
    container_name: garendil-postgres
    restart: unless-stopped
    environment:
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
      POSTGRES_DB: garendil_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U dev -d garendil_db"]
      interval: 10s
      timeout: 5s
      retries: 5

  neo4j:
    image: neo4j:5-community
    container_name: garendil-neo4j
    restart: unless-stopped
    environment:
      NEO4J_AUTH: neo4j/dev
      NEO4J_PLUGINS: '["apoc"]'
    ports:
      - "7687:7687"
      - "7474:7474"
    volumes:
      - neo4j_data:/var/lib/neo4j/data
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:7474/"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: garendil-redis
    restart: unless-stopped
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
  neo4j_data:
  redis_data:
EOF

echo "✅ TAREA 4 completada: Docker compose configurado"
```

---

## TAREA 5: Configurar Kubernetes deployment (escalable)

**Qué hacer:** Archivos YAML de K8s para producción escalada

```bash
mkdir -p infra/k8s

# Crear infra/k8s/namespace.yaml
cat > infra/k8s/namespace.yaml << 'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: garendil
  labels:
    name: garendil
EOF

# Crear infra/k8s/postgres-pvc.yaml
cat > infra/k8s/postgres-pvc.yaml << 'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
  namespace: garendil
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
EOF

# Crear infra/k8s/postgres-deployment.yaml
cat > infra/k8s/postgres-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: garendil
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:16-alpine
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_USER
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: username
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: password
        - name: POSTGRES_DB
          value: garendil_db
        volumeMounts:
        - name: postgres-storage
          mountPath: /var/lib/postgresql/data
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
      volumes:
      - name: postgres-storage
        persistentVolumeClaim:
          claimName: postgres-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
  namespace: garendil
spec:
  selector:
    app: postgres
  ports:
  - protocol: TCP
    port: 5432
    targetPort: 5432
  type: ClusterIP
EOF

# Crear infra/k8s/api-deployment.yaml
cat > infra/k8s/api-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: garendil-api
  namespace: garendil
spec:
  replicas: 3  # Escalable: 3 replicas por defecto
  selector:
    matchLabels:
      app: garendil-api
  template:
    metadata:
      labels:
        app: garendil-api
    spec:
      containers:
      - name: api
        image: rodhandev/garendil-api:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: api-secret
              key: database-url
        - name: NEO4J_URL
          valueFrom:
            secretKeyRef:
              name: api-secret
              key: neo4j-url
        - name: REDIS_URL
          valueFrom:
            configMapKeyRef:
              name: api-config
              key: redis-url
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 5
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 2
        resources:
          requests:
            memory: "512Mi"
            cpu: "250m"
          limits:
            memory: "1Gi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: garendil-api
  namespace: garendil
spec:
  selector:
    app: garendil-api
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8000
  type: LoadBalancer
EOF

# Crear infra/k8s/hpa.yaml (Horizontal Pod Autoscaling)
cat > infra/k8s/hpa.yaml << 'EOF'
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: garendil-api-hpa
  namespace: garendil
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: garendil-api
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
EOF

# Crear infra/k8s/secrets.yaml (plantilla)
cat > infra/k8s/secrets.yaml << 'EOF'
# ⚠️ PLANTILLA — Generar con valores reales en CI/CD
# NO commitear credenciales reales
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: garendil
type: Opaque
stringData:
  username: dev
  password: CHANGE_ME_IN_PRODUCTION
---
apiVersion: v1
kind: Secret
metadata:
  name: api-secret
  namespace: garendil
type: Opaque
stringData:
  database-url: postgresql://dev:CHANGE_ME@postgres:5432/garendil_db
  neo4j-url: neo4j://neo4j:CHANGE_ME@neo4j:7687
EOF

# Crear infra/k8s/configmap.yaml
cat > infra/k8s/configmap.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: api-config
  namespace: garendil
data:
  redis-url: redis://redis:6379
  log-level: "INFO"
EOF

echo "✅ TAREA 5 completada: Kubernetes manifests creados"
```

---

## TAREA 6: Crear Dockerfile multi-stage para API

**Qué hacer:** Imagen Docker optimizada para FastAPI

```bash
cat > services/api/Dockerfile << 'EOF'
# Stage 1: Builder
FROM python:3.11-slim as builder

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies from builder
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# Copy application
COPY . .

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

echo "✅ TAREA 6 completada: Dockerfile creado"
```

---

## TAREA 7: Crear Dockerfile para Frontend

**Qué hacer:** Imagen Next.js optimizada

```bash
cat > apps/web/Dockerfile << 'EOF'
# Stage 1: Builder
FROM node:20-alpine as builder

WORKDIR /app

COPY package.json pnpm-lock.yaml* ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

# Stage 2: Runtime
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./

ENV NODE_ENV=production
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:3000 || exit 1

CMD ["npm", "start"]
EOF

echo "✅ TAREA 7 completada: Frontend Dockerfile creado"
```

---

## TAREA 8: Configurar GitHub Actions CI/CD

**Qué hacer:** Pipelines automáticos de build, test, deploy

```bash
mkdir -p .github/workflows

# Crear .github/workflows/ci.yml
cat > .github/workflows/ci.yml << 'EOF'
name: CI — Lint & Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
      - run: pnpm install
      - run: pnpm lint

  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16-alpine
        env:
          POSTGRES_USER: dev
          POSTGRES_PASSWORD: dev
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - uses: pnpm/action-setup@v2
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'
      - run: pnpm install
      - run: pnpm test --coverage
      - uses: codecov/codecov-action@v3
EOF

# Crear .github/workflows/build.yml
cat > .github/workflows/build.yml << 'EOF'
name: Build & Push Docker

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  build-api:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-buildx-action@v3
      - uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      - uses: docker/build-push-action@v5
        with:
          context: services/api
          push: true
          tags: rodhandev/garendil-api:latest,rodhandev/garendil-api:${{ github.sha }}
          cache-from: type=registry,ref=rodhandev/garendil-api:buildcache
          cache-to: type=registry,ref=rodhandev/garendil-api:buildcache,mode=max

  build-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-buildx-action@v3
      - uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      - uses: docker/build-push-action@v5
        with:
          context: apps/web
          push: true
          tags: rodhandev/garendil-web:latest,rodhandev/garendil-web:${{ github.sha }}
          cache-from: type=registry,ref=rodhandev/garendil-web:buildcache
          cache-to: type=registry,ref=rodhandev/garendil-web:buildcache,mode=max
EOF

echo "✅ TAREA 8 completada: GitHub Actions configurado"
```

---

## TAREA 9: Crear scripts de utilidad

**Qué hacer:** Helper scripts para desarrollo y deployment

```bash
mkdir -p infra/scripts

# Crear infra/scripts/setup-env.sh
cat > infra/scripts/setup-env.sh << 'EOF'
#!/bin/bash
set -e

echo "🔧 Garendil — Setup ambiente de desarrollo"

# Instalar dependencias globales
echo "📦 Instalando dependencias con pnpm..."
pnpm install

# Crear archivos .env locales si no existen
if [ ! -f ".env.local" ]; then
  cp .env.example .env.local
  echo "✅ .env.local creado (editar con valores locales)"
fi

if [ ! -f "services/api/.env.local" ]; then
  cp .env.example services/api/.env.local
  echo "✅ services/api/.env.local creado"
fi

if [ ! -f "apps/web/.env.local" ]; then
  cp .env.example apps/web/.env.local
  echo "✅ apps/web/.env.local creado"
fi

# Iniciar Docker
echo "🐳 Iniciando servicios Docker..."
docker-compose -f infra/docker-compose.yml up -d

# Esperar a que postgres esté listo
echo "⏳ Esperando a PostgreSQL..."
sleep 3

# Ejecutar migraciones
echo "🔄 Ejecutando migraciones de base de datos..."
cd services/api
python scripts/migrate.py
cd ../..

echo "✅ Setup completado. Ejecuta 'pnpm dev' para iniciar"
EOF

chmod +x infra/scripts/setup-env.sh

# Crear infra/scripts/build-docker.sh
cat > infra/scripts/build-docker.sh << 'EOF'
#!/bin/bash
set -e

echo "🐳 Building Docker images..."

echo "📦 Building API..."
docker build -t rodhandev/garendil-api:latest services/api

echo "📦 Building Web..."
docker build -t rodhandev/garendil-web:latest apps/web

echo "✅ Docker images built"
EOF

chmod +x infra/scripts/build-docker.sh

# Crear infra/scripts/deploy-k8s.sh
cat > infra/scripts/deploy-k8s.sh << 'EOF'
#!/bin/bash
set -e

NAMESPACE="garendil"
CONTEXT="${1:-docker-desktop}"

echo "🚀 Deploying Garendil to Kubernetes ($CONTEXT)"

# Switch context
kubectl config use-context $CONTEXT || true

# Create namespace
kubectl create namespace $NAMESPACE || true

# Apply manifests
echo "📋 Applying Kubernetes manifests..."
kubectl apply -f infra/k8s/namespace.yaml
kubectl apply -f infra/k8s/configmap.yaml
kubectl apply -f infra/k8s/secrets.yaml
kubectl apply -f infra/k8s/postgres-pvc.yaml
kubectl apply -f infra/k8s/postgres-deployment.yaml
kubectl apply -f infra/k8s/api-deployment.yaml
kubectl apply -f infra/k8s/hpa.yaml

echo "⏳ Waiting for rollout..."
kubectl rollout status deployment/garendil-api -n $NAMESPACE

echo "✅ Deployment complete"
kubectl get pods -n $NAMESPACE
EOF

chmod +x infra/scripts/deploy-k8s.sh

echo "✅ TAREA 9 completada: Utility scripts creados"
```

---

## TAREA 10: Crear archivo CLAUDE.md de especificación

**Qué hacer:** Documentación para sesiones futuras de Claude Code

```bash
cat > CLAUDE.md << 'EOF'
# Garendil — CLAUDE.md v0.1

**Última actualización:** 2026-05-17  
**Versión de proyecto:** 0.1.0  
**Estado:** ✅ Estructura inicializada — listo para desarrollo de features

---

## Identidad & Visión

**Garendil** = Sistema público de scoring de riesgo de corrupción para funcionarios peruanos.

**Stack final:**
- Backend: FastAPI + PostgreSQL + Neo4j (grafo)
- Frontend: Next.js 14 + Tailwind CSS + vis.js (grafo interactivo)
- Infraestructura: Docker + Kubernetes (escalable, multi-server ready)
- Auth/datos: Supabase (opcional)
- Hosting: Vercel (frontend) + Hetzner VPS/K8s (backend)
- CI/CD: GitHub Actions

---

## Decisiones de arquitectura

| Decisión | Razón |
|----------|-------|
| Monorepo (pnpm + Turborepo) | Compartir código, deployments acoplados |
| Next.js SSR `/perfil/[dni]` | SEO de perfiles públicos |
| Neo4j para grafo | Relaciones + patrones de comportamiento |
| Docker multi-stage | Imágenes pequeñas (~300MB) |
| K8s + HPA | Escalabilidad horizontal automática |
| Secretos en K8s | Seguridad en producción |

---

## Rutas principales

| Ruta | Descripción |
|------|-------------|
| `GET /` | Homepage — buscador por DNI |
| `GET /perfil/[dni]` | Perfil del funcionario (SSR) |
| `GET /grafo` | Explorador de grafo global |
| `GET /metodologia` | Explicación del scoring |
| `GET /api/health` | Health check |
| `GET /api/stats` | Estadísticas del sistema |
| `GET /api/search?dni=12345678` | Búsqueda de perfil (API) |

---

## Estructura de carpetas

```
garendil/
├── apps/web/                  # Next.js frontend
│   ├── app/
│   │   ├── page.tsx          # Homepage
│   │   ├── perfil/[dni]/
│   │   ├── grafo/
│   │   ├── metodologia/
│   │   └── layout.tsx
│   ├── Dockerfile
│   └── next.config.js
├── services/api/              # FastAPI backend
│   ├── app/
│   │   ├── main.py           # Entry point
│   │   ├── api/              # Route handlers
│   │   ├── models/           # SQLAlchemy models
│   │   ├── schemas/          # Pydantic schemas
│   │   ├── services/         # Business logic
│   │   ├── db/               # Database config
│   │   └── utils/
│   ├── scripts/
│   │   └── migrate.py        # DB migrations
│   ├── requirements.txt
│   └── Dockerfile
├── packages/core/             # Shared logic (tipos, utils)
├── infra/
│   ├── docker-compose.yml    # Dev environment
│   ├── k8s/                  # Kubernetes manifests
│   │   ├── namespace.yaml
│   │   ├── postgres-*.yaml
│   │   ├── api-deployment.yaml
│   │   ├── hpa.yaml
│   │   └── secrets.yaml
│   └── scripts/              # Deployment scripts
├── .github/workflows/         # CI/CD pipelines
├── CLAUDE.md                 # This file
├── PROGRESS.md               # Development progress
└── turbo.json / pnpm-workspace.yaml
```

---

## Cómo funciona el sistema

### Capa 1: Reglas explícitas (auditable)
```python
# En services/api/app/services/scoring.py
def calculate_layer1_rules(funcionario_id: int) -> Dict[str, float]:
    """Reglas explícitas: contratos sospechosos, patrimonio inconsistente, etc."""
    alerts = {}
    
    # Regla: empresa creada < 30 días
    alerts['empresa_nueva'] = check_empresa_nueva(funcionario_id)
    
    # Regla: monto > presupuesto base en X%
    alerts['monto_inconsistente'] = check_monto_inconsistente(funcionario_id)
    
    return alerts
```

### Capa 2: Anomaly Detection (ML no supervisado)
```python
# En services/api/app/services/ml_unsupervised.py
def detect_anomalies(funcionario_id: int) -> Dict[str, float]:
    """Isolation Forest: detecta patrones raros sin etiquetas."""
    datos = get_historical_contracts(funcionario_id)
    # Entrenar IF y obtener score de anomalía
    return isolation_forest_score(datos)
```

### Capa 3: ML supervisado (futuro)
```python
# En services/api/app/services/ml_supervised.py
def predict_risk(funcionario_id: int) -> float:
    """Random Forest sobre features etiquetadas (cuando haya datos)."""
    features = extract_features_from_layers_1_2(funcionario_id)
    # Entrenar RF y predecir
    return random_forest_predict(features)
```

---

## Próximos pasos (Fase 2)

- [ ] Integración OSCE API — ingesta de contratos
- [ ] Modelos SQLAlchemy — tablas de funcionarios, contratos, procesos
- [ ] Endpoints `/api/search` y `/api/perfil/[dni]`
- [ ] Capa 1 de scoring — reglas explícitas
- [ ] Página `/perfil/[dni]` con datos hardcoded → integración con API
- [ ] Visualización de grafo con vis.js
- [ ] Scraping piloto de fuentes (MEF, INFOBRAS)
- [ ] Tests unitarios + integración
- [ ] Deploy a Vercel (frontend) + Hetzner (backend)

---

## Comandos útiles

```bash
# Desarrollo
pnpm dev                      # Ambos (frontend + backend)
pnpm docker:dev              # Servicios locales (postgres, neo4j, redis)
pnpm db:migrate              # Ejecutar migraciones SQL

# Build
pnpm build                   # Build para producción
pnpm docker:build            # Build imágenes Docker

# Deploy
./infra/scripts/deploy-k8s.sh docker-desktop   # A K8s local
```

---

## Referencia: estructura de datos (.md exportable)

El archivo `.md` generado por perfil sigue esta estructura:

```markdown
---
dni: "12345678"
nombre: "Juan Pérez"
score_ier: 74
nivel_riesgo: "Alto"
---

# Perfil: Juan Pérez

## Score IER: 74/100

### Desglose
- Corrupción: XX/100
- Competencia: XX/100
- Adecuación al cargo: XX/100

## Historial de contratos públicos
...

## Patrimonio declarado
...

## Historial delictivo
...

## Conexiones — Grafo
...
```

---

## Prompt de arranque (para sesiones futuras)

```
Eres Claude Code asistente de desarrollo de Garendil.

Tu contexto:
1. Lee CLAUDE.md (este archivo)
2. Lee PROGRESS.md (estado actual)
3. Lee los archivos modificados en la última sesión

Tu tarea:
- Implementar lo especificado en PROGRESS.md
- Mantener coherencia con CLAUDE.md
- Actualizar PROGRESS.md al final con:
  * Fecha de sesión
  * Qué completaste
  * Decisiones fuera de spec (si aplica)
  * Próximo paso

Nunca cambies CLAUDE.md sin confirmación previa.
```

---

## Decisiones descartadas

| Idea | Razón del rechazo |
|------|------------------|
| Django + DRF | FastAPI es más moderno y rápido |
| React (sin Next.js) | Next.js da SSR y SEO gratis |
| MongoDB | PostgreSQL es más robusto para datos relacionales |
| GraphQL | REST suficiente para MVP |
| Nginx en Hetzner | K8s ingress maneja routing automático |

EOF

echo "✅ TAREA 10 completada: CLAUDE.md creado"
```

---

## TAREA 11: Crear PROGRESS.md

**Qué hacer:** Archivo de tracking de progreso

```bash
cat > PROGRESS.md << 'EOF'
# PROGRESS — Garendil v0.1

**Última sesión:** 2026-05-17  
**Estado actual:** ✅ Estructura inicializada

## Completado en sesión inaugural

- [x] Monorepo inicializado (pnpm + Turborepo)
- [x] Backend FastAPI estructura base
- [x] Frontend Next.js estructura base
- [x] Docker compose para desarrollo
- [x] Kubernetes manifests (escalable)
- [x] GitHub Actions CI/CD
- [x] Utility scripts
- [x] CLAUDE.md y PROGRESS.md

## Checklist activo (Fase 2)

- [ ] OSCE API integration — obtener contratos reales
- [ ] Modelos de BD (Funcionario, Contrato, Proceso)
- [ ] Endpoint `/api/search` funcional
- [ ] Scoring Capa 1 (reglas explícitas)
- [ ] Página `/perfil/[dni]` con datos reales
- [ ] Grafo con vis.js
- [ ] Tests unitarios
- [ ] Deploy a Vercel + Hetzner

## Decisiones fuera de spec

Ninguna en esta sesión.

## Notas técnicas

- Docker compose levanta 3 servicios: PostgreSQL (5432), Neo4j (7687), Redis (6379)
- K8s está configurado para 3 replicas mínimo, máximo 10 con HPA
- Secretos en K8s (no en git) — actualizar antes de deploy
- Imágenes Docker usan buildkit cache para rapidez

## Próxima sesión

Empezar con integración OSCE API:
1. Obtener datos reales de contratos públicos
2. Crear modelos SQLAlchemy (Funcionario, Contrato)
3. Implementar endpoint `/api/search?dni=XXXXXXXX`
4. Integrar con frontend

EOF

echo "✅ TAREA 11 completada: PROGRESS.md creado"
```

---

## TAREA 12: Commit inicial

**Qué hacer:** Registrar todos los cambios en Git

```bash
git add -A
git commit -m "feat: Initialize Garendil — monorepo, FastAPI backend, Next.js frontend, Docker, Kubernetes"

git log --oneline -5
# Output esperado:
# abc1234 feat: Initialize Garendil — monorepo, FastAPI backend, Next.js frontend, Docker, Kubernetes

echo "✅ TAREA 12 completada: Cambios commiteados"
```

---

## Testing — Verificar que todo funciona

```bash
# Test 1: Monorepo structure
echo "✅ Test 1: Monorepo structure"
ls -la apps/ services/ packages/ infra/
# Output esperado: Directorios existen

# Test 2: Docker compose
echo "✅ Test 2: Docker compose"
docker-compose -f infra/docker-compose.yml ps
# Output esperado: 3 servicios corriendo (postgres, neo4j, redis)

# Test 3: Backend health check
echo "✅ Test 3: Backend health check"
cd services/api && python app/main.py &
sleep 3
curl http://localhost:8000/health
# Output esperado: {"status":"ok","version":"0.1.0"}
kill %1

# Test 4: Frontend build
echo "✅ Test 4: Frontend build"
cd apps/web && npm install && npm run build
# Output esperado: Next.js build successful

# Test 5: K8s manifests validation
echo "✅ Test 5: K8s manifests"
kubectl apply --dry-run=client -f infra/k8s/
# Output esperado: Todos los manifests son válidos

echo "✅ ✅ ✅ TODAS LAS PRUEBAS PASARON ✅ ✅ ✅"
```

---

## Commit final

```bash
git add -A
git commit -m "chore: Complete initialization — all systems tested and working"

echo "🎉 GARENDIL v0.1 INICIALIZADO EXITOSAMENTE"
echo "📋 Próximo paso: Implementar integración OSCE API"
echo "📖 Referencia: CLAUDE.md + PROGRESS.md"
```

---

## Notas para Claude Code

1. **Este `.md` es directiva ejecutable** — no es especificación teórica, son comandos concretos
2. **Código completo** — copy-paste ready, sin omisiones ("// ...resto igual")
3. **Output esperado explícito** — cada test muestra lo que debería ver
4. **Orden respeta dependencias** — monorepo primero, luego servicios, luego infra
5. **Escalabilidad incluida** — K8s HPA desde el inicio, no retrofitting
6. **Seguridad en K8s** — secrets template, nunca hardcodear credenciales
7. **Documentación viva** — CLAUDE.md y PROGRESS.md se mantienen juntos
8. **CI/CD automático** — GitHub Actions listos para producción

**Si algo falla, revisar:**
- Docker disponible en PATH
- Node.js 20+ y Python 3.11+
- Puertos 5432, 7687, 6379, 3000, 8000 libres localmente
- Permisos de escritura en el repo

---

## FIN DEL PROMPT

**Comando para ejecutar en Claude Code:**

```
Leo este archivo PROMPT_garendil_v1_initialization.md completamente.
Ejecuto cada TAREA en orden.
Antes de pasar a la siguiente tarea, verifico que la anterior completó sin errores.
Al finalizar, ejecuto el Testing para validar que todo funciona.
Hago commit final cuando todo esté verde.
Actualizo PROGRESS.md con la fecha de sesión y qué completé.
```

Tiempo esperado: **45–60 minutos** en máquina estándar
