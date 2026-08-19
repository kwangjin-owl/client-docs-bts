drop table if exists applications;

create table applications (
  id bigint generated always as identity primary key,
  created_at timestamptz default now(),

  track text not null,
  agency text not null,
  cert_code text,
  cert_name text not null,

  name text not null,
  phone text not null,
  gender text,
  birth_date date,
  email text,

  exam_region text,
  exam_date date,
  exam_session text,

  fee_amount int,
  fee_discount_type text,
  fee_final int,
  payment_method text,
  status text default '접수완료',

  extra jsonb
);

alter table applications enable row level security;
create policy "anon insert" on applications for insert to anon with check (true);
create policy "anon read" on applications for select to anon using (true);
alter table applications add column usage_context text;