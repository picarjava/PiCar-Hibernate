package com.storeRecord.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activityToken.model.ActivityTokenService;
import com.activityToken.model.ActivityTokenVO;
import com.member.model.*;
import com.paymentRecord.model.PaymentRecordDAO;
import com.paymentRecord.model.PaymentRecordService;
import com.paymentRecord.model.PaymentRecordVO;
import com.rate.model.RateDAO;
import com.rate.model.RateService;
import com.rate.model.RateVO;
import com.storeRecord.model.StoreRecordDAO;
import com.storeRecord.model.StoreRecordService;
import com.storeRecord.model.StoreRecordVO;
import com.util.Checkout;
import com.util.CountToken;
import com.util.CountToken1;

/**
 * Servlet implementation class StroeRecordServlet
 */

public class StoreRecordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String storeRecordID = req.getParameter("storeRecordID");
				if (storeRecordID == null || (storeRecordID.trim()).length() == 0) {
					errorMsgs.add("請輸入資費編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/paymentRecord/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				StoreRecordService srSvc = new StoreRecordService();
				StoreRecordVO storeRecordVO = srSvc.getOneStoreRecord(storeRecordID);
				if (storeRecordVO == null) {
					errorMsgs.add("無此撥款紀錄編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/storeRecord/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("storeRecordVO", storeRecordVO);
				RequestDispatcher succesView = req.getRequestDispatcher("/storeRecord/listOneStoreRecord.jsp");
				succesView.forward(req, res);

			} catch (RuntimeException e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/storeRecord/selec_page.jsp");
				failureView.forward(req, res);
			}
		}

		// 查詢會員個人的紀錄
		if ("getOne_For_Display_Mem".equals(action)) {
			List<String> errorMsgs = new LinkedList();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String memID = req.getParameter("memID").trim();

				StoreRecordService srSvc = new StoreRecordService();
				List<StoreRecordVO> list = srSvc.getMemStoreRecord(memID);
				if (list.isEmpty()) {
					errorMsgs.add("無此撥款紀錄編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/storeRecord/select_page.jsp");
					failureView.forward(req, res);
					return;
				}

				req.setAttribute("list", list);

				// 為了拿到加總金額
//				StoreRecordService storeRecordSvc = new StoreRecordService();
//				Integer sumCount = storeRecordSvc.getCount(memID);
//				req.setAttribute("sumCount", sumCount);

				RequestDispatcher succesView = req
						.getRequestDispatcher("/storeRecord/listOneStoreRecordMemberBack.jsp");
				succesView.forward(req, res);

			} catch (RuntimeException e) {
				errorMsgs.add("無法取得資料" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/storeRecord/selec_page.jsp");
				failureView.forward(req, res);
			}
		}

//		---儲值紀錄不修改--

//		if ("getOne_For_Update".equals(action)) {
//			List<String> errorMsgs = new LinkedList();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				Integer rateID = new Integer(req.getParameter("rateID"));
//				RateService rateSvc = new RateService();
//				RateVO rateVO = rateSvc.getOneRate(rateID);
//				req.setAttribute("rateVO", rateVO);
//
//				RequestDispatcher succesView = req.getRequestDispatcher("/rate/update_rate_iuput.jsp");
//				succesView.forward(req, res);
//
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/rate/listAllrate.jsp");
//				failureView.forward(req, res);
//			}
//
//		}

//		if ("update".equals(action)) {
//
//			List<String> errorMsgs = new LinkedList();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				Integer rateID = new Integer(req.getParameter("rateID").trim());
//
//				String rateName = req.getParameter("rateName").trim();
//				String nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
//				if (rateName == null || rateName.trim().length() == 0) {
//
//					errorMsgs.add("請輸入費率名稱");
//				} else if (!rateName.trim().matches(nameReg)) {
//
//					errorMsgs.add("會員姓名請輸入 中文、英文字母、數字和   \" , \" 且長度必需在2到20之間");
//				}
//
//				Double ratePrice = null;
//				try {
//					ratePrice = new Double(req.getParameter("ratePrice").trim());
//					if (ratePrice == 0) {
//						errorMsgs.add("請輸入數字");
//					}
//				} catch (Exception e) {
//					ratePrice = 0.0;
//					errorMsgs.add("請輸入數字，可至小數點第一位");
//				}
//
//				Integer rateBasic = null;
//				try {
//					rateBasic = new Integer(req.getParameter("rateBasic").trim());
//				} catch (Exception e) {
//					rateBasic = 0;
//					errorMsgs.add("請輸入數字");
//				}
//
//				RateVO rateVO = new RateVO();
//				rateVO.setRateID(rateID);
//				rateVO.setRateName(rateName);
//				rateVO.setRatePrice(ratePrice);
//				rateVO.setRateBasic(rateBasic);
//
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("rateVO", rateVO);
//					RequestDispatcher failView = req.getRequestDispatcher("/rate/update_rate_iuput.jsp");
//					failView.forward(req, res);
//					return;
//				}
//
//				// 開始新增資料
//				RateService rateSvc = new RateService();
//				rateVO = rateSvc.updateRate(rateID, rateName, ratePrice, rateBasic);
//
//				RequestDispatcher succesView = req.getRequestDispatcher("/rate/listAllRate.jsp");
//				succesView.forward(req, res);
//
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要新增的資料：" + e.getMessage());
//				RequestDispatcher successView = req.getRequestDispatcher("/rate/update_rate_iuput.jsp");
//				successView.forward(req, res);
//			}
//
//		}
//

		// 從自己addStoreRecord.jsp來的請求
		if ("insert".equals(action)) {

			// 司機編號作下拉式選單
			List<String> errorMsgs = new LinkedList();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String memID = req.getParameter("memID").trim();
				String nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (memID == null || memID.trim().length() == 0) {

					errorMsgs.add("請輸入會員ID");
				} else if (!memID.trim().matches(nameReg)) {

					errorMsgs.add("會員姓名請輸入 中文、英文字母、數字和   \" , \" 且長度必需在2到20之間");
				}

				Integer amount = null;
				try {
					amount = new Integer(req.getParameter("amount").trim());

				} catch (Exception e) {
					amount = 0;
					errorMsgs.add("請點選金額");
				}

				StoreRecordVO storeRecordVO = new StoreRecordVO();
				storeRecordVO.setMemID(memID);
				storeRecordVO.setAmount(amount);
				// 以上VO是為了錯誤時，原輸入資料保留

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("storeRecordVO", storeRecordVO);
					RequestDispatcher failView = req.getRequestDispatcher("/front-end/storeRecord/addStoreRecord.jsp");
					failView.forward(req, res);
					return;
				}

				// 開始新增資料
				StoreRecordService storeRecordSvc = new StoreRecordService();
				storeRecordVO = storeRecordSvc.addStoreRecord(memID, amount);
				req.setAttribute("storeRecordVO", storeRecordVO);

				// 為了拿名子
				List<StoreRecordVO> list = storeRecordSvc.getMemStoreRecord(memID);
				req.setAttribute("list", list);

				// 為了計算加總金額 用取得會員代幣替代
//				Integer sumCount = storeRecordSvc.getCount(memID);
//				req.setAttribute("sumCount", sumCount);

				MemberService memberSvc = new MemberService();
				MemberVO memberVO1 = memberSvc.getOneMember(memID);
				memberSvc.updateToken(memID, memberVO1.getToken() + storeRecordVO.getAmount());
				MemberVO memberVO = memberSvc.getOneMember(memID);
				req.setAttribute("memberVO", memberVO);
				System.out.println("已經插入");

				
				
				RequestDispatcher succesView = req
						.getRequestDispatcher("/front-end/member/listOneMemberByUpdate.jsp");
				succesView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得要新增的資料：" + e.getMessage());
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/storeRecord/addStoreRecord.jsp");
				successView.forward(req, res);
			}

		}

		// 從Front-end/Member/listOneMember.jsp來的請求
		if ("addToken".equals(action)) {

			String memID = req.getParameter("memID");
			StoreRecordVO storeRecordVO = new StoreRecordVO();
			storeRecordVO.setMemID(memID);

			req.setAttribute("storeRecordVO", storeRecordVO);
			RequestDispatcher successView = req.getRequestDispatcher("/front-end/storeRecord/addStoreRecord.jsp");
			successView.forward(req, res);
		}

//		--儲值紀錄不刪除--
//		if ("delete".equals(action)) { // 來自listAllEmp.jsp
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 ***************************************/
//				Integer rateID = new Integer(req.getParameter("rateID").trim());
//
//				/*************************** 2.開始刪除資料 ***************************************/
//				RateService rateSvc = new RateService();
//				rateSvc.deleteRate(rateID);
//				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//				RequestDispatcher successView = req.getRequestDispatcher("listAllRate.jsp");// 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add("刪除資料失敗:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("listAllRate.jsp");
//				failureView.forward(req, res);
//			}
//		}

		if ("insertOrder".equals(action)) {

			List<String> errorMsgs = new LinkedList();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String memID = req.getParameter("memID").trim();
				String nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (memID == null || memID.trim().length() == 0) {

					errorMsgs.add("請輸入司機ID");
				} else if (!memID.trim().matches(nameReg)) {

					errorMsgs.add("會員姓名請輸入 中文、英文字母、數字和   \" , \" 且長度必需在2到20之間");
				}

				Integer amount = 0;
				try {
					amount = Integer.valueOf(req.getParameter("amount")); // 扣除金額為負值

				} catch (Exception e) {
					amount = 0;
					errorMsgs.add("請點選金額");
				}

				String orderID = null;
				try {
					orderID = req.getParameter("orderID").trim();

				} catch (Exception e) {
					orderID = null;
					errorMsgs.add("請新增訂單ID");
				}
				
				
				
				

				ActivityTokenService atSvc = new ActivityTokenService();
				List<ActivityTokenVO> onesActivityToken = new LinkedList();
				onesActivityToken = atSvc.getOnesALL(memID);
				Collections.sort(onesActivityToken, new Comparator<ActivityTokenVO>() {

					@Override
					public int compare(ActivityTokenVO o1, ActivityTokenVO o2) {
						int result = (int) (o1.getDeadline().getTime() - o2.getDeadline().getTime());
						return result;
					}

				});
				
				Collections.sort(onesActivityToken, new Comparator<ActivityTokenVO>() {

					@Override
					public int compare(ActivityTokenVO o1, ActivityTokenVO o2) {
						int result = (int) -((o1.getTokenAmount() - o2.getTokenAmount()));
						return result;
					}

				});

				String memberIDNewest = null;
				String activityIDNewest = null;
				if (!onesActivityToken.isEmpty()) {
					if (onesActivityToken.get(0).getTokenAmount() != 0) {
						amount = -(amount - onesActivityToken.get(0).getTokenAmount());
						// 將第一筆資料歸零OR刪除?
						memberIDNewest = onesActivityToken.get(0).getMemID();
						activityIDNewest = onesActivityToken.get(0).getActivityID();
//						atSvc.cancelToken(memberIDNewest, activityIDNewest);

					} else {
						amount = -amount;
					}
				}

				StoreRecordVO storeRecordVO = new StoreRecordVO();
//				storeRecordVO.setMemID(memID);
//				storeRecordVO.setAmount(amount);
//				storeRecordVO.setOrderID(orderID);
				// 以上VO是為了錯誤時，原輸入資料保留

//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("storeRecordVO", storeRecordVO);
//					RequestDispatcher failView = req.getRequestDispatcher("/front-end/storeRecord/addStoreRecord.jsp");
//					failView.forward(req, res);
//					return;
//				}

				MemberService memberSvc = new MemberService();
				MemberVO memberVO = memberSvc.getOneMember(memID);
				Integer count = memberVO.getToken() + amount;
				try {
					if (count < 0) {
						throw new Exception("總金額小於0");
						
					}
				} catch (Exception e) {
					System.out.println(e);
					return;
				}
				// 開始新增資料
				atSvc.cancelToken(memberIDNewest, activityIDNewest);
				StoreRecordService storeRecordSvc = new StoreRecordService();
				storeRecordVO = storeRecordSvc.addOrdrID(memID, amount, orderID);
				req.setAttribute("storeRecordVO", storeRecordVO);

				// 為了拿名子
				List<StoreRecordVO> list = storeRecordSvc.getMemStoreRecord(memID);
				req.setAttribute("list", list);

				// 為了計算加總金額 用取得會員代幣替代
//				Integer sumCount = storeRecordSvc.getCount(memID);
//				req.setAttribute("sumCount", sumCount);
				System.out.println(memID);
				System.out.println(count);
				memberSvc.updateToken(memID, count);
				RequestDispatcher succesView = req
						.getRequestDispatcher("/front-end/storeRecord/listOneStoreRecordByMem.jsp");
				succesView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("無法取得要新增的資料：" + e.getMessage());
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/storeRecord/addStoreRecord.jsp");
				successView.forward(req, res);
			}

		}

		
		if ("insertOrder1".equals(action)) {
			String memID = req.getParameter("memID").trim();
					
			Integer amount = Integer.valueOf(req.getParameter("amount")); // 扣除金額為負值
			String orderID = req.getParameter("orderID").trim();
			Integer i = Integer.valueOf(req.getParameter("count"));
			MemberService memberSvc = new MemberService();
			CountToken1 ct1 = new CountToken1();
			try {
				ct1.countToken(memID, amount, orderID, i);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			

		}
	}

}
