import express from 'express';
import health from './health';
import getOdds from './getOdds';
import resetOdds from './resetOdds';
import roll from './roll';

const api = express.Router();

api.use(health);
api.use(getOdds);
api.use(resetOdds);
api.use(roll);

export default api;
