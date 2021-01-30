package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.*;

@WebServlet(urlPatterns ="/member/join_member.do")
public class MemberJoinServlet extends HttpServlet{
 @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 try { //->일어날 예외에 대한 대비
	 	//한글요청
		req.setCharacterEncoding("UTF-8");
		
		//MemberDao 내의 getSequence 메소드 호출
		MemberDto dto = new MemberDto();
		MemberDao dao = new MemberDao();
		int member_no = dao.getSequence();
		dto.setMember_no(member_no);
		
		dto.setMember_id(req.getParameter("member_id"));
		dto.setMember_pw(req.getParameter("member_pw"));
		dto.setMember_nick(req.getParameter("member_nick"));
		dto.setMember_email(req.getParameter("member_email"));
		dto.setMember_phone(req.getParameter("member_phone"));
		dto.setMember_auth(req.getParameter("member_auth"));
		dao.insert(dto);
		 
		 
	 
		 //결과
		 resp.sendRedirect("join_success.jsp");
		 
		
		 
	 }
	 //예외처리
	 catch (Exception e) {
		e.printStackTrace(); //->에러 출력시
		resp.sendError(500); //->에러 코드 발동!!
	}
	 
}
}