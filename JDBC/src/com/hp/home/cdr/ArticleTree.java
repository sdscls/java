package com.hp.home.cdr;

import java.sql.*;

public class ArticleTree {

	public static void main(String[] args) {
		
		new ArticleTree().show();
	}

	public void show() {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?"
					+ "user=root&password=root");
			st = conn.createStatement();

			rs = st.executeQuery("select * from article where pid = 0");
			while(rs.next()){
				System.out.println(rs.getString("title"));
				tree(rs.getInt("id"), conn,1);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
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

	private void tree(int id, Connection conn, int level) {
		Statement st = null;
		ResultSet rs = null;
		
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<level;i++){
			sb.append("   ");
		}
		
		try {
			st = conn.createStatement();
			String sql = "select * from article where pid = " + id;
			rs = st.executeQuery(sql);
			while (rs.next()) {
				System.out.println(sb + rs.getString("title"));
				tree(rs.getInt("id"), conn, level + 1);
			}
			sb = null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}

