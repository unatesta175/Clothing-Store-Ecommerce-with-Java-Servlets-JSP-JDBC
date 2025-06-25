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
<title>Expose Printing | Home</title>

<style>
.product-image-wrapper {
	position: relative;
	width: 100%;
	aspect-ratio: 1/1; /* modern method, keeps it square */
	border-radius: 1rem;
	overflow: hidden;
	background-color: #fff;
}

.product-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center; /* ensures central focus */
	border-radius: 1rem;
}
</style>
</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>

	<!-- ============================================-->
	<!-- <section> begin ============================-->
	<section class="pt-5 pb-9">
		<div class="product-filter-container">
			
			<div class="row justify-content-center">
				
				<div class="col-lg-9 col-xxl-10">
					<div class="row gx-3 gy-6 mb-8">


						<c:forEach items="${ products}" var="prod">
							<div class="col-12 col-sm-6 col-md-4 col-xxl-2">
								<div class="product-card-container h-100">
									<div
										class="position-relative text-decoration-none product-card h-100">
										<div class="d-flex flex-column justify-content-between h-100">
											<div>
												<div
													class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
													<!-- <button
														class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
														data-bs-toggle="tooltip" data-bs-placement="top"
														title="Add to wishlist">
														<span class="fas fa-heart d-block-hover"></span><span
															class="far fa-heart d-none-hover"></span>
													</button> -->
													<div class="product-image-wrapper">
														<img class="product-image" src="${ prod.image}"
															alt="${ prod.name}" />
													</div>
												</div>
												<a class="stretched-link text-decoration-none"
													href="ProductController?action=viewProduct&pid=<c:out value='${prod.id}' />">
													<h4 class="mb-2 lh-sm line-clamp-3 product-name">${ prod.name }</h4>
												</a>

												<!-- 	<p class="fs-9">
													<span class="fa fa-star text-warning"></span><span
														class="fa fa-star text-warning"></span><span
														class="fa fa-star text-warning"></span><span
														class="fa fa-star text-warning"></span><span
														class="fa fa-star text-warning"></span><span
														class="text-body-quaternary fw-semibold ms-1">(67
														people rated)</span>
												</p> -->
											</div>
											<div>

												<div class="d-flex align-items-center mb-1">

													<h3 class="text-body-tertiary mb-0">
														RM
														<fmt:formatNumber value="${prod.price}" type="number"
															minFractionDigits="2" maxFractionDigits="2" />
													</h3>
												</div>
												<p class="text-body-tertiary fw-semibold fs-9 lh-1 mb-0">
													${prod.variantCount} size(s) available</p>
												<span class="mt-2 badge badge-phoenix badge-phoenix-primary">${prod.category}</span>
											</div>
										</div>
									</div>
								</div>
							</div>

						</c:forEach>



					
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