package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import houseSemi.beans.*;

@WebServlet(urlPatterns = "/like/zzim_add.do")
public class ZzimAddServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			LikesDao likesDao = new LikesDao();

			int house_no=Integer.parseInt(req.getParameter("house_no"));
			
			HouseDao houseDao = new HouseDao();
			HouseDto houseDto = houseDao.find(house_no);
			
			boolean zzim;
			if(likesDao.check(house_no)) {
				likesDao.delete(house_no);
				zzim=false;
			}
			else {
				LikesDto likesDto =new LikesDto();
				int likes_no =likesDao.getSequence();
				
				likesDto.setLikes_no(likes_no);
				likesDto.setHouse_no(house_no);
				likesDto.setMember_no(memberDto.getMember_no());
				likesDto.setBroker_no(houseDto.getBroker_no());
				likesDao.add(likesDto);
				zzim=true;
			}
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.getWriter().print(zzim);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
