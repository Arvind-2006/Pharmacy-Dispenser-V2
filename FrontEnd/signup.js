const BASE_URL = "http://localhost:8080";

function setMessage(text, kind) {
  const el = document.getElementById("message");
  el.textContent = text || "";
  el.className = kind || "";
}

document.getElementById("signupForm").addEventListener("submit", function (e) {
  e.preventDefault();
  setMessage("");

  const username = document.getElementById("username").value.trim();
  const password = document.getElementById("password").value;
  const name = document.getElementById("name").value.trim();
  const email = document.getElementById("email").value.trim();
  const ageRaw = document.getElementById("age").value.trim();
  const gender = document.getElementById("gender").value.trim();
  const phone = document.getElementById("phone").value.trim();
  const address = document.getElementById("address").value.trim();

  if (username.length < 3) {
    setMessage("Username must be at least 3 characters.", "error");
    return;
  }
  if (password.length < 6) {
    setMessage("Password must be at least 6 characters.", "error");
    return;
  }

  const body = {
    username,
    password,
    name,
    email,
    phone: phone || null,
    address: address || null,
    gender: gender || null,
  };

  if (ageRaw !== "") {
    const age = parseInt(ageRaw, 10);
    if (Number.isNaN(age) || age < 0) {
      setMessage("Enter a valid age or leave it blank.", "error");
      return;
    }
    body.age = age;
  }

  fetch(`${BASE_URL}/auth/register/patient`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  })
    .then(async (res) => {
      const text = await res.text();
      if (!res.ok) {
        throw new Error(text || "Registration failed");
      }
      return text;
    })
    .then((msg) => {
      setMessage(msg, "success");
      setTimeout(() => {
        window.location.href = "login.html";
      }, 1200);
    })
    .catch((err) => {
      setMessage(err.message, "error");
    });
});
