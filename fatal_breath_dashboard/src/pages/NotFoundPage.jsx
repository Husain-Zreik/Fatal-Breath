import { Link } from "react-router-dom";

const NotFoundPage = () => {
    return (
        <div className="min-vh-100 d-flex flex-column justify-content-center align-items-center text-center">
            <h1 className="display-4">404 - Page Not Found</h1>
            <p className="lead">Sorry, the page you’re looking for doesn’t exist.</p>
            <Link to="/" className="btn btn-danger mt-3">
                Back to Home
            </Link>
        </div>
    );
};

export default NotFoundPage;
