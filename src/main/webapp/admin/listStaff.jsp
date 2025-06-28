



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "Employees");
String activePage = (String) request.getAttribute("activePage");

//Redirect if the session is null
if (session.getAttribute("employee") == null) {
	response.sendRedirect(request.getContextPath()+"/admin/login.jsp");
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
							<h1 class="m-0">Employees List</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item active">Employees</li>
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
										href="${pageContext.request.contextPath}/EmployeeController?action=createEmployee"><button
											class="btn btn-primary float-right"
											style="border-radius: 30px;">Register employee</button></a>
									<h4 class=" ">Employees Informations</h4>

								</div>
								<!-- /.card-header -->

								<div class="card-body">

									<table id="example1" class="table table-bordered table-striped">
										<thead>
											<tr>
												<th>ID</th>
												<th>Name</th>
												<th>Email</th>
												<th>Phone Number</th>
												<th>Manager</th>
												<th>Role</th>
												<th>Created At</th>
												<th>Updated At</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${employees}" var="employee">
												<tr>
													<td><c:out value="${employee.id}"/></td>
													<td><c:out value="${employee.name}"/></td>
													<td><c:out value="${employee.email}"/></td>
													<td><c:out value="${employee.phone}"/></td>



													<c:choose>
														<c:when test="${employee.adminId != null}">
															<td><c:out value="${employee.manager.name}"/></td>
														</c:when>
														<c:otherwise>
															<td>None</td>
														</c:otherwise>
													</c:choose>

													<td><c:out value="${employee.role}"/></td>
													<td><fmt:formatDate value="${employee.createdAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>

													<td><fmt:formatDate value="${employee.updatedAt}"
															pattern="d/M/yyyy, h:mm:ss a" /></td>
													<td>
														<div
															class="d-flex justify-content-center align-items-center gap-2">
															<a
																href="${pageContext.request.contextPath}/EmployeeController?action=updateEmployee&empid=<c:out value="${employee.id}" />"
																title="Update employee details"
																class="btn btn-warning btn-sm" style="margin-right: 4px !important;"> <i
																class="fas fa-edit"></i>
															</a> <a
																href="${pageContext.request.contextPath}/EmployeeController?action=deleteEmployee&empid=<c:out value="${employee.id}" />"
																title="Delete employee"
																class="btn btn-danger btn-sm"> <i
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
