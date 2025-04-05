<!DOCTYPE html>
<html>
<head>
  <title>Voting History</title>
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
    .poll-question {
      color: #007bff;
    }
    .poll-question:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<h1>Your Voting History</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>
<form action="<c:url value='/logout' />" method="POST">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <button type="submit">Logout</button>
</form>

<%-- Check if there are any votes --%>
<c:if test="${not empty votingHistory}">
  <table>
    <thead>
    <tr>
      <th>Poll Question</th>
      <th>Option Selected</th>
      <th>Voted At</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="vote" items="${votingHistory}">
      <tr>
        <td>
          <a class="poll-question" href="<c:url value='/poll/${vote.poll.id}' />">
              ${vote.poll.question}
          </a>
        </td>
        <td>${vote.poll.options[vote.selectedOption]}</td>
        <td>${vote.votedAt}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</c:if>

<%-- If no votes are found --%>
<c:if test="${empty votingHistory}">
  <p>You have not voted in any polls yet.</p>
</c:if>

</body>
</html>