<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Income Management - Personal Financial Manager</title>
    <link rel="stylesheet" href="Style.css" />
</head>
<body>
    <form action="IncomeManagement.jsp" method="post">
        <div>
            <h1>Income Management</h1>
            <h2>Add New Income</h2>
            <p>
                <label for="txtIncomeSource">Source: </label>
                <input type="text" id="txtIncomeSource" name="txtIncomeSource" placeholder="Income Source" required />
            </p>
            <p>
                <label for="txtIncomeAmount">Amount: </label>
                <input type="text" id="txtIncomeAmount" name="txtIncomeAmount" placeholder="Income Amount" required />
            </p>
            <p>
                <input type="submit" id="btnAddIncome" name="btnAddIncome" value="Add Income" />
                <Button type="button" id="btnAddExpense" name="btnBack" value="Back"><a href="Dashboard.jsp">Back</a></button>
            </p>
            <%      
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                if(request.getParameter("btnAddIncome")!=null)
                {
                    String source = request.getParameter("txtIncomeSource");
                    int amount = Integer.parseInt(request.getParameter("txtIncomeAmount"));
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    PreparedStatement ps = c.prepareStatement("insert into IncomeData values(?,?,?)");
                    ps.setString(1, source);
                    ps.setInt(2, amount);
                    ps.setString(3, session.getAttribute("name").toString());
                    int i = ps.executeUpdate();
                    if(i>0)
                    {%><div class="afterText"> <p style="color:greenyellow">Data Added...</p>
                    <% }else 
                    { %><p style="font-size: 27px; color: red; text-align: center;">Something Wrong!</p> </div>
                    <% 
                    }
                    ps.close();
                    c.close();
                }
            %>
            <br>
            <h2>Income List</h2>
            <table border="2" id="Incomeview">
                <tr>
                    <th>Income Source</th>
                    <th>Income Amount</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <%
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    PreparedStatement ps = c.prepareStatement("select * from IncomeData");
                    ResultSet incomeData = ps.executeQuery();
                    while(incomeData.next())
                    {
                %>
                    <tr>
                        <td><%= incomeData.getString(1) %></td>
                        <td><%= incomeData.getInt(2) %></td>
                        <td><a href="EditIncome.jsp?incomeSource=<%= incomeData.getString(1) %>&incomeAmount=<%= incomeData.getInt(2) %>">Edit</a></td>
                        <td><a href="IncomeManagement.jsp?incomeSource=<%= incomeData.getString(1) %>&incomeAmount=<%= incomeData.getInt(2) %>&del=true">Delete</a></td>
                    </tr>
                <%
                    }
                    incomeData.close();
                    ps.close();
                    
                    if(request.getParameter("del")!=null)
                    {
                        String incomeSource = request.getParameter("incomeSource");
                        int incomeAmount = Integer.parseInt(request.getParameter("incomeAmount"));
                        PreparedStatement psd = c.prepareStatement("Delete from IncomeData where IncomeSource=? and IncomeAmount=? and SessionName=?");
                        psd.setString(1, incomeSource);
                        psd.setInt(2, incomeAmount);
                        psd.setString(3, session.getAttribute("name").toString());
                        psd.executeUpdate();
                        psd.close(); 
                    }
                %>
            </table>
        </div>
    </form>
</body>
</html>
