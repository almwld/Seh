const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'sehatak-secret-key-2026';

function authMiddleware(req, res, next) {
  const token = req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'يرجى تسجيل الدخول' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ error: 'انتهت الجلسة، يرجى إعادة تسجيل الدخول' });
  }
}

function doctorMiddleware(req, res, next) {
  if (req.user?.role !== 'doctor') {
    return res.status(403).json({ error: 'غير مصرح' });
  }
  next();
}

module.exports = { authMiddleware, doctorMiddleware, JWT_SECRET };
