<!DOCTYPE html>
<html>
<head>
  <title>Profile</title>
  <style>
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input {
      width: 100%;
      padding: 8px;
      box-sizing: border-box;
    }
    .form-group input[readonly] {
      background-color: #f1f1f1; /* Light gray background for readonly fields */
      color: #777; /* Dimmed text color */
      cursor: not-allowed; /* Show not-allowed cursor */
    }
    .success-message {
      color: green;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .update-button {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 5px;
    }
    .update-button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<h1>Profile</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
<!-- Success Message -->
<c:if test="${not empty successMessage}">
  <div class="success-message">
      ${successMessage}
  </div>
</c:if>

<!-- Profile Form -->
<form method="post" action="${pageContext.request.contextPath}/profile/update">
  <input type="hidden" name="id" value="${user.id}" />
  <input type="hidden" name="_csrf" value="${_csrf.token}" />

  <!-- Username Field (Non-Editable) -->
  <div class="form-group">
    <label for="username">Username</label>
    <input type="text" id="username" name="username" value="${user.username}" readonly />
  </div>

  <!-- Editable Full Name Field -->
  <div class="form-group">
    <label for="fullName">Full Name</label>
    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required />
  </div>

  <!-- Editable Password Field -->
  <div class="form-group">
    <label for="password">Password</label>
    <input type="password" id="password" name="password" value="${user.password}" required />
  </div>

  <!-- Editable Email Field -->
  <div class="form-group">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" value="${user.email}" required />
  </div>

  <!-- Editable Phone Number Field -->
  <div class="form-group">
    <label for="phoneNumber">Phone Number</label>
    <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required />
  </div>

  <!-- Submit Button -->
  <button type="submit" class="update-button">Update Profile</button>
</form>
</body>
</html>