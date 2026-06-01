// Mock AI responses (will connect to Python AI service)
async function triage(req, res) {
  const { symptoms, body_part } = req.body;
  
  const specs = {
    'head': 'الطب العصبي', 'chest': 'الصدرية والقلب',
    'stomach': 'الجهاز الهضمي', 'skin': 'الجلدية',
    'bones': 'العظام والمفاصل', 'mental': 'الصحة النفسية',
    'children': 'طب الأطفال', 'general': 'الطب العام'
  };

  const urgencyKeywords = ['شديد', 'حادث', 'نزيف', 'اختناق'];
  const isUrgent = urgencyKeywords.some(k => symptoms?.includes(k));

  res.json({
    specialization: specs[body_part] || 'الطب العام',
    urgency: isUrgent ? 'high' : 'low',
    recommended_action: isUrgent ? 'استشارة فورية' : 'مراقبة منزلية',
    confidence: 0.85
  });
}

async function chatbot(req, res) {
  const { message } = req.body;
  
  let response = 'شكراً لتواصلك. كيف يمكنني مساعدتك؟';
  let type = 'general';

  if (message?.includes('سلام') || message?.includes('مرحب')) {
    response = 'وعليكم السلام! أنا مساعدك الصحي. كيف يمكنني خدمتك؟';
    type = 'greeting';
  } else if (message?.includes('طوارئ') || message?.includes('emergency')) {
    response = '🚨 اتصل فوراً على 1122';
    type = 'urgent';
  } else if (message?.includes('دواء') || message?.includes('باراسيتامول')) {
    response = '💊 باراسيتامول: مسكن ألم، 500mg كل 6 ساعات';
    type = 'info';
  } else if (message?.includes('موعد') || message?.includes('حجز')) {
    response = '📅 لحجز موعد: الأطباء > اختر التخصص > الطبيب > التاريخ';
    type = 'help';
  }

  res.json({ response, type, create_ticket: type === 'general' });
}

module.exports = { triage, chatbot };
