<!DOCTYPE html>
<html>
<head>
  <title>User Management</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4; /* Light grey background */
      margin: 0;
      padding: 20px; /* Padding around the body */
      color: #333; /* Dark text color */
    }

    h1, h2 {
      color: #333; /* Dark text color for headings */
      text-align: center; /* Center the headings */
    }

    a {
      color: #007bff; /* Blue link color */
      text-decoration: none; /* No underline */
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
    }

    a:hover {
      text-decoration: underline; /* Underline on hover */
    }

    table {
      width: 100%;
      border-collapse: collapse; /* Collapse borders */
      margin-bottom: 20px; /* Space below the table */
    }

    table, th, td {
      border: 1px solid #ccc; /* Light grey border */
    }

    th, td {
      padding: 10px; /* Padding inside cells */
      text-align: left; /* Left align text */
    }

    th {
      background-color: #007bff; /* Blue background for header */
      color: white; /* White text for header */
    }

    .edit-form, .delete-form {
      display: flex; /* Use flexbox for alignment */
      gap: 10px; /* Space between elements */
      align-items: center; /* Center items vertically */
    }

    .delete-form {
      margin: 0; /* Remove margin */
    }

    .back-button {
      margin-bottom: 20px; /* Space below the back button */
    }

    button {
      background-color: #007bff; /* Blue button background */
      color: white; /* White text */
      border: none; /* No border */
      padding: 8px 12px; /* Padding inside button */
      border-radius: 4px; /* Rounded corners */
      cursor: pointer; /* Pointer cursor on hover */
      transition: background-color 0.3s; /* Smooth transition */
    }

    button:hover {
      background-color: #0056b3; /* Darker blue on hover */
    }

    .delete-button {
      background-color: red;
    }

    .error-message {
      color: red; /* Red text for error messages */
      text-align: center; /* Center the error message */
      margin-bottom: 20px; /* Space below error message */
    }

    .success-message {
      color: green; /* Green text for success messages */
      text-align: center; /* Center the success message */
      margin-bottom: 20px; /* Space below success message */
    }

    .add-admin-form {
      margin-top: 20px; /* Space above the add admin form */
      text-align: center; /* Center the form */
    }

    .add-admin-form input {
      margin: 5px; /* Space around inputs */
      padding: 8px; /* Padding inside inputs */
      border: 1px solid #ccc; /* Light grey border */
      border-radius: 4px; /* Rounded corners */
      width: calc(20% - 10px); /* Adjust width for inputs */
    }

    .add-admin-form button {
      margin-top: 10px; /* Space above the button */
    }
  </style>
</head>
<body>
<h1>User Management</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>

<!-- Success Message -->
<c:if test="${not empty successMessage}">
  <div class="success-message">
      ${successMessage}
  </div>
</c:if>

<table>
  <thead>
  <tr>
    <th>Username</th>
    <th>Full Name</th>
    <th>Password</th>
    <th>Email</th>
    <th>Phone Number</th>
    <th>Actions</th>
    <th></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${users}">
    <tr <!-- Inline Editing Form -->
    <form method="post" action="${pageContext.request.contextPath}/teacher/users/update" class="edit-form">
      <input type="hidden" name="id" value="${user.id}" />
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
      <td>${user.username}</td> <!-- Username is not editable -->
      <td><input type="text" name="fullName" value="${user.fullName}" required /></td>
      <td><input type="password" name="password" value="${user.password}" required /></td>
      <td><input type="email" name="email" value="${user.email}" required /></td>
      <td><input type="text" name="phoneNumber" value="${user.phoneNumber}" required /></td>
      <td>
        <button type="submit">Save</button>
      </td>
    </form>
    <!-- Delete Button -->
    <form method="post" action="${pageContext.request.contextPath}/teacher/users/delete" class="delete-form">
      <input type="hidden" name="id" value="${user.id}" />
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
      <td>
        <button type="submit" class="delete-button">Delete</button>
      </td>
    </form>
    </tr>
  </c:forEach>
  </tbody>
</table>

<!-- Add Admin Form -->
<div class="add-admin-form">
  <h2>Add Admin</h2>
  <form method="post" action="${pageContext.request.contextPath}/teacher/users/add-admin">
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <input type="text" name="username" placeholder="Username" required />
    <input type="password" name="password" placeholder="Password" required />
    <input type="text" name="fullName" placeholder="Full Name" required />
    <input type="email" name="email" placeholder="Email" required />
    <input type="text" name="phoneNumber" placeholder="Phone Number" required />
    <button type="submit">Add Admin</button>
  </form>
</div>

<!-- Admin List -->
<h2>Admin Accounts</h2>
<table>
  <thead>
  <tr>
    <th>Username</th>
    <th>Full Name</th>
    <th>Email</th>
    <th>Phone Number</th>
    <th>Actions</th>
    <th></th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="admin" items="${admins}">
    <tr>
      <!-- Inline Editing Form -->
      <form method="post" action="${pageContext.request.contextPath}/teacher/users/update-admin" class="edit-form">
        <input type="hidden" name="id" value="${admin.id}" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <td>${admin.username}</td> <!-- Username is not editable -->
        <td><input type="text" name="fullName" value="${admin.fullName}" required /></td>
        <td><input type="email" name="email" value="${admin.email}" required /></td>
        <td><input type="text" name="phoneNumber" value="${admin.phoneNumber}" required /></td>
        <td>
          <button type="submit">Save</button>
        </td>
      </form>
      <!-- Delete Button -->
      <form method="post" action="${pageContext.request.contextPath}/teacher/users/delete-admin" class="delete-form">
        <input type="hidden" name="id" value="${admin.id}" />
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <td>
          <button type="submit" class="delete-button">Delete</button>
        </td>
      </form>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>