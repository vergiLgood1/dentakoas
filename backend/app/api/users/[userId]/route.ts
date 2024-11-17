import { NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import db from "@/lib/db";

import { Role } from "@/config/enum";
import { getUserById, setHashPassword } from "@/helpers/user";

export async function GET(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User userId is required" },
        { status: 400 }
      );
    }

    const existingUser = await getUserById(userId, {
      KoasProfile: true,
      PasienProfile: true,
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Filter profile berdasarkan role
    const user = (() => {
      if (existingUser.role === Role.Koas) {
        return {
          ...existingUser,
          pasienProfile: undefined, // Sembunyikan pasienProfile jika role KOAS
        };
      } else if (existingUser.role === Role.Pasien) {
        return {
          ...existingUser,
          KoasProfile: undefined, // Sembunyikan KoasProfile jika role PASIEN
        };
      } else {
        return {
          ...existingUser,
          KoasProfile: undefined,
          pasienProfile: undefined,
        };
      }
    })();

    return NextResponse.json(
      {
        status: "Success",
        message: "Retrived user successfully",
        data: { user },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching user", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function PUT(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();
  const { givenName, familyName, email, password, phone, role } = body;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User Id is required" },
        { status: 400 }
      );
    }

    const existingUser = await getUserById(userId, {
      KoasProfile: true,
      PasienProfile: true,
    });

    if (!existingUser)
      return NextResponse.json({ error: "User not found" }, { status: 404 });

    const hash = await setHashPassword(password, existingUser.password ?? "");

    const user = await db.user.update({
      where: { id: String(userId) },
      data: {
        givenName,
        familyName,
        email,
        password: hash,
        phone,
        role,
      } as Prisma.UserUpdateInput,
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Update user successfully",
        data: { user },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating user", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function PATCH(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();
  const { givenName, familyName, email, password, phone, role } = body;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User id is required" },
        { status: 400 }
      );
    }

    const existingUser = await getUserById(userId, {
      KoasProfile: true,
      PasienProfile: true,
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    const hash = await setHashPassword(password, existingUser.password ?? "");

    const user = await db.user.update({
      where: { id: String(userId) },
      data: {
        givenName: givenName || existingUser.givenName,
        familyName: familyName || existingUser.familyName,
        email: email || existingUser.email,
        password: hash,
        phone: phone || existingUser.phone,
        role: role || existingUser.role,
      } as Prisma.UserUpdateInput,
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Update user successfully",
        data: { user },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating user", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "user Id is required" },
        { status: 400 }
      );
    }

    await db.user.delete({
      where: { id: userId },
    });

    return NextResponse.json(
      { message: "User deleted successfully" },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error deleting user", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
