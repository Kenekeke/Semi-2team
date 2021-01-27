package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.*;

public class LikesDao {
	String USERNAME="house";
	String PASSWORD="house";
	public List<LikesDto> select(int member_no) throws Exception{
		Connection con=JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select * from likes where member_no=? order by likes_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs= ps.executeQuery();
		List<LikesDto> list = new ArrayList<>(); 
		
		while(rs.next()) {
			LikesDto dto=new LikesDto();
			dto.setLikes_no(rs.getInt("likes_no"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setMember_no(rs.getInt("member_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
	public boolean check(int house_no) throws Exception {
		Connection con=JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select * from likes where house_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		boolean result = rs.next();
		con.close();
		return result;
	}
	public boolean delete(int house_no) throws Exception {
		Connection con=JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="delete likes where house_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		int count =ps.executeUpdate();
		con.close();
		return count>0;
	}
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select likes_seq.nextval next from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int sequence = rs.getInt(1);
		con.close();
		return sequence;
	}
	public boolean add(LikesDto dto) throws Exception {
		Connection con=JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="insert into likes values(?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1,dto.getLikes_no());
		ps.setInt(2, dto.getHouse_no());
		ps.setInt(3, dto.getMember_no());
		ps.setInt(4, dto.getBroker_no());
		int count =ps.executeUpdate();
		con.close();
		return count>0;
	}
}
