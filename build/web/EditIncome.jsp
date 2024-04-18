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
         <form action="EditIncome.jsp?incomeSource=<%= request.getParameter("incomeSource") %>&incomeAmount=<%= request.getParameter("incomeAmount") %>" method="post">
            <div>
            <h1>Income Management</h1>
            <h2>Edit Income</h2>
            <p>
                <label for="txtIncomeSource">Source: </label>
                <input type="text" id="txtIncomeSource" name="txtIncomeSource" placeholder="Income Source" required />
            </p>
            <p>
                <label for="txtIncomeAmount">Amount: </label>
                <input type="text" id="txtIncomeAmount" name="txtIncomeAmount" placeholder="Income Amount" required />
            </p>
            <p>
                <input type="submit" id="btnAddIncome" name="btnAddIncome" value="Edit Income" />
                <Button type="button" id="btnAddExpense" name="btnBack" value="Back"><a href="IncomeManagement.jsp">Back</a></button>
            </p>
            </div>
            <%      
                
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                if(request.getParameter("btnAddIncome")!=null)
                {
                    String incomeSource = request.getParameter("incomeSource");
                    int incomeAmount = Integer.parseInt(request.getParameter("incomeAmount"));
                    String source = request.getParameter("txtIncomeSource");
                    int amount = Integer.parseInt(request.getParameter("txtIncomeAmount"));
                    Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/sample","app","app");
                    PreparedStatement ps = c.prepareStatement("update IncomeData set IncomeSource=?,IncomeAmount=? where IncomeSource=? and IncomeAmount=? and SessionName=?");
                    ps.setString(1, source);
                    ps.setInt(2, amount);
                    ps.setString(3, incomeSource);
                    ps.setInt(4, incomeAmount);
                    ps.setString(5, session.getAttribute("name").toString());
                    int i = ps.executeUpdate();
                    if(i>0)
                    {%><div class="afterText"> <p style="color:greenyellow">Data Updated...</p>
                    <% }else 
                    { %><p style="font-size: 27px; color: red; ">Something Wrong!</p> </div>
                    <% 
                    }
                    ps.close();
                    c.close();
                }
        %>
         </form>
    </body>
</html>
