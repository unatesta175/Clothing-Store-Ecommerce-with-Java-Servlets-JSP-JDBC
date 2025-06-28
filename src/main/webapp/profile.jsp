<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

// Redirect if the session is null
if (session.getAttribute("customer") == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<%@include file="/includes/head.jsp"%>

<meta charset="UTF-8">
<title>Expose Printing | Profile</title>
</head>

<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container">

		<div class="section">

			<section class="pt-5 pb-9">
				<div class="container">

					<nav class="mb-2" aria-label="breadcrumb">
						<ol class="breadcrumb mb-0">
							<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Profile</li>
						</ol>
					</nav>

					<div
						class="row align-items-center justify-content-between g-3 mb-4">
						<div class="col-auto">
							<h2 class="mb-0">Profile</h2>
						</div>

					</div>

					=
					<form action="CustomerController" method="POST"
						enctype="multipart/form-data">

						<div class="row g-3 mb-6">
							<div class="col-12 col-lg-8">
								<div class="card h-100">
									<div class="card-body">
										<div class="border-bottom border-dashed pb-4">
											<div
												class="row align-items-center g-3 g-sm-5 text-center text-sm-start">
												<div class="col-12 col-sm-auto">



													<c:choose>
														<c:when test="${ empty customer.image }">

															<input class="d-none" name="image" id="avatarFile"
																type="file" />
															<label class="cursor-pointer avatar avatar-5xl"
																for="avatarFile"><img class="rounded-circle"
																src="images/man.png" alt="" /></label>
														</c:when>
														<c:otherwise>
															<input class="d-none" name="image" id="avatarFile"
																type="file" />
															<label class="cursor-pointer avatar avatar-5xl"
																for="avatarFile"><img class="rounded-circle"
																src="${customer.image}" alt="" /></label>


														</c:otherwise>
													</c:choose>

												</div>

												<input type="hidden" name="existingImage"
													value="${customer.image}">
												<!-- Image Preview -->


												<div class="col-12 col-sm-auto flex-1">
													<h3>
														<c:out value="${customer.name}" />
													</h3>
													<p class="text-body-secondary">
														Joined
														<c:out value="${customer.timeAgo()}" />
													</p>
												</div>
											</div>
										</div>
										<div class="d-flex flex-between-center pt-4">
											<div>
												<h6 class="mb-2 text-body-secondary">Total Spent</h6>
												<h4 class="fs-7 text-body-highlight mb-0">
													RM
													<fmt:formatNumber value="${totalSpentAmount}" type="number"
														minFractionDigits="2" maxFractionDigits="2" />
												</h4>
											</div>
											<div class="text-end">
												<h6 class="mb-2 text-body-secondary">Last Order</h6>
												<h4 class="fs-7 text-body-highlight mb-0">${lastOrderDate}</h4>
											</div>
											<div class="text-end">
												<h6 class="mb-2 text-body-secondary">Total Orders</h6>
												<h4 class="fs-7 text-body-highlight mb-0">${totalOrder}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-12 col-lg-4">
								<div class="card h-100">
									<div class="card-body">
										<div class="border-bottom border-dashed">
											<h4 class="mb-3">
												Default Address
												<button class="btn btn-link p-0" type="button">
													<span class="fas fa-edit fs-9 ms-3 text-body-quaternary"></span>
												</button>
											</h4>
										</div>
										<div class="pt-4 mb-7 mb-lg-4 mb-xl-7">
											<div class="row justify-content-between">
												<div class="col-auto">
													<h5 class="text-body-highlight">Address</h5>
												</div>
												<div class="col-auto">
													<p class="text-body-secondary">
														<c:out value="${customer.address}" />
													</p>
												</div>
											</div>
										</div>
										<div class="border-top border-dashed pt-4">
											<div class="row flex-between-center mb-2">
												<div class="col-auto">
													<h5 class="text-body-highlight mb-0">Email</h5>
												</div>
												<div class="col-auto">
													<a class="lh-1" href="mailto:shatinon@jeemail.com"> <c:out
															value="${customer.email}" /></a>
												</div>
											</div>
											<div class="row flex-between-center">
												<div class="col-auto">
													<h5 class="text-body-highlight mb-0">Phone</h5>
												</div>
												<div class="col-auto">
													<a href="tel:+1234567890"> <c:out
															value="${customer.phone}" /></a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>


						<div class="row g-3 mb-6">
							<div class="col-12">
								<div class="card h-100">
									<div class="card-body">
										<div class="my-5">
											<div class="scrollbar">
												<ul class="nav nav-underline fs-9 flex-nowrap mb-3 pb-1"
													id="myTab" role="tablist">
													<li class="nav-item me-3"><a
														class="nav-link text-nowrap active" id="personal-info-tab"
														data-bs-toggle="tab" href="#tab-personal-info" role="tab"
														aria-controls="tab-personal-info" aria-selected="true"><span
															class="fas fa-user me-2"></span>Personal info</a></li>
													<li class="nav-item me-3 "><a
														class="nav-link text-nowrap" id="change-password-tab"
														data-bs-toggle="tab" href="#tab-change-password"
														role="tab" aria-controls="tab-change-password"
														aria-selected="true"><span class="fas fa-lock me-2"></span>Change
															password</a></li>



												</ul>
											</div>
											<div class="tab-content" id="profileTabContent">
												<div class="tab-pane fade show active"
													id="tab-personal-info" role="tabpanel"
													aria-labelledby="personal-info-tab">

													
														<!-- Display error message if exists -->
														<%-- <c:if test="${not empty errorMessage}">
															<div class="login-error-message">${errorMessage}</div>
														</c:if> --%>
														<div class="row g-3 mb-5">

															<input name="action" value="updateProfile" hidden>

															<div class="col-12 col-lg-6">

																<input name="id" class="form-control" id="id"
																	type="text" value="<c:out value="${customer.id}" />"
																	hidden /> <label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="fullName">Full name</label><input name="name"
																	class="form-control" id="fullName" type="text"
																	placeholder="Full name"
																	value="<c:out value="${customer.name}" />" />

															</div>
															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="email">Email</label><input name="email"
																	class="form-control" id="email" type="text"
																	placeholder="Email"
																	value="<c:out value="${customer.email}" />" readonly
																	disabled />
															</div>
															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="text">Address</label><input name="address"
																	class="form-control" id="address" type="text"
																	placeholder="Address"
																	value="<c:out value="${customer.address}" />" />
															</div>

															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="phone">Phone</label><input name="phone"
																	class="form-control" id="phone" type="text"
																	placeholder="+1234567890"
																	value="<c:out value="${customer.phone}" />" />
															</div>

														</div>
														<div class="text-end">
															<button type="submit" class="btn btn-primary px-7 rounded-5">Save
																changes</button>

														</div>
													</form>
												</div>
												<div class="tab-pane fade " id="tab-change-password"
													role="tabpanel" aria-labelledby="tab-change-password">
													<form action="CustomerController" method="post">
														<!-- Display error message if exists -->
														<%-- 	<c:if test="${not empty errorPasswordMessage}">
														<div class="login-error-message">${errorPasswordMessage}</div>
													</c:if> --%>
														<div class="row g-3 mb-5">

															<input name="action" value="updatePassword" hidden>

															<div class="col-12 col-lg-4">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="oldPassword">Old Password</label><input
																	name="oldPassword" class="form-control"
																	id="oldPassword" type="password"
																	placeholder="Old Password" />
															</div>
															<div class="col-12 col-lg-4">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="newPassword">New Password</label><input
																	name="newPassword" class="form-control"
																	id="newPassword" type="password"
																	placeholder="New Password" />
															</div>
															<div class="col-12 col-lg-4">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="confirmPassword">Confirm Password</label><input
																	name="confirmPassword" class="form-control"
																	id="confirmPassword" type="password"
																	placeholder="Confirm Password" />
															</div>
														</div>
														<div class="text-end">
															<button class="btn btn-primary px-7">Save
																changes</button>
														</div>
													</form>
												</div>
			</section>
		</div>
	</div>





	<%@include file="/includes/footer.jsp"%>
	<%@include file="/includes/flash.jsp"%>
</body>

</html>