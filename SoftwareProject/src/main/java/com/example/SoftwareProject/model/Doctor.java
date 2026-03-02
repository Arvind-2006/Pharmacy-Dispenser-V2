package com.example.SoftwareProject.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String specialization;

    @Column(unique = true, nullable = false)
    private String email;

    private String phone;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Constructors
    public Doctor() {}
    public Doctor(String name, String specialization,
                  String email, String phone) {
        this.name = name;
        this.specialization = specialization;
        this.email = email;
        this.phone = phone;
    }
}
