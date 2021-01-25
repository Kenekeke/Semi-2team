package houseSemi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BoardDao;
import houseSemi.beans.BoardDto;

@WebServlet(urlPatterns = "/board/boardEdit.do")
public class BoardEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			BoardDto boardDto = new BoardDto();
			boardDto.setBoard_header(req.getParameter("board_header"));
			boardDto.setBoard_title(req.getParameter("board_title"));
			boardDto.setBoard_content(req.getParameter("board_content"));
			boardDto.setBoard_no(board_no);
			BoardDao boardDao=new BoardDao();
			boardDao.update(boardDto);
			
			resp.sendRedirect("boardDetail.jsp?board_no="+board_no);

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
