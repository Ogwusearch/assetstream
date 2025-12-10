import api from './api';

export const getAssets = () => api.get('/assets');
export const createAsset = (data: any) => api.post('/assets', data);
export const updateAsset = (id: string, data: any) => api.put(`/assets/${id}`, data);
export const deleteAsset = (id: string) => api.delete(`/assets/${id}`);
