package GetOutput;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnection {
	public static Connection connects() throws Exception {
		Class.forName("org.postgresql.Driver");
		return DriverManager.getConnection("jdbc:postgresql://localhost:5432/websocket","postgres","password");	
	}
}
