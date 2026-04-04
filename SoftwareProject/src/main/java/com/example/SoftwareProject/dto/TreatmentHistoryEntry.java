package com.example.SoftwareProject.dto;

import java.time.LocalDateTime;

/**
 * Summary view of clinical history from the prescription table (no line items).
 */
public class TreatmentHistoryEntry {

    private Long prescriptionId;
    private LocalDateTime prescribedAt;
    private String diagnosis;
    private String status;
    private String patientName;

    public TreatmentHistoryEntry() {
    }

    public TreatmentHistoryEntry(Long prescriptionId, LocalDateTime prescribedAt,
                                 String diagnosis, String status, String patientName) {
        this.prescriptionId = prescriptionId;
        this.prescribedAt = prescribedAt;
        this.diagnosis = diagnosis;
        this.status = status;
        this.patientName = patientName;
    }

    public Long getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(Long prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public LocalDateTime getPrescribedAt() {
        return prescribedAt;
    }

    public void setPrescribedAt(LocalDateTime prescribedAt) {
        this.prescribedAt = prescribedAt;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
}
