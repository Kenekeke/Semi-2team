package houseSemi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import houseSemi.beans.*;


@WebServlet(urlPatterns = "/like/zzim_type.do")
public class ZzimTypeServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			
			String house_type=req.getParameter("house_type");
			int house_no=Integer.parseInt(req.getParameter("house_no"));
			System.out.println(house_no);
			resp.setHeader("Content-Type", "application/json");
    		resp.setHeader("Content-Encoding", "UTF-8");	
    		 
    		ObjectMapper mapper = new ObjectMapper();
    		String json;
    		switch(house_type){ 
    			case "one": 
    				OneDao oneDao = new OneDao();
    				OneTypeVO oneVO = oneDao.type(house_no);
    				json = mapper.writeValueAsString(oneVO);
    				resp.getWriter().print(json);
    				break;
    			case "villaTwo":
    				VillaTwoDao villaDao = new VillaTwoDao();
    				VillaTwoTypeVO villavo = villaDao.type(house_no);
    				json = mapper.writeValueAsString(villavo);
    				resp.getWriter().print(json);
    				break;
    			case "office":
    				OfficeDao officeDao = new OfficeDao();
    				OfficeTypeVO officevo = officeDao.type(house_no);
    				json = mapper.writeValueAsString(officevo);
    				resp.getWriter().print(json);
    				break;
    		}     
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
