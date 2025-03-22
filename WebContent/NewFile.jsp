<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h1>Database Connection Status</h1>
    <%
        String url = "jdbc:mariadb://mysql-navanidhiram.alwaysdata.net:3306/navanidhiram_def";
        String user = "405212";
        String password = "Excel_students@007";
        Connection conn = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                out.println("<p style='color:green;'>Successfully connected to the database.</p>");
            } else {
                out.println("<p style='color:red;'>Failed to make a connection.</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>SQL Exception: " + e.getMessage() + "</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p style='color:red;'>Class Not Found Exception: " + e.getMessage() + "</p>");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    out.println("<p style='color:red;'>Error closing connection: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>
