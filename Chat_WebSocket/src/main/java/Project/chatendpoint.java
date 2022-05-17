package Project;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@ServerEndpoint(value="/endpoint")
public class chatendpoint{
	
	private static Set<Session> session = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnMessage
	public String onMessage(Session client,String data) {
		//System.out.println("Message : " +data);
		
		try {
			Class.forName("org.postgresql.Driver");
			Connection c=DriverManager.getConnection("jdbc:postgresql://localhost:5432/websocket","postgres","password");
			String arr[]=data.split(",");
			
			String username[]=arr[0].split(":");
			String name=username[1].substring(1,username[1].length()-1);
			
			String message[]=arr[1].split(":");
			String msg=message[1].substring(1,message[1].length()-1);
			
			String receive[]=arr[2].split(":");
			String receiver=receive[1].substring(1,receive[1].length()-2);
			
			if(msg.trim()!="" && msg!=null) {
				String sql="insert into messages values(?,?,?)";
				PreparedStatement pst=c.prepareStatement(sql);
				pst.setString(1, name);
				pst.setString(2,msg);
				pst.setString(3, receiver);
				pst.executeUpdate();
			}	
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		for(Session get : session) {
				try {
					get.getBasicRemote().sendText(data);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return null;
	}
	
	@OnOpen
	public void onOpen(Session client) {
		//System.out.println("On Open : "+client.getId());
		session.add(client);
	}
	
	@OnClose
	public void onClose(Session client) {
		//System.out.println("On Close : "+client.getId());
		session.remove(client);
	}
	
}
