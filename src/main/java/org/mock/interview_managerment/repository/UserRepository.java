package org.mock.interview_managerment.repository;

import org.mock.interview_managerment.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

//crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User eric);

    void deleteById(long id);

    List<User> findOneByEmail(String email);

    public Optional<User> findById(Long id);

    List<User> findAll();

    User findById(long id); // null

    public boolean existsByEmail(String email);

    public User findByEmail(String email);

    public User findByUserId(Long id);

    public Optional<User> findByUsername(String username);

    @Query("SELECT u FROM User u WHERE " +
            "(?1 IS NULL OR u.username LIKE %?1% OR " +
            "u.email LIKE %?1% OR " +
            "u.fullName LIKE %?1% OR " +
            "u.address LIKE %?1% OR " +
            "u.note LIKE %?1% OR " +
            "u.phoneNumber LIKE %?1% OR " +
            "u.role.roleName LIKE %?1%) AND " +
            "(?2 IS NULL OR u.role.roleId = ?2)")
    Page<User> searchAndFilterUsers(String keyword, Long roleId, Pageable pageable);

    @Query("SELECT u FROM User u WHERE u.role.roleName = 'MANAGER'")
    List<User> findByRoleRoleName(String roleName);

    List<User> findByRole_RoleId(Long roleId);


    @Query("SELECT u FROM User u WHERE u.role.roleName = :roleName")
    List<User> findByRoleName(String roleName);

    @Query("SELECT u FROM User u WHERE u.userId = :userId")
    User findByUserId(long userId);

}