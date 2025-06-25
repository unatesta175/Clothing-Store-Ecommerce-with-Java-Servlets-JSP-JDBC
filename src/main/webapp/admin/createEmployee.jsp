


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
							<h1 class="m-0">Create Employee</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/EmployeeController?action=listEmployee">List
										Employee</a></li>
								<li class="breadcrumb-item active">Create Employee</li>
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
									<h3 class="card-title">Employee Details</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form method="post"
								
								
									action="${pageContext.request.contextPath}/EmployeeController"
									class="form-horizontal">
									<div class="card-body">

										<input type="text" name="id" 
											hidden> <input type="text" name="action"
											value="createOtherEmployee" hidden>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Full
												name</label>
											<div class="col-sm-8">
												<input type="text" name="name"
													class="form-control"
													placeholder="Full name" style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Email
											</label>
											<div class="col-sm-8">
												<input type="email" name="email"
													 class="form-control"
													placeholder="Email Address" style="border-radius: 30px;">
											</div>
										</div>
										
											<div class="form-group row ">
											<label for="inputPassword3" class="col-sm-4 col-form-label">Password</label>
											<div class="col-sm-8">
												<input type="password" value=""
													name="password"  class="form-control"
													id="inputPassword3" placeholder="Password"
													style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Phone
												Number </label>
											<div class="col-sm-8">
												<input type="text" name="phone"
													 class="form-control"
													placeholder="Phone no" style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Role
											</label>
											<div class="col-sm-8">

												<select class="form-control" name="role"
													style="border-radius: 30px;">
													<option value="" selected>Choose role</option>
												
													<option value="Admin">Admin</option>
													<option value="Employee">Employee</option>


												</select>

											</div>
										</div>




										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Manager</label>
											<div class="col-sm-8">
												<select class="form-control" name="admin_id"
													style="border-radius: 30px;">
													<option value="" selected>Choose manager for this
														employee</option>
													
													<option value="">None</option>

													<c:forEach var="emp" items="${employeeList}">
														<option value="${emp.id}">
															<c:out value="${emp.name}" />
														</option>
													</c:forEach>
												</select>


											</div>
										</div>
										
							






									


									</div>
									<!-- /.card-body -->
									<div class="card-footer ">
										<input type="submit" class="btn btn-warning"
											style="border-radius: 30px;" value="Submit Changes">
										<a href="${pageContext.request.contextPath}/EmployeeController?action=listEmployee" class="btn btn-primary float-right"
											style="border-radius: 30px;">Back</a>
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
