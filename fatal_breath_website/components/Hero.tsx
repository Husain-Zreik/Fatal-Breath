"use client";

import Image from "next/image";
import { CustomButton } from ".";


const Hero = () => {
    const handleScroll = (direction: string) => {
    const nextSection = document.getElementById(direction);

    if (nextSection) {
        nextSection.scrollIntoView({ behavior: "smooth" });
    }
    };

    return (
    <div className="bg-[#E3EEFF] ">
    <div className="hero ">
        <div className="flex-1 pt-36 padding-x ">
            <h1 className="hero__title">
            Fatal Breath: <br/> Your Guardian Angel Against Toxic Gases!
            </h1>

            <p className="hero__subtitle">
            Protect your family from the silent killer with Fatal Breath.
            </p>

            <div className="flex justify-start flex-row items-center">
                <CustomButton
                    title="Features"
                    containerStyles="bg-primary-blue bg-[#1C246C] text-white rounded-full mt-10"
                    handleClick={()=>handleScroll("Features")}
                />
            </div>
        </div>
        <div className="hero__image-container">
            <div className="hero__image">
                <Image src="/hero.png" alt="hero" fill className="object-contain" />
            </div>
        </div>
    </div>
    </div>
    );
};

export default Hero;
