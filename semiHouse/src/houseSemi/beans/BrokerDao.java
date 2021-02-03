package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import houseSemi.util.JdbcUtil;
import houseSemi.beans.BrokerDto;

public class BrokerDao {
	public static final String USERNAME = "kh42";
	public static final String PASSWORD = "kh42";

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
	public BrokerDto find(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		 
		String sql = "select * from broker where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		BrokerDto dto; 
		if(rs.next()) {
			dto = new BrokerDto();
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setBroker_address(rs.getString("broker_address"));
			dto.setBroker_address2(rs.getString("broker_address2"));
			dto.setBroker_name(rs.getString("broker_name"));
			dto.setBroker_landline(rs.getString("broker_landline"));
		}
		else {
			dto = null;
		}
		con.close();
		return dto;		
	}
	public boolean edit(BrokerDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update broker "
						+ "set broker_address=?, broker_address2=? broker_name=?, broker_landline=?" 
						+ "where broker_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getBroker_address());
		ps.setString(2, dto.getBroker_address2());
		ps.setString(3, dto.getBroker_name());
		ps.setString(4, dto.getBroker_landline()); 
		ps.setInt(5, dto.getBroker_no());

		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public BrokerMemberVO select(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql= "select * from broker B inner join member M on M.member_no = B.member_no where B.member_no = ?";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		BrokerMemberVO vo;
		if(rs.next()) {
			vo = new BrokerMemberVO();
			vo.setMember_no(rs.getInt("member_no"));
			vo.setMember_id(rs.getString("member_id"));
			vo.setMember_pw(rs.getString("member_pw"));
			vo.setMember_nick(rs.getString("member_nick"));
			vo.setMember_email(rs.getString("member_email"));
			vo.setMember_phone(rs.getString("member_phone"));
			vo.setMember_auth(rs.getString("member_auth"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setBroker_address(rs.getString("broker_address"));
			vo.setBroker_address2(rs.getString("broker_address2"));
			vo.setBroker_name(rs.getString("broker_name"));
			vo.setBroker_landline(rs.getString("broker_landline"));						
		}
		else {
			vo = null; 
		}
		con.close();
		return vo;
	}
	public boolean edit(BrokerMemberVO vo) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update broker "
						+ "set broker_name=?, broker_address=?, broker_address2=?, broker_landline=?"
						+ "where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, vo.getBroker_name());
		ps.setString(2, vo.getBroker_address());
		ps.setString(3, vo.getBroker_address2());
		ps.setString(4, vo.getBroker_landline());
		ps.setInt(5, vo.getMember_no());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
		public int getSequence() throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "Select broker_seq.nextval from dual";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int b_seq = rs.getInt(1);
			
			con.close();
			return b_seq;
		}
		
		public void insert(BrokerDto dto) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "insert into broker values(?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getBroker_no());
			ps.setInt(2, dto.getMember_no());
			ps.setString(3, dto.getBroker_name());
			ps.setString(4, dto.getBroker_address());
			ps.setString(5, dto.getBroker_address2());
			ps.setString(6, dto.getBroker_landline());
			ps.execute();
			
			con.close();
		}
}

