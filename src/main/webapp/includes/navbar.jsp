
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ============================================-->
<!-- <section> begin ============================-->
<section class="py-0 sticky-navbar">
	<div class="container-small">
		<div class="ecommerce-topbar">
			<nav class="navbar navbar-expand-lg navbar-light px-0 ">
				<div class="row gx-0 gy-2 w-100 flex-between-center">
					<div class="col-auto">

						<div class="d-flex align-items-center">
							<img src="<%=request.getContextPath()%>/images/logo-expose.png"
								alt="phoenix" width="27" /> <a
								class="navbar-brand logo-text ms-2"
								href="${pageContext.request.contextPath}/">Expose Printing</a>
						</div>

					</div>
					<div class="col-auto order-md-1">
						<ul class="navbar-nav navbar-nav-icons flex-row me-n2">




							<c:choose>
								<c:when test="${empty sessionScope.customer}">
									<!-- Not logged in -->


									<li class="nav-item"><a href="login.jsp"><button
												type="button"
												class="btn btn-outline-primary me-1 mb-1 rounded-5"
												class="nav-link px-2">Login</button> </a></li>

									<li class="nav-item"><a href="register.jsp"><button
												type="button" class="btn btn-secondary me-1 mb-1 rounded-5"
												class="nav-link px-2">Sign Up</button></a></li>

									<li class="nav-item"><a
										class="nav-link px-2 icon-indicator icon-indicator-primary"
										href="CartController?action=viewCart" role="button"><span
											class="text-body-tertiary" data-feather="shopping-cart"
											style="height: 20px; width: 20px;"></span><span
											class="icon-indicator-number"><span style="font-size: 10px;">0</span></span></a></li>
								</c:when>
								<c:otherwise>
									<!-- Logged in -->
									<c:set var="cartCount"
										value="${sessionScope.cartCount != null ? sessionScope.cartCount : 0}" />
									
									<li class="nav-item"><a
										class="nav-link px-2 icon-indicator icon-indicator-primary"
										href="CartController?action=viewCart" role="button"><span
											class="text-body-tertiary" data-feather="shopping-cart"
											style="height: 20px; width: 20px;"></span><span
											class="icon-indicator-number"><span style="font-size: 10px;">${cartCount}</span></span></a></li>

									<li class="nav-item dropdown"><a class="nav-link px-2"
										id="navbarDropdownUser" href="#" role="button"
										data-bs-toggle="dropdown" data-bs-auto-close="outside"
										aria-haspopup="true" aria-expanded="false"><span
											class="text-body-tertiary" data-feather="user"
											style="height: 20px; width: 20px;"></span></a>
										<div
											class="dropdown-menu dropdown-menu-end navbar-dropdown-caret py-0 dropdown-profile shadow border mt-2"
											aria-labelledby="navbarDropdownUser">
											<div class="card position-relative border-0">
												<div class="card-body p-0">
													<div class="text-center pt-4 pb-3">
														<div class="avatar avatar-xl ">
														
													<c:choose>
													<c:when test="${empty sessionScope.customer.image}">
													<img class="rounded-circle "
																src="images/man.png"
																alt="" />
													</c:when>
													<c:otherwise>
													<img class="rounded-circle "
																src="${sessionScope.customer.image}"
																alt="" />
													</c:otherwise>
													</c:choose>
															
														</div>
														<h6 class="mt-2 text-body-emphasis">
															<c:out value="${sessionScope.customer.name}" />
															
														</h6>
													</div>
													<div class="mb-3 mx-3">
														<input readonly disabled
															class="form-control form-control-sm"
															id="statusUpdateInput" type="text"
															placeholder="<c:out value="${sessionScope.customer.email}"/>" />
													</div>
												</div>
												<div class="overflow-auto scrollbar" style="height: 10rem;">
													<ul class="nav d-flex flex-column mb-2 pb-1">
														<li class="nav-item"><a class="nav-link px-3"
															href="CustomerController?action=profile"> <span class="me-2 text-body"
																data-feather="user"></span><span>Profile</span>
														</a></li>
														<li class="nav-item"><a class="nav-link px-3"
															href="OrderController?action=orderhistory"><span class="me-2 text-body"
																data-feather="pie-chart"></span>Order History</a></li>

														<li class="nav-item"><a class="nav-link px-3"
															href="CartController?action=viewCart"> <span class="me-2 text-body"
																data-feather="shopping-cart"></span>Cart
														</a></li>
														

													</ul>
												</div>
												<div class="card-footer p-0 border-top border-translucent">


													<div class="px-3 mb-3 mt-3">
														<a
															class="btn btn-phoenix-secondary d-flex flex-center w-100"
															href="CustomerController?action=logout"> <span
															class="me-2" data-feather="log-out"> </span>Sign out
														</a>
													</div>

												</div>
											</div>
										</div></li>

								</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<div class="col-12 col-md-6">
						<div class="search-box ecommerce-search-box w-100">
							<form class="position-relative" data-bs-toggle="search"
								data-bs-display="static">
								<input class="form-control search-input search form-control-sm"
									type="search" placeholder="Search" aria-label="Search" /> <span
									class="fas fa-search search-box-icon"></span>
							</form>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<!-- end of .container-->
</section>
<!-- <section> close ============================-->
<!-- ============================================-->

<nav
	class="ecommerce-navbar navbar-expand navbar-light bg-body-emphasis justify-content-between ">
	<div class="container-small d-flex flex-between-center"
		data-navbar="data-navbar">
		<div class="dropdown">
			<button
				class="btn text-body ps-0 pe-5 text-nowrap dropdown-toggle dropdown-caret-none"
				data-category-btn="data-category-btn" data-bs-toggle="dropdown">
				<span class="fas fa-bars me-2"></span>Category
			</button>
			<div
				class="dropdown-menu border border-translucent py-0 category-dropdown-menu">
				<div class="card border-0 scrollbar" style="max-height: 657px;">
					<div class="card-body p-6 pb-3">
						<div class="row gx-7 gy-5 mb-5">
							<div class="col-12 col-sm-6 col-md-4">
								<div class="d-flex align-items-center mb-3">
									<span class="text-primary me-2" data-feather="pocket"
										style="stroke-width: 3;"></span>

								</div>
								<div class="ms-n2">
									<a
										class="text-body-emphasis d-block mb-1 text-decoration-none bg-body-highlight-hover px-2 py-1 rounded-2"
										href="#!">Jersey</a> <a
										class="text-body-emphasis d-block mb-1 text-decoration-none bg-body-highlight-hover px-2 py-1 rounded-2"
										href="#!">Varsity</a> <a
										class="text-body-emphasis d-block mb-1 text-decoration-none bg-body-highlight-hover px-2 py-1 rounded-2"
										href="#!">Cap</a>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>
		</div>
		<ul class="navbar-nav justify-content-end align-items-center">
			<li class="nav-item" data-nav-item="data-nav-item"><a
				class="nav-link ps-0 active"
				href="${pageContext.request.contextPath}/">Home</a></li>

			<li class="nav-item" data-nav-item="data-nav-item"><a
				class="nav-link" href="ProductController?action=productCatalogue">Product Catalog</a></li>
			

			<li class="nav-item" data-nav-item="data-nav-item"><a
				class="nav-link" href="OrderController?action=orderhistory">Order History</a></li>
	
		
		</ul>
	</div>
</nav>


