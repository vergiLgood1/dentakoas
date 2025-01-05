import bcrypt from "bcryptjs";
import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function PATCH(req: Request) {
  try {
    // Parsing URL untuk mendapatkan userId
    const url = new URL(req.url);
    const pathSegments = url.pathname.split("/");
    const userId = pathSegments[pathSegments.length - 2]; // Elemen sebelum "reset-password"

    console.log("ini adalah userId:", userId);

    // Parsing body request
    const body = await req.json();
    const { password } = body;

    if (!userId) {
      return NextResponse.json(
        { error: "Invalid URL. User ID is missing." },
        { status: 400 }
      );
    }

    console.log("ini adalah userId:", userId);

    // Fetch user dari database
    const existingUser = await db.user.findUnique({
      where: { id: userId },
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Update data user
    const newPasswordUser = await db.user.update({
      where: { id: existingUser.id },
      data: {
        password: hashedPassword,
      },
    });

    return NextResponse.json({
      success: true,
      message: "Password updated successfully.",
      data: { user: newPasswordUser },
    });
  } catch (error) {
    if (error instanceof Error) {
      return NextResponse.json(
        {
          error: "Internal Server Error : " + error.message,
        },
        { status: 500 }
      );
    }
  }
}
