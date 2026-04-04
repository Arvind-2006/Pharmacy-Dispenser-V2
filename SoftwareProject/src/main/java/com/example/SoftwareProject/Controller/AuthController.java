package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.PatientAccountService;
import com.example.SoftwareProject.dto.LoginRequest;
import com.example.SoftwareProject.dto.PatientRegistrationDTO;
import com.example.SoftwareProject.security.JwtUtil;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private PatientAccountService patientAccountService;

    /**
     * Self-service signup: creates {@code User} with {@code ROLE_PATIENT} and linked {@code Patient} row.
     */
    @PostMapping("/register/patient")
    public ResponseEntity<String> registerPatient(@Valid @RequestBody PatientRegistrationDTO dto) {
        patientAccountService.registerPatient(dto);
        return ResponseEntity.ok("Account created. You can sign in now.");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        String token = jwtUtil.generateToken(userDetails);

        String role = userDetails.getAuthorities()
                .iterator()
                .next()
                .getAuthority();

        return ResponseEntity.ok(Map.of(
                "token", token,
                "role", role
        ));
    }
}
