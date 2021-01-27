package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class OfficeDao {
	public static final String USERNAME="house";
	public static final String PASSWORD="house";
	public OfficeDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from office where house_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		OfficeDto dto;
		if(rs.next()) {
			dto = new OfficeDto();
			dto.setBroker_agree(rs.getString("broker_agree"));
			dto.setAnimal(rs.getString("animal"));
			dto.setBroker_no(rs.getInt("broker_no"));
			dto.setElevator(rs.getString("elevator"));
			dto.setEtc(rs.getString("etc"));
			dto.setFloor(rs.getString("floor"));
			dto.setHouse_no(rs.getInt("house_no"));
			dto.setLoan(rs.getString("loan"));
			dto.setMember_no(rs.getInt("member_no"));
			dto.setMove_in(rs.getString("move_in"));
			dto.setParking(rs.getString("parking"));
			dto.setAddress(rs.getString("address"));
			dto.setAddress2(rs.getString("address2"));
			dto.setArea(rs.getString("area"));
			dto.setDeposit(rs.getInt("deposit"));
			dto.setMonthly(rs.getInt("monthly"));
			dto.setTitle(rs.getString("title"));
			dto.setBill(rs.getInt("bill"));
			dto.setDirection(rs.getString("direction"));
			dto.setOffice_no(rs.getInt("office_no"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
	public void insert(OfficeDto officeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into office "
				+ "values(office_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,0 ,?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, officeDto.getHouse_no());
		ps.setInt(2, officeDto.getMember_no());
		ps.setInt(3, officeDto.getBroker_no());
		ps.setInt(4, officeDto.getDeposit());
		ps.setInt(5, officeDto.getMonthly());
		ps.setString(6, officeDto.getAddress());
		ps.setString(7, officeDto.getAddress2());
		ps.setString(8, officeDto.getFloor());
		ps.setString(9, officeDto.getLoan());
		ps.setString(10, officeDto.getAnimal());
		ps.setString(11, officeDto.getElevator());
		ps.setString(12, officeDto.getParking());
		ps.setString(13, officeDto.getMove_in());
		ps.setString(14, officeDto.getEtc());
		ps.setString(15, officeDto.getArea());
		ps.setInt(16, officeDto.getBill());
		ps.setString(17, officeDto.getDirection());
		ps.setString(18, officeDto.getTitle());
		
		
		
		ps.execute();
		
		con.close();
		
	}
	public List<OfficeDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from office";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<OfficeDto> officelist = new ArrayList<>();
		while(rs.next()) {
			OfficeDto officeDto = new OfficeDto();
			officeDto.setOffice_no(rs.getInt("office_no"));
			officeDto.setDeposit(rs.getInt("deposit"));
			officeDto.setMonthly(rs.getInt("monthly"));
			officeDto.setAddress(rs.getString("address"));
			officeDto.setFloor(rs.getString("floor"));
			officeDto.setLoan(rs.getString("loan"));
			officeDto.setAnimal(rs.getString("animal"));
			officeDto.setElevator(rs.getString("elevator"));
			officeDto.setParking(rs.getString("parking"));
			officeDto.setHouse_no(rs.getInt("house_no"));
			officeDto.setAddress2(rs.getString("address2"));
			officeDto.setMove_in(rs.getString("move_in"));
			officeDto.setEtc(rs.getString("etc"));
			officeDto.setBroker_agree(rs.getString("broker_agree"));
			officeDto.setArea(rs.getString("area"));
			officeDto.setBill(rs.getInt("bill"));
			officeDto.setDirection(rs.getString("direction"));
			officeDto.setTitle(rs.getString("title"));
			officelist.add(officeDto);
		}
		con.close();
		return officelist;
	}
	public List<OfficeDto> onSelect() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from office where broker_agree='1'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<OfficeDto> officelist = new ArrayList<>();
		while(rs.next()) {
			OfficeDto officeDto = new OfficeDto();
			officeDto.setOffice_no(rs.getInt("office_no"));
			officeDto.setDeposit(rs.getInt("deposit"));
			officeDto.setMonthly(rs.getInt("monthly"));
			officeDto.setAddress(rs.getString("address"));
			officeDto.setFloor(rs.getString("floor"));
			officeDto.setLoan(rs.getString("loan"));
			officeDto.setAnimal(rs.getString("animal"));
			officeDto.setElevator(rs.getString("elevator"));
			officeDto.setParking(rs.getString("parking"));
			officeDto.setHouse_no(rs.getInt("house_no"));
			officeDto.setAddress2(rs.getString("address2"));
			officeDto.setMove_in(rs.getString("move_in"));
			officeDto.setEtc(rs.getString("etc"));
			officeDto.setBroker_agree(rs.getString("broker_agree"));
			officeDto.setArea(rs.getString("area"));
			officeDto.setBill(rs.getInt("bill"));
			officeDto.setDirection(rs.getString("direction"));
			officeDto.setTitle(rs.getString("title"));
			officelist.add(officeDto);
		}
		con.close();
		return officelist;
	}
	
	
	public List<OfficeDto> select(FilteringVO officeVO) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String floor1,floor2,floor3;
		if(officeVO.getFloor1().equals("N")&&officeVO.getFloor2().equals("N")&&officeVO.getFloor3().equals("N")) {
			floor1 = "반지하";
			floor2 = "층";
			floor3 = "옥탑방";
		}
		else if(officeVO.getFloor2().equals("지상층")) {
			floor1 = officeVO.getFloor1();
			floor2 = "층";
			floor3 = officeVO.getFloor3();
		}
		else {
			floor1 = officeVO.getFloor1();
			floor2 = officeVO.getFloor2();
			floor3 = officeVO.getFloor3();
		}
		String sql;
		PreparedStatement ps;
		// 월세만
		if(officeVO.getCharter_min().equals("N")) {
			if(officeVO.getDeposit_min().equals("0")&&officeVO.getDeposit_max().equals("max")) {
				if(officeVO.getMonthly_min().equals("0")&&officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>0 and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setString(1, floor1);
					ps.setString(2, floor3);
					ps.setString(3, floor2);
					ps.setString(4, officeVO.getLoan());
					ps.setString(5, officeVO.getAnimal());
					ps.setString(6, officeVO.getElevator());
					ps.setString(7, officeVO.getParking());
				}
				else if(officeVO.getMonthly_min().equals("0")) {
					sql = "select * from office where deposit>0 and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, officeVO.getLoan());
					ps.setString(6, officeVO.getAnimal());
					ps.setString(7, officeVO.getElevator());
					ps.setString(8, officeVO.getParking());
				}
				else if(officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>0 and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, officeVO.getLoan());
					ps.setString(6, officeVO.getAnimal());
					ps.setString(7, officeVO.getElevator());
					ps.setString(8, officeVO.getParking());
				}
				else {
					sql = "select * from office where deposit>0 and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
			}
			else if(officeVO.getDeposit_min().equals("0")) {
				if(officeVO.getMonthly_min().equals("0")&&officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>0 and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, officeVO.getLoan());
					ps.setString(6, officeVO.getAnimal());
					ps.setString(7, officeVO.getElevator());
					ps.setString(8, officeVO.getParking());
				}
				else if(officeVO.getMonthly_min().equals("0")) {
					sql = "select * from office where deposit>0 and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
				else if(officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>0 and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
				else {
					sql = "select * from office where deposit>0 and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setInt(3, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, officeVO.getLoan());
					ps.setString(8, officeVO.getAnimal());
					ps.setString(9, officeVO.getElevator());
					ps.setString(10, officeVO.getParking());
				}
			}
			else if(officeVO.getDeposit_max().equals("max")) {
				if(officeVO.getMonthly_min().equals("0")&&officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, officeVO.getLoan());
					ps.setString(6, officeVO.getAnimal());
					ps.setString(7, officeVO.getElevator());
					ps.setString(8, officeVO.getParking());
				}
				else if(officeVO.getMonthly_min().equals("0")) {
					sql = "select * from office where deposit>=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
				else if(officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
				else {
					sql = "select * from office where deposit>=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setInt(3, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, officeVO.getLoan());
					ps.setString(8, officeVO.getAnimal());
					ps.setString(9, officeVO.getElevator());
					ps.setString(10, officeVO.getParking());
				}
			}
			else {
				if(officeVO.getMonthly_min().equals("0")&&officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>=? and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, officeVO.getLoan());
					ps.setString(7, officeVO.getAnimal());
					ps.setString(8, officeVO.getElevator());
					ps.setString(9, officeVO.getParking());
				}
				else if(officeVO.getMonthly_min().equals("0")) {
					sql = "select * from office where deposit>=? and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, officeVO.getLoan());
					ps.setString(8, officeVO.getAnimal());
					ps.setString(9, officeVO.getElevator());
					ps.setString(10, officeVO.getParking());
				}
				else if(officeVO.getMonthly_max().equals("max")) {
					sql = "select * from office where deposit>=? and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, officeVO.getLoan());
					ps.setString(8, officeVO.getAnimal());
					ps.setString(9, officeVO.getElevator());
					ps.setString(10, officeVO.getParking());
				}
				else {
					sql = "select * from office where deposit>=? and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(officeVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(officeVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(officeVO.getMonthly_min()));
					ps.setInt(4, Integer.parseInt(officeVO.getMonthly_max()));
					ps.setString(5, floor1);
					ps.setString(6, floor3);
					ps.setString(7, floor2);
					ps.setString(8, officeVO.getLoan());
					ps.setString(9, officeVO.getAnimal());
					ps.setString(10, officeVO.getElevator());
					ps.setString(11, officeVO.getParking());
				}
			}
		}
		//전세만
		else {
			if(officeVO.getCharter_min().equals("0")&&officeVO.getCharter_max().equals("max")) {
				sql = "select * from office where monthly=0 and deposit>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setString(1, floor1);
				ps.setString(2, floor3);
				ps.setString(3, floor2);
				ps.setString(4, officeVO.getLoan());
				ps.setString(5, officeVO.getAnimal());
				ps.setString(6, officeVO.getElevator());
				ps.setString(7, officeVO.getParking());
			}
			else if(officeVO.getCharter_min().equals("0")) {
				sql = "select * from office where monthly=0 and deposit>0 and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(officeVO.getCharter_max()));
				ps.setString(2, floor1);
				ps.setString(3, floor3);
				ps.setString(4, floor2);
				ps.setString(5, officeVO.getLoan());
				ps.setString(6, officeVO.getAnimal());
				ps.setString(7, officeVO.getElevator());
				ps.setString(8, officeVO.getParking());
			}
			else if(officeVO.getCharter_max().equals("max")) {
				sql = "select * from office where monthly=0 and deposit>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(officeVO.getCharter_min()));
				ps.setString(2, floor1);
				ps.setString(3, floor3);
				ps.setString(4, floor2);
				ps.setString(5, officeVO.getLoan());
				ps.setString(6, officeVO.getAnimal());
				ps.setString(7, officeVO.getElevator());
				ps.setString(8, officeVO.getParking());
			}
			else {
				sql = "select * from office where monthly=0 and deposit>=? and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(officeVO.getCharter_min()));
				ps.setInt(2, Integer.parseInt(officeVO.getCharter_max()));
				ps.setString(3, floor1);
				ps.setString(4, floor3);
				ps.setString(5, floor2);
				ps.setString(6, officeVO.getLoan());
				ps.setString(7, officeVO.getAnimal());
				ps.setString(8, officeVO.getElevator());
				ps.setString(9, officeVO.getParking());
			}
		}
		ResultSet rs = ps.executeQuery();
		List<OfficeDto> officelist = new ArrayList<>();
		while(rs.next()) {
			OfficeDto officeDto = new OfficeDto();
			officeDto.setOffice_no(rs.getInt("office_no"));
			officeDto.setDeposit(rs.getInt("deposit"));
			officeDto.setMonthly(rs.getInt("monthly"));
			officeDto.setAddress(rs.getString("address"));
			officeDto.setFloor(rs.getString("floor"));
			officeDto.setLoan(rs.getString("loan"));
			officeDto.setAnimal(rs.getString("animal"));
			officeDto.setElevator(rs.getString("elevator"));
			officeDto.setParking(rs.getString("parking"));
			officeDto.setHouse_no(rs.getInt("house_no"));
			officeDto.setAddress2(rs.getString("address2"));
			officeDto.setMove_in(rs.getString("move_in"));
			officeDto.setEtc(rs.getString("etc"));
			officeDto.setBroker_agree(rs.getString("broker_agree"));
			officeDto.setArea(rs.getString("area"));
			officeDto.setBill(rs.getInt("bill"));
			officeDto.setDirection(rs.getString("direction"));
			officeDto.setTitle(rs.getString("title"));
			officelist.add(officeDto);
		}
		con.close();
		return officelist;
	}

	
	public List<OfficeVO> select(int office_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from(office O inner join photo P on O.house_no = P.house_no " + 
				"inner join broker B on O.broker_no = B.broker_no " + 
				"inner join member M on B.member_no = M.member_no) where office_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, office_no);
		ResultSet rs = ps.executeQuery();
		List<OfficeVO> officelist = new ArrayList<>();
		while(rs.next()) {
			OfficeVO vo = new OfficeVO();
			vo.setOffice_no(rs.getInt("office_no"));
			vo.setHouse_no(rs.getInt("house_no"));
			vo.setMember_no(rs.getInt("member_no"));
			vo.setBroker_no(rs.getInt("broker_no"));
			vo.setDeposit(rs.getInt("deposit"));
			vo.setMonthly(rs.getInt("monthly"));
			vo.setAddress(rs.getString("address"));
			vo.setAddress2(rs.getString("address2"));
			vo.setFloor(rs.getString("floor"));
			vo.setLoan(rs.getString("loan"));
			vo.setAnimal(rs.getString("animal"));
			vo.setElevator(rs.getString("elevator"));
			vo.setParking(rs.getString("parking"));
			vo.setMove_in(rs.getString("move_in"));
			vo.setEtc(rs.getString("etc"));
			vo.setBroker_agree(rs.getString("broker_agree"));
			vo.setArea(rs.getString("area"));
			vo.setBill(rs.getInt("bill"));
			vo.setDirection(rs.getString("direction"));
			vo.setTitle(rs.getString("title"));
			vo.setPhoto_no(rs.getInt("photo_no"));
			vo.setUpload_name(rs.getString("upload_name"));
			vo.setSave_name(rs.getString("save_name"));
			vo.setPhoto_type(rs.getString("photo_type"));
			vo.setBroker_address(rs.getString("broker_address"));
			vo.setBroker_address2(rs.getString("broker_address2"));
			vo.setBroker_name(rs.getString("broker_name"));
			vo.setBroker_landline(rs.getString("broker_landline"));
			vo.setMember_email(rs.getString("member_email"));
			vo.setMember_phone(rs.getString("member_phone"));
			officelist.add(vo);
		}
		con.close();
		return officelist;
	}
	
	public OfficeTypeVO type(int house_no) throws Exception {
		Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select O.*, house_type from (select * from office where house_no=?) O left outer join house H on H.house_no=O.house_no";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		OfficeTypeVO VO;
		if(rs.next()) {
			VO=new OfficeTypeVO();
			VO.setBroker_agree(rs.getString("broker_agree"));
			VO.setAnimal(rs.getString("animal"));
			VO.setBroker_no(rs.getInt("broker_no"));
			VO.setElevator(rs.getString("elevator"));
			VO.setEtc(rs.getString("etc"));
			VO.setFloor(rs.getString("floor"));
			VO.setHouse_no(rs.getInt("house_no"));
			VO.setLoan(rs.getString("loan"));
			VO.setMember_no(rs.getInt("member_no"));
			VO.setMove_in(rs.getString("move_in"));
			VO.setParking(rs.getString("parking"));
			VO.setAddress(rs.getString("address"));
			VO.setAddress2(rs.getString("address2"));
			VO.setArea(rs.getString("area"));
			VO.setTitle(rs.getString("title"));
			VO.setBill(rs.getInt("bill"));
			VO.setDirection(rs.getString("direction"));
			VO.setDeposit(rs.getInt("deposit"));
			VO.setMonthly(rs.getInt("monthly"));
			VO.setOffice_no(rs.getInt("office_no"));
			VO.setHouse_type(rs.getString("house_type"));
		}
		else {
			VO=null;
		}
		con.close();
		return VO;
	}
}
