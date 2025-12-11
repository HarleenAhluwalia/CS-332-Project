<?php
require 'database.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Section Grade Distribution</title>
</head>
<body>
<h1>Grade Distribution for a Section</h1>

<form method="post">
    Course Number (Cnum):
    <input type="number" name="cnum" required>
    Section Number (Snum):
    <input type="number" name="snum" required>
    <input type="submit" value="Count Grades">
</form>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $cnum = intval($_POST['cnum']);
    $snum = intval($_POST['snum']);

    $sql = "
        SELECT Grade, COUNT(*) AS NumStudents
        FROM Enrollment
        WHERE Cnum = ? AND Snum = ?
        GROUP BY Grade
        ORDER BY Grade;
    ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $cnum, $snum);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo "<p>No enrollment records found for that section.</p>";
    } else {
        echo "<table border='1'>
                <tr>
                    <th>Grade</th>
                    <th>Number of Students</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['Grade']}</td>
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
