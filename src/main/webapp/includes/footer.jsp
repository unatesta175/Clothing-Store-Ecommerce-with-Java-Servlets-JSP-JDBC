
<section class="bg-body-highlight dark__bg-gray-1100 py-9">
	<div class="container-small">
		<div class="row justify-content-between gy-4">
			<div class="col-12 col-lg-4">
				<div class="d-flex align-items-center mb-3">
					<img src="images/logo-expose.png" alt="phoenix" width="27" />
					<p class="logo-text ms-2">EXPOSE PRINTING</p>
				</div>
				<p class="text-body-tertiary mb-1 fw-semibold lh-sm fs-9">
					Custom Jerseys, Caps & Varsity Jackets - Designed for You, Printed
					by Us. High-quality apparel tailored to match your style and
					passion. Elevate your look with our exclusive prints!</p>
			</div>
			<div class="col-6 col-md-auto">
				<h5 class="fw-bolder mb-3">Visit Us</h5>
				<div class="d-flex flex-column">
					<a class="text-body-tertiary fw-semibold fs-9 mb-1"
						href="${pageContext.request.contextPath}/">Home</a> <a
						class="text-body-tertiary fw-semibold fs-9 mb-1" href="login.jsp">Sign
						In</a> <a class="text-body-tertiary fw-semibold fs-9 mb-1"
						href="register.jsp">Sign Up</a> <a
						class="text-body-tertiary fw-semibold fs-9 mb-1" href="ProductController?action=productCatalogue">Product Catalog</a>
					<a class="text-body-tertiary fw-semibold fs-9 mb-1" href="CustomerController?action=profile">Profile</a>

						
				</div>
			</div>
			<div class="col-6 col-md-auto">
				<h5 class="fw-bolder mb-3">Quick Links</h5>
				<div class="d-flex flex-column">
					<a class="text-body-tertiary fw-semibold fs-9 mb-1"
						href="https://www.google.com/maps/place//data=!4m2!3m1!1s0x31cc4c118980e0e3:0x9fda70bc6b87e680?source=g.page.share"
						target="_blank" rel="noopener noreferrer"> <i
						class="fas fa-map-marker-alt"></i> A-1, 07, Jalan SS 6 / 5a, <br />
						Dataran Glomac, 47301 Petaling Jaya,<br /> Selangor
					</a>
				</div>
			</div>
			<div class="col-6 col-md-auto">
				<h5 class="fw-bolder mb-3">Contact Us</h5>
				<div class="d-flex flex-column">


					<a class="mb-1 fw-semibold fs-9 d-flex underline" href="tel:+60173788108"
						><i class="fa fa-phone me-2 fs-8"></i><span
						class="text-body-secondary">+60 17-378 8108</span> </a> <a
						class="mb-1 fw-semibold fs-9 d-flex" href="#!" target="_blank"><span
						class="fab fa-facebook-square text-primary me-2 fs-8"></span><span
						class="text-body-secondary">Facebook</span></a> <a
						class="mb-1 fw-semibold fs-9 d-flex" href="#!" target="_blank"><span
						class="fab fa-twitter-square text-info me-2 fs-8"></span><span
						class="text-body-secondary">Twitter</span></a> <a
						class="mb-1 fw-semibold fs-9 d-flex"
						href="https://api.whatsapp.com/send?phone=60123469084"
						target="_blank"><span
						class="fab fa-whatsapp-square text-success me-2 fs-8"></span><span
						class="text-body-secondary">Whatsapp</span></a>
				</div>
			</div>

		</div>
	</div>
	<!-- end of .container-->
</section>

<footer class="footer position-relative">
	<div class="row g-0 justify-content-between align-items-center h-100">
		<div class="col-12 col-sm-auto text-center">
			<p class="mb-0 mt-2 mt-sm-0 text-body">
				Expose Printing<span class="d-none d-sm-inline-block"></span><span
					class="d-none d-sm-inline-block mx-1">|</span><br class="d-sm-none" />2024
				&copy;<a class="mx-1">All rights reserved.</a>
			</p>
		</div>
		<div class="col-12 col-sm-auto text-center">
			<p class="mb-0 text-body-tertiary text-opacity-85">v1.0</p>
		</div>
	</div>
</footer>



<!-- ===============================================-->
<!--    JavaScripts-->
<!-- ===============================================-->
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="<%=request.getContextPath()%>/vendors/popper/popper.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/bootstrap/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/anchorjs/anchor.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/is/is.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/fontawesome/all.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/lodash/lodash.min.js"></script>
<script
	src="https://polyfill.io/v3/polyfill.min.js?features=window.scroll"></script>
<script src="<%=request.getContextPath()%>/vendors/list.js/list.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/feather-icons/feather.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/dayjs/dayjs.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/swiper/swiper-bundle.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/dropzone/dropzone.min.js"></script>
<script src="<%=request.getContextPath()%>/vendors/rater-js/index.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/glightbox/glightbox.min.js">
	
</script>
<script src="<%=request.getContextPath()%>/assets/js/phoenix.js"></script><script>document.addEventListener('DOMContentLoaded', function() {
		const avatarFileInput = document.getElementById('avatarFile');

		avatarFileInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					// Find the image within the avatar label and update its src
					const avatarImage = document.querySelector('label[for="avatarFile"] img');
					if (avatarImage) {
						avatarImage.src = e.target.result;
					}
				};
				reader.readAsDataURL(file);
			}
		});
	});</script>


