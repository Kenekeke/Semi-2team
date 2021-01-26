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


@WebServlet(urlPatterns = "/like/test.do")
public class ZzimSearchServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("utf8");
			
			String keyword=req.getParameter("keyword");
			SearchDao dao = new SearchDao();
			List<SearchDto> list= dao.select(keyword);
			
			resp.setHeader("Content-Type", "application/json");
			resp.setHeader("Content-Encoding", "UTF-8");	
			 
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(list);
			resp.getWriter().print(json);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}



