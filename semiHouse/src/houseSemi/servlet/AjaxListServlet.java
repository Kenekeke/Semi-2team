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

@WebServlet(urlPatterns = "/filter/list.do")
public class AjaxListServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("utf8");		
			
			String filter = req.getParameter("filter");
			
			OneDao oneDao=new OneDao();
		   	List<OneDto> onelist;
		   	
		   	if(filter == null){
		   		onelist = oneDao.select();
		   	}
		   	else{
		   		OneVO oneVO = new OneVO();
		   		oneVO.setCharter_min(req.getParameter("charter_min"));
		   		oneVO.setCharter_max(req.getParameter("charter_max"));
		   		oneVO.setDeposit_min(req.getParameter("deposit_min"));
		   		oneVO.setDeposit_max(req.getParameter("deposit_max"));
		   		oneVO.setMonthly_min(req.getParameter("monthly_min"));
		   		oneVO.setMonthly_max(req.getParameter("monthly_max"));
		   		oneVO.setFloor1(req.getParameter("floor1"));
		   		oneVO.setFloor2(req.getParameter("floor2"));
		   		oneVO.setFloor3(req.getParameter("floor3"));
		   		oneVO.setParking(req.getParameter("parking"));
		   		oneVO.setElevator(req.getParameter("elevator"));
		   		oneVO.setAnimal(req.getParameter("animal"));
		   		oneVO.setLoan(req.getParameter("loan"));
		   		onelist = oneDao.select(oneVO);
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
			String json = mapper.writeValueAsString(onelist);
			resp.getWriter().print(json);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
