package com.hp.home.cdr;

import java.sql.*;

public class TestTransaction {

	public static void main(String[] args) {
		Connection conn = null;
		Statement st = null;
		
		try {
			//new oracle.jdbc.driver.OracleDriver();
			
			//Class 类转载器，条用方法forName之后,会把相应的对象给new出来，实例创建之后，会自动向DriverManager注册,
			//通过大管家可以拿到一个数据库的连接
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
			
			conn.setAutoCommit(false);
			st = conn.createStatement();
			st.addBatch("insert into dept2 values (66, 'BI', 'Shanghai')");
			st.addBatch("insert into dept2 values (99, 'ES', 'Shanghai')");
			st.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			
			
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch(SQLException e){
			e.printStackTrace();
			try{
				if(conn!=null){
					conn.rollback();
					conn.setAutoCommit(true);
				}
			}catch(SQLException e1){
				e1.printStackTrace();
			}
			
		}finally{
			try{
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
