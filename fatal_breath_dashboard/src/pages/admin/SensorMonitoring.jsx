import React, { useState, useEffect } from 'react';

const SensorMonitoring = () => {
    const [sensors, setSensors] = useState([]);

    useEffect(() => {
        // Mock data - replace with API call
        const mockSensors = [
            { id: 1, name: 'Living Room CO Sensor', status: 'online', lastActivity: '2 minutes ago', currentReading: '15 ppm' },
            { id: 2, name: 'Kitchen CO Sensor', status: 'online', lastActivity: '5 minutes ago', currentReading: '8 ppm' },
            { id: 3, name: 'Bedroom CO Sensor', status: 'offline', lastActivity: '2 hours ago', currentReading: 'N/A' },
        ];
        setSensors(mockSensors);
    }, []);

    return (
        <div>
            <h3>Sensor Monitoring</h3>
            <table>
                <thead>
                    <tr>
                        <th>Sensor Name</th>
                        <th>Status</th>
                        <th>Last Activity</th>
                        <th>Current Reading</th>
                    </tr>
                </thead>
                <tbody>
                    {sensors.map(sensor => (
                        <tr key={sensor.id} className={sensor.status}>
                            <td>{sensor.name}</td>
                            <td>{sensor.status}</td>
                            <td>{sensor.lastActivity}</td>
                            <td>{sensor.currentReading}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default SensorMonitoring;