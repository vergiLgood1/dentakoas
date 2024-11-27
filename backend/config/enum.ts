// Enum for User Role
export enum Role {
  Pasien = "Pasien",
  Koas = "Koas",
  Admin = "Admin",
}

// Enum for Gender (if applicable)
export enum Gender {
  Male = "Male",
  Female = "Female",
}

export enum StatusPost {
  Pending = "Pending",
  Open = "Open",
  Closed = "Closed",
}

export enum StatusKoas {
  Rejected = "Rejected",
  Pending = "Pending",
  Approved = "Approved",
}

export enum StatusAppointment {
  Waiting = "Waiting",
  Ongoing = "Ongoing",
  Completed = "Completed",
}
