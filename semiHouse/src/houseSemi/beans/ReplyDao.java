package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class ReplyDao {
	public static final String USERNAME = "house";
	public static final String PASSWORD = "house";
	//댓글등록
	public void insert(ReplyDto replyDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into reply values(reply_seq.nextval,?,?,?,sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, replyDto.getBoard_no());
		ps.setInt(2, replyDto.getMember_no());
		ps.setString(3, replyDto.getReply_content());
		ps.execute();
		con.close();
	}
	//댓글보기
	public List<ReplyDto> List(int board_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from reply where board_no=? order by reply_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		List<ReplyDto> replylist = new ArrayList<>();
		while(rs.next()) {
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReply_no(rs.getInt("reply_no"));
			replyDto.setBoard_no(rs.getInt("board_no"));
			replyDto.setMember_no(rs.getInt("member_no"));
			replyDto.setReply_content(rs.getString("reply_content"));
			replyDto.setReply_time(rs.getDate("reply_time"));
			replylist.add(replyDto);
		}
		con.close();
		return replylist;
	}
	//댓글삭제
	public void delete(int reply_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "delete reply where reply_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reply_no);
		ps.execute();
		con.close();
	}
}
