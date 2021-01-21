package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.*;

@WebServlet(urlPatterns ="/board/write" )
public class BoardWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("utf8");
			BoardDto boardDto=new BoardDto();
			boardDto.setBoard_header(req.getParameter("board_header"));
			boardDto.setBoard_title(req.getParameter("board_title"));
			boardDto.setBoard_content(req.getParameter("board_content"));
			
			int member_no = (int) req.getSession().getAttribute("세션값을 넣어주새요");
			MemberDao memberDao=new MemberDao();
			MemberDto memberDto=memberDao.find(member_no);
			
			
			BoardDao boardDao = new BoardDao();
			
			//추후 Dao에 추가해야 합니다!!!
//			int board_no = boardDao.getSequence();
//			boardDto.setBoard_no(board_no);		
//			boardDao.writeWithPrimaryKey(boardDto);
					
			resp.sendRedirect("어디로 가야하나요");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
