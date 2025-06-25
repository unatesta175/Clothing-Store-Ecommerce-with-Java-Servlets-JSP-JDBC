


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
							<h1 class="m-0">Update Employee</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/EmployeeController?action=listEmployee">List
										Employee</a></li>
								<li class="breadcrumb-item active">Update Employee</li>
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
								enctype="multipart/form-data"
								
								
									action="${pageContext.request.contextPath}/EmployeeController"
									class="form-horizontal">
									<div class="card-body">

										<input type="text" name="id" value="${selectedEmployee.id}"
											hidden> <input type="text" name="action"
											value="updateOtherEmployee" hidden>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Full
												name</label>
											<div class="col-sm-8">
												<input type="text" name="name"
													value="${selectedEmployee.name}" class="form-control"
													placeholder="Full name" style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Email
											</label>
											<div class="col-sm-8">
												<input type="email" name="email"
													value="${selectedEmployee.email}" class="form-control"
													placeholder="Email Address" style="border-radius: 30px;" readonly>
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Phone
												Number </label>
											<div class="col-sm-8">
												<input type="text" name="phone"
													value="${selectedEmployee.phone}" class="form-control"
													placeholder="Phone no" style="border-radius: 30px;">
											</div>
										</div>
										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Role
											</label>
											<div class="col-sm-8">

												<select class="form-control" name="role"
													style="border-radius: 30px;">
													<option value="" disabled>Choose role</option>
													<option selected value="${selectedEmployee.role}">${selectedEmployee.role}</option>
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
													<option value="" disabled>Choose manager for this
														employee</option>
														
														<c:choose>
														<c:when test ="${not empty selectedEmployee.manager.name }">
														<option selected value="${selectedEmployee.manager.id}">${selectedEmployee.manager.name}</option>
														
													  <option value="">None</option>
														</c:when>
														
														<c:otherwise>
														<option selected value="">None</option>
														</c:otherwise>
														</c:choose>
													
												

													<c:forEach var="emp" items="${employeeList}">
														<option value="${emp.id}">
															<c:out value="${emp.name}" />
														</option>
													</c:forEach>
												</select>


											</div>
										</div>
										
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Product Image</label>
											<div class="col-sm-8">
												<div class="input-group">
													<div class="custom-file">
														<input type="file" class="custom-file-input"
															id="exampleInputFile" name="image"> <label
															class="custom-file-label" for="exampleInputFile"
															style="border-radius: 30px;">Choose file</label>
													</div>
												</div>

												<input type="hidden" name="existingImage"
													value="${selectedEmployee.image}">
												<!-- Image Preview -->
												<div class="mt-2">

													<c:choose>
														<c:when test="${ empty selectedEmployee.image }">


															<c:choose>
																<c:when test="${ selectedEmployee.role =='Admin' }">
																	<img id="previewImage" src="admin/dist/img/man.png"
																		alt="Current Product Image"
																		style="max-width: 100px; border-radius: 10px;">


																</c:when>
																<c:otherwise>
																	<img id="previewImage" src="admin/dist/img/officer.png"
																		alt="Current Product Image"
																		style="max-width: 100px; border-radius: 10px;">

																</c:otherwise>
															</c:choose>



														</c:when>
														<c:otherwise>
															<img id="previewImage"
																src="${selectedEmployee.image}"
																alt="Current Product Image"
																style="max-width: 100px; border-radius: 10px;">


														</c:otherwise>
													</c:choose>

												</div>
											</div>
										</div>






										<div class="form-group row invisible">
											<label for="inputPassword3" class="col-sm-4 col-form-label">Password</label>
											<div class="col-sm-8">
												<input type="password" value="${selectedEmployee.password}"
													name="password" readonly class="form-control"
													id="inputPassword3" placeholder="Password"
													style="border-radius: 30px;">
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
