package houseSemi.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcUtil{
	public static Connection getConnection(String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@www.sysout.co.kr:1521:xe", username, password);	
		return con;
	}
}