package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.MemberDao;
import houseSemi.beans.MemberDto;

@WebServlet(urlPatterns = "/admin/edit.do")
public class AdminEditServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto dto = new MemberDto(); 
			dto.setMember_no(Integer.parseInt(req.getParameter("member_no")));
			dto.setMember_auth(req.getParameter("member_auth"));
			

			MemberDao dao = new MemberDao();
			boolean result = dao.editByAdmin(dto);
			
			if(result) {
				resp.sendRedirect("list.jsp?type=member_no&key="+dto.getMember_no());
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