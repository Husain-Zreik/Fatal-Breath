import React from 'react';

const Footer = () => {
    const handleSubmit = (e) => {
        e.preventDefault();
        // Add subscription logic here (e.g. API call)
        alert("Subscribed!");
    };

    return (
        <footer className="text-center bg-dark text-white py-4">
            <div className="container">
                <div className="row">
                    {/* Brand */}
                    <div className="col-md-4 mb-3">
                        <h5>Fatal Breath</h5>
                        <p>Your guardian angel against toxic gases</p>
                    </div>

                    {/* Quick Links */}
                    <div className="col-md-4 mb-3">
                        <h5>Quick Links</h5>
                        <ul className="list-unstyled">
                            <li><a href="#home" className="text-white">Home</a></li>
                            <li><a href="#about" className="text-white">About</a></li>
                            <li><a href="#features" className="text-white">Features</a></li>
                            <li><a href="#protection" className="text-white">Protection</a></li>
                        </ul>
                    </div>

                    {/* Newsletter */}
                    <div className="col-md-4 mb-3">
                        <h5>Newsletter</h5>
                        <form onSubmit={handleSubmit}>
                            <div className="input-group">
                                <input type="email" className="form-control" placeholder="Your Email" required />
                                <button className="btn btn-danger" type="submit">Subscribe</button>
                            </div>
                        </form>
                    </div>
                </div>

                <hr className="my-4 bg-light" />

                {/* Footer Bottom */}
                <p className="mb-0">
                    Fatal Breath © 2025 | All rights reserved.
                    <a href="#" className="text-white ms-2">Privacy Policy</a> |
                    <a href="#" className="text-white ms-2">Terms & Conditions</a>
                </p>
            </div>
        </footer>
    );
};

export default Footer;
