const express = require('express');
const router = express.Router();
const otpService = require('../services/otpService');
const messagingService = require('../services/messagingService');
router.post('/send', async (req, res) => {
  const { phone } = req.body;
  const otp = otpService.saveOTP(phone);
  const sendResult = await messagingService.sendOTP(phone, otp);
  res.json({ success: true, ...sendResult });
});
router.post('/verify', async (req, res) => {
  const { phone, otp } = req.body;
  const result = otpService.verifyOTP(phone, otp);
  if (result.success) res.json(result);
  else res.status(400).json(result);
});
module.exports = router;
