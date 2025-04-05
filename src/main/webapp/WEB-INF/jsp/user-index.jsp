<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
  <title>User Dashboard</title>
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
<h1>User Dashboard</h1>

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
    <h2>Teacher Tools</h2>
    <ul>
      <li>
        <a href="<c:url value='/teacher/users' />">Manage Users</a>
      </li>
    </ul>
  </div>
</security:authorize>

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
        <!-- If the user has the ROLE_TEACHER role, show the teacher version -->
        <security:authorize access="hasRole('ROLE_TEACHER')">
          <a href="<c:url value='/teacher/lecture/${lecture.id}' />">${lecture.title}</a>
        </security:authorize>
        <!-- If the user does NOT have the ROLE_TEACHER role, show the student version -->
        <security:authorize access="!hasRole('ROLE_TEACHER')">
          <a href="<c:url value='/lecture/${lecture.id}' />">${lecture.title}</a>
        </security:authorize>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Display Polls -->
<div class="section">
  <h2>Polls</h2>
  <ul>
    <c:forEach var="poll" items="${polls}">
      <li>
        <!-- Link to the poll using poll_id -->
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>