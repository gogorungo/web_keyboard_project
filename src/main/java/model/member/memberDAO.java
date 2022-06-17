package model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.item.itemDTO;
import model.order.OrderDTO;

public class memberDAO {
	Connection con;
	PreparedStatement ptmt; // 보안적용
	ResultSet rs;
	String sql;

	public memberDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<memberDTO> allList() {
		ArrayList<memberDTO> memberList = new ArrayList<memberDTO>();
		sql = "select * from member";

		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setName(rs.getString("name"));
				dto.setBirthdate(rs.getTimestamp("birthdate"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				if (rs.getString("zip_code") != null) {
					dto.setZip_code(rs.getString("zip_code"));
				}
				if (rs.getString("addr1") != null) {
					dto.setAddr1(rs.getString("addr1"));
				}
				if (rs.getString("addr2") != null) {
					dto.setAddr2(rs.getString("addr2"));
				}
				if (rs.getString("tel") != null) {
					dto.setTel(rs.getString("tel"));
					
					String tel = rs.getString("tel");
					
					String tel1 = tel.substring(0,3);
					String tel2 = tel.substring(3,7);
					String tel3 = tel.substring(7);
					
					dto.setTel1(tel1);
					dto.setTel2(tel2);
					dto.setTel3(tel3);
					
				}
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return memberList;
	}

	public void signUp(memberDTO dto) {
		Date date = new Date();
		Object birthDay;

		sql = "insert into member (user_id, user_pw, name, birthdate, gender, email, zip_code, addr1, addr2, tel, reg_date) values "
				+ "(?, password(?), ?, ?, ?, ?, ?, ?, ?, ?, sysdate())";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.getUser_id());
			ptmt.setString(2, dto.getUser_pw());
			ptmt.setString(3, dto.getName());

			date = dto.getBirthdate();
			birthDay = new Timestamp(date.getTime());
			ptmt.setObject(4, birthDay);

			ptmt.setString(5, dto.getGender());
			ptmt.setString(6, dto.getEmail());
			ptmt.setString(7, dto.getZip_code());
			ptmt.setString(8, dto.getAddr1());
			ptmt.setString(9, dto.getAddr2());
			ptmt.setString(10, dto.getTel());

			rs = ptmt.executeQuery();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public int checkPW(int memberNo, String userPW) {
		
		sql = "SELECT count(*) FROM member WHERE memberNO = ? and user_pw = password(?)";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			ptmt.setString(2, userPW);

			rs = ptmt.executeQuery();

			rs.next(); 
			
			return rs.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		
		return 0;
	}
	
	public int checkIDEmail(String userID, String email) {
		
		sql = "SELECT count(*) FROM member WHERE user_id = ? and email = ?";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, userID);
			ptmt.setString(2, email);

			rs = ptmt.executeQuery();

			rs.next(); 
			
			return rs.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		
		return 0;
	}

	public memberDTO memberLogin(memberDTO dto) {
		memberDTO res = null;

		sql = "SELECT * FROM member WHERE user_id = ? and user_pw = password(?)";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.getUser_id());
			ptmt.setString(2, dto.getUser_pw());

			rs = ptmt.executeQuery();

			if (rs.next()) {
				res = new memberDTO();
				res.setMemberNo(rs.getInt("memberNo"));
				res.setUser_id(rs.getString("user_id"));
				res.setName(rs.getString("name"));
				res.setBirthdate(rs.getTimestamp("birthdate"));
				res.setGender(rs.getString("gender"));
				res.setEmail(rs.getString("email"));

				if (rs.getString("zip_code") != null) {
					res.setZip_code(rs.getString("zip_code"));
				}
				
				if (rs.getString("addr1") != null) {
					res.setAddr1(rs.getString("addr1"));
				}

				if (rs.getString("addr2") != null) {
					res.setAddr2(rs.getString("addr2"));
				}

				if (rs.getString("tel") != null) {
					res.setTel(rs.getString("tel"));
					
					String tel = rs.getString("tel");
					
					String tel1 = tel.substring(0,3);
					String tel2 = tel.substring(3,7);
					String tel3 = tel.substring(7);
					
					res.setTel1(tel1);
					res.setTel2(tel2);
					res.setTel3(tel3);
					
				}

				res.setReg_date(rs.getTimestamp("reg_date"));
				res.setStatus(rs.getString("status"));
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}

		return res;
	}

	public memberDTO detail(int id) {
		memberDTO dto = null;
		sql = "select * from member where memberNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, id);

			rs = ptmt.executeQuery();

			if (rs.next()) {

				dto = new memberDTO();

				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setName(rs.getString("name"));
				dto.setBirthdate(rs.getTimestamp("birthdate"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));

				if (rs.getString("zip_code") != null) {
					dto.setZip_code(rs.getString("zip_code"));
				}
				
				if (rs.getString("addr1") != null) {
					dto.setAddr1(rs.getString("addr1"));
				}
				if (rs.getString("addr2") != null) {
					dto.setAddr2(rs.getString("addr2"));
				}
				if (rs.getString("tel") != null) {
					dto.setTel(rs.getString("tel"));
					String tel = rs.getString("tel");
					
					String tel1 = tel.substring(0,3);
					String tel2 = tel.substring(3,7);
					String tel3 = tel.substring(7);
					
					dto.setTel1(tel1);
					dto.setTel2(tel2);
					dto.setTel3(tel3);
				}
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return dto;
	}
	
	public void doWithdrawal(int memberNo) {
		
		sql = "update member set status = ? where memberNo = ? ";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "탈퇴");
			ptmt.setInt(2, memberNo);
			
			ptmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public int modify(memberDTO dto) {

		int res = 0;
		sql = "update member set user_id = ?, user_pw = password(?), name = ?, email = ?, zip_code=?, addr1 = ?, addr2 = ?, tel = ? "

				+ "where memberNo =? ";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.user_id);
			ptmt.setString(2, dto.user_pw);
			ptmt.setString(3, dto.name);
			ptmt.setString(4, dto.email);
			ptmt.setString(5, dto.zip_code);
			ptmt.setString(6, dto.addr1);
			ptmt.setString(7, dto.addr2);
			ptmt.setString(8, dto.tel);
			ptmt.setInt(9, dto.memberNo);
			// 실행된 갯수만
			res = ptmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}

	public int Adminmodify(memberDTO dto) {

		int res = 0;
		sql = "update member set user_id = ?, name = ?, birthdate = ? ,gender=?, email = ?, zip_code = ?, addr1 = ?, addr2 = ?, tel = ?, status = ? "
				+ "where memberNo =? ";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, dto.user_id);
			ptmt.setString(2, dto.name);
			
			Date date = new Date();
			date = dto.birthdate;
			Object oDate = new Timestamp(date.getTime());
			
			ptmt.setObject(3, oDate);
			ptmt.setString(4, dto.gender);
			ptmt.setString(5, dto.email);
			ptmt.setString(6, dto.zip_code);
			ptmt.setString(7, dto.addr1);
			ptmt.setString(8, dto.addr2);
			ptmt.setString(9, dto.tel);
			ptmt.setString(10, dto.status);
			ptmt.setInt(11, dto.memberNo);
			// 실행된 갯수만
			res = ptmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;
	}

	public int totalCnt(int no) {
		sql = "SELECT COUNT(*) FROM orders WHERE memberNo = ?";

		try {
			ptmt = con.prepareStatement(sql);

			ptmt.setInt(1, no);

			rs = ptmt.executeQuery();

			rs.next();

			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}

	public ArrayList<OrderDTO> orderList(int start, int limit, int memberNo) {
		ArrayList<OrderDTO> res = new ArrayList<OrderDTO>();
		sql = "SELECT * FROM orders WHERE memberNo = ? order by ordered_date desc limit ?, ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, memberNo);
			ptmt.setInt(2, start);
			ptmt.setInt(3, limit);

			rs = ptmt.executeQuery();

			while (rs.next()) {

				OrderDTO dto = new OrderDTO();

				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setOrdered_num(rs.getString("ordered_num"));
				dto.setOrdered_date(rs.getTimestamp("ordered_date"));
				dto.setManufacture(rs.getString("manufacture"));
				dto.setCategory(rs.getString("category"));
				if (rs.getString("switchs") != null) {
					dto.setSwitchs(rs.getString("switchs"));
				}
				dto.setSpec(rs.getString("spec"));
				dto.setPrice(rs.getInt("price"));
				dto.setSelect_count(rs.getInt("select_count"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setItem_img1(rs.getString("item_img1"));
				dto.setItem_img2(rs.getString("item_img2"));
				dto.setMemberNo(memberNo);
				dto.setName(rs.getString("name"));
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
				dto.setStatus(rs.getString("status"));
				if (rs.getString("refund") != null) {
					dto.setRefund(rs.getString("refund"));
				}
				if (rs.getTimestamp("refund_date") != null) {
					dto.setRefund_date(rs.getTimestamp("refund_date"));
				}

				res.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;
	}
	
	public void updatePW(String userId, String userPw) {
		sql = "update member set user_pw = password(?) where user_id = ? ";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, userPw);
			ptmt.setString(2, userId);
			
			ptmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
	}


	public boolean change(String status, int memberNo) {
		sql = "update member set status = ? where memberNo =? ";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, status);
			ptmt.setInt(2, memberNo);
			ptmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}
	
	public ArrayList<memberDTO> findList(String member_id) {
		ArrayList<memberDTO> memberList = new ArrayList<memberDTO>();
		sql = "select * from member where user_id like ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, member_id);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setName(rs.getString("name"));
				dto.setBirthdate(rs.getTimestamp("birthdate"));
				dto.setGender(rs.getString("gender"));
				dto.setEmail(rs.getString("email"));
				
				if (rs.getString("zip_code") != null) {
					dto.setZip_code(rs.getString("zip_code"));
				}
				
				if (rs.getString("addr1") != null) {
					dto.setAddr1(rs.getString("addr1"));
				}
				if (rs.getString("addr2") != null) {
					dto.setAddr2(rs.getString("addr2"));
				}
				if (rs.getString("tel") != null) {
					dto.setTel(rs.getString("tel"));
				}
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return memberList;
	}
	
	// 중복 닉네임, 이메일 검사용
	public ArrayList<memberDTO> findData() {
		ArrayList<memberDTO> memberList = new ArrayList<memberDTO>();
		sql = "select * from member";

		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setEmail(rs.getString("email"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return memberList;
	}



	public int idchk(String user_id) {
		
		sql = "select count(*) from member where user_id = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, user_id);

			rs = ptmt.executeQuery();

			rs.next(); 
			
			return rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}
	
	public int emailchk(String email) {
		
		sql = "select count(*) from member where email = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, email);

			rs = ptmt.executeQuery();

			rs.next(); 
			
			return rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}

	public void close() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}
		if (ptmt != null) {
			try {
				ptmt.close();
			} catch (SQLException e) {
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
	}
}