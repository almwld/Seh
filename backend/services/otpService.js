const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const otpStore = new Map();
class OTPService {
  constructor() {
    setInterval(() => this._cleanExpired(), 300000);
  }
  generateOTP() { return crypto.randomInt(100000, 999999).toString(); }
  saveOTP(phone) {
    const otp = this.generateOTP();
    const key = this._formatPhone(phone);
    otpStore.set(key, { otp, expiresAt: Date.now() + 10 * 60 * 1000, attempts: 0, verified: false });
    return otp;
  }
  verifyOTP(phone, otp) {
    const key = this._formatPhone(phone);
    const data = otpStore.get(key);
    if (!data) return { success: false, error: 'الرمز منتهي الصلاحية. اطلب رمزاً جديداً' };
    if (data.expiresAt < Date.now()) { otpStore.delete(key); return { success: false, error: 'انتهت صلاحية الرمز' }; }
    if (data.verified) return { success: false, error: 'الرمز مستخدم مسبقاً' };
    data.attempts++;
    if (data.attempts > 5) { otpStore.delete(key); return { success: false, error: 'تجاوزت عدد المحاولات. اطلب رمزاً جديداً' }; }
    if (data.otp !== otp.toString().trim()) return { success: false, error: 'رمز التحقق غير صحيح' };
    data.verified = true;
    const token = this._generateToken(phone);
    return { success: true, message: 'تم التحقق بنجاح', token, phone: this._formatPhone(phone) };
  }
  _generateToken(phone) {
    return jwt.sign({ phone: this._formatPhone(phone), type: 'access', timestamp: Date.now() }, process.env.JWT_SECRET || 'sehatak_secret_key_2024', { expiresIn: '30d' });
  }
  _formatPhone(phone) {
    let cleaned = phone.replace(/[^0-9+]/g, '');
    if (cleaned.startsWith('00')) cleaned = '+' + cleaned.substring(2);
    if (!cleaned.startsWith('+')) cleaned = (cleaned.startsWith('0') ? '+967' + cleaned.substring(1) : '+967' + cleaned);
    return cleaned;
  }
  _cleanExpired() {
    const now = Date.now();
    for (const [key, value] of otpStore.entries()) { if (value.expiresAt < now) otpStore.delete(key); }
  }
  resendOTP(phone) {
    const key = this._formatPhone(phone);
    otpStore.delete(key);
    return this.saveOTP(phone);
  }
}
module.exports = new OTPService();
