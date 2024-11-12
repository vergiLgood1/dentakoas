// components/CheckSession.tsx

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "./ui/card";
import { Button } from "./ui/button";
import { auth, signOut } from "@/auth";

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
            <form
              action={async () => {
                "use server";

                await signOut();
              }}
            >
              <button
                type="submit"
                className="flex w-full items-center text-center justify-center px-4 py-2 mt-4 text-white bg-red-500 rounded-md"
              >
                Sign Out
              </button>
            </form>
          </div>
        ) : (
          <p>No active session found.</p>
        )}
      </CardContent>
    </Card>
  );
};

export default CheckSession;
