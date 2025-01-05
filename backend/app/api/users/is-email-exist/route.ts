import db from "@/lib/db";
import { valEmail } from "@/lib/validations";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  try {
    // Mengambil query parameter dari URL
    const { searchParams } = new URL(req.url);
    const email = searchParams.get("email");

    // Validasi: Apakah parameter email diberikan
    if (!email) {
      return NextResponse.json(
        { error: "Email parameter is required" },
        { status: 400 }
      );
    }

    // Validasi: Format email menggunakan regex
    const isValidEmail = valEmail.safeParse(email);

    if (!isValidEmail.success) {
      return NextResponse.json(
        { error: "Invalid email format" },
        { status: 400 }
      );
    }

    // Cek apakah email sudah ada di database
    const existingEmail = await db.user.findUnique({
      where: {
        email,
      },
      select: {
        email: true,
      },
    });

    // Tampilkan apakah email tersedia
    const isEmailExist = existingEmail ? true : false;

    console.log("Email:", email, "is available:", isEmailExist);

    return NextResponse.json(
      { email, isEmailExist: isEmailExist },
      { status: 200 }
    );
  } catch (error: any) {
    // Tangani error berdasarkan jenisnya
    console.error("Error fetching email:", error);

    if (error.code === "P2021") {
      // Contoh: Kesalahan Prisma jika tabel tidak ditemukan
      return NextResponse.json(
        { error: "Database table not found" },
        { status: 500 }
      );
    }

    // Default: Kesalahan tak dikenal
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}
