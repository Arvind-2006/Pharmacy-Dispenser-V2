package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.PrescriptionService;
import com.example.SoftwareProject.dto.PrescriptionRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/doctor")
@RequiredArgsConstructor
public class DoctorPrescriptionController {

    private final PrescriptionService prescriptionService;

    @PostMapping("/prescriptions")
    public ResponseEntity<?> createPrescription(
            @RequestBody PrescriptionRequest request,
            @RequestBody String doctorUsername) {

        return ResponseEntity.ok(
                prescriptionService.createPrescription(request, doctorUsername)
        );


    }
}