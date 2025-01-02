import { getAuth } from "firebase-admin/auth";
import { NextResponse } from "next/server";

// export async function POST(req: Request) {
//   const url = new URL(req.url); // Parse URL dari request
//   const token = url.searchParams.get("token"); // Ambil parameter "token"

//   console.log("Token:", token);

//   if (!token) {
//     return NextResponse.json({ error: "Missing token!" }, { status: 400 });
//   }

//   // perbarui status emailVerified menjadi true

//   // Menangkap hasil dari newVerification
//   const result = await newVerification(token);

//   // Jika ada error, kembalikan sebagai respons API
//   if (result.error) {
//     return NextResponse.json({ error: result.error }, { status: 400 });
//   }

//   // Jika berhasil, kembalikan sebagai respons API
//   return NextResponse.json({
//     status: "Success",
//     message: "Verification success!",
//     data: { token: token },
//   });
// }

// export async function PATCH(req: Request) {
//   const body = await req.json();
//   const { email } = body;

//   if (!email) {
//     return NextResponse.json({ error: "Email is required." }, { status: 400 });
//   }

//   const auth = getAuth();
//   const user = await auth.generateEmailVerificationLink(email);
// }

export default async function POST(req: Request) {
  const body = await req.json();
  const { oobCode } = body;

  try {
    const auth = getAuth();
    await auth.verifyIdToken(oobCode);
  } catch (error) {
    if (error instanceof Error) {
      return NextResponse.json({ error: error.message }, { status: 400 });
    }
    return NextResponse.json(
      { error: "An unknown error occurred" },
      { status: 400 }
    );
  }
}
