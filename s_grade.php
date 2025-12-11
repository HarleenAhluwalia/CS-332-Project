<?php
require 'database.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Student Transcript</title>
</head>
<body>
<h1>Student Courses and Grades</h1>

<form method="post">
    Student CWID:
    <input type="text" name="cwid" required>
    <input type="submit" value="Show Transcript">
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cwid = $_POST['cwid'];

    $sql = "
        SELECT c.Cnum,
               c.Title,
               e.Snum,
               e.Grade
        FROM Enrollment e
        JOIN Section s
          ON e.Snum = s.Snum AND e.Cnum = s.Cnum
        JOIN Course c
          ON s.Cnum = c.Cnum
        WHERE e.CWID = ?
        ORDER BY c.Cnum, e.Snum;
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $cwid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo "<p>No courses found for that student.</p>";
    } else {
        echo "<table border='1'>
                <tr>
                    <th>Course #</th>
                    <th>Title</th>
                    <th>Section #</th>
                    <th>Grade</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['Cnum']}</td>
                    <td>{$row['Title']}</td>
                    <td>{$row['Snum']}</td>
                    <td>{$row['Grade']}</td>
                  </tr>";
        }
        echo "</table>";
    }
    $stmt->close();
}
?>

<p><a href="login.php">Back to main menu</a></p>
</body>
</html>
