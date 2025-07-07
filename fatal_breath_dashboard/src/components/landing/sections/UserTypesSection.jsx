
const cardBaseStyle = {
    backgroundColor: 'rgba(255, 255, 255, 0.8)',
    backdropFilter: 'blur(10px)',
    transition: 'all 0.4s ease',
    cursor: 'pointer',
};

const badgeStyle = (color) => ({
    backgroundColor: `rgba(${color}, 0.1)`,
    color: `rgb(${color})`,
    border: `1px solid rgba(${color}, 0.2)`,
});

const hoverEnter = (e, shadowColor) => {
    e.currentTarget.style.transform = 'translateY(-10px) scale(1.02)';
    e.currentTarget.style.boxShadow = `0 25px 50px rgba(${shadowColor}, 0.25)`;
    e.currentTarget.style.borderColor = `rgba(${shadowColor}, 0.4)`;
};

const hoverLeave = (e, borderColor) => {
    e.currentTarget.style.transform = 'translateY(0) scale(1)';
    e.currentTarget.style.boxShadow = 'none';
    e.currentTarget.style.borderColor = `rgba(${borderColor}, 0.2)`;
};

const UserTypesSection = () => {

    return (
        <section id="users" className="light-red-bg py-5 px-4 mb-5">

            <div className="container">
                <div className="text-center mb-5">
                    <h2 className="section-title">
                        User <span style={{
                            background: 'linear-gradient(135deg, #2b77e6, #4299e1)',
                            WebkitBackgroundClip: 'text',
                            WebkitTextFillColor: 'transparent'
                        }}>Types</span>
                    </h2>
                    <p className="lead" style={{ color: '#4a5568', margin: '0 auto' }}>
                        Fatal Breath offers different access levels for complete household protection
                    </p>
                </div>

                <div className="row g-4 justify-content-center">

                    {/* === Manager Card === */}
                    <div className="col-lg-5 col-md-6">
                        <div
                            className="h-100 rounded-4 overflow-hidden position-relative"
                            style={{ ...cardBaseStyle, border: '1px solid rgba(229, 62, 62, 0.2)' }}
                            onMouseEnter={(e) => hoverEnter(e, '229, 62, 62')}
                            onMouseLeave={(e) => hoverLeave(e, '229, 62, 62')}
                        >
                            <div className="position-relative overflow-hidden" style={{ height: '300px' }}>
                                <img
                                    // src="https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                                    src="assets/images/manager2.jpg"
                                    className="w-100 h-100 object-fit-cover"
                                    alt="Manager"
                                    style={{ transition: 'transform 0.4s ease' }}
                                    onMouseEnter={(e) => e.target.style.transform = 'scale(1.1)'}
                                    onMouseLeave={(e) => e.target.style.transform = 'scale(1)'}
                                />
                                <div className="position-absolute top-0 start-0 w-100 h-100"
                                    style={{ background: 'linear-gradient(135deg, rgba(229, 62, 62, 0.1), rgba(255, 227, 227, 0.2))' }}
                                />
                                <div className="position-absolute top-3 end-3">
                                    <span className="badge rounded-pill px-3 py-2 fw-semibold"
                                        style={{
                                            background: 'linear-gradient(135deg, #e53e3e, #c53030)',
                                            color: 'white',
                                            boxShadow: '0 5px 15px rgba(229, 62, 62, 0.4)'
                                        }}
                                    >
                                        Full Access
                                    </span>
                                </div>
                            </div>

                            <div className="p-4 text-center">
                                <h4 className="fw-bold mb-2" style={{ color: '#2d3748' }}>Manager</h4>
                                <p className="fw-medium" style={{ color: '#e53e3e', fontSize: '0.95rem' }}>
                                    Homeowner/Administrator
                                </p>
                                <p className="mb-4" style={{ color: '#4a5568', lineHeight: '1.6', fontSize: '0.95rem' }}>
                                    Managers can create houses and rooms within the app, invite others to join, and have full control over all safety settings and notifications.
                                </p>
                                <div className="d-flex flex-wrap gap-2 justify-content-center">
                                    {['Create Houses', 'Manage Rooms', 'Invite Members'].map((text) => (
                                        <span key={text} className="badge rounded-pill px-3 py-1" style={badgeStyle('229, 62, 62')}>
                                            {text}
                                        </span>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* === Member Card === */}
                    <div className="col-lg-5 col-md-6">
                        <div
                            className="h-100 rounded-4 overflow-hidden position-relative"
                            style={{ ...cardBaseStyle, border: '1px solid rgba(43, 119, 230, 0.2)' }}
                            onMouseEnter={(e) => hoverEnter(e, '43, 119, 230')}
                            onMouseLeave={(e) => hoverLeave(e, '43, 119, 230')}
                        >
                            <div className="position-relative overflow-hidden" style={{ height: '300px' }}>
                                <img
                                    // src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                                    src="assets/images/members2.jpg"
                                    className="w-100 h-100 object-fit-cover"
                                    alt="Member"
                                    style={{ transition: 'transform 0.4s ease' }}
                                    onMouseEnter={(e) => e.target.style.transform = 'scale(1.1)'}
                                    onMouseLeave={(e) => e.target.style.transform = 'scale(1)'}
                                />
                                <div className="position-absolute top-0 start-0 w-100 h-100"
                                    style={{ background: 'linear-gradient(135deg, rgba(43, 119, 230, 0.1), rgba(227, 238, 255, 0.2))' }}
                                />
                                <div className="position-absolute top-3 end-3">
                                    <span className="badge rounded-pill px-3 py-2 fw-semibold"
                                        style={{
                                            background: 'linear-gradient(135deg, #2b77e6, #1e5fb8)',
                                            color: 'white',
                                            boxShadow: '0 5px 15px rgba(43, 119, 230, 0.4)'
                                        }}
                                    >
                                        Monitoring Access
                                    </span>
                                </div>
                            </div>

                            <div className="p-4 text-center">
                                <h4 className="fw-bold mb-2" style={{ color: '#2d3748' }}>Member</h4>
                                <p className="fw-medium" style={{ color: '#2b77e6', fontSize: '0.95rem' }}>
                                    Family/Household Member
                                </p>
                                <p className="mb-4" style={{ color: '#4a5568', lineHeight: '1.6', fontSize: '0.95rem' }}>
                                    Members join houses created by Managers and have access to monitoring features, alerts, and emergency communication tools.
                                </p>
                                <div className="d-flex flex-wrap gap-2 justify-content-center">
                                    {['Join Houses', 'View Alerts', 'Emergency Tools'].map((text) => (
                                        <span key={text} className="badge rounded-pill px-3 py-1" style={badgeStyle('43, 119, 230')}>
                                            {text}
                                        </span>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

    );
};

export default UserTypesSection;
