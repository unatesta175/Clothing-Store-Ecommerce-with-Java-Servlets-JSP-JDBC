<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<html lang="en">
<head>

<link rel="apple-touch-icon" sizes="180x180"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="shortcut icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="manifest"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<meta name="msapplication-TileImage"
	content="<%=request.getContextPath()%>/images/logo-expose.png">
<meta name="theme-color" content="#ffffff">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Expose Print | Receipt Print</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/admin/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/admin/dist/css/adminlte.min.css">
</head>
<body>
	<div class="wrapper">
		<!-- Main content -->
		<section class="invoice">
			<!-- title row -->
			<div class="row">
				<div class="col-12">
					<h2 class="page-header">
						<img src="${pageContext.request.contextPath}/admin/dist/img/logo-expose.png" width="75" >Expose Print <small
							class="float-right">Date: ${payment.createdAt}</small>
					</h2>
				</div>
				<!-- /.col -->
			</div>
			<!-- info row -->
			<div class="row invoice-info">
				<div class="col-sm-4 invoice-col">
					From
					<address>
						<strong>Expose Printing, Inc.</strong><br> A-1, 07, Jalan SS
						6 / 5a, Dataran Glomac, 47301 Petaling Jaya, Selangor<br>
						Phone: (804) 123-5432<br> Email: info@exposeprinting.com
					</address>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 invoice-col">
					To
					<address>
						<strong>${order.customer.name}</strong><br>${order.customer.address}<br>
						Phone: ${order.customer.phone}<br> Email: ${order.customer.email}
					</address>
				</div>
				<!-- /.col -->
				<div class="col-sm-4 invoice-col">
					<b>Invoice #007612</b><br> <br> <b>Order ID:</b>
					${order.id}<br> <b>Payment Date:</b> ${payment.createdAt}<br>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->

			<!-- Table row -->
			<div class="row">
				<div class="col-12 table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Qty</th>
								<th>Product</th>
								<th>Category</th>
								<th>Size</th>
								<th>Price (unit)</th>
								<th>Subtotal</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>

								<c:when test="${ not empty orderItems}">

									<c:forEach items="${orderItems}" var="item">
										<tr>
											<td>${item.quantity}</td>
											<td>${item.product.name}</td>
											<td>${item.product.category}</td>
											<td>${item.product.size}</td>
											<td>RM<fmt:formatNumber value="${item.product.price}"
													type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
											<td>RM<fmt:formatNumber
													value="${item.product.price*item.quantity}" type="number"
													minFractionDigits="2" maxFractionDigits="2" /></td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>


						</tbody>
					</table>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->

			<div class="row">
				<!-- accepted payments column -->
				<div class="col-6">
					<p class="lead">Payment Methods:</p>
					 <img
						src="${pageContext.request.contextPath}/admin/dist/img/credit/toyyibpay.png"
						alt="ToyyibPay">

				
				</div>
				
			
				<!-- /.col -->
				<div class="col-6">
					<p class="lead">Amount Paid on  ${payment.createdAt}</p>

					<div class="table-responsive">
						<table class="table">
							<tr>
								<th style="width: 50%">Total:</th>
								<td>RM<fmt:formatNumber value="${order.totalPrice}"
													type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
							</tr>
						
						</table>
					</div>
				</div>
				<!-- /.col -->
			</div>
			
				<br>
				<br>
				
			<!-- /.row -->
		</section>
		<!-- /.content -->
	</div>
	<!-- ./wrapper -->
	<!-- Page specific script -->
	<script>
		window.addEventListener("load", window.print());
	</script>
</body>
</html>
