import React, { useEffect, useState } from 'react';
import { Home, Bed, AlertTriangle, Shield, Users, ArrowRightCircle } from 'lucide-react';
import { loadStat } from '../../../root/api';
import { useNavigate } from 'react-router-dom';

const OverviewPage = () => {
  const [stats, setStats] = useState({
    houses: 0,
    rooms: 0,
    unsafeRooms: 0,
    mediumRiskRooms: 0,
    activeMembers: 0,
    systemHealth: {
      inactiveSensors: 0,
      roomsWithoutSensors: 0
    },
  });

  const navigate = useNavigate();

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const response = await loadStat();
        setStats(response);
      } catch (error) {
        console.error('Failed to load stats:', error);
      }
    };

    fetchStats();
  }, []);

  // eslint-disable-next-line no-unused-vars
  const StatCard = ({ icon: Icon, title, value, subtitle, color }) => (
    <div className="card shadow-sm border-0 h-100">
      <div className="card-body d-flex flex-column justify-content-between gap-2">
        <div className="d-flex align-items-center gap-3 mb-2">
          <div className={`p-2 rounded-circle ${color} bg-opacity-25`}>
            <Icon className={`text-${color.replace('bg-', '')}`} size={24} />
          </div>
          <div>
            <h5 className="fw-bold mb-0">{value}</h5>
            <small className="text-muted small">{title}</small>
          </div>
        </div>
        {subtitle && (
          <p className="text-muted small mb-0 ms-1">{subtitle}</p>
        )}
      </div>
    </div>
  );


  return (
    <div className="container py-5">
      {/* Stats Grid */}
      <div className="row g-4 mb-4">
        <div className="col-12 col-sm-6 col-lg-3">
          <StatCard
            icon={Home}
            title="Connected Houses"
            value={stats.houses}
            subtitle="All systems operational"
            color="bg-primary"
          />
        </div>
        <div className="col-12 col-sm-6 col-lg-3">
          <StatCard
            icon={Bed}
            title="Monitored Rooms"
            value={stats.rooms}
            subtitle="Across all properties"
            color="bg-success"
          />
        </div>
        <div className="col-12 col-sm-6 col-lg-3">
          <StatCard
            icon={AlertTriangle}
            title="Medium Risk Rooms"
            value={stats.mediumRiskRooms}
            subtitle="Check conditions soon"
            color="bg-warning"
          />
        </div>
        <div className="col-12 col-sm-6 col-lg-3">
          <StatCard
            icon={Shield}
            title="Unsafe Rooms"
            value={stats.unsafeRooms}
            subtitle="Immediate attention"
            color="bg-danger"
          />
        </div>
      </div>


      {/* Lower Section: Health + Actions + Members */}
      <div className="row g-3 g-md-4 mb-4">
        <div className="col-12 col-md-6 col-lg-4">
          <div className="card h-100">
            <div className="card-body">
              <h5 className="card-title d-flex align-items-center mb-4">
                <Shield className="me-2 text-success" size={20} />
                System Health
              </h5>
              <div className="mb-4">
                <div className="d-flex justify-content-between small text-muted mb-1">
                  <span>Inactive Sensors</span>
                  <strong className="text-danger">{stats.systemHealth.inactiveSensors}</strong>
                </div>
                <div className="progress">
                  <div
                    className="progress-bar bg-danger"
                    style={{ width: `${stats.systemHealth.inactiveSensors > 0 ? 100 : 0}%` }}
                  />
                </div>
              </div>
              <div className="mb-4">
                <div className="d-flex justify-content-between small text-muted mb-1">
                  <span>Rooms Without Sensors</span>
                  <strong className="text-danger">{stats.systemHealth.roomsWithoutSensors}</strong>
                </div>
                <div className="progress">
                  <div
                    className="progress-bar bg-warning"
                    style={{ width: `${stats.systemHealth.roomsWithoutSensors > 0 ? 100 : 0}%` }}
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-12 col-md-6 col-lg-4">
          <div className="card h-100">
            <div className="card-body text-center">
              <h5 className="card-title d-flex align-items-center justify-content-center mb-4">
                <Users className="me-2 text-info" size={20} />
                Active Members
              </h5>
              <h2 className="text-info fw-bold display-6 mb-0">{stats.activeMembers}</h2>
              <p className="text-muted small">Currently active across your houses</p>
            </div>
          </div>
        </div>

        <div className="col-12 col-lg-4">
          <div className="card h-100">
            <div className="card-body">
              <h5 className="card-title mb-4">Quick Actions</h5>
              <div className="d-grid gap-2">
                <button
                  className="btn btn-outline-primary d-flex justify-content-between align-items-center"
                  onClick={() => navigate('/manager/houses')}
                >
                  Manage Houses <ArrowRightCircle size={16} />
                </button>
                <button
                  className="btn btn-outline-info d-flex justify-content-between align-items-center"
                  onClick={() => navigate('/manager/members')}
                >
                  Manage Members <ArrowRightCircle size={16} />
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
  );
};

export default OverviewPage;