package model.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import test.XssUtil;

public class QnaDAO {

	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;

	public QnaDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<QnaDTO> list(int start, int limit) {
		ArrayList<QnaDTO> res = new ArrayList<QnaDTO>();

		sql = "select * from qna where status = ? order by qnaNo desc limit ?, ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "미답변");
			ptmt.setInt(2, start);
			ptmt.setInt(3, limit);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				QnaDTO dto = new QnaDTO();

				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setHits(rs.getInt("hits"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				dto.setOrdered_num(rs.getString("ordered_num"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public ArrayList<QnaDTO> complete(int start, int limit) {
		ArrayList<QnaDTO> res = new ArrayList<QnaDTO>();

		sql = "select * from qna where status = ? order by qnaNo desc limit ?, ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "답변");
			ptmt.setInt(2, start);
			ptmt.setInt(3, limit);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				QnaDTO dto = new QnaDTO();

				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setHits(rs.getInt("hits"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				dto.setOrdered_num(rs.getString("ordered_num"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public ArrayList<QnaDTO> total(int start, int limit) {
		ArrayList<QnaDTO> res = new ArrayList<QnaDTO>();

		sql = "select * from qna order by qnaNo desc limit ?, ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, start);
			ptmt.setInt(2, limit);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				QnaDTO dto = new QnaDTO();

				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setHits(rs.getInt("hits"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				dto.setOrdered_num(rs.getString("ordered_num"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public QnaDTO detail(int no) {

		QnaDTO dto = null;

		sql = "select * from qna where qnaNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				dto = new QnaDTO();

				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setHits(rs.getInt("hits"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				dto.setOrdered_num(rs.getString("ordered_num"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return dto;

	}

	public QnaDTO getSubject(int no, String subject) {

		QnaDTO res = null;

		sql = "select * from qna where qnaNo = ? and subject = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			ptmt.setString(2, subject);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				res = new QnaDTO();

				res.setQnaNo(rs.getInt("qnaNo"));
				res.setSubject(rs.getString("subject"));
				res.setUser_id(rs.getString("user_id"));
				res.setPname(rs.getString("pname"));
				res.setContent(rs.getString("content"));
				res.setHits(rs.getInt("hits"));
				res.setReg_date(rs.getTimestamp("reg_date"));
				res.setStatus(rs.getString("status"));
				res.setOrdered_num(rs.getString("ordered_num"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public void insert(QnaDTO dto) {

		sql = "insert into qna(subject, user_id, pname, content, hits, reg_date, status, memberNo, ordered_num) values (?, ?, ?, ?, 0, now(), ?, ?, ?)";

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
			ptmt.setString(5, "미답변");
			ptmt.setInt(6, dto.memberNo);
			ptmt.setString(7, dto.ordered_num);
			ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public int modify(QnaDTO dto) {

		int res = 0;

		sql = "update qna set subject = ?, content = ?, reg_date = now(), ordered_num = ? where qnaNo = ?";

		String xSubject = dto.subject;
		xSubject = XssUtil.cleanXSS(xSubject);

		String xContent = dto.content;
		xContent = XssUtil.cleanXSS(xContent);

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, xSubject);
			ptmt.setString(2, xContent);
			ptmt.setString(3, dto.ordered_num);
			ptmt.setInt(4, dto.qnaNo);

			res = ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public int processUpdate(QnaDTO dto) {

		int res = 0;

		sql = "update qna set status = ? where qnaNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, "답변");
			ptmt.setInt(2, dto.qnaNo);

			res = ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public boolean removeQna(int qnaNo) {
		sql = "delete from qna where qnaNo = ?";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, qnaNo);
			rs = ptmt.executeQuery();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return false;
	}

	public int postCount() {

		sql = "select count(*) from qna";

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

	public ArrayList<QnaDTO> Currentlist(String Status) {
		ArrayList<QnaDTO> res = new ArrayList<QnaDTO>();
		sql = "select * from qna where status = ? order by qnaNo desc";
		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, Status);
			rs = ptmt.executeQuery();
			while (rs.next()) {
				QnaDTO dto = new QnaDTO();
				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getString("status"));
				dto.setOrdered_num(rs.getString("ordered_num"));
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