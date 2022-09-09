package model.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.notice.NoticeDTO;

public class MainDAO {
	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;
	
	public MainDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<MainDTO> Currentlist(String Status) {
		ArrayList<MainDTO> res = new ArrayList<MainDTO>();
		sql = "select * from Main where status = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, Status);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				MainDTO dto = new MainDTO();
				dto.setMainNo(rs.getInt("MainNo"));
				dto.setStatus(rs.getString("status"));
				dto.setItemNo(rs.getInt("itemNO"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	
	public boolean removeitem(int itemNo, String status) {
		sql = "delete from Main where itemNo = ? and status = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, itemNo);
			ptmt.setString(2, status);
			rs = ptmt.executeQuery();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	public boolean insert(int itemNo, String status) {
		sql = "insert into Main (itemNo ,status) values (?,?)";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, itemNo);
			ptmt.setString(2, status);
			rs = ptmt.executeQuery();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	public void close() {
		if(rs!=null)try {rs.close();} catch (Exception e) {}
		if(ptmt!=null)try {ptmt.close();} catch (Exception e) {}
		if(con!=null)try {con.close();} catch (Exception e) {}
	}

	
	
	
}
