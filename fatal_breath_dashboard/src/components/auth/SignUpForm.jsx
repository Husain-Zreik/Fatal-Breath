import React, { useState } from "react";
import { FaUser, FaLock, FaEnvelope } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { RegisterUser } from "../../root/api";
import { showAlert } from "../../utils/Swal";

const SignUpForm = ({ onSwitch }) => {
  const navigate = useNavigate();

  const [name, setName] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  const validateRegistrationForm = ({ name, username, email, password }) => {
    if (!name || !username || !email || !password) {
      return { valid: false, message: "Please fill out all fields." };
    }

    if (name.length > 50) {
      return { valid: false, message: "Full Name must be 50 characters or less." };
    }

    if (username.length > 30) {
      return { valid: false, message: "Username must be 30 characters or less." };
    }

    if (/\s/.test(username)) {
      return { valid: false, message: "Username must be a single word with no spaces." };
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return { valid: false, message: "Please enter a valid email address." };
    }

    if (email.length > 100) {
      return { valid: false, message: "Email must be 100 characters or less." };
    }

    if (password.length < 6) {
      return { valid: false, message: "Password must be at least 6 characters long." };
    }

    if (password.length > 100) {
      return { valid: false, message: "Password must be 100 characters or less." };
    }

    return { valid: true };
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const { valid, message } = validateRegistrationForm({
      name,
      username,
      email,
      password,
    });

    if (!valid) {
      showAlert({
        title: "Validation Error",
        text: message,
        icon: "warning",
      });
      return;
    }

    setLoading(true);
    try {
      await RegisterUser(name, username, email, password, "1");
      navigate("/manager");
    } catch (error) {
      const errorMessage =
        error?.response?.data?.message || "Unexpected Error.";

      showAlert({
        title: "Registration Failed",
        text: errorMessage,
        icon: "error",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="auth-form">
      <h1 className="title">Create Account</h1>

      <div className="input-box">
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Full Name"
          maxLength={50}
          required
        />
        <FaUser className="icon" />
      </div>

      <div className="input-box">
        <input
          type="text"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          placeholder="Username"
          maxLength={30}
          required
        />
        <FaUser className="icon" />
      </div>

      <div className="input-box">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Email"
          maxLength={100}
          required
        />
        <FaEnvelope className="icon" />
      </div>

      <div className="input-box">
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Password"
          maxLength={100}
          required
        />
        <FaLock className="icon" />
      </div>

      <button className="button" type="submit" disabled={loading}>
        {loading ? "Registering..." : "Register"}
      </button>

      <div className="link">
        <p>
          Already have an account?{" "}
          <a onClick={onSwitch} style={{ cursor: "pointer" }}>
            Login
          </a>
        </p>
      </div>
    </form>
  );
};

export default SignUpForm;
