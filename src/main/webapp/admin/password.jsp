
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "Profile");
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
							<h1 class="m-0">Password</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
								<li class="breadcrumb-item active">Password</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->


			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- left column -->
						<div class="col-md-6">

							<div class="card " style="border-radius: 10px;">
								<div class="card-header">
									<h3 class="card-title">Edit Password</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form method="post" action="${pageContext.request.contextPath}/EmployeeController"class="form-horizontal">
								
								<input type="text" name="action" value="updatePassword" hidden>
								
									<div class="card-body">
										<div class="form-group row">
											<label for="inputPassword3" class="col-sm-4 col-form-label">Old
												password</label>
											<div class="col-sm-8">
												<input name="oldPassword" type="password" class="form-control"
													id="inputPassword3" placeholder="Old password"
													style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputPassword3" class="col-sm-4 col-form-label">New
												password</label>
											<div class="col-sm-8">
												<input name="newPassword" type="password" class="form-control"
													id="inputPassword3" placeholder="New password"
													style="border-radius: 30px;">
											</div>
										</div>

										<div class="form-group row">
											<label for="inputPassword3" class="col-sm-4 col-form-label">Confirm
												new password</label>
											<div class="col-sm-8">
												<input name="confirmPassword" type="password" class="form-control"
													id="inputPassword3" placeholder="Confirm new password"
													style="border-radius: 30px;">
											</div>
										</div>


									</div>
									<!-- /.card-body -->
									<div class="card-footer ">
										<button type="submit" class="btn btn-warning"
											style="border-radius: 30px;">Save changes</button>
											
											<a class="btn btn-primary float-right" href="profile.jsp" style="border-radius: 30px;">Back to profile</a>
										
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
