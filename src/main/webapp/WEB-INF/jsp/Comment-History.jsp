<!DOCTYPE html>
<html>
<head>
  <title>Comment History</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    h1 {
      color: #333;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    table th, table td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    table th {
      background-color: #f2f2f2;
      font-weight: bold;
    }
    .lecture-title {
      color: #007bff;
    }
    .lecture-title:hover {
      text-decoration: underline;
    }
    .poll-title {
      color: #28a745;
    }
    .poll-title:hover {
      text-decoration: underline;
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
