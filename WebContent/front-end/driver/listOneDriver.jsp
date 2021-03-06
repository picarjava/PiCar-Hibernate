<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.driver.model.*" %>
<%@ page import="com.member.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*"%>
<html>
<head>
  <title>司機資料管理</title>

<%-- <jsp:include page="/regna-master/head.jsp" /> --%>
<jsp:include page="/front-end/HomeDriver/Header.jsp" />  
</head>

<body>
    <!--==========================
      Contact Section
    ============================-->
    
<!--       DriverVO driverVO=(DriverVO)request.getAttribute("driverVO"); -->
<!-- DriverVO driverVO  = driSrc.getOneDriverBymemID(memberVO.getMemID()); -->
    
    <!-- 先取出VO -->
<%--     <% String driverID = "D012" ;%> --%>
<!-- 登入功能串接 ，將VOmemID指定給 memID-->
  <%
  
MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
  String memID=memberVO.getMemID();
  session.setAttribute("memID",memID);
DriverService driSrc = new DriverService();
DriverVO driverVO  = driSrc.getOneDriverBymemID(memberVO.getMemID());
System.out.print(driverVO);
DriverVO xxx  = driSrc.getfindDriverByMemID(memberVO.getMemID());
session.setAttribute("xxx", xxx);
                    System.out.println(xxx);
                    
      List<DriverVO> list = driSrc.getAll();
//       String lastMem = (list.get(list.size()-1).getMemID());
         String lastDriver = list.get(list.size()-1).getDriverID();
         pageContext.setAttribute("lastDriver", lastDriver);
  %>
    <!-- 錯誤列表 -->
    <%LinkedList errorMsgs=(LinkedList<String>)request.getAttribute("errorMsgs");%>
    <c:if test="${not empty errorMsgs}"><ul class="list-group">
          <li class="list-group-item active">Opps!錯誤訊息回報</li>
          <c:forEach var="massage" items="${errorMsgs}">
          <li class="list-group-item">${massage}</li>
          </c:forEach>
        </ul>
    </c:if>
    <section id="contact">
         <div class="container wow fadeInUp">
            <div class="col-lg-12 col-md-12">
                <div class="section-header">
                  <h3 class="section-title">司機個人資料</h3>
                  <div class="text-center">
                  <form action="homeDriverDataManagment.jsp"><!--設返回頁面 -->
                  <button type="submit" >返回</button>
                  </form>
                  </div>                
                </div>  
            </div>      
         </div>
         <div class="container wow fadeInUp">
            <div class="row justify-content-center">
              <div class="col-lg-12 col-md-12">
                <div class="form">
                  <!-- 司機表單開始 -->
                  <form action="https://www.google.com" method="post" role="form" class="contactForm">
                    <!-- <form action="<%=request.getContextPath()%>/activity/Activ_servlet.html" method="post" role="form" class="contactForm"> -->
                     <div class="form-group">
                      <p>會員編號</p> 
                     <input type="text" name="memID"  readonly  value="${driverVO.memID}" class="form-control"   />
                    </div>
<!--                      <div class="form-group"> --會有交易問題---->
<!--                       <p>司機編號</p>  -->
<%--                      <input type="text" name="driverID"  readonly  value="${driverVO.driverID}" class="form-control"   /> --%>
<!--                     </div> -->
                    <div class="form-group">
                       <p>車牌號碼</p>
                      <input type="text" name="plateNum" class="form-control" value="${driverVO.plateNum}" readonly  placeholder="請輸入車牌號碼" />
                       <div class="card" style="width: 18rem;">
                        </div>
                    </div>
                    <div class="form-group" class="form-control">
                      <p>駕照</p>
                       <div class="card" style="width: 18rem;" >
                          <img src="driver.do?driverID=${lastDriver}&pic=1" width="300" height="150" class="card-img-top" alt="..." >
                        </div>      
                   </div>
                    <div class="form-group">
                      <p>良民證</p>
                       <div class="card" style="width: 18rem;">
                          <img src="driver.do?driverID=${lastDriver}&pic=2" width="300" height="150" class="card-img-top" alt="..." >
                        </div>
                    </div>
                    <div class="form-group">
                      <p>肇事紀錄</p>
                       <div class="card" style="width: 18rem;">
                          <img src="driver.do?driverID=${lastDriver}&pic=3" width="300" height="150" class="card-img-top" alt="..." >
                        </div>
                    </div>
                    <div class="form-group">
                      <p>身分證</p>
                       <div class="card" style="width: 18rem;">
                          <img src="driver.do?driverID=${lastDriver}&pic=4"  width="300" height="150" class="card-img-top" alt="..." >
                        </div>
                    </div>
                    <div class="form-group">
                      <p>會員照片</p>
							<img src="<%=request.getServletContext().getContextPath()%>/front-end/member/member.do?memID=${memberVO.memID}"  width='200' height="200"
		          onerror="this.src='cat.jpg'">
                    </div>
                    <div class="form-group">
                       <p>評價分數</p>
                      <input type="text" name="Score" class="form-control" value="${driverVO.score}"  disabled="disabled"/>
                       <div class="card" style="width: 18rem;">
                        </div>
                    </div>
                    <div class="form-group">
                       <p>車型</p>
                      <input type="text" name="carType" class="form-control" value="${driverVO.carType}"  disabled="disabled" />
                       <div class="card" style="width: 18rem;">
                        </div>
                    </div>
                    <h3>喜好設定</h3>
                            <div class="form-group">
                                <p>願意共乘載客</p>
                                <div class="form-control" style="width: 18rem;">
                                <c:if test="${driverVO.sharedCar == 0}">不接受共享</c:if>
						      	<c:if test="${driverVO.sharedCar == 1}">接受共享</c:if>
						      	</div>
                           </div>

                            <div class="form-group">
                                <p>可載寵物</p>
                                <div class="form-control" style="width: 18rem;">
                                <c:if test="${driverVO.pet == 0}">不要寵物</c:if>
						      	<c:if test="${driverVO.pet == 1}">寵物我可以</c:if>
						      	</div>
                            </div>
                            <div class="form-group">
                                <p>抽菸</p>
                                <div class="form-control" style="width: 18rem;">
                                <c:if test="${driverVO.smoke == 0}">不接受抽菸</c:if>
						      	<c:if test="${driverVO.smoke == 1}">接受抽菸</c:if>
						      	</div>
                            </div>

                            <div class="form-group">
                                <p>提供嬰兒座椅</p>
                                <div class="form-control" style="width: 18rem;">
                                <c:if test="${driverVO.babySeat == 0}">不提供嬰兒座椅</c:if>
						        <c:if test="${driverVO.babySeat == 1}">提供嬰兒座椅</c:if>
						        </div>
                            </div>
						      
                  <!--  <div class="text-center"><button type="submit">確認修改</button></div>  -->
                    <!--隱藏的參數action讓controller抓-->
                    <!-- <input type="hidden" name="action" value="UPTDATE"> -->
                  </form>
                </div>
              </div>
            </div><!-- row結尾 -->
          </div>
    </section><!-- #contact -->
 
<jsp:include page="/regna-master/body.jsp" />
<jsp:include page="/front-end/HomeDriver/Footer.jsp" />
</body>
</html>
