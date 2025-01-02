// import { getUserByEmail } from "@/helpers/user";
// import { NextResponse } from "next/server";
// import { getAuth } from "firebase-admin/auth";
// import db from "@/lib/db";

import { getUserByEmail } from "@/helpers/user";
import db from "@/lib/db";
import { NextResponse } from "next/server";

// export async function POST(req: Request) {
//   const body = await req.json();

//   const { email } = body;

//   if (!email) {
//     return NextResponse.json({ error: "Email is required." }, { status: 400 });
//   }

//   try {
//     const existingUser = await getUserByEmail(email);

//     if (!existingUser?.email) {
//       return NextResponse.json(
//         { error: "User email not found." },
//         { status: 400 }
//       );
//     }

//     await db.user.update({
//       where: { id: existingUser.id },
//       data: { emailVerified: new Date(), email: existingToken.email },
//     });

//     await db.verificationRequest.delete({
//       where: { id: existingToken.id },
//     });

//     return NextResponse.json({
//       message: "Email verified.",
//     });
//   } catch (error) {
//     console.error("Error verifying email", error);
//     return NextResponse.json(
//       { error: "Internal Server Error" },
//       { status: 500 }
//     );
//   }
// }

export async function PATCH(req: Request) {
  try {
    // Parsing body request
    const body = await req.json();
    const { email } = body;

    // Validasi input email
    if (!email || typeof email !== "string") {
      return NextResponse.json(
        { error: "Invalid or missing email address." },
        { status: 400 }
      );
    }

    // Cek apakah user dengan email tersebut ada
    const existingUser = await getUserByEmail(email);

    if (!existingUser) {
      return NextResponse.json(
        { error: "User not found with the provided email." },
        { status: 404 }
      );
    }

    // Update emailVerified menjadi true
    await db.user.update({
      where: { id: existingUser.id },
      data: { emailVerified: new Date() },
    });

    // Berikan respons sukses
    return NextResponse.json({
      message: "Email successfully verified.",
    });
  } catch (error) {
    console.error("Error verifying email:", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
