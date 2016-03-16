package com.hp.home.cdr;

import java.sql.*;

public class TestPrepStmt {

	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement pst = null;
		
		if(args.length!=3){
			System.out.println("The parameter are not correct! Please input again!");
			System.exit(-1);
		}
		int deptno = 0;
		
		try {
			deptno = Integer.parseInt(args[0]);
		}catch(NumberFormatException e){
			System.out.println("The deptno should be number! Please input again!");
			System.exit(-1);
		}
		
		String dname = args[1];
		String loc = args[2];
		
		
		try {
			//new oracle.jdbc.driver.OracleDriver();
			
			//Class 类转载器，条用方法forName之后,会把相应的对象给new出来，实例创建之后，会自动向DriverManager注册,
			//通过大管家可以拿到一个数据库的连接
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
			pst = conn.prepareStatement("insert into dept2 values (?, ?, ?)");
			pst.setInt(1, deptno);
			pst.setString(2, dname);
			pst.setString(3, loc);
			pst.executeUpdate();
			
			
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				if(pst!=null){
					pst.close();
					pst = null;
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
