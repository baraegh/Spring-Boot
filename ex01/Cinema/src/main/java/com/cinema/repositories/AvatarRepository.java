package com.cinema.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinema.models.Avatar;

@Repository
public interface AvatarRepository extends JpaRepository<Avatar, Long> {
    public List<Avatar> findByUserIdAndFilmId(String userId, Long filmId);
}
