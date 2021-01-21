package houseSemi.beans;

public class SearchDto {
	private int search_no;
	private String name;
	private String address;
	private double lat;
	private double lng;
	public int getSearch_no() {
		return search_no;
	}
	public void setSearch_no(int search_no) {
		this.search_no = search_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	
}
