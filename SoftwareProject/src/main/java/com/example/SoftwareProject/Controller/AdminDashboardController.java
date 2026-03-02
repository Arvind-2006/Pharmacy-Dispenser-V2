package com.example.SoftwareProject.Controller;

import com.example.SoftwareProject.Service.AdminDashboardService;
import com.example.SoftwareProject.dto.DashboardSummary;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@PreAuthorize("hasRole('ADMIN')")
@RestController
public class AdminDashboardController{

    private final AdminDashboardService adminDashboardService;

    @GetMapping("/admin/dashboard")
    public String AdminDashboard() {
        return "Admin only";
    }

    public AdminDashboardController(AdminDashboardService adminDashboardService) {
        this.adminDashboardService = adminDashboardService;
    }

    @GetMapping("/summary")
    public DashboardSummary getSummary() {
        return adminDashboardService.getDashboardSummary();
    }

}

