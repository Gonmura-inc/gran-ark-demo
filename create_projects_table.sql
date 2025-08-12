-- GRANARK営業支援システム用 projectsテーブル作成SQL
-- Supabase SQL Editorで実行してください

-- 既存テーブルがある場合は削除（注意：データも削除されます）
-- DROP TABLE IF EXISTS projects;

-- projectsテーブルの作成
CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    project_name TEXT NOT NULL,
    assigned_email TEXT NOT NULL,
    support_email TEXT,
    status TEXT NOT NULL DEFAULT '商談中',
    sales_budget NUMERIC(12,0) NOT NULL DEFAULT 0,
    decided_amount NUMERIC(12,0) NOT NULL DEFAULT 0,
    brokerage_fee NUMERIC(12,0) NOT NULL DEFAULT 0,
    start_date DATE,
    contract_date DATE,
    payment_date DATE,
    progress SMALLINT NOT NULL DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
    partner_connection TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- インデックスの作成（検索性能向上）
CREATE INDEX idx_projects_assigned_email ON projects(assigned_email);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_start_date ON projects(start_date);

-- テーブルコメント
COMMENT ON TABLE projects IS 'GRANARK営業案件管理テーブル';
COMMENT ON COLUMN projects.id IS '案件ID（自動採番）';
COMMENT ON COLUMN projects.project_name IS '案件名（顧客名・物件名）';
COMMENT ON COLUMN projects.assigned_email IS '担当者メールアドレス';
COMMENT ON COLUMN projects.support_email IS 'サポート担当者メールアドレス';
COMMENT ON COLUMN projects.status IS '営業ステータス（商談中/見込み/成約/入金済/キャンセル）';
COMMENT ON COLUMN projects.sales_budget IS '営業予算額';
COMMENT ON COLUMN projects.decided_amount IS '決定額';
COMMENT ON COLUMN projects.brokerage_fee IS '仲介手数料';
COMMENT ON COLUMN projects.start_date IS '営業開始日';
COMMENT ON COLUMN projects.contract_date IS '成約日';
COMMENT ON COLUMN projects.payment_date IS '入金日';
COMMENT ON COLUMN projects.progress IS '進捗率（0-100%）';
COMMENT ON COLUMN projects.partner_connection IS '連携先情報（AD/制作等）';
COMMENT ON COLUMN projects.created_at IS 'レコード作成日時';