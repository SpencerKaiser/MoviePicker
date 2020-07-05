import express from 'express';
import { cachedData, resetOdds, updateOdds } from '../cachedData';

const api = express.Router();
api.get('/roll', (_, res) => {
  let winner;

  const rand = Math.random() * 100;
  if (rand <= cachedData.odds[0].percentChance) {
    [winner] = cachedData.odds;
  } else {
    [, winner] = cachedData.odds;
  }

  if (winner.percentChance > 50) {
    resetOdds();
  } else {
    updateOdds(winner.user);
  }

  res.send({
    winner: winner.user,
    newOdds: cachedData.odds,
  });
});

export default api;
