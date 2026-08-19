-- ============================================================
-- 접수 테이블 (applications)
--
-- ★ 주의 ★
-- 아래 drop 문은 "처음 만들 때만" 씁니다.
-- 이미 접수 데이터가 들어 있는 상태에서 이 파일을 다시 실행하면
-- 표가 통째로 지워집니다.
-- 다시 실행할 일이 생기면 drop 줄을 지우고 필요한 부분만 돌리세요.
-- ============================================================

drop table if exists applications;

create table applications (
  id bigint generated always as identity primary key,
  created_at timestamptz default now(),

  track text not null,              -- 국가기술 / 전문 / 보건
  agency text not null,             -- 두두넷 / 두두보건
  cert_code text,                   -- 7910, P002, H001 ...
  cert_name text not null,

  name text not null,
  phone text not null,              -- 010-0000-0000 으로 통일
  gender text,                      -- M / F 로 통일
  birth_date date,                  -- YYYY-MM-DD 로 통일
  email text,

  exam_region text,
  exam_date date,
  exam_session text,

  fee_amount int,
  fee_discount_type text,
  fee_final int,
  payment_method text,              -- 신용카드 / 계좌이체 / 가상계좌 로 통일
  status text default '접수완료',    -- 접수완료 / 결제대기 / 취소 로 통일
  usage_context text,               -- 본인단독 / 가족보조 / 복지관 / 대리접수

  extra jsonb                       -- 트랙별로만 있는 칸
);

alter table applications enable row level security;

create policy "anon insert" on applications for insert to anon with check (true);
create policy "anon read"   on applications for select to anon using (true);