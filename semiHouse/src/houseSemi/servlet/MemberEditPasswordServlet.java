package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MemberDao;


@WebServlet(urlPatterns = "/member/editpw.do")
public class MemberEditPasswordServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int member_no = (int)req.getSession().getAttribute("check");
			String member_pw = req.getParameter("member_pw");

			MemberDao dao = new MemberDao();
			boolean pwresult = dao.pwlogin(member_no, member_pw);
			 
			if(pwresult) {
				resp.sendRedirect("edit.jsp");
			}
			else {
				resp.sendRedirect("editpw.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}