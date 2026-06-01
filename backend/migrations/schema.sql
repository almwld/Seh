-- ============================================
--   SEHATAK MEDICAL PLATFORM - Database Schema
-- ============================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========== USERS ==========
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_type VARCHAR(20) CHECK (user_type IN ('patient','doctor','pharmacy','admin')),
    avatar TEXT,
    is_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== DOCTORS ==========
CREATE TABLE IF NOT EXISTS doctors (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    specialty VARCHAR(100),
    license_number VARCHAR(100) UNIQUE,
    experience_years INT,
    consultation_fee DECIMAL(10,2),
    rating DECIMAL(3,2) DEFAULT 5.0,
    is_available BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== CONSULTATIONS ==========
CREATE TABLE IF NOT EXISTS consultations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    patient_id UUID REFERENCES users(id),
    doctor_id UUID REFERENCES users(id),
    symptoms TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    urgency VARCHAR(20) DEFAULT 'low',
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== MESSAGES (chat) ==========
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    consultation_id UUID REFERENCES consultations(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES users(id),
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT NOW(),
    is_read BOOLEAN DEFAULT false
);

-- ========== PRESCRIPTIONS ==========
CREATE TABLE IF NOT EXISTS prescriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    consultation_id UUID REFERENCES consultations(id) ON DELETE CASCADE,
    doctor_id UUID REFERENCES users(id),
    patient_id UUID REFERENCES users(id),
    medicines JSONB DEFAULT '[]',
    instructions TEXT,
    issued_at TIMESTAMP DEFAULT NOW()
);

-- ========== ORDERS (pharmacy) ==========
CREATE TABLE IF NOT EXISTS orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    pharmacy_id UUID REFERENCES users(id),
    total_amount DECIMAL(10,2),
    status VARCHAR(30) DEFAULT 'ordered',
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== NOTIFICATIONS ==========
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    body TEXT,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== APPOINTMENTS ==========
CREATE TABLE IF NOT EXISTS appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    patient_id UUID REFERENCES users(id),
    doctor_id UUID REFERENCES users(id),
    appointment_date DATE,
    appointment_time TIME,
    type VARCHAR(20) CHECK (type IN ('in_person','video','voice')),
    status VARCHAR(20) DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== MEDICAL RECORDS ==========
CREATE TABLE IF NOT EXISTS medical_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    record_type VARCHAR(50),
    title VARCHAR(200),
    description TEXT,
    file_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ========== INDEXES ==========
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_consultations_patient ON consultations(patient_id);
CREATE INDEX IF NOT EXISTS idx_consultations_doctor ON consultations(doctor_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id);
