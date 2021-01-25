package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;


@WebServlet(urlPatterns = "/member/login.do")
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String LoginGubun= req.getParameter("flag");
		if(LoginGubun.equals("m")) {
		try {
				MemberDto dto = new MemberDto();
				dto.setMember_id(req.getParameter("id"));
				dto.setMember_pw(req.getParameter("pw"));
				
				MemberDao dao = new MemberDao();
				boolean login = dao.login(dto);  
				
				MemberDto m = dao.find(dto.getMember_id());
				req.getSession().setAttribute("auth", m.getMember_auth());
				if(!m.getMember_auth().equals("broker")) {
				if(login) {
					req.getSession().setAttribute("check", m.getMember_no());
					req.getSession().setAttribute("auth", m.getMember_auth());
					resp.sendRedirect("../index.jsp");
					}	
					else { 
						resp.sendRedirect("login.jsp?error");
			} 
				}else { 
					resp.sendRedirect("login.jsp?error");
		} 
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			}
		}
		if(LoginGubun.equals("b")) {
			try {
				MemberDto dto = new MemberDto();
				dto.setMember_id(req.getParameter("id"));
				dto.setMember_pw(req.getParameter("pw"));
				
				
				MemberDao dao = new MemberDao();
				boolean login = dao.login(dto); 
				
				MemberDto m = dao.find(dto.getMember_id());
				req.getSession().setAttribute("auth", m.getMember_auth());
				if(m.getMember_auth().equals("broker")) {
				if(login) {
					req.getSession().setAttribute("check", m.getMember_no());
					req.getSession().setAttribute("auth", m.getMember_auth());
					resp.sendRedirect("../index.jsp");
					}	
					else { 
						resp.sendRedirect("login.jsp?error");
			} 
				}else { 
					resp.sendRedirect("login.jsp?error");
				} 
			}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			}
		}
	}
}
