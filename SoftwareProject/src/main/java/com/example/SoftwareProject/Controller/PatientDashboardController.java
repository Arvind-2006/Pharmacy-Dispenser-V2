package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.PatientDashboardService;
import com.example.SoftwareProject.dto.PatientProfileDTO;
import com.example.SoftwareProject.dto.TreatmentHistoryEntry;
import com.example.SoftwareProject.model.DispenseLog;
import com.example.SoftwareProject.model.Prescription;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@PreAuthorize("hasRole('PATIENT')")
public class PatientDashboardController {

    private final PatientDashboardService patientDashboardService;

    public PatientDashboardController(PatientDashboardService patientDashboardService) {
        this.patientDashboardService = patientDashboardService;
    }

    @GetMapping("/patient/dashboard")
    public Map<String, String> patientDashboard(Authentication authentication) {
        return Map.of(
                "message", "Patient dashboard",
                "username", authentication.getName()
        );
    }

    @GetMapping("/patient/profile")
    public PatientProfileDTO profile(Authentication authentication) {
        return patientDashboardService.getProfile(authentication.getName());
    }

    /** Full prescriptions from the prescription table (including line items). */
    @GetMapping("/patient/prescriptions")
    public List<Prescription> prescriptions(Authentication authentication) {
        return patientDashboardService.getPrescriptions(authentication.getName());
    }

    /** Medical dispense events for this patient (status per log row). */
    @GetMapping("/patient/dispense-status")
    public List<DispenseLog> dispenseStatus(Authentication authentication) {
        return patientDashboardService.getDispenseStatus(authentication.getName());
    }

    /** Diagnosis / prescription timeline (treatment history). */
    @GetMapping("/patient/treatment-history")
    public List<TreatmentHistoryEntry> treatmentHistory(Authentication authentication) {
        return patientDashboardService.getTreatmentHistory(authentication.getName());
    }
}
