
const FeaturesTable = () => {
    const features = [
        { feature: 'Real-time CO Monitoring', description: 'Continuous tracking of carbon monoxide levels', benefit: 'Always know your air quality' },
        { feature: 'Instant Alerts', description: 'Immediate notifications when danger is detected', benefit: 'Quick response to emergencies' },
        { feature: 'Emergency Chat', description: 'Built-in communication for emergencies', benefit: 'Coordinate safety measures quickly' },
        { feature: 'Multi-Room Management', description: 'Monitor multiple rooms simultaneously', benefit: 'Whole-home protection' },
        { feature: 'User Management', description: 'Add/remove users with different access levels', benefit: 'Flexible household access' },
        { feature: 'Friendly UI', description: 'Intuitive, easy-to-use interface', benefit: 'Simple for all family members' },
    ];

    return (
        <section id="features" className="light-blue-bg py-5 " >
            <div className="container">
                <div className="text-center mb-5">
                    <h2 className="section-title">
                        Key <span style={{
                            background: 'linear-gradient(135deg, #e53e3e, #c53030)',
                            WebkitBackgroundClip: 'text',
                            WebkitTextFillColor: 'transparent'
                        }}>Features</span>
                    </h2>
                    <p className="lead" style={{ color: '#4a5568' }}>
                        Comprehensive protection against toxic gases
                    </p>
                </div>

                <div className="rounded-4 overflow-hidden shadow-sm" style={{
                    backgroundColor: 'rgba(255, 255, 255, 0.85)',
                    border: '1px solid rgba(229, 62, 62, 0.15)',
                    backdropFilter: 'blur(10px)'
                }}>
                    <div className="table-responsive">
                        <table className="table align-middle mb-0">
                            <thead style={{
                                background: 'linear-gradient(135deg, #e53e3e, #c53030)',
                                color: 'white',
                                borderBottom: 'none'
                            }}>
                                <tr>
                                    <th className="px-4 py-3">Feature</th>
                                    <th className="px-4 py-3">Description</th>
                                    <th className="px-4 py-3">Benefit</th>
                                </tr>
                            </thead>
                            <tbody>
                                {features.map(({ feature, description, benefit }, idx) => (
                                    <tr key={idx} style={{
                                        transition: 'background-color 0.2s ease'
                                    }}
                                        onMouseEnter={e => e.currentTarget.style.backgroundColor = 'rgba(255, 245, 245, 0.6)'}
                                        onMouseLeave={e => e.currentTarget.style.backgroundColor = 'transparent'}
                                    >
                                        <td className="px-4 py-3 fw-semibold" style={{ color: '#c53030' }}>{feature}</td>
                                        <td className="px-4 py-3 text-muted">{description}</td>
                                        <td className="px-4 py-3">
                                            <span className="badge rounded-pill px-3 py-2 fw-medium" style={{
                                                backgroundColor: 'rgba(229, 62, 62, 0.1)',
                                                color: '#e53e3e',
                                                border: '1px solid rgba(229, 62, 62, 0.2)'
                                            }}>
                                                {benefit}
                                            </span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                <div className="alert alert-danger mt-4 shadow-sm" style={{ borderRadius: '1rem' }}>
                    <p className="mb-0 fw-medium text-center">
                        Carbon monoxide is called the <strong>"silent killer"</strong> because it's colorless, odorless, and can be deadly before symptoms are noticed.
                    </p>
                </div>
            </div>
        </section>
    );
};

export default FeaturesTable;
