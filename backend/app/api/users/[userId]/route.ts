import { NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import db from "@/lib/db";

import { Role } from "@/config/enum";
import { getUserById, setHashPassword } from "@/helpers/user";

export async function GET(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
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
      FasilitatorProfile: true,
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
          fasilitatorProfile: undefined,
        };
      } else if (existingUser.role === Role.Pasien) {
        return {
          ...existingUser,
          KoasProfile: undefined, // Sembunyikan KoasProfile jika role PASIEN
          fasilitatorProfile: undefined,
        };
      } else if (existingUser.role === Role.Fasilitator) {
        return {
          ...existingUser,
          KoasProfile: undefined,
          pasienProfile: undefined,
        };
      }
      return existingUser; // Default jika role tidak dikenali
    })();

    // Filter properti yang undefined atau null
    const filteredUser = Object.fromEntries(
      Object.entries(user).filter(
        ([_, value]) => value !== undefined && value !== null
      )
    );

    return NextResponse.json(
      {
        ...filteredUser,
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
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
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
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();
  const { givenName, familyName, name, email, password, phone, role } = body;

  console.log("receive body : ", body);

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User id is required" },
        { status: 400 }
      );
    }

    const existingUser = await db.user.findUnique({
      where: { id: userId },
      include: {
        KoasProfile: true,
        PasienProfile: true,
        FasilitatorProfile: true,
      },
    });

    // const isOauth =
    //   password === null ||
    //   (password === undefined && existingUser?.emailVerified !== null);

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    const hash = await setHashPassword(password, existingUser.password);

    // Update user dengan data baru
    const user = await db.user.update({
      where: { id: String(userId) },
      data: {
        givenName: givenName || existingUser.givenName,
        familyName: familyName || existingUser.familyName,
        name: name || existingUser.name,
        email: email || existingUser.email,
        password: hash || existingUser.password,
        phone: phone || existingUser.phone,
        role: role || existingUser.role,
      } as Prisma.UserUpdateInput,
    });

    if (role === null) {
      return NextResponse.json(
        {
          status: "Success",
          message: "Update user successfully",
          data: { ...user },
        },
        { status: 200 }
      );
    }

    // Operasi untuk menangani profil
    if (role) {
      // Hapus profil lama sebelum membuat yang baru jika role berubah
      if (existingUser.role !== role) {
        await db.koasProfile.deleteMany({ where: { userId } });
        await db.pasienProfile.deleteMany({ where: { userId } });
        await db.fasilitatorProfile.deleteMany({ where: { userId } });

        let newProfile = null;

        // Buat profil baru sesuai role
        if (role === Role.Koas) {
          newProfile = await db.koasProfile.create({
            data: {
              ...body.profile,
              userId: userId,
            },
          });
        } else if (role === Role.Pasien) {
          newProfile = await db.pasienProfile.create({
            data: {
              ...body.profile,
              userId: userId,
            },
          });
        } else if (role === Role.Fasilitator) {
          newProfile = await db.fasilitatorProfile.create({
            data: {
              ...body.profile,
              userId: userId,
            },
          });
        } else {
          return NextResponse.json(
            { error: "Role not found" },
            { status: 404 }
          );
        }

        return NextResponse.json(
          {
            status: "Success",
            message: "Update user successfully",
            data: { ...user, newProfile },
          },
          { status: 200 }
        );
      }
    }

    return NextResponse.json(
      {
        ...user,
      },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      // console.error("Error details:", error);
      return NextResponse.json(
        {
          error: "Internal Server Error : " + error.message,
        },
        { status: 500 }
      );
    }
  }
}

export async function DELETE(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
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
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);
    }
  }
}
