<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

//Redirect if the session is null
/* if (session.getAttribute("customer") == null) {
 response.sendRedirect("login.jsp");
 return;
} */
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>

<meta charset="UTF-8">
<title>Expose Printing | Checkout</title>
</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>

	<!-- ============================================-->
	<!-- <section> begin ============================-->
	<section class="pt-5 pb-9">
		<div class="container-small">
			<nav class="mb-2" aria-label="breadcrumb">
				<ol class="breadcrumb mb-0">
					<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
					<li class="breadcrumb-item"><a
						href="CartController?action=viewCart">Cart</a></li>
					<li class="breadcrumb-item active" aria-current="page">Checkout</li>
				</ol>
			</nav>
			<h2 class="mb-5">Checkout</h2>
			<div class="row justify-content-between">
				<div class="col-lg-7 col-xl-7">

					<div class="d-flex align-items-end">
						<h3 class="mb-0 me-3">Order Details</h3>
						<a href="profile.jsp" class="btn btn-link p-0" type="button">Edit</a>
					</div>
					<table class="table table-borderless mt-4">
						<tbody>
							<tr>
								<td class="py-2 ps-0">
									<div class="d-flex">
										<span class="fs-3 me-2" data-feather="user"
											style="height: 16px; width: 16px;"> </span>
										<h5 class="lh-sm me-4">Name</h5>
									</div>
								</td>
								<td class="py-2 fw-bold lh-sm">:</td>
								<td class="py-2 px-3">
									<h5 class="lh-sm fw-normal text-body-secondary">${sessionScope.customer.name}</h5>
								</td>
							</tr>
							<tr>
								<td class="py-2 ps-0">
									<div class="d-flex">
										<span class="fs-3 me-2" data-feather="home"
											style="height: 16px; width: 16px;"> </span>
										<h5 class="lh-sm me-4">Address</h5>
									</div>
								</td>
								<td class="py-2 fw-bold lh-sm">:</td>
								<td class="py-2 px-3">
									<h5 class="lh-lg fw-normal text-body-secondary">${sessionScope.customer.address}</h5>
								</td>
							</tr>
							<tr>
								<td class="py-2 ps-0">
									<div class="d-flex">
										<span class="fs-3 me-2" data-feather="phone"
											style="height: 16px; width: 16px;"> </span>
										<h5 class="lh-sm me-4">Phone</h5>
									</div>
								</td>
								<td class="py-2 fw-bold lh-sm">:</td>
								<td class="py-2 px-3">
									<h5 class="lh-sm fw-normal text-body-secondary">${sessionScope.customer.phone}</h5>
								</td>
							</tr>
						</tbody>
					</table>


					<hr class="my-6">
					<form action="OrderController" method="post">
						<div class="row g-2 mb-5 mb-lg-0">



							<input name="action" value="placeOrder" hidden>
							<div class="col-md-8 col-lg-9 d-grid">
								<button class="rounded-5 btn btn-primary" type="submit">
									Pay RM
									<fmt:formatNumber value="${subTotalPrice}" type="number"
										minFractionDigits="2" maxFractionDigits="2" />
								</button>
							</div>
							<div class="col-md-4 col-lg-3 d-grid">
								<a href="CartController?action=viewCart"
									class="rounded-5 btn btn-phoenix-secondary text-nowrap"
									>Cancel Checkout and Exit</a>
							</div>



						</div>
					</form>
				</div>
				<div class="col-lg-5 col-xl-4">
					<div class="card mt-3 mt-lg-0">
						<div class="card-body">
							<div class="d-flex align-items-center justify-content-between">
								<h3 class="mb-0">Summary</h3>
								<a href="CartController?action=viewCart"
									class="btn btn-link pe-0" type="button">Edit cart</a>
							</div>
							<div class="border-dashed border-bottom border-translucent mt-4">
								<div class="ms-n2">

									<c:forEach items="${cartItems}" var="item">
										<div class="row align-items-center mb-5 g-3">
											<div class="col-8 col-md-7 col-lg-7">
												<div class="d-flex align-items-center">
													<img class="me-2 ms-1" src="${item.product.image}"
														width="40" alt="" />
													<h6 class="fw-semibold text-body-highlight lh-base">${item.product.name}</h6>
												</div>
											</div>
											<div class="col-2 col-md-3 col-lg-2">
												<h6 class="fs-10 mb-0">${item.quantity}x</h6>
											</div>
											<div class="col-2 ps-0 col-lg-3">
												<h5 class="mb-0 fw-semibold lh-base ">
													RM
													<fmt:formatNumber value="${item.product.price}"
														type="number" minFractionDigits="2" maxFractionDigits="2" />
												</h5>
											</div>
										</div>
									</c:forEach>

								</div>
							</div>
							<div class="border-dashed border-bottom border-translucent mt-4">

								<div class="d-flex justify-content-between mb-2">
									<h5 class="text-body fw-semibold">Subtotal</h5>
									<h5 class="text-body fw-semibold">
										RM
										<fmt:formatNumber value="${subTotalPrice}" type="number"
											minFractionDigits="2" maxFractionDigits="2" />
									</h5>
								</div>

							</div>
							<div class="d-flex justify-content-between border-dashed-y pt-3">
								<h4 class="mb-0">Total :</h4>
								<h4 class="mb-0">
									RM
									<fmt:formatNumber value="${subTotalPrice}" type="number"
										minFractionDigits="2" maxFractionDigits="2" />
								</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- end of .container-->
	</section>
	<!-- <section> close ============================-->
	<!-- ============================================-->


	<%@include file="/includes/footer.jsp"%>
</body>
</html>