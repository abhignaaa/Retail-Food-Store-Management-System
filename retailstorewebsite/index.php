<!DOCTYPE html>
<html>
<head>
	<title>Retail Store Management</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h2>Retail Store Management</h2>
	<form id="add-form" method="POST">
		<label>County:</label>
		<input type="text" id="county" name="county">

		<label>State:</label>
		<input type="text" id="state" name="state">
    <label>City:</label>
		<input type="text" id="city" name="city">

		<button type="submit" name="add">Add</button>
	</form>
	<table id="table">
		<thead>
			<tr>
				<th>County</th>
				<th>State</th>
				<th>City</th>
        
				
			</tr>
		</thead>
		<tbody>
			<?php renderTable(); ?>
		</tbody>
	</table>
	<script src="app.js"></script>
</body>
</html>

<?php

// Function to render the table
function renderTable() {
    // Connect to the database (you will need to fill in the details)
    $host = 'sql12.freemysqlhosting.net';
    $dbname = 'sql12617381';
    $username = 'sql12617381';
    $password = 'Y6Tpm3hpkD';
    $db = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);

    // Select the database
    $db->exec("USE $dbname");

    // Get the data from the database
    $stmt = $db->query("SELECT * FROM mytable");
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Render the table rows
    foreach ($data as $row) {
        echo "<tr>";
        echo "<td>{$row['county']}</td>";
        echo "<td>{$row['state']}</td>";
        echo "<td>{$row['city']}</td>";
      

        echo "</tr>";
    }
}

// Handle the form submission
if (isset($_POST['add'])) {
    // Connect to the database (you will need to fill in the details)
    $host = 'sql12.freemysqlhosting.net';
    $dbname = 'sql12617381';
    $username = 'sql12617381';
    $password = 'Y6Tpm3hpkD';
    $db = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);

    // Select the database
    $db->exec("USE $dbname");

    // Insert the new row into the database
    $stmt = $db->prepare("INSERT INTO mytable (county, state, city) VALUES (?, ?, ?)");
    $stmt->execute([$_POST['county'], $_POST['state'],$_POST['city']]);

    // Redirect back to the index page
    // header("Location: public_html/index.php");
    exit;
}
?>