import { Role } from "@/config/enum";
import { genUsername, getUserByEmail } from "@/helpers/user";
import db from "@/lib/db";
import { SignUpSchema } from "@/lib/schemas";
import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";

export async function POST(req: Request) {
  const body = await req.json();
  const { givenName, familyName, email, password, confirmPassword, phone, role, profile } = body;

  const validateFields = SignUpSchema.safeParse(body);

  if (!validateFields.success) {
    return NextResponse.json({ error: validateFields.error }, { status: 400 });
  }

  const existingUser = await getUserByEmail(email);

  if (existingUser) {
    return NextResponse.json(
      { error: "Email already in use." },
      { status: 400 }
    );
  }

  try {
    const name = await genUsername(givenName, familyName);
    const hash = await bcrypt.hash(password, 10);

    const newUser = await db.user.create({
      data: {
        givenName,
        familyName,
        name,
        email,
        password: hash,
      } as Prisma.UserCreateInput,
    });

    if (newUser.role === Role.Koas) {
      await db.koasProfile.create({
        data: {
          ...profile,
          userId: newUser.id,
        },
      });
    } else if (newUser.role === Role.Pasien) {
      await db.pasienProfile.create({
        data: {
          ...profile,
          userId: newUser.id,
        },
      });
    }

    return NextResponse.json(
      {
        status: "Success",
        message: "User created successfully",
        data: { user: newUser },
      },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating user", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
