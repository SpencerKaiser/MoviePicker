import express from 'express';
import { cachedData } from '../cachedData';

const api = express.Router();
api.get('/getOdds', (_, res) => {
  res.send(cachedData.odds);
});

export default api;
