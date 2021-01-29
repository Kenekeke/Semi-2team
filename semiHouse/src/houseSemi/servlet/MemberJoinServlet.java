package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BrokerDto;
import houseSemi.beans.MemberDao;
import houseSemi.beans.MemberDto;

@WebServlet(urlPatterns ="/member/join_member.do")
public class MemberJoinServlet extends HttpServlet{
 @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 try { //->일어날 예외에 대한 대비
		
		//한글 복구 작업 및 설정 준비
		 req.setCharacterEncoding("UTF-8");
		 MemberDto dto = new MemberDto();
		 dto.setMember_id(req.getParameter("member_id"));
		 dto.setMember_pw(req.getParameter("member_pw"));
		 dto.setMember_nick(req.getParameter("member_nick"));
		 dto.setMember_email(req.getParameter("member_email"));
		 dto.setMember_phone(req.getParameter("member_phone"));
		 dto.setMember_auth(req.getParameter("member_auth"));
		 
		 
//		 1.회원가입창이 뜨고 
//		 2.일반회원은 정보를 넣으면 바로 join_success.jsp 로 해서 -> 로그인화면이동, 홈화면이동 
		 
		 //처리
		 MemberDao dao = new MemberDao();
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