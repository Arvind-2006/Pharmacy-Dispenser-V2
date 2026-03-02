package com.example.SoftwareProject.Service;

import com.example.SoftwareProject.dto.DoctorProfileDTO;
import com.example.SoftwareProject.dto.ItemRequest;
import com.example.SoftwareProject.dto.PrescriptionRequest;
import com.example.SoftwareProject.model.*;
import com.example.SoftwareProject.repositories.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class DoctorService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DoctorRepo doctorRepository;

    @Autowired
    private PatientRepo patientRepo;
    public DoctorService(UserRepository userRepository, DoctorRepo doctorRepository) {
        this.userRepository = userRepository;
        this.doctorRepository = doctorRepository;
    }

    // Add Doctor
    public Doctor addDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }


    // Get All Doctors
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    // Update Doctor
    public Doctor updateDoctor(Long id, Doctor updatedDoctor) {

        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Doctor not found"));

        doctor.setName(updatedDoctor.getName());
        doctor.setSpecialization(updatedDoctor.getSpecialization());
        doctor.setEmail(updatedDoctor.getEmail());
        doctor.setPhone(updatedDoctor.getPhone());

        return doctorRepository.save(doctor);
    }

    // Delete Doctor
    public void deleteDoctor(Long id) {
        doctorRepository.deleteById(id);
    }

    public DoctorProfileDTO getProfile(String username) {

        Doctor doctor = (Doctor) doctorRepository.findByUserUsername(username)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        return new DoctorProfileDTO(
                doctor.getName(),
                doctor.getSpecialization(),
                doctor.getEmail(),
                doctor.getPhone()
        );
    }


    @Transactional
    public Prescription createPrescription(PrescriptionRequest request, String username) {

        User doctor = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        // 1. MUST find the actual Patient Entity to fill 'patient_id'
        Patient patient = (Patient) patientRepo.findByName(request.getPatientName())
                .orElseThrow(() -> new RuntimeException("Patient not found in system"));

        Prescription prescription = new Prescription();
        prescription.setPatient(patient); // This fills the patient_id column
        prescription.setPatientName(request.getPatientName()); // Fills the text column
        prescription.setDiagnosis(request.getDiagnosis());
        prescription.setDoctor(doctor);
        prescription.setPrescribedAt(LocalDateTime.now());


        // 2. Explicitly set the Expiry Date
        prescription.setExpiryDate(LocalDate.now().plusDays(7));

        // 3. Ensure Status is set
        prescription.setStatus("ACTIVE");

        List<PrescriptionItem> items = new ArrayList<>();
        for (ItemRequest itemReq : request.getItems()) {
            Medicine medicine = medicineRepository.findById(itemReq.getMedicineId())
                    .orElseThrow(() -> new RuntimeException("Medicine not found"));

            PrescriptionItem item = new PrescriptionItem();
            item.setMedicine(medicine);
            item.setQuantity(itemReq.getQuantity());
            item.setPrescription(prescription);

            // If your PrescriptionItem has a dosage field, set it here
            // item.setDosage(itemReq.getDosage());

            items.add(item);
        }

        prescription.setItems(items);

        // The save call will now persist the Prescription AND the linked items
        return prescriptionRepository.save(prescription);
    }

    @Autowired
    private PrescriptionRepo prescriptionRepository;



    public List<Prescription> getMyPrescriptions(String username) {

        User doctor = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        return prescriptionRepository.findByDoctor(doctor);
    }

    @Autowired
    private MedicineRepo medicineRepository;

    public List<Medicine> getAvailableMedicines() {
        return medicineRepository.findAll();
    }


}
