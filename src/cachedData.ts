import fs from 'fs';
import { Data } from './types/data';
import getRequiredEnvVar from './utils/getRequiredEnvVar';

const users = getRequiredEnvVar('USERS').split(',');

let data: Data;

function saveData() {
  fs.writeFileSync('./data.json', JSON.stringify(data, null, 2));
}

function init() {
  try {
    const rawData = fs.readFileSync('../data.json', 'utf-8');
    data = JSON.parse(rawData) as Data;
  } catch (error) {
    data = {
      odds: [],
    };

    users.forEach((user: string) => {
      data.odds.push({
        user,
        percentChance: 50,
      });
      saveData();
    });
  }
}

export function updateOdds(winnerName: string): void {
  const [loser, winner] = data.odds.sort((a) => (a.user === winnerName ? 1 : -1));
  loser.percentChance += 5;
  winner.percentChance -= 5;
  saveData();
}

export function resetOdds(): void {
  data.odds = [];

  users.forEach((user: string) => {
    data.odds.push({
      user,
      percentChance: 50,
    });
  });

  saveData();
}

init();

export const cachedData = data;
