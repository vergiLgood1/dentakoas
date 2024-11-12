// pages/check-session.tsx

import CheckSession from "@/components/checkSession";
import { NextPage } from "next";

const CheckSessionPage: NextPage = () => {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-50">
      <CheckSession />
    </div>
  );
};

export default CheckSessionPage;
