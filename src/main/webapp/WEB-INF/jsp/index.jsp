<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
  <title>Welcome</title>
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
      color: #005eff; /* blue text */
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

    .section {
      margin-bottom: 30px;
      padding: 15px;
      background-color: white; /* White background for sections */
      border: 1px solid #ddd; /* Light grey border */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
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
<h1>Welcome to the Online Course Website</h1>

<div>
  <security:authorize access="isAnonymous()">
    <p>
      Please <a href="<c:url value='/login' />">log in</a>.
      If you haven't created an account, <a href="<c:url value='/register' />">sign up</a>.
    </p>
  </security:authorize>

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
        <a href="<c:url value='/poll/${poll.id}' />">${poll.question}</a>
      </li>
    </c:forEach>
  </ul>
</div>

</body>
</html>