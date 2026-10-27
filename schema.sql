-- Starter schema. Run in Supabase SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'customer' check (role in ('customer','admin')),
  created_at timestamptz not null default now()
);
create table if not exists public.deposits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  method text not null check (method in ('bKash','Nagad')),
  amount numeric(12,2) not null check (amount >= 10),
  sender_number text not null,
  transaction_id text not null,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  created_at timestamptz not null default now(),
  unique(method, transaction_id)
);
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  game text not null check (game in ('Free Fire','PUBG Mobile')),
  package_name text not null,
  price numeric(12,2) not null check (price > 0),
  player_id text not null,
  status text not null default 'pending' check (status in ('pending','paid','processing','completed','rejected')),
  created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
alter table public.deposits enable row level security;
alter table public.orders enable row level security;

create policy "profile read own" on public.profiles for select to authenticated using (auth.uid() = id);
create policy "profile insert own customer" on public.profiles for insert to authenticated with check (auth.uid() = id and role = 'customer');
create policy "profile update own name only" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id and role = 'customer');
create policy "deposits read own" on public.deposits for select to authenticated using (auth.uid() = user_id);
create policy "deposit request own" on public.deposits for insert to authenticated with check (auth.uid() = user_id and status = 'pending');
create policy "orders read own" on public.orders for select to authenticated using (auth.uid() = user_id);
create policy "order request own" on public.orders for insert to authenticated with check (auth.uid() = user_id and status = 'pending');

-- Production note: admin approval, wallet ledger, balance changes and fulfillment must be
-- implemented in trusted server-side functions/Edge Functions with admin-role checks.
-- Do NOT create client policies that let users approve deposits or edit balances.
