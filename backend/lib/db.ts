// src/lib/prisma.ts
import { PrismaClient } from "@prisma/client"
import { withOptimize } from "@prisma/extension-optimize"

declare global {
  var db: PrismaClient | undefined
}

const db: PrismaClient =
  global.globalThis.db ||
  new PrismaClient().$extends(
    withOptimize({ apiKey: process.env.OPTIMIZE_API_KEY || '' })
  ) as PrismaClient
  
if (process.env.NODE_ENV !== "production") globalThis.db = db

export default db
