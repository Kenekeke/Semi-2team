package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

import houseSemi.util.JdbcUtil;

public class BoardDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	public BoardDto find(int board_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs= ps.executeQuery();
		BoardDto dto;
		if(rs.next()) {
			dto=new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_title(rs.getString("board_title"));
			dto.setBoard_header(rs.getString("board_header"));
			dto.setBoard_content(rs.getString("board_content"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setBoard_count(rs.getInt("board_count"));
			dto.setBoard_time(rs.getDate("board_time"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
	public boolean update(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql ="update board set board_title=?, board_header=?, board_content=? where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoard_title());
		ps.setString(2, boardDto.getBoard_header());
		ps.setString(3, boardDto.getBoard_content());
		ps.setInt(4, boardDto.getBoard_no());
		int result =ps.executeUpdate();
		con.close();
		return result>0;
	}
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int seq=rs.getInt(1);
		con.close();
		return seq;
	}
	public void writeWithPrimaryKey(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into board values(?, ?, ?, ?, ?, 0, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardDto.getBoard_no());
		ps.setInt(2, boardDto.getMember_no());
		ps.setString(3, boardDto.getBoard_header());
		ps.setString(4, boardDto.getBoard_title());
		ps.setString(5, boardDto.getBoard_content());
		ps.execute();
		con.close();
	}
	
}
