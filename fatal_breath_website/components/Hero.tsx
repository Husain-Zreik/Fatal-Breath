"use client";

import Image from "next/image";
import CustomButton from "./CustomButton";


const Hero = () => {
    const handleScroll = () => {
    const nextSection = document.getElementById("discover");

    if (nextSection) {
        nextSection.scrollIntoView({ behavior: "smooth" });
    }
    };

    return (
    <div className="hero">
        <div className="flex-1 pt-36 padding-x">
            <h1 className="hero__title">
            Fatal Breath: {<br/>} Your Guardian Angel Against Toxic Gases!
            </h1>

            <p className="hero__subtitle">
            Protect your family from the silent killer with Fatal Breath.
            </p>

            <CustomButton
                title="Explore"
                containerStyles="bg-primary-blue text-white rounded-full mt-10"
                handleClick={handleScroll}
            />
        </div>
        <div className="hero__image-container">
            <div className="hero__image">
                <Image src="/hero.png" alt="hero" fill className="object-contain" />
            </div>
        </div>
    </div>
    );
};

export default Hero;
