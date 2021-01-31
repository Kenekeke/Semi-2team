package houseSemi.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import houseSemi.beans.BrokerDao;
import houseSemi.beans.BrokerDto;
import houseSemi.beans.HouseDao;
import houseSemi.beans.HouseDto;
import houseSemi.beans.MemberDao;
import houseSemi.beans.MemberDto;
import houseSemi.beans.OfficeDao;
import houseSemi.beans.OfficeDto;
import houseSemi.beans.OneDao;
import houseSemi.beans.OneDto;
import houseSemi.beans.PhotoDao;
import houseSemi.beans.PhotoDto;
import houseSemi.beans.VillatwoDao;
import houseSemi.beans.VillatwoDto;

@WebServlet(urlPatterns = "/house/insert-room.do")
public class HouseInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			// 수신
			String path = "C:\\Download";
			int max = 10 * 1024 * 1024; //10MB
			String encoding = "UTF-8";  //encoding
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();//같은 파일 업로드시 덮어쓰기 방지
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			////하우스 테이블 생성//////
			HouseDto houseDto = new HouseDto();
			HouseDao houseDao = new HouseDao();

			//현재 로그인 사용자 정보 불러오기
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			houseDto.setMember_no(memberDto.getMember_no());
			
			//주소 추출
			String address = mRequest.getParameter("address");
			String city = null;
			java.util.Scanner sc = new java.util.Scanner(address);
			while(sc.hasNext()) {
				String temp = sc.next();
				if(temp.contains("구")) {
					city = temp;
					break;
				}
			}
			sc.close();
						
			//부동산 사용자 정보 입력
			BrokerDao brokerDao = new BrokerDao();
			
			BrokerDto brokerDto = brokerDao.find(city);
			int broker_no = brokerDto.getBroker_no();
			//추출한 city가 부동산 주소에 포함되어있다면 부동산 넘버를 들고 오시오
			if(brokerDto.getBroker_address().contains(city)) {
				houseDto.setBroker_no(broker_no);				
			}
			
			int house_no = houseDao.getSequence(); //시퀀스 생성
			houseDto.setHouse_no(house_no);
			
			//매물 종류 받기: 원룸 빌라 오피스텔
			houseDto.setHouse_type(mRequest.getParameter("house_type"));
			
			houseDao.insertWithPrimaryKey(houseDto);
			
			/////////////////사진 등록////////////////
			
			// 수신 폴더 생성
			File dir = new File(path);
			dir.mkdir();
			
			//계산
			PhotoDao photoDao = new PhotoDao();
			for(int i=1; i <=5 ; i++) {
				PhotoDto photoDto = new PhotoDto();
				photoDto.setHouse_no(house_no);
				photoDto.setSave_name(mRequest.getFilesystemName("f"+i)); //저장된 이름
				photoDto.setUpload_name(mRequest.getOriginalFileName("f"+i)); //업로드 이름
				File target = mRequest.getFile("f"+i);
				photoDto.setPhoto_size(target.length()); //파일 크기
				photoDto.setPhoto_type(mRequest.getContentType("f"+i)); //파일 유형
				
				photoDao.insert(photoDto);
			}
			
			
			///////////원룸, 투룸, 오피스텔 테이블 생성//////
			if(mRequest.getParameter("house_type").equals("one")) {
				OneDto oneDto = new OneDto();
				OneDao oneDao = new OneDao();
				
				oneDto.setHouse_no(house_no);
				oneDto.setMember_no(member_no);
				oneDto.setBroker_no(broker_no);
				oneDto.setAddress(address);
				oneDto.setAddress2(mRequest.getParameter("address2"));
				oneDto.setDeposit(Integer.parseInt(mRequest.getParameter("deposit"))*10000);
				oneDto.setMonthly(Integer.parseInt(mRequest.getParameter("monthly"))*10000);
				oneDto.setBill(Integer.parseInt(mRequest.getParameter("bill"))*10000);
				oneDto.setArea(mRequest.getParameter("area"));
				oneDto.setFloor(mRequest.getParameter("floor"));
				oneDto.setDirection(mRequest.getParameter("direction"));
				oneDto.setLoan(mRequest.getParameter("loan"));
				oneDto.setAnimal(mRequest.getParameter("animal"));
				oneDto.setElevator(mRequest.getParameter("elevator"));
				oneDto.setParking(mRequest.getParameter("parking"));
				oneDto.setMove_in(mRequest.getParameter("move_in"));
				oneDto.setTitle(mRequest.getParameter("title"));
				oneDto.setEtc(mRequest.getParameter("etc"));
				
				oneDao.insert(oneDto);
			}else if(mRequest.getParameter("house_type").equals("villatwo")) {
				VillatwoDto villatwoDto = new VillatwoDto();
				VillatwoDao villatwoDao = new VillatwoDao();
				
				
				villatwoDto.setHouse_no(house_no);
				villatwoDto.setMember_no(member_no);
				villatwoDto.setBroker_no(broker_no);
				villatwoDto.setAddress(address);
				villatwoDto.setAddress2(mRequest.getParameter("address2"));
				villatwoDto.setDeposit(Integer.parseInt(mRequest.getParameter("deposit"))*10000);
				villatwoDto.setMonthly(Integer.parseInt(mRequest.getParameter("monthly"))*10000);
				villatwoDto.setBill(Integer.parseInt(mRequest.getParameter("bill"))*10000);
				villatwoDto.setArea(mRequest.getParameter("area"));
				villatwoDto.setFloor(mRequest.getParameter("floor"));
				villatwoDto.setDirection(mRequest.getParameter("direction"));
				villatwoDto.setLoan(mRequest.getParameter("loan"));
				villatwoDto.setAnimal(mRequest.getParameter("animal"));
				villatwoDto.setElevator(mRequest.getParameter("elevator"));
				villatwoDto.setParking(mRequest.getParameter("parking"));
				villatwoDto.setMove_in(mRequest.getParameter("move_in"));
				villatwoDto.setTitle(mRequest.getParameter("title"));
				villatwoDto.setEtc(mRequest.getParameter("etc"));
				
				villatwoDao.insert(villatwoDto);
				
			}else {
				OfficeDto officeDto = new OfficeDto();
				OfficeDao officeDao = new OfficeDao();
				
				
				officeDto.setHouse_no(house_no);
				officeDto.setAddress(address);
				officeDto.setMember_no(member_no);
				officeDto.setBroker_no(broker_no);
				officeDto.setAddress2(mRequest.getParameter("address2"));
				officeDto.setDeposit(Integer.parseInt(mRequest.getParameter("deposit"))*10000);
				officeDto.setMonthly(Integer.parseInt(mRequest.getParameter("monthly"))*10000);
				officeDto.setBill(Integer.parseInt(mRequest.getParameter("bill"))*10000);
				officeDto.setArea(mRequest.getParameter("area"));
				officeDto.setFloor(mRequest.getParameter("floor"));
				officeDto.setDirection(mRequest.getParameter("direction"));
				officeDto.setLoan(mRequest.getParameter("loan"));
				officeDto.setAnimal(mRequest.getParameter("animal"));
				officeDto.setElevator(mRequest.getParameter("elevator"));
				officeDto.setParking(mRequest.getParameter("parking"));
				officeDto.setMove_in(mRequest.getParameter("move_in"));
				officeDto.setTitle(mRequest.getParameter("title"));
				officeDto.setEtc(mRequest.getParameter("etc"));
				
				officeDao.insert(officeDto);
			}
			
			//출력
			resp.sendRedirect("insert_success.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("insert_fail.jsp");
		}
		
	
	}
}
