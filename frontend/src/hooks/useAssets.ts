import { useState, useEffect } from 'react';
import api from '../services/api';

export const useAssets = () => {
  const [assets, setAssets] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.get('/assets')
      .then(res => setAssets(res.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  return { assets, loading };
};
