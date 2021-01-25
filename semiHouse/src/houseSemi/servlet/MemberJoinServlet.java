package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns ="/member/join.do")
public class MemberJoinServlet extends HttpServlet{
 @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 try { //->일어날 예외에 대한 대비
		//한글 복구 작업 및 설정 준비
		 req.setCharacterEncoding("UTF-8");
		 String member_id = req.getParameter("member_id");
		 String member_pw = req.getParameter("member_pw");
		 String member_nick = req.getParameter("member_nick");
		 String member_email = req.getParameter("member_email");
		 String member_phone = req.getParameter("member_phone");
		 String member_member = req.getParameter("member_member");
		 
		 //resp 처리
		 resp.setCharacterEncoding("UTF-8");
		 resp.setContentType("text/html");
		 resp.getWriter().println("아이디"+member_id);
		 resp.getWriter().println("비밀번호"+member_pw);
		 resp.getWriter().println("닉네임"+member_nick);
		 resp.getWriter().println("이메일"+member_email);
		 resp.getWriter().println("휴대폰 번호"+member_phone);
		 resp.getWriter().println("회원 구분"+member_member);
		 
		 //if문? 쳐서 join_broker로 ?
//		 if(member==member_member) {
//			 resp.sendRedirect("회원 가입 완료");
//		 }
//		 else {
//			 resp.sendRedirect("join_broker.do");//상대경로
//		 };
	} catch (Exception e) {
		e.printStackTrace(); //->에러 출력시
		resp.sendError(500); //->에러 코드 발동!!
	}
	 
 }
}