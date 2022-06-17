package model.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDAO {
	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;

	public CartDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean CheckMemberCart(int memberNo) {
		sql = "select * from cart where memberNo = ? ";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	public boolean CheckCart(int itemNo, int memberNo) {
		sql = "select * from cart where itemNo = ? and memberNo = ? ";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, itemNo);
			ptmt.setInt(2, memberNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return true;
	}
	
	public CartDTO CartDetail(int itemNo, int memberNo) {
		CartDTO cartDTO = new CartDTO();
		sql = "select * from cart where itemNo = ? and memberNo = ? ";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, itemNo);
			ptmt.setInt(2, memberNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				cartDTO.setItem_name(rs.getString("item_name"));
				cartDTO.setManufacture(rs.getString("manufacture"));
				cartDTO.setCategory(rs.getString("category"));
				cartDTO.setSwitchs(rs.getString("switchs"));
				cartDTO.setSpec(rs.getString("spec"));
				cartDTO.setPrice(rs.getInt("price"));
				cartDTO.setStock(rs.getInt("stock"));
				cartDTO.setItem_img1(rs.getString("item_img1"));
				cartDTO.setItem_img2(rs.getString("item_img2"));
				cartDTO.setItemNo(itemNo);
				cartDTO.setMemberNo(memberNo);
				cartDTO.setSelected_count(rs.getInt("selected_count"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cartDTO;
	}

	public CartDTO ItemToCartDTO(int index) {
		CartDTO cartDTO = new CartDTO();
		sql = "select * from item where itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, index);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				cartDTO.setItem_name(rs.getString("item_name"));
				cartDTO.setManufacture(rs.getString("manufacture"));
				cartDTO.setCategory(rs.getString("category"));
				cartDTO.setSwitchs(rs.getString("switchs"));
				cartDTO.setSpec(rs.getString("spec"));
				cartDTO.setPrice(rs.getInt("price"));
				cartDTO.setStock(rs.getInt("stock"));
				cartDTO.setItem_img1(rs.getString("item_img1"));
				cartDTO.setItem_img2(rs.getString("item_img2"));
				cartDTO.setItemNo(index);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cartDTO;
	}

	public void insert(CartDTO dto) {
		sql = "insert into cart (selected_count, item_name, manufacture, category,"
				+ " switchs, spec,price,stock,reg_date,item_img1,item_img2," + "memberNo,itemNo) values "
				+ "(?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ? )";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, dto.selected_count);
			ptmt.setString(2, dto.item_name);
			ptmt.setString(3, dto.manufacture);
			ptmt.setString(4, dto.category);
			ptmt.setString(5, dto.switchs);
			ptmt.setString(6, dto.spec);
			ptmt.setInt(7, dto.price);
			ptmt.setInt(8, dto.stock);
			ptmt.setString(9, dto.reg_date);
			ptmt.setString(10, dto.item_img1);
			ptmt.setString(11, dto.item_img2);
			ptmt.setInt(12, dto.memberNo);
			ptmt.setInt(13, dto.itemNo);
			ptmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public ArrayList<CartDTO> list(int memberNo) {
		ArrayList<CartDTO> res = new ArrayList<CartDTO>();
		sql = "select * from cart where memberNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCartNo(rs.getInt("cartNo"));
				dto.setSelected_count(rs.getInt("selected_count"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				dto.setSwitchs(rs.getString("switchs"));
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setStock(rs.getInt("stock"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setItemNo(rs.getInt("itemNo"));
				res.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}

	public boolean delCart(int memberNo) {
		sql = "DELETE FROM cart WHERE memberNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	public boolean removeitem(int memberNo, int itemNo) {
		sql = "DELETE FROM cart WHERE memberNo = ? AND itemNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			ptmt.setInt(2, itemNo);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}

	public void ChangeSelectCount(int itemNo, int memberNo, int count) {
		sql = "update cart set selected_count = ? where itemNo = ? and memberNo = ? ";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, count);
			ptmt.setInt(2, itemNo);
			ptmt.setInt(3, memberNo);
			ptmt.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	
	public void close() {
		if (rs != null)
			try {
				rs.close();
			} catch (Exception e) {
			}
		if (ptmt != null)
			try {
				ptmt.close();
			} catch (Exception e) {
			}
		if (con != null)
			try {
				con.close();
			} catch (Exception e) {
			}
	}

}
