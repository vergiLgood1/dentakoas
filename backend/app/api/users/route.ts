import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";
import db from "@/lib/db";
import bcrypt from "bcryptjs";

import { Role } from "@/config/enum";
import { SignUpSchema } from "@/lib/schemas";
import { UserQueryString } from "@/config/types";
import { getUserByEmail, parseSearchParams, genUsername } from "@/helpers/user";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const query: UserQueryString = parseSearchParams(searchParams);

  const isKoas = Role.Koas;
  const isPasien = Role.Pasien;
  const isFasilitator = Role.Fasilitator;

  try {
    const user = await db.user.findMany({
      where: {
        ...query,
      } as Prisma.UserWhereInput,
      orderBy: {
        name: "asc",
      },
      include: {
        KoasProfile: true,
        PasienProfile: true,
        FasilitatorProfile: true,
      },
    });

    const filtereduser = user.map((user) => {
      if (user.role === Role.Koas) {
        return {
          ...user,
          PasienProfile: undefined, // sembunyikan pasien profile
          FasilitatorProfile: undefined, // sembunyikan fasilitator profile
        };
      } else if (user.role === Role.Pasien) {
        return {
          ...user,
          KoasProfile: undefined, // sembunyikan koas profile
          FasilitatorProfile: undefined, // sembunyikan fasilitator profile
        };
      } else if (user.role === Role.Fasilitator) {
        return {
          ...user,
          KoasProfile: undefined, // sembunyikan koas profile
          PasienProfile: undefined, // sembunyikan pasien profile
        };
      } else {
        return {
          ...user,
          KoasProfile: undefined, // sembunyikan koas profile
          PasienProfile: undefined, // sembunyikan pasien profile
          FasilitatorProfile: undefined, // sembunyikan fasilitator profile
        };
      }
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "User retrived successfully",
        data: { user: filtereduser },
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

export async function POST(req: Request) {
  const body = await req.json();
  const {
    id,
    givenName,
    familyName,
    email,
    password,
    phone,
    role,
    profile,
    image,
  } = body;

  console.log("Received Body:", body);

  const isOauth =
    password === null ||
    (password === undefined && role === null) ||
    role === undefined;

  let hash = null;
  // const validateFields = SignUpSchema.safeParse(body);

  // if (!validateFields.success) {
  //   return NextResponse.json({ error: validateFields.error }, { status: 400 });
  // }

  const existingUser = await getUserByEmail(email);
  if (existingUser) {
    console.log(`Attempted signup with existing email: ${email}`);
    return NextResponse.json(
      { error: "Email already in use." },
      { status: 400 }
    );
  }

  try {
    const name = await genUsername(givenName, familyName);

    const hash = !isOauth ? await bcrypt.hash(password, 10) : null;

    const newUser = await db.user.create({
      data: {
        id,
        givenName,
        familyName,
        name,
        email,
        password: hash,
        phone,
        image: image ?? null,
        role: role ?? null,
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
    } else {
      await db.fasilitatorProfile.create({
        data: {
          ...profile,
          userId: newUser.id,
        },
      });
    }

    if (isOauth)
      await db.user.update({
        where: { id: newUser.id },
        data: { emailVerified: new Date() },
      });

    return NextResponse.json(
      {
        status: "Success",
        message: "User created successfully",
        data: { user: newUser },
      },
      { status: 201 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log("Error: ", error.stack);
    }
  }
}

export async function DELETE(req: Request) {
  try {
    await db.user.deleteMany({});

    return NextResponse.json(
      {
        status: "Success",
        message: "All users deleted successfully",
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error deleting all users", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

