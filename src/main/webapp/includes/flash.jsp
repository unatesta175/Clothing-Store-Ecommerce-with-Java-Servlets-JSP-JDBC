<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
if (session.getAttribute("successLoginMessage") != null) {
%>
<script>
	$(function() {
		var Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 2000, // Optional: if you want the toast to disappear after 3 seconds
		});
		Toast.fire({
			icon : 'success',
			title : "${successLoginMessage}"
		}).then(function() {
			// Redirect after the SweetAlert2 message is shown
			<%session.removeAttribute("successLoginMessage");%>
			window.location.href = 'index.jsp';
		});
	});
</script>
<%
}
%>


<%
if (session.getAttribute("successMessage") != null) {
%>
<script>
	$(function() {
		var Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 3000, // Optional: if you want the toast to disappear after 3 seconds
		});
		Toast.fire({
			icon : 'success',
			title : "${successMessage}"
		}).then(function() {
			// Redirect after the SweetAlert2 message is shown
			<%session.removeAttribute("successMessage");%>
			
		});
	});
</script>
<%
}
%>

<%
if (session.getAttribute("errorMessage") != null) {
%>
<script>
	$(function() {
		var Toast = Swal.mixin({
			toast : true,
			position : 'top-end',
			showConfirmButton : false,
			timer : 7000, // Optional: if you want the toast to disappear after 3 seconds
		});
		Toast.fire({
			icon : 'error',
			title : "${errorMessage}"
		}).then(function() {
			
			<%session.removeAttribute("errorMessage");%>
			
		});
	});
</script>
<%
}
%>


