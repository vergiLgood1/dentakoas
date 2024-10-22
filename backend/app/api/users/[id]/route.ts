import { NextResponse } from "next/server"
import { Prisma } from "@prisma/client"
import { getUserId, getPassword } from "@/helper/user_helper"

import db from "@/lib/db"
import bcrypt from "bcryptjs"

export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koasProfile: true, pasienProfile: true },
    })

    return NextResponse.json(user, { status: 200 })
  } catch (error) {
    console.error("Error fetching user", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

export async function PUT(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  const body = await req.json()
  const { firstname, lastname, email, password, phone, role } = body

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await getUserId(userId)

    const hash = await getPassword(password, user.password)

    const updatedUser = await db.users.update({
      where: { id: String(userId) },
      data: {
        firstname,
        lastname,
        email,
        password: hash,
        phone,
        role,
      } as Prisma.UsersUpdateInput,
    })

    return NextResponse.json(updatedUser, { status: 200 })
  } catch (error) {
    console.error("Error updating user", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

export async function PATCH(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  const body = await req.json()
  const { firstname, lastname, email, password, phone, role } = body

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koasProfile: true, pasienProfile: true },
    })

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 })
    }

    const hash = await getPassword(password, user.password)

    const updatedUser = await db.users.update({
      where: { id: String(userId) },
      data: {
        firstname: firstname || user.firstname,
        lastname: lastname || user.lastname,
        email: email || user.email,
        password: hash,
        phone: phone || user.phone,
        role: role || user.role
      } as Prisma.UsersUpdateInput,
    })

    return NextResponse.json(updatedUser, { status: 200 })
  } catch (error) {
    console.error("Error updating user", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    await getUserId(userId)

    await db.users.delete({
      where: { id: String(userId) },
    })

    return NextResponse.json(
      { message: "User deleted successfully" },
      { status: 200 }
    )
  } catch (error) {
    console.error("Error deleting user", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}
