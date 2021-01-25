package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import houseSemi.util.JdbcUtil;

public class OneDao {
	String USERNAME="house";
	String PASSWORD="house";
	
	//매물 등록
		public void insert(OneDto oneDto) throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "insert into one "
					+ "values(one_seq.nextval,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,? ,? ,0 ,?, ?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, oneDto.getHouse_no());
			ps.setInt(2, oneDto.getMember_no());
			ps.setInt(3, oneDto.getBroker_no());
			ps.setInt(4, oneDto.getDeposit());
			ps.setInt(5, oneDto.getMonthly());
			ps.setString(6, oneDto.getAddress());
			ps.setString(7, oneDto.getAddress2());
			ps.setString(8, oneDto.getFloor());
			ps.setString(9, oneDto.getLoan());
			ps.setString(10, oneDto.getAnimal());
			ps.setString(11, oneDto.getElevator());
			ps.setString(12, oneDto.getParking());
			ps.setString(13, oneDto.getMove_in());
			ps.setString(14, oneDto.getEtc());
			ps.setString(15, oneDto.getArea());
			ps.setInt(16, oneDto.getBill());
			ps.setString(17, oneDto.getDirection());
			ps.setString(18, oneDto.getTitle());
			
			ps.execute();
			
			con.close();
		}
		//수정
		public boolean updateOne(OneDto oneDto)throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "update one set "
					+ "deposit=?, monthly=?, address=?, address2=?, floor=?, loan=?, animal=?, elevater=?, "
					+ "parking=?, move_in=?, etc=?, area=?, bill=?, direction=?, title=? where house_no=?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, oneDto.getDeposit());
			ps.setInt(2, oneDto.getMonthly());
			ps.setString(3, oneDto.getAddress());
			ps.setString(4, oneDto.getAddress2());
			ps.setString(5, oneDto.getFloor());
			ps.setString(6, oneDto.getLoan());
			ps.setString(7, oneDto.getAnimal());
			ps.setString(8, oneDto.getElevator());
			ps.setString(9, oneDto.getParking());
			ps.setString(10, oneDto.getMove_in());
			ps.setString(11, oneDto.getEtc());
			ps.setString(12, oneDto.getArea());
			ps.setInt(13, oneDto.getBill());
			ps.setString(14, oneDto.getDirection());
			ps.setString(15, oneDto.getTitle());
			ps.setInt(16, oneDto.getHouse_no());
			
			int count = ps.executeUpdate();
			con.close();
			return count>0;
		}
		//단일 조회
		public OneDto find(int house_no)throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql = "select * from one where house_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, house_no);
			
			ResultSet rs = ps.executeQuery();
			OneDto dto;
			if(rs.next()) {
				dto = new OneDto();
				dto.setHouse_no(rs.getInt("house_no"));
				dto.setDeposit(rs.getInt("deposit"));
				dto.setMonthly(rs.getInt("monthly"));
				dto.setAddress(rs.getString("address"));
				dto.setAddress2(rs.getString("address2"));
				dto.setFloor(rs.getString("floor"));
				dto.setLoan(rs.getString("loan"));
				dto.setAnimal(rs.getString("animal"));
				dto.setElevator(rs.getString("elevator"));
				dto.setParking(rs.getString("parking"));
				dto.setMove_in(rs.getString("move_in"));
				dto.setEtc(rs.getString("etc"));
				dto.setArea(rs.getString("area"));
				dto.setBill(rs.getInt("bill"));
				dto.setDirection(rs.getString("direction"));
				dto.setTitle(rs.getString("title"));
				
			}else {
				dto = null;
			}
			con.close();
			return dto;
			
		}
		public List<OneDto> select() throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
			String sql = "select * from one";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			List<OneDto> onelist = new ArrayList<>();
			while(rs.next()) {
				OneDto oneDto = new OneDto();
				oneDto.setOne_no(rs.getInt("one_no"));
				oneDto.setDeposit(rs.getInt("deposit"));
				oneDto.setMonthly(rs.getInt("monthly"));
				oneDto.setAddress(rs.getString("address"));
				oneDto.setFloor(rs.getString("floor"));
				oneDto.setLoan(rs.getString("loan"));
				oneDto.setAnimal(rs.getString("animal"));
				oneDto.setElevator(rs.getString("elevator"));
				oneDto.setParking(rs.getString("parking"));
				oneDto.setHouse_no(rs.getInt("house_no"));
				oneDto.setAddress2(rs.getString("address2"));
				oneDto.setMove_in(rs.getString("move_in"));
				oneDto.setEtc(rs.getString("etc"));
				oneDto.setBroker_agree(rs.getString("broker_agree"));
				oneDto.setArea(rs.getString("area"));
				oneDto.setBill(rs.getInt("bill"));
				oneDto.setDirection(rs.getString("direction"));
				oneDto.setTitle(rs.getString("title"));
				onelist.add(oneDto);
			}
			con.close();
			return onelist;
		}
		public List<OneDto> onSelect() throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
			String sql = "select * from one where broker_agree='1'";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			List<OneDto> onelist = new ArrayList<>();
			while(rs.next()) {
				OneDto oneDto = new OneDto();
				oneDto.setOne_no(rs.getInt("one_no"));
				oneDto.setDeposit(rs.getInt("deposit"));
				oneDto.setMonthly(rs.getInt("monthly"));
				oneDto.setAddress(rs.getString("address"));
				oneDto.setFloor(rs.getString("floor"));
				oneDto.setLoan(rs.getString("loan"));
				oneDto.setAnimal(rs.getString("animal"));
				oneDto.setElevator(rs.getString("elevator"));
				oneDto.setParking(rs.getString("parking"));
				oneDto.setHouse_no(rs.getInt("house_no"));
				oneDto.setAddress2(rs.getString("address2"));
				oneDto.setMove_in(rs.getString("move_in"));
				oneDto.setEtc(rs.getString("etc"));
				oneDto.setBroker_agree(rs.getString("broker_agree"));
				oneDto.setArea(rs.getString("area"));
				oneDto.setBill(rs.getInt("bill"));
				oneDto.setDirection(rs.getString("direction"));
				oneDto.setTitle(rs.getString("title"));
				onelist.add(oneDto);
			}
			con.close();
			return onelist;
		}
		
		public List<OneDto> select(FilteringVO oneVO) throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
			String floor1,floor2,floor3;
			if(oneVO.getFloor1().equals("N")&&oneVO.getFloor2().equals("N")&&oneVO.getFloor3().equals("N")) {
				floor1 = "반지하";
				floor2 = "층";
				floor3 = "옥탑방";
			}
			else if(oneVO.getFloor2().equals("지상층")) {
				floor1 = oneVO.getFloor1();
				floor2 = "층";
				floor3 = oneVO.getFloor3();
			}
			else {
				floor1 = oneVO.getFloor1();
				floor2 = oneVO.getFloor2();
				floor3 = oneVO.getFloor3();
			}
			String sql;
			PreparedStatement ps;
			// 월세만
			if(oneVO.getCharter_min().equals("N")) {
				if(oneVO.getDeposit_min().equals("0")&&oneVO.getDeposit_max().equals("max")) {
					if(oneVO.getMonthly_min().equals("0")&&oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>0 and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setString(1, floor1);
						ps.setString(2, floor3);
						ps.setString(3, floor2);
						ps.setString(4, oneVO.getLoan());
						ps.setString(5, oneVO.getAnimal());
						ps.setString(6, oneVO.getElevator());
						ps.setString(7, oneVO.getParking());
					}
					else if(oneVO.getMonthly_min().equals("0")) {
						sql = "select * from one where deposit>0 and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(2, floor1);
						ps.setString(3, floor3);
						ps.setString(4, floor2);
						ps.setString(5, oneVO.getLoan());
						ps.setString(6, oneVO.getAnimal());
						ps.setString(7, oneVO.getElevator());
						ps.setString(8, oneVO.getParking());
					}
					else if(oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>0 and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setString(2, floor1);
						ps.setString(3, floor3);
						ps.setString(4, floor2);
						ps.setString(5, oneVO.getLoan());
						ps.setString(6, oneVO.getAnimal());
						ps.setString(7, oneVO.getElevator());
						ps.setString(8, oneVO.getParking());
					}
					else {
						sql = "select * from one where deposit>0 and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
				}
				else if(oneVO.getDeposit_min().equals("0")) {
					if(oneVO.getMonthly_min().equals("0")&&oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>0 and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setString(2, floor1);
						ps.setString(3, floor3);
						ps.setString(4, floor2);
						ps.setString(5, oneVO.getLoan());
						ps.setString(6, oneVO.getAnimal());
						ps.setString(7, oneVO.getElevator());
						ps.setString(8, oneVO.getParking());
					}
					else if(oneVO.getMonthly_min().equals("0")) {
						sql = "select * from one where deposit>0 and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
					else if(oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>0 and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
					else {
						sql = "select * from one where deposit>0 and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setInt(3, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(4, floor1);
						ps.setString(5, floor3);
						ps.setString(6, floor2);
						ps.setString(7, oneVO.getLoan());
						ps.setString(8, oneVO.getAnimal());
						ps.setString(9, oneVO.getElevator());
						ps.setString(10, oneVO.getParking());
					}
				}
				else if(oneVO.getDeposit_max().equals("max")) {
					if(oneVO.getMonthly_min().equals("0")&&oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setString(2, floor1);
						ps.setString(3, floor3);
						ps.setString(4, floor2);
						ps.setString(5, oneVO.getLoan());
						ps.setString(6, oneVO.getAnimal());
						ps.setString(7, oneVO.getElevator());
						ps.setString(8, oneVO.getParking());
					}
					else if(oneVO.getMonthly_min().equals("0")) {
						sql = "select * from one where deposit>=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
					else if(oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
					else {
						sql = "select * from one where deposit>=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setInt(3, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(4, floor1);
						ps.setString(5, floor3);
						ps.setString(6, floor2);
						ps.setString(7, oneVO.getLoan());
						ps.setString(8, oneVO.getAnimal());
						ps.setString(9, oneVO.getElevator());
						ps.setString(10, oneVO.getParking());
					}
				}
				else {
					if(oneVO.getMonthly_min().equals("0")&&oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>=? and deposit<=? and monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setString(3, floor1);
						ps.setString(4, floor3);
						ps.setString(5, floor2);
						ps.setString(6, oneVO.getLoan());
						ps.setString(7, oneVO.getAnimal());
						ps.setString(8, oneVO.getElevator());
						ps.setString(9, oneVO.getParking());
					}
					else if(oneVO.getMonthly_min().equals("0")) {
						sql = "select * from one where deposit>=? and deposit<=? and monthly>0 and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(3, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(4, floor1);
						ps.setString(5, floor3);
						ps.setString(6, floor2);
						ps.setString(7, oneVO.getLoan());
						ps.setString(8, oneVO.getAnimal());
						ps.setString(9, oneVO.getElevator());
						ps.setString(10, oneVO.getParking());
					}
					else if(oneVO.getMonthly_max().equals("max")) {
						sql = "select * from one where deposit>=? and deposit<=? and monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(3, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setString(4, floor1);
						ps.setString(5, floor3);
						ps.setString(6, floor2);
						ps.setString(7, oneVO.getLoan());
						ps.setString(8, oneVO.getAnimal());
						ps.setString(9, oneVO.getElevator());
						ps.setString(10, oneVO.getParking());
					}
					else {
						sql = "select * from one where deposit>=? and deposit<=? and monthly>=? and monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
						ps = con.prepareStatement(sql);
						ps.setInt(1, Integer.parseInt(oneVO.getDeposit_min()));
						ps.setInt(2, Integer.parseInt(oneVO.getDeposit_max()));
						ps.setInt(3, Integer.parseInt(oneVO.getMonthly_min()));
						ps.setInt(4, Integer.parseInt(oneVO.getMonthly_max()));
						ps.setString(5, floor1);
						ps.setString(6, floor3);
						ps.setString(7, floor2);
						ps.setString(8, oneVO.getLoan());
						ps.setString(9, oneVO.getAnimal());
						ps.setString(10, oneVO.getElevator());
						ps.setString(11, oneVO.getParking());
					}
				}
			}
			//전세만
			else {
				if(oneVO.getCharter_min().equals("0")&&oneVO.getCharter_max().equals("max")) {
					sql = "select * from one where monthly=0 and deposit>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setString(1, floor1);
					ps.setString(2, floor3);
					ps.setString(3, floor2);
					ps.setString(4, oneVO.getLoan());
					ps.setString(5, oneVO.getAnimal());
					ps.setString(6, oneVO.getElevator());
					ps.setString(7, oneVO.getParking());
				}
				else if(oneVO.getCharter_min().equals("0")) {
					sql = "select * from one where monthly=0 and deposit>0 and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(oneVO.getCharter_max()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, oneVO.getLoan());
					ps.setString(6, oneVO.getAnimal());
					ps.setString(7, oneVO.getElevator());
					ps.setString(8, oneVO.getParking());
				}
				else if(oneVO.getCharter_max().equals("max")) {
					sql = "select * from one where monthly=0 and deposit>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(oneVO.getCharter_min()));
					ps.setString(2, floor1);
					ps.setString(3, floor3);
					ps.setString(4, floor2);
					ps.setString(5, oneVO.getLoan());
					ps.setString(6, oneVO.getAnimal());
					ps.setString(7, oneVO.getElevator());
					ps.setString(8, oneVO.getParking());
				}
				else {
					sql = "select * from one where monthly=0 and deposit>=? and deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=? and broker_agree='1'";
					ps = con.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(oneVO.getCharter_min()));
					ps.setInt(2, Integer.parseInt(oneVO.getCharter_max()));
					ps.setString(3, floor1);
					ps.setString(4, floor3);
					ps.setString(5, floor2);
					ps.setString(6, oneVO.getLoan());
					ps.setString(7, oneVO.getAnimal());
					ps.setString(8, oneVO.getElevator());
					ps.setString(9, oneVO.getParking());
				}
			}
			ResultSet rs = ps.executeQuery();
			List<OneDto> onelist = new ArrayList<>();
			while(rs.next()) {
				OneDto oneDto = new OneDto();
				oneDto.setOne_no(rs.getInt("one_no"));
				oneDto.setDeposit(rs.getInt("deposit"));
				oneDto.setMonthly(rs.getInt("monthly"));
				oneDto.setAddress(rs.getString("address"));
				oneDto.setFloor(rs.getString("floor"));
				oneDto.setLoan(rs.getString("loan"));
				oneDto.setAnimal(rs.getString("animal"));
				oneDto.setElevator(rs.getString("elevator"));
				oneDto.setParking(rs.getString("parking"));
				oneDto.setHouse_no(rs.getInt("house_no"));
				oneDto.setAddress2(rs.getString("address2"));
				oneDto.setMove_in(rs.getString("move_in"));
				oneDto.setEtc(rs.getString("etc"));
				oneDto.setBroker_agree(rs.getString("broker_agree"));
				oneDto.setArea(rs.getString("area"));
				oneDto.setBill(rs.getInt("bill"));
				oneDto.setDirection(rs.getString("direction"));
				oneDto.setTitle(rs.getString("title"));
				onelist.add(oneDto);
			}
			con.close();
			return onelist;
		}

		
		public List<OneVO> select(int one_no) throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME,PASSWORD);
			String sql = "select * from(one O inner join photo P on O.house_no = P.house_no " + 
					"inner join broker B on O.broker_no = B.broker_no " + 
					"inner join member M on B.member_no = M.member_no) where one_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, one_no);
			ResultSet rs = ps.executeQuery();
			List<OneVO> onelist = new ArrayList<>();
			while(rs.next()) {
				OneVO vo = new OneVO();
				vo.setOne_no(rs.getInt("one_no"));
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
				onelist.add(vo);
			}
			con.close();
			return onelist;
		}
		
		public OneTypeVO type(int house_no) throws Exception {
			Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
			String sql="select O.*, house_type from (select * from one where house_no=?) O left outer join house H on H.house_no=O.house_no";
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setInt(1, house_no);
			ResultSet rs= ps.executeQuery();
			
			OneTypeVO VO;
			if(rs.next()) {
				VO=new OneTypeVO();
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
				VO.setOne_no(rs.getInt("one_no"));
				VO.setHouse_type(rs.getString("house_type"));
			}
			else {
				VO=null;
			}
			con.close();
			return VO;
		}
	
}
