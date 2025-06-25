<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>

<meta charset="ISO-8859-1">
<title>Expose Printing | Login</title>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>



	<div class="container-fluid ">

		<!--/.bg-holder-->
		<div class="row flex-center position-relative min-vh-100 g-0 py-5 ">
			<div class="col-11 col-sm-10 col-xl-8 ">
				<div class="card cardshadow border border-translucent auth-card rounded-5">
					<div class="card-body pe-md-0">
						<div class="row align-items-center gx-0 gy-7">
							<div
								class="rounded-4 col-auto bg-body-highlight dark__bg-gray-1100 rounded-3 position-relative overflow-hidden auth-title-box">
								<div class="bg-holder"
									style="background-image: url(<%=request.getContextPath()%>/assets/img/bg/bg1000.png);"></div>
								<!--/.bg-holder-->

								<div
									class="position-relative  mb-6 d-none d-md-block text-center mt-md-15">
									<img class="auth-title-box-img d-dark-none"
										src="<%=request.getContextPath()%>/images/hero1.png"
										style="width: 350px; height: auto; max-width: 100%;" alt="" />
								</div>
								<div
									class="position-relative px-4 px-lg-7 pt-7 pb-7 pb-sm-5 text-center text-md-start pb-lg-7 pb-md-7">
									<h3 class="mb-3 text-secondary-lighter fs-7">Welcome to
										Web-Based Ordering System for Expose Printing</h3>
									<p class="text-body-tertiary"></p>
									<ul class="list-unstyled mb-0 w-max-content w-md-auto">
										<li class="d-flex align-items-center"><span
											class="uil uil-check-circle text-success me-2"></span><span
											class="text-secondary-light fw-semibold">Comfortable</span></li>
										<li class="d-flex align-items-center"><span
											class="uil uil-check-circle text-success me-2"></span><span
											class="text-secondary-light fw-semibold">Fancy</span></li>
										<li class="d-flex align-items-center"><span
											class="uil uil-check-circle text-success me-2"></span><span
											class="text-secondary-light fw-semibold">High Quality</span></li>
									</ul>
								</div>

							</div>
							<div class="col mx-auto">
								<div class="auth-form-box">
									<div class="text-center mb-3">
										<a class="d-flex flex-center text-decoration-none mb-4"
											href="index.jsp">
											<div
												class="d-flex align-items-center fw-bolder fs-3 d-inline-block">
												<img src="images/logo-expose.png" alt="expose logo" width="58" />
											</div>
										</a>
										<h3 class="text-body-highlight">Login</h3>
										<p class="text-body-tertiary">Get access to your account</p>
									</div>
									<form action="CustomerController" method="post">
									
									<input name="action" value="login" hidden>
										
									<div class="mb-3 text-start">
										<label class="form-label text-capitalize fs-9" for="email">Email address</label>
										<div class="form-icon-container">
											<input name="email" class="form-control form-icon-input" id="email"
												type="email" placeholder="name@example.com" /><span
												class="fas fa-user text-body fs-9 form-icon"></span>
										</div>
									</div>
									<div class="mb-5 text-start">
										<label class="form-label text-capitalize fs-9" for="password">Password</label>
										<div class="form-icon-container">
											<input name="password" class="form-control form-icon-input" id="password"
												type="password" placeholder="Password" /><span
												class="fas fa-key text-body fs-9 form-icon"></span>
										</div>
									</div>
									<!-- <div class="row flex-between-center mb-7">
										<div class="col-auto">
											<div class="form-check mb-0">
												<input class="form-check-input" id="basic-checkbox"
													type="checkbox" checked="checked" /><label
													class="form-check-label mb-0" for="basic-checkbox">Remember
													me</label>
											</div>
										</div>
										<div class="col-auto">
											<a class="fs-9 fw-semibold" href="forgot-password.html">Forgot
												Password?</a>
										</div>
									</div> -->
									<button type="submit" class="rounded-5 btn btn-primary w-100 mb-3">Login</button>
									<div class="text-center">
										<span class="fs-9 fw-bold"> Don't have an account ? <a  href="register.jsp"> Sign up now</a></span> 
									</div>
									<div class="text-center">
										<span class="fs-9 fw-bold">  <a  href="admin/login.jsp"> Go to Admin UI </a></span> 
										
									</div>
									 </form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>
	<br>


	<%@include file="/includes/footer.jsp"%>
	<%@include file="/includes/flash.jsp"%>
</body>
</html>
<!-- 
Author: FES
Date: Updated 6 Jan 2024 
-->