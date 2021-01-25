package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class SearchDao {
	String USERNAME="house";
	String PASSWORD="house";
	public List<SearchDto> select(String keyword) throws Exception{
		Connection con=JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select * from search where instr(name,?) > 0 or instr(address,?) > 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setString(2, keyword);
		ResultSet rs= ps.executeQuery();
		List<SearchDto> list= new ArrayList<>();
		while(rs.next()) {
			SearchDto dto = new SearchDto();
			dto.setAddress(rs.getString("address"));
			dto.setLat(rs.getDouble("lat"));
			dto.setLng(rs.getDouble("lng"));
			dto.setName(rs.getString("name"));
			dto.setSearch_no(rs.getInt("search_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
}
