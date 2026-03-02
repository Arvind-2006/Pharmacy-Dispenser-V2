package com.example.SoftwareProject.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name="prescription")
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String patientName;

    private String diagnosis;

    private LocalDateTime prescribedAt;

    //new
    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private User doctor;

    private String status = "ACTIVE";

    private LocalDate expiryDate;

    @OneToMany(mappedBy = "prescription", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<PrescriptionItem> items = new ArrayList<>();

    //NEW
    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;


}
