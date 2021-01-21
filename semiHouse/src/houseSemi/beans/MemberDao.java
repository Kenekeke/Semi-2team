package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import houseSemi.util.JdbcUtil;

public class MemberDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	public MemberDto find(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql="select * from member where member_no=?";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs= ps.executeQuery();
		
		MemberDto dto;
		if(rs.next()) {
			dto=new MemberDto();
			dto.setMember_no(rs.getInt("member_no"));;
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_nick(rs.getString("member_nick"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_email(rs.getString("member_email"));
			dto.setMember_auth(rs.getString("member_auth"));
			dto.setMember_phone(rs.getString("member_phone"));
		}
		else {
			dto=null;
		}
		return dto;
	}
}
