const router = require('express').Router();
const { triage, chatbot } = require('../controllers/ai.controller');
const { authMiddleware } = require('../middleware/auth.middleware');

router.post('/triage', authMiddleware, triage);
router.post('/chatbot', authMiddleware, chatbot);

module.exports = router;
