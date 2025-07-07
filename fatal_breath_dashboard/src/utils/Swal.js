import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";

const MySwal = withReactContent(Swal);

export const showAlert = ({ title, text, icon = "success", timer = 3000 }) => {
  return MySwal.fire({
    title,
    text,
    icon, // 'success' | 'error' | 'warning' | 'info' | 'question'
    timer,
    showConfirmButton: false,
    timerProgressBar: true,
    toast: true,
    position: "top-end",
  });
};
