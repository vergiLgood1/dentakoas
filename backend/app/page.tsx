'use client'

import { useState } from 'react';
import axios from 'axios';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

export default function ApiGuide() {
  const [userId, setUserId] = useState<string>('');
  const [responseData, setResponseData] = useState<string>('');
  const [error, setError] = useState<string | null>(null);

  const handleCheckAPI = async () => {
    try {
      const response = await axios.get(`/api/users?id=${userId}`);
      setResponseData(JSON.stringify(response.data, null, 2));
      setError(null); // clear any previous errors
    } catch (err: any) {
      setError(err.response ? err.response.data.error : 'An error occurred');
    }
  };

  return (
    <div className="p-6 max-w-md mx-auto">
      <h1 className="text-2xl font-bold mb-4">API Guide</h1>

      <div className="mb-4">
        <Label htmlFor="userId">User ID</Label>
        <Input
          id="userId"
          type="text"
          placeholder="Enter user ID"
          value={userId}
          onChange={(e) => setUserId(e.target.value)}
        />
      </div>

      <Button onClick={handleCheckAPI}>Check API</Button>

      {error && <p className="text-red-600 mt-4">{error}</p>}

      <div className="mt-4">
        <Label htmlFor="response">Response</Label>
        <Textarea
          id="response"
          readOnly
          value={responseData}
          placeholder="API response will appear here"
          rows={8}
        />
      </div>
    </div>
  );
}
