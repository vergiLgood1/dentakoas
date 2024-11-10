import { Gender, Role, StatusKoas, StatusPost } from "@/config/enum"

//  Type for authentication
export interface LoginResponse {
  id: string
  accessToken?: string
  expiredAt?: string
  renewalToken?: string
  user: {
    email: string
  }
}

export interface TokenInfo {
  expiredAt: string
  accessToken: string
  refreshToken: string
  user: {
    email: string
  }
  error?: string
}

export interface SessionInfo {
  accessToken: string
  user: {
    email: string
  }
  error?: string
}

// Type for Users
export interface User {
  id: string
  firstname: string
  lastname: string
  username: string
  email: string
  password: string
  phone: string
  img?: string | null // Optional field
  role: Role
  koasProfile?: KoasProfile | null // Optional field
  pasienProfile?: PasienProfile | null // Optional field
  createdAt: Date
  updateAt: Date
}

// Type for KoasProfile
export interface KoasProfile {
  id: string
  userId: string
  koasNumber?: string | null // Optional field
  faculty?: string | null // Optional field
  bio?: string | null // Optional field
  whatsappLink?: string | null // Optional field
  status: StatusKoas
  createdAt: Date
  updateAt: Date
}

// Type for PasienProfile
export interface PasienProfile {
  id: string
  userId: string
  age?: number | null // Optional field
  gender?: Gender | null // Optional field
  bio?: string | null // Optional field
  createdAt: Date
  updateAt: Date
}

// Type for Posts
export type Post = {
  id: string
  userId: string
  koasId: string
  treatmentId: string
  title: string
  desc: string
  patientRequirement?: string
  status: StatusPost
  published: boolean
  createdAt: Date
  updateAt: Date
  koas?: KoasProfile
  users?: User
  likes?: Like[]
}

// Type for Likes
export type Like = {
  id: string
  postId: string
  userId: string
  createdAt: Date
  user?: User
  posts?: Post
}

// Type for Notifications
export type Notification = {
  id: string
  userId: string
  message: string
  isRead: boolean
  createdAt: Date
  user?: User
}

// Type for TreatmentType
export type TreatmentType = {
  id: string
  name: string
  createdAt: Date
  updateAt: Date
}

// Interface for user input validation
export interface UserInput {
  firstname: string
  lastname: string
  email: string
  password: string
  phone_number: string
  role: string
}

// Response types for validation
export interface ValidationResult {
  isValid: boolean
  error?: string
}

export type UserQueryParams = {
  firstname?: string
  lastname?: string
  username?: string
  email?: string
  phone?: string
  role?: string
  createdAt?: string
  updateAt?: string
  [key: string]: string | undefined // Tambahkan tipe yang lebih spesifik
}
