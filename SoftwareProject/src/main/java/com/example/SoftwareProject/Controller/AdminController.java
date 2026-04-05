package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.InventoryService;
import com.example.SoftwareProject.Service.MedicineService;
import com.example.SoftwareProject.Service.PrescriptionService;
import com.example.SoftwareProject.model.Medicine;
import com.example.SoftwareProject.model.MedicineInventory;
import com.example.SoftwareProject.model.Prescription;
import com.example.SoftwareProject.repositories.MedicineInventoryRepo;
import com.example.SoftwareProject.repositories.PrescriptionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@PreAuthorize("hasRole('ADMIN')")
@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private MedicineService medicineService;

    @Autowired
    private InventoryService inventoryService;

    @PostMapping("/medicine")
    public ResponseEntity<?> addMedicine(@RequestBody Medicine medicine) {
        return ResponseEntity.ok(medicineService.addMedicine(medicine));
    }

    @PutMapping("/medicine/{id}")
    public ResponseEntity<?> updateMedicine(@PathVariable Long id,
                                            @RequestBody Medicine medicine) {
        return ResponseEntity.ok(medicineService.updateMedicine(id, medicine));
    }

    @DeleteMapping("/medicine/{id}")
    public ResponseEntity<?> deleteMedicine(@PathVariable Long id) {
        medicineService.deleteMedicine(id);
        return ResponseEntity.ok("Deleted Successfully");
    }

    @GetMapping("/medicines")
    public ResponseEntity<?> getAllMedicine() {
        return ResponseEntity.ok(medicineService.getAllMedicines());
    }

    @Autowired
    private MedicineInventoryRepo inventoryRepo;

    @GetMapping("/inventory")
    public List<MedicineInventory> getAllStock() {
        return inventoryRepo.findAll();
    }

    @PostMapping("/inventory/add")
    public ResponseEntity<?> addBatch(@RequestBody MedicineInventory inventory) {
        return ResponseEntity.ok(inventoryService.addBatch(inventory));
    }

    @PutMapping("/inventory/{id}")
    public ResponseEntity<?> updateStock(@PathVariable Long id,
                                         @RequestParam int quantity) {
        System.out.println("UPDATE API HIT -> ID: " + id + ", QTY: " + quantity);
        return ResponseEntity.ok(inventoryService.updateStock(id, quantity));
    }

    @GetMapping("/inventory/low-stock")
    public ResponseEntity<?> lowStock() {
        return ResponseEntity.ok(inventoryService.getLowStock());
    }

    @GetMapping("/inventory/expired")
    public ResponseEntity<?> expired() {
        return ResponseEntity.ok(inventoryService.getExpired());
    }

    //admin/prescriptions
    @Autowired
    PrescriptionRepo prescriptionRepo;

    @Autowired
    private PrescriptionService prescriptionService;

    @GetMapping("/pending")
    public List<Prescription> getPending() {
        return prescriptionRepo.findByStatus("PENDING");
    }

    @GetMapping("/prescriptions")
    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepo.findAll();
    }

    @PutMapping("/{id}/approve")
    public ResponseEntity<?> approve(@PathVariable Long id) {
        Prescription p = prescriptionRepo.findById(id).get();
        p.setStatus("APPROVED");
        return ResponseEntity.ok(prescriptionRepo.save(p));
    }

}