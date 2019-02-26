<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
>
<%@ page import="com.driver.model.*"%>
>
<%@ page import="java.util.*"%>
>
<html>
<head>
<meta charset="utf-8">
<title>Be our Driver</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Favicons -->
<link href="img/favicon.png" rel="icon">
<link href="img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Poppins:300,400,500,700"
	rel="stylesheet">

<!-- Bootstrap CSS File -->
<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Libraries CSS Files -->
<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="lib/animate/animate.min.css" rel="stylesheet">

<!-- Main Stylesheet File -->
<link href="css/style.css" rel="stylesheet">

<!-- =======================================================
    Theme Name: Regna
    Theme URL: https://bootstrapmade.com/regna-bootstrap-onepage-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body>
	<!-- 先get 再set -->
	<%
		DriverVO driverVO = (DriverVO) request.getAttribute("driverVO");
	%>

	<%
		LinkedList errorMsgs = (LinkedList) request.getAttribute("errorMsgs");
	%>
	<!-- 錯誤列表 -->
	<c:if test="${not empty errorMsgs}">
		<ul class="list-group">
			<li class="list-group-item active">Opps!錯誤訊息回報</li>
			<c:forEach var="massage" items="${errorMsgs}">
				<li class="list-group-item">${massage}</li>
			</c:forEach>
		</ul>
	</c:if>
	<!--==========================
      Contact Section 
    ============================-->

	<section id="contact">
		<div class="container wow fadeInUp">
			<div class="col-lg-12 col-md-12">
				<div class="section-header">
					<h3 class="section-title">成為司機</h3>
					<div class="text-center">
						<form action="">
							<!-- 以上請寫成為司機的人 action="寫上上一頁的畫面" -->
							<button type="submit" class="btn btn-outline-success"">返回</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="container wow fadeInUp">
			<div class="row justify-content-center">
				<div class="col-lg-12 col-md-12">
					<div class="form">
						<!-- 成為司機開始 -->

						<form action="driver.do" method="post" enctype="multipart/form-data">

							<div class="form-group">
								<p>會員編號</p>
								<input type="text" name="memID" value="M003"
									class="form-control" disabled="disabled" />
							</div>
							<div class="form-group">
								<p>車牌號碼</p>
								<input type="text" name="plateNum" class="form-control"
									value="PIC-0005" placeholder="請輸入車牌號碼" />
							</div>
							<div class="form-group">
								<p>車型</p>
								<select name="carType" class="form-control">
									<option value="Picar">Picar</option>
									<option value="Nissan">Nissan</option>
									<option value="Volkswagen">Volkswagen</option>
									<option value="Skoda">Skoda</option>
									<option value="Audi">Audi</option>
									<option value="Ford">Ford</option>
									<option value="Toyota">Toyota</option>
									<option value="Honda">Honda</option>
									<option value="Mazda">Mazda</option>
									<option value="Mercedes-Benz">Mercedes-Benz</option>
								</select>

							</div>
							<div class="form-group">
								<p>駕照</p>
								<input type="file" class="form-control" name="licence"
									value="" placeholder="請輸入駕照" />
							</div>
							<div class="form-group">
								<p>良民證</p>
								<input type="file" class="form-control" name="criminal"
									value="" />
							</div>

							<div class="form-group">
								<p>肇事紀錄</p>
								<input type="file" class="form-control" name="trafficRecord"
									value="2019-03-29" placeholder="請輸入肇事紀錄" />
							</div>

							<div class="form-group">
								<p>身分證</p>
								<input type="file" class="form-control" name="idNum" value="200"
									placeholder="請上傳身分證" />
							</div>

							<div class="form-group">
								<p>大頭照</p>
								<input type="file" class="form-control" name="photo">
							</div>

							<div class="form-group">
								<p>願意共乘載客</p>
								<select name="sharedCar" class="form-control">
									<option value="0">無</option>
									<option value="1">有</option>
								</select>
							</div>

							<div class="form-group">
								<p>可載寵物</p>
								<select name="pet" class="form-control">
									<option value="0">無法</option>
									<option value="1">接受</option>
								</select>
							</div>

							<div class="form-group">
								<p>抽菸</p>
								<select name="smoke" class="form-control">
									<option value="0">無</option>
									<option value="1">有</option>
								</select>
							</div>

							<div class="form-group">
								<p>提供嬰兒座椅</p>
								<select name="babySeat" class="form-control">
									<option value="0">無</option>
									<option value="1">有</option>
								</select>
							</div>

							<div class="text-center">
								<input type="hidden" name="action" value="INSERT">
								<button type="submit" class="btn btn-dark">成為司機</button>
							</div>

							<!--隱藏的參數action讓controller抓-->

						</form>
					</div>
				</div>
			</div>
			<!-- row結尾 -->
		</div>
	</section>
	<!-- #contact -->
	<!--==========================
    底部
  ============================-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<!-- JavaScript Libraries -->
	<script src="lib/jquery/jquery.min.js"></script>
	<script src="lib/jquery/jquery-migrate.min.js"></script>
	<script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8HeI8o-c1NppZA-92oYlXakhDPYR7XMY"></script>

	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/counterup/counterup.min.js"></script>
	<script src="lib/superfish/hoverIntent.js"></script>
	<script src="lib/superfish/superfish.min.js"></script>

	<!-- Contact Form JavaScript File 
  <script src="contactform/contactform.js"></script> -->

	<!-- Template Main Javascript File  -->
	<script src="js/main.js"></script>

</body>
</html>