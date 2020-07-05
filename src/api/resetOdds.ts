import express from 'express';
import { cachedData, resetOdds } from '../cachedData';

const api = express.Router();
api.get('/resetOdds', (_, res) => {
  resetOdds();
  res.send(cachedData.odds);
});

export default api;
