import { sendOtpResetPassword } from "@/lib/mail";
import { generateOtp } from "@/lib/otp";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const { email } = body;

    if (!email) {
      return NextResponse.json(
        { error: "Email is required." },
        { status: 400 }
      );
    }

    const verificationOtp = await generateOtp(email);
    await sendOtpResetPassword(email, verificationOtp.otp);

    return NextResponse.json({ message: "Verification email sent." });
  } catch (error) {
    console.error("Error sending verification email", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }

  //   const url = new URL(req.url);
  //   const otp = url.searchParams.get("otp");

  //   console.log("Otp:", otp);

  //   if (!otp) {
  //     return NextResponse.json({ error: "Missing otp!" }, { status: 400 });
  //   }

  //   // Menangkap hasil dari newVerification
  //   const result = await newVerification(otp);

  //   // Jika ada error, kembalikan sebagai respons API
  //   if (result.error) {
  //     return NextResponse.json({ error: result.error }, { status: 400 });
  //   }

  //   // Jika berhasil, kembalikan sebagai respons API
  //   return NextResponse.json({
  //     status: "Success",
  //     message: "Verification success!",
  //     data: { otp: otp },
  //   });
}
