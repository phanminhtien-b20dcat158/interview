package org.mock.interview_managerment.controller.admin;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.mock.interview_managerment.dto.request.UserCreateDto;
import org.mock.interview_managerment.dto.response.UserDetailDto;
import org.mock.interview_managerment.dto.response.UserListDto;
import org.mock.interview_managerment.dto.response.UserUpdateDto;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.*;
import org.mock.interview_managerment.repository.UserRepository;
import org.mock.interview_managerment.services.RoleService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@Controller
public class UserController {

    private final UserService userService;
    private final RoleService roleService;

    public UserController(UserService userService, RoleService roleService) {
        this.userService = userService;
        this.roleService = roleService;
    }

    @GetMapping("/user")
    public String getListUsersPage(
            @RequestParam(name = "page", defaultValue = "0") Integer page,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "roleId", required = false) Long roleId,
            Model model) {

        Pageable pageable = PageRequest.of(page, 5);
        Page<UserListDto> userPage = userService.handleSearchAndFilterUsers(keyword, roleId, pageable);

        model.addAttribute("listRole", roleService.handleGetAllRole());
        model.addAttribute("userPage", userPage);
        model.addAttribute("keyword", keyword);
        model.addAttribute("roleId", roleId);
        model.addAttribute("page", userPage.getNumber() + 1);
        model.addAttribute("pageSize", userPage.getTotalPages());

        return "user/list";
    }

    @GetMapping("/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new UserCreateDto());
        return "user/create";
    }

    @PostMapping("/user/create")
    public String createUser(@Valid @ModelAttribute("newUser") UserCreateDto request,
                             BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/create";
        }

        System.out.println(request);
        userService.handleSaveUser(request);
        return "redirect:/user";
    }

    @GetMapping("/user/detail/{userId}")
    public String getUserDetailPage(@PathVariable("userId") Long userId, Model model) {

        UserDetailDto userDetail = userService.handleGetUserDetail(userId);
        System.out.println(userDetail);
        model.addAttribute("userDetail", userDetail);
        return "user/detail";
    }

    @PostMapping("/user/update-status")
    public ResponseEntity<Void> updateStatus(@RequestBody Map<String, String> requestBody) {
        Long userId = Long.valueOf(requestBody.get("userId"));

        // Cập nhật trạng thái của người dùng
        userService.toggleStatus(userId);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/user/update/{userId}")
    public String getUserUpdatePage(@PathVariable("userId") Long userId, Model model) {

        UserUpdateDto userUpdateDto = userService.handleGetUserById(userId);
        System.out.println(userUpdateDto);

        model.addAttribute("user", userUpdateDto);
        return "user/update";
    }

    @PostMapping("/user/update")
    public String updateUser(@Valid @ModelAttribute("user") UserUpdateDto request,
                             BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/update";
        }

        userService.handleUpdateUser(request);
        return "redirect:/user";
    }

    @GetMapping("/login")
    public String getPageLogin() {
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("userId");
        return "redirect:/login?logout";
    }

}
