import * as React from "react";

interface OTPEmailTemplateProps {
  OTP: string;
}

export const OTPEmailTemplate: React.FC<Readonly<OTPEmailTemplateProps>> = ({ OTP }) => (
  <div
    style={{
      fontFamily: "Arial, sans-serif",
      color: "#333",
      padding: "20px",
      backgroundColor: "#f9f9f9",
    }}
  >
    <table
      align="center"
      width="100%"
      cellPadding="0"
      cellSpacing="0"
      style={{
        maxWidth: "600px",
        backgroundColor: "#ffffff",
        border: "1px solid #e0e0e0",
        borderRadius: "8px",
        overflow: "hidden",
      }}
    >
      <tbody>
        <tr>
          <td
            style={{
              backgroundColor: "#007BFF",
              color: "#ffffff",
              padding: "20px",
              textAlign: "center",
            }}
          >
            <h1 style={{ margin: 0, fontSize: "24px" }}>Your OTP Code</h1>
          </td>
        </tr>
        <tr>
          <td style={{ padding: "20px" }}>
            <p style={{ fontSize: "16px", marginBottom: "20px" }}>
              Use the following OTP to complete your verification process:
            </p>
            <p
              style={{
                fontSize: "24px",
                fontWeight: "bold",
                color: "#007BFF",
                textAlign: "center",
                margin: "20px 0",
              }}
            >
              {OTP}
            </p>
            <p style={{ fontSize: "14px", color: "#666" }}>
              This OTP is valid for the next 10 minutes. Please do not share it
              with anyone.
            </p>
          </td>
        </tr>
        <tr>
          <td
            style={{
              backgroundColor: "#f4f4f4",
              padding: "20px",
              textAlign: "center",
              fontSize: "14px",
              color: "#666",
            }}
          >
            <p>
              If you did not request this code, please ignore this email or
              contact support.
            </p>
            <p>
              &copy; {new Date().getFullYear()} Your Company. All rights reserved.
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
);
