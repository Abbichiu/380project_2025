<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
  <title>Index Page</title>
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
    .welcome {
      margin-bottom: 20px;
      font-size: 1.2em;
      color: #555;
    }
  </style>
</head>
<body>
<h1>Welcome to the Portal</h1>

<!-- Display Login or Welcome Message -->
<div class="welcome">
  <!-- If the user is not authenticated -->
  <security:authorize access="isAnonymous()">
    <p>Please <a href="<c:url value='/login' />">login</a> with your account.</p>
  </security:authorize>

  <!-- If the user is authenticated -->
  <security:authorize access="isAuthenticated()">
    <p>Welcome, <security:authentication property="name" />!</p>
    <!-- Logout button -->
    <form action="<c:url value='/logout' />" method="POST">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <button type="submit">Logout</button>
    </form>
  </security:authorize>
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
        <a href="<c:url value='/lecture/${lecture.id}' />">${lecture.title}</a>
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
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>