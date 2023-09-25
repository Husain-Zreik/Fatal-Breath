import { features } from "@/constants";
import Image from "next/image";

const Features = () => {
    return (
        <div className="bg-[#FFE3E3] md:h-screen" id="Features">
            <div className="hero h-full flex flex-col justify-center items-center">
                <div>
                <Image src="/icons.png" alt="alert" width={400} height={400} className="object-contain" />
                <Image src="/devs.png" alt="alert" width={400} height={400} className="object-contain" />

                </div>

                <div className="flex-1 padding-x">
                    <h1 className="hero__title mb-16">Features:</h1>

                    <div className="flex flex-wrap justify-center sm:items-center gap-3 mb-10">
                        {features.map((feature, index) => (
                            <div key={index} className="bg-white rounded-lg shadow-md p-4 w-72">
                                <h2 className="text-xl font-bold mb-2">{feature.title}</h2>
                                <p className="text-sm">{feature.description}</p>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Features;
