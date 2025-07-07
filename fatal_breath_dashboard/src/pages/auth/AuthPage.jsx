import ParticlesBackground from "../../components/animations/ParticlesBackground";
import SmokeBackground from "../../components/animations/SmokeBackground";
import LoginForm from "../../components/auth/LoginForm";
import SignUpForm from "../../components/auth/SignUpForm";
import { useState } from "react";


export default function AuthPage() {
    const [showLogin, setShowLogin] = useState(true);

    const toggleForm = () => setShowLogin((prev) => !prev);

    return (
        <div className="auth-page">
            {/* <ParticlesBackground /> */}
            <SmokeBackground particleCount={300} direction="right" />

            <div className="branding-section">
                <div className="d-flex ">
                    <h1 className="branding-title">FATAL BREATH</h1>
                </div>
                <h2 className="branding-subtitle">Your Guardian Angel Against Toxic Gases!</h2>
                <p className="branding-text">Protect your family from the silent killer with FatalBreath.</p>
            </div>

            <div className="form-section">
                {showLogin ? (
                    <LoginForm onSwitch={toggleForm} />
                ) : (
                    <SignUpForm onSwitch={toggleForm} />
                )}
            </div>
        </div>
    );
}
