-- Ejecuta este script una sola vez en Supabase > SQL Editor.
create table if not exists public.agenda_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.agenda_data enable row level security;

-- Cada usuario solo puede leer, crear y modificar su propia fila.
drop policy if exists "Solo leer mis datos Agenda CNP" on public.agenda_data;
create policy "Solo leer mis datos Agenda CNP"
  on public.agenda_data for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Solo insertar mis datos Agenda CNP" on public.agenda_data;
create policy "Solo insertar mis datos Agenda CNP"
  on public.agenda_data for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "Solo actualizar mis datos Agenda CNP" on public.agenda_data;
create policy "Solo actualizar mis datos Agenda CNP"
  on public.agenda_data for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- No se habilita acceso anónimo ni se necesita una clave service_role en el frontend.
grant select, insert, update on public.agenda_data to authenticated;
revoke all on public.agenda_data from anon;
