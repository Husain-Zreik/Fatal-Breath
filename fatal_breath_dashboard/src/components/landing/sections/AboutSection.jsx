
const AboutSection = () => {
    return (
        <section id="about" className="py-5 px-2 light-red-bg text-dark">
            <div className="container">

                <div className="row align-items-center">
                    <div className="col-lg-6 mb-4 mb-lg-0 px-lg-4">

                        <h2 className="section-title">
                            Why Fatal Breath ?
                        </h2>

                        <p className="fs-5 text-secondary">
                            Fatal Breath is your smart shield against deadly gases like carbon monoxide—keeping your family safe through real-time alerts and intelligent detection before it’s too late.
                        </p>
                    </div>

                    <div className="col-lg-6">
                        {/* Carousel */}
                        <div
                            id="featuresCarousel"
                            className="carousel slide bg-white rounded shadow p-2"
                            data-bs-ride="carousel"
                        >
                            <div className="carousel-indicators">
                                <button type="button" data-bs-target="#featuresCarousel" data-bs-slide-to="0" className="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#featuresCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#featuresCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                            </div>
                            <div className="carousel-inner rounded">
                                <div className="carousel-item active">
                                    <img src="assets/images/alert.png" className="d-block w-100 rounded" alt="CO Detector" />
                                    <div className="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded px-3 py-2">
                                        <h5>Instant Alerts</h5>
                                    </div>
                                </div>
                                <div className="carousel-item">
                                    <img
                                        src="https://fatal-breath.vercel.app/_next/image?url=%2Fmembers.png&w=1920&q=75"
                                        className="d-block w-100 rounded"
                                        alt="Mobile App"
                                    />
                                    <div className="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded px-3 py-2">
                                        <h5>Family Safety</h5>
                                    </div>
                                </div>
                                <div className="carousel-item">
                                    <img
                                        src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
                                        alt="Family Protection"
                                        className="d-block w-100 rounded"
                                    />
                                    <div className="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded px-3 py-2">
                                        <h5>Real-time Monitoring</h5>
                                    </div>
                                </div>
                            </div>
                            <button className="carousel-control-prev" type="button" data-bs-target="#featuresCarousel" data-bs-slide="prev">
                                <span className="carousel-control-prev-icon custom-dark-icon" aria-hidden="true"></span>
                                <span className="visually-hidden">Previous</span>
                            </button>
                            <button className="carousel-control-next" type="button" data-bs-target="#featuresCarousel" data-bs-slide="next">
                                <span className="carousel-control-next-icon custom-dark-icon" aria-hidden="true"></span>
                                <span className="visually-hidden">Next</span>
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </section>
    );
};

export default AboutSection;
