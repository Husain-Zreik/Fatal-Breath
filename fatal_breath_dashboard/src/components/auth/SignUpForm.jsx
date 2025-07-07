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

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      await RegisterUser(name, username, email, password, '1');
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
          <a onClick={onSwitch}>
            Login
          </a>
        </p>
      </div>
    </form>
  );
};

export default SignUpForm;
