package com.mtb.user.repository;
import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import com.mtb.user.model.User;
@Transactional
public interface UserRepository extends JpaRepository<User, Integer>{
   User findByUserEmail(String userEmail);
   User findByUserName(String username);
   @Modifying
   @Query("update User user set user.userPassword=?2 where user.userEmail=?1")
   int updatePassword(String userEmail, String userPaswword);
   @Modifying
   @Query("update User user set user.userRole='theatreOwner' where user.userId=?1")
   int updateRole(int userId);
   @Modifying
   @Query("update User user set user.userRole='user' where user.userId=?1")
   int updateRoleToUser(int userId);

}