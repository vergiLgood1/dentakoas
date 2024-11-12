// components/CheckSession.tsx

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { auth } from "@/auth";

const CheckSession = async () => {
  const session = await auth();
  return (
    <Card className="max-w-md mx-auto mt-10">
      <CardHeader>
        <CardTitle>Session Status</CardTitle>
      </CardHeader>
      <CardContent>
        {session ? (
          <div>
            <p>{JSON.stringify(session, null, 2)}</p>
          </div>
        ) : (
          <p>No active session found.</p>
        )}
      </CardContent>
    </Card>
  );
};

export default CheckSession;
