// Cập nhật tên tệp khi chọn tệp
document.querySelector(".custom-file-input").addEventListener("change", function () {
    var fileName = this.value.split("\\").pop();
    this.nextElementSibling.classList.add("selected");
    this.nextElementSibling.innerHTML = fileName;
});

// Kiểm tra định dạng tệp khi gửi biểu mẫu
document.getElementById("uploadForm").addEventListener("submit", function (event) {
    var fileInput = document.getElementById("file");
    var file = fileInput.files[0];
    var allowedExtensions = /(\.xls|\.xlsx)$/i;

    if (!file) {
        return; // Nếu không có tệp được chọn, không thực hiện kiểm tra
    }

    if (!allowedExtensions.exec(file.name)) {
        event.preventDefault(); // Ngăn chặn việc gửi biểu mẫu
        document.getElementById("fileError").style.display = "block"; // Hiển thị thông báo lỗi
    } else {
        document.getElementById("fileError").style.display = "none"; // Ẩn thông báo lỗi
    }
});