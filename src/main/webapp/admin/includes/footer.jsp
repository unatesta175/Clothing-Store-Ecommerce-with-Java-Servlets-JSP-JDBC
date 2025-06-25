<footer class="main-footer">
	<strong>Copyright &copy; 2025 <a href="#">Expose Printing</a>.
	</strong> All rights reserved.
	<div class="float-right d-none d-sm-inline-block">
		<b>Version</b> 1.0
	</div>
</footer>

<!-- jQuery -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
	$.widget.bridge('uibutton', $.ui.button)
</script>
<!-- Bootstrap 4 -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/chart.js/Chart.min.js"></script>
<!-- Sparkline -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/jqvmap/jquery.vmap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/jqvmap/maps/jquery.vmap.malaysia.js"></script>
<!-- jQuery Knob Chart -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/moment/moment.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script
	src="<%=request.getContextPath()%>/admin/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables/jquery.dataTables.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/jszip/jszip.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/pdfmake/pdfmake.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/pdfmake/vfs_fonts.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/admin/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/admin/dist/js/demo.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/admin/dist/js/map.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script
	src="<%=request.getContextPath()%>/admin/dist/js/pages/dashboard.js"></script>
<script
	src="<%=request.getContextPath()%>/admin/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

<script>
	$(function() {
		bsCustomFileInput.init();
	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const fileInput = document.getElementById("exampleInputFile");
		const fileLabel = document.querySelector(".custom-file-label");
		const previewImage = document.getElementById("previewImage");

		fileInput.addEventListener("change", function() {
			const file = this.files[0];
			if (file) {
				fileLabel.textContent = file.name;

				const reader = new FileReader();
				reader.onload = function(e) {
					previewImage.src = e.target.result; // Set preview to selected image
				};
				reader.readAsDataURL(file);
			}
		});
	});
</script>

<script>
	$(function() {

		$("#example1").DataTable({
			"responsive" : true,
			"lengthChange" : false,
			"autoWidth" : false,
			"buttons" : [ "copy", "csv", "excel", "pdf", "print", "colvis" ]
		}).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
		$('#example2').DataTable({
			"paging" : true,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"info" : true,
			"autoWidth" : false,
			"responsive" : true,
		});
	});
</script>

<script>
        
$("#location-tab").one('click', function () {
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/location",
        type: "GET",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        }
    }).done(function (data) {
        var ordersData = {};

        data.forEach(function (item) {
            ordersData[item.code] = item.count;
        });

        $("#malaysia-map").vectorMap({
            map: "malaysia",
            backgroundColor: "transparent",
            zoomOnScroll: true,
            regionStyle: {
                initial: {
                    fill: "rgba(255, 255, 255, 0.7)",
                    "fill-opacity": 1,
                    stroke: "rgba(0,0,0,.2)",
                    "stroke-width": 1,
                    "stroke-opacity": 1,
                },
            },
            series: {
                regions: [{
                    values: ordersData,
                    scale: ["#C8EEFF", "#0071A4"],
                    normalizeFunction: 'polynomial'
                }]
            },
            onLabelShow: function (e, el, code) {
                if (typeof ordersData[code] !== "undefined") {
                    el.html(el.html() + " - Customers: " + ordersData[code]);
                }
            },
            onRegionClick: function (e, code) {
                if (typeof ordersData[code] !== "undefined") {
                    console.log("Region: " + code + ", Customers: " + ordersData[code]);
                }
            }
        });
    }).fail(function (xhr, status, error) {
        console.error("Error loading location data:", error);
        console.error("Status:", status);
        console.error("Response:", xhr.responseText);
    });
});

    </script>

