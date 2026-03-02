package com.example.SoftwareProject.Service;

import com.example.SoftwareProject.model.*;
import com.example.SoftwareProject.repositories.DispenseLogRepo;
import com.example.SoftwareProject.repositories.MedicineInventoryRepo;
import com.example.SoftwareProject.repositories.PrescriptionRepo;
import com.example.SoftwareProject.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class DispenseService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PrescriptionRepo prescriptionRepo;

    @Autowired
    private MedicineInventoryRepo inventoryRepo;

    @Autowired
    private DispenseLogRepo logRepo;

    @Transactional
    public String dispenseMedicine(Long prescriptionId,String loggedInUsername) {
        // 1. Get the User who is currently at the machine
        System.out.println("Starting dispense for ID: " + prescriptionId + " by User: " +loggedInUsername);
        User operator = userRepository.findByUsername(loggedInUsername)
                .orElseThrow(() -> new RuntimeException("Operator not found"));
        // ✅ Fetch prescription only ONCE
        Prescription prescription = prescriptionRepo.findById(prescriptionId)
                .orElseThrow(() -> new RuntimeException("Prescription not found"));

        // ✅ Check if already dispensed (String comparison)
        if ("DISPENSED".equalsIgnoreCase(prescription.getStatus())) {
            throw new RuntimeException("Prescription already dispensed");
        }


        // ✅ Loop through all medicines in prescription
        for (PrescriptionItem item : prescription.getItems()) {

            Medicine medicine = item.getMedicine();
            int quantityRequired = item.getQuantity();

            MedicineInventory inventory = inventoryRepo
                    .findByMedicine(medicine)
                    .orElseThrow(() -> new RuntimeException(
                            "Inventory not found for " + medicine.getMedicineName()
                    ));

            // ✅ Check stock
            if (inventory.getQuantityAvailable() < quantityRequired) {
                throw new RuntimeException(
                        "Not enough stock for " + medicine.getMedicineName()
                );
            }

            // ✅ Reduce stock
            inventory.setQuantityAvailable(
                    inventory.getQuantityAvailable() - quantityRequired
            );

            inventoryRepo.save(inventory);

            //NEW
            DispenseLog log = new DispenseLog();
            log.setPrescription(prescription);
            log.setMedicine(medicine);
            log.setPatient(prescription.getPatient());// This is only possible because of the fix above!
            log.setDispensedBy(operator);
            log.setQuantityDispensed(quantityRequired);
            log.setDispenseTime(LocalDateTime.now());
            log.setStatus("SUCCESS");

            logRepo.save(log);
        }

        // ✅ Update prescription status
        prescription.setStatus("DISPENSED");
        prescriptionRepo.save(prescription);

        return "Medicine Dispensed Successfully";
    }

    // ✅ Profile method (outside dispense method)
    public User getProfile(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
    }
}
