import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  try {
    const notifications = await db.notification.findMany({
      orderBy: { createdAt: "desc" },
      include: {
        sender: true,
        recipient: true,
      },
    });

    if (!notifications) {
      return NextResponse.json(
        { error: "Notifications not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        notifications,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching notifications:", error);
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
  try {
    const params = await props.params;
    const { searchParams } = new URL(req.url);
    const id = searchParams.get("id") || params.id;

    const body = await req.json();
    const { title, message, status } = body;

    const updatedNotification = await db.notification.update({
      where: { id },
      data: {
        title,
        message,
        status: status,
        updatedAt: new Date(),
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Notification updated successfully",
        data: updatedNotification,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating notification:", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
