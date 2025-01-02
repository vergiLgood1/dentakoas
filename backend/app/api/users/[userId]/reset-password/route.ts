import { getUserByEmail, setHashPassword } from "@/helpers/user";
import db from "@/lib/db";
import { NextResponse } from "next/server";
import bcrpyt from "bcryptjs";

export async function PATCH(req: Request) {
  try {
    // Parsing body request
    const body = await req.json();
    const { email, newPassword } = body;

    // Validasi input email
    if (!email || typeof email !== "string") {
      return NextResponse.json(
        { error: "Invalid or missing email address." },
        { status: 400 }
      );
    }

    // Cari user berdasarkan email
    const existingUser = await getUserByEmail(email);

    // Jika user tidak ditemukan
    if (!existingUser?.email) {
      return NextResponse.json(
        { error: "User email not found." },
        { status: 400 }
      );
    }

    // Hash password
    const hashedPassword = await bcrpyt.hash(newPassword, 10);

    // Update data user
    await db.user.update({
      where: { id: existingUser.id },
      data: {
        password: hashedPassword,
      },
    });

    return NextResponse.json({
      success: true,
      message: "Password updated successfully.",
    });
  } catch (error) {
    console.error("Error verifying email", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
