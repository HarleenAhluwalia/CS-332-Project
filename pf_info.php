<?php
require 'database.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Professor Schedule</title>
</head>
<body>
<h1>Professor Schedule Lookup</h1>

<form method="post">
    Professor SSN:
    <input type="text" name="ssn" required>
    <input type="submit" value="Search">
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ssn = $_POST['ssn'];

    $sql = "
        SELECT c.Title,
               s.Snum,
               s.Classroom,
               GROUP_CONCAT(DISTINCT md.Day ORDER BY md.Day SEPARATOR '') AS Days,
               s.BeginTime,
               s.EndTime
        FROM Professor p
        JOIN Section s
          ON p.SSN = s.TeachSSN
        JOIN Course c
          ON s.Cnum = c.Cnum
        LEFT JOIN MeetingDays md
          ON md.Snum = s.Snum AND md.Cnum = s.Cnum
        WHERE p.SSN = ?
        GROUP BY c.Title, s.Snum, s.Classroom, s.BeginTime, s.EndTime
        ORDER BY c.Cnum, s.Snum;
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $ssn);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo "<p>No sections found for that professor.</p>";
    } else {
        echo "<table border='1'>
                <tr>
                    <th>Course Title</th>
                    <th>Section #</th>
                    <th>Classroom</th>
                    <th>Meeting Days</th>
                    <th>Begin Time</th>
                    <th>End Time</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['Title']}</td>
                    <td>{$row['Snum']}</td>
                    <td>{$row['Classroom']}</td>
                    <td>{$row['Days']}</td>
                    <td>{$row['BeginTime']}</td>
                    <td>{$row['EndTime']}</td>
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
