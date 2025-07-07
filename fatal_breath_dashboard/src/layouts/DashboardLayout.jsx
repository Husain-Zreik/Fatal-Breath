import { useState, useEffect } from "react";
import { Outlet } from "react-router-dom";
import ManagerSidebar from "../components/layout/sidebar/ManagerSidebar";
import ManagerNavbar from "../components/layout/Navbar";

const DashboardLayout = () => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);

  const toggleSidebar = () => setIsSidebarOpen(!isSidebarOpen);
  const closeSidebar = () => setIsSidebarOpen(false);

  // Close sidebar when screen size changes to desktop
  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth > 768) {
        setIsSidebarOpen(false);
      }
    };

    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return (
    <div className="manager-container">
      <ManagerSidebar isOpen={isSidebarOpen} closeSidebar={closeSidebar} />

      {/* Mobile overlay */}
      {isSidebarOpen && <div className="overlay" onClick={closeSidebar}></div>}

      <main className="main-content">
        <ManagerNavbar isOpen={isSidebarOpen} toggleSidebar={toggleSidebar} />
        <div className="main-inner">
          <Outlet />
        </div>
      </main>
    </div>
  );
};

export default DashboardLayout;
