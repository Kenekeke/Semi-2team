package houseSemi.beans;

public class BrokerDto {
	private int broker_no;
	private String broker_address;
	private String broker_name;
	private String broker_landline;
	public BrokerDto() {
		super();
	}
	public int getBroker_no() {
		return broker_no;
	}
	public void setBroker_no(int broker_no) {
		this.broker_no = broker_no;
	}
	public String getBroker_address() {
		return broker_address;
	}
	public void setBroker_address(String broker_address) {
		this.broker_address = broker_address;
	}
	public String getBroker_name() {
		return broker_name;
	}
	public void setBroker_name(String broker_name) {
		this.broker_name = broker_name;
	}
	public String getBroker_landline() {
		return broker_landline;
	}
	public void setBroker_landline(String broker_landline) {
		this.broker_landline = broker_landline;
	}
	
}
