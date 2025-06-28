
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "register");
String activePage = (String) request.getAttribute("activePage");
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="./includes/head.jsp"%>
<body class="hold-transition register-page">


	<div class="register-box">
		<div class="card card-outline card-warning"
			style="border-radius: 12px;">

			<div class="card-header text-center">
				<img src="<%=request.getContextPath()%>/admin/dist/img/logo-expose.png" alt="expose Logo"
					class="brand-image img-circle w-25 h-100">

			</div>

			<div class="card-body text-center">
				<span class="text-center">
					<p class=" h1">
						<b>Expose</b>Print
					</p>
				</span>
				<p class="login-box-msg">Register a new employee</p>

				<form action="${pageContext.request.contextPath}/EmployeeController"
					method="POST">

					<%-- 	<c:if test="${not empty errorMessage}">
						<div class="mb-3 login-error-message" style="color:red;">${errorMessage}</div>
					</c:if> --%>

					<input name="action" value="create" hidden>


					<div class="input-group mb-3">
						<input type="text" name="name" class="form-control"
							placeholder="Enter full name" style="border-radius: 30px;">

					</div>
					<div class="input-group mb-3">
						<input name="email" type="email" class="form-control"
							placeholder="Enter email address" style="border-radius: 30px;">

					</div>
					<div class="input-group mb-3">
						<input name="password" type="password" class="form-control"
							placeholder="Enter password" style="border-radius: 30px;">

					</div>
					
					<div class="input-group mb-3">
						<input name="confirmpassword" type="password" class="form-control"
							placeholder="Enter confirm password" style="border-radius: 30px;">

					</div>

					<div class="input-group mb-3">
						<input name="phone" type="text" class="form-control"
							placeholder="Enter Phone" style="border-radius: 30px;">

					</div>

					<div class="input-group mb-3">

						<select class="form-control" name="role"
							style="border-radius: 30px;">
							<option value="">Choose role</option>
							<option value="Admin">Admin</option>
							<option value="Employee">Employee</option>
						</select>
					</div>



					<div class="input-group mb-3">
						<select class="form-control" name="admin_id"
							style="border-radius: 30px;">
							<option value="" disabled selected>Choose manager for
								this employee</option>
							<option value="">None</option>

							<c:forEach var="emp" items="${employees}">
								<option value="${emp.id}">
									<c:out value="${emp.name}" />
								</option>
							</c:forEach>
						</select>
					</div>



					<div class="row">
						<div class="col-8"></div>
						<!-- /.col -->
						<div class="col-4">
							<input type="submit" class="btn btn-primary btn-block"
								style="border-radius: 30px;" value="Register">
						</div>
						<!-- /.col -->
					</div>
				</form>



				<a href="<%=request.getContextPath()%>/admin/login.jsp" class="text-center">I already have an account</a>
			</div>
			<!-- /.form-box -->
		</div>
		<!-- /.card -->
	</div>
	<script
	src="<%=request.getContextPath()%>/admin/plugins/jquery/jquery.min.js"></script>
	<%@include file="./includes/flash.jsp"%>
</body>
</html>
