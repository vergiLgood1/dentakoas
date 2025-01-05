import { getUserById } from "@/helpers/user";
import db from "@/lib/db";
import { NextResponse } from "next/server";

// GET: Fetch a facilitator profile by user ID, including the associated university
export async function GET(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.id;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  try {
    const profile = await db.fasilitatorProfile.findUnique({
      where: {
        userId: userId,
      },
    });

    if (!profile) {
      return NextResponse.json({ error: "Profile not found" }, { status: 404 });
    }

    return NextResponse.json(profile, { status: 200 });
  } catch (error) {
    console.error("Error fetching facilitator profile:", error);
    return NextResponse.json(
      { error: "Error fetching facilitator profile" },
      { status: 500 }
    );
  }
}

// PATCH: Update facilitator profile's university
export async function PATCH(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.id;

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 });
  }

  const body = await req.json();
  const { university } = body;

  const existingUser = await getUserById(userId, {
    FasilitatorProfile: true,
  });

  if (!existingUser) {
    return NextResponse.json({ error: "User not found" }, { status: 404 });
  }

  try {
    // Update the facilitator profile
    const updatedProfile = await db.fasilitatorProfile.update({
      where: { userId },
      data: {
        university: university,
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Profile updated successfully",
        data: updatedProfile,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating facilitator profile:", error);
    return NextResponse.json(
      { error: "Error updating facilitator profile" },
      { status: 500 }
    );
  }
}
