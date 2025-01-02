// import { getUserByEmail } from "@/helpers/user";
// import { getVerificationTokenByEmail } from "@/helpers/verification-token";
// import { sendVerificationEmail } from "@/lib/mail";
// import { generateVerificationToken } from "@/lib/tokens";
// import { NextResponse } from "next/server";

// export async function POST(req: Request) {
//   const body = await req.json();
//   const { email } = body;

//   const existingUser = await getUserByEmail(email);

//   if (!existingUser || !existingUser.email || !existingUser.password) {
//     return NextResponse.json({ error: "User not found." }, { status: 400 });
//   }

//   if (!existingUser.emailVerified) {
//     const verificationToken = await generateVerificationToken(
//       existingUser.email
//     );

//     await sendVerificationEmail(
//       verificationToken.email,
//       verificationToken.token
//     );
//   }

//   return NextResponse.json({ message: "Verification email sent." });
// }
