package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.MemberDao;
import houseSemi.util.StringUtil;


@WebServlet(urlPatterns = "/admin/pw.do")	
public class AdminPasswordServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = Integer.parseInt(req.getParameter("member_no"));
			String password = StringUtil.generateRandomString(6);
			
			MemberDao dao = new MemberDao();
			boolean result = dao.editPasswordByAdmin(member_no, password);
			
			if(result) {
 
				req.setAttribute("password", password);
				req.getRequestDispatcher("pw.jsp").forward(req, resp);
			}
			else {
				resp.sendError(404);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}