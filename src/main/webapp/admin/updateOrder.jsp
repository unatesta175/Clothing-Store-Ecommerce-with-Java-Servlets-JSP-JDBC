


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "Orders");
String activePage = (String) request.getAttribute("activePage");

//Redirect if the session is null
if (session.getAttribute("employee") == null) {
	response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="./includes/head.jsp"%>
<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">

		<!-- Preloader -->
		<%@include file="./includes/preloader.jsp"%>

		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links -->
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" data-widget="pushmenu"
					href="#" role="button"><i class="fas fa-bars"></i></a></li>
				<li class="nav-item d-none d-sm-inline-block"><a
					href="index.jsp" class="nav-link">Home</a></li>

			</ul>


		</nav>
		<!-- /.navbar -->


		<%@include file="./includes/sidebar.jsp"%>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">Update Order</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item"><a
									href="${pageContext.request.contextPath}/OrderController?action=listOrder">List
										Order</a></li>
								<li class="breadcrumb-item active">Update Order</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->







			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- left column -->
						<div class="col-md-6">

							<div class="card " style="border-radius: 10px;">
								<div class="card-header">
									<h3 class="card-title">Order Details</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form method="post" action="OrderController?action=updatestatus"
									class="form-horizontal">
									<div class="card-body">



										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Order
												ID</label>
											<div class="col-sm-8">
												<input readonly type="text" name="orderId"
													value="${order.id}" class="form-control"
													placeholder="Full name" style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Customer
											</label>
											<div class="col-sm-8">
												<input readonly type="email" name="email"
													value="${order.customer.name}" class="form-control"
													placeholder="Email Address" style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Phone
												Number </label>
											<div class="col-sm-8">
												<input readonly type="text" name="phone"
													value="${order.customer.phone}" class="form-control"
													placeholder="Phone no" style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Total
											</label>
											<div class="col-sm-8">
												<input readonly type="text" name="phone"
													value="RM<fmt:formatNumber value="${order.totalPrice}" type="number"
											minFractionDigits="2" maxFractionDigits="2" />"
													class="form-control" placeholder="Phone no"
													style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Order
												Date & Time </label>
											<div class="col-sm-8">
												<input readonly type="text" name="phone"
													value="${order.createdAt}" class="form-control"
													placeholder="Phone no" style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Status
											</label>
											<div class="col-sm-8">

												<select class="form-control" name="status"
													style="border-radius: 30px;">

													<option value="${order.status}" selected>${order.status}</option>
													<option value="Failed" >Failed</option>
													<option value="Processing" >Processing</option>
													<option value="Delivered">Delivered</option>


												</select>

											</div>
										</div>

										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Order Summary</label>
											<div class="col-sm-8">
												<div
													style="border: 1px solid #ddd; padding: 15px; border-radius: 10px;">

													<c:forEach var="item" items="${orderItems}"
														varStatus="status">
														<div class="d-flex align-items-center mb-4">
															<img src="${item.product.image}"
																alt="${item.product.name}"
																style="width: 80px; height: auto; margin-right: 15px;">
															<div>
																<strong>${item.product.name}</strong>
																<div class="d-flex align-items-center mt-2">
																	<input readonly type="number" class="form-control"
																		value="${item.quantity}" min="1"
																		style="width: 60px; margin-right: 10px; border-radius: 10px;">
																	<span><strong>RM ${item.price}</strong></span>
																</div>
															</div>
														</div>

														<!-- Add HR separator except for the last item -->
														<c:if test="${!status.last}">
															<hr>
														</c:if>
													</c:forEach>

												</div>
											</div>
										</div>



									</div>
									<!-- /.card-body -->
									<div class="card-footer ">
										<input type="submit" class="btn btn-warning"
											style="border-radius: 30px;" value="Submit Changes">
										<a href="OrderController?action=listorder"
											class="btn btn-primary float-right"
											style="border-radius: 30px;">Cancel</a>
									</div>
									<!-- /.card-footer -->
								</form>
							</div>

						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->



		</div>





		<%@include file="./includes/footer.jsp"%>
		<%@include file="./includes/flash.jsp"%>

	</div>
	<!-- ./wrapper -->


</body>
</html>
