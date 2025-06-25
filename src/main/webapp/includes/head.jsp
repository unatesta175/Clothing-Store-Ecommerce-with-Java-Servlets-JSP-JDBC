<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">



<!-- ===============================================-->
<!--    Favicons-->
<!-- ===============================================-->
<link rel="apple-touch-icon" sizes="180x180"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="shortcut icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<link rel="manifest"
	href="<%=request.getContextPath()%>/images/logo-expose.png">
<meta name="msapplication-TileImage"
	content="<%=request.getContextPath()%>/images/logo-expose.png">
<meta name="theme-color" content="#ffffff">
<script
	src="<%=request.getContextPath()%>/vendors/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script
	src="<%=request.getContextPath()%>/vendors/simplebar/simplebar.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/config.js"></script>


<!-- ===============================================-->
<!--    Stylesheets-->
<!-- ===============================================-->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com/">
<link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin="">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&amp;display=swap"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/vendors/simplebar/simplebar.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://polyfill.io/v3/polyfill.min.js?features=window.scroll">
<link href="<%=request.getContextPath()%>/assets/css/theme-rtl.min.css"
	type="text/css" rel="stylesheet" id="style-rtl">
<link href="<%=request.getContextPath()%>/assets/css/theme.min.css"
	type="text/css" rel="stylesheet" id="style-default">
<link href="<%=request.getContextPath()%>/assets/css/user-rtl.min.css"
	type="text/css" rel="stylesheet" id="user-style-rtl">
<link href="<%=request.getContextPath()%>/assets/css/user.min.css"
	type="text/css" rel="stylesheet" id="user-style-default">
    
    


<script>
	var phoenixIsRTL = window.config.config.phoenixIsRTL;
	if (phoenixIsRTL) {
		var linkDefault = document.getElementById('style-default');
		var userLinkDefault = document.getElementById('user-style-default');
		linkDefault.setAttribute('disabled', true);
		userLinkDefault.setAttribute('disabled', true);
		document.querySelector('html').setAttribute('dir', 'rtl');
	} else {
		var linkRTL = document.getElementById('style-rtl');
		var userLinkRTL = document.getElementById('user-style-rtl');
		linkRTL.setAttribute('disabled', true);
		userLinkRTL.setAttribute('disabled', true);
	}
</script>

<link
	href="<%=request.getContextPath()%>/vendors/swiper/swiper-bundle.min.css"
	rel="stylesheet">
</head>