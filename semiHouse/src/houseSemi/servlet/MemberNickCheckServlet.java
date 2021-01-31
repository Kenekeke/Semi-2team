package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.MemberDao;

@WebServlet(urlPatterns = "/member/nickCheck.do")
public class MemberNickCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String member_nick=req.getParameter("member_nick");
			MemberDao memberDao=new MemberDao();
			boolean result=memberDao.nickCheck(member_nick);
			
			resp.getWriter().print(result);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
