import api from './api';

export const getProfile = () => api.get('/profile');
export const updateProfile = (data: any) => api.put('/profile', data);
