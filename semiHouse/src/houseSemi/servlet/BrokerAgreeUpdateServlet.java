package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.HouseDao;
import houseSemi.beans.HouseDto;
import houseSemi.beans.OfficeDao;
import houseSemi.beans.OneDao;
import houseSemi.beans.OneDto;
import houseSemi.beans.VillatwoDao;

@WebServlet(urlPatterns = "/member/update-agree.do")
public class BrokerAgreeUpdateServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			//처리
			int house_no = Integer.parseInt(req.getParameter("house_no"));
			//하우스테이블//
			HouseDao houseDao = new HouseDao();
			HouseDto houseDto = houseDao.find(house_no);
			
			String broker_agree = "1";
			if(houseDto.getHouse_type().equals("one")){
				OneDao oneDao = new OneDao();
				oneDao.updateOneBrokerA(broker_agree, house_no);				
			}else if(houseDto.getHouse_type().equals("office")) {
				OfficeDao officeDao = new OfficeDao();
				officeDao.updateOfficeBrokerA(broker_agree, house_no);								
			}else {
				VillatwoDao villatwoDao = new VillatwoDao();
				villatwoDao.updateVillatwoBrokerA(broker_agree, house_no);
			}
			
			resp.sendRedirect(req.getContextPath()+"/member/broker_room-list.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}