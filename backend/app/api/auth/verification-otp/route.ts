import { getUserByEmail } from "@/helpers/user";
import { compareOtp } from "@/lib/otp";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  const { otp } = await req.json();

  console.log("Receicve OTP : ", otp);

  try {
    const isValidOtp = await compareOtp(otp);

    if (!isValidOtp) {
      return NextResponse.json({ message: "Invalid OTP" }, { status: 400 });
    }

    return NextResponse.json({ message: "OTP verified successfully" });
  } catch (error) {
    const errorMessage =
      error instanceof Error ? error.message : "Unknown error";
    return NextResponse.json(
      { message: "Error verifying OTP", error: errorMessage },
      { status: 500 }
    );
  }
}
