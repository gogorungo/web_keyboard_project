package model.memberService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.order.OrderDAO;
import test.HttpConnectionUtil;
import test.SHA_512_Util;

public class MemberOrdering implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String orderNum = request.getParameter("orderNum");
		String res = request.getParameter("res");

		String msg = null;
		String goUrl = "Order";
		if (new OrderDAO().requestOrder(orderNum, res)) {
			if (res.equals("주문취소확인")) {
				msg = "주문이 취소되었습니다.";
				Cancel(orderNum);
				new OrderDAO().requestRefund(orderNum);
			} else if (res.equals("주문취소요청")) {
				msg = "주문 취소가 요청되었습니다.";
			} else if (res.equals("반품요청")) {
				msg = "반품이 요청되었습니다";
			} else if (res.equals("교환요청")) {
				msg = "교환이 요청되었습니다";
			}
		} else {
			msg = "처리 실패";
		}

		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./member_view/memberAlert");
	}

	public void Cancel(String orderNum) {
		Date date_now = new Date(System.currentTimeMillis()); // 현재시간을 가져와 Date형으로 저장한다//년월일시분초 14자리 포멧
		SimpleDateFormat fourteen_format = new SimpleDateFormat("yyyyMMddHHmmss");

		// step1. 요청을 위한 파라미터 설정

		String Key = "ItEQKi3rY7uvDS8l"; // INIpayTest 의 INIAPI key
		String type = "Refund";
		String paymethod = "Card";
		String timestamp = fourteen_format.format(date_now);
		String clientIp = "192.0.0.1";
		String mid = "INIpayTest";
		String tid = orderNum; // 40byte 승인 TID 입력
		String msg = "거래취소요청";

		// Hash 암호화
		String data_hash = Key + type + paymethod + timestamp + clientIp + mid + tid;
		SHA_512_Util SHA_512 = new SHA_512_Util();
		String hashData = SHA_512.getSHA512(data_hash);// SHA_512_Util 을 이용하여 hash암호화(해당 LIB는 직접구현 필요)

		// 전송 URL
		String APIURL = "https://iniapi.inicis.com/api/v1/refund"; // 전송 URL

		HashMap<String, String> CashReceiptsMap = new HashMap<String, String>();

		CashReceiptsMap.put("type", type);
		CashReceiptsMap.put("paymethod", paymethod);
		CashReceiptsMap.put("timestamp", timestamp);
		CashReceiptsMap.put("clientIp", clientIp);
		CashReceiptsMap.put("mid", mid);
		CashReceiptsMap.put("tid", tid);
		CashReceiptsMap.put("msg", msg);
		CashReceiptsMap.put("hashData", hashData);

		// step2. key=value 로 post 요청

		HttpConnectionUtil httpUtil = new HttpConnectionUtil();

		try {
			String authResultString = "";
			authResultString = httpUtil.postRequest2(APIURL, CashReceiptsMap);
			System.out.println(authResultString);
		} catch (Exception ex) {
			System.out.println(ex);

		}
	}

}