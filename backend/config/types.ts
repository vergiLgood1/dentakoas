import { Gender, Role, StatusKoas, StatusPost } from "@/config/enum";
import { prismaModels } from "./const";

//  Type for authentication
export interface LoginResponse {
  id: string;
  accessToken?: string;
  expiredAt?: string;
  renewalToken?: string;
  user: {
    email: string;
  };
}

export interface TokenInfo {
  expiredAt: string;
  accessToken: string;
  refreshToken: string;
  user: {
    email: string;
  };
  error?: string;
}

export interface SessionInfo {
  accessToken: string;
  user: {
    email: string;
  };
  error?: string;
}

// Type for user
export interface User {
  id: string;
  givenName: string;
  familyName: string;
  name: string;
  email: string;
  password: string;
  phone: string;
  image?: string | null; // Optional field
  role: Role;
  koasProfile?: koasProfile | null; // Optional field
  PasienProfile?: PasienProfile | null; // Optional field
  createdAt: Date;
  updateAt: Date;
}

// Type for koasProfile
export interface koasProfile {
  id: string;
  userId: string;
  koasNumber?: string | null; // Optional field
  faculty?: string | null; // Optional field
  bio?: string | null; // Optional field
  whatsappLink?: string | null; // Optional field
  status: StatusKoas;
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

// Type for Post
export type Post = {
  id: string;
  userId: string;
  koasId: string;
  treatmentId: string;
  title: string;
  desc: string;
  patientRequirement?: string;
  status: StatusPost;
  published: boolean;
  createdAt: Date;
  updateAt: Date;
  koas?: koasProfile;
  user?: User;
  Like?: Like[];
};

// Type for Like
export type Like = {
  id: string;
  postId: string;
  userId: string;
  createdAt: Date;
  user?: User;
  Post?: Post;
};

// Type for Notification
export type Notification = {
  id: string;
  userId: string;
  message: string;
  isRead: boolean;
  createdAt: Date;
  user?: User;
};

// Type for TreatmentType
export type TreatmentType = {
  id: string;
  name: string;
  createdAt: Date;
  updateAt: Date;
};

// Interface for user input validation
export interface UserInput {
  givenName: string;
  familyName: string;
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

export type UserQueryString = {
  givenName?: string;
  familyName?: string;
  name?: string;
  email?: string;
  phone?: string;
  role?: string;
  createdAt?: string;
  updateAt?: string;
  koasProfile?: {
    [key: string]: string | undefined;
  };
  fasilitatorProfile?: {
    [key: string]: string | undefined;
  };
  pasienProfile?: {
    [key: string]: string | undefined;
  };
  [key: string]: string | undefined | { [key: string]: string | undefined };
};


export interface PostQueryString {
  userId?: string;
  koasId?: string;
  treatmentId?: string;
  title?: string;
  desc?: string;
  status?: string;
  published?: boolean;
  likes?: number;
  createdAt?: { gte: string; lte: string }; // Izinkan objek filter
  updatedAt?: { gte: string; lte: string }; // Izinkan objek filter
  [key: string]:
    | string
    | { gte: string; lte: string }
    | number
    | boolean
    | undefined;
}

export type TableName = keyof typeof prismaModels;