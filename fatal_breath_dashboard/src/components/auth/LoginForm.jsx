import { useState } from "react";
import { FaEnvelope, FaLock } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { Login } from "../../root/api";
import { showAlert } from "../../utils/Swal";

function LoginForm({ onSwitch }) {
  const navigate = useNavigate();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      await Login(username, password);

      navigate("/manager");
    } catch (error) {
      const errorMessage =
        error?.response?.data?.message
        || error.message
        || "Unexpected Error.";

      showAlert({
        title: "Login Failed",
        text: errorMessage,
        icon: "error",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="auth-form">
      <h1>Login</h1>

      <div className="input-box">
        <input
          id="username"
          type="email"
          value={username}
          placeholder="Email"
          onChange={(e) => setUsername(e.target.value)}
          required
        />
        <FaEnvelope className="icon" />
      </div>

      <div className="input-box">
        <input
          id="password"
          type="password"
          value={password}
          placeholder="Password"
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <FaLock className="icon" />
      </div>

      <button className="button" type="submit" disabled={loading}>
        {loading ? "Logging in..." : "Login"}
      </button>

      <div className="link">
        <p>
          Don't have an account?{" "}
          <a onClick={onSwitch}>
            Register
          </a>
        </p>
      </div>
    </form>
  );
}

export default LoginForm;
