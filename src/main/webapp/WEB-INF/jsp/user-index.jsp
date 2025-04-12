<!DOCTYPE html>
<html>
<head>
  <title>Online Course Website</title>
  <style>
    body {
      font-family: 'Helvetica Neue', Arial, sans-serif;
      margin: 20px;
      background-color: #f4f4f4; /* Light grey background */
      color: #333; /* Dark text color */
    }

    h1 {
      font-size: 2.5em; /* Larger font size */
      padding: 10px;
      color: #00FF00FF; /* Lime text */
      border-radius: 5px; /* Rounded corners */
    }

    a {
      text-decoration: none;
      color: #007bff; /* Blue links */
      transition: color 0.3s; /* Smooth transition */
    }

    a:hover {
      color: #0056b3; /* Darker blue on hover */
      text-decoration: underline; /* Underline on hover */
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

    .logout-button {
      width: 200px;
      padding: 10px 15px; /* Padding for the button */
      background-color: #dc3545; /* Bootstrap danger color */
      color: white; /* White text */
      border: none; /* No border */
      border-radius: 5px; /* Rounded corners */
      cursor: pointer; /* Pointer cursor on hover */
      transition: background-color 0.3s; /* Smooth transition */
    }

    .logout-button:hover {
      background-color: #c82333; /* Darker red on hover */
    }

    .section {
      margin-bottom: 30px;
      padding: 15px;
      background-color: white; /* White background for sections */
      border: 1px solid #ddd; /* Light grey border */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }

    .delete-button {
      background-color: red;
    }

    ul {
      list-style-type: none; /* Remove default bullets */
      padding: 0;
    }

    ul li {
      margin-bottom: 10px;
      padding: 10px;
      background-color: #f9f9f9; /* Light background for list items */
      border: 1px solid #eee; /* Light border */
      border-radius: 3px; /* Rounded corners */
    }
  </style>
</head>
<body>
<h1>Online Course Website</h1>
<p>Welcome, <strong>${username}</strong>!</p>

<form action="<c:url value='/logout' />" method="POST">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit" class="logout-button">Logout</button>
</form>

<!-- Profile Link (Visible to All User Roles) -->
<div class="section">
  <h2>Your Profile</h2>
  <ul>
    <li>
      <a href="<c:url value='/profile?id=${userId}' />">View and Update Profile</a>
    </li>
  </ul>
</div>

<!-- Display Teacher Link -->
<security:authorize access="hasRole('ROLE_TEACHER')">
  <div class="section">
    <h2>User Management</h2>
    <ul>
      <li>
        <a href="<c:url value='/teacher/users' />">Manage Users</a>
      </li>
    </ul>
  </div>
</security:authorize>

<div class="section">
  <h2>Polls History</h2>
  <ul>
    <li><a href="<c:url value='/poll/history' />">View Your Voting History</a></li>
  </ul>
</div>

<!-- Add Comment History Section -->
<div class="section">
  <h2>Comments History</h2>
  <ul>
    <li><a href="<c:url value='/comments/history' />">View All Comment History</a></li>
  </ul>
</div>

<!-- Display Courses -->
<div class="section">
  <h2>Courses</h2>
  <ul>
    <c:forEach var="course" items="${courses}">
      <li>${course.name}</li>
    </c:forEach>
  </ul>
</div>

<!-- Display Lectures -->
<div class="section">
  <h2>Lectures</h2>
  <ul>
    <c:forEach var="lecture" items="${lectures}">
      <li>
      <security:authorize access="hasRole('ROLE_TEACHER')">
        <a href="<c:url value='/teacher/lecture/${lecture.id}' />">${lecture.title}</a>
        <form method="post" action="<c:url value='/lecture/delete/${lecture.id}' />" style="display:inline;">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <button type="submit" class="delete-button">Delete</button>
        </form>
      </security:authorize>
      <security:authorize access="!hasRole('ROLE_TEACHER')">
        <a href="<c:url value='/lecture/${lecture.id}' />">${lecture.title}</a>
      </security:authorize>
      </li>
    </c:forEach>
  </ul>

  <security:authorize access="hasRole('ROLE_TEACHER')">
    <form method="post" action="<c:url value='/lecture/add' />">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <label for="title">Title:</label>
      <input type="text" id="title" name="title" required />
      <label for="description">Description:</label>
      <textarea id="description" name="description" required></textarea>
      <button type="submit">Add Lecture</button>
    </form>
  </security:authorize>
</div>

<!-- Display Polls -->
<div class="section">
  <h2>Polls</h2>
  <ul>
    <c:forEach var="poll" items="${polls}">
      <li>
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
        <security:authorize access="hasRole('ROLE_TEACHER')">
          <form method="post" action="<c:url value='/poll/delete/${poll.id}' />" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" class="delete-button">Delete</button>
          </form>
        </security:authorize>
      </li>
    </c:forEach>
  </ul>

  <security:authorize access="hasRole('ROLE_TEACHER')">
    <div class="section">
      <h2>Add Poll</h2>
      <form method="post" action="<c:url value='/poll/add' />">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <label for="question">Poll Question:</label>
        <input type="text" id="question" name="question" required />
        <label for="option1">Option 1:</label>
        <input type="text" id="option1" name="options" required />
        <label for="option2">Option 2:</label>
        <input type="text" id="option2" name="options" required />
        <label for="option3">Option 3:</label>
        <input type="text" id="option3" name="options" required />
        <label for="option4">Option 4:</label>
        <input type="text" id="option4" name="options" required />
        <button type="submit">Add Poll</button>
      </form>
    </div>
  </security:authorize>
</div>
</body>
</html>