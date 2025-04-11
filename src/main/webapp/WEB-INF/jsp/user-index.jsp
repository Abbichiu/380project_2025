<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <title>Online Course Website</title>
</head>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 20px;
  }
  h1, h2 {
    color: #333;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  ul li {
    margin-bottom: 10px;
  }
  a {
    text-decoration: none;
    color: #007bff;
  }
  a:hover {
    text-decoration: underline;
  }
  .section {
    margin-bottom: 30px;
  }
</style>
<body>
<h1>Online Course Website</h1>
<p>Welcome, <strong>${username}</strong>!</p>
<form action="<c:url value='/logout' />" method="POST">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit">Logout</button>
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
<!-- Display Lectures -->
<div class="section">
  <h2>Lectures</h2>
  <ul>
    <!-- Loop through the list of lectures -->
    <c:forEach var="lecture" items="${lectures}">
      <li>
        <!-- If the user has the ROLE_TEACHER -->
        <security:authorize access="hasRole('ROLE_TEACHER')">
          <!-- Link for teachers to view a lecture -->
          <a href="<c:url value='/teacher/lecture/${lecture.id}' />">${lecture.title}</a>

          <!-- Delete button for teachers -->
          <form method="post" action="<c:url value='/lecture/delete/${lecture.id}' />" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" style="color: red;">Delete</button>
          </form>
        </security:authorize>

        <!-- If the user is NOT a teacher -->
        <security:authorize access="!hasRole('ROLE_TEACHER')">
          <!-- Link for students to view a lecture -->
          <a href="<c:url value='/lecture/${lecture.id}' />">${lecture.title}</a>
        </security:authorize>
      </li>
    </c:forEach>
  </ul>

  <!-- Add Lecture Form (Visible only to teachers) -->
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
        <!-- Link to view the poll -->
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
        <security:authorize access="hasRole('ROLE_TEACHER')">
          <!-- Delete button for teachers -->
          <form method="post" action="<c:url value='/poll/delete/${poll.id}' />" style="display:inline;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" style="color: red;">Delete</button>
          </form>
        </security:authorize>
      </li>
    </c:forEach>
  </ul>

  <!-- Add Poll Section -->
  <security:authorize access="hasRole('ROLE_TEACHER')">
    <div class="section">
      <h2>Add Poll</h2>
      <form method="post" action="<c:url value='/poll/add' />">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <!-- Poll Question -->
        <label for="question">Poll Question:</label>
        <input type="text" id="question" name="question" required />

        <!-- Poll Options -->
        <label for="option1">Option 1:</label>
        <input type="text" id="option1" name="options" required />

        <label for="option2">Option 2:</label>
        <input type="text" id="option2" name="options" required />

        <label for="option3">Option 3:</label>
        <input type="text" id="option3" name="options" required />

        <label for="option4">Option 4:</label>
        <input type="text" id="option4" name="options" required />

        <!-- Submit Button -->
        <button type="submit">Add Poll</button>
      </form>
    </div>
  </security:authorize>
</div>






</body>


</html>