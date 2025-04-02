<!DOCTYPE html>
<html>
<head>
  <title>Poll Result</title>
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
    .votes {
      font-weight: bold;
    }
    .highlight {
      color: #fff;
      background-color: #007bff;
      padding: 2px 5px;
      border-radius: 4px;
    }
    .comments {
      margin-top: 20px;
    }
    .comment {
      margin-bottom: 15px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      background-color: #f9f9f9;
    }
    .comment .username {
      font-weight: bold;
      color: #007bff;
    }
    .comment .role {
      font-style: italic;
      color: #666;
    }
  </style>
</head>
<body>
<h1>Poll Result</h1>
<h2>${poll.question}</h2>

<!-- Display poll options with vote counts -->
<ul>
  <c:forEach var="option" items="${poll.options}" varStatus="status">
    <li>
      <span class="votes ${selectedOptions.contains(option) ? 'highlight' : ''}">
        ${option} - ${voteCounts[status.index]} votes
      </span>
    </li>
  </c:forEach>
</ul>

<!-- Display list of comments -->
<div class="comments">
  <h2>Comments</h2>
  <c:choose>
    <c:when test="${not empty poll.comments}">
      <c:forEach var="comment" items="${poll.comments}">
        <div class="comment">
          <p>
            <span class="username">${comment.user.username}</span>
            (<span class="role">${comment.user.role}</span>):
          </p>
          <p>${comment.content}</p>
        </div>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <p>No comments available for this poll.</p>
    </c:otherwise>
  </c:choose>
</div>

<a href="/">Back to Index</a>
</body>
</html>