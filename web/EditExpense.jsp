<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Page</title>
        <link rel="stylesheet" href="Style.css" />
    </head>
    <body>
        <form action="EditExpense.jsp?expenseCategory=<%= request.getParameter("expenseCategory") %>&expenseAmount=<%= request.getParameter("expenseAmount") %>" method="post">
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
                <input type="submit" id="btnAddExpense" name="btnAddExpense" value="Edit Expense" />
                <Button type="button" id="btnAddExpense" name="btnBack" value="Back"><a href="ExpenseManagement.jsp">Back</a></button>
            </p>
            </div>
            <%
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                if(request.getParameter("btnAddExpense")!=null)
                {
                    String expenseCategory = request.getParameter("expenseCategory");
                    int expenseAmount = Integer.parseInt(request.getParameter("expenseAmount"));
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    String category = request.getParameter("txtExpenseCategory");
                    int amount = Integer.parseInt(request.getParameter("txtExpenseAmount"));
                    PreparedStatement ps = c.prepareStatement("update ExpenseData set ExpenseCategory=?,ExpenseAmount=? where ExpenseCategory=? and ExpenseAmount=? and SessionName=?");
                    ps.setString(1, category);
                    ps.setInt(2, amount);
                    ps.setString(3, expenseCategory);
                    ps.setInt(4, expenseAmount);
                    ps.setString(5, session.getAttribute("name").toString());
                    int i = ps.executeUpdate();
                    if(i>0)
                    {%><div class="afterText"> <p style="color:greenyellow">Data Updated...</p>
                    <% }else 
                    { %><p style="font-size: 27px; color: red; text-align: center;">Something Wrong!</p> </div>
                    <% 
                    }
                    ps.close();
                }
        %>
        </form>
    </body>
</html>
