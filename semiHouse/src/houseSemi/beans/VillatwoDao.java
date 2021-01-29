package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class VillatwoDao {
	public static final String USERNAME="house";
	public static final String PASSWORD="house";
	public VillatwoDto find(int house_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from villa where house_no =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		VillatwoDto dto;
		if(rs.next()) {
			dto = new VillatwoDto();
			
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
			dto.setVillatwo_no(rs.getInt("villatwo_no"));
		}
		else {
			dto=null;
		}
		con.close();
		return dto;
	}
	
	public void insert(VillatwoDto villatwoDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into villatwo "
				+ "values(villatwo_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,0 ,?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, villatwoDto.getHouse_no());
		ps.setInt(2, villatwoDto.getMember_no());
		ps.setInt(3, villatwoDto.getBroker_no());
		ps.setInt(4, villatwoDto.getDeposit());
		ps.setInt(5, villatwoDto.getMonthly());
		ps.setString(6, villatwoDto.getAddress());
		ps.setString(7, villatwoDto.getAddress2());
		ps.setString(8, villatwoDto.getFloor());
		ps.setString(9, villatwoDto.getLoan());
		ps.setString(10, villatwoDto.getAnimal());
		ps.setString(11, villatwoDto.getElevator());
		ps.setString(12, villatwoDto.getParking());
		ps.setString(13, villatwoDto.getMove_in());
		ps.setString(14, villatwoDto.getEtc());
		ps.setString(15, villatwoDto.getArea());
		ps.setInt(16, villatwoDto.getBill());
		ps.setString(17, villatwoDto.getDirection());
		ps.setString(18, villatwoDto.getTitle());
		
		ps.execute();
		
		con.close();
	}
	//수정
		public boolean update(VillatwoDto villatwoDto) throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "update villatwo set "
					+ "deposit=?, monthly=?, address=?, address2=?, floor=?, loan=?, animal=?, elevator=?, "
					+ "parking=?, move_in=?, etc=?, area=?, bill=?, direction=?, title=? where house_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, villatwoDto.getDeposit());
			ps.setInt(2, villatwoDto.getMonthly());
			ps.setString(3, villatwoDto.getAddress());
			ps.setString(4, villatwoDto.getAddress2());
			ps.setString(5, villatwoDto.getFloor());
			ps.setString(6, villatwoDto.getLoan());
			ps.setString(7, villatwoDto.getAnimal());
			ps.setString(8, villatwoDto.getElevator());
			ps.setString(9, villatwoDto.getParking());
			ps.setString(10, villatwoDto.getMove_in());
			ps.setString(11, villatwoDto.getEtc());
			ps.setString(12, villatwoDto.getArea());
			ps.setInt(13, villatwoDto.getBill());
			ps.setString(14, villatwoDto.getDirection());
			ps.setString(15, villatwoDto.getTitle());
			ps.setInt(16, villatwoDto.getHouse_no());
			
			int count = ps.executeUpdate();
			con.close();
			return count>0;
		}
		public boolean updateVillatwoBrokerA(String broker_agree, int house_no)throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "update villatwo set broker_agree=? where house_no=?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, broker_agree);
			ps.setInt(2, house_no);
			
			int count = ps.executeUpdate();
			con.close();
			return count>0;
		}	

	public List<VillatwoDto> onSelect() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from villatwo where broker_agree='1'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<VillatwoDto> villalist = new ArrayList<>();
		while(rs.next()) {
			VillatwoDto villatwoDto = new VillatwoDto();
			villatwoDto.setVillatwo_no(rs.getInt("villatwo_no"));
			villatwoDto.setDeposit(rs.getInt("deposit"));
			villatwoDto.setMonthly(rs.getInt("monthly"));
			villatwoDto.setAddress(rs.getString("address"));
			villatwoDto.setFloor(rs.getString("floor"));
			villatwoDto.setLoan(rs.getString("loan"));
			villatwoDto.setAnimal(rs.getString("animal"));
			villatwoDto.setElevator(rs.getString("elevator"));
			villatwoDto.setParking(rs.getString("parking"));
			villatwoDto.setHouse_no(rs.getInt("house_no"));
			villatwoDto.setAddress2(rs.getString("address2"));
			villatwoDto.setMove_in(rs.getString("move_in"));
			villatwoDto.setEtc(rs.getString("etc"));
			villatwoDto.setBroker_agree(rs.getString("broker_agree"));
			villatwoDto.setArea(rs.getString("area"));
			villatwoDto.setBill(rs.getInt("bill"));
			villatwoDto.setDirection(rs.getString("direction"));
			villatwoDto.setTitle(rs.getString("title"));
			villalist.add(villatwoDto);
		}
		con.close();
		return villalist;
	}
	
	public List<VillatwoDto> select(FilteringVO villatwoVO) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String floor1,floor2,floor3;
		if(villatwoVO.getFloor1().equals("N")&&villatwoVO.getFloor2().equals("N")&&villatwoVO.getFloor3().equals("N")) {
			floor1 = "반지하";
			floor2 = "층";
			floor3 = "옥탑방";
		}
		else if(villatwoVO.getFloor2().equals("지상층")) {
			floor1 = villatwoVO.getFloor1();
			floor2 = "층";
			floor3 = villatwoVO.getFloor3();
		}
		else {
			floor1 = villatwoVO.getFloor1();
			floor2 = villatwoVO.getFloor2();
			floor3 = villatwoVO.getFloor3();
		}
		String sql;
		PreparedStatement ps;
		// 월세만
		if(villatwoVO.getCharter_min().equals("N")) {
			if(villatwoVO.getDeposit_min().equals("0")&&villatwoVO.getDeposit_max().equals("max")) {
				if(villatwoVO.getMonthly_min().equals("0")&&villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>0 and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setString(1, floor1);
					ps.setString(2, floor3);
					ps.setString(3, floor2);
					ps.setString(4, villatwoVO.getLoan());
					ps.setString(5, villatwoVO.getAnimal());
					ps.setString(6, villatwoVO.getElevator());
					ps.setString(7, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_min().equals("0")) {
					sql = "select * from villatwo where deposit>0 and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, villatwoVO.getLoan());
					ps.setString(6, villatwoVO.getAnimal());
					ps.setString(7, villatwoVO.getElevator());
					ps.setString(8, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>0 and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, villatwoVO.getLoan());
					ps.setString(6, villatwoVO.getAnimal());
					ps.setString(7, villatwoVO.getElevator());
					ps.setString(8, villatwoVO.getParking());
				}
				else {
					sql = "select * from villatwo where deposit>0 and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
			}
			else if(villatwoVO.getDeposit_min().equals("0")) {
				if(villatwoVO.getMonthly_min().equals("0")&&villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>0 and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, villatwoVO.getLoan());
					ps.setString(6, villatwoVO.getAnimal());
					ps.setString(7, villatwoVO.getElevator());
					ps.setString(8, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_min().equals("0")) {
					sql = "select * from villatwo where deposit>0 and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>0 and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
				else {
					sql = "select * from villatwo where deposit>0 and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setInt(3, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, villatwoVO.getLoan());
					ps.setString(8, villatwoVO.getAnimal());
					ps.setString(9, villatwoVO.getElevator());
					ps.setString(10, villatwoVO.getParking());
				}
			}
			else if(villatwoVO.getDeposit_max().equals("max")) {
				if(villatwoVO.getMonthly_min().equals("0")&&villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, villatwoVO.getLoan());
					ps.setString(6, villatwoVO.getAnimal());
					ps.setString(7, villatwoVO.getElevator());
					ps.setString(8, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_min().equals("0")) {
					sql = "select * from villatwo where deposit>=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
				else {
					sql = "select * from villatwo where deposit>=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setInt(3, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, villatwoVO.getLoan());
					ps.setString(8, villatwoVO.getAnimal());
					ps.setString(9, villatwoVO.getElevator());
					ps.setString(10, villatwoVO.getParking());
				}
			}
			else {
				if(villatwoVO.getMonthly_min().equals("0")&&villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>=? and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, villatwoVO.getLoan());
					ps.setString(7, villatwoVO.getAnimal());
					ps.setString(8, villatwoVO.getElevator());
					ps.setString(9, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_min().equals("0")) {
					sql = "select * from villatwo where deposit>=? and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, villatwoVO.getLoan());
					ps.setString(8, villatwoVO.getAnimal());
					ps.setString(9, villatwoVO.getElevator());
					ps.setString(10, villatwoVO.getParking());
				}
				else if(villatwoVO.getMonthly_max().equals("max")) {
					sql = "select * from villatwo where deposit>=? and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setString(4, floor1);
					ps.setString(5, floor3);
					ps.setString(6, floor2);
					ps.setString(7, villatwoVO.getLoan());
					ps.setString(8, villatwoVO.getAnimal());
					ps.setString(9, villatwoVO.getElevator());
					ps.setString(10, villatwoVO.getParking());
				}
				else {
					sql = "select * from villatwo where deposit>=? and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(villatwoVO.getDeposit_min()));
					ps.setInt(2, Integer.parseInt(villatwoVO.getDeposit_max()));
					ps.setInt(3, Integer.parseInt(villatwoVO.getMonthly_min()));
					ps.setInt(4, Integer.parseInt(villatwoVO.getMonthly_max()));
					ps.setString(5, floor1);
					ps.setString(6, floor3);
					ps.setString(7, floor2);
					ps.setString(8, villatwoVO.getLoan());
					ps.setString(9, villatwoVO.getAnimal());
					ps.setString(10, villatwoVO.getElevator());
					ps.setString(11, villatwoVO.getParking());
				}
			}
		}
		//전세만
		else {
			if(villatwoVO.getCharter_min().equals("0")&&villatwoVO.getCharter_max().equals("max")) {
				sql = "select * from villatwo where monthly=0 and deposit>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setString(1, floor1);
				ps.setString(2, floor3);
				ps.setString(3, floor2);
				ps.setString(4, villatwoVO.getLoan());
				ps.setString(5, villatwoVO.getAnimal());
				ps.setString(6, villatwoVO.getElevator());
				ps.setString(7, villatwoVO.getParking());
			}
			else if(villatwoVO.getCharter_min().equals("0")) {
				sql = "select * from villatwo where monthly=0 and deposit>0 and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(villatwoVO.getCharter_max()));
				ps.setString(2, floor1);
				ps.setString(3, floor3);
				ps.setString(4, floor2);
				ps.setString(5, villatwoVO.getLoan());
				ps.setString(6, villatwoVO.getAnimal());
				ps.setString(7, villatwoVO.getElevator());
				ps.setString(8, villatwoVO.getParking());
			}
			else if(villatwoVO.getCharter_max().equals("max")) {
				sql = "select * from villatwo where monthly=0 and deposit>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(villatwoVO.getCharter_min()));
				ps.setString(2, floor1);
				ps.setString(3, floor3);
				ps.setString(4, floor2);
				ps.setString(5, villatwoVO.getLoan());
				ps.setString(6, villatwoVO.getAnimal());
				ps.setString(7, villatwoVO.getElevator());
				ps.setString(8, villatwoVO.getParking());
			}
			else {
				sql = "select * from villatwo where monthly=0 and deposit>=? and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(villatwoVO.getCharter_min()));
				ps.setInt(2, Integer.parseInt(villatwoVO.getCharter_max()));
				ps.setString(3, floor1);
				ps.setString(4, floor3);
				ps.setString(5, floor2);
				ps.setString(6, villatwoVO.getLoan());
				ps.setString(7, villatwoVO.getAnimal());
				ps.setString(8, villatwoVO.getElevator());
				ps.setString(9, villatwoVO.getParking());
			}
		}
		ResultSet rs = ps.executeQuery();
		List<VillatwoDto> villalist = new ArrayList<>();
		while(rs.next()) {
			VillatwoDto villatwoDto = new VillatwoDto();
			villatwoDto.setVillatwo_no(rs.getInt("villatwo_no"));
			villatwoDto.setDeposit(rs.getInt("deposit"));
			villatwoDto.setMonthly(rs.getInt("monthly"));
			villatwoDto.setAddress(rs.getString("address"));
			villatwoDto.setFloor(rs.getString("floor"));
			villatwoDto.setLoan(rs.getString("loan"));
			villatwoDto.setAnimal(rs.getString("animal"));
			villatwoDto.setElevator(rs.getString("elevator"));
			villatwoDto.setParking(rs.getString("parking"));
			villatwoDto.setHouse_no(rs.getInt("house_no"));
			villatwoDto.setAddress2(rs.getString("address2"));
			villatwoDto.setMove_in(rs.getString("move_in"));
			villatwoDto.setEtc(rs.getString("etc"));
			villatwoDto.setBroker_agree(rs.getString("broker_agree"));
			villatwoDto.setArea(rs.getString("area"));
			villatwoDto.setBill(rs.getInt("bill"));
			villatwoDto.setDirection(rs.getString("direction"));
			villatwoDto.setTitle(rs.getString("title"));
			villalist.add(villatwoDto);
		}
		con.close();
		return villalist;
	}

	
	public List<VillatwoVO> select(int villatwo_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from(villatwo V inner join photo P on V.house_no = P.house_no " + 
				"inner join broker B on V.broker_no = B.broker_no " + 
				"inner join member M on B.member_no = M.member_no) where villatwo_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, villatwo_no);
		ResultSet rs = ps.executeQuery();
		List<VillatwoVO> villalist = new ArrayList<>();
		while(rs.next()) {
			VillatwoVO vo = new VillatwoVO();
			vo.setVillatwo_no(rs.getInt("villatwo_no"));
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
			villalist.add(vo);
		}
		con.close();
		return villalist;
	}
	
	public VillaTwoTypeVO type(int house_no) throws Exception {
		Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql="select V.*, house_type from (select * from villaTwo where house_no=?) V left outer join house H on H.house_no=V.house_no";
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs= ps.executeQuery();
		
		VillaTwoTypeVO VO;
		if(rs.next()) {
			VO=new VillaTwoTypeVO();
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
			VO.setVillaTwo_no(rs.getInt("villaTwo_no"));
			VO.setHouse_type(rs.getString("house_type"));
		}
		else {
			VO=null;
		}
		con.close();
		return VO;
	}
	public List<VillatwoVO> house_select(int house_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
		String sql = "select * from(villatwo V inner join photo P on V.house_no = P.house_no " + 
				"inner join broker B on V.broker_no = B.broker_no " + 
				"inner join member M on B.member_no = M.member_no) where V.house_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, house_no);
		ResultSet rs = ps.executeQuery();
		List<VillatwoVO> villalist = new ArrayList<>();
		while(rs.next()) {
			VillatwoVO vo = new VillatwoVO();
			vo.setVillatwo_no(rs.getInt("villatwo_no"));
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
			villalist.add(vo);
		}
		con.close();
		return villalist;
	}
	
}
