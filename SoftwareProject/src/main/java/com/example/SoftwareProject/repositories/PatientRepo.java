package com.example.SoftwareProject.repositories;

import com.example.SoftwareProject.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PatientRepo extends JpaRepository<Patient,Long> {
   // Optional<Object> findByName(String patientName);

    Optional<Object> findByName(String patientName);
    //Optional<Object> findByUser(String patientName);
    Optional<Patient> findByUserUsername(String username);

    boolean existsByEmailIgnoreCase(String email);
}
