package org.mock.interview_managerment.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomePageController {

    @RequestMapping("/")
    public String homePage(HttpSession session) {
        // Kiểm tra trạng thái đăng nhập
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null) {
            isLoggedIn = false; // Giả định mặc định chưa đăng nhập
        } else {
            isLoggedIn = true;
        }
        session.setAttribute("isLoggedIn", isLoggedIn);
        return "home";
    }
}
