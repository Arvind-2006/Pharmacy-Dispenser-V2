package com.example.SoftwareProject.repositories;

import com.example.SoftwareProject.model.Prescription;
import com.example.SoftwareProject.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PrescriptionRepo extends JpaRepository<Prescription,Long> {
    List<Prescription> findByStatus(String pending);
    List<Prescription> findByDoctor(User doctor);


    // Find prescriptions by Patient ID so the patient can see their list at the machine
    List<Prescription> findByPatientIdAndStatus(Long patientId, String status);
}
