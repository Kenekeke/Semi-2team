package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class PhotoDao {
	public static final String USERNAME = "house";
	public static final String PASSWORD = "house";
	
	public void insert(PhotoDto photoDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into photo values(photo_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, photoDto.getHouse_no());
		ps.setString(2, photoDto.getUpload_name());
		ps.setString(3, photoDto.getSave_name());
		ps.setString(4, photoDto.getPhoto_type());
		ps.setLong(5, photoDto.getPhoto_size());
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "delete photo where house_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, house_no);
		int count = ps.executeUpdate();
		
		con.close();
		return count >0;
	}
	
	//단일 조회
	public PhotoDto find(int house_no, int photo_no)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from photo where house_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		
		ResultSet rs = ps.executeQuery();
		PhotoDto dto;
		if(rs.next()) {
			dto = new PhotoDto();
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setUpload_name(rs.getString("upload_name"));
			dto.setSave_name(rs.getString("save_name"));
			dto.setPhoto_size(rs.getLong("photo_size"));
			dto.setPhoto_type(rs.getString("photo_type"));
			
		}else {
			dto = null;
		}
		con.close();
		return dto;
		
	}
	
	public List<PhotoDto> select(int house_no)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from photo where house_no=? order by photo_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		
		ResultSet rs = ps.executeQuery();
		List<PhotoDto> photoList = new ArrayList<PhotoDto>();
		while(rs.next()) {
			PhotoDto photoDto = new PhotoDto();
			photoDto.setUpload_name(rs.getString("upload_name"));
			photoDto.setSave_name(rs.getString("save_name"));
			photoDto.setPhoto_size(rs.getLong("photo_size"));
			photoDto.setPhoto_type(rs.getString("photo_type"));
			photoList.add(photoDto);
		}
		con.close();
		return photoList;
	}
}
