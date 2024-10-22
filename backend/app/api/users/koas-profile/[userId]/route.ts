import { NextResponse } from "next/server"
import db from "@/lib/db"
import { Prisma } from "@prisma/client"

export async function GET(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("userId") || params.userId

  try {
    const user = await db.users.findUnique({
      where: {
        id: userId,
      },
      include: {
        koasProfile: true,
      },
    })

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 })
    }

    return NextResponse.json(user, { status: 200 })
  } catch (error) {
    console.error("Error fetching user profile:", error) // Log error
    return NextResponse.json(
      { error: "Error fetching user profile" },
      { status: 500 }
    )
  }
}

export async function POST(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("userId") || params.userId

  const body = await req.json()
  const { koasNumber, faculty, bio, whatsappLink } = body

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const koasProfile = await db.koasProfile.create({
      data: {
        koasNumber,
        faculty,
        bio,
        whatsappLink,
        user: { connect: { id: userId } },
      } as Prisma.KoasProfileCreateInput,
    })

    return NextResponse.json(koasProfile, { status: 201 })

  } catch (error) {
    console.error("Error creating KOAS profile:", error) // Log error
    return NextResponse.json(
      { error: "Error creating KOAS profile" },
      { status: 500 }
    )
  }
}

export async function PATCH(req: Request, {params}: {params: {userId: string}}) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("userId") || params.userId
  const body = await req.json()

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koasProfile: true },
    })

    if (!user || !user.koasProfile) {
      return NextResponse.json(
        { error: "KOAS profile not found" },
        { status: 404 }
      )
    }

    const updatedProfile = await db.koasProfile.update({
      where: { userId: String(userId) },
      data: {
        koasNumber: body.koasNumber || user.koasProfile.koasNumber,
        faculty: body.faculty || user.koasProfile.faculty,
        bio: body.bio || user.koasProfile.bio,
        whatsappLink: body.whatsappLink || user.koasProfile.whatsappLink, 
      } as Prisma.KoasProfileUpdateInput,
    })

    return NextResponse.json({message: "Koas profile update successfully"}, { status: 200 })

  } catch (error) {
    console.error("Error updating KOAS profile", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

export async function PUT(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.userId
  const body = await req.json()

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koasProfile: true },
    })

    if (!user || !user.koasProfile) {
      return NextResponse.json(
        { error: "KOAS profile not found" },
        { status: 404 }
      )
    }

    const updatedProfile = await db.koasProfile.update({
      where: { userId: String(userId) },
      data: {
        koasNumber: body.koasNumber,
        faculty: body.faculty,
        bio: body.bio,
        whatsappLink: body.whatsappLink,
      } as Prisma.KoasProfileUpdateInput,
    })

    return NextResponse.json(updatedProfile, { status: 200 })

  } catch (error) {
    console.error("Error updating user profile:", error) // Log error
    return NextResponse.json(
      { error: "Error updating user profile" },
      { status: 500 }
    )
  }
}

export async function DELETE(req: Request, { params }: { params: {userId: string} }) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("userId") || params.userId

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koasProfile: true },
    })

    if (!user || !user.koasProfile) {
      return NextResponse.json(
        { error: "KOAS profile not found" },
        { status: 404 }
      )
    }

    await db.koasProfile.delete({
      where: { userId: String(userId) },
    })

    return NextResponse.json({ message: "KOAS profile deleted" }, { status: 200 })

  } catch (error) {
    console.error("Error deleting KOAS profile:", error) // Log error
    return NextResponse.json(
      { error: "Error deleting KOAS profile" },
      { status: 500 }
    )
  }

}