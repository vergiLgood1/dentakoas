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
       include: {koas_profile: true, pasien_profile: true}
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

export async function PUT(req: Request, { params }: { params: { id: string } }) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  const body = await req.json()
  const { firstname, lastname, email, password, phone_number, role } = body

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
        phone_number,
        role,
      },
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

export async function PATCH(req: Request, { params }: { params: { id: string } }) {
  const { searchParams } = new URL(req.url)
  const userId = searchParams.get("id") || params.id

  const body = await req.json()
  const { firstname, lastname, email, password, phone_number, role } = body

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "User ID is required" },
        { status: 400 }
      )
    }

    const user = await db.users.findUnique({
      where: { id: String(userId) },
      include: { koas_profile: true, pasien_profile: true },
    })

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 })
    }

    const hash = await getPassword(password, user.password)

    let userUpdate: Prisma.UsersUpdateInput = {
      firstname: firstname || user.firstname,
      lastname: lastname || user.lastname,
      email: email || user.email,
      password: hash,
      phone_number: phone_number || user.phone_number,
      role: role || user.role,
    }

    if (user.role === "KOAS") {
      userUpdate.koas_profile = {
        upsert: {
          create: {
            nomor_koas: body.nomor_koas || user.koas_profile?.nomor_koas,
            faculty: body.faculty || user.koas_profile?.faculty,
            bio: body.bio || user.koas_profile?.bio,
            whatsapp_link:
              body.whatsapp_link || user.koas_profile?.whatsapp_link,
          },
          update: {
            nomor_koas: body.nomor_koas || user.koas_profile?.nomor_koas,
            faculty: body.faculty || user.koas_profile?.faculty,
            bio: body.bio || user.koas_profile?.bio,
            whatsapp_link:
              body.whatsapp_link || user.koas_profile?.whatsapp_link,
          },
        },
      }
    }

    if (user.role === "PASIEN") {
      userUpdate.pasien_profile = {
        upsert: {
          create: {
            name: body.nomor_pasien || user.pasien_profile?.name,
            age: body.age || user.pasien_profile?.age,
            gender: body.gender || user.pasien_profile?.gender,
          },
          update: {
            name: body.nomor_pasien || user.pasien_profile?.name,
            age: body.age || user.pasien_profile?.age,
            gender: body.gender || user.pasien_profile?.gender,
          },
        },
      }
    }

    const updatedUser = await db.users.update({
      where: { id: String(userId) },
      data: userUpdate,
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

export async function DELETE(req: Request, { params }: { params: { id: string } }) {
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
