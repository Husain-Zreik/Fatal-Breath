import React from 'react';

const StatsSection = () => {
    const stats = [
        { value: '24/7', label: 'Protection' },
        { value: '0.5s', label: 'Alert Response Time' },
        { value: '99.9%', label: 'Detection Accuracy' },
        { value: '∞', label: 'Peace of Mind' },
    ];

    return (
        <section className="py-5">
            <div className="container">
                <div className="row text-center">
                    {stats.map(({ value, label }, idx) => (
                        <div className="col-md-3 col-sm-6 mb-4" key={idx}>
                            <h2 className="display-4">{value}</h2>
                            <p>{label}</p>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
};

export default StatsSection;
