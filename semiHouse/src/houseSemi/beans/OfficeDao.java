package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import houseSemi.util.*;

public class OfficeDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	public OfficeTypeVO type(int house_no) throws Exception {
		Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select O.*, house_type from (select * from office where house_no=?) O left outer join house H on H.house_no=O.house_no";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		OfficeTypeVO VO;
		if(rs.next()) {
			VO=new OfficeTypeVO();
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
			VO.setOffice_no(rs.getInt("office_no"));
			VO.setHouse_type(rs.getString("house_type"));
		}
		else {
			VO=null;
		}
		con.close();
		return VO;
	}
	
	public OfficeDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from office where house_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		OfficeDto dto;
		if(rs.next()) {
			dto = new OfficeDto();
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
			dto.setOffice_no(rs.getInt("office_no"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
	public void insert(OfficeDto officeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into office "
				+ "values(office_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,0 ,?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, officeDto.getHouse_no());
		ps.setInt(2, officeDto.getMember_no());
		ps.setInt(3, officeDto.getBroker_no());
		ps.setInt(4, officeDto.getDeposit());
		ps.setInt(5, officeDto.getMonthly());
		ps.setString(6, officeDto.getAddress());
		ps.setString(7, officeDto.getAddress2());
		ps.setString(8, officeDto.getFloor());
		ps.setString(9, officeDto.getLoan());
		ps.setString(10, officeDto.getAnimal());
		ps.setString(11, officeDto.getElevator());
		ps.setString(12, officeDto.getParking());
		ps.setString(13, officeDto.getMove_in());
		ps.setString(14, officeDto.getEtc());
		ps.setString(15, officeDto.getArea());
		ps.setInt(16, officeDto.getBill());
		ps.setString(17, officeDto.getDirection());
		ps.setString(18, officeDto.getTitle());
		
		
		
		ps.execute();
		
		con.close();
		
	}	
}
