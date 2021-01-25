package houseSemi.beans;

import java.sql.Date;

public class HouseDto {
	private int house_no;
	private int member_no;
	private int broker_no;
	private String house_type;
	private Date insert_date;
	public int getHouse_no() {
		return house_no;
	}
	public void setHouse_no(int house_no) {
		this.house_no = house_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getBroker_no() {
		return broker_no;
	}
	public void setBroker_no(int broker_no) {
		this.broker_no = broker_no;
	}
	public String getHouse_type() {
		return house_type;
	}
	public void setHouse_type(String house_type) {
		this.house_type = house_type;
	}
	public Date getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(Date insert_date) {
		this.insert_date = insert_date;
	}
	
}
