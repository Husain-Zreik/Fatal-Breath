"use client";

import Image from "next/image";

const Purpose = () => {

    return (
    <div className="bg-[#FFE3E3] " id="Purpose">
    <div className="hero ">

        <Image src="/alert.png" alt="alert" width={400} height={400} className="  object-contain" />

        <div className="flex-1 pt-24 padding-x mb-20">
            <h1 className="hero__title">
            Purpose
            </h1>

            <p className="hero__subtitle">
            “Fatal Breath” is an application built to reduce the death caused by the high amount of toxic gases such as CO in the house. 
            </p>

        </div>
    </div>
    </div>
    );
};

export default Purpose;
