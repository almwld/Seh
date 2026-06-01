const axios = require('axios');
class MessagingService {
  async sendOTP(phone, otp) {
    return { success: true, channel: 'dev', dev_otp: otp };
  }
  _formatPhone(phone) {
    let cleaned = phone.replace(/[^0-9+]/g, '');
    if (cleaned.startsWith('00')) cleaned = '+' + cleaned.substring(2);
    if (!cleaned.startsWith('+')) cleaned = (cleaned.startsWith('0') ? '+967' + cleaned.substring(1) : '+967' + cleaned);
    return cleaned;
  }
}
module.exports = new MessagingService();
