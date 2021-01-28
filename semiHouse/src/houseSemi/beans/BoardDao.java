package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class BoardDao {
	public static final String USERNAME = "house";
	public static final String PASSWORD = "house";
	
	public void delete(int board_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "delete board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();
		con.close();
	}
	public BoardDto find(int board_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		BoardDto boardDto = new BoardDto();
		if(rs.next()) {
			boardDto.setBoard_no(rs.getInt("board_no"));
			boardDto.setMember_no(rs.getInt("member_no"));
			boardDto.setBoard_header(rs.getString("board_header"));
			boardDto.setBoard_title(rs.getString("board_title"));
			boardDto.setBoard_content(rs.getString("board_content"));
			boardDto.setBoard_count(rs.getInt("board_count"));
			boardDto.setBoard_time(rs.getDate("board_time"));
		}
		else {
			boardDto = null;
		}
		con.close();
		return boardDto;
	}
	public void update(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql ="update board set board_title=?, board_header=?, board_content=? where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoard_title());
		ps.setString(2, boardDto.getBoard_header());
		ps.setString(3, boardDto.getBoard_content());
		ps.setInt(4, boardDto.getBoard_no());
		ps.execute();
		con.close();
	}
	
	//게시물 상세정보
	public BoardVO detail(int board_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select B.board_no, B.member_no, B.board_header, B.board_title, "
				+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
				+ "from(board B left outer join reply R on B.board_no = R.board_no "
				+ "inner join member M on B.member_no = M.member_no) "
				+ "where B.board_no=? "
				+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ResultSet rs = ps.executeQuery();
		BoardVO vo = new BoardVO();
		if(rs.next()) {
			vo.setBoard_no(rs.getInt("board_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBoard_header(rs.getString("board_header"));
			vo.setBoard_title(rs.getString("board_title"));
			vo.setBoard_content(rs.getString("board_content"));
			vo.setBoard_count(rs.getInt("board_count"));
			vo.setBoard_time(rs.getDate("board_time"));
			vo.setReplycount(rs.getInt("replycount"));
			vo.setMember_nick(rs.getString("member_nick"));
		}
		else {
			vo = null;
		}
		con.close();
		return vo;
	}
	
	//목록
	public List<BoardVO> List(int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(select rownum rn, T.* from("
				+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
				+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
				+ "from(board B left outer join reply R on B.board_no = R.board_no "
				+ "inner join member M on B.member_no = M.member_no) "
				+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
				+ "order by B.board_no desc) T) where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		List<BoardVO> boardlist = new ArrayList<>();
		while(rs.next()) {
			BoardVO VO = new BoardVO();
			VO.setBoard_no(rs.getInt("board_no"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setBoard_header(rs.getString("board_header"));
			VO.setBoard_title(rs.getString("board_title"));
			VO.setBoard_content(rs.getString("board_content"));
			VO.setBoard_count(rs.getInt("board_count"));
			VO.setBoard_time(rs.getDate("board_time"));
			VO.setReplycount(rs.getInt("replycount"));
			VO.setMember_nick(rs.getString("member_nick"));
			boardlist.add(VO);
		}
		con.close();
		return boardlist;
	}
	
	//헤더
	public List<BoardVO> List(String header, int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(select rownum rn, T.* from("
				+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
				+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
				+ "from(board B left outer join reply R on B.board_no = R.board_no "
				+ "inner join member M on B.member_no = M.member_no) "
				+ "where board_header=? "
				+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
				+ "order by B.board_no desc) T) where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, header);
		ps.setInt(2, start);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		List<BoardVO> boardlist = new ArrayList<>();
		while(rs.next()) {
			BoardVO VO = new BoardVO();
			VO.setBoard_no(rs.getInt("board_no"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setBoard_header(rs.getString("board_header"));
			VO.setBoard_title(rs.getString("board_title"));
			VO.setBoard_content(rs.getString("board_content"));
			VO.setBoard_count(rs.getInt("board_count"));
			VO.setBoard_time(rs.getDate("board_time"));
			VO.setReplycount(rs.getInt("replycount"));
			VO.setMember_nick(rs.getString("member_nick"));
			boardlist.add(VO);
		}
		con.close();
		return boardlist;
	}
	
	//검색까지
	public List<BoardVO> List(String type, String key, int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql;
		PreparedStatement ps;
		if(type.equals("board_title_content")) {
			sql = "select * from(select rownum rn, T.* from("
					+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
					+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
					+ "from(board B left outer join reply R on B.board_no = R.board_no "
					+ "inner join member M on B.member_no = M.member_no) "
					+ "where instr(board_title,?) > 0 or instr(board_content,?) > 0 "
					+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
					+ "order by B.board_no desc) T) where rn between ? and ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, key);
			ps.setString(2, key);
			ps.setInt(3, start);
			ps.setInt(4, end);
		}
		else {
			sql = "select * from(select rownum rn, T.* from("
					+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
					+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
					+ "from(board B left outer join reply R on B.board_no = R.board_no "
					+ "inner join member M on B.member_no = M.member_no) "
					+ "where instr(#1,?) > 0 "
					+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
					+ "order by B.board_no desc) T) where rn between ? and ?";
			sql = sql.replace("#1", type);
			ps = con.prepareStatement(sql);
			ps.setString(1, key);
			ps.setInt(2, start);
			ps.setInt(3, end);
		}
		ResultSet rs = ps.executeQuery();
		List<BoardVO> boardlist = new ArrayList<>();
		while(rs.next()) {
			BoardVO VO = new BoardVO();
			VO.setBoard_no(rs.getInt("board_no"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setBoard_header(rs.getString("board_header"));
			VO.setBoard_title(rs.getString("board_title"));
			VO.setBoard_content(rs.getString("board_content"));
			VO.setBoard_count(rs.getInt("board_count"));
			VO.setBoard_time(rs.getDate("board_time"));
			VO.setReplycount(rs.getInt("replycount"));
			VO.setMember_nick(rs.getString("member_nick"));
			boardlist.add(VO);
		}
		con.close();
		return boardlist;
	}
	//헤더&검색
	public List<BoardVO> List(String header,String type, String key, int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql;
		PreparedStatement ps;
		if(type.equals("board_title_content")) {
			sql = "select * from(select rownum rn, T.* from("
					+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
					+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
					+ "from(board B left outer join reply R on B.board_no = R.board_no "
					+ "inner join member M on B.member_no = M.member_no) "
					+ "where board_header=? and (instr(board_title,?) > 0 or instr(board_content,?) > 0) "
					+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
					+ "order by B.board_no desc) T) where rn between ? and ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, header);
			ps.setString(2, key);
			ps.setString(3, key);
			ps.setInt(4, start);
			ps.setInt(5, end);
		}
		else {
			sql = "select * from(select rownum rn, T.* from("
					+ "select B.board_no, B.member_no, B.board_header, B.board_title, "
					+ "B.board_content, B.board_count, B.board_time, count(R.reply_no) replycount, M.member_nick "
					+ "from(board B left outer join reply R on B.board_no = R.board_no "
					+ "inner join member M on B.member_no = M.member_no) "
					+ "where board_header=? and instr(#1,?) > 0 "
					+ "group by B.board_no, B.member_no, B.board_header, B.board_title, B.board_content, B.board_count, B.board_time, M.member_nick "
					+ "order by B.board_no desc) T) where rn between ? and ?";
			sql = sql.replace("#1", type);
			ps = con.prepareStatement(sql);
			ps.setString(1, header);
			ps.setString(2, key);
			ps.setInt(3, start);
			ps.setInt(4, end);
		}
		ResultSet rs = ps.executeQuery();
		List<BoardVO> boardlist = new ArrayList<>();
		while(rs.next()) {
			BoardVO VO = new BoardVO();
			VO.setBoard_no(rs.getInt("board_no"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setBoard_header(rs.getString("board_header"));
			VO.setBoard_title(rs.getString("board_title"));
			VO.setBoard_content(rs.getString("board_content"));
			VO.setBoard_count(rs.getInt("board_count"));
			VO.setBoard_time(rs.getDate("board_time"));
			VO.setReplycount(rs.getInt("replycount"));
			VO.setMember_nick(rs.getString("member_nick"));
			boardlist.add(VO);
		}
		con.close();
		return boardlist;
	}
	
	//게시물 총 개수
	public int count() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) count from board";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt("count");
	}
	//헤더
	public int count(String header) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) count from board where board_header=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, header);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt("count");
	}
	//검색일때
	public int count(String type, String key) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql;
		PreparedStatement ps;
		if(type.equals("board_title_content")) {
			sql = "select count(*) count from board where instr(board_title,?)>0 or instr(board_content,?)>0";
			ps = con.prepareStatement(sql);
			ps.setString(1, key);
			ps.setString(2, key);
		}
		else {
			sql = "select count(*) count from (board B inner join member M on B.member_no = M.member_no) where instr(#1,?)>0";
			sql = sql.replace("#1", type);
			ps = con.prepareStatement(sql);
			ps.setString(1, key);
		}
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt("count");
	}
	//헤더+검색
	public int count(String header, String type, String key) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql;
		PreparedStatement ps;
		if(type.equals("board_title_content")) {
			sql = "select count(*) count from board where board_header=? and (instr(board_title,?)>0 or instr(board_content,?)>0)";
			ps = con.prepareStatement(sql);
			ps.setString(1, header);
			ps.setString(2, key);
			ps.setString(3, key);
		}
		else {
			sql = "select count(*) count from (board B inner join member M on B.member_no = M.member_no) where board_header=? and instr(#1,?)>0";
			sql = sql.replace("#1", type);
			ps = con.prepareStatement(sql);
			ps.setString(1, header);
			ps.setString(2, key);
		}
		ResultSet rs = ps.executeQuery();
		rs.next();
		return rs.getInt("count");
	}
	
	//시퀀스얻어오기
	public int getSequence() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select board_seq.nextval next from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int sequence = rs.getInt("next");
		con.close();
		return sequence;
	}
	//등록
	public void insert(BoardDto boardDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into board values(?,?,?,?,?,0,sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardDto.getBoard_no());
		ps.setInt(2, boardDto.getMember_no());
		ps.setString(3, boardDto.getBoard_header());
		ps.setString(4, boardDto.getBoard_title());
		ps.setString(5, boardDto.getBoard_content());
		ps.execute();
		con.close();
	}
	public void plusCount(int board_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update board set board_count=board_count+1 where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, board_no);
		ps.execute();
		con.close();
	}
	
	public List<BoardDto> indexselect(int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql ="select * from (" + 
				" select rownum rn, TMP.* from (" + 
				" select board_title,board_no from board where board_header ='공지사항' order by board_no asc" + 
				" )TMP" + 
				" ) where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		List<BoardDto> boardlist = new ArrayList<>();
		while(rs.next()) {
			BoardDto dto = new BoardDto();
			dto.setBoard_no(rs.getInt("board_no"));
			dto.setBoard_title(rs.getString("board_title"));
			boardlist.add(dto);
		}
		con.close();
		return boardlist;
	}
}
