package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import houseSemi.beans.*;

@WebServlet(urlPatterns = "/like/zzim_check.do")
public class ZzimCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = (int)req.getSession().getAttribute("check");
			int house_no=Integer.parseInt(req.getParameter("house_no"));
			LikesDao likesDao = new LikesDao();
			String zzim;
			if(likesDao.check(house_no, member_no)) {
				zzim="yes";
			}
			else {
				zzim="no";
			}
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.getWriter().print(zzim);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
