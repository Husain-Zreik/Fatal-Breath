import React from 'react'
import Image from "next/image";


function UserTypes() {
    return (
        <div className="bg-[#E3EEFF] " id='User-Types'>
        <div className="hero ">
            <div className="flex-1 pt-16 padding-x ">
                <h1 className="hero__title">
                User Types :
                </h1>
    
                <p className="hero__subtitle">
                <br/><b  className='font-bold'>1-Manager:</b>Managers are individuals who own houses and have the authority to create houses and rooms within the application. They can also invite people to join these houses.
                <br/>
                <br/><b className='font-bold'>2-Member:</b>  Members are individuals who are part of a house created by a manager. They have the capability to request membership and join houses managed by others.
                </p>
            </div>
            <div className="hero__image-container">
                <div className="hero__image">
                    <Image src="/members.png" alt="members" fill className="object-contain" />
                </div>
            </div>
        </div>
        </div>
    )
}

export default UserTypes