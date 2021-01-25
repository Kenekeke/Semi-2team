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

@WebServlet(urlPatterns = "/like/zzim.do")
public class ZzimListServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			resp.setContentType("application/x-json; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			int member_no =Integer.parseInt(req.getParameter("member_no"));
			LikesDao likesDao=new LikesDao();
			List<LikesDto> likesList = likesDao.select(member_no);
			List<HouseDto> houseList = new ArrayList<>();
			for(LikesDto likesDto : likesList){
				HouseDao houseDao = new HouseDao();
				HouseDto houseDto =houseDao.find(likesDto.getHouse_no());//매물번호로 매물Dto를 호출합니다.
				//매물타입에 따라 다른 테이블에서 객체를 불러옵니다.
				houseList.add(houseDto);
			}
    		resp.setHeader("Content-Type", "application/json");
    		resp.setHeader("Content-Encoding", "UTF-8");	
    		 
    		ObjectMapper mapper = new ObjectMapper();
    		String json = mapper.writeValueAsString(houseList);
			resp.getWriter().print(json);
    		
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}	
}