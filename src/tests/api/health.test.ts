import 'jest';
import supertest from 'supertest';
import { app } from '../../app';

describe('/api/health', () => {
  it('returns status, details, and timestamp', async () => {
    const healthResponse = await supertest(app).get('/api/health');
    const health = healthResponse.body;

    expect(health.status).toBe('OK');
    expect(health.details).toBe('Everything looks good 👌');
    expect(health.time).toBeDefined();
    expect(new Date(health.time)).toBeInstanceOf(Date);
  });
});
