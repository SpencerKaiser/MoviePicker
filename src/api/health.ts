import express from 'express';

const api = express.Router();
api.get('/health', (_, res) => {
  res.send({
    status: 'OK',
    details: 'Everything looks good 👌',
    time: new Date().toISOString(),
  });
});

export default api;
