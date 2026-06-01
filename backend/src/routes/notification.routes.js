const router = require('express').Router();
const { authMiddleware } = require('../middleware/auth.middleware');

router.get('/', authMiddleware, (req, res) => {
  res.json({ message: 'notification routes ready' });
});

module.exports = router;
