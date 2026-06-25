package com.cinema.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinema.models.UserAuthentication;

@Repository
public interface AuthRepository extends JpaRepository<UserAuthentication, Long> {
    List<UserAuthentication> findByUserId(String userId);
}
