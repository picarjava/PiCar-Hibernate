<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>select_page.jsp</title>
<style>
#errmsg{
	width:200px;
	height:100px;
	color:red;
}
</style>

</head>
<body bgcolor="#c1ece9">
<h3>select_page.jsp</h3>
	<div id="errmsg">
	<c:if test="${not empty errorMsgs}">
	<ul>	
		<c:forEach var="message" items="${errorMsgs}">
			<li>
				${message}
			</li>
		</c:forEach>	
	</ul>
	</c:if>
	</div>

	<ul>
		<li><a href="listAllRate.jsp" >點選顯示全部費率</a>  <font color="blue" face="DFKai-sb">All members by DAO</font> <br><br>
	
				
		<li>
			<form method="post" action="rate.do">
				<b>請輸入費率編號(EX:M001) (資料格式驗證  by Controller ):</b><br> 
				<input type="text" name="rateID">
				<input type="hidden" name="action" value="getOne_For_Display"><br>
				<input type="submit" value="submit"> 
			</form> 
		</li>	
		<br>
		
		<% /*<li>
			<form method="post" action="member.do">
				<b>請輸入會員編號(EX:M001) (資料格式驗證  by Java Script):</b><br> 
				<input type="text" name="memID">
				<input type="hidden" name="action" value="getOne_For_Display"><br>
				<input type="button" value="submit" onlick="fun1()">  
			</form> 
		</li>*/	%>
		
		
			<jsp:useBean id="ratedao" scope="page" class="com.rate.model.RateDAO" />
		
		<br><br>
		<li>
			<form method="post" action="rate.do">
				<b>請選擇費率編號</b> <br>
				<select size="1" name="rateID">
					<c:forEach var="rateVO" items="${ratedao.all}">
						<option value="${rateVO.rateID}">${rateVO.rateID}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="getOne_For_Display"><br>
				<input type="submit" value="submit">
			</form>
		</li>
		<br>
		<li>
			<form method="post" action="rate.do">
				<b>請選擇費率名稱</b><br>
				<select size="1" name="rateID">
					<c:forEach var="rateVO" items="${ratedao.all}">
						<option value="${rateVO.rateID}">"${rateVO.rateName}" 					
					</c:forEach>
				</select>
				<br>	
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="submit">			
			</form>
			
		</li>
	</ul>
	<ul>
		<li>	
		<a href="addRate.jsp">點選新增員工資料</a>
		</li>
	</ul>
	
	
	
	

<script>    
   function fun1(){
      with(document.form1){
         if (memID.value=="") 
             alert("請輸入員工編號!");
         else if (isNaN(memID.value)) 
             alert("員工編號格式不正確!");
      
         else
             submit();
      }
   }
</script>

</body>
</html>