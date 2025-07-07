import axios from "axios";
import { localStorageAction } from "./localstorage";

// axios.defaults.baseURL = "http://127.0.0.1:8000/api";
axios.defaults.baseURL = "http://142.93.100.2/api/api";

export const sendRequest = async ({
  method = "GET",
  route,
  body,
  includeHeaders = true,
  isMultipart = false,
}) => {
  if (!route) throw Error("URL required");

  axios.defaults.headers.authorization = includeHeaders
    ? `Bearer ${localStorageAction("access_token")}`
    : "";

  try {
    let config = {
      method,
      url: route,
      data: body,
    };

    if (isMultipart) {
      config = {
        ...config,
        headers: {
          ...config.headers,
          "Content-Type": "multipart/form-data",
        },
      };
    }

    const response = await axios.request(config);

    return response.data;
  } catch (error) {
    // Handle unauthorized error
    if (
      error.response &&
      error.response.status === 401 &&
      window.location.pathname !== "/auth"
    ) {
      window.location.href = "/auth";
    }
    // Re-throw other errors
    throw error;
  }
};
