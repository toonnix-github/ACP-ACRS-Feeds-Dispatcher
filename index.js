const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || 'feeds-dispatcher';
const ENV = process.env.NODE_ENV || 'dev';
const VERSION = process.env.APP_VERSION || '1.0.0';

// Basic health check
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'UP'
  });
});

// Context health check
app.get('/health/context', (req, res) => {
  res.status(200).json({
    status: 'UP',
    app: APP_NAME,
    environment: ENV,
    version: VERSION,
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});