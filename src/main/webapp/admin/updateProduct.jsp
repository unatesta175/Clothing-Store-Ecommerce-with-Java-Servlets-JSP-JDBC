


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

request.setAttribute("activePage", "Products");
String activePage = (String) request.getAttribute("activePage");

//Redirect if the session is null
if (session.getAttribute("employee") == null) {
	response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<%@include file="./includes/head.jsp"%>
<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">

		<!-- Preloader -->
		<%@include file="./includes/preloader.jsp"%>

		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links -->
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" data-widget="pushmenu"
					href="#" role="button"><i class="fas fa-bars"></i></a></li>
				<li class="nav-item d-none d-sm-inline-block"><a
					href="${pageContext.request.contextPath}/admin/index.jsp" class="nav-link">Home</a></li>

			</ul>


		</nav>
		<!-- /.navbar -->


		<%@include file="./includes/sidebar.jsp"%>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">Update Product</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/index.jsp">Home</a></li>
								<li class="breadcrumb-item"><a
									href="${pageContext.request.contextPath}/ProductController?action=listproduct">List
										Product</a></li>
								<li class="breadcrumb-item active">Update Product</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->







			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- left column -->
						<div class="col-md-6">

							<div class="card " style="border-radius: 10px;">
								<div class="card-header">
									<h3 class="card-title">Product Details</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form method="post" enctype="multipart/form-data"
									action="${pageContext.request.contextPath}/ProductController"
									class="form-horizontal">
									<div class="card-body">

										<input type="text" name="id" value="${product.id}" hidden>
										<input type="text" name="action" value="update" hidden>


										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Product
												Name </label>
											<div class="col-sm-8">

												<select id="name" class="form-control" name="name"
													style="border-radius: 30px;">
													<option value="" disabled>Choose Product Name</option>
													<option value="${product.name}" selected>${product.name}</option>

													<c:forEach items="${ prodList }" var="prodItem">

														<c:choose>
															<c:when test="${prodItem.name != product.name}">
																<option value="${prodItem.name}">${prodItem.name}</option>
															</c:when>


														</c:choose>


													</c:forEach>




												</select>

											</div>
										</div>





										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Product Image</label>
											<div class="col-sm-8">
												<div class="input-group">
													<div class="custom-file">
														<input type="file" class="custom-file-input"
															id="exampleInputFile" name="image"> <label
															class="custom-file-label" for="exampleInputFile"
															style="border-radius: 30px;">Choose file</label>
													</div>
												</div>

												<input type="hidden" name="existingImage"
													value="${product.image}">

												<!-- Image Preview -->
												<div class="mt-2">

													<img id="previewImage" src="${product.image}"
														alt="No Image"
														style="max-width: 100px; border-radius: 10px;">

												</div>
												<small class="form-text text-muted m-2"> Recommended
													size: 294×310 px. Please ensure your image matches these
													dimensions. </small>
											</div>
										</div>
										





										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Type
											</label>
											<div class="col-sm-8">

												<select id="type" class="form-control" name="type"
													style="border-radius: 30px;">
													<option value="" disabled>Choose Type</option>
													<option selected value="${product.type}">${product.type}</option>


													<option value="Topwear">Topwear</option>
													<option value="Bottomwear">Bottomwear</option>

												</select>

											</div>
										</div>




										<c:choose>
											<c:when test="${ empty productcollarType}">
												<div id="collarType" class="form-group row"
													style="display: none;">
													<label for="inputEmail3" class="col-sm-4 col-form-label">Collar
														Type </label>
													<div class="col-sm-8">

														<select class="form-control" name="collarType"
															style="border-radius: 30px;">
															<option value="" selected>Choose collar type</option>
															<option value="Crew">Crew</option>
															<option value="Polo">Polo</option>
															<option value="V-Neck">V-Neck</option>
															<option value="Mandarin">Mandarin</option>
														</select>

													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div id="collarType" class="form-group row"
													style="display: none;">
													<label for="inputEmail3" class="col-sm-4 col-form-label">Collar
														Type </label>
													<div class="col-sm-8">

														<select class="form-control" name="collarType"
															style="border-radius: 30px;">
															<option value="" disabled>Choose collar type</option>
															<option selected value="${productcollarType}">${productcollarType}</option>
															<option value="Crew">Crew</option>
															<option value="Polo">Polo</option>
															<option value="V-Neck">V-Neck</option>
															<option value="Mandarin">Mandarin</option>
														</select>

													</div>
												</div>
											</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${ empty productfitType}">
												<div id="fitType" class="form-group row"
													style="display: none;">
													<label for="inputEmail3" class="col-sm-4 col-form-label">Fit
														Type </label>
													<div class="col-sm-8">

														<select class="form-control" name="fitType"
															style="border-radius: 30px;">
															<option value="">Choose fit type</option>

															<option value="Straight Fit">Straight Fit</option>
															<option value="Regular Fit">Regular Fit</option>
															<option value="Slim Fit">Slim Fit</option>
															<option value="Skinny Fit">Skinny Fit</option>


														</select>

													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div id="fitType" class="form-group row"
													style="display: none;">
													<label for="inputEmail3" class="col-sm-4 col-form-label">Fit
														Type </label>
													<div class="col-sm-8">

														<select class="form-control" name="fitType"
															style="border-radius: 30px;">
															<option value="">Choose fit type</option>
															<option selected value="${productfitType }">${productfitType}</option>
															<option value="Straight Fit">Straight Fit</option>
															<option value="Regular Fit">Regular Fit</option>
															<option value="Slim Fit">Slim Fit</option>
															<option value="Skinny Fit">Skinny Fit</option>


														</select>

													</div>
												</div>
											</c:otherwise>
										</c:choose>







										<div id="categoryBottomwearDiv" class="form-group row"
											style="display: none;">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Category
											</label>
											<div class="col-sm-8">

												<select id="categoryBottomwear" class="form-control"
													name="category" style="border-radius: 30px;" disabled>
													<option value="">Choose Category</option>
													<option selected value="${product.category}">${product.category}</option>
													<option value="Shorts">Shorts</option>
													<option value="Sweatpant">Sweatpant</option>
													<option value="Tracksuits">Tracksuit</option>


												</select>
											</div>
										</div>

										<div id="categoryTopwearDiv" class="form-group row"
											style="display: none;">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Category
											</label>
											<div class="col-sm-8">

												<select id="categoryTopwear" class="form-control"
													name="category" style="border-radius: 30px;" disabled>
													<option value="">Choose Category</option>
													<option selected value="${product.category}">${product.category}</option>
													<option value="Jersey">Jersey</option>
													<option value="Varsity">Varsity</option>
													<option value="Jacket">Jacket</option>
													<option value="T-shirt">T-shirt</option>
													<option value="Polo Shirt">Polo Shirt</option>
													<option value="Hoodie">Hoodie</option>

												</select>
											</div>
										</div>







										<div class="form-group row">
											<label for="inputEmail3" class="col-sm-4 col-form-label">Size
											</label>
											<div class="col-sm-8">

												<select class="form-control" name="size"
													style="border-radius: 30px;">
													<option disabled value="">Choose Size</option>
													<option selected value="${product.size}">${product.size}</option>
													<option value="XS">XS</option>
													<option value="S">S</option>
													<option value="M">M</option>
													<option value="L">L</option>
													<option value="XL">XL</option>

												</select>

											</div>
										</div>

										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Price (RM)</label>
											<div class="col-sm-8">
												<input type="number" name="price" step="0.01" min="0.01"
													class="form-control" placeholder="Enter product price"
													style="border-radius: 30px;"
													value="<fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />">
											</div>
										</div>



										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Description</label>
											<div class="col-sm-8">
												<textarea name="description" rows="4" class="form-control"
													placeholder="Enter description"
													style="border-radius: 15px;">${product.description} </textarea>
											</div>
										</div>





										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Stock</label>
											<div class="col-sm-8">
												<input type="number" name="stock" class="form-control"
													placeholder="Enter stock count" value="${product.stock}"
													style="border-radius: 30px;">
											</div>
										</div>



									</div>
									<!-- /.card-body -->
									<div class="card-footer ">
										
										<a
											href="${pageContext.request.contextPath}/ProductController?action=listProduct"
											class="btn btn-secondary "
											style="border-radius: 30px;">Back</a>
											
											<input type="submit" class="btn btn-primary float-right"
											style="border-radius: 30px;" value="Submit Changes">
									</div>
									<!-- /.card-footer -->
								</form>
							</div>

						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->



		</div>





		<%@include file="./includes/footer.jsp"%>
		<%@include file="./includes/flash.jsp"%>

		<script>
			$('#type').on('change', function() {
				const selected = $(this).val();

				if (selected === 'Topwear') {
					$('#collarType').show();
					$('#fitType').hide();
				} else if (selected === 'Bottomwear') {
					$('#fitType').show();
					$('#collarType').hide();
				} else {
					$('#collarType').hide();
					$('#fitType').hide();
				}
			});
			$('#type').on(
					'change',
					function() {
						if ($(this).val() === 'Topwear') {
							$('#categoryTopwearDiv').show();
							$('#categoryTopwear').prop('disabled', false);
							$('#categoryBottomwearDiv').hide();
							$('#categoryBottomwear').prop('disabled', true);
						} else if ($(this).val() === 'Bottomwear') {
							$('#categoryBottomwearDiv').show();
							$('#categoryBottomwear').prop('disabled', false);
							$('#categoryTopwearDiv').hide();
							$('#categoryTopwear').prop('disabled', true);
						} else {
							$('#categoryTopwearDiv, #categoryBottomwearDiv')
									.hide();
							$('#categoryTopwear, #categoryBottomwear').prop(
									'disabled', true);
						}
					});

			// Optional: run on page load
			$(document).ready(function() {
				$('#type').trigger('change');
			});
		</script>

	</div>
	<!-- ./wrapper -->


</body>
</html>
