import { NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import db from "@/lib/db";

import { Role } from "@/config/enum";
import { getUserById, setHashPassword } from "@/helpers/user";
import { koasProfile } from "@/data/koas-profile";

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

    const user = await db.user.findUnique({
      where: { id: userId },
      include: { koasProfile: true, pasienProfile: true },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Filter profile berdasarkan role
    const filteredUser = (() => {
      if (user.role === Role.Koas) {
        return {
          ...user,
          pasienProfile: undefined, // Sembunyikan pasienProfile jika role KOAS
        };
      } else if (user.role === Role.Pasien) {
        return {
          ...user,
          koasProfile: undefined, // Sembunyikan koasProfile jika role PASIEN
        };
      } else {
        return {
          ...user,
          koasProfile: undefined,
          pasienProfile: undefined,
        };
      }
    })();

    return NextResponse.json(filteredUser, { status: 200 });
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
  const { firstname, lastname, email, password, phone, role } = body;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User userId is required" },
        { status: 400 }
      );
    }

    const user = await getUserById(userId, {
      koasProfile: true,
      pasienProfile: true,
    });

    if (!user)
      return NextResponse.json({ error: "User not found" }, { status: 404 });

    const hash = await setHashPassword(password, user.password ?? "");

    const updatedUser = await db.user.update({
      where: { id: String(userId) },
      data: {
        firstname,
        lastname,
        email,
        password: hash,
        phone,
        role,
      } as Prisma.userUpdateInput,
    });

    return NextResponse.json(updatedUser, { status: 200 });
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
  const { firstname, lastname, email, password, phone, role } = body;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User userId is required" },
        { status: 400 }
      );
    }

    const user = await getUserById(userId, {
      koasProfile: true,
      pasienProfile: true,
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    const hash = await setHashPassword(password, user.password ?? "");

    const updatedUser = await db.user.update({
      where: { id: userId },
      data: {
        firstname: firstname || user.firstname,
        lastname: lastname || user.lastname,
        email: email || user.email,
        password: hash,
        phone: phone || user.phone,
        role: role || user.role,
      } as Prisma.userUpdateInput,
    });

    return NextResponse.json(updatedUser, { status: 200 });
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
        { error: "User userId is required" },
        { status: 400 }
      );
    }

    await getUserById(userId);

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
