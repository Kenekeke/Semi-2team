package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;
import beans.MemberDto;


@WebServlet(urlPatterns = "/member/brokeredit.do")
public class BrokerEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			MemberDto dto = new MemberDto(); 
			dto.setMember_no((int)req.getSession().getAttribute("check"));
			dto.setMember_nick(req.getParameter("member_nick"));
			dto.setMember_email(req.getParameter("member_email"));
			dto.setMember_phone(req.getParameter("member_phone"));
			dto.setMember_pw(req.getParameter("member_pw"));

			MemberDao dao = new MemberDao();
			boolean result = dao.edit(dto);
			
			if(result) {
				resp.sendRedirect("brokeredit.jsp");
			}
			else {
				resp.sendRedirect("edit.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}


