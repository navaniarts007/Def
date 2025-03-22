<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
            <jsp:include page="msg.jsp"></jsp:include>
            <a href="#" class="btn btn-success btn-sm float-right" data-target="#addEmployee" data-toggle="modal"><i class="fa fa-plus"></i> Add Employee</a>
            <h4 class="p-2" style="border-bottom:2px solid green;">Employee Management</h4>
            
            <div class="mb-3 d-flex justify-content-between">
                <input type="text" class="form-control" placeholder="Search Employees..." style="max-width: 300px;">
                <select class="form-control" style="max-width: 200px;">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Inactive</option>
                </select>
                <div>
                    <button class="btn btn-primary" onclick="exportToExcel()">Export to Excel</button>
                     <button class="btn btn-danger" onclick="exportToPDF()">Export to PDF</button>
                    <button class="btn btn-secondary" onclick="printTable()">Print</button>
                    
                </div>
            </div>
            <style>button {
    position: relative;
    z-index: 1;
    transition: all 0.3s ease-in-out;
}

button:hover {
    background-color: green !important; 
    color: white !important; 
    transform: scale(1.05);
}
            </style>
            <script>
    function printTable() {
        var printContents = document.querySelector(".table-container").innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
    </script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<script>
function exportToExcel() {
    let table = document.querySelector(".table-container table"); 
    let wb = XLSX.utils.book_new(); 
    let ws = XLSX.utils.table_to_sheet(table); 
    XLSX.utils.book_append_sheet(wb, ws, "Employees");
    XLSX.writeFile(wb, "Employee_Data.xlsx");
}
</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.19.2/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script>
function exportToPDF() {
    const { jsPDF } = window.jspdf;
    let doc = new jsPDF('l', 'pt', 'a4'); 
    let table = document.querySelector(".table-container");

    html2canvas(table).then(canvas => {
        let imgData = canvas.toDataURL('image/png');
        let imgWidth = 800; 
        let imgHeight = (canvas.height * imgWidth) / canvas.width; 
        doc.addImage(imgData, 'PNG', 20, 20, imgWidth, imgHeight);
        doc.save("Employee_Data.pdf");
    });
}
</script>

<div class="table-container"> 
                <table class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th>Employee ID</th>
                            <th>Photo</th>
                            <th>Full Name</th>
                            <th>Father's/Husband's Name</th>
                            <th>Spouse Name</th>
                            <th>Date of Birth</th>
                            <th>Education Qualification</th>
                            <th>Gender</th>
                            <th>Family Status</th>
                            <th>Date of Join</th>
                            <th>Blood Group</th>
                            <th>Phone Number</th>
                            <th>Emergency Phone</th>
                            <th>Email Address</th>
                            <th>Religion</th>
                            <th>Designation</th>
                            <th>Nationality</th>
                            <th>Address</th>
                            <th>Permanent Address</th>
                            <th>Location</th>
                            <th>Bank Name</th>
                            <th>Branch Name</th>
                            <th>Bank A/C Number</th>
                            <th>IFSC Code</th>
                            <th>Aadhaar Number</th>
                            <th>Income Tax Number</th>
                            <th>PF Account Number</th>
                            <th>ESI Number</th>
                            <th>Passport Number</th>
                            <th>Official Email Address</th>
                            <th>Marital Status</th>
                            <th>Department</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% String sql="SELECT * FROM employees";
                        List<Map<String,String>> data=DbHelper.executeDQL(sql);
                        for(Map<String,String> row : data) { %>
                        <tr>
                            <td><%= row.get("employee_id") %></td>
                            <td><img src="uploads/<%= row.get("photo") %>" width="50"></td>
                            <td><%= row.get("full_name") %></td>
                            <td><%= row.get("father_husband_name") %></td>
                            <td><%= row.get("spouse_name") %></td>
                            <td><%= row.get("dob") %></td>
                            <td><%= row.get("education_qualification") %></td>
                            <td><%= row.get("gender") %></td>
                            <td><%= row.get("family_status") %></td>
                            <td><%= row.get("date_of_join") %></td>
                            <td><%= row.get("blood_group") %></td>
                            <td><%= row.get("phone_number") %></td>
                            <td><%= row.get("emergency_phone") %></td>
                            <td><%= row.get("email_address") %></td>
                            <td><%= row.get("religion") %></td>
                            <td><%= row.get("designation") %></td>
                            <td><%= row.get("nationality") %></td>
                            <td><%= row.get("address") %></td>
                            <td><%= row.get("permanent_address") %></td>
                            <td><%= row.get("location") %></td>
                            <td><%= row.get("bank_name") %></td>
                            <td><%= row.get("branch_name") %></td>
                            <td><%= row.get("bank_ac_number") %></td>
                            <td><%= row.get("ifsc_code") %></td>
                            <td><%= row.get("aadhaar_number") %></td>
                            <td><%= row.get("income_tax_number") %></td>
                            <td><%= row.get("pf_account_number") %></td>
                            <td><%= row.get("esi_number") %></td>
                            <td><%= row.get("passport_number") %></td>
                            <td><%= row.get("email") %></td>
                            <td><%= row.get("marital_status") %></td>
                            <td><%= row.get("department") %></td>
                            <td>
                                <button class="btn btn-primary btn-sm">Edit</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<style>
.table-container {
    width: 100%;
    max-width: 100%;
    overflow-x: auto;
    white-space: nowrap; /* Prevents text from wrapping */
}
table {
    width: max-content; /* Table expands based on content */
    min-width: 100%;
    border-collapse: collapse;
}

th, td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ddd;
    min-width: 150px; /* Adjust this for better spacing */
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
th {
    resize: horizontal;
    overflow: auto;
}


.pagination {
    margin-top: 10px;
    display: flex;
    justify-content: center;
}

.pagination a {
    padding: 8px 12px;
    margin: 0 5px;
    text-decoration: none;
    background: #4CAF50;
    color: white;
    border-radius: 4px;
}</style>
<jsp:include page="footer.jsp"></jsp:include>