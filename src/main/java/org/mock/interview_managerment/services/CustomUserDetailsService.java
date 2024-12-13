package org.mock.interview_managerment.services;


import org.mock.interview_managerment.entities.User;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Collections;
import java.util.Optional;

public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userService.getUserByUsername(username);

        User userx = user.orElseThrow(() -> new UsernameNotFoundException(username));

        boolean enabled = userx.getStatus().name().equals("ACTIVE");

        boolean accountNonExpired = true; // Giả sử tài khoản không hết hạn
        boolean credentialsNonExpired = true; // Giả sử thông tin xác thực không hết hạn
        boolean accountNonLocked = true; // Giả sử tài khoản không bị khóa

        return new org.springframework.security.core.userdetails.User(
                userx.getUsername(),
                userx.getPassword(),
                enabled,
                accountNonExpired,
                credentialsNonExpired,
                accountNonLocked,
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + userx.getRole().getRoleName()))
        );
    }
}
