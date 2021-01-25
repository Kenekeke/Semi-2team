package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.tomcat.dbcp.dbcp2.Jdbc41Bridge;

import houseSemi.util.JdbcUtil;

public class BrokerDao {
	public static final String USERNAME = "house";
	public static final String PASSWORD = "house";

	public BrokerDto find(String city) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from broker where instr(broker_address, ?)>0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, city);
		ResultSet rs = ps.executeQuery();
		BrokerDto dto;
		if(rs.next()) {
			dto = new BrokerDto();
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setBroker_address(rs.getString("broker_address"));
		}else {
			dto = null;
		}
		con.close();
		return dto;
	}
}
