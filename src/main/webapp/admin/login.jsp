
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "login");
String activePage = (String) request.getAttribute("activePage");
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="./includes/head.jsp"%>
<body class="hold-transition login-page">

	
		<div class="login-box">
			<!-- /.login-logo -->
			<div class="card card-outline card-warning"
				style="border-radius: 12px;">
				<div class="card-header text-center">
					<img src="dist/img/logo-expose.png" alt="expose Logo"
						class="brand-image img-circle w-25 h-100">
				</div>
				<div class="card-body ">
					<span class="text-center">
						<p class=" h1">
							<b>Expose</b>Print
						</p>
					</span>

					<p class="login-box-msg">Sign in to access admin dashboard</p>

					<form action="${pageContext.request.contextPath}/EmployeeController" method="post">
					
						<input name="action" value="login" hidden>
						
						<div class="input-group mb-3">
							<input name="email" type="email" class="form-control" placeholder="Email"
								style="border-radius: 30px;">
							<div class="input-group-append"></div>
						</div>
						<div class="input-group mb-3">
							<input name="password" type="password" class="form-control"
								placeholder="Password" style="border-radius: 30px;">
							<div class="input-group-append"></div>
						</div>
						<div class="row">
							<!-- <div class="col-8">
								<div class="icheck-primary">
									<input type="checkbox" id="remember"> <label
										for="remember"> Remember Me </label>
								</div>
							</div> -->
							<!-- /.col -->
							<div class="col-4">
								<input type="submit" class="btn btn-primary btn-block"
									style="border-radius: 30px;" value="Sign In">
									
									
								<!-- 	<a href="index.jsp"><button type="submit" class="btn btn-primary btn-block"
									style="border-radius: 30px;">Sign In</button></a> -->
							</div>
							<!-- /.col -->
						</div>
					</form>


					<!-- /.social-auth-links -->

					<!-- <p class="mb-1">
						<a href="forgot-password.html">I forgot my password</a>
					</p> -->
					<p class="mb-0 mt-3">
						<a href="${pageContext.request.contextPath}/EmployeeController?action=register" class="text-center">Register a new
							membership</a>
				
					</p>
					<p class="mb-0">
						
					   <span class="fs-9 fw-bold">  <a  href="${pageContext.request.contextPath}/login.jsp"> Go to Customer UI </a></span> 
					</p>
					
				</div>
				<!-- /.card-body -->
			</div>
			<!-- /.card -->
		</div>
		<script
	src="<%=request.getContextPath()%>/admin/plugins/jquery/jquery.min.js"></script>
			<%@include file="./includes/flash.jsp"%>
</body>
</html>
