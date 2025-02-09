import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(req: Request, { id }: { id: string }) {
  try {
    const university = await db.university.findUnique({
      where: {
        id: id,
      },
      include: {
        koasProfile: true,
      },
    });

    if (!university) {
      return NextResponse.json(
        { error: "University not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        university,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching university", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function PATCH(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  const body = await req.json();
  const { name, alias, location, image } = body;

  try {
    if (!id) {
      return NextResponse.json(
        { error: "University id is required" },
        { status: 400 }
      );
    }

    const existingUniversity = await db.university.findUnique({
      where: { id },
    });

    if (!existingUniversity) {
      return NextResponse.json(
        { error: "University not found" },
        { status: 404 }
      );
    }

    const university = await db.university.update({
      where: { id },
      data: {
        name,
        alias,
        location,
        image,
      },
    });

    return NextResponse.json(
      {
        university,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating university", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
