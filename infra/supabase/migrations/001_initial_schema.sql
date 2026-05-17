-- ============================================================
-- GARENDIL — Esquema inicial Supabase
-- ============================================================

-- Extensión para UUIDs
create extension if not exists "uuid-ossp";

-- ============================================================
-- TABLA: profiles
-- Extiende auth.users de Supabase con datos adicionales
-- ============================================================
create table public.profiles (
  id          uuid references auth.users(id) on delete cascade primary key,
  email       text not null,
  created_at  timestamptz default now() not null,
  updated_at  timestamptz default now() not null,

  -- Fase 2: campos de perfil extendido
  display_name  text,
  avatar_url    text
);

alter table public.profiles enable row level security;

-- El usuario solo puede ver y editar su propio perfil
create policy "profiles: select own"
  on public.profiles for select
  using (auth.uid() = id);

create policy "profiles: update own"
  on public.profiles for update
  using (auth.uid() = id);

-- Trigger: crear profile automáticamente al registrarse
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ============================================================
-- TABLA: consultas
-- Registra cada búsqueda realizada por un usuario (Fase 1)
-- Sirve como rate limiting y auditoría de uso
-- ============================================================
create table public.consultas (
  id          uuid default uuid_generate_v4() primary key,
  user_id     uuid references public.profiles(id) on delete cascade not null,
  dni_buscado text not null,             -- DNI del funcionario consultado
  resultado   jsonb,                     -- snapshot del resultado (para auditoría)
  created_at  timestamptz default now() not null
);

alter table public.consultas enable row level security;

create policy "consultas: select own"
  on public.consultas for select
  using (auth.uid() = user_id);

create policy "consultas: insert own"
  on public.consultas for insert
  with check (auth.uid() = user_id);

-- Índices
create index consultas_user_id_idx on public.consultas(user_id);
create index consultas_dni_idx on public.consultas(dni_buscado);
create index consultas_created_at_idx on public.consultas(created_at desc);

-- ============================================================
-- TABLA: funcionarios_cache
-- Cache de perfiles de funcionarios calculados por el backend
-- Evita recalcular el score en cada consulta
-- ============================================================
create table public.funcionarios_cache (
  dni           text primary key,
  nombre        text not null,
  cargo_actual  text,
  institucion   text,
  score_ier     numeric(5, 2),           -- 0.00 a 100.00
  score_detalle jsonb,                   -- desglose por dimensión
  fuentes       jsonb,                   -- lista de fuentes usadas
  calculado_at  timestamptz default now() not null,
  actualizado_at timestamptz default now() not null
);

-- Solo el service role (backend) puede escribir en esta tabla
alter table public.funcionarios_cache enable row level security;

create policy "funcionarios_cache: select all"
  on public.funcionarios_cache for select
  to authenticated
  using (true);

-- ============================================================
-- Fase 2 (pendiente): tablas para guardados, comparativas, etc.
-- ============================================================
-- create table public.guardados ( ... );
-- create table public.comparativas ( ... );
