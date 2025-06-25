



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
							<h1 class="m-0">Order List</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item active">Order List</li>
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
						<div class="col-12">
							<div class="card" style="border-radius: 10px;">
								<div class="card-header ">

									<h4 class=" ">Orders List</h4>

								</div>
								<!-- /.card-header -->

								<div class="card-body">

									<table id="example1" class="table table-bordered table-striped">
										<thead>

											<tr>
												<th>Order ID</th>
												<th>Customer</th>
												<th>Email</th>
												<th>Phone Number</th>
												<th>Status</th>
												<th>Payment</th>
												<th>Total</th>
												<th>Order created At</th>
												<th>Last Update</th>
												<th>Action</th>


											</tr>
										</thead>
										<tbody>
											<c:forEach items="${orders}" var="order">
												<tr>
													<td>${order.id}</td>
													<td>${order.customer.name}</td>
													<td>${order.customer.email}</td>
													<td>${order.customer.phone}</td>
													<td><c:choose>
															<c:when
																test="${order.status == 'Pending' || order.status == 'Failed' }">
																<span class="badge badge-danger">Failed</span>

															</c:when>

															<c:when test="${order.status == 'Processing' }">
																<span class="badge badge-info">${order.status}</span>
															</c:when>
															<c:otherwise>
																<span class="badge badge-success">${order.status}</span>
															</c:otherwise>
														</c:choose></td>
													<td><c:choose>
															<c:when test="${order.payment.status == 'Pending' ||order.payment.status == 'Failed'||order.payment.status == null}">
																<span class="badge badge-danger">Failed</span>

															</c:when>

															<c:otherwise>
																<span class="badge badge-success">${order.payment.status}</span>
															</c:otherwise>
														</c:choose></td>
													<td>RM<fmt:formatNumber value="${order.totalPrice}"
															type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
													<td><fmt:formatDate value="${order.createdAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>
													<td><fmt:formatDate value="${order.updatedAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>
													<td>
														<div
															class="d-flex justify-content-center align-items-center gap-2">


															<c:choose>
																<c:when test="${order.payment.status == 'Completed' }">
																	<a
																		href="${pageContext.request.contextPath}/OrderController?action=updateOrder&oid=<c:out value="${order.id}" />"
																		class="btn btn-warning btn-sm"
																		style="margin-right: 4px !important;"> <i
																		class="fas fa-edit"></i>
																	</a>
																	<a
																		href="${pageContext.request.contextPath}/OrderController?action=generateReceipt&oid=<c:out value="${order.id}" />"
																		class="btn btn-secondary btn-sm"> <i
																		class="fas fa-print"></i>
																	</a>
																</c:when>
																<c:otherwise>

																	<a
																		href="${pageContext.request.contextPath}/OrderController?action=updateOrder&oid=<c:out value="${order.id}" />"
																		class="btn btn-warning btn-sm"
																		style="margin-right: 4px !important;"> <i
																		class="fas fa-edit"></i>
																	</a>

																</c:otherwise>
															</c:choose>




														</div>
													</td>
												</tr>



											</c:forEach>


										</tbody>

									</table>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->



		</div>





		<%@include file="./includes/footer.jsp"%>

		<%@include file="./includes/flash.jsp"%>

	</div>
	<!-- ./wrapper -->


</body>
</html>
