import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  try {
    if (!id) {
      return NextResponse.json(
        { error: "review Id is required" },
        { status: 400 }
      );
    }

    const review = await db.review.findUnique({
      where: { id: id },
      include: {
        user: true,
        KoasProfile: {
          include: {
            user: true,
          },
        },
        post: true,
      },
    });

    if (!review) {
      return NextResponse.json({ error: "Review not found" }, { status: 404 });
    }

    return NextResponse.json(
      {
        ...review,
      },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to fetch review:", error);

      return NextResponse.json(
        { error: "Internal Server Error" },
        { status: 500 }
      );
    }
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

  try {
    if (!id) {
      return NextResponse.json(
        { error: "review Id is required" },
        { status: 400 }
      );
    }

    const review = await db.review.update({
      where: { id: id },
      data: {
        ...body,
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Review updated successfully",
        data: review,
      },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to update review:", error);

      return NextResponse.json(
        { error: "Internal Server Error" },
        { status: 500 }
      );
    }
  }
}

export async function PUT(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;
  const body = await req.json();

  try {
    if (!id) {
      return NextResponse.json(
        { error: "review Id is required" },
        { status: 400 }
      );
    }

    const review = await db.review.update({
      where: { id: id },
      data: {
        ...body,
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Update review successfully",
        data: review,
      },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);

      return NextResponse.json(
        { error: "Internal Server Error" },
        { status: 500 }
      );
    }
  }
}

export async function DELETE(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  try {
    if (!id) {
      return NextResponse.json(
        { error: "review Id is required" },
        { status: 400 }
      );
    }

    await db.review.delete({
      where: { id: id },
    });

    return NextResponse.json(
      { message: "Review deleted successfully" },
      { status: 200 }
    );
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.stack);
      console.error("Failed to create content interaction:", error);

      return NextResponse.json(
        { error: "Internal Server Error" },
        { status: 500 }
      );
    }
  }
}
