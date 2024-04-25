<%@ page import="java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<%
		int transactAccount = Integer.parseInt(request.getParameter("account_Number")); 
		String transactionAmount = request.getParameter("transaction_Amount");
		String transactionType = request.getParameter("transactions");
		transactionType = transactionType.toLowerCase();
		ArrayList<String[]> customers1 = (ArrayList<String[]>) session.getAttribute("customers");
		String[] account1 = customers1.get(transactAccount);
		double transactAmount = Double.parseDouble(transactionAmount);
    	double balance = Double.parseDouble(account1[3]);
	%>
	
  <!-- Navbar -->

  <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
    <div class="container">
      <a class="navbar-brand" href="#">Bank Management System</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="#addAccount">Add Account</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#transactions">Transactions</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#displayAccounts">All Accounts</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
  <!-- Alert Box -->

  <div class="alert alert-success alert-dismissible fade show" role="alert">
  	
  	<%
  		if(transactionType.equals("deposit")){
  			balance += transactAmount;
  			account1[3] = Double.toString(balance);
  	%>
  		<p>Rs.<%= transactAmount%> deposited in account <%= customers1.indexOf(account1)%></p>
  	<%
  		}
  		else if(transactionType.equals("withdraw")){
  			if(balance > transactAmount){
  				balance -= transactAmount;
  				account1[3] = Double.toString(balance);
  	%>
  		<p>Rs.<%= transactAmount%> withdrawn from account <%= customers1.indexOf(account1)%></p>
  	<%
  			}else{
  				out.println("Insufficient Fund!!");
  			}
  		}
  	%>	
    <p>Transaction done successfully!!</p>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  

  <!-- Add Customer Section -->

  <div class="container mt-5">
    <section id="addAccount">
      <h2>Add Bank Account</h2>
      <form action="newAccount.jsp" method="post">
        <div class="mb-3">
          <label for="customerName" class="form-label">Customer Name</label>
          <input type="text" class="form-control" id="customerName" placeholder="Enter Customer Name" name="customer_Name" required>
        </div>
        <div class="mb-3">
          <label for="customerAddress" class="form-label">Customer Address</label>
          <input type="text" class="form-control" id="customerAddress" placeholder="Enter Customer Address" name="customer_Address" required>
        </div>
        <div class="mb-3">
          <label for="customerPhone" class="form-label">Customer Phone Number</label>
          <input type="tel" class="form-control" id="customerPhone" placeholder="Enter Customer Phone Number" name="customer_Phone" required>
        </div>
        <div class="mb-3">
          <label for="customerPhone" class="form-label">Initial Deposit Amount</label>
          <input type="tel" class="form-control" id="initialDeposit" placeholder="Enter Initial Deposit Amount" name="initial_Deposit" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
    </section>

    <hr>

    <!-- Transactions Section -->

    <section id="transactions">
      <h2>Transactions</h2>
      <form action="addTransaction.jsp" method="post">
        <div class="mb-3">
          <label for="accountNumber" class="form-label">Account Number</label>
          <input type="text" class="form-control" id="accountNumber" placeholder="Enter Account Number" name="account_Number" required>
        </div>
        <div class="mb-3">
          <label for="transactionType" class="form-label">Transaction Type</label>
          <input type="text" class="form-control" id="transactionType" placeholder="Enter Transaction Type" name="transactions" required>
        </div>
        <div class="mb-3">
          <label for="amount" class="form-label">Amount</label>
          <input type="number" class="form-control" id="amount" placeholder="Enter Amount" name="transaction_Amount" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
    </section>

    <hr>

    <!-- Display Accounts Section -->

    <section id="displayAccounts">
      <h2>All Bank Accounts</h2>
      <% 
        ArrayList<String[]> customer = (ArrayList<String[]>) session.getAttribute("customers");
        if (customer != null) {
            Iterator<String[]> iterator = customer.iterator();
            while (iterator.hasNext()) {
                String[] customer1= iterator.next();
                int len = customer1.length;
                int index = customer.indexOf(customer1);
      %>
      <p><strong>Account Number:</strong> <%= index%></p>
      <p><strong>Name:</strong> <%= customer1[0] %></p>
      <p><strong>Address:</strong> <%= customer1[1] %></p>
      <p><strong>Phone Number:</strong> <%= customer1[2] %></p>
      <p><strong>Account Balance:</strong> <%= customer1[3] %></p>
    <hr>
     <% 
            }
        } 
     %>
    </section>
  </div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>