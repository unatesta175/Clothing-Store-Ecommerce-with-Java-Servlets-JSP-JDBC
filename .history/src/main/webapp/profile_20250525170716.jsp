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

					<div class="row align-items-center justify-content-between g-3 mb-4">
						<div class="col-auto">
							<h2 class="mb-0">Profile</h2>
						</div>

					</div>

					<form action="CustomerController" method="POST" enctype="multipart/form-data">

						<div class="row g-3 mb-6">
							<div class="col-12 col-lg-8">
								<div class="card h-100">
									<div class="card-body">
										<div class="border-bottom border-dashed pb-4">
											<div class="row align-items-center g-3 g-sm-5 text-center text-sm-start">
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

												<input type="hidden" name="existingImage" value="${customer.image}">
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
												<h4 class="fs-7 text-body-highlight mb-0">$894</h4>
											</div>
											<div class="text-end">
												<h6 class="mb-2 text-body-secondary">Last Order</h6>
												<h4 class="fs-7 text-body-highlight mb-0">1 week ago</h4>
											</div>
											<div class="text-end">
												<h6 class="mb-2 text-body-secondary">Total Orders</h6>
												<h4 class="fs-7 text-body-highlight mb-0">97</h4>
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
													<a class="lh-1" href="mailto:shatinon@jeemail.com">
														<c:out value="${customer.email}" /></a>
												</div>
											</div>
											<div class="row flex-between-center">
												<div class="col-auto">
													<h5 class="text-body-highlight mb-0">Phone</h5>
												</div>
												<div class="col-auto">
													<a href="tel:+1234567890">
														<c:out value="${customer.phone}" /></a>
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
												<ul class="nav nav-underline fs-9 flex-nowrap mb-3 pb-1" id="myTab"
													role="tablist">
													<li class="nav-item me-3"><a class="nav-link text-nowrap active"
															id="personal-info-tab" data-bs-toggle="tab"
															href="#tab-personal-info" role="tab"
															aria-controls="tab-personal-info" aria-selected="true"><span
																class="fas fa-user me-2"></span>Personal info</a></li>
													<li class="nav-item me-3 "><a class="nav-link text-nowrap"
															id="change-password-tab" data-bs-toggle="tab"
															href="#tab-change-password" role="tab"
															aria-controls="tab-change-password"
															aria-selected="true"><span
																class="fas fa-lock me-2"></span>Change
															password</a></li>
													<li class="nav-item me-3"><a class="nav-link text-nowrap"
															id="orders-tab" data-bs-toggle="tab" href="#tab-orders"
															role="tab" aria-controls="tab-orders"
															aria-selected="true"><span
																class="fas fa-shopping-cart me-2"></span>Orders <span
																class="text-body-tertiary fw-normal"> (35)</span></a>
													</li>
													<li class="nav-item me-3"><a class="nav-link text-nowrap"
															id="reviews-tab" data-bs-toggle="tab" href="#tab-reviews"
															role="tab" aria-controls="tab-orders"
															aria-selected="true"><span
																class="fas fa-star me-2"></span>Reviews<span
																class="text-body-tertiary fw-normal"> (24)</span></a>
													</li>
													<li class="nav-item "><a class="nav-link text-nowrap"
															id="wishlist-tab" data-bs-toggle="tab" href="#tab-wishlist"
															role="tab" aria-controls="tab-orders"
															aria-selected="true"><span
																class="fas fa-heart me-2"></span>Wishlist</a></li>


												</ul>
											</div>
											<div class="tab-content" id="profileTabContent">
												<div class="tab-pane fade show active" id="tab-personal-info"
													role="tabpanel" aria-labelledby="personal-info-tab">

													<form action="CustomerController" method="post">
														<!-- Display error message if exists -->
														<c:if test="${not empty errorMessage}">
															<div class="login-error-message">${errorMessage}</div>
														</c:if>
														<div class="row g-3 mb-5">

															<input name="action" value="updateProfile" hidden>

															<div class="col-12 col-lg-6">

																<input name="id" class="form-control" id="id"
																	type="text" value="<c:out value="
																	${customer.id}" />"
																hidden /> <label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="fullName">Full name</label><input name="name"
																	class="form-control" id="fullName" type="text"
																	placeholder="Full name" value="<c:out value="
																	${customer.name}" />" />

															</div>
															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="email">Email</label><input name="email"
																	class="form-control" id="email" type="text"
																	placeholder="Email" value="<c:out value="
																	${customer.email}" />" readonly
																disabled />
															</div>
															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="text">Address</label><input name="address"
																	class="form-control" id="address" type="text"
																	placeholder="Address" value="<c:out value="
																	${customer.address}" />" />
															</div>

															<div class="col-12 col-lg-6">
																<label
																	class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																	for="phone">Phone</label><input name="phone"
																	class="form-control" id="phone" type="text"
																	placeholder="+1234567890" value="<c:out value="
																	${customer.phone}" />" />
															</div>

														</div>
														<div class="text-end">
															<button type="submit" class="btn btn-primary px-7">Save
																changes</button>

														</div>
													</form>
												</div>
												<div class="tab-pane fade " id="tab-change-password" role="tabpanel"
													aria-labelledby="tab-change-password">

													<!-- Display error message if exists -->
													<c:if test="${not empty errorPasswordMessage}">
														<div class="login-error-message">${errorPasswordMessage}</div>
													</c:if>
													<div class="row g-3 mb-5">

														<input name="action" value="updatePassword" hidden>

														<div class="col-12 col-lg-4">
															<label
																class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																for="oldPassword">Old Password</label><input
																name="oldPassword" class="form-control" id="oldPassword"
																type="password" placeholder="Old Password" />
														</div>
														<div class="col-12 col-lg-4">
															<label
																class="form-label text-body-highlight fw-bold fs-9 ps-0 text-capitalize lh-sm"
																for="newPassword">New Password</label><input
																name="newPassword" class="form-control" id="newPassword"
																type="password" placeholder="New Password" />
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
				<div class="tab-pane fade " id="tab-orders" role="tabpanel" aria-labelledby="orders-tab">
					<div class="border-top border-bottom border-translucent" id="profileOrdersTable"
						data-list='{"valueNames":["order","status","delivery","date","total"],"page":6,"pagination":true}'>
						<div class="table-responsive scrollbar">
							<table class="table fs-9 mb-0">
								<thead>
									<tr>
										<th class="sort white-space-nowrap align-middle pe-3 ps-0" scope="col"
											data-sort="order" style="width: 15%; min-width: 140px">ORDER</th>
										<th class="sort align-middle pe-3" scope="col" data-sort="status"
											style="width: 15%; min-width: 180px">STATUS</th>
										<th class="sort align-middle text-start" scope="col" data-sort="delivery"
											style="width: 20%; min-width: 160px">DELIVERY
											METHOD</th>
										<th class="sort align-middle pe-0 text-end" scope="col" data-sort="date"
											style="width: 15%; min-width: 160px">DATE</th>
										<th class="sort align-middle text-end" scope="col" data-sort="total"
											style="width: 15%; min-width: 160px">TOTAL</th>
										<th class="align-middle pe-0 text-end" scope="col" style="width: 15%;"></th>
									</tr>
								</thead>
								<tbody class="list" id="profile-order-table-body">
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2453</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-success"><span
													class="badge-label">Shipped</span><span class="ms-1"
													data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Cash
											on delivery</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Dec
											12, 12:56 PM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">RM87
										</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="order-details.jsp">View</a><a
														class="dropdown-item" href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2452</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-info"><span
													class="badge-label">Ready to pickup</span><span class="ms-1"
													data-feather="info"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Free
											shipping</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Dec
											9, 2:28PM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM7264</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2451</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-warning"><span
													class="badge-label">Partially fulfilled</span><span class="ms-1"
													data-feather="clock"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Local
											pickup</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Dec
											4, 12:56 PM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM375</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2450</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-secondary"><span
													class="badge-label">Canceled</span><span class="ms-1"
													data-feather="x"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Standard
											shipping</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Dec
											1, 4:07 AM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM657</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2449</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-success"><span
													class="badge-label">fulfilled</span><span class="ms-1"
													data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Express</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Nov
											28, 7:28 PM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM9562</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2448</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-danger"><span
													class="badge-label">Unfulfilled</span><span class="ms-1"
													data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Local
											delivery</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Nov
											24, 10:16 AM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM256</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-body-tertiary text-opacity-85 pointers-events-none text-decoration-none"
												href="#!">#2447</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-secondary"><span
													class="badge-label">Cancelled</span><span class="ms-1"
													data-feather="x"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Standard
											shipping</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Nov
											10, 12:00 PM</td>
										<td
											class="date align-middle fw-semibold text-end py-2 text-body-tertiary text-opacity-85">
											RM898</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-primary" href="#!">#2446</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-success"><span
													class="badge-label">shipped</span><span class="ms-1"
													data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Express</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Nov
											12, 12:20 PM</td>
										<td class="date align-middle fw-semibold text-end py-2 text-body-highlight">
											RM4116</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="order align-middle white-space-nowrap py-2 ps-0"><a
												class="fw-semibold text-body-tertiary text-opacity-85 pointers-events-none text-decoration-none"
												href="#!">#2445</a></td>
										<td
											class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">
											<span class="badge badge-phoenix fs-10 badge-phoenix-success"><span
													class="badge-label">fulfilled</span><span class="ms-1"
													data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="delivery align-middle white-space-nowrap text-body py-2">Free
											shipping</td>
										<td class="total align-middle text-body-tertiary text-end py-2">Oct
											19, 1:20 PM</td>
										<td
											class="date align-middle fw-semibold text-end py-2 text-body-tertiary text-opacity-85">
											RM4116</td>
										<td class="align-middle text-end white-space-nowrap pe-0 action py-2">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="row align-items-center justify-content-between py-2 pe-0 fs-9">
							<div class="col-auto d-flex">
								<p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body"
									data-list-info="data-list-info"></p>
								<a class="fw-semibold" href="#!" data-list-view="*">View all<span
										class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a><a class="fw-semibold d-none" href="#!" data-list-view="less">View
									Less<span class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a>
							</div>
							<div class="col-auto d-flex">
								<button class="page-link" data-list-pagination="prev">
									<span class="fas fa-chevron-left"></span>
								</button>
								<ul class="mb-0 pagination"></ul>
								<button class="page-link pe-0" data-list-pagination="next">
									<span class="fas fa-chevron-right"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="tab-reviews" role="tabpanel" aria-labelledby="reviews-tab">
					<div class="border-y" id="profileRatingTable"
						data-list='{"valueNames":["product","rating","review","status","date"],"page":6,"pagination":true}'>
						<div class="table-responsive scrollbar">
							<table class="table fs-9 mb-0">
								<thead>
									<tr>
										<th class="sort white-space-nowrap align-middle" scope="col"
											style="min-width: 220px;" data-sort="product">PRODUCT</th>
										<th class="sort align-middle" scope="col" data-sort="rating"
											style="max-width: 10%;">RATING</th>
										<th class="sort align-middle" scope="col" style="min-width: 480px"
											data-sort="review">REVIEW</th>
										<th class="sort align-middle" scope="col" style="max-width: 12%;"
											data-sort="status">STATUS</th>
										<th class="sort text-end align-middle" scope="col" style="max-width: 10%;"
											data-sort="date">DATE</th>
										<th class="sort text-end pe-0 align-middle" scope="col" style="width: 7%"></th>
									</tr>
								</thead>
								<tbody class="list" id="profile-review-table-body">
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												1</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa-regular fa-star text-warning-light"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">This
												Fitbit is fantastic! I was trying to be in better shape and
												needed some motivation, so I decided to treat myself to a
												new Fitbit.</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-success">Approaved<span
													class="ms-1" data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Just now</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												2</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa-regular fa-star text-warning-light"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">The
												order was delivered ahead of schedule. To give us additional
												time, you should leave the packaging sealed with plastic.</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-warning">Pending<span
													class="ms-1" data-feather="clock"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Dec 9, 2:28 PM</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												3</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star-half-alt star-icon text-warning"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">It's
												a Mac, after all. Once you've gone Mac, there's no going
												back. My first Mac lasted over nine years, and this is my
												second.</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-success">Approaved<span
													class="ms-1" data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Dec 4, 12:56 PM</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												4</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa-regular fa-star text-warning-light"></span><span
												class="fa-regular fa-star text-warning-light"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">Personally,
												I like the minimalist style, but I wouldn't choose it if I
												were searching for a computer that I would use frequently.
												It's not horrible in terms of speed and power</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-success">Approaved<span
													class="ms-1" data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Nov 28, 7:28 PM</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												5</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">It
												performs exactly as expected. There are three of these in
												the family.</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-secondary">Cancelled<span
													class="ms-1" data-feather="x"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Nov 24, 10:16 AM</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												6</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">The
												controller is quite comfy for me. Despite its increased
												size, the controller still fits well in my hands.</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-success">Approaved<span
													class="ms-1" data-feather="check"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Just now</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle product pe-3"><a class="fw-semibold line-clamp-1"
												href="product-details.html">Jersey
												7</a></td>
										<td class="align-middle rating white-space-nowrap fs-10"><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa-regular fa-star text-warning-light"></span></td>
										<td class="align-middle review pe-7">
											<p class="fw-semibold text-body-highlight mb-0 line-clamp-2">The
												response time and service I received when contacted the
												designers were Phenomenal!</p>
										</td>
										<td class="align-middle status pe-9"><span
												class="badge badge-phoenix fs-10 badge-phoenix-warning">Pending<span
													class="ms-1" data-feather="fas fa-stopwatch"
													style="height: 12.8px; width: 12.8px;"></span></span></td>
										<td class="align-middle text-end date white-space-nowrap">
											<p class="text-body-tertiary mb-0">Nov 07, 9:00 PM</p>
										</td>
										<td class="align-middle white-space-nowrap text-end pe-0">
											<div class="btn-reveal-trigger position-static">
												<button
													class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
													type="button" data-bs-toggle="dropdown" data-boundary="window"
													aria-haspopup="true" aria-expanded="false"
													data-bs-reference="parent">
													<span class="fas fa-ellipsis-h fs-10"></span>
												</button>
												<div class="dropdown-menu dropdown-menu-end py-2">
													<a class="dropdown-item" href="#!">View</a><a class="dropdown-item"
														href="#!">Export</a>
													<div class="dropdown-divider"></div>
													<a class="dropdown-item text-danger" href="#!">Remove</a>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="row align-items-center justify-content-between py-2 pe-0 fs-9">
							<div class="col-auto d-flex">
								<p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body"
									data-list-info="data-list-info"></p>
								<a class="fw-semibold" href="#!" data-list-view="*">View all<span
										class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a><a class="fw-semibold d-none" href="#!" data-list-view="less">View
									Less<span class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a>
							</div>
							<div class="col-auto d-flex">
								<button class="page-link" data-list-pagination="prev">
									<span class="fas fa-chevron-left"></span>
								</button>
								<ul class="mb-0 pagination"></ul>
								<button class="page-link pe-0" data-list-pagination="next">
									<span class="fas fa-chevron-right"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="tab-wishlist" role="tabpanel" aria-labelledby="wishlist-tab">
					<div class="border-y border-translucent" id="productWishlistTable"
						data-list='{"valueNames":["products","color","size","price","quantity","total"],"page":5,"pagination":true}'>
						<div class="table-responsive scrollbar">
							<table class="table fs-9 mb-0">
								<thead>
									<tr>
										<th class="sort white-space-nowrap align-middle fs-10" scope="col"
											style="width: 7%;"></th>
										<th class="sort white-space-nowrap align-middle" scope="col"
											style="width: 30%; min-width: 250px;" data-sort="products">PRODUCTS</th>
										<th class="sort align-middle" scope="col" data-sort="color" style="width: 16%;">
											COLOR</th>
										<th class="sort align-middle" scope="col" data-sort="size" style="width: 10%;">
											SIZE</th>
										<th class="sort align-middle text-end" scope="col" data-sort="price"
											style="width: 10%;">PRICE</th>
										<th class="sort align-middle text-end pe-0" scope="col" style="width: 35%;">
										</th>
									</tr>
								</thead>
								<tbody class="list" id="profile-wishlist-table-body">
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-1.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 1</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Pure
											matte black</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											xxl</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM57</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-6.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 2</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Black</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											xs</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM1,499</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-5.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 3</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">White</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											s</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM299</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-4.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 4</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Space
											Gray</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											l</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM1,699</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-3.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 5</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Ocean
											Blue</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											m</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM65</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-10.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 6</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">White</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											s</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM30</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-2.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 7</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Black</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											xs</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM40</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-1.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 8</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Black</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											xxl</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM130</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
									<tr class="hover-actions-trigger btn-reveal-trigger position-static">
										<td class="align-middle white-space-nowrap ps-0 py-0"><a
												class="border border-translucent rounded-2 d-inline-block"
												href="product-details.html"><img src="images/jersey-17.png" alt=""
													width="53" /></a></td>
										<td class="products align-middle pe-11"><a class="fw-semibold mb-0 line-clamp-1"
												href="product-details.html">Jersey 9</a></td>
										<td class="color align-middle white-space-nowrap fs-9 text-body">Space
											Gray</td>
										<td
											class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold">
											xl</td>
										<td class="price align-middle text-body fs-9 fw-semibold text-end">RM99</td>
										<td
											class="total align-middle fw-bold text-body-highlight text-end text-nowrap pe-0">
											<button
												class="btn btn-sm text-body-quaternary text-body-tertiary-hover me-2">
												<span class="fas fa-trash"></span>
											</button>
											<button class="btn btn-primary fs-10">
												<span class="fas fa-shopping-cart me-1 fs-10"></span>Add to
												cart
											</button></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="row align-items-center justify-content-between py-2 pe-0 fs-9">
							<div class="col-auto d-flex">
								<p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body"
									data-list-info="data-list-info"></p>
								<a class="fw-semibold" href="#!" data-list-view="*">View all<span
										class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a><a class="fw-semibold d-none" href="#!" data-list-view="less">View
									Less<span class="fas fa-angle-right ms-1" data-fa-transform="down-1"></span>
								</a>
							</div>
							<div class="col-auto d-flex">
								<button class="page-link" data-list-pagination="prev">
									<span class="fas fa-chevron-left"></span>
								</button>
								<ul class="mb-0 pagination"></ul>
								<button class="page-link pe-0" data-list-pagination="next">
									<span class="fas fa-chevron-right"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
		</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	<!-- end of .container-->
	</section>

	</div>
	</div>




	<%@include file="/includes/footer.jsp"%>
	<%@include file="/includes/flash.jsp"%>
</body>

</html>