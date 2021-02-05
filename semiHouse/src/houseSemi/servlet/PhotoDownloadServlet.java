package houseSemi.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import houseSemi.beans.PhotoDao;
import houseSemi.beans.PhotoDto;

@WebServlet(urlPatterns = "/member/photodownload.do")
public class PhotoDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int photo_no = Integer.parseInt(req.getParameter("photo_no"));
			int house_no = Integer.parseInt(req.getParameter("house_no"));
			
			PhotoDao photoDao = new PhotoDao();
			PhotoDto photoDto = photoDao.findMemberPhoto(house_no, photo_no);
			
			String path = "D:/upload/kh42";
			File target = new File(path, photoDto.getSave_name());
			byte[] data = new byte[(int)target.length()];
			FileInputStream in = new FileInputStream(target);
			in.read(data);
			in.close();
			
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(photoDto.getPhoto_size()));
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(photoDto.getUpload_name(), "UTF-8")+"\"");
			
			resp.getOutputStream().write(data);
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
