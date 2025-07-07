import Navbar from '../../components/landing/Navbar';
import Footer from '../../components/landing/Footer';

import HeroSection from '../../components/landing/sections/HeroSection';
import AboutSection from '../../components/landing/sections/AboutSection';
import ProtectionSection from '../../components/landing/sections/ProtectionSection';
import UserTypesSection from '../../components/landing/sections/UserTypesSection';
import StatsSection from '../../components/landing/sections/StatsSection';
import FeaturesTable from '../../components/landing/sections/FeaturesTable';

const LandingPage = () => {
    const goToLogin = () => {
        // example redirect or modal open
        window.location.href = '/auth';
    };

    return (
        <>
            <Navbar />
            <main>
                <HeroSection onGetStarted={goToLogin} />
                <AboutSection />
                <ProtectionSection />
                <UserTypesSection />
                <StatsSection />
                <FeaturesTable />
            </main>
            <Footer />
        </>
    );
};

export default LandingPage;
