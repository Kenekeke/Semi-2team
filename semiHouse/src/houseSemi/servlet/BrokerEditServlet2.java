package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BrokerDao;
import houseSemi.beans.BrokerMemberVO;


@WebServlet(urlPatterns = "/member/brokeredit2.do")
public class BrokerEditServlet2 extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			BrokerMemberVO vo = new BrokerMemberVO(); 
			vo.setMember_no((int)req.getSession().getAttribute("check"));
			vo.setBroker_name(req.getParameter("broker_name"));
			vo.setBroker_address(req.getParameter("broker_address"));
			vo.setBroker_address2(req.getParameter("broker_address2"));
			vo.setBroker_landline(req.getParameter("broker_landline"));

			BrokerDao dao = new BrokerDao();
			boolean result = dao.edit(vo);
			
			if(result) {
				resp.sendRedirect("my.jsp");
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


