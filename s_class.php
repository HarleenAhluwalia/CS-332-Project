<?php
require 'database.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Course Sections</title>
</head>
<body>
<h1>List Sections of a Course</h1>

<form method="post">
    Course Number (Cnum):
    <input type="number" name="cnum" required>
    <input type="submit" value="List Sections">
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cnum = intval($_POST['cnum']);

    $sql = "
        SELECT s.Snum,
               s.Classroom,
               GROUP_CONCAT(DISTINCT md.Day ORDER BY md.Day SEPARATOR '') AS Days,
               s.BeginTime,
               s.EndTime,
               COUNT(DISTINCT e.CWID) AS NumStudents
        FROM Section s
        LEFT JOIN MeetingDays md
               ON md.Snum = s.Snum AND md.Cnum = s.Cnum
        LEFT JOIN Enrollment e
               ON e.Snum = s.Snum AND e.Cnum = s.Cnum
        WHERE s.Cnum = ?
        GROUP BY s.Snum, s.Classroom, s.BeginTime, s.EndTime
        ORDER BY s.Snum;
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $cnum);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo "<p>No sections found for that course.</p>";
    } else {
        echo "<table border='1'>
                <tr>
                    <th>Section #</th>
                    <th>Classroom</th>
                    <th>Meeting Days</th>
                    <th>Begin Time</th>
                    <th>End Time</th>
                    <th>Students Enrolled</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['Snum']}</td>
                    <td>{$row['Classroom']}</td>
                    <td>{$row['Days']}</td>
                    <td>{$row['BeginTime']}</td>
                    <td>{$row['EndTime']}</td>
                    <td>{$row['NumStudents']}</td>
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
