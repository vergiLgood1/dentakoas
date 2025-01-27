// Enum for User Role
export enum Role {
  Pasien = "Pasien",
  Koas = "Koas",
  Admin = "Admin",
  Fasilitator = "Fasilitator",
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
  Canceled = "Canceled",
  Rejected = "Rejected",
  Pending = "Pending",
  Confirmed = "Confirmed",
  Ongoing = "Ongoing",
  Completed = "Completed",
}
