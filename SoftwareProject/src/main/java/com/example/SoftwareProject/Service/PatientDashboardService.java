package com.example.SoftwareProject.Service;

import com.example.SoftwareProject.dto.PatientProfileDTO;
import com.example.SoftwareProject.dto.TreatmentHistoryEntry;
import com.example.SoftwareProject.model.DispenseLog;
import com.example.SoftwareProject.model.Patient;
import com.example.SoftwareProject.model.Prescription;
import com.example.SoftwareProject.repositories.DispenseLogRepo;
import com.example.SoftwareProject.repositories.PatientRepo;
import com.example.SoftwareProject.repositories.PrescriptionRepo;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PatientDashboardService {

    private final PatientRepo patientRepo;
    private final PrescriptionRepo prescriptionRepo;
    private final DispenseLogRepo dispenseLogRepo;

    public PatientDashboardService(PatientRepo patientRepo,
                                   PrescriptionRepo prescriptionRepo,
                                   DispenseLogRepo dispenseLogRepo) {
        this.patientRepo = patientRepo;
        this.prescriptionRepo = prescriptionRepo;
        this.dispenseLogRepo = dispenseLogRepo;
    }

    public Patient resolvePatientOrThrow(String username) {
        return patientRepo.findByUserUsername(username)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.FORBIDDEN,
                        "No patient profile is linked to this account"));
    }

    public PatientProfileDTO getProfile(String username) {
        Patient p = resolvePatientOrThrow(username);
        return new PatientProfileDTO(
                p.getName(), p.getAge(), p.getGender(),
                p.getEmail(), p.getPhone(), p.getAddress());
    }

    public List<Prescription> getPrescriptions(String username) {
        Patient p = resolvePatientOrThrow(username);
        return prescriptionRepo.findByPatient_IdOrderByPrescribedAtDesc(p.getId());
    }

    public List<DispenseLog> getDispenseStatus(String username) {
        Patient p = resolvePatientOrThrow(username);
        return dispenseLogRepo.findByPatient_IdOrderByDispenseTimeDesc(p.getId());
    }

    public List<TreatmentHistoryEntry> getTreatmentHistory(String username) {
        return getPrescriptions(username).stream()
                .map(pr -> new TreatmentHistoryEntry(
                        pr.getId(),
                        pr.getPrescribedAt(),
                        pr.getDiagnosis(),
                        pr.getStatus(),
                        pr.getPatientName()))
                .collect(Collectors.toList());
    }
}
