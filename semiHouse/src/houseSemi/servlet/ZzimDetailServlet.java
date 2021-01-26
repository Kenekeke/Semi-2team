package houseSemi.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import houseSemi.beans.*;


@WebServlet(urlPatterns = "/like/zzim_detail.do")
public class ZzimDetailServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			
			int house_no = Integer.parseInt(req.getParameter("house_no"));
			String house_type=req.getParameter("house_type");
			
			//출력
			resp.setHeader("Contect-Type", "application/json");
			resp.setHeader("Content-Encoding", "UTF-8");
			ObjectMapper mapper = new ObjectMapper();
			String json;
			
			switch(house_type){ 
			case "one": 
				OneDao oneDao = new OneDao();
				List<OneVO> onelist = oneDao.house_select(house_no);
				json = mapper.writeValueAsString(onelist);
				resp.getWriter().print(json);
				break;
			case "villaTwo":
				VillatwoDao villaDao = new VillatwoDao();
				List<VillatwoVO> villalist = villaDao.house_select(house_no);
				json = mapper.writeValueAsString(villalist);
				resp.getWriter().print(json);
				break;
			case "office":
				OfficeDao officeDao = new OfficeDao();
				List<OfficeVO> officelist = officeDao.house_select(house_no);
				json = mapper.writeValueAsString(officelist);
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
