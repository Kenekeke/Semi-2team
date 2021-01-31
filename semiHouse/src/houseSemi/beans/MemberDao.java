package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	public void write(MemberDto dto)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into Member("
					+ "values(member_seq.nextval, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ps.setString(3, dto.getMember_nick());
		ps.setString(4, dto.getMember_email());
		ps.setString(5, dto.getMember_phone());
		ps.setString(6, dto.getMember_auth());
		ps.execute();

		con.close();
	}
	public boolean login(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_id=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ResultSet rs = ps.executeQuery();
		
		boolean result = rs.next();

		con.close();
		return result;
	}
	public boolean pwlogin(int member_no, String member_pw) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,member_no);
		ps.setString(2,member_pw);
		ResultSet rs = ps.executeQuery();
		
		boolean result = rs.next();

		con.close();
		return result;
	}
	public MemberDto find(String member_id) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_id);
		ResultSet rs = ps.executeQuery();
		MemberDto dto;
		if(rs.next()) {
			dto = new MemberDto();
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_nick(rs.getString("member_nick"));
			dto.setMember_email(rs.getString("member_email"));
			dto.setMember_phone(rs.getString("member_phone"));
			dto.setMember_auth(rs.getString("member_auth"));
		}
			else {
				dto = null;
		}
		
		con.close();
		return dto;		
	}
	public boolean editPassword(int member_no, String member_pw, String change_pw) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member set member_pw=? where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, change_pw);
		ps.setInt(2, member_no);
		ps.setString(3, member_pw);
		int count = ps.executeUpdate();
		
		con.close();
		 
		return count > 0; 
	}
	public boolean edit(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member "
						+ "set member_nick=?, member_email=?, member_phone=?"
						+ "where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_nick());
		ps.setString(2, dto.getMember_email());
		ps.setString(3, dto.getMember_phone()); 
		ps.setInt(4, dto.getMember_no());
		ps.setString(5, dto.getMember_pw());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	public boolean delete(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete member where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	public List<MemberDto> select(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" + 
						"select rownum rn, TMP.* from(" +
							"select * from member order by member_no asc"+
						")TMP" + 
					 ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<MemberDto> list = new ArrayList<>();
		while(rs.next()) {
			MemberDto dto = new MemberDto();
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_nick(rs.getString("member_nick"));
			dto.setMember_auth(rs.getString("member_auth"));

			
			list.add(dto);
		}
		
		con.close();
		
		return list;
	}
	public List<MemberDto> select(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from(" + 
						"select rownum rn, TMP.* from(" +
							"select * from member "
							+ "where instr(#1, ?) > 0"
							+ "order by member_no asc"+
						")TMP" + 
					 ") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<MemberDto> list = new ArrayList<>();
		while(rs.next()) {
			MemberDto dto = new MemberDto();
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_nick(rs.getString("member_nick"));
			dto.setMember_auth(rs.getString("member_auth"));
			dto.setMember_email(rs.getString("member_email"));
			dto.setMember_phone(rs.getString("member_phone"));
			
			list.add(dto);
		}
		
		con.close();
		
		return list;
	}
	public int getCount(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from member where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();
		
		return count;
	}
	
//	목록 개수를 구하는 메소드
	public int getCount() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select count(*) from member";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();
		
		return count;
	}
	public boolean editByAdmin(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member set member_auth=? where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_auth());
		ps.setInt(2, dto.getMember_no());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
//	시퀀스 번호를 미리 생성하는 기능
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "Select member_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int m_seq = rs.getInt(1);
		
		con.close();
		return m_seq;
	}
	
//	번호까지 함께 등록하는 기능 -> 회원번호 겹침방지
	public void insert(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getMember_no());
		ps.setString(2, dto.getMember_id());
		ps.setString(3, dto.getMember_pw());
		ps.setString(4, dto.getMember_nick());
		ps.setString(5, dto.getMember_email());
		ps.setString(6, dto.getMember_phone());
		ps.setString(7, dto.getMember_auth());
		ps.execute();
		
		con.close();
	}
	public boolean editPasswordByAdmin(int member_no, String member_pw) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member set member_pw=? where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_pw);
		ps.setInt(2, member_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
}
