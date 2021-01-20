package houseSemi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OneDao {
	public List<OneDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection("web", "web");
		String sql = "select * from one";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<OneDto> onelist = new ArrayList<>();
		while(rs.next()) {
			OneDto oneDto = new OneDto();
			oneDto.setOne_no(rs.getInt("one_no"));
			oneDto.setOne_deposit(rs.getInt("one_deposit"));
			oneDto.setOne_monthly(rs.getInt("one_monthly"));
			oneDto.setOne_address(rs.getString("one_address"));
			oneDto.setFloor(rs.getString("floor"));
			oneDto.setLoan(rs.getString("loan"));
			oneDto.setAnimal(rs.getString("animal"));
			oneDto.setElevator(rs.getString("elevator"));
			oneDto.setParking(rs.getString("parking"));
			onelist.add(oneDto);
		}
		con.close();
		return onelist;
	}
	
	
	public List<OneDto> select(OneVO oneVO) throws Exception{
		Connection con = JdbcUtil.getConnection("web", "web");
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
					sql = "select * from one where one_deposit>0 and one_monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_monthly>0 and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_monthly>=? and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 one_deposit<=? and one_monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_deposit<=? and one_monthly>0 and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_deposit<=? and one_monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>0 and one_deposit<=? and one_monthly>=? and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_monthly>0 and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_monthly>=? and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_deposit<=? and one_monthly>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_deposit<=? and one_monthly>0 and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_deposit<=? and one_monthly>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
					sql = "select * from one where one_deposit>=? and one_deposit<=? and one_monthly>=? and one_monthly<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
				sql = "select * from one where one_monthly=0 and one_deposit>0 and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
				sql = "select * from one where one_monthly=0 and one_deposit>0 and one_deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
				sql = "select * from one where one_monthly=0 and one_deposit>=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
				sql = "select * from one where one_monthly=0 and one_deposit>=? and one_deposit<=? and (floor in (?,?) or instr(floor,?)>0) and loan>=? and animal>=? and elevator>=? and parking>=?";
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
			oneDto.setOne_deposit(rs.getInt("one_deposit"));
			oneDto.setOne_monthly(rs.getInt("one_monthly"));
			oneDto.setOne_address(rs.getString("one_address"));
			oneDto.setFloor(rs.getString("floor"));
			oneDto.setLoan(rs.getString("loan"));
			oneDto.setAnimal(rs.getString("animal"));
			oneDto.setElevator(rs.getString("elevator"));
			oneDto.setParking(rs.getString("parking"));
			onelist.add(oneDto);
		}
		con.close();
		return onelist;
	}

	
	public OneDto select(int one_no) throws Exception{
		Connection con = JdbcUtil.getConnection("web", "web");
		String sql = "select * from one where one_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, one_no);
		ResultSet rs = ps.executeQuery();
		OneDto oneDto = new OneDto();
		if(rs.next()) {
			oneDto.setOne_no(rs.getInt("one_no"));
			oneDto.setOne_deposit(rs.getInt("one_deposit"));
			oneDto.setOne_monthly(rs.getInt("one_monthly"));
			oneDto.setOne_address(rs.getString("one_address"));
			oneDto.setFloor(rs.getString("floor"));
			oneDto.setLoan(rs.getString("loan"));
			oneDto.setAnimal(rs.getString("animal"));
			oneDto.setElevator(rs.getString("elevator"));
			oneDto.setParking(rs.getString("parking"));
		}
		else {
			oneDto = null;
		}
		con.close();
		return oneDto;
	}
}
