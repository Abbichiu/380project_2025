<!DOCTYPE html>
<html>
<head>
  <title>Voting History</title>
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
    .poll-question {
      color: #007bff; /* Blue color for poll questions */
      text-decoration: none; /* No underline */
    }
    .poll-question:hover {
      text-decoration: underline; /* Underline on hover */
    }
    p {
      text-align: center; /* Center the message */
      font-size: 1.1em; /* Slightly larger font size */
    }
  </style>
</head>
<body>
<h1>Your Voting History</h1>
<!-- Back Button -->
<a href="<c:url value='/index' />" class="back-button">Back to Dashboard</a>

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