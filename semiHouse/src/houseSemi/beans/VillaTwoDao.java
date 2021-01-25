package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import houseSemi.util.*;

public class VillaTwoDao {
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
	
	public VillaTwoDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from villa where house_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		VillaTwoDto dto;
		if(rs.next()) {
			dto = new VillaTwoDto();
			
			dto.setBroker_agree(rs.getString("broker_agree"));
			dto.setAnimal(rs.getString("animal"));
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setElevator(rs.getString("elevator"));
			dto.setEtc(rs.getString("etc"));
			dto.setFloor(rs.getString("floor"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setLoan(rs.getString("loan"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMove_in(rs.getDate("move_in"));
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
}
