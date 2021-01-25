package houseSemi.servlet;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import houseSemi.beans.*;

@WebServlet(urlPatterns = "/house/list_villatwo.do")
public class AjaxListVillatwoServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");		
			
			String filter = req.getParameter("filter");
			VillatwoDao villaDao = new VillatwoDao();
		   	List<VillatwoDto> villalist;
		   	
		   	//System.out.println(filter);
		   	
		   	if(filter.equals("null")){
		   		villalist = villaDao.onSelect();
		   	}
		   	else{
		   		FilteringVO villatwoVO = new FilteringVO();
		   		villatwoVO.setCharter_min(req.getParameter("charter_min"));
		   		villatwoVO.setCharter_max(req.getParameter("charter_max"));
		   		villatwoVO.setDeposit_min(req.getParameter("deposit_min"));
		   		villatwoVO.setDeposit_max(req.getParameter("deposit_max"));
		   		villatwoVO.setMonthly_min(req.getParameter("monthly_min"));
		   		villatwoVO.setMonthly_max(req.getParameter("monthly_max"));
		   		villatwoVO.setFloor1(req.getParameter("floor1"));
		   		villatwoVO.setFloor2(req.getParameter("floor2"));
		   		villatwoVO.setFloor3(req.getParameter("floor3"));
		   		villatwoVO.setParking(req.getParameter("parking"));
		   		villatwoVO.setElevator(req.getParameter("elevator"));
		   		villatwoVO.setAnimal(req.getParameter("animal"));
		   		villatwoVO.setLoan(req.getParameter("loan"));
		   		villalist = villaDao.select(villatwoVO);
		   	}
			
			resp.setHeader("Content-Type", "application/json");
			resp.setHeader("Content-Encoding", "UTF-8");	
			 
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(villalist);
			resp.getWriter().print(json);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
