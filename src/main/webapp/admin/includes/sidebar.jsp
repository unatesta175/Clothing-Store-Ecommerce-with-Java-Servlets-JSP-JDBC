<%@ page import="expose.model.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<aside class=" main-sidebar sidebar-light-warning elevation-4">
	<!-- Brand Logo -->
	<a href="${pageContext.request.contextPath}/admin/index.jsp"
		class="brand-link"> <img
		src="<%=request.getContextPath()%>/admin/dist/img/logo-expose.png"
		alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
		style="opacity: .8"> <span class="brand-text font-weight-light">Expose
			Print</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class="user-panel mt-2 pb-2 mb-3 d-flex align-items-center">
			<div class="image me-2">

				<c:choose>
					<c:when test="${sessionScope.employee.role == 'Admin' }">

						<c:choose>
							<c:when test="${ not empty sessionScope.employee.image }">
								<img src="${sessionScope.employee.image}"
									class="img-circle elevation-2" alt="User Image"
									style="height: 35px; width: 35px;">
							</c:when>
							<c:otherwise>
								<img src="<%=request.getContextPath()%>/admin/dist/img/man.png"
									class="img-circle elevation-2" alt="User Image"
									style="height: 35px; width: 35px;">
							</c:otherwise>
						</c:choose>


					</c:when>
					<c:otherwise>
						<img
							src="<%=request.getContextPath()%>/admin/dist/img/officer.png"
							class="img-circle elevation-2" alt="User Image"
							style="height: 35px; width: 35px;">
					</c:otherwise>
				</c:choose>

			</div>
			<div class="info">

				<c:choose>
					<c:when test="${not empty sessionScope.employee }">
						<div class="text-bold " style="font-weight: bold;">
							<c:out value="${sessionScope.employee.role}" />
						</div>
						<div
							style="font-size: 14px !important; text-transform: capitalize; color: #555; white-space: normal !important;">
							<c:out value="${sessionScope.employee.name}" />
						</div>


					</c:when>
				</c:choose>
			</div>



		</div>





		<!-- SidebarSearch Form -->


		<!-- Sidebar Menu -->
		<nav class=" mt-2">
			<ul class="nav nav-child-indent nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
				<li class="nav-item "><a
					href="${pageContext.request.contextPath}/admin/index.jsp"
					class="<%="dashboard".equalsIgnoreCase(activePage) ? "nav-link active" : "nav-link"%>">
						<i class="nav-icon fas fa-tachometer-alt"></i>
						<p>Dashboard</p>
				</a></li>



				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/EmployeeController?action=profile"
					class="<%="profile".equalsIgnoreCase(activePage) ? "nav-link active" : "nav-link"%>">
						<i class="nav-icon fas fa-user"></i>
						<p>Profile</p>
				</a></li>


				<c:choose>
					<c:when
						test="${not empty sessionScope.employee and sessionScope.employee.role == 'Admin'}">
						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/EmployeeController?action=listEmployee"
							class="<%="employees".equalsIgnoreCase(activePage) ? "nav-link active" : "nav-link"%>">
								<i class="nav-icon fas fa-users"></i>
								<p>Employees</p>
						</a></li>
					</c:when>
				</c:choose>


				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/OrderController?action=listOrder"
					class="<%="orders".equalsIgnoreCase(activePage) ? "nav-link active" : "nav-link"%>">
						<i class="nav-icon fas fa-shopping-cart"></i>
						<p>Orders</p>
				</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/ProductController?action=listProduct"
					class="<%="products".equalsIgnoreCase(activePage) ? "nav-link active" : "nav-link"%>">
						<i class="nav-icon fas fa-shopping-bag"></i>
						<p>Products</p>
				</a></li>

				<li class="nav-item "><a
					href="${pageContext.request.contextPath}/EmployeeController?action=logout"
					class="nav-link"> <i class="nav-icon fas fa-sign-out-alt"></i>
						<p>Logout</p>
				</a></li>



			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>