import React from 'react';
import { Link } from 'react-router-dom';

const AdminDashboard = () => {
  return (
    <div className="dashboard">
      <h2>Admin Dashboard</h2>
      <nav className="sidebar">
        <ul>
          <li><Link to="/admin/user-management">User Management</Link></li>
          <li><Link to="/admin/house-management">House & Room Management</Link></li>
          <li><Link to="/admin/sensor-monitoring">Sensor Monitoring</Link></li>
          <li><Link to="/admin/announcements">Announcements</Link></li>
          <li><Link to="/admin/analytics">Analytics</Link></li>
          <li><Link to="/admin/system-logs">System Logs</Link></li>
        </ul>
      </nav>
      <div className="dashboard-content">
        {/* Content will be rendered here based on route */}
      </div>
    </div>
  );
};

export default AdminDashboard;