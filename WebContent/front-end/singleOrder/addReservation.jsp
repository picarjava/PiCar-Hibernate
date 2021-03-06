<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.singleOrder.model.SingleOrderVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.util.Checkout" %>
<!DOCTYPE html>
<html lang="zh">
<head>
<jsp:include page="/front-end/HomeMember/HeadMember.jsp"/>
<jsp:include page="/front-end/HomeMember/HeadMemberReservatoin.jsp"/>

 
    <title>預約叫車</title>
   
 
<style>
	#map { 
         height: 500px;  
         width: 1200px;
        
      } 
        #origin-input, 
       #destination-input { 
         background-color: #fff; 
         font-family: Roboto;  
         font-size: 18px; 
         font-weight: 400; 
         margin-left: 15px; 
         padding: 1 11px 1 13px; 
         text-overflow: ellipsis; 
         width: 400px; 
       } 
      .form-row {
		    display: inline-block;    /* 如需支持IE8以下版本，用浮动来做 */
		}
		
		h1, h2, h3, h4, h5, h6 {
		    margin: 10px 0;
		    font-family: inherit;
		    font-weight: bold;
		    line-height: 20px;
		    color: black;
		    text-rendering: optimizelegibility;
		}
		</style>
</head>

<!-- 登入功能串接 ，將VOmemID指定給 memID-->
<%@ page import="com.member.model.MemberVO"%>
<%MemberVO memberVO=(MemberVO)session.getAttribute("memberVO");
String memID=memberVO.getMemID();
session.setAttribute("memID",memID);
%> 
<jsp:useBean id="checkout" class="com.util.Checkout"> </jsp:useBean>


<body>

 <!-- 錯誤列表 -->
    <%
        List<String> errorMsgs=(List<String>)request.getAttribute("errorMsgs");
    %>
    <c:if test="${not empty errorMsgs}"><ul class="list-group">
		  <li class="list-group-item active">Opps!錯誤訊息回報</li>
		  <c:forEach var="massage" items="${errorMsgs}">
		  <li class="list-group-item">${massage}</li>
		  </c:forEach>
		</ul>
	</c:if>

  <!--==========================
      預約叫車
    ============================-->
    <section id="contact">
      <div class="container wow fadeInUp">
        <div class="section-header">
          <h3 class="section-title">單程預約</h3>
          <h4 class="section-description">單程叫車需於三日前預約</h4>
        </div>
      </div>

      <div class="container wow fadeInUp">
        <div class="row justify-content-center">
          <div class="col-lg-1 col-md-4">
            <div class="info">
            </div>
          </div>
          
          <div class="col-lg-9 col-md-8">
            <div class="form">
              <!-- 新增活動表單開始 -->
              <form action="<%=application.getContextPath()%>/singleOrder" method="post" role="form" class="contactForm" name="form1">
 					<div class="form-group">
	                   <h3>會員${memID} ${memberVO.name} 您好!  歡迎預約叫車</h3>
	                  <input type="hidden" type="text" name="memID" class="form-control"  readonly value="${memID}"   placeholder="請輸入會員編號" />
	       			</div>
		       		<div  class="form-row">
		       			<div class="span">
						<p id="distance"></p>
						</div>
						<div class="span">
		       			<p id="duration"></p>
		       			</div>
		       			<div class="span" >
		       			<p id="checkout"></p>
		       			</div>
	       			</div>
	       			<div class="form-row">
	       			    <div class="span">
		       			<p id="calculate"></p>
		       			</div>
		       		</div>	
		       		<div>
		       		<img src="<%=application.getContextPath()%>/front-end/login/PIC/M006.png"	height="45" width="45" onClick="idwrite1(this)">
		       		</div>
 					<div class="form-row">
                      <div class="col">
                        <p>上車地點/下車地點</p> 
                        <input id="origin-input" type="text" name="startLoc" value="${singleOrder.startLoc}" class="form-control" placeholder="請輸入上車地點">
                      </div>
                      <div class="col">
                        <input id="destination-input" type="text" name="endLoc" value="${singleOrder.endLoc}" class="form-control" placeholder="請輸入下車地點">
                      </div>
                      <div  id="map" class="col12">
                     </div>
                    </div>
                   
                   
                      <!--==========================
                    google地圖開始
                    ============================-->
                     
                      
                    
<!-- 					    <iframe  -->
<!-- 					      width="600"  -->
<!-- 					      height="450"  -->
<!-- 					      frameborder="0"  -->
<!-- 					      style="border:0"  -->
<!-- 					      src="https://www.google.com/maps/embed/v1/directions?key=AIzaSyCWL8JxUOY0dQZ01M4rCgDU-oHLkP5BORI&origin=中央大學&destination=台北小巨蛋" -->
<!-- 					      allowfullscreen> -->
<!-- 					  </iframe> -->
                 <!--==========================
                     google地圖結束
                    ============================-->
<!--                 <div class="alert alert-light"> -->
<!--                   <p>上車時間</p> -->
<%--                   <input type="text" id="f_date1" name="startTime"  value="${singleOrder.startTime}"/> --%>
                  
<!--                 </div> -->
                <!-- 單次叫車+按鈕 -->
                <div class="alert alert-light">
	               <p>上車時間</p>
	               <div class="input-group mb-3">
					  <input type="text" id="f_date1" name="startTime"  value="${singleOrder.startTime}" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
					  
					</div>
				</div>
                <div class="form-group">
	            <p>備註</p>
	            <textarea class="form-control" name="note"  placeholder="請輸入備註">${singleOrder.note}</textarea>
	            </div>
                <div class="text-center"><button type="submit" id="submitAutocomplete">送出</button></div>

                <!-- /*放隱藏的標籤，讓Controller抓到參數進行操作*/ -->
                <input type="hidden" name="action" value="insert">
                <input type="hidden" name="orderType" value="3">
                <input type="hidden" id="startLng" name="startLng" value="">
                <input type="hidden" id="startLat" name="startLat" value="">
                <input type="hidden" id="endLng" name="endLng" value="">
                <input type="hidden" id="endLat" name="endLat" value="">
                <input type="hidden" id="totalAmount" name="totalAmount" value="">
                <!-- 訂單種類:預約叫車3/長期預約叫車4-->
              </form>
              
            </div>
          </div>
        </div>

      </div>
    </section><!-- #contact -->
</body>

<!-- auto place complete 開始 -->
 <script>
function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    mapTypeControl: false,
    center: {lat: 23.914626, lng: 121.060895},
    zoom: 7.5
  });

  new AutocompleteDirectionsHandler(map);
  
}

/**
 * @constructor
 */
function AutocompleteDirectionsHandler(map) {
  this.map = map;
  this.originPlaceId = null;
  this.destinationPlaceId = null;
  this.travelMode = 'DRIVING';
  this.directionsService = new google.maps.DirectionsService;
  this.directionsDisplay = new google.maps.DirectionsRenderer;
  this.directionsDisplay.setMap(map);

  var originInput = document.getElementById('origin-input');
  var destinationInput = document.getElementById('destination-input');


  var originAutocomplete = new google.maps.places.Autocomplete(originInput);
  // Specify just the place data fields that you need.
  originAutocomplete.setFields(['place_id']);

  var destinationAutocomplete =
      new google.maps.places.Autocomplete(destinationInput);
  // Specify just the place data fields that you need.
  destinationAutocomplete.setFields(['place_id']);
  
 

  this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
  this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');

  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(
      destinationInput);
}

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(
    autocomplete,mode) {
  var me = this;
  autocomplete.bindTo('bounds', this.map);

  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
	    if (!place.place_id) {
	      window.alert('Please select an option from the dropdown list.');
	      return;
	    }
	    if (mode === 'ORIG') {
	      me.originPlaceId = place.place_id;
	    } else {
	      me.destinationPlaceId = place.place_id;
	    }
    me.route();
  });
};

AutocompleteDirectionsHandler.prototype.route = function() {
  if (!this.originPlaceId || !this.destinationPlaceId) {
    return;
  }
  
  var me = this;

  this.directionsService.route(
      {
        origin: {'placeId': this.originPlaceId},
        destination: {'placeId': this.destinationPlaceId},
        travelMode: this.travelMode
      },
      function(response, status) {
    	  
    	  if (status === 'OK') {
          me.directionsDisplay.setDirections(response);
          //呈現預估時間與距離
          var distance =response.routes[0].legs[0].distance.value;
    	  var duration=response.routes[0].legs[0].duration.value;
    	 
    	  var totalAmount =document.getElementById('totalAmount');
    	  totalAmount.value=parseInt((distance/1000*24.5)+40);
    	  
    	  document.getElementById('distance').innerHTML = 
             "<h3>預估距離</h3><h4>"+ parseInt(distance/1000) + "公里"+distance%1000+"公尺</h4>" ;
    	  document.getElementById('duration').innerHTML = 
              "<h3>預估時間</h3><h4>"+parseInt(duration/60/60)+"時"+parseInt(duration/60%60) + "分</h4>";
          document.getElementById('checkout').innerHTML = 
        	  "<h3>總金額</h3><h4>$"+ totalAmount.value +"元</h4>";
          document.getElementById('calculate').innerHTML = 
        	  "<h6>"+parseInt(distance/1000) + "公里"+distance%1000+"公尺 X 24.5 元/每公里資費 + 40元 基本費/每趟 ="+ totalAmount.value +"元</h6>";
           
    	  } else {
          window.alert('Directions request failed due to ' + status);
        }
      });
		  //將地址資料轉為緯經度
		var startLngInput = document.getElementById('startLng');
		var startLatInput = document.getElementById('startLat');
		var endLngInput = document.getElementById('endLng');
		var endLatInput = document.getElementById('endLat');
		  
		  
		  var geocoder = new google.maps.Geocoder();
		  geocoder.geocode({'placeId':this.originPlaceId},function(results,status){
			  
			  if (status === 'OK') {
		  			  startLatInput.value =results[0].geometry.location.lat();//得到起點緯經度資料Object
		  			  startLngInput.value=results[0].geometry.location.lng();
		  	  }else{
		  		  window.alert('No results found');
		  	  }
		  });
		  
		  geocoder.geocode({'placeId':this.destinationPlaceId},function(results,status){
			  
			  if (status === 'OK') {
		  			  endLatInput.value=results[0].geometry.location.lat();//得到迄點緯經度資料Object
		  			  endLngInput.value=results[0].geometry.location.lng();
		  	  }else{
		  		  window.alert('No results found');
		  	  }
		  });
};


    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWL8JxUOY0dQZ01M4rCgDU-oHLkP5BORI&libraries=places&callback=initMap"
        async defer></script>
<!-- auto complete結束 -->



				<!-- 新增日期HTML -->
<!-- 		                <div class="alert alert-light alert-dismissible fade show" role="alert"> -->
<!-- 						  <strong></strong>  -->
<!-- 						  <p>上車時間</p> -->
<!-- 			               <div class="input-group mb-3"> -->
<%-- 							  <input type="text" id="f_date1" name="startTime"  value="${singleOrder.startTime}" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2"> --%>
<!-- 							  <div class="input-group-append"> -->
<!-- 							    <button class="btn btn-outline-secondary" type="button" id="button-addon2">新增其他日期</button> -->
<!-- 							  </div> -->
<!-- 							</div> -->
<!-- 						  <button type="button" class="close" data-dismiss="alert" aria-label="Close"> -->
<!-- 						    <span aria-hidden="true">&times;</span> -->
<!-- 						  </button> -->
<!-- 						</div> -->
			    <!-- 新增日期結束 -->



 <!-- datetimepicker -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
<script>
//得到未來n天的Date
function getFutureDate(addDays) {
	var futureDate=new Date()
	futureDate.setDate(futureDate.getDate()+addDays);
	return futureDate;
	}
	
var minDate=getFutureDate(3);//須於三天前預約
var maxDate=getFutureDate(16); //僅能下定未來三天後的14天

        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
           timepicker:true,       //timepicker:true,
           step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
           format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
      	   value:  minDate,        // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate: '',            '2017/07/10',  // 起始日
           minDate:   minDate,            //'-1970-01-01', // 去除今日(不含)之前
           maxDate:   maxDate         //  '+1970-01-01'  // 去除今日(不含)之後
        });
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        var somedate1 = minDate;    //new Date();
        $('#f_date1').datetimepicker({
            beforeShowDay: function(date) {
               if (date.getYear() <  somedate1.getYear())
            	   return [false, ""];
               else if (date.getYear() == somedate1.getYear())
            	   if (date.getMonth() <  somedate1.getMonth())
            		   return [false, ""];
                   else if (date.getMonth() == somedate1.getMonth())
            		   if (date.getHours() < somedate1.getHours())
            			   return [false, ""];
            		   else if (date.getHours() == somedate1.getHours())
            			   if (date.getMinutes() < somedate1.getMinutes())
            				   return [false, ""];
               
            if (date.getYear() <  somedate1.getYear() || 
               (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
               (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())) {
                return [false, ""];
            }
            
            return [true, ""];
        }});

        
        //      2.以下為某一天之後的日期無法選擇
             var somedate2 = maxDate;    //new Date('2017-06-15');
             $('#f_date1').datetimepicker({
                 beforeShowDay: function(date) {
                   if (  date.getYear() >  somedate2.getYear() || 
                        (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
                        (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //            if (  date.getYear() <  somedate1.getYear() || 
        //                 (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //                 (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //                   ||
        //                  date.getYear() >  somedate2.getYear() || 
        //                 (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //                 (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
        //神奇小按鈕
        function idwrite1() {
		form1.startLoc.value = "tibame";
		form1.endLoc.value = "台北101";
	     }
        
</script>

</html>
