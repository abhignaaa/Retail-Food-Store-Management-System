let data = [];

// Add row to the table
function addRow() {
  const county = document.getElementById("county").value;
  const state = document.getElementById("state").value;
  const city = document.getElementById("city").value;


  if (!county || !state || !city) {
    alert("Please enter valid details");
    return;
  }

  const row = {
    county,
    state,
    city
  };
  data.push(row);
  renderTable();
  clearForm();
}

// Render the table with the updated data
function renderTable() {
  console.log(data,`row`)
  
  const table = document.getElementById("table");
  const tbody = table.getElementsByTagName("tbody")[0];
  tbody.innerHTML = "";
  for (let i = 0; i < data.length; i++) {
    const row = tbody.insertRow(i);
    const countyCell = row.insertCell(0);
    const statelCell = row.insertCell(1);
    const cityCell = row.insertCell(2);
    const actionCell = row.insertCell(3);
    countyCell.innerHTML = data[i].county;
    statelCell.innerHTML = data[i].state;
    cityCell.innerHTML = data[i].city;
    actionCell.innerHTML = `
			<button type="button" onclick="editRow(${i})">Edit</button>
			<button type="button" onclick="deleteRow(${i})">Delete</button>
		`;
  }
}

// Clear the form after adding a row
function clearForm() {
  document.getElementById("add-form").reset();
}

// Edit row in the table
function editRow(index) {
  const row = data[index];
  document.getElementById("county").value = row.county;
  document.getElementById("state").value = row.state;
  document.getElementById("city").value = row.city;

}

// Delete row from the table
function deleteRow(index) {
  data.splice(index, 1);
  renderTable();
}
