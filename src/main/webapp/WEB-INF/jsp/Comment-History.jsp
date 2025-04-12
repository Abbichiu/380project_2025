<!DOCTYPE html>
<html>
<head>
  <title>Comment History</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      background-color: #f4f4f4; /* Light grey background */
      color: #333; /* Dark text color */
    }
    h1 {
      color: #333;
      text-align: center; /* Center the heading */
    }
    .back-button {
      display: inline-block; /* Make the link a block element */
      margin-bottom: 20px; /* Space below the link */
      color: #007bff; /* Blue link color */
      font-weight: bold; /* Bold text */
      text-decoration: none; /* No underline */
      text-align: center; /* Center the link */
    }
    .back-button:hover {
      text-decoration: underline; /* Underline on hover */
    }
    table {
      width: 100%;
      border-collapse: collapse; /* Collapse borders */
      margin-top: 20px; /* Space above the table */
      background: white; /* White background for the table */
      border-radius: 5px; /* Rounded corners */
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    }
    table th, table td {
      border: 1px solid #ddd; /* Light grey border */
      padding: 12px; /* Padding inside cells */
      text-align: left; /* Left align text */
    }
    table th {
      background-color: #f2f2f2; /* Light grey background for header */
      font-weight: bold; /* Bold text for header */
    }
    .lecture-title {
      color: #007bff; /* Blue color for lecture titles */
      text-decoration: none; /* No underline */
    }
    .lecture-title:hover {
      text-decoration: underline; /* Underline on hover */
    }
    .poll-title {
      color: #28a745; /* Green color for poll titles */
      text-decoration: none; /* No underline */
    }
    .poll-title:hover {
      text-decoration: underline; /* Underline on hover */
    }
    p {
      text-align: center; /* Center the message */
      font-size: 1.1em; /* Slightly larger font size */
    }
  </style>
</head>
<body>
<h1>Comment History</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
<%-- Display comments grouped by lectures and polls --%>
<table>
  <thead>
  <tr>
    <th>Content</th>
    <th>Commented On</th>
    <th>Commented By</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="comment" items="${comments}">
    <tr>
      <td>${comment.content}</td>
      <td>
        <c:choose>
          <%-- Check if the comment is linked to a lecture --%>
          <c:when test="${not empty comment.lecture}">
            <a class="lecture-title" href="<c:url value='/lecture/${comment.lecture.id}' />">
              Lecture: ${comment.lecture.title}
            </a>
          </c:when>
          <%-- Check if the comment is linked to a poll --%>
          <c:when test="${not empty comment.poll}">
            <a class="poll-title" href="<c:url value='/poll/${comment.poll.id}' />">
              Poll: ${comment.poll.question}
            </a>
          </c:when>
          <%-- If neither, display "Unknown" --%>
          <c:otherwise>
            Unknown
          </c:otherwise>
        </c:choose>
      </td>
      <td>${comment.user.fullName} (${comment.user.username})</td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>
