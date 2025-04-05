<!DOCTYPE html>
<html>
<head>
  <title>User Management</title>
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
    }
    table, th, td {
      border: 1px solid black;
    }
    th, td {
      padding: 8px;
      text-align: left;
    }
    .edit-form {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .delete-form {
      margin: 0;
    }
    .back-button {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<h1>User Management</h1>

<!-- Back Button -->
<div class="back-button">
  <a href="<c:url value='/index' />" style="text-decoration: none; color: white; background-color: #007bff; padding: 10px 20px; border-radius: 5px;">
    Back to Dashboard
  </a>
</div>

<table>
  <thead>
  <tr>
    <th>Username</th>
    <th>Full Name</th>
    <th>Password</th>
    <th>Email</th>
    <th>Phone Number</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${users}">
    <tr>
      <!-- Inline Editing Form -->
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
          <button type="submit" style="color: red;">Delete</button>
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
          <button type="submit" style="color: red;">Delete</button>
        </td>
      </form>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>