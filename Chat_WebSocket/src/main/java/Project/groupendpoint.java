package Project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/GroupChat")
public class groupendpoint {
	private static Set<Session> Users=Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen(Session client) { 
		Users.add(client);
	}
		
	@OnClose
	public void onClose(Session client) { 
		Users.remove(client);
	}
	
	@OnMessage
	public String onMessage(Session client, String data) { 
		//System.out.println("Message : "+data);
		
		try {
			Class.forName("org.postgresql.Driver");
			Connection c=DriverManager.getConnection("jdbc:postgresql://localhost:5432/websocket","postgres","password");
			String arr[]=data.split(",");
			String grpname[]=arr[0].split(":");
			String name=grpname[1].substring(1,grpname[1].length()-1);
			
			String username[]=arr[1].split(":");
			String user=username[1].substring(1,username[1].length()-1);
			
			String message[]=arr[2].split(":");
			String msg=message[1].substring(1,message[1].length()-2);
			
			if(msg.trim()!="" && msg!=null) {
				System.out.println(name+":"+user+":"+msg);
				String sql="insert into groups values(?,?,?)";
				PreparedStatement pst=c.prepareStatement(sql);
				pst.setString(1, user);
				pst.setString(2,name);
				pst.setString(3, msg);
				pst.executeUpdate();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		for(Session answer : Users) {
			try {
				answer.getBasicRemote().sendText(data);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
