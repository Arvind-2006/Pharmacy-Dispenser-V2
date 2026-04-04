package com.example.SoftwareProject.Service;

import com.example.SoftwareProject.dto.PatientRegistrationDTO;
import com.example.SoftwareProject.model.Patient;
import com.example.SoftwareProject.model.Role;
import com.example.SoftwareProject.model.User;
import com.example.SoftwareProject.repositories.PatientRepo;
import com.example.SoftwareProject.repositories.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
public class PatientAccountService {

    private final UserRepository userRepository;
    private final PatientRepo patientRepo;
    private final PasswordEncoder passwordEncoder;

    public PatientAccountService(UserRepository userRepository,
                                 PatientRepo patientRepo,
                                 PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.patientRepo = patientRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public void registerPatient(PatientRegistrationDTO dto) {
        if (userRepository.findByUsername(dto.getUsername()).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");
        }
        if (patientRepo.existsByEmailIgnoreCase(dto.getEmail().trim())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "An account with this email already exists");
        }

        User user = new User();
        user.setUsername(dto.getUsername().trim());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setRole(Role.ROLE_PATIENT);
        user = userRepository.save(user);

        Patient patient = new Patient();
        patient.setName(dto.getName().trim());
        patient.setAge(dto.getAge());
        patient.setGender(dto.getGender() != null ? dto.getGender().trim() : null);
        patient.setEmail(dto.getEmail().trim().toLowerCase());
        patient.setPhone(dto.getPhone() != null ? dto.getPhone().trim() : null);
        patient.setAddress(dto.getAddress() != null ? dto.getAddress().trim() : null);
        patient.setUser(user);
        patientRepo.save(patient);
    }
}
