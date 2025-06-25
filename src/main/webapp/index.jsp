<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>

<meta charset="UTF-8">
<title>Expose Printing | Home</title>
</head>
<body>
	<%@ include file="/includes/navbar.jsp" %>
	
	<div class="container mt-3">
		<div class="section">
			<div class="container col-xxl-12 px-4 py-3">
				<div class="row flex-lg-row-reverse align-items-center g-5 py-5">
					<div class="col-10 col-sm-8 col-lg-6">

						<img src="images/hero1.png" class="d-block mx-lg-auto img-fluid"
							alt="Hero Image" width="700" height="500" loading="lazy">
					</div>
					<div class="col-lg-6">
						<h1 class="display-3 fw-bold text-body-emphasis lh-1 mb-3">Looking 
							for the perfect design of jersey?</h1>
						<p class="lead fs-7">Design your dream jersey with
							ease—whether for your team, business, or event. High-quality
							prints, quick delivery, and endless customization options await.</p>
						<div class="d-grid gap-2 d-md-flex justify-content-md-start">
							<a href="ProductController?action=productCatalogue"><button type="button" class="btn btn-dark btn-lg px-4 me-md-2">Shop
								Now</button></a>

						</div>

						<div class="row g-5 py-3 row-cols-3 row-cols-lg-3">
							<div class="feature col border-end">
								<h3 class="display-6 text-body-emphasis fw-bold">800+</h3>
								<p class="text-body-tertiary">Flagship Design</p>
							</div>
							<div class="feature col border-end">
								<h3 class="display-6 text-body-emphasis fw-bold">100%</h3>
								<p class="text-body-tertiary">High Quality Products</p>
							</div>
							<div class="feature col">
								<h3 class="display-6 text-body-emphasis fw-bold">10,000+</h3>
								<p class="text-body-tertiary">Customers Worldwide</p>
							</div>
						</div>
						
						
						
						
					</div>
				</div>
			</div>
		</div>
	</div>



<%@include file="/includes/footer.jsp"%>
</body>
</html>