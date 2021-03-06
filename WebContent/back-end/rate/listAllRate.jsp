<%@ page language="java" contentType="text/html; chartset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rate.model.*" import="java.util.List"
	import="java.io.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/back-end/head_back.jsp" />
<meta charset="UTF-8">
<title>全部費率</title>
<jsp:include page="/back-end/btnCss.jsp" />

</head>
<style>
th{
	font-family: 'Microsoft JhengHei', 'Fira Code', 'Source Code Pro', 'Noto Sans CJK SC', monospace;
		
}
</style>
<body>
<div class="wrapper ">
<jsp:include page="/back-end/kidBodyLeft.jsp" />
	<%
		RateService rateSvc = new RateService();
		List<RateVO> list = rateSvc.getAll();
		pageContext.setAttribute("list", list);
	%>
	<jsp:include page="/back-end/kidBodyLeft.jsp" />
	<div class="main-panel">
	<div class="content">
<!-- 	<a href="select_page.jsp">回主畫面</a> -->

		<table border="1" id="table1">

			<tr>
				<th>費率ID</th>
				<th>費率名稱</th>
				<th>費率(NTDS/KM)</th>
				<th>基本費率(NTDS)</th>
<!-- 				<td>修改</td> -->
<!-- 				<td>刪除</td> -->
			</tr>
	
	<c:forEach var="rateVO" items="${list}">
	

			<tr>
				<td>${rateVO.rateID}</td>
				<td>${rateVO.rateName}</td>
				<td>${rateVO.ratePrice}</td>
				<td>${rateVO.rateBasic}</td>


<!-- 				<td> -->
<%-- 					<form method="post"	action="<%=request.getContextPath()%>/back-end/rate/rate.do"> --%>
<!-- 						<input type="submit" value="修改">  -->
<%-- 						<input type="hidden" name="rateID" value="${rateVO.rateID}">  --%>
<!-- 						<input type="hidden" name="action" value="getOne_For_Update"> -->
				
<!-- 				    </form> -->
<!-- 				 </td> -->
				</tr>
<!-- 				<td> -->
<%-- 					<form method="post" action="<%=request.getContextPath()%>/back-end/rate/rate.do"> --%>
<!-- 						<input type="submit" value="刪除"> -->
<%-- 						 <input type="hidden" name="rateID" value="${rateVO.rateID}">  --%>
<!-- 						 <input type="hidden" name="action" value="delete"> -->
<!-- 					</form> -->

<!-- 				</td> -->
		

	</c:forEach>
	</table>
</div>
</div>
</div>
<jsp:include page="/back-end/kidFooter.jsp" />
</body>
</html>