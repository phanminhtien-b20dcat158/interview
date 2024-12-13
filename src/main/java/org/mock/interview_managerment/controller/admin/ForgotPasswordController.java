package org.mock.interview_managerment.controller.admin;

import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.mock.interview_managerment.entities.PasswordResetToken;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.repository.UserRepository;
import org.mock.interview_managerment.services.EmailService;
import org.mock.interview_managerment.services.PasswordResetTokenService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.UUID;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final EmailService emailService;
    private final PasswordResetTokenService passwordResetTokenService;
    private final UserRepository userRepository;

    public ForgotPasswordController(UserService userService, EmailService sendEmailService, PasswordResetTokenService passwordResetTokenService, UserRepository userRepository) {
        this.userService = userService;
        this.emailService = sendEmailService;
        this.passwordResetTokenService = passwordResetTokenService;
        this.userRepository = userRepository;
    }

    @GetMapping("/forgot-password")
    public String getPageForgotPassword() {

        return "auth/forgot-password";
    }


    @GetMapping("/forgot-password/send-email")
    public String sendTokenToEmail(@RequestParam(name = "email") String email, RedirectAttributes redirectAttributes) {

        System.out.println("send-email");

        User user = userService.handleGetUserByEmail(email);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "No user found with this email address.");
            return "redirect:/forgot-password";
        }
        String token = UUID.randomUUID().toString();
        LocalDateTime expiryDate = LocalDateTime.now().plusHours(1);
        PasswordResetToken passwordResetToken = PasswordResetToken.builder()
                .user(user)
                .token(token)
                .expirationDate(expiryDate)
                .build();

        passwordResetTokenService.handleSavePasswordResetToken(passwordResetToken);


        String resetPasswordUrl = "http://localhost:8080/forgot-password/reset-password?token=" + token;

        emailService.sendPasswordResetEmail(email, resetPasswordUrl);
        return "auth/send-email-success";

    }

    @GetMapping("/forgot-password/reset-password")
    public String resetPassword(@RequestParam(name = "token") String token, RedirectAttributes redirectAttributes, Model model) {
        PasswordResetToken passwordResetToken = passwordResetTokenService.handleGetPasswordResetToken(token);

        if (passwordResetToken == null || passwordResetToken.getExpirationDate().isBefore(LocalDateTime.now())) {
            redirectAttributes.addFlashAttribute("error", "Invalid or expired token.");
            return "redirect:/forgot-password";
        }

        // Nếu token hợp lệ, hiển thị trang reset password
        model.addAttribute("token", token);
        return "auth/reset-password";
    }

    @PostMapping("/forgot-password/reset-password")
    public String processResetPassword(@RequestParam(name = "token") String token,
                                       @RequestParam(name = "password") String password,
                                       RedirectAttributes redirectAttributes,
                                       Model model) {

        PasswordResetToken passwordResetToken = passwordResetTokenService.handleGetPasswordResetToken(token);
        if (passwordResetToken == null || passwordResetToken.getExpirationDate().isBefore(LocalDateTime.now())) {
            redirectAttributes.addFlashAttribute("error", "Invalid or expired token.");
            return "redirect:/forgot-password";
        }

        User user = passwordResetToken.getUser();
        userService.handleResetPassword(user, password);

        passwordResetTokenService.handleDeleteToken(passwordResetToken);
        model.addAttribute("message", "Your password has been successfully reset.");
        System.out.println("Done reset password");
        return "redirect:/login";
    }
}
