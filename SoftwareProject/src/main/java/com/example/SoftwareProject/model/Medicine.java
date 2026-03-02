package com.example.SoftwareProject.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "medicine")

@Getter
@Setter
public class Medicine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long medicineId;

    private String medicineName;
    private String description;
    private double price;           // Optional but realistic
    private String manufacturer;    // Optional but professional
}


