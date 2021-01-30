package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BrokerDao;
import houseSemi.beans.BrokerDto;
import houseSemi.beans.MemberDao;
import houseSemi.beans.MemberDto;

@WebServlet(urlPatterns ="/member/join_broker.do")
public class BrokerJoinServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		
		//한글 요청
		req.setCharacterEncoding("UTF-8");
		
		
		
		//MemberDao 내의 getSequence 메소드 호출
		MemberDto dto = new MemberDto();
		MemberDao dao = new MemberDao();
		BrokerDto brokerDto = new BrokerDto();
		BrokerDao brokerDao = new BrokerDao();
		int member_no = dao.getSequence();
		int broker_no = brokerDao.getSequence();
		
		
		dto.setMember_no(member_no);
		dto.setMember_id(req.getParameter("member_id"));
		dto.setMember_pw(req.getParameter("member_pw"));
		dto.setMember_nick(req.getParameter("member_nick"));
		dto.setMember_email(req.getParameter("member_email"));
		dto.setMember_phone(req.getParameter("member_phone"));
		dto.setMember_auth(req.getParameter("member_auth"));
		brokerDto.setBroker_name(req.getParameter("broker_name"));
		brokerDto.setBroker_address(req.getParameter("broker_address"));
		brokerDto.setBroker_address2(req.getParameter("broker_address2"));
		brokerDto.setBroker_landline(req.getParameter("broker_landline"));
		brokerDto.setMember_no(member_no);
		brokerDto.setBroker_no(broker_no); //시퀀스만들기
		dao.insert(dto);
		brokerDao.insert(brokerDto);
		
		
		
		
		//결과
		resp.sendRedirect("join_success.jsp");
	
	
	
	
	}
	//예외처리
	catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
