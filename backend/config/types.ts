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
