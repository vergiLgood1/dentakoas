import db from "@/lib/db";
import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  // const { searchParams } = new URL(req.url);
  // const query: UniversityQueryString = parseSearchParams(searchParams);

  try {
    const university = await db.university.findMany({
      // where: {
      //   ...query,
      // } as Prisma.UniversityWhereInput,
      orderBy: {
        name: "asc",
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "University retrived successfully",
        data: { university },
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
  props: { body: Promise<{ name: string }> }
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
