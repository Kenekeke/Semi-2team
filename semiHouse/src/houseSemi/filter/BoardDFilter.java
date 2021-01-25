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

@WebFilter(urlPatterns= {
		"/board/boardDelete.do"
})
public class BoardDFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		req.setCharacterEncoding("UTF-8");
		try {
			int board_no = Integer.parseInt(req.getParameter("board_no"));
			BoardDao boardDao = new BoardDao();
			int member_no = (int)req.getSession().getAttribute("check");
			boolean isBoardOwner = member_no == boardDao.find(board_no).getMember_no();
			String admin = (String)req.getSession().getAttribute("auth");
			
			if(isBoardOwner) {
				chain.doFilter(request, response);
				return;
			}
			if(admin!=null&&admin.equals("admin")) {
				chain.doFilter(request, response);
				return;
			}
			resp.sendError(403);
		}
		catch(Exception e) {
			e.printStackTrace();

		}
	}
}
