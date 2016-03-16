package com.hp.home.cdr;

import java.sql.*;

public class TestMysqlConnector {

	public static void main(String[] args) {

		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();

			conn = DriverManager.getConnection("jdbc:mysql://localhost/mydata?"
					+ "user=root&password=root");
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost/mydata","root","root");
			
			st = conn.createStatement();
			rs = st.executeQuery("select * from dept");

			while (rs.next()) {
				System.out.println(rs.getString("deptno"));
			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
		}

		catch (Exception ex) {
			ex.printStackTrace();
			
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (st != null) {
					st.close();
					st = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
