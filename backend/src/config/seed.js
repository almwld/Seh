const { pool } = require('./db');
const bcrypt = require('bcryptjs');

async function seed() {
  try {
    // مستخدم تجريبي
    const password_hash = await bcrypt.hash('123456', 12);
    await pool.query(`
      INSERT INTO users (full_name, email, phone, password_hash, role) VALUES
      ('أحمد محمد', 'ahmed@email.com', '+967777123456', $1, 'patient'),
      ('د. علي المولد', 'ali@email.com', '+967777123457', $1, 'doctor')
      ON CONFLICT (email) DO NOTHING
    `, [password_hash]);

    // أطباء
    await pool.query(`
      INSERT INTO doctors (user_id, specialty, sub_specialty, qualification, experience_years, consultation_fee, hospital) VALUES
      ((SELECT id FROM users WHERE email='ali@email.com'), 'باطنية', 'أطفال', 'بكالوريوس طب - البورد العربي', 20, 500, 'مستشفى الثورة')
      ON CONFLICT DO NOTHING
    `);

    console.log('✅ Database seeded successfully');
    process.exit(0);
  } catch (error) {
    console.error('❌ Seed failed:', error);
    process.exit(1);
  }
}

seed();
