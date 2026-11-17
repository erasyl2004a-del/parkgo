-- ParkGo initial data model. Apply with Supabase CLI after creating a project.
create extension if not exists pgcrypto;
create table if not exists public.parking_operators (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid references auth.users(id) on delete set null,
 name text not null,
 phone text,
 created_at timestamptz not null default now()
);
create table if not exists public.parking_lots (
 id uuid primary key default gen_random_uuid(),
 operator_id uuid references public.parking_operators(id) on delete set null,
 name text not null,
 city text not null,
 district text,
 address text not null,
 latitude double precision not null,
 longitude double precision not null,
 hourly_price numeric(10,2) not null default 0 check(hourly_price >= 0),
 total_spaces integer not null default 0 check(total_spaces >= 0),
 available_spaces integer not null default 0 check(available_spaces >= 0 and available_spaces <= total_spaces),
 is_active boolean not null default false,
 created_at timestamptz not null default now()
);
create table if not exists public.parking_reservations (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 lot_id uuid not null references public.parking_lots(id),
 starts_at timestamptz not null,
 ends_at timestamptz not null,
 status text not null default 'pending' check(status in ('pending','confirmed','cancelled','completed')),
 created_at timestamptz not null default now(),
 check(ends_at > starts_at)
);
alter table public.parking_lots enable row level security;
alter table public.parking_operators enable row level security;
alter table public.parking_reservations enable row level security;
create policy "Active lots are publicly readable" on public.parking_lots for select using (is_active = true);
create policy "Operators read own profile" on public.parking_operators for select using (auth.uid() = owner_id);
create policy "Users read own reservations" on public.parking_reservations for select using (auth.uid() = user_id);
create policy "Users create own reservations" on public.parking_reservations for insert with check (auth.uid() = user_id);
