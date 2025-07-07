import React, { useState, useEffect } from 'react';
import { Shield, Zap, Users, AlertTriangle, Wifi, Bell, Eye, Activity } from 'lucide-react';

const ProtectionSection = () => {
    const [isVisible, setIsVisible] = useState(false);
    const [gasLevel, setGasLevel] = useState(0);
    const [alertActive, setAlertActive] = useState(false);

    useEffect(() => {
        setIsVisible(true);
        // Simulate gas level monitoring
        const interval = setInterval(() => {
            const newLevel = Math.random() * 100;
            setGasLevel(newLevel);
            // setAlertActive(newLevel > 75);
        }, 2000);
        return () => clearInterval(interval);
    }, []);

    const features = [
        {
            icon: <Shield className="w-4 h-4" />,
            title: "Targeted Gas Detection",
            description: "Configured to detect carbon monoxide, methane, LPG, and more, based on your settings."
        },
        {
            icon: <Activity className="w-4 h-4" />,
            title: "Live Gas Level Monitoring",
            description: "Real-time tracking of gas concentration with live readings and history logging."
        },
        {
            icon: <AlertTriangle className="w-4 h-4" />,
            title: "Threshold Alert System",
            description: "Instant warnings when gas levels exceed safe thresholds, ensuring fast response."
        },
        {
            icon: <Users className="w-4 h-4" />,
            title: "Household-Wide Notifications",
            description: "Notifications sent to all registered members to assist anyone in danger."
        }
    ];

    return (
        <section id='protection' className="light-blue-bg py-5 px-3">

            <div className="container" >

                {/* How Fatal Breath Works Section */}
                <div className={`mb-5 ${isVisible ? 'animate__animated animate__fadeInUp animate__delay-2s' : ''}`}>
                    <div className="text-center mb-5">
                        <h2 className="section-title">
                            Explore the - <span style={{
                                background: 'linear-gradient(135deg, #e53e3e, #ff6b6b)',
                                WebkitBackgroundClip: 'text',
                                WebkitTextFillColor: 'transparent'
                            }}>Cycle</span>
                        </h2>
                        <p className="lead" style={{ color: '#4a5568', margin: '0 auto' }}>
                            From detection to rescue — complete gas safety in every breath.
                        </p>
                    </div>

                    <div className="row g-4">
                        {features.map((feature, index) => (
                            <div key={index} className="col-lg-3 col-md-6">
                                <div className="h-100 p-4 rounded-4 position-relative overflow-hidden" style={{
                                    backgroundColor: 'rgba(255, 255, 255, 0.7)',
                                    border: '1px solid rgba(229, 62, 62, 0.2)',
                                    backdropFilter: 'blur(10px)',
                                    transition: 'all 0.3s ease',
                                    cursor: 'pointer'
                                }}
                                    onMouseEnter={(e) => {
                                        e.currentTarget.style.transform = 'translateY(-5px)';
                                        e.currentTarget.style.boxShadow = '0 20px 40px rgba(229, 62, 62, 0.2)';
                                        e.currentTarget.style.borderColor = 'rgba(229, 62, 62, 0.4)';
                                    }}
                                    onMouseLeave={(e) => {
                                        e.currentTarget.style.transform = 'translateY(0)';
                                        e.currentTarget.style.boxShadow = 'none';
                                        e.currentTarget.style.borderColor = 'rgba(229, 62, 62, 0.2)';
                                    }}
                                >
                                    {/* Floating Icon Container */}
                                    <div className="text-center mb-4">
                                        <div className="d-inline-flex align-items-center justify-content-center rounded-3 p-3 mb-3" style={{
                                            background: 'linear-gradient(135deg, rgba(229, 62, 62, 0.2), rgba(255, 107, 107, 0.2))',
                                            border: '1px solid rgba(229, 62, 62, 0.3)',
                                            transition: 'transform 0.3s ease'
                                        }}>
                                            <div style={{ color: '#e53e3e' }}>
                                                {feature.icon}
                                            </div>
                                        </div>
                                    </div>

                                    {/* Content */}
                                    <div className="text-center">
                                        <h4 className="fw-bold mb-3" style={{ color: '#2d3748' }}>
                                            {feature.title}
                                        </h4>
                                        <p className="mb-0" style={{ color: '#4a5568', lineHeight: '1.6' }}>
                                            {feature.description}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Emergency Alert Simulation */}
                {alertActive && (
                    <div className="position-fixed top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center" style={{
                        backgroundColor: 'rgba(220, 53, 69, 0.9)',
                        backdropFilter: 'blur(5px)',
                        zIndex: 1050,
                        animation: 'pulse 2s infinite'
                    }}>
                        <div className="p-5 rounded-4 text-center mx-3" style={{
                            backgroundColor: '#dc3545',
                            border: '2px solid #c82333',
                            maxWidth: '400px'
                        }}>
                            <AlertTriangle className="text-white mb-3" size={64} style={{ animation: 'bounce 1s infinite' }} />
                            <h3 className="h2 fw-bold text-white mb-2">TOXIC GAS DETECTED!</h3>
                            <p className="text-white mb-4">Alert sent to all family members</p>
                            <div className="d-flex gap-3 justify-content-center">
                                <button
                                    onClick={() => setAlertActive(false)}
                                    className="btn btn-light px-4 py-2 fw-semibold"
                                >
                                    Acknowledge
                                </button>
                                <button className="btn btn-outline-light px-4 py-2 fw-semibold">
                                    Call 911
                                </button>
                            </div>
                        </div>
                    </div>
                )}

                {/* Live Monitoring Dashboard */}
                <div className={`mb-5 ${isVisible ? 'animate__animated animate__fadeInUp animate__delay-1s' : ''}`}>
                    <div className="p-4 rounded-4" style={{
                        backgroundColor: 'rgba(255, 255, 255, 0.6)',
                        border: '1px solid rgba(255, 255, 255, 0.3)',
                        backdropFilter: 'blur(10px)',
                        boxShadow: '0 20px 40px rgba(0, 0, 0, 0.1)'
                    }}>
                        <div className="d-flex justify-content-between align-items-center mb-4">
                            <h3 className="h4 fw-bold d-flex align-items-center gap-2 mb-0" style={{ color: '#2d3748' }}>
                                <div className={`rounded-circle ${alertActive ? 'bg-danger' : 'bg-success'}`} style={{
                                    width: '12px',
                                    height: '12px',
                                    animation: alertActive ? 'pulse 1s infinite' : 'none'
                                }}></div>
                                Live Monitoring
                            </h3>
                            <div className="d-flex align-items-center gap-2" style={{ color: '#4a5568' }}>
                                <Wifi size={20} />
                                <span className="fw-monospace">Connected</span>
                            </div>
                        </div>

                        <div className="row g-4">
                            <div className="col-md-4">
                                <div className="p-4 rounded-3" style={{
                                    background: 'linear-gradient(135deg, rgba(255, 255, 255, 0.8), rgba(227, 238, 255, 0.6))',
                                    border: '1px solid rgba(255, 255, 255, 0.4)'
                                }}>
                                    <div className="d-flex justify-content-between align-items-center mb-3">
                                        <span style={{ color: '#4a5568' }}>Gas Level</span>
                                        <Shield className={alertActive ? 'text-danger' : 'text-success'} size={24} />
                                    </div>
                                    <div className={`h2 fw-bold ${alertActive ? 'text-danger' : 'text-success'}`}>
                                        {gasLevel.toFixed(1)}%
                                    </div>
                                    <div className="progress mt-3" style={{ height: '8px' }}>
                                        <div
                                            className={`progress-bar ${alertActive ? 'bg-danger' : 'bg-success'}`}
                                            style={{
                                                width: `${gasLevel}%`,
                                                transition: 'width 0.5s ease'
                                            }}
                                        ></div>
                                    </div>
                                </div>
                            </div>

                            <div className="col-md-4">
                                <div className="p-4 rounded-3" style={{
                                    background: 'linear-gradient(135deg, rgba(227, 238, 255, 0.8), rgba(200, 217, 255, 0.6))',
                                    border: '1px solid rgba(43, 119, 230, 0.2)'
                                }}>
                                    <div className="d-flex justify-content-between align-items-center mb-3">
                                        <span style={{ color: '#4a5568' }}>Connected Devices</span>
                                        <Users className="text-primary" size={24} />
                                    </div>
                                    <div className="h2 fw-bold text-primary">4</div>
                                    <div className="small text-primary mt-1">Family Members</div>
                                </div>
                            </div>

                            <div className="col-md-4">
                                <div className="p-4 rounded-3" style={{
                                    background: 'linear-gradient(135deg, rgba(255, 227, 227, 0.8), rgba(255, 227, 227, 0.6))',
                                    border: '1px solid rgba(229, 62, 62, 0.2)'
                                }}>
                                    <div className="d-flex justify-content-between align-items-center mb-3">
                                        <span style={{ color: '#4a5568' }}>Status</span>
                                        <Zap className="text-warning" size={24} />
                                    </div>
                                    <div className={`h4 fw-bold ${alertActive ? 'text-danger' : 'text-success'}`}>
                                        {alertActive ? 'ALERT!' : 'Safe'}
                                    </div>
                                    <div className="small text-muted mt-1">
                                        {alertActive ? 'Emergency detected' : 'All systems normal'}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>

    );
};

export default ProtectionSection;