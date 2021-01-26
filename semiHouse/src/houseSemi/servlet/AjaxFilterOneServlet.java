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

@WebServlet(urlPatterns="/house/filter_one.do")
public class AjaxFilterOneServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			int one_no = Integer.parseInt(req.getParameter("one_no"));
			//System.out.println(one_no);
			OneDao oneDao = new OneDao();
			List<OneVO> onelist = oneDao.select(one_no);
			
			//출력
			resp.setHeader("Contect-Type", "application/json");
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
