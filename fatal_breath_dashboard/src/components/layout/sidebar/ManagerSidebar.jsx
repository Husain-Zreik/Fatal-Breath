import { useLocation, useNavigate, Link } from "react-router-dom";
import {
  AiFillDashboard,
  AiFillHome,
  AiOutlineUser,
} from "react-icons/ai";
import { FaEnvelopeOpenText } from "react-icons/fa";
import { LogOutIcon } from "lucide-react";

const ManagerSidebar = ({ isOpen, closeSidebar }) => {
  const location = useLocation();
  const navigate = useNavigate();

  const isActive = (path) => location.pathname.includes(path);

  const handleLinkClick = () => {
    if (window.innerWidth <= 768) {
      closeSidebar();
    }
  };

  const handleLogout = () => {
    localStorage.clear();
    navigate("/auth", { replace: true });
  };

  return (
    <aside className={`sidebar ${isOpen ? "open" : ""}`}>
      <h1 className="sidebar-logo">Fatal Breath</h1>

      <div className="sidebar-section">
        <nav className="sidebar-content">
          {/* Section: Dashboard */}
          <div className="sidebar-group">
            <h3>Dashboard</h3>
            <Link
              to="/manager"
              className={
                isActive("/manager") && location.pathname === "/manager"
                  ? "active"
                  : ""
              }
              onClick={handleLinkClick}
            >
              <AiFillDashboard className="icon" />
              Overview
            </Link>
          </div>

          {/* Section: Management */}
          <div className="sidebar-group">
            <h3>Manage</h3>
            <Link
              to="/manager/houses"
              className={isActive("/houses") ? "active" : ""}
              onClick={handleLinkClick}
            >
              <AiFillHome className="icon" />
              Houses
            </Link>

            <Link
              to="/manager/members"
              className={isActive("/members") ? "active" : ""}
              onClick={handleLinkClick}
            >
              <AiOutlineUser className="icon" />
              Members
            </Link>
          </div>

          {/* Section: Invitations */}
          <div className="sidebar-group">
            <h3>Connections</h3>
            <Link
              to="/manager/requests"
              className={isActive("/requests") ? "active" : ""}
              onClick={handleLinkClick}
            >
              <FaEnvelopeOpenText className="icon" />
              Requests
            </Link>
          </div>
        </nav>

        {/* Footer */}
        <div className="sidebar-footer">
          <button className="btn btn-outline-danger w-100 text-start d-flex align-items-center gap-2"
            onClick={handleLogout}>
            <LogOutIcon className="icon" />
            Logout
          </button>
        </div>
      </div>
    </aside>
  );
};

export default ManagerSidebar;
