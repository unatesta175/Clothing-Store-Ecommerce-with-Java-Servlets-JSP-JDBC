<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

//Redirect if the session is null
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
<title>Expose Printing | Order Details</title>
</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>

	<!-- ============================================-->
	<!-- <section> begin ============================-->
	<section class="pt-5 pb-9">
		<div class="container-small cart">

			<nav class="mb-2" aria-label="breadcrumb">
				<ol class="breadcrumb mb-0">
					<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
					<li class="breadcrumb-item"><a
						href="OrderController?action=orderhistory">Order History</a></li>
					<li class="breadcrumb-item active">Order Details</li>
				</ol>
			</nav>
			<h2 class="mb-0">
				Order <span>#${order.id }</span>
			</h2>

			<c:choose>
				<c:when test="${payment.status == 'Completed' }">
					<span class="badge badge-phoenix badge-phoenix-success">Order
						has been paid</span>
				</c:when>

				<c:otherwise>
					<span class="badge badge-phoenix badge-phoenix-danger">Order
						cancelled / failed</span>
				</c:otherwise>

			</c:choose>

			<div class="d-sm-flex flex-between-center mb-3">
				<p class="text-body-secondary lh-sm mb-0 mt-2 mt-sm-0">Customer
					Name : ${sessionScope.customer.name }</p>



			</div>


			<div class="row g-5">
				<div class="col-12 col-lg-9">
					<div class="card">
						<div class="card-body">

							<div id="cartTable"
								data-list='{"valueNames":["products","category","size","price","quantity","total","action"],"page":10,"pagination":{"innerWindow":2,"left":1,"right":1}}}'>
								<div class="table-responsive scrollbar mx-n1 px-1">
									<table class="table fs-9 mb-0 border-top border-translucent">
										<thead>
											<tr>
												<th class="sort white-space-nowrap align-middle fs-10"
													scope="col"></th>
												<th class="sort white-space-nowrap align-middle" scope="col"
													style="min-width: 250px;">PRODUCTS</th>
												<th class="sort align-middle" scope="col"
													style="width: 80px;">CATEGORY</th>
												<th class="sort align-middle" scope="col"
													style="width: 150px;">SIZE</th>
												<th class="sort align-middle text-end" scope="col"
													style="width: 300px;">PRICE</th>
												<th class="sort align-middle ps-5" scope="col"
													style="width: 200px;">QUANTITY</th>
												<th class="sort align-middle text-end" scope="col"
													style="width: 250px;">TOTAL</th>
												<th class="sort text-end align-middle pe-0" scope="col"></th>
											</tr>
										</thead>


										<tbody class="list" id="cart-table-body">
											<c:choose>
												<c:when test="${not empty orderItems}">
													<c:forEach items="${orderItems}" var="item">



														<tr class="cart-table-row btn-reveal-trigger">

															<td class="align-middle white-space-nowrap py-0"><a
																class="d-block border border-translucent rounded-2"
																href="product-details.html"><img
																	src="<c:out value="${item.product.image}"/>" alt=""
																	width="53" /></a></td>
															<td class="products align-middle"><a
																class="fw-semibold mb-0 line-clamp-2"
																href="ProductController?action=viewProduct&pid=${item.product.id}"><c:out
																		value="${item.product.name}" /></a></td>
															<td
																class="category align-middle white-space-nowrap fs-9 text-body"><c:out
																	value="${item.product.category}" /></td>
															<td
																class="size align-middle white-space-nowrap text-body-tertiary fs-9 fw-semibold"><c:out
																	value="${item.product.size}" /></td>
															<td
																class="price align-middle text-body fs-9 fw-semibold text-end"><fmt:formatNumber
																	value="${item.product.price}" type="number"
																	minFractionDigits="2" maxFractionDigits="2" /></td>
															<td class="quantity align-middle fs-8 ps-5">
																<form action="CartController?action=update"
																	method="post" class="d-inline">
																	<div class="d-flex align-items-center gap-2">
																		<!-- Quantity input group -->
																		<div class="input-group input-group-sm flex-nowrap"
																			data-quantity="data-quantity">

																			<input readonly name="quantity"
																				class="form-control text-center input-spin-none"
																				type="number" min="1" style="min-width: 60px;"
																				value="<c:out value='${item.quantity}'/>"
																				aria-label="Amount (to the nearest dollar)" />

																		</div>



																	</div>

																	<input type="hidden" name="pid"
																		value="${item.product.id}">
																</form>
															</td>


															<td
																class="total align-middle fw-bold text-body-highlight text-end"><fmt:formatNumber
																	value="${item.product.price*item.quantity}"
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" /></td>
															<td
																class="action align-middle white-space-nowrap text-end pe-0 ">





															</td>


														</tr>
													</c:forEach>

												</c:when>
												<c:otherwise>

													<tr>
														<td colspan="12" class="text-center py-5">
															<div
																class="d-flex flex-column align-items-center justify-content-center">
																<i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
																<h5 class="text-muted mb-2">No items Found</h5>
																<p class="text-muted mb-0">There are currently no
																	items to display.</p>
															</div>
														</td>
													</tr>


												</c:otherwise>
											</c:choose>



											<tr class="cart-table-row btn-reveal-trigger">
												<td class="text-body-emphasis fw-semibold ps-0 fs-8"
													colspan="6">Items subtotal :</td>
												<td class="text-body-emphasis fw-bold text-end fs-8">RM<fmt:formatNumber
														value="${subTotalPrice}" type="number"
														minFractionDigits="2" maxFractionDigits="2" /></td>
												<td></td>
											</tr>
										</tbody>

									</table>
								</div>
								<div class="d-flex justify-content-center mt-3">
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
				<div class="col-12 col-lg-3">
					<div class="card">
						<div class="card-body">
							<div class="d-flex flex-between-center mb-3">
								<h3 class="card-title mb-0">Summary</h3>

							</div>
							<select class="form-select mb-3" aria-label="delivery type">
								<option value="Online Banking" Selected readonly disabled>Online
									Banking</option>

							</select>
							<div>

								<div class="d-flex justify-content-between">
									<p class="text-body fw-semibold">Subtotal :</p>
									<p class="text-body-emphasis fw-semibold">
										RM
										<fmt:formatNumber value="${subTotalPrice}" type="number"
											minFractionDigits="2" maxFractionDigits="2" />
									</p>
								</div>

							</div>

							<div
								class="d-flex justify-content-between border-y border-dashed py-3 mb-4">
								<h4 class="mb-0">Total :</h4>
								<h4 class="mb-">
									RM
									<fmt:formatNumber value="${subTotalPrice}" type="number"
										minFractionDigits="2" maxFractionDigits="2" />
								</h4>
							</div>




							<c:choose>
								<c:when test="${payment.status == 'Completed' }">
									<a
										href="OrderController?action=generateReceipt&oid=${order.id}"
										rel="noopener" target="_blank">
										<button
											class="btn btn-secondary me-1 mb-1 w-100 text-decoration-none rounded-5"
											type="button">
											<span class="fas fa-print me-2"></span>Print Receipt
										</button>
									</a>
								</c:when>

								<c:otherwise>
									<a href="ProductController?action=productCatalogue">
										<button
											class="btn btn-secondary me-1 mb-1 w-100 text-decoration-none rounded-5"
											type="button">Make A New Order</button>
									</a>
								</c:otherwise>

							</c:choose>




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
	<%@include file="/includes/flash.jsp"%>
</body>
</html>