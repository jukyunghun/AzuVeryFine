package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Depurative;

@Repository
public interface DepurativeRepository extends JpaRepository<Depurative, Integer>{

}
