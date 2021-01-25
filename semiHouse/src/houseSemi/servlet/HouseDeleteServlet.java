package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.HouseDao;

@WebServlet(urlPatterns = "/member/delete-room.do")
public class HouseDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int house_no = Integer.parseInt(req.getParameter("house_no"));
			//처리
			HouseDao houseDao = new HouseDao();
			boolean result = houseDao.delete(house_no);
			
			//출력
			if(result) {
//				resp.sendRedirect("room-list.jsp");
				resp.sendRedirect(req.getContextPath()+"/member/room-list.jsp");
			}else {
				resp.sendError(404);
			}
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
