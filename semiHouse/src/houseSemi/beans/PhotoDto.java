package houseSemi.beans;

public class PhotoDto {
	private int photo_no;
	private int house_no;
	private String upload_name;
	private String save_name;
	private String photo_type;
	private long photo_size;
	
	public PhotoDto() {
		super();
	}
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public int getHouse_no() {
		return house_no;
	}
	public void setHouse_no(int house_no) {
		this.house_no = house_no;
	}
	public String getUpload_name() {
		return upload_name;
	}
	public void setUpload_name(String upload_name) {
		this.upload_name = upload_name;
	}
	public String getSave_name() {
		return save_name;
	}
	public void setSave_name(String save_name) {
		this.save_name = save_name;
	}
	public String getPhoto_type() {
		return photo_type;
	}
	public void setPhoto_type(String photo_type) {
		this.photo_type = photo_type;
	}
	public long getPhoto_size() {
		return photo_size;
	}
	public void setPhoto_size(long photo_size) {
		this.photo_size = photo_size;
	}
	
	
	
}


