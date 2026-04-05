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
    @Column(name = "medicine_id")
    private Long medicineId;

    @Column(name = "medicine_name")
    private String medicineName;
    
    @Column(name = "description")
    private String description;
    
    @Column(name = "price")
    private double price;           // Optional but realistic
    
    @Column(name = "manufacturer")
    private String manufacturer;    // Optional but professional
}


