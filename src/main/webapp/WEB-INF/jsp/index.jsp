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
    .poll-form {
      margin-left: 20px;
      font-size: 0.9em;
    }
    .poll-submit-btn {
      margin-top: 10px;
    }
  </style>
</head>
<body>
<h1>Welcome to the Portal</h1>

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
        <!-- Poll question -->
        <span>${poll.question}</span>

        <!-- Poll selection form -->
        <form class="poll-form" action="/poll/vote" method="post">
          <input type="hidden" name="pollId" value="${poll.id}" />
          <!-- Display options as checkboxes -->
          <c:forEach var="option" items="${poll.options}">
            <div>
              <label>
                <input type="checkbox" name="selectedOptions" value="${option}" />
                  ${option}
              </label>
            </div>
          </c:forEach>
          <button type="submit" class="poll-submit-btn">Submit</button>
        </form>
      </li>
    </c:forEach>
  </ul>
</div>
</body>
</html>