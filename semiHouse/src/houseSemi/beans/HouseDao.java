package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import houseSemi.util.*;

public class HouseDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	public HouseDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select * from House where house_no=?";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs = ps.executeQuery();
		HouseDto dto;
		if(rs.next()) {
			dto= new HouseDto();
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setHouse_type(rs.getString("house_type"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setInsert_date(rs.getDate("insert_date"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
}
