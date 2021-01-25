package houseSemi.beans;

public class LikesDto {
	private int Likes_no;
	private int house_no;
	private int broker_no;
	private int member_no;
	
	
	public int getLikes_no() {
		return Likes_no;
	}
	public void setLikes_no(int likes_no) {
		Likes_no = likes_no;
	}
	public int getHouse_no() {
		return house_no;
	}
	public void setHouse_no(int house_no) {
		this.house_no = house_no;
	}
	public int getBroker_no() {
		return broker_no;
	}
	public void setBroker_no(int broker_no) {
		this.broker_no = broker_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	
}
