const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { pool } = require('../config/db');
const JWT_SECRET = process.env.JWT_SECRET || 'sehatak-secret';

// Register
async function register(req, res) {
  try {
    const { full_name, email, phone, password, user_type } = req.body;
    
    const existing = await pool.query('SELECT id FROM users WHERE email = $1 OR phone = $2', [email, phone]);
    if (existing.rows.length > 0) {
      return res.status(400).json({ error: 'البريد الإلكتروني أو رقم الهاتف مسجل مسبقاً' });
    }

    const password_hash = await bcrypt.hash(password, 12);
    const result = await pool.query(
      `INSERT INTO users (full_name, email, phone, password_hash, user_type)
       VALUES ($1, $2, $3, $4, $5) RETURNING id, full_name, email, phone, user_type, created_at`,
      [full_name, email, phone, password_hash, user_type || 'patient']
    );

    const user = result.rows[0];
    const token = jwt.sign({ id: user.id, user_type: user.user_type }, JWT_SECRET, { expiresIn: '30d' });

    res.status(201).json({ user, token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

// Login
async function login(req, res) {
  try {
    const { email, password } = req.body;
    
    const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(401).json({ error: 'بيانات الدخول غير صحيحة' });
    }

    const user = result.rows[0];
    const valid = await bcrypt.compare(password, user.password_hash);
    if (!valid) {
      return res.status(401).json({ error: 'بيانات الدخول غير صحيحة' });
    }

    const token = jwt.sign({ id: user.id, user_type: user.user_type }, JWT_SECRET, { expiresIn: '30d' });
    delete user.password_hash;

    res.json({ user, token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

// Get Profile
async function getProfile(req, res) {
  try {
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [req.user.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'المستخدم غير موجود' });
    }
    const user = result.rows[0];
    delete user.password_hash;
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

// Update Profile
async function updateProfile(req, res) {
  try {
    const { full_name, avatar } = req.body;
    const result = await pool.query(
      'UPDATE users SET full_name = COALESCE($1, full_name), avatar = COALESCE($2, avatar) WHERE id = $3 RETURNING *',
      [full_name, avatar, req.user.id]
    );
    const user = result.rows[0];
    delete user.password_hash;
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

// Verify OTP (Mockup)
async function verifyOtp(req, res) {
  const { code } = req.body;
  if (code === '123456') {
    return res.json({ message: 'تم التحقق بنجاح' });
  }
  res.status(400).json({ error: 'كود التحقق غير صحيح' });
}

module.exports = { register, login, getProfile, updateProfile, verifyOtp };
