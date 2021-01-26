package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.MemberDao;

@WebServlet(urlPatterns = "/member/delete.do")
public class MemberDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int member_no = (int) req.getSession().getAttribute("check");
		
			MemberDao dao = new MemberDao();
			dao.delete(member_no); 
			
			req.getSession().removeAttribute("check");
			req.getSession().removeAttribute("auth");
			resp.sendRedirect("goodbye.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
} 