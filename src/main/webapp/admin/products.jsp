
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "products");
String activePage = (String) request.getAttribute("activePage");

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
					href="${pageContext.request.contextPath}/admin/index.jsp" class="nav-link">Home</a></li>

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
							<h1 class="m-0">Products List</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/index.jsp">Home</a></li>
								<li class="breadcrumb-item active">Products</li>
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
									<a
										href="${pageContext.request.contextPath}/ProductController?action=create"><button
											type="submit" class="btn btn-primary float-right"
											style="border-radius: 30px;">Create Product</button></a>
									<h4 class=" ">Products Details</h4>

								</div>
								<!-- /.card-header -->

								<div class="card-body">

									<table id="example1" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>No.</th>
												<th>Product</th>
												<th>Image</th>
												<th>Type</th>
												<th>Category</th>
												<th>Size</th>
												<th>Price</th>

												<th>Stock</th>
												<th>Created At</th>
												<th>Updated At</th>
												<th>Action</th>


											</tr>
										</thead>
										<tbody>

											<c:forEach items="${products}" var="product"
												varStatus="status">




												<tr>
													<td><c:out value="${status.index + 1}" /></td>
													<td><c:out value="${product.name}" /></td>
													<td><img src="<c:out value="${ product.image }" />"
														alt="Product Image" width="60" height="60"></td>
													<td><c:out value="${product.type}" /></td>
													<td><c:out value="${product.category}" /></td>
													<td><c:out value="${product.size}" /></td>
													<td>RM <fmt:formatNumber value="${product.price}"
															type="number" minFractionDigits="2" maxFractionDigits="2" /></td>

													<td><c:out value="${product.stock}" /></td>
													<td><fmt:formatDate value="${product.createdAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>
												<td><fmt:formatDate value="${product.updatedAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>
													<td>
														<div class="d-flex">
															<a
																href="${pageContext.request.contextPath}/ProductController?action=update&pid=<c:out value='${product.id}' />"
																title="Update product details"
																class="btn btn-warning btn-sm " style="margin-right: 4px !important;"> <i
																class="fas fa-edit"></i>
															</a> <a
																href="${pageContext.request.contextPath}/ProductController?action=delete&pid=<c:out value='${product.id}' />"
																title="Delete product"
																class="btn btn-danger btn-sm" > <i
																class="fas fa-trash-alt"></i>
															</a>
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
