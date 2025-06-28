<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>

<meta charset="UTF-8">
<title>Expose Printing | Order History</title>
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

					<li class="breadcrumb-item active" aria-current="page">Order
						History</li>
				</ol>
			</nav>
			<h2 class="mb-6">Order History</h2>
			<div class="row g-5">
				<div class="col-12 col-lg-12">
					<div class="card">
						<div class="card-body">

							<div id="cartTable"
								data-list='{"valueNames":["order","status","payment","date","total"],"page":6,"pagination":true}'>
								<div class="table-responsive scrollbar mx-n1 px-1">
									<table class="table fs-9 mb-0 border-top border-translucent">
										<thead>
											<tr>
												<th class="sort white-space-nowrap align-middle pe-3 ps-0"
													scope="col" data-sort="order"
													style="width: 15%; min-width: 140px">ORDER</th>
												<th class="sort align-middle pe-3" scope="col"
													data-sort="status" style="width: 15%; min-width: 180px">STATUS</th>
												<th class="sort align-middle pe-3" scope="col"
													data-sort="status" style="width: 15%; min-width: 180px">PAYMENT</th>
												<th class="sort align-middle pe-0 text-end" scope="col"
													data-sort="date" style="width: 15%; min-width: 160px">DATE</th>
												<th class="sort align-middle text-end" scope="col"
													data-sort="total" style="width: 15%; min-width: 160px">TOTAL</th>
												<th class="align-middle pe-0 text-end" scope="col"
													style="width: 15%;"></th>
											</tr>
										</thead>


										<tbody class="list" id="cart-table-body">

											<c:choose>
												<c:when test="${not empty orders}">
													<c:forEach items="${orders}" var="order">
														<tr
															class="hover-actions-trigger btn-reveal-trigger position-static">
															<td
																class="order align-middle white-space-nowrap py-2 ps-0">
																#<c:out value="${order.id}" />
															</td>
															<td
																class="status align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">



																<c:choose>
																	<c:when
																		test="${order.status == 'Payment Failed'  || order.status == 'Failed' }">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-danger">
																			<span class="badge-label"> <c:out
																					value="${order.status}" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>
																	
																	<c:when
																		test="${order.status == 'Pending' }">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-danger">
																			<span class="badge-label"> <c:out
																					value="Failed" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>

																	<c:when test="${order.status == 'Delivered'}">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-success">
																			<span class="badge-label"> <c:out
																					value="${order.status}" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>
																	<c:otherwise>
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-info">
																			<span class="badge-label"> <c:out
																					value="${order.status}" />
																		</span> <span class="ms-1" data-feather="check"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:otherwise>
																</c:choose>



															</td>
															<td
																class="payment align-middle white-space-nowrap text-start fw-bold text-body-tertiary py-2">



																<c:choose>
																	<c:when
																		test="${order.payment.status == 'Failed' && order.payment.status != null}">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-danger">
																			<span class="badge-label"> <c:out
																					value="${order.payment.status}" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>
																	
																	<c:when
																		test="${order.payment.status == null || order.payment.status == 'Pending'}">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-danger">
																			<span class="badge-label"> <c:out
																					value="Failed" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>

																	<c:when test="${order.payment.status == 'Completed'}">
																		<span
																			class="badge badge-phoenix fs-10 badge-phoenix-success">
																			<span class="badge-label"> <c:out
																					value="${order.payment.status}" />
																		</span> <span class="ms-1" data-feather="x-circle"
																			style="height: 12.8px; width: 12.8px;"></span>
																		</span>
																	</c:when>
																	
																</c:choose>



															</td>
															<td
																class="total align-middle text-body-tertiary text-end py-2">
																<fmt:formatDate value="${order.createdAt}" pattern="yyyy/MM/dd hh:mm:ss.S a" />
															</td>
															<td
																class="date align-middle fw-semibold text-end py-2 text-body-highlight">
																RM<fmt:formatNumber value="${order.totalPrice}"
																	type="number" minFractionDigits="2"
																	maxFractionDigits="2" />
															</td>
															<td
																class="align-middle text-end white-space-nowrap pe-0 action py-2">
																<div class="btn-reveal-trigger position-static">
																	<button
																		class="btn btn-sm dropdown-toggle dropdown-caret-none transition-none btn-reveal"
																		type="button" data-bs-toggle="dropdown"
																		data-boundary="window" aria-haspopup="true"
																		aria-expanded="false" data-bs-reference="parent">
																		<span class="fas fa-ellipsis-h fs-10"></span>
																	</button>
																	<div class="dropdown-menu dropdown-menu-end py-2">
																		<a class="dropdown-item"
																			href="OrderController?action=orderDetails&orderId=${order.id}">View</a>

																	</div>
																</div>
															</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>

													<tr>
														<td colspan="9" class="text-center py-5">
															<div
																class="d-flex flex-column align-items-center justify-content-center">
																<i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
																<h5 class="text-muted mb-2">No Orders Found</h5>
																<p class="text-muted mb-0">There are currently no
																	orders to display.</p>
															</div>
														</td>
													</tr>


												</c:otherwise>
											</c:choose>



										</tbody>

									</table>
								</div>
								<div
									class="row align-items-center justify-content-between py-2 pe-0 fs-9">
									<div class="col-auto d-flex">
										<p class="mb-0 d-none d-sm-block me-3 fw-semibold text-body"
											data-list-info="data-list-info"></p>
										<a class="fw-semibold" href="#!" data-list-view="*">View
											all<span class="fas fa-angle-right ms-1"
											data-fa-transform="down-1"></span>
										</a><a class="fw-semibold d-none" href="#!" data-list-view="less">View
											Less<span class="fas fa-angle-right ms-1"
											data-fa-transform="down-1"></span>
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
		<!-- end of .container-->
	</section>
	<!-- <section> close ============================-->
	<!-- ============================================-->



	<%@include file="/includes/footer.jsp"%>
	<%@include file="/includes/flash.jsp"%>
	<script>
		
	</script>
</body>
</html>