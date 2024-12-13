package org.mock.interview_managerment.mapper;

import org.mock.interview_managerment.dto.request.UserCreateDto;
import org.mock.interview_managerment.dto.response.UserDetailDto;
import org.mock.interview_managerment.dto.response.UserListDto;
import org.mock.interview_managerment.dto.response.UserUpdateDto;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.repository.RoleRepository;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    private final RoleRepository roleRepository;

    public UserMapper(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public User toUser(UserCreateDto request) {
        User user = User.builder()
                .fullName(request.getFullName())
                .email(request.getEmail())
                .dob(request.getDob())
                .address(request.getAddress())
                .phoneNumber(request.getPhoneNumber())
                .gender(request.getGender())
                .role(roleRepository.findByRoleName(request.getRole().getRoleName()))
                .department(request.getDepartment())
                .status(request.getStatus())
                .note(request.getNote())
                .build();

        return user;
    }

    public UserListDto toUserListDto(User response) {
        return UserListDto.builder()
                .userId(response.getUserId())
                .username(response.getUsername())
                .email(response.getEmail())
                .phoneNumber(response.getPhoneNumber())
                .role(response.getRole().getRoleName())
                .status(response.getStatus().name())
                .build();
    }

    public UserDetailDto toUserDetailDto(User response) {
        return UserDetailDto.builder()
                .userId(response.getUserId())
                .fullName(response.getFullName())
                .dob(response.getDob())
                .phoneNumber(response.getPhoneNumber())
                .role(response.getRole().getRoleName())
                .status(response.getStatus().name())
                .email(response.getEmail())
                .address(response.getAddress())
                .gender(response.getGender().name())
                .department(response.getDepartment().name())
                .note(response.getNote())
                .build();
    }

    public UserUpdateDto toUserUpdateDto(User response) {
        return UserUpdateDto.builder()
                .userId(response.getUserId())
                .fullName(response.getFullName())
                .dob(response.getDob())
                .phoneNumber(response.getPhoneNumber())
                .role(response.getRole())
                .status(response.getStatus())
                .email(response.getEmail())
                .address(response.getAddress())
                .gender(response.getGender())
                .department(response.getDepartment())
                .note(response.getNote())
                .build();
    }

    public User toUser(UserUpdateDto request) {
        return User.builder()
                .userId(request.getUserId())
                .fullName(request.getFullName())
                .email(request.getEmail())
                .dob(request.getDob())
                .address(request.getAddress())
                .phoneNumber(request.getPhoneNumber())
                .gender(request.getGender())
                .role(roleRepository.findByRoleName(request.getRole().getRoleName()))
                .department(request.getDepartment())
                .status(request.getStatus())
                .note(request.getNote())
                .build();
    }
}
