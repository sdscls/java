package com.hp.home.cdr;
import java.sql.*;

public class TestJDBC {

	public static void main(String[] args) {
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			//new oracle.jdbc.driver.OracleDriver();
			
			//Class 类转载器，条用方法forName之后,会把相应的对象给new出来，实例创建之后，会自动向DriverManager注册,
			//通过大管家可以拿到一个数据库的连接
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
			st = conn.createStatement();
			rs = st.executeQuery("select * from dept");
			
			while(rs.next()){
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				System.out.println("deptno: "+ deptno+", dname: "+ dname );
			}
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			try{
				if(rs!=null){
					rs.close();
					rs = null;
				}
				if(st!=null){
					st.close();
					st = null;
				}
				if(conn!=null){
					conn.close();
					conn = null;
				}
			} catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

}
