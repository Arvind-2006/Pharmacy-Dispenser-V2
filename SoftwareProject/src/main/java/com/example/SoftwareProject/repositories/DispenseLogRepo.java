package com.example.SoftwareProject.repositories;

import com.example.SoftwareProject.model.DispenseLog;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface DispenseLogRepo extends JpaRepository<DispenseLog,Long> {
    long countByDispenseTimeBetween(LocalDateTime start,
                                    LocalDateTime end);

    List<DispenseLog> findByPatient_IdOrderByDispenseTimeDesc(Long patientId);
}
