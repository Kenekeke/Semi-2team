package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class HouseDao {
	// 계정정보를 상수로 저장
	public static final String USERNAME = "kh42";
	public static final String PASSWORD = "kh42";
	
	//시퀀스 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select house_seq.nextval from dual";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	//시퀀스까지 함께 등록하는 기능
	public void insertWithPrimaryKey(HouseDto houseDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into house values(?, ?, ?, ?, sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, houseDto.getHouse_no());
		ps.setInt(2, houseDto.getMember_no());
		ps.setInt(3, houseDto.getBroker_no());
		ps.setString(4, houseDto.getHouse_type());
		
		
		ps.execute();
		
		con.close();
		
	}
	//수정
	public boolean update(HouseDto houseDto)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update house set broker_no=? where house_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, houseDto.getBroker_no());
		ps.setInt(2, houseDto.getHouse_no());
		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}
	
	// 삭제
	public boolean delete(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete house where house_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0; 
	}
	//단일 조회
	public HouseDto find(int house_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from house where house_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs = ps.executeQuery();
		HouseDto dto;
		if(rs.next()) {
			dto = new HouseDto();
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setHouse_type(rs.getString("house_type"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setInsert_date(rs.getDate("insert_date"));
		}else {
			dto = null;
		}
		con.close();
		return dto;
	}
	
	//조회
	public List<HouseDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<HouseDto> houseList = new ArrayList<HouseDto>();
		while (rs.next()) {
			HouseDto dto = new HouseDto();
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setInsert_date(rs.getDate("insert_date"));
			houseList.add(dto);
		}
		con.close();
		return houseList;
	}
	public List<HouseDto> select(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house where member_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseDto> houseList = new ArrayList<HouseDto>();
		while (rs.next()) {
			HouseDto dto = new HouseDto();
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setInsert_date(rs.getDate("insert_date"));
			dto.setHouse_type(rs.getString("house_type"));
			houseList.add(dto);
		}
		con.close();
		return houseList;
	}
	public List<HouseOnePhotoVO> selectOne(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join one O on H.house_no = O.house_no "
						+ "inner join photo P on O.house_no = P.house_no "
							+ "where H.member_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseOnePhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseOnePhotoVO vo = new HouseOnePhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setOne_no(rs.getInt("one_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
	public List<HouseOnePhotoVO> selectOneBroker(int broker_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join one O on H.house_no = O.house_no "
						+ "inner join photo P on O.house_no = P.house_no "
							+ "where H.broker_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, broker_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseOnePhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseOnePhotoVO vo = new HouseOnePhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setOne_no(rs.getInt("one_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
	public List<HouseOfficePhotoVO> selectOffice(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join office O on H.house_no = O.house_no "
						+ "inner join photo P on O.house_no = P.house_no "
							+ "where H.member_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseOfficePhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseOfficePhotoVO vo = new HouseOfficePhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setOffice_no(rs.getInt("office_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
	public List<HouseOfficePhotoVO> selectOfficeBroker(int broker_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join office O on H.house_no = O.house_no "
						+ "inner join photo P on O.house_no = P.house_no "
							+ "where H.broker_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, broker_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseOfficePhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseOfficePhotoVO vo = new HouseOfficePhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setOffice_no(rs.getInt("office_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
	public List<HouseVillatwoPhotoVO> selectVillatwo(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join villatwo V on H.house_no = V.house_no "
						+ "inner join photo P on V.house_no = P.house_no "
							+ "where H.member_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseVillatwoPhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseVillatwoPhotoVO vo = new HouseVillatwoPhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setVillatwo_no(rs.getInt("villatwo_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
	public List<HouseVillatwoPhotoVO> selectVillatwoBroker(int broker_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from house H "
						+ "inner join villatwo V on H.house_no = V.house_no "
						+ "inner join photo P on V.house_no = P.house_no "
							+ "where H.broker_no=? order by photo_no asc";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, broker_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseVillatwoPhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseVillatwoPhotoVO vo = new HouseVillatwoPhotoVO();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setHouse_type(rs.getString("house_type"));
			vo.setInsert_date(rs.getDate("insert_date"));
			vo.setVillatwo_no(rs.getInt("villatwo_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setBill(rs.getInt("bill"));
			vo.setTitle(rs.getString("title"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			
			houseList.add(vo);
		}
		con.close();
		return houseList;
	}
}
