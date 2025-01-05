import { NextResponse } from "next/server";
import db from "@/lib/db";
import { Prisma } from "@prisma/client";

export async function GET(req: Request, props: { params: Promise<{ userId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    const user = await db.user.findUnique({
      where: {
        id: userId,
      },
      include: {
        PasienProfile: true,
      },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    return NextResponse.json(user, { status: 200 });
  } catch (error) {
    console.error("Error fetching user profile:", error); // Log error
    return NextResponse.json(
      { error: "Error fetching user profile" },
      { status: 500 }
    );
  }
}

export async function PATCH(req: Request, props: { params: Promise<{ userId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      );
    }

    const user = await db.user.findUnique({
      where: {
        id: userId,
      },
      include: {
        PasienProfile: true,
      },
    });

    if (!user || !user.PasienProfile) {
      return NextResponse.json(
        { error: "Pasien profile not found" },
        { status: 404 }
      );
    }

    const updateProfile = await db.pasienProfile.update({
      where: { userId: String(userId) },
      data: {
        age: body.age ?? user.PasienProfile.age,
        gender: body.gender ?? user.PasienProfile.gender,
        bio: body.bio ?? user.PasienProfile.bio,
      } as Prisma.PasienProfileUpdateInput,
    });

    return NextResponse.json(
      { data: updateProfile, message: "Profile updated successfully" },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error update pasien profile:", error); // Log error
    return NextResponse.json(
      { error: "Error fetching user profile" },
      { status: 500 }
    );
  }
}

export async function PUT(req: Request, props: { params: Promise<{ userId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      );
    }

    const user = await db.user.findUnique({
      where: {
        id: userId,
      },
      include: {
        PasienProfile: true,
      },
    });

    if (!user || !user.PasienProfile) {
      return NextResponse.json(
        { error: "Pasien profile not found" },
        { status: 404 }
      );
    }

    const updateProfile = await db.pasienProfile.update({
      where: { userId: String(userId) },
      data: {
        age: body.age,
        gender: body.gender,
        bio: body.bio,
      } as Prisma.PasienProfileUpdateInput,
    });

    return NextResponse.json(
      { data: updateProfile, message: "Profile updated successfully" },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error update pasien profile:", error); // Log error
    return NextResponse.json(
      { error: "Error fetching user profile" },
      { status: 500 }
    );
  }
}

export async function DELETE(req: Request, props: { params: Promise<{ userId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;
  const reset = searchParams.get("reset") === "true"; // Ambil opsi reset dari query

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      );
    }

    const user = await db.user.findUnique({
      where: {
        id: userId,
      },
      include: {
        PasienProfile: true,
      },
    });

    if (!user || !user.PasienProfile) {
      return NextResponse.json(
        { error: "Pasien profile not found" },
        { status: 404 }
      );
    }

    if (reset) {
      //   Jika reset = true, reset pasienProfile menjadi null
      const deletedProfile = await db.pasienProfile.update({
        where: {
          userId: userId,
        },
        data: {
          age: null,
          gender: null,
          bio: null,
        } as Prisma.PasienProfileUpdateInput,
      });

      return NextResponse.json(
        {
          data: deletedProfile,
          message: "Pasien profile partially cleared successfully",
        },
        { status: 200 }
      );
    } else {
      // Jika reset = false, hapus seluruh record pasienProfile
      const deletedProfile = await db.pasienProfile.delete({
        where: {
          userId: userId,
        },
      });

      return NextResponse.json(
        {
          data: deletedProfile,
          message: "Pasien profile completely deleted successfully",
        },
        { status: 200 }
      );
    }
  } catch (error) {
    console.error("Error deleting pasien profile:", error); // Log error
    return NextResponse.json(
      { error: "Error deleting pasien profile" },
      { status: 500 }
    );
  }
}
