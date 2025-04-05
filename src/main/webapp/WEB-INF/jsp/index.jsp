<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
  <title>Welcome</title>
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
<h1>Welcome to the Portal</h1>

<div>
  <!-- Show login and register links for anonymous users -->
  <security:authorize access="isAnonymous()">
    <p>
      Please <a href="<c:url value='/login' />">log in</a>.
      If you haven't created an account, <a href="<c:url value='/register' />">sign up</a>.
    </p>
  </security:authorize>

  <!-- Show dashboard link for authenticated users -->
  <security:authorize access="isAuthenticated()">
    <p>Welcome back! <a href="<c:url value='/index' />">Go to your dashboard</a>.</p>
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
        <!-- Link to the poll using poll_id -->
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
      </li>
    </c:forEach>
  </ul>
</div>

</body>
</html>