import { NextResponse } from "next/server";
import db from "@/lib/db";
import { Role } from "@/config/enum";
import { Prisma } from "@prisma/client";
import { getUserById } from "@/helpers/user";

export async function GET(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  let profile;

  console.log("Received userId", userId);

  if (!userId) {
    console.log("User ID is required");
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    const existingUser = await getUserById(userId, undefined, {
      id: true,
      email: true,

      password: true,
      role: true,
    });

    const isOauth =
      existingUser?.password === null ||
      existingUser?.password === undefined ||
      existingUser?.password === "";

    console.log("Existing user", existingUser);

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Check user role and respond with the appropriate profile
    if (existingUser.role == Role.Koas) {
      profile = await db.koasProfile.findUnique({
        where: { userId },
      });

      if (!profile) {
        return NextResponse.json(
          { error: "Profile not found" },
          { status: 404 }
        );
      }

      const totalReviews = await db.review.count({
        where: {
          userId,
        },
      });

      const patientCount = await db.appointment.count({
        where: {
          koasId: profile.id,
          status: "Completed",
        },
      });

      const averageRating = await db.review.aggregate({
        _avg: {
          rating: true,
        },
        where: {
          userId,
        },
      });

      // Remove createdAt and updateAt from the profile object
      const { createdAt, updateAt, ...profileWithoutDates } = profile;

      profile = {
        ...profileWithoutDates,
        stats: {
          totalReviews,
          averageRating: parseFloat(
            (averageRating._avg.rating || 0.0).toFixed(1)
          ),
          patientCount,
        },
        createdAt,
        updateAt,
      };
    } else if (existingUser.role == Role.Pasien) {
      profile = await db.pasienProfile.findUnique({
        where: { userId },
      });
    } else if (existingUser.role == Role.Fasilitator) {
      profile = await db.fasilitatorProfile.findUnique({
        where: { userId },
      });
    } else if (existingUser.role == Role.Admin) {
      profile = await db.user.findUnique({
        where: { id: userId },
      });
    } else if (existingUser.role == null) {
      return NextResponse.json(existingUser, { status: 200 });
    }

    if (!profile) {
      console.log("Existing role : " + existingUser.role);
      console.log("Profile not found : " + profile);
      return NextResponse.json({ error: "Profile not found" }, { status: 404 });
    }

    const filteredProfile = (() => {
      switch (existingUser.role) {
        case Role.Fasilitator:
          return { FasilitatorProfile: profile };
        case Role.Koas:
          return { KoasProfile: profile };
        case Role.Pasien:
          return { PasienProfile: profile };
        default:
          return { message: "No profile available for this role" };
      }
    })();

    const user = {
      ...existingUser,
      ...filteredProfile,
    };

    return NextResponse.json(user, { status: 200 });
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);
    }
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

  const {
    koasNumber,
    age,
    gender,
    departement,
    university,
    bio,
    whatsappLink,
    status,
  } = body;

  console.log("Received body", body);
  console.log("Received userId", userId);

  if (typeof age === "string") {
    body.age = parseInt(age, 10);
  }

  let profile;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    const existingUser = await getUserById(userId, undefined, {
      id: true,
      givenName: true,
      familyName: true,
      role: true,
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Get the existing profile from the database
    // let existingProfile;
    // if (existingUser.role === Role.Koas) {
    //   existingProfile = await db.koasProfile.findUnique({
    //     where: { userId },
    //   });
    // } else if (existingUser.role === Role.Pasien) {
    //   existingProfile = await db.pasienProfile.findUnique({
    //     where: { userId },
    //   });
    // }

    // Create the profile based on the user role
    if (existingUser.role === Role.Koas) {
      const existingKoas = await db.koasProfile.findUnique({
        where: { userId },
      });

      profile = await db.koasProfile.update({
        where: { userId },
        data: {
          koasNumber: koasNumber ?? existingKoas?.koasNumber,
          age: age ?? existingKoas?.age,
          gender: gender ?? existingKoas?.gender,
          departement: departement ?? existingKoas?.departement,
          university: university ?? existingKoas?.university, // Relasi ke universitas
          bio: bio ?? existingKoas?.bio,
          whatsappLink: whatsappLink ?? existingKoas?.whatsappLink,
          status: status ?? existingKoas?.status,
          user: { connect: { id: userId } },
        } as Prisma.KoasProfileUpdateInput,
      });

      // Send notification to Fasilitators with the same university
      // const fasilitators = await db.fasilitatorProfile.findMany({
      //   where: { university: profile.university },
      //   include: { user: true },
      // });

      // for (const fasilitator of fasilitators) {
      //   const newNotif = await db.notification.createMany({
      //     data: {
      //       senderId: existingUser!.id,
      //       userId: fasilitator.user.id,
      //       koasId: profile.id,
      //       title: "Koas Registration Pending Approval",
      //       message: `${existingUser.givenName} ${existingUser.familyName} has registered as Koas and is pending approval. Please review their profile.`,
      //       createdAt: new Date(),
      //     },
      //   });
      //   console.log("New notif for fasilitator:", newNotif);
      // }
    } else if (existingUser.role === Role.Pasien) {
      const existingPasien = await db.pasienProfile.findUnique({
        where: { userId },
      });

      profile = await db.pasienProfile.update({
        where: { userId },
        data: {
          age: age ?? existingPasien?.age,
          gender: gender ?? existingPasien?.gender,
          bio: bio ?? existingPasien?.bio,
          user: { connect: { id: userId } },
        } as Prisma.PasienProfileUpdateInput,
      });
    } else if (existingUser.role === Role.Fasilitator) {
      const existingFasilitator = await db.fasilitatorProfile.findUnique({
        where: { userId },
      });
      profile = await db.fasilitatorProfile.update({
        where: { userId },
        data: {
          university: university ?? existingFasilitator?.university,
          user: { connect: { id: userId } },
        } as Prisma.FasilitatorProfileUpdateInput,
      });
    } else {
      return NextResponse.json({ error: "Invalid user role" }, { status: 400 });
    }

    const user = {
      ...existingUser,
      profile,
    };

    return NextResponse.json(
      {
        status: "Success",
        message: "Profile updated successfully",
        data: { user },
      },
      { status: 201 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);
    }
  }
}

export async function DELETE(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = params.userId;
  let profile;

  const reset = searchParams.get("reset") === "true";

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    // Fetch the user to check the role
    const existingUser = await getUserById(userId, undefined, {
      id: true,
      role: true,
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    if (reset) {
      if (existingUser.role === Role.Koas) {
        profile = await db.koasProfile.update({
          where: { userId },
          data: {
            koasNumber: null,
            age: null,
            gender: null,
            departement: null,
            university: { disconnect: true },
            bio: null,
            whatsappLink: null,
            status: "Pending",
            createdAt: new Date(),
            updateAt: new Date(),
          } as Prisma.KoasProfileUpdateInput,
        });
      } else if (existingUser.role === Role.Pasien) {
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
      if (existingUser.role === Role.Koas) {
        profile = await db.koasProfile.delete({
          where: { userId },
        });
      } else if (existingUser.role === Role.Pasien) {
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

    const user = {
      ...existingUser,
      profile,
    };

    return NextResponse.json(
      {
        status: "Success",
        message: reset
          ? "Profile reset successfully"
          : "Profile delete successfully",
        data: { user },
      },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);
    }
  }
}

export async function POST(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
  const userId = params.userId;
  const body = await req.json();

  const {
    koasNumber,
    departement,
    bio,
    whatsappLink,
    university,
    age,
    gender,
  } = body;
  let profile;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    const existingUser = await getUserById(userId, undefined, {
      id: true,
      role: true,
    });

    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Create the profile based on the user role
    if (existingUser.role === Role.Koas) {
      profile = await db.koasProfile.create({
        data: {
          user: { connect: { id: userId } },
          koasNumber: koasNumber,
          age: age,
          gender: gender,
          departement: departement,
          university: university, // Relasi ke universitas
          bio: bio,
          whatsappLink: whatsappLink,
        } as Prisma.KoasProfileCreateInput,
      });
    } else if (existingUser.role === Role.Pasien) {
      profile = await db.pasienProfile.create({
        data: {
          user: { connect: { id: userId } },
          age: age,
          gender: gender,
          bio: bio,
        } as Prisma.PasienProfileCreateInput,
      });
    } else {
      return NextResponse.json({ error: "Invalid user role" }, { status: 400 });
    }

    const user = {
      ...existingUser,
      profile,
    };

    return NextResponse.json(
      {
        status: "Success",
        message: "Profile created successfully",
        data: { user },
      },
      { status: 201 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);
    }
  }
}
