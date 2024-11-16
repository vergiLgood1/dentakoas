import { NextResponse } from "next/server";
import db from "@/lib/db";
import { Role } from "@/config/enum";
import { Prisma } from "@prisma/client";

export async function GET(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const userId = params.userId;
  let profile;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    // Fetch the user, including the role and relevant profiles
    const user = await db.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        name: true,
        email: true,
        phone: true,
        address: true,
        image: true,
        role: true,
      },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Check user role and respond with the appropriate profile
    if (user.role === Role.Koas) {
      profile = await db.koasProfile.findUnique({
        where: { userId },
        select: {
          id: true,
          userId: true,
          koasNumber: true,
          faculty: true,
          bio: true,
          whatsappLink: true,
          status: true,
        },
      });
    } else if (user.role === Role.Pasien) {
      profile = await db.pasienProfile.findUnique({
        where: { userId },
        select: {
          id: true,
          userId: true,
          age: true,
          gender: true,
          bio: true,
        },
      });
    } else {
      return NextResponse.json({ error: "Invalid user role" }, { status: 400 });
    }

    if (!profile) {
      return NextResponse.json({ error: "Profile not found" }, { status: 404 });
    }

    const userWithProfile = {
      ...user,
      profile,
    };

    return NextResponse.json(
      { message: "Fetch user profile successfully", user: userWithProfile },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching profile:", error);
    return NextResponse.json(
      { error: "Error fetching profile" },
      { status: 500 }
    );
  }
}

export async function PATCH(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const userId = params.userId;
  const body = await req.json();

  let profile;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    // Fetch the user to check the role
    const user = await db.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        role: true,
      },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Create the profile based on the user role
    if (user.role === Role.Koas) {
      profile = await db.koasProfile.update({
        where: { userId },
        data: {
          ...body,
          user: { connect: { id: userId } },
        } as Prisma.KoasProfileUpdateInput,
      });
    } else if (user.role === Role.Pasien) {
      profile = await db.pasienProfile.update({
        where: { userId },
        data: {
          ...body,
          user: { connect: { id: userId } },
        } as Prisma.PasienProfileUpdateInput,
      });
    } else {
      return NextResponse.json({ error: "Invalid user role" }, { status: 400 });
    }

    return NextResponse.json(
      { message: "Profile updated successfully", profile },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating profile:", error);
    return NextResponse.json(
      { error: "Error creating profile" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url);
  const userId = params.userId;
  let profile;

  const reset = searchParams.get("reset") === "true";

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    // Fetch the user to check the role
    const user = await db.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        role: true,
      },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    if (reset) {
      if (user.role === Role.Koas) {
        profile = await db.koasProfile.update({
          where: { userId },
          data: {
            koasNumber: null,
            faculty: null,
            bio: null,
            whatsappLink: null,
            status: "Pending",
            createdAt: new Date(),
            updateAt: new Date(),
          } as Prisma.KoasProfileUpdateInput,
        });
      } else if (user.role === Role.Pasien) {
        profile = await db.pasienProfile.update({
          where: { userId },
          data: {
            age: null,
            gender: null,
            bio: null,
            createdAt: new Date(),
            updateAt: new Date(),
          } as Prisma.PasienProfileUpdateInput,
        });
      }
    }

    if (!reset) {
      // Delete the profile based on the user role
      if (user.role === Role.Koas) {
        profile = await db.koasProfile.delete({
          where: { userId },
        });
      } else if (user.role === Role.Pasien) {
        profile = await db.pasienProfile.delete({
          where: { userId },
        });
      } else {
        return NextResponse.json(
          { error: "Invalid user role" },
          { status: 400 }
        );
      }
    }

    return NextResponse.json(
      {
        message: reset
          ? "Profile reset successfully"
          : "Profile delete successfully",
        profile,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error deleting profile:", error);
    return NextResponse.json(
      { error: "Error deleting profile" },
      { status: 500 }
    );
  }
}
