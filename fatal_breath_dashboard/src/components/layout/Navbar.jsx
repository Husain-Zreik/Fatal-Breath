import { useLocation } from "react-router-dom";
import { RxHamburgerMenu } from "react-icons/rx";
import { IoMdClose } from "react-icons/io";
import { FaUserCircle } from "react-icons/fa";
import { localStorageAction } from "../../core/config/localstorage";

const Navbar = ({ isOpen, toggleSidebar }) => {
  const location = useLocation();
  const user = localStorageAction("user_data");

  const generateBreadcrumb = (path) => {
    const parts = path.split("/").filter(Boolean);

    if (parts.length <= 1) return "Dashboard";

    // Find if the path includes 'houses' followed by an ID or slug
    const houseIndex = parts.findIndex((p) => p === "houses");
    if (houseIndex !== -1 && parts.length > houseIndex + 1) {
      return "Houses > Details";
    }

    // Default case: build from the rest of the path
    return parts
      .slice(1)
      .map((part) =>
        part.charAt(0).toUpperCase() + part.slice(1).replace(/-/g, " ")
      )
      .join(" / ");
  };

  return (
    <nav className="manager-navbar px-4 py-3">
      <div className="d-flex align-items-center gap-3">
        <button
          className="sidebar-toggle btn btn-light d-md-none"
          onClick={toggleSidebar}
          aria-label={isOpen ? "Close sidebar" : "Open sidebar"}
        >
          {isOpen ? <IoMdClose size={20} /> : <RxHamburgerMenu size={20} />}
        </button>

        <h2 className="page-title mb-0 fs-4 fw-semibold text-muted">
          {generateBreadcrumb(location.pathname)}
        </h2>
      </div>

      <div className="navbar-profile">
        <span >{user?.name || "User"}</span>
        {user?.avatar ? (
          <img
            src={user.avatar}
            alt="Profile"
            className="rounded-circle"
          />
        ) : (
          <FaUserCircle size={36} className="text-muted" />
        )}
      </div>
    </nav>
  );
};

export default Navbar;
