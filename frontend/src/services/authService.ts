import api from './api';

export const login = (email: string, password: string) =>
  api.post('/auth/login', { email, password });

export const register = (data: { name: string; email: string; password: string }) =>
  api.post('/auth/register', data);
