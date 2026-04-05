package com.example.SoftwareProject.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "dispense_log")
public class DispenseLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "log_id")
    private Long logId;

    @ManyToOne
    @JoinColumn(name = "prescription_id")
    private Prescription prescription;

    @ManyToOne
    @JoinColumn(name = "medicine_id")
    private Medicine medicine;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    // WHO triggered the machine (The logged-in User)
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User dispensedBy;

    private int quantityDispensed;
    private LocalDateTime dispenseTime;
    private String status; // e.g., "SUCCESS", "MOTOR_JAM", "OUT_OF_STOCK"
}