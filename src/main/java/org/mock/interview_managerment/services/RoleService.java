package org.mock.interview_managerment.services;

import org.mock.interview_managerment.dto.response.RoleListDto;
import org.mock.interview_managerment.mapper.RoleMapper;
import org.mock.interview_managerment.repository.RoleRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class RoleService {

    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;

    public RoleService(RoleRepository roleRepository, RoleMapper roleMapper) {
        this.roleRepository = roleRepository;
        this.roleMapper = roleMapper;
    }

    public List<RoleListDto> handleGetAllRole() {
        return roleRepository.findAll().stream()
                .map(roleMapper::toRoleListDto)
                .collect(Collectors.toList());
    }
}
