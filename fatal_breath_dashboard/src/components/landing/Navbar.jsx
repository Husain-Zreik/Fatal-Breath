const Navbar = () => {
    const goToLogin = () => {
        window.location.href = "/auth"; // use navigate("/login") if using react-router-dom
    };

    return (
        <nav className="navbar navbar-expand-lg" id="navbar">
            <div className="container">
                <a className="navbar-brand" href="#home">
                    <img src="/fatalbreath.png" alt="Fatal Breath Logo" width="200" height="auto" />
                </a>

                <button
                    className="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                >
                    <span className="navbar-toggler-icon"></span>
                </button>

                <div className="collapse navbar-collapse" id="navbarNav">
                    <ul className="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li className="nav-item">
                            <a className="nav-link active" href="#home">Home</a>
                        </li>
                        <li className="nav-item">
                            <a className="nav-link" href="#about">About</a>
                        </li>
                        <li className="nav-item">
                            <a className="nav-link" href="#protection">Protection</a>
                        </li>
                        <li className="nav-item">
                            <a className="nav-link" href="#users">Users</a>
                        </li>
                        <li className="nav-item">
                            <a className="nav-link" href="#features">Features</a>
                        </li>
                    </ul>

                    <button onClick={goToLogin} className="btn btn-danger ms-lg-3 mt-2 mt-lg-0">
                        Login
                    </button>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
