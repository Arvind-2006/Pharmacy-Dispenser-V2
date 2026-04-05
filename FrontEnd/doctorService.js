const BASE_URL = "http://localhost:8080";

// Toggles visibility between views
function showSection(sectionId) {
    const sections = ['doctorsProfile', 'addPrescriptionForm', 'welcomeScreen', 'viewPrescriptionForm'];
    sections.forEach(id => {
        const el = document.getElementById(id);
        if (el) el.style.display = (id === sectionId) ? "block" : "none";
    });
}

function hideAll() {
    showSection('welcomeScreen');
}

// PROFILE LOGIC
function viewProfile() {
    const token = localStorage.getItem("jwt");
    fetch(`${BASE_URL}/doctor/profile`, {
        method: "GET",
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        showSection('doctorsProfile');
        document.getElementById("doctorBody").innerHTML = `
            <tr>
                <td>${data.name}</td>
                <td>${data.email}</td>
                <td>${data.phone}</td>
                <td>${data.specialization}</td>
            </tr>`;
    })
    .catch(err => alert("Error loading profile"));
}

// PRESCRIPTION LOGIC
function showAddPrescriptionForm() {
    showSection('addPrescriptionForm');
}

// VIEW PRESCRIPTIONS
function showViewPrescriptionForm() {
    const token = localStorage.getItem("jwt");
    fetch(`${BASE_URL}/doctor/prescriptions`, {
        method: "GET",
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        showSection('viewPrescriptionForm');
        const prescriptionBody = document.getElementById("prescriptionBody");
        const noPrescriptionsMessage = document.getElementById("noPrescriptionsMessage");
        
        if (data && data.length > 0) {
            noPrescriptionsMessage.style.display = "none";
            prescriptionBody.innerHTML = data.map(prescription => `
                <tr>
                    <td>${prescription.patientName}</td>
                    <td>${prescription.diagnosis}</td>
                    <td>${prescription.items && prescription.items[0] ? prescription.items[0].medicineId : 'N/A'}</td>
                    <td>${prescription.items && prescription.items[0] ? prescription.items[0].quantity : 'N/A'}</td>
                    <td>${new Date(prescription.createdAt).toLocaleDateString()}</td>
                </tr>
            `).join('');
        } else {
            noPrescriptionsMessage.style.display = "block";
            prescriptionBody.innerHTML = '';
        }
    })
    .catch(err => {
        alert("Error loading prescriptions: " + err.message);
        console.error(err);
    });
}

document.getElementById("prescriptionForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const token = localStorage.getItem("jwt");

    const payload = {
        patientName: document.getElementById("patientName").value,
        diagnosis: document.getElementById("diagnosis").value,
        items: [{
            medicineId: parseInt(document.getElementById("medicineId").value),
            quantity: parseInt(document.getElementById("quantity").value)
        }]
    };

    fetch(`${BASE_URL}/doctor/prescription`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        },
        body: JSON.stringify(payload)
    })
    .then(res => {
        if (!res.ok) throw new Error("Check Medicine ID or Stock");
        return res.json();
    })
    .then(data => {
        alert("Success! Prescription issued.");
        document.getElementById("prescriptionForm").reset();
        hideAll();
    })
    .catch(err => alert("Error: " + err.message));
});
