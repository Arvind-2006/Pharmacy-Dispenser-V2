package com.example.SoftwareProject.Service;

import com.example.SoftwareProject.dto.ItemRequest;
import com.example.SoftwareProject.dto.PrescriptionRequest;
import com.example.SoftwareProject.model.*;
import com.example.SoftwareProject.repositories.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class PrescriptionService {

    @Autowired
    private PrescriptionRepo prescriptionRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DoctorRepo doctorRepository;

    @Autowired
    private PatientRepo patientRepository;

    @Autowired
    private MedicineRepo medicineRepository;

    @Autowired
    private PrescriptionItemRepo prescriptionItemRepository;


    @Autowired
    private PatientRepo patientRepo; // You need this!

    @Transactional
    public Prescription createPrescription(PrescriptionRequest request, String username) {
        // 1. Find the Doctor (the User account)
        User doctorUser = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        // 2. Find the Patient by Name (Since you inserted them manually)
        Patient patient = (Patient) patientRepo.findByName(request.getPatientName())
                .orElseThrow(() -> new RuntimeException("Patient '" + request.getPatientName() + "' not found. Please ensure they are in the system."));

        // 3. Initialize Prescription
        Prescription prescription = new Prescription();
        prescription.setPatient(patient); // Link the actual Patient entity
        prescription.setDiagnosis(request.getDiagnosis());
        prescription.setDoctor(doctorUser);
        prescription.setPrescribedAt(LocalDateTime.now());
        prescription.setStatus("ACTIVE"); // Important for the Dispensing machine to check
        prescription.setExpiryDate(LocalDate.now().plusDays(7));

        // 4. Map the Items
        List<PrescriptionItem> items = new ArrayList<>();
        for (ItemRequest itemReq : request.getItems()) {
            Medicine medicine = medicineRepository.findById(itemReq.getMedicineId())
                    .orElseThrow(() -> new RuntimeException("Medicine not found"));

            PrescriptionItem item = new PrescriptionItem();
            item.setMedicine(medicine);
            item.setQuantity(itemReq.getQuantity());
            item.setPrescription(prescription);
            items.add(item);
        }

        prescription.setItems(items);
        return prescriptionRepository.save(prescription);
    }
}