// Interface for user input validation
export interface UserInput {
    firstname: string;
    lastname: string;
    email: string;
    password: string;
    phone_number: string;
    role: string;
  }

// Response types for validation
export interface ValidationResult {
    isValid: boolean;
    error?: string;
  }