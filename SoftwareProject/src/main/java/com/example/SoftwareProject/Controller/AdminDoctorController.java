package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.AdminDashboardService;
import com.example.SoftwareProject.Service.DoctorService;
import com.example.SoftwareProject.dto.DoctorProfileDTO;
import com.example.SoftwareProject.dto.DoctorRegistrationDTO;
import com.example.SoftwareProject.model.Doctor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/doctors")
public class AdminDoctorController {
    @Autowired
    private final DoctorService doctorService;
    @Autowired
    public AdminDashboardService adminService;

    public AdminDoctorController(DoctorService doctorService) {
        this.doctorService = doctorService;
    }

    @PostMapping
    public ResponseEntity<DoctorProfileDTO> registerDoctor(
            @RequestBody DoctorRegistrationDTO request) {

        return ResponseEntity.ok(adminService.registerDoctor(request));
    }
    // Get All Doctors
    @GetMapping
    public List<Doctor> getAllDoctors() {
        return doctorService.getAllDoctors();
    }

    // Update Doctor
    @PutMapping("/{id}")
    public Doctor updateDoctor(@PathVariable Long id,
                               @RequestBody Doctor doctor) {
        return doctorService.updateDoctor(id, doctor);
    }

    // Delete Doctor
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable Long id) {
        doctorService.deleteDoctor(id);
    }
}
