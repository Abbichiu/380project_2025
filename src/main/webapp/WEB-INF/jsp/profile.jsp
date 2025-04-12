<!DOCTYPE html>
<html>
<head>
  <title>Profile</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4; /* Light grey background */
      margin: 0;
      padding: 20px; /* Padding around the body */
      color: #333; /* Dark text color */
    }

    h1 {
      text-align: center; /* Center the heading */
      color: #333; /* Dark text color */
      margin-bottom: 20px; /* Space below heading */
    }

    a.back-button {
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
      color: #007bff; /* Blue link color */
      text-decoration: none; /* No underline */
      font-weight: bold; /* Bold text */
    }

    a.back-button:hover {
      text-decoration: underline; /* Underline on hover */
    }

    .form-group {
      margin-bottom: 15px; /* Space below each form group */
    }

    .form-group label {
      display: block; /* Block display for labels */
      margin-bottom: 5px; /* Space below label */
      font-weight: bold; /* Bold text for labels */
    }

    .form-group input {
      width: 100%; /* Full width inputs */
      padding: 10px; /* Padding inside inputs */
      border: 1px solid #ccc; /* Light grey border */
      border-radius: 4px; /* Rounded corners */
      box-sizing: border-box; /* Include padding in width */
    }

    .form-group input[readonly] {
      background-color: #f1f1f1; /* Light gray background for readonly fields */
      color: #777; /* Dimmed text color */
      cursor: not-allowed; /* Show not-allowed cursor */
    }

    .success-message {
      color: green; /* Green text for success messages */
      font-weight: bold; /* Bold text */
      margin-bottom: 20px; /* Space below success message */
      text-align: center; /* Center the message */
    }

    .alert.alert-danger {
      color: red; /* Red text for error messages */
      font-weight: bold; /* Bold text */
      margin-bottom: 20px; /* Space below error message */
      text-align: center; /* Center the message */
    }

    .update-button {
      background-color: #007bff; /* Blue button background */
      color: white; /* White text */
      border: none; /* No border */
      padding: 10px 20px; /* Padding inside button */
      cursor: pointer; /* Pointer cursor on hover */
      border-radius: 5px; /* Rounded corners */
      width: 100%; /* Full width button */
      transition: background-color 0.3s; /* Smooth transition */
    }

    .update-button:hover {
      background-color: #0056b3; /* Darker blue on hover */
    }
  </style>
</head>
<body>
<h1>Profile</h1>
<div>
  <a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
</div>

<!-- Success Message -->
<c:if test="${not empty successMessage}">
  <div class="success-message">
      ${successMessage}
  </div>
</c:if>

<!-- Error Message -->
<c:if test="${not empty errorMessage}">
  <div class="alert alert-danger">
      ${errorMessage}
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
    <input type="text" id="fullName" name="fullName" value ="${user.fullName}" required />
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