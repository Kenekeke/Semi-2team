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

@WebServlet(urlPatterns = "/house/list_office.do")
public class AjaxListOfficeServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");		
			
			String filter = req.getParameter("filter");
			OfficeDao officeDao = new OfficeDao();
		   	List<OfficeDto> officelist;
		   	
		   	
		   	if(filter.equals("null")){
		   		officelist = officeDao.onSelect();
		   	}
		   	else{
		   		FilteringVO officeVO = new FilteringVO();
		   		officeVO.setCharter_min(req.getParameter("charter_min"));
		   		officeVO.setCharter_max(req.getParameter("charter_max"));
		   		officeVO.setDeposit_min(req.getParameter("deposit_min"));
		   		officeVO.setDeposit_max(req.getParameter("deposit_max"));
		   		officeVO.setMonthly_min(req.getParameter("monthly_min"));
		   		officeVO.setMonthly_max(req.getParameter("monthly_max"));
		   		officeVO.setFloor1(req.getParameter("floor1"));
		   		officeVO.setFloor2(req.getParameter("floor2"));
		   		officeVO.setFloor3(req.getParameter("floor3"));
		   		officeVO.setParking(req.getParameter("parking"));
		   		officeVO.setElevator(req.getParameter("elevator"));
		   		officeVO.setAnimal(req.getParameter("animal"));
		   		officeVO.setLoan(req.getParameter("loan"));
		   		officelist = officeDao.select(officeVO);
		   	}
		   	
			/*
			 * for(OneDto oneDto : onelist){
			 * 
			 * datas.push({ "번호" : oneDto.getOne_no(), "주소" : oneDto.getOne_address() //스트링을
			 * 넣어줄때는 ''를 반드시 사용해 줘야함 }); }
			 */
			
			resp.setHeader("Content-Type", "application/json");
			resp.setHeader("Content-Encoding", "UTF-8");	
			 
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(officelist);
			resp.getWriter().print(json);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
