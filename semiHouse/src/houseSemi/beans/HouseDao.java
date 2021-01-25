package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class HouseDao {
	// 계정정보를 상수로 저장
	public static final String USERNAME = "house";
	public static final String PASSWORD = "house";
	
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
	public List<HouseOnePhotoVO> select(String member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select H.house_no, O.address, O.address2, H.insert_date, O.broker_agree " + 
				"from house H inner join one O on H.house_no = O.house_no where H.member_no=?;";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		List<HouseOnePhotoVO> houseList = new ArrayList<>();
		while (rs.next()) {
			HouseOnePhotoVO vo = new HouseDto();
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setInsert_date(rs.getDate("insert_date"));
			houseList.add(houseDto);
		}
		con.close();
		return houseList;
	}
}
