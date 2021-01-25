package houseSemi.beans;

import java.sql.Date;

public class VillatwoDto {
	private int villaTwo_no;
	private int house_no;
	private int member_no;
	private int broker_no;
	private int deposit;
	private int monthly;
	private String address;
	private String address2;
	private String floor;
	private String loan;
	private String animal;
	private String elevator;
	private String parking;
	private String move_in;
	private String etc;
	private String area;
	private String broker_agree;
	private int bill;
	private String direction;
	private String title;
	
	public int getVillaTwo_no() {
		return villaTwo_no;
	}
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
	public int getDeposit() {
		return deposit;
	}
	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}
	public int getMonthly() {
		return monthly;
	}
	public void setMonthly(int monthly) {
		this.monthly = monthly;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public String getLoan() {
		return loan;
	}
	public void setLoan(String loan) {
		this.loan = loan;
	}
	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public String getElevator() {
		return elevator;
	}
	public void setElevator(String elevator) {
		this.elevator = elevator;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public String getMove_in() {
		return move_in;
	}
	public void setMove_in(String move_in) {
		this.move_in = move_in;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getBroker_agree() {
		return broker_agree;
	}
	public void setBroker_agree(String broker_agree) {
		this.broker_agree = broker_agree;
	}
	public int getBill() {
		return bill;
	}
	public void setBill(int bill) {
		this.bill = bill;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setVillaTwo_no(int villaTwo_no) {
		this.villaTwo_no = villaTwo_no;
	}
	//객체 검사
	public boolean isFloor (String floor) {
		return this.floor != null && this.floor.equals(floor);
	}
	public boolean isDirection (String direction) {
		return this.direction != null && this.direction.equals(direction);
	}
	public boolean isLoan (String loan) {
		return this.loan != null && this.loan.equals(loan);
	}
	public boolean isAnimal (String animal) {
		return this.animal != null && this.animal.equals(animal);
	}
	public boolean isElevator (String elevator) {
		return this.elevator != null && this.elevator.equals(elevator);
	}
	public boolean isParking (String parking) {
		return this.parking != null && this.parking.equals(parking);
	}
}
