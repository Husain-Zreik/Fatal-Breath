import Magnet from '../../external/Magnet/Magnet';
import SmokeBackground from '../../animations/SmokeBackground';

const HeroSection = ({ onGetStarted }) => {
    return (
        <section id="home" className="hero-section light-blue-bg text-white py-5">
            <SmokeBackground particleCount={200} direction="up" />

            <div className="text-center" style={{ position: 'relative', zIndex: 2 }}>
                <Magnet padding={100} disabled={false} magnetStrength={100}>
                    <h1 className="display-1 mb-4">
                        <span className="fw-bold text-black">FATAL</span>{' '}
                        <span className="fw-light text-danger">BREATH</span>
                    </h1>
                </Magnet>
                <p className="lead mb-5 text-secondary">
                    Your Guardian Angel Against Toxic Gases
                </p>
                <button onClick={onGetStarted} className="btn btn-danger btn-lg me-2">
                    Get Started
                </button>
                <button className="btn btn-outline-light btn-lg">Learn More</button>
            </div>
        </section>
    );
};

export default HeroSection;
