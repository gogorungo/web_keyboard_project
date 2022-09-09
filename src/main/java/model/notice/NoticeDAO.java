package model.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import test.XssUtil;

public class NoticeDAO {

	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;

	public NoticeDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<NoticeDTO> AllList() {
		ArrayList<NoticeDTO> res = new ArrayList<NoticeDTO>();

		sql = "select * from notice";

		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}
	
	public ArrayList<NoticeDTO> list(int start, int limit) {
		ArrayList<NoticeDTO> res = new ArrayList<NoticeDTO>();

		sql = "select * from notice where status = ? order by noticeNo desc limit ?, ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "게시");
			ptmt.setInt(2, start);
			ptmt.setInt(3, limit);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();

				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}
	
	public NoticeDTO detail(int no) {

		NoticeDTO dto = null;

		sql = "select * from notice where noticeNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				dto = new NoticeDTO();

				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setHits(rs.getInt("hits"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return dto;

	}
	
	public NoticeDTO notExpiredDetail(int no) {
		
		NoticeDTO dto = null;
		
		sql = "select * from notice where noticeNo = ? and status = ?";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			ptmt.setString(2, "게시");
			rs = ptmt.executeQuery();
			
			while (rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setHits(rs.getInt("hits"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return dto;
		
	}

	public void insert(NoticeDTO dto) {

		sql = "insert into notice(subject, user_id, pname, content, hits, reg_date) values (?, ?, ?, ?, 0, now())";
		
		String xSubject = dto.subject;
		xSubject = XssUtil.cleanXSS(xSubject);
		
		String xContent = dto.content;
		xContent = XssUtil.cleanXSS(xContent);

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, xSubject);
			ptmt.setString(2, dto.user_id);
			ptmt.setString(3, dto.pname);
			ptmt.setString(4, xContent);
			ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public int modify(NoticeDTO dto) {

		int res = 0;

		sql = "update notice set subject = ?, content = ?, reg_date = now() where noticeNo = ?";
		
		String xSubject = dto.subject;
		xSubject = XssUtil.cleanXSS(xSubject);
		
		String xContent = dto.content;
		xContent = XssUtil.cleanXSS(xContent);

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, xSubject);
			ptmt.setString(2, xContent);
			ptmt.setInt(3, dto.noticeNo);

			res = ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}
	
	public int expirationUpdate(int no) {
		
		int res = 0;
		
		sql = "update notice set status = ? where noticeNo = ?";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "만료");
			ptmt.setInt(2, no);
			
			res = ptmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return res;
		
	}
	
	public int notExpirationUpdate(int no) {
		
		int res = 0;
		
		sql = "update notice set status = ? where noticeNo = ?";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "게시");
			ptmt.setInt(2, no);
			
			res = ptmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return res;
		
	}

	public int postCount() {

		sql = "select count(*) from notice";

		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();

			rs.next();

			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}
	
	public int postedCount() {
		
		sql = "select count(*) from notice where status = ?";
		
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "게시");
			rs = ptmt.executeQuery();
			
			rs.next();
			
			return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return 0;
	}

	public ArrayList<NoticeDTO> Currentlist(String Status) {
		ArrayList<NoticeDTO> res = new ArrayList<NoticeDTO>();
		sql = "select * from notice where status = ? order by noticeNo desc";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, Status);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return res;

	}

	public void close() {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {
			}
		if (ptmt != null)
			try {
				ptmt.close();
			} catch (SQLException e) {
			}
		if (con != null)
			try {
				con.close();
			} catch (SQLException e) {
			}

	}

}