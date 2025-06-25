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

								<span class="badge badge-phoenix badge-phoenix-secondary mb-1">${ productcollarType }
									collar</span> <span
									class="badge badge-phoenix badge-phoenix-secondary mb-1">${ productfitType  }</span>

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
<input name="action" type="hidden" value="create">
									<input name="price" type="hidden" value="${product.price}">


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

	<!-- ============================================-->
	<!-- <section> begin ============================-->
	<section class="py-0 mb-9">
		<div class="container">
			<div class="d-flex flex-between-center mb-3">
				<div>
					<h3>Similar Products</h3>
					<p class="mb-0 text-body-tertiary fw-semibold">Essential for a
						better life</p>
				</div>
				<button class="btn btn-sm btn-phoenix-primary">View all</button>
			</div>
			<div class="swiper-theme-container products-slider">
				<div class="swiper swiper-container theme-slider"
					data-swiper='{"slidesPerView":1,"spaceBetween":16,"breakpoints":{"450":{"slidesPerView":2,"spaceBetween":16},"768":{"slidesPerView":3,"spaceBetween":16},"992":{"slidesPerView":4,"spaceBetween":16},"1200":{"slidesPerView":5,"spaceBetween":16},"1540":{"slidesPerView":6,"spaceBetween":16}}}'>
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-4.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">FC
												Barcelona Home Jersey 2023/24 (Player Version)</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(59
												people rated)</span>
										</p>
									</div>
									<div>
										<div class="d-flex align-items-center mb-1">
											<p class="me-2 text-body text-decoration-line-through mb-0">RM49.99</p>
											<h3 class="text-body-emphasis mb-0">RM34.99</h3>
										</div>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-5.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">FC
												Barcelona Away Jersey 2023/24 (Player Version)</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(13
												people rated)</span>
										</p>
									</div>
									<div>

										<div class="d-flex align-items-center mb-1">
											<p class="me-2 text-body text-decoration-line-through mb-0">RM1299.00</p>
											<h3 class="text-body-emphasis mb-0">RM1149.00</h3>
										</div>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-2.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">Nike
												Liverpool Home Jersey 2023/24 (Player Version)</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(64
												people rated)</span>
										</p>
									</div>
									<div>
										<h3 class="text-body-emphasis">RM59.00</h3>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-3.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">Adidas
												Manchester United Pre-Match Jersey 2023/24</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(32
												people rated)</span>
										</p>
									</div>
									<div>
										<p class="fs-9 text-body-highlight fw-bold mb-2">Stock
											limited</p>
										<div class="d-flex align-items-center mb-1">
											<p class="me-2 text-body text-decoration-line-through mb-0">RM899.99</p>
											<h3 class="text-body-emphasis mb-0">RM855.00</h3>
										</div>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-4.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">Nike
												Chelsea Home Jersey 2023/24 (Stadium Version)</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(39
												people rated)</span>
										</p>
									</div>
									<div>

										<h3 class="text-body-emphasis">RM59.00</h3>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-5.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">Nike
												Chelsea Away Jersey 2023/24 (Stadium Version)</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(6
												people rated)</span>
										</p>
									</div>
									<div>
										<p class="fs-9 text-body-highlight fw-bold mb-1">Bundle
											availabe</p>
										<p class="fs-9 text-body-tertiary mb-2">Charger not
											included</p>
										<h3 class="text-body-emphasis">RM89.00</h3>

									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div
								class="position-relative text-decoration-none product-card h-100">
								<div class="d-flex flex-column justify-content-between h-100">
									<div>
										<div
											class="bg-body-emphasis rounded-4  border border-1 border-translucent rounded-3 position-relative mb-3">
											<button
												class="btn rounded-circle p-0 d-flex flex-center btn-wish z-2 d-toggle-container btn-outline-primary"
												data-bs-toggle="tooltip" data-bs-placement="top"
												title="Add to wishlist">
												<span class="fas fa-heart d-block-hover"></span><span
													class="far fa-heart d-none-hover"></span>
											</button>
											<img class="img-fluid"
												src="<%=request.getContextPath()%>/images/jersey-6.png"
												alt="" />
										</div>
										<a class="stretched-link" href="product-details.html">
											<h6 class="mb-2 lh-sm line-clamp-3 product-name">New
												York Mets MLB Varsity Jacket</h6>
										</a>
										<p class="fs-9">
											<span class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="fa fa-star text-warning"></span><span
												class="text-body-quaternary fw-semibold ms-1">(67
												people rated)</span>
										</p>
									</div>
									<div>
										<div class="d-flex align-items-center mb-1">
											<p class="me-2 text-body text-decoration-line-through mb-0">RM125.00</p>
											<h3 class="text-body-emphasis mb-0">RM89.00</h3>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="swiper-nav">
					<div class="swiper-button-next">
						<span class="fas fa-chevron-right nav-icon"></span>
					</div>
					<div class="swiper-button-prev">
						<span class="fas fa-chevron-left nav-icon"></span>
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