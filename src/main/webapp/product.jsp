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
</head>
<body>
	<%@ include file="/includes/navbar.jsp"%>

	<!-- ============================================-->
	<!-- <section> begin ============================-->
	<div class="pt-5 pb-9">
		<section class="py-0">
			<div class="container-small">
				<nav class="mb-3" aria-label="breadcrumb">
					<ol class="breadcrumb mb-0">

						<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
						<li class="breadcrumb-item "><a
							href="ProductController?action=productCatalogue">Product
								Catalogue</a></li>
						<li class="breadcrumb-item active" aria-current="page">${ product.name}</li>
					</ol>
				</nav>
				<div class="row g-5 mb-5 mb-lg-8"
					data-product-details="data-product-details">

					<div class="col-12 col-lg-6">
						<div class="row g-3 mb-3">
							<div class="col-12 col-md-2 col-lg-12 col-xl-2">
								<div
									class="swiper-products-thumb swiper swiper-container theme-slider overflow-visible"
									id="swiper-products-thumb"></div>
							</div>
							<div class="col-12 col-md-10 col-lg-12 col-xl-10">
								<div
									class="d-flex align-items-center border border-translucent rounded-3 bg-body-emphasis rounded-4  text-center p-5 h-100">
									<div class="swiper swiper-container theme-slider"
										data-thumb-target="swiper-products-thumb"
										data-products-swiper='{"slidesPerView":1,"spaceBetween":16,"thumbsEl":".swiper-products-thumb"}'></div>
								</div>
							</div>
						</div>

					</div>
					<div class="col-12 col-lg-6">
						<div class="d-flex flex-column justify-content-between h-100">
							<div>

								<h2 class="mb-1 lh-sm text-body-tertiary">${ product.name }</h2>


								<c:choose>
									<c:when test="${ productcollarType == '' }">

										<span class="badge badge-phoenix badge-phoenix-secondary mb-1">${ productfitType  }</span>
									</c:when>

									<c:when test="${ productfitType == '' }">
										<span class="badge badge-phoenix badge-phoenix-secondary mb-1">${ productcollarType }
										</span>

									</c:when>

								</c:choose>


								<div class="d-flex flex-wrap align-items-start mb-3">

									<span class="badge badge-phoenix badge-phoenix-primary">${product.category}</span>
								</div>

								<div class="d-flex flex-wrap align-items-center">
									<h1 class="me-3">
										RM
										<fmt:formatNumber value="${product.price}" type="number"
											minFractionDigits="2" maxFractionDigits="2" />
									</h1>

								</div>
								<c:choose>
									<c:when test="${ product.stock > 0}">
										<span
											class="badge badge-phoenix fs-9 badge-phoenix-success mb-2"><span
											class="badge-label">In stock</span><span class="ms-1"
											data-feather="check" style="height: 12.8px; width: 12.8px;"></span></span>

										<!-- 	<p class="text-success fw-semibold fs-7 mb-2">In stock</p> -->
									</c:when>
									<c:otherwise>

										<!-- <p class="text-warning fw-semibold fs-7 mb-2">Out of stock</p> -->
										<span
											class="badge badge-phoenix fs-9 badge-phoenix-danger mb-2"><span
											class="badge-label">Out of Stock</span><span class="ms-1"
											data-feather="x" style="height: 12.8px; width: 12.8px;"></span></span>
									</c:otherwise>
								</c:choose>


								<p class="mb-4 text-body-secondary">
									<strong class="text-body-highlight">${product.description}
								</p>

								<div class="d-flex product-color-variants"
									data-product-color-variants="data-product-color-variants">
									<div hidden
										class="rounded-1 border border-translucent me-2 active"
										data-variant="Blue"
										data-products-images='["${product.image}"]'>
										<img src="${product.image}" alt="" width="38" />
									</div>

								</div>

								<form action="CartController" method="post">
									<input name="action" type="hidden" value="create"> <input
										name="price" type="hidden" value="${product.price}">


									<div class="mb-3">
										<div class="row g-3 g-sm-5 align-items-end">
											<div class="col-12 col-sm-auto">
												<p class="fw-semibold mb-2 text-body">Size :</p>
												<div class="d-flex align-items-center">
													<select name="productId" class="form-select w-auto">



														<c:forEach items="${ prodVars }" var="prodVar">
															<c:choose>
																<c:when test="${ prodVar.stock > 0}">
																	<option value="${ prodVar.id}">${ prodVar.size}
																		- stock left : ${ prodVar.stock}</option>
																</c:when>
															</c:choose>
														</c:forEach>


													</select>
												</div>
											</div>
											<div class="col-12 col-sm">
												<p class="fw-semibold mb-2 text-body">Quantity :</p>
												<div class="d-flex justify-content-between align-items-end">
													<div class="d-flex flex-between-center"
														data-quantity="data-quantity">
														<button type="button" class="btn btn-phoenix-primary px-3"
															data-type="minus">
															<span class="fas fa-minus"></span>
														</button>
														<input name="quantity"
															class="form-control text-center input-spin-none bg-transparent border-0 outline-none"
															style="width: 50px;" type="number" min="1" value="1" />
														<button type="button" class="btn btn-phoenix-primary px-3"
															data-type="plus">
															<span class="fas fa-plus"></span>
														</button>
													</div>
													<button class="btn btn-phoenix-primary px-3 border-0"></button>
												</div>
											</div>
										</div>
									</div>
									<div class="d-flex">

										<button type="submit"
											class="btn btn-lg btn-warning rounded-pill w-100 fs-9 fs-sm-8">
											<span class="fas fa-shopping-cart me-2"></span>Add to cart
										</button>

									</div>
								</form>


							</div>
							<div></div>
						</div>
					</div>
				</div>
				<!-- end of .container-->
		</section>






	</div>
	<!-- <section> close ============================-->
	<!-- ============================================-->




	<%@include file="/includes/footer.jsp"%>
	<%@include file="/includes/flash.jsp"%>
</body>
</html>