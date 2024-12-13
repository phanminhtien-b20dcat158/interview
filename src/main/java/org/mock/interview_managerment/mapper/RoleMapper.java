package org.mock.interview_managerment.mapper;

import org.mock.interview_managerment.dto.response.RoleListDto;
import org.mock.interview_managerment.entities.Role;
import org.springframework.stereotype.Component;

@Component
public class RoleMapper {

    public RoleListDto toRoleListDto(Role role) {
        return RoleListDto.builder()
                .roleId(role.getRoleId())
                .roleName(role.getRoleName())
                .build();
    }
}
