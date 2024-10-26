
// Enum for User Role
export enum Role {
  Pasien = "Pasien",
  Koas = "Koas",
}

// Enum for Gender (if applicable)
export enum Gender {
  Male = "Male",
  Female = "Female",
}

// Type for KoasProfile
export interface KoasProfile {
  id: string;
  userId: string;
  koasNumber?: string | null; // Optional field
  faculty?: string | null; // Optional field
  bio?: string | null; // Optional field
  whatsappLink?: string | null; // Optional field
  createdAt: Date;
  updateAt: Date;
}

// Type for PasienProfile
export interface PasienProfile {
  id: string;
  userId: string;
  age?: number | null; // Optional field
  gender?: Gender | null; // Optional field
  bio?: string | null; // Optional field
  createdAt: Date;
  updateAt: Date;
}

// Type for Users
export interface User {
  id: string;
  firstname: string;
  lastname: string;
  username: string;
  email: string;
  password: string;
  phone: string;
  img?: string | null; // Optional field
  role: Role;
  koasProfile?: KoasProfile | null; // Optional field
  pasienProfile?: PasienProfile | null; // Optional field
  createdAt: Date;
  updateAt: Date;
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

