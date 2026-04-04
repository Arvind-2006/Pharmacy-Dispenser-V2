package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.PatientAccountService;
import com.example.SoftwareProject.dto.PatientRegistrationDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/patients")
public class AdminPatientController {

    private final PatientAccountService patientAccountService;

    public AdminPatientController(PatientAccountService patientAccountService) {
        this.patientAccountService = patientAccountService;
    }

    @PostMapping
    public ResponseEntity<String> registerPatient(@Valid @RequestBody PatientRegistrationDTO dto) {
        patientAccountService.registerPatient(dto);
        return ResponseEntity.ok("Patient registered successfully.");
    }
}
