import { newVerification } from "@/lib/tokens";
import { NextResponse } from "next/server";

export async function POST(req: Request) {
  const url = new URL(req.url); // Parse URL dari request
  const token = url.searchParams.get("token"); // Ambil parameter "token"

  console.log("Token:", token);

  if (!token) {
    return NextResponse.json({ error: "Missing token!" }, { status: 400 });
  }

  // Menangkap hasil dari newVerification
  const result = await newVerification(token);

  // Jika ada error, kembalikan sebagai respons API
  if (result.error) {
    return NextResponse.json({ error: result.error }, { status: 400 });
  }

  // Jika berhasil, kembalikan sebagai respons API
  return NextResponse.json({
    status: "Success",
    message: "Verification success!",
    data: { token: token },
  });
}
