package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BoardDao;
import houseSemi.beans.BoardDto;


@WebServlet(urlPatterns ="/semi-project/boardWrite.do")
public class BoardWriteServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BoardDto boardDto = new BoardDto();
			boardDto.setMember_no((int)req.getSession().getAttribute("check"));
			boardDto.setBoard_header(req.getParameter("board_header"));
			boardDto.setBoard_title(req.getParameter("board_title"));
			boardDto.setBoard_content(req.getParameter("board_content"));
			
			BoardDao boardDao = new BoardDao();
			int board_no = boardDao.getSequence();
			boardDto.setBoard_no(board_no);
			boardDao.insert(boardDto);
					
			resp.sendRedirect("boardDetail.jsp?board_no="+board_no);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
