function openWorkspace() {
    document.getElementById("contentArea").style.display = "block";
    // Scroll to the content area smoothly
    document.getElementById("contentArea").scrollIntoView({ behavior: 'smooth' });
}

function loadInventory() {
    openWorkspace(); // Show the white box
    fetch("http://localhost:8080/admin/inventory", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = "<h3>Inventory List</h3><table><thead><tr><th>Medicine</th><th>Stock</th><th>Expiry</th></tr></thead><tbody>";
        data.forEach(i => {
            html += `<tr>
                        <td>${i.medicine.medicineName}</td>
                        <td>${i.quantityAvailable}</td>
                        <td>${i.expiryDate}</td>
                    </tr>`;
        });
        html += "</tbody></table>";
        document.getElementById("content").innerHTML = html;
    });
}

//Show Add Doctor Form
function showAddDoctorForm() {
    document.getElementById("addPatientForm").style.display = "none";
    document.getElementById("addDoctorForm").style.display = "block";
}
function hideAddDoctorForm() {
    document.getElementById("addDoctorForm").style.display = "none";
}

function showAddPatientForm() {
    document.getElementById("addDoctorForm").style.display = "none";
    document.getElementById("addMedicineForm").style.display = "none";
    document.getElementById("doctorsList").style.display = "none";
    document.getElementById("addPatientForm").style.display = "block";
    document.getElementById("patientResponse").innerText = "";
}

function hideAddPatientForm() {
    document.getElementById("addPatientForm").style.display = "none";
}

function addPatient() {
    const token = localStorage.getItem("jwt");

    if (!token) {
        alert("You are not logged in!");
        return;
    }

    const username = document.getElementById("patientUsername").value.trim();
    const password = document.getElementById("patientPassword").value;
    const name = document.getElementById("patientFullName").value.trim();
    const email = document.getElementById("patientEmail").value.trim();
    const ageVal = document.getElementById("patientAge").value.trim();
    const gender = document.getElementById("patientGender").value.trim();
    const phone = document.getElementById("patientPhone").value.trim();
    const address = document.getElementById("patientAddress").value.trim();

    if (!username || !password || !name || !email) {
        document.getElementById("patientResponse").innerText =
            "Username, password, full name, and email are required.";
        return;
    }

    const body = {
        username: username,
        password: password,
        name: name,
        email: email,
        phone: phone || null,
        address: address || null,
        gender: gender || null,
    };
    if (ageVal !== "") {
        const age = parseInt(ageVal, 10);
        if (!Number.isNaN(age) && age >= 0) {
            body.age = age;
        }
    }

    fetch("http://localhost:8080/admin/patients", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            Authorization: "Bearer " + token,
        },
        body: JSON.stringify(body),
    })
        .then(async (response) => {
            const text = await response.text();
            if (!response.ok) {
                throw new Error(text || "Failed to register patient");
            }
            return text;
        })
        .then((msg) => {
            document.getElementById("patientUsername").value = "";
            document.getElementById("patientPassword").value = "";
            document.getElementById("patientFullName").value = "";
            document.getElementById("patientEmail").value = "";
            document.getElementById("patientAge").value = "";
            document.getElementById("patientGender").value = "";
            document.getElementById("patientPhone").value = "";
            document.getElementById("patientAddress").value = "";
            hideAddPatientForm();
            alert(msg);
        })
        .catch((error) => {
            console.error(error);
            document.getElementById("patientResponse").innerText = error.message;
        });
}

function addDoctor() {

    const token = localStorage.getItem("jwt");

    if (!token) {
        alert("You are not logged in!");
        return;
    }

    const doctorData = {
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        name: document.getElementById("name").value,
        specialization: document.getElementById("specialization").value,
        phone: document.getElementById("phone").value
    };

    fetch("http://localhost:8080/admin/doctors", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        },
        body: JSON.stringify(doctorData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to add doctor");
        }
        return response.json();
    })
    .then(data => {
        document.getElementById("doctorResponse").innerText =
            "Doctor added successfully!";
        hideAddDoctorForm();
    })
    .catch(error => {
        console.error(error);
        document.getElementById("doctorResponse").innerText =
            "Error adding doctor!";
    });
}

function loadSummary() {
    fetch("http://localhost:8080/summary", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = `
            <div class="card summary">
                <h3>Total Medicines</h3>
                <p>${data.totalMedicines}</p>
            </div>

            <div class="card low">
                <h3>Low Stock</h3>
                <p>${data.lowStockCount}</p>
            </div>

            <div class="card expired">
                <h3>Expired</h3>
                <p>${data.expiredCount}</p>
            </div>

            <div class="card summary">
                <h3>Dispensed Today</h3>
                <p>${data.totalDispensedToday}</p>
            </div>
        `;
        document.getElementById("content").innerHTML = html;
    })
    .catch(err => alert("Error loading summary"));
}
function loadMedicines() {
    fetch("http://localhost:8080/admin/medicines", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = "<h3>Medicines</h3><ul>";
        data.forEach(m => {
            html += `<li>${m.medicineName} - ₹${m.price}</li>`;
        });
        html += "</ul>";
        document.getElementById("content").innerHTML = html;
    });
}
function loadInventory() {
    fetch("http://localhost:8080/admin/inventory", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = "<h3>Inventory</h3><ul>";
        data.forEach(i => {
            html += `<li>
                        ${i.medicine.medicineName}
                        - Stock: ${i.quantityAvailable}
                        - Expiry: ${i.expiryDate}
                     </li>`;
        });
        html += "</ul>";
        document.getElementById("content").innerHTML = html;
    });
}
function loadLowStock() {
    fetch("http://localhost:8080/admin/inventory/low-stock", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = "<h3 style='color:red;'>Low Stock Medicines</h3><ul>";
        data.forEach(i => {
            html += `<li>
                        ${i.medicine.medicineName}
                        - Remaining: ${i.quantityAvailable}
                     </li>`;
        });
        html += "</ul>";
        document.getElementById("content").innerHTML = html;
    });
}
function loadExpired() {
    fetch("http://localhost:8080/admin/inventory/expired", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        let html = "<h3 style='color:darkred;'>Expired Medicines</h3><ul>";
        data.forEach(i => {
            html += `<li>
                        ${i.medicine.medicineName}
                        - Expired On: ${i.expiryDate}
                     </li>`;
        });
        html += "</ul>";
        document.getElementById("content").innerHTML = html;
    });
}
function loadLogs() {
    fetch("http://localhost:8080/admin/dispense/logs", {
        headers: { "Authorization": "Bearer " + token }
    })
    .then(res => res.json())
    .then(data => {
        if (data.length === 0) {
            document.getElementById("content").innerHTML =
                "<h3>No dispense logs found.</h3>";
            return;
        }

        let html = "<h3>Dispense Logs</h3><ul>";
        data.forEach(l => {
            html += `<li>
                        ${l.medicine.medicineName}
                        - Qty: ${l.quantityDispensed}
                        - Time: ${l.dispenseTime}
                     </li>`;
        });
        html += "</ul>";
        document.getElementById("content").innerHTML = html;
    })
    .catch(err => alert("Error loading logs"));
}
function showDoctors() {

    const token = localStorage.getItem("jwt");
    document.getElementById("addPatientForm").style.display = "none";

    fetch("http://localhost:8080/admin/doctors", {
        method: "GET",
        headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to fetch doctors");
        }
        return response.json();
    })
    .then(data => {
        document.getElementById("doctorsList").style.display = "block";
        const tbody = document.getElementById("doctorBody");
        
        tbody.innerHTML = "";

        data.forEach(doctor => {

            const row = document.createElement("tr");

            row.innerHTML = `
                <td>${doctor.name}</td>
                <td>${doctor.email}</td>
                <td>${doctor.phone}</td>
                <td>${doctor.specialization}</td>
                <td>
                    <button onclick="deleteDoctor(${doctor.id})">
                        Delete
                    </button>
                </td>
            `;

            tbody.appendChild(row);
        });

    })
    .catch(error => {
        console.error(error);
        alert("Error loading doctors");
    });
}function hideDoctors() {
    document.getElementById("doctorsList").style.display = "none";
}
function deleteDoctor(id) {

    const token = localStorage.getItem("jwt");

    if (!token) {
        alert("Please login again");
        return;
    }

    if (!confirm("Are you sure you want to delete this doctor?")) {
        return;
    }

    fetch(`http://localhost:8080/admin/doctors/${id}`, {
        method: "DELETE",
        headers: {
            "Authorization": "Bearer " + token
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to delete doctor");
        }

        alert("Doctor deleted successfully");

        // 🔥 Refresh table after delete
        showDoctors();
    })
    .catch(error => {
        console.error(error);
        alert("Error deleting doctor");
    });
}

function showAddMedicineForm() {
    document.getElementById("addPatientForm").style.display = "none";
    document.getElementById("addMedicineForm").style.display = "block";
}

function hideAddMedicineForm() {
    document.getElementById("addMedicineForm").style.display = "none";
}

function addMedicine() {

    const token = localStorage.getItem("jwt");

    if (!token) {
        alert("You are not logged in!");
        return;
    }

    const medicineData = {
        medicineName: document.getElementById("medicineName").value,
        description: document.getElementById("description").value,
        price: parseFloat(document.getElementById("price").value),
        manufacturer: document.getElementById("manufacturer").value
    };

    fetch("http://localhost:8080/admin/medicine", {   
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        },
        body: JSON.stringify(medicineData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Failed to add medicine");
        }
        return response.json();
    })
    .then(data => {
        document.getElementById("medicineResponse").innerText =
            "Medicine added successfully!";
        hideAddMedicineForm();
        loadMedicines(); // refresh list
    })
    .catch(error => {
        console.error(error);
        document.getElementById("medicineResponse").innerText =
            "Error adding medicine!";
    });
}