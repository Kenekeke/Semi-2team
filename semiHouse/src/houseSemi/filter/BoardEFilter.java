package houseSemi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.BoardDao;
import houseSemi.beans.BoardDto;

@WebFilter(urlPatterns= {
		"/board/boardEdit.jsp","/board/boardEdit.do"
})
public class BoardEFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		req.setCharacterEncoding("UTF-8");
		try {
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			BoardDao boardDao = new BoardDao();
			BoardDto boardDto = boardDao.find(board_no);
			int member_no = (int)req.getSession().getAttribute("check");
			if(member_no == boardDto.getMember_no()) {
				chain.doFilter(request, response);
				return;
			}
			resp.sendError(403);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
