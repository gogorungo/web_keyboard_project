package model.item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.member.memberDTO;


public class itemDAO {
	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;
	
	public itemDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int modify(itemDTO dto) {
		int res = 0;
		sql = "update item set item_name = ?,manufacture = ?,category = ?,switchs = ?,"
				+ "spec = ?,price = ?,item_img1 = ?,item_img2 = ? where itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.getItem_name());
			ptmt.setString(2, dto.getManufacture());
			ptmt.setString(3, dto.getCategory());
			ptmt.setString(4, dto.getSwitchs());
			ptmt.setString(5, dto.getSpec());
			ptmt.setInt(6, dto.getPrice());
			ptmt.setString(7, dto.getItem_img1());
			ptmt.setString(8, dto.getItem_img2());
			ptmt.setInt(9, dto.getItemNo());
			res = ptmt.executeUpdate();
			return res;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}

	
	
	public boolean addStock(int itemNo, int addCount) {
		sql = "update item set stock = ? where itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, addCount);
			ptmt.setInt(2, itemNo);
			ptmt.executeQuery();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	
	public ArrayList<itemDTO> list(){
		ArrayList<itemDTO> res = new ArrayList<itemDTO>();
		sql = "select * from item";
		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();
			while(rs.next()) {
				itemDTO dto = new itemDTO();
				dto.setItemNo(rs.getInt("itemNo"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setItem_sold(rs.getInt("item_sold"));
				res.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	
	public ArrayList<itemDTO> detaillist(int start, int end) {
		ArrayList<itemDTO> res = new ArrayList<itemDTO>();
		sql = "select * from item where price between ? AND ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, start);
			ptmt.setInt(2, end);
			rs = ptmt.executeQuery();
			while(rs.next()) {
				itemDTO dto = new itemDTO();
				dto.setItemNo(rs.getInt("itemNo"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setItem_sold(rs.getInt("item_sold"));
				res.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	
	public itemDTO Detail(int index){
		itemDTO dto = new itemDTO();
		sql = "select * from item where itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, index);
			rs = ptmt.executeQuery();
			while(rs.next()) {
				dto.setItemNo(rs.getInt("itemNo"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setItem_sold(rs.getInt("item_sold"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}
	
	public void insert(itemDTO dto) {
		sql = "insert into item (item_name ,manufacture,category,switchs,"
				+ "spec,price,stock,item_img1,item_img2,reg_date) values ("
				+ "?,?,?,?,?,?,?,?,?,sysdate())";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.getItem_name());
			ptmt.setString(2, dto.getManufacture());
			ptmt.setString(3, dto.getCategory());
			ptmt.setString(4, dto.getSwitchs());
			ptmt.setString(5, dto.getSpec());
			ptmt.setInt(6, dto.getPrice());
			ptmt.setInt(7, dto.getStock());
			ptmt.setString(8, dto.getItem_img1());
			ptmt.setString(9, dto.getItem_img2());
			ptmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	
	}
	
	public void insertNotSwitchs(itemDTO dto) {
		sql = "insert into item (item_name ,manufacture,category,"
				+ "spec,price,stock,item_img1,item_img2,reg_date) values ("
				+ "?,?,?,?,?,?,?,?,sysdate())";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.getItem_name());
			ptmt.setString(2, dto.getManufacture());
			ptmt.setString(3, dto.getCategory());
			ptmt.setString(4, dto.getSpec());
			ptmt.setInt(5, dto.getPrice());
			ptmt.setInt(6, dto.getStock());
			ptmt.setString(7, dto.getItem_img1());
			ptmt.setString(8, dto.getItem_img2());
			ptmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public ArrayList<itemDTO> findcategoryList(String category) {
		ArrayList<itemDTO> res = new ArrayList<itemDTO>();
		sql = "select * from item where category = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, category);
			rs = ptmt.executeQuery();
			while(rs.next()) {
				itemDTO dto = new itemDTO();
				dto.setItemNo(rs.getInt("itemNo"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setItem_sold(rs.getInt("item_sold"));
				res.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}
	
	public ArrayList<itemDTO> searchList(String itemname) {
		ArrayList<itemDTO> itemList = new ArrayList<itemDTO>();
		sql = "select * from item where item_name like ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, itemname);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				itemDTO dto = new itemDTO();
				dto.setItemNo(rs.getInt("itemNo"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setItem_sold(rs.getInt("item_sold"));
				itemList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return itemList;
	}
	
	
	public void Sell(int itemNo, int count) {
	
		sql = "update item set stock = ? where itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, count);
			ptmt.setInt(2, itemNo);
			ptmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	
	public void close() {
		if(rs!=null)try {rs.close();} catch (Exception e) {}
		if(ptmt!=null)try {ptmt.close();} catch (Exception e) {}
		if(con!=null)try {con.close();} catch (Exception e) {}
	}

	

	
	
}
