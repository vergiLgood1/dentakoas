import db from "@/lib/db";
import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  try {
    const universities = await db.university.findMany({
      orderBy: {
        name: "asc",
      },
      include: {
        _count: {
          select: {
            koasProfile: true,
          },
        },
      },
    });

    const formattedUniversities = universities.map((university) => ({
      id: university.id,
      name: university.name,
      alias: university.alias,
      location: university.location,
      latitude: university.latitude,
      longitude: university.longitude,
      image: university.image,
      koasCount: university._count.koasProfile,
      createdAt: university.createdAt,
      updatedAt: university.updateAt,
    }));

    return NextResponse.json(
      {
        universities: formattedUniversities,
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

export async function POST(
  req: Request,
) {
  const { body } = await req.json();
  const { name, alias, location } = body;

  if (!name || !alias) {
    return NextResponse.json(
      { error: "University name and alias is required" },
      { status: 400 }
    );
  }

  try {
    const university = await db.university.create({
      data: {
        name,
        alias,
        location,
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "University created successfully",
        data: { university },
      },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating university", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
