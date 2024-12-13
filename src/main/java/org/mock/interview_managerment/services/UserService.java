package org.mock.interview_managerment.services;

import org.mock.interview_managerment.dto.request.UserCreateDto;
import org.mock.interview_managerment.dto.response.UserDetailDto;
import org.mock.interview_managerment.dto.response.UserListDto;
import org.mock.interview_managerment.dto.response.UserUpdateDto;
import org.mock.interview_managerment.entities.User;

import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.enums.StatusUserEnum;
import org.mock.interview_managerment.mapper.UserMapper;
import org.mock.interview_managerment.repository.RoleRepository;
import org.mock.interview_managerment.repository.UserRepository;
import org.mock.interview_managerment.util.UserNameValid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final PasswordService passwordService;

    private final EmailService emailService;

    private final UserMapper userMapper;

    public UserService(UserRepository userRepository,
            PasswordService passwordService,
            EmailService emailService,
            UserMapper userMapper) {
        this.userRepository = userRepository;
        this.passwordService = passwordService;
        this.emailService = emailService;
        this.userMapper = userMapper;
    }

    public User handleSaveUser(UserCreateDto request) {
        // mapper entity
        User user = userMapper.toUser(request);

        // gen password
        String password = passwordService.autoGeneratePassword();
        String hashPasword = passwordService.encryptPassword(password);
        user.setPassword(hashPasword);

        user = userRepository.save(user);
        user.setUsername(UserNameValid.genUserName(user.getFullName(), user.getUserId()));

        // send password to email
        emailService.sendPasswordCreate(user.getEmail(), user.getUsername(), password);

        return userRepository.save(user);
    }

    public Page<UserListDto> handleGetAllUsers(Pageable pageable) {
        Page<User> userPage = userRepository.findAll(pageable);
        List<UserListDto> userListDtos = userPage.getContent().stream()
                .map(userMapper::toUserListDto)
                .collect(Collectors.toList());

        return new PageImpl<>(userListDtos, pageable, userPage.getTotalElements());
    }

    public UserDetailDto handleGetUserDetail(Long userId) {
        return userMapper.toUserDetailDto(userRepository.findById(userId).get());
    }

    public void toggleStatus(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            user.setStatus(user.getStatus().name().equals("ACTIVE") ? StatusUserEnum.INACTIVE : StatusUserEnum.ACTIVE);
            userRepository.save(user);
        }
    }

    public UserUpdateDto handleGetUserById(Long userId) {
        return userMapper.toUserUpdateDto(userRepository.findByUserId(userId));
    }

    public User handleUpdateUser(UserUpdateDto request) {
        Optional<User> existingUserOptional = userRepository.findById(request.getUserId());

        if (existingUserOptional.isEmpty()) {
            throw new RuntimeException("User not found");
        }

        User existingUser = existingUserOptional.get();
        User user = userMapper.toUser(request);
        user.setPassword(existingUser.getPassword());
        user.setUsername(existingUser.getUsername());
        return userRepository.save(user);
    }

    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public Page<UserListDto> handleSearchAndFilterUsers(String keyword, Long roleId, Pageable pageable) {
        Page<User> userPage = userRepository.searchAndFilterUsers(keyword, roleId, pageable);
        List<UserListDto> userListDtos = userPage.getContent().stream()
                .map(userMapper::toUserListDto)
                .collect(Collectors.toList());

        return new PageImpl<>(userListDtos, pageable, userPage.getTotalElements());
    }

    public List<User> getManagers() {
        return userRepository.findByRoleRoleName("MANAGER");
    }

    public List<User> getRecruiters() {
        return userRepository.findByRoleRoleName("RECRUITER");
    }

    public List<User> findByRoleforCandidate() {
        List<User> list = this.userRepository.findByRole_RoleId(1L);
        List<User> list2 = this.userRepository.findByRole_RoleId(2L);
        List<User> list3 = this.userRepository.findByRole_RoleId(3L);
        list.addAll(list2);
        list.addAll(list3);
        return list;
    }

    public boolean checkEmailExist(String email) {
        return userRepository.existsByEmail(email);
    }

    public User handleGetUserByEmail(String email) {

        return userRepository.findByEmail(email);
    }

    public void handleResetPassword(User user, String newPass) {

        user.setPassword(passwordService.encryptPassword(newPass));
        userRepository.save(user);
    }

    // Code van
    public List<User> getUsersByRoleName(String roleName) {
        return userRepository.findByRoleName(roleName);
    }

    public User getByUserId(long userId) {
        return userRepository.findByUserId(userId);
    }

    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            String username = userDetails.getUsername();
            Optional<User> ouser = getUserByUsername(username);
            User user = ouser.get();
            return user;
        }
        return null;
    }

    public String getCurrentUsername() {
        // Lấy thông tin người dùng từ SecurityContextHolder
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            return getRoleName(userDetails.getAuthorities().toString());
        }
        return null;
    }

    public String getCurrentUserRole() {
        // Lấy thông tin người dùng từ SecurityContextHolder
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            return userDetails.getUsername();
        }
        return null;
    }

    // "ADMIN", "RECRUITER", "INTERVIEWER", "MANAGER"
    public String getRoleName(String authority) {
        switch (authority) {
            case "[ROLE_INTERVIEWER]":
                return "interviewer";
            case "[ROLE_ADMIN]":
                return "admin";
            case "[ROLE_RECRUITER]":
                return "recruiter";
            case "[ROLE_MANAGER]":
                return "manager";

            default:
                return "Unknown role";
        }
    }

    public boolean isAdminOrManagerOrRecruiter() {
        String role = getCurrentUserRole();
        return "admin".equals(role) || "manager".equals(role) || "recruiter".equals(role);
    }
}
