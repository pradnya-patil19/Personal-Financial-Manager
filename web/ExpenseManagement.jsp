<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Expense Management - Personal Financial Manager</title>
    <link rel="stylesheet" href="Style.css" />
</head>
<body>
    <form action="ExpenseManagement.jsp" method="post">
        <div>
            <h1>Expense Management</h1>
            <h2>Add New Expense</h2>
            <p>
                <label for="txtExpenseCategory">Category: </label>
                <input type="text" id="txtExpenseCategory" name="txtExpenseCategory" placeholder="Expense Category" required />
            </p>
            <p>
                <label for="txtExpenseAmount">Amount: </label>
                <input type="text" id="txtExpenseAmount" name="txtExpenseAmount" placeholder="Expense Amount" required />
            </p>
            <p>
                <input type="submit" id="btnAddExpense" name="btnAddExpense" value="Add Expense" />
                <Button type="button" id="btnAddExpense" name="btnBack" value="Back"><a href="Dashboard.jsp">Back</a></button>
            </p>
            <%
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                if(request.getParameter("btnAddExpense")!=null)
                {
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    String category = request.getParameter("txtExpenseCategory");
                    int amount = Integer.parseInt(request.getParameter("txtExpenseAmount"));
                    PreparedStatement ps = c.prepareStatement("insert into ExpenseData values(?,?,?)");
                    ps.setString(1, category);
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
                }
            %>
            <br>
            <h2>Expense List</h2>
            <table border="2" id="Incomeview">
                <tr>
                    <th>Expense Category</th>
                    <th>Expense Amount</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                 <%
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    PreparedStatement ps = c.prepareStatement("select * from ExpenseData");
                    ResultSet expenseData = ps.executeQuery();
                    while(expenseData.next())
                    {
                %>
                    <tr>
                        <td><%= expenseData.getString(1) %></td>
                        <td><%= expenseData.getString(2) %></td>
                        <td><a href="EditExpense.jsp?expenseCategory=<%= expenseData.getString(1) %>&expenseAmount=<%= expenseData.getInt(2) %>">Edit</a></td>
                        <td><a href="ExpenseManagement.jsp?expenseCategory=<%= expenseData.getString(1) %>&expenseAmount=<%= expenseData.getInt(2) %>&del=true">Delete</a></td>
                    </tr>
                <%
                    }
                    expenseData.close();
                    ps.close();
                    
                    if(request.getParameter("del")!=null)
                    {
                        String expenseCategory = request.getParameter("expenseCategory");
                        int expenseAmount = Integer.parseInt(request.getParameter("expenseAmount"));
                        PreparedStatement psd = c.prepareStatement("Delete from ExpenseData where ExpenseCategory=? and ExpenseAmount=? and SessionName=?");
                        psd.setString(1, expenseCategory);
                        psd.setInt(2, expenseAmount);
                        ps.setString(3, session.getAttribute("name").toString());
                        psd.executeUpdate();
                        psd.close(); 
                    }
                %>
            </table>
        </div>
    </form>
</body>
</html>
