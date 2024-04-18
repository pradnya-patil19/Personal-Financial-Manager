<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Personal Financial Manager</title>
    <link rel="stylesheet" href="Style.css" />
</head>
<body>
    <form action="Dashboard.jsp" method="post">
        <div>
            <h1>Welcome to Your Dashboard</h1>
            <h2>Financial Summary</h2>
            <%
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                PreparedStatement pse = c.prepareStatement("select * from ExpenseData");
                PreparedStatement psi = c.prepareStatement("select * from IncomeData");
                ResultSet incomeData = psi.executeQuery();
                ResultSet expenseData = pse.executeQuery();
                int totalExpense=0,totalIncome=0;
                while(incomeData.next())
                {
                    totalIncome = incomeData.getInt(2);
                }
                while(expenseData.next())
                {
                    totalExpense = expenseData.getInt(2);
                }
            %>
            <p>
                <strong>Total Income:</strong>
                <span id="lblTotalIncome"><%= totalIncome %></span>
            </p>
            <p>
                <strong>Total Expenses:</strong>
                <span id="lblTotalExpenses"><%= totalExpense %></span>
            </p>
            <p>
                <strong>Available Balance:</strong>
                <span id="lblAvailableBalance"><%= totalIncome-totalExpense %></span>
            </p>
            <p>
                <input type="submit" id="AdIn" name="AdIn" value="Manage Income" />
                <input type="submit" id="AdEx" name="AdEx" value="Manage Expenses" />
            </p>
            <br>
            <a href="Dashboard.jsp?sclose=logout" id="logout">Log Out</a>
        </div>
    </form>
    <% 
       if(request.getParameter("AdIn")!=null)
           response.sendRedirect("IncomeManagement.jsp");
       if(request.getParameter("AdEx")!=null)
           response.sendRedirect("ExpenseManagement.jsp");
       if(request.getParameter("sclose")!=null)
       {
           session.invalidate();
           response.sendRedirect("index.html");
       }
     %>        
</body>
</html>
