package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import houseSemi.util.*;

public class VillatwoDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	public VillaTwoTypeVO type(int house_no) throws Exception {
		Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select V.*, house_type from (select * from villaTwo where house_no=?) V left outer join house H on H.house_no=V.house_no";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		VillaTwoTypeVO VO;
		if(rs.next()) {
			VO=new VillaTwoTypeVO();
			VO.setBroker_agree(rs.getString("broker_agree"));
			VO.setAnimal(rs.getString("animal"));
			VO.setBroker_no(rs.getInt("broker_no"));
			VO.setElevator(rs.getString("elevator"));
			VO.setEtc(rs.getString("etc"));
			VO.setFloor(rs.getString("floor"));
			VO.setHouse_no(rs.getInt("house_no"));
			VO.setLoan(rs.getString("loan"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setMove_in(rs.getDate("move_in"));
			VO.setParking(rs.getString("parking"));
			VO.setAddress(rs.getString("address"));
			VO.setAddress2(rs.getString("address2"));
			VO.setArea(rs.getString("area"));
			VO.setTitle(rs.getString("title"));
			VO.setBill(rs.getInt("bill"));
			VO.setDirection(rs.getString("direction"));
			VO.setDeposit(rs.getInt("deposit"));
			VO.setMonthly(rs.getInt("monthly"));
			VO.setVillaTwo_no(rs.getInt("villaTwo_no"));
			VO.setHouse_type(rs.getString("house_type"));
		}
		else {
			VO=null;
		}
		con.close();
		return VO;
	}
	
	public VillatwoDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from villa where house_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		VillatwoDto dto;
		if(rs.next()) {
			dto = new VillatwoDto();
			
			dto.setBroker_agree(rs.getString("broker_agree"));
			dto.setAnimal(rs.getString("animal"));
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setElevator(rs.getString("elevator"));
			dto.setEtc(rs.getString("etc"));
			dto.setFloor(rs.getString("floor"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setLoan(rs.getString("loan"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMove_in(rs.getString("move_in"));
			dto.setParking(rs.getString("parking"));
			dto.setAddress(rs.getString("address"));
			dto.setAddress2(rs.getString("address2"));
			dto.setArea(rs.getString("area"));
			dto.setDeposit(rs.getInt("deposit"));
			dto.setMonthly(rs.getInt("monthly"));
			dto.setTitle(rs.getString("title"));
			dto.setBill(rs.getInt("bill"));
			dto.setDirection(rs.getString("direction"));
			dto.setVillaTwo_no(rs.getInt("villaTwo_no"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
	
	public void insert(VillatwoDto villatwoDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into villatwo "
				+ "values(villatwo_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,0 ,?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, villatwoDto.getHouse_no());
		ps.setInt(2, villatwoDto.getMember_no());
		ps.setInt(3, villatwoDto.getBroker_no());
		ps.setInt(4, villatwoDto.getDeposit());
		ps.setInt(5, villatwoDto.getMonthly());
		ps.setString(6, villatwoDto.getAddress());
		ps.setString(7, villatwoDto.getAddress2());
		ps.setString(8, villatwoDto.getFloor());
		ps.setString(9, villatwoDto.getLoan());
		ps.setString(10, villatwoDto.getAnimal());
		ps.setString(11, villatwoDto.getElevator());
		ps.setString(12, villatwoDto.getParking());
		ps.setString(13, villatwoDto.getMove_in());
		ps.setString(14, villatwoDto.getEtc());
		ps.setString(15, villatwoDto.getArea());
		ps.setInt(16, villatwoDto.getBill());
		ps.setString(17, villatwoDto.getDirection());
		ps.setString(18, villatwoDto.getTitle());
		
		ps.execute();
		
		con.close();
	}
}
