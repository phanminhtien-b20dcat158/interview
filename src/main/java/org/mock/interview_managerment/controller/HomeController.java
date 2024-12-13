package org.mock.interview_managerment.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/home")
    public String getHomePage(Model model) {
        getUserInfor(model);

        return "home"; // Điều hướng đến trang home
    }

    @GetMapping("/403")
    public String getAccessDeniedPage(Model model) {
        return "auth/pages-403";
    }


    public void getUserInfor(Model model) {
        // Lấy thông tin người dùng từ SecurityContextHolder
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            model.addAttribute("username", userDetails.getUsername());
            String roleName = getRoleName(userDetails.getAuthorities().toString());
            model.addAttribute("roleName", roleName);
            // Bạn có thể thêm các thông tin khác của user nếu cần
        } else {
            model.addAttribute("username", principal.toString());
        }
    }


    public String getRoleName(String authority) {
        switch(authority) {
            case "[ROLE_INTERVIEWER]":
                return "Interviewer";

            default:
                return "Unknown role";
        }
    }
}
