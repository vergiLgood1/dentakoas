import * as React from "react";

interface VerificationEmailTemplateProps {
  confirmLink: string;
}

export const VerificationEmailTemplate: React.FC<
  Readonly<VerificationEmailTemplateProps>
> = ({ confirmLink }) => (
  <div
    style={{
      fontFamily: "Arial, sans-serif",
      color: "#333",
      padding: "20px",
      backgroundColor: "#f4f4f4",
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
        border: "1px solid #ddd",
        borderRadius: "5px",
      }}
    >
      <tbody>
        <tr>
          <td
            style={{
              padding: "20px",
              textAlign: "center",
              backgroundColor: "#007BFF",
              color: "#fff",
              borderRadius: "5px 5px 0 0",
            }}
          >
            <h1>Email Verification</h1>
          </td>
        </tr>
        <tr>
          <td style={{ padding: "20px" }}>
            <p style={{ fontSize: "16px" }}>
              Thank you for signing up! Please confirm your email address by
              clicking the link below:
            </p>
            <p style={{ textAlign: "center", margin: "20px 0" }}>
              <a
                href={confirmLink}
                style={{
                  display: "inline-block",
                  padding: "10px 20px",
                  fontSize: "16px",
                  color: "#fff",
                  backgroundColor: "#007BFF",
                  textDecoration: "none",
                  borderRadius: "5px",
                }}
              >
                Confirm Email Address
              </a>
            </p>
            <p style={{ fontSize: "14px", color: "#666" }}>
              If the button above does not work, copy and paste the following
              link into your browser:
            </p>
            <p style={{ fontSize: "14px", color: "#007BFF" }}>{confirmLink}</p>
          </td>
        </tr>
        <tr>
          <td
            style={{
              padding: "20px",
              textAlign: "center",
              backgroundColor: "#f4f4f4",
              borderTop: "1px solid #ddd",
              fontSize: "14px",
            }}
          >
            <p>
              &copy; {new Date().getFullYear()} Your Company. All rights
              reserved.
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
);
