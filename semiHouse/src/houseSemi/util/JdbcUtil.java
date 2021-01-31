package houseSemi.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcUtil{
	public static Connection getConnection(String username, String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@124.254.202.40:1521:xe", username, password);	
		return con;
	}	
}