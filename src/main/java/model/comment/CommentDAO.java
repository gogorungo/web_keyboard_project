package model.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.qna.QnaDTO;
import test.XssUtil;

public class CommentDAO {

	Connection con;
	PreparedStatement ptmt;
	ResultSet rs;
	String sql;

	public CommentDAO() {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/qazxsw");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<CommentDTO> list() {

		ArrayList<CommentDTO> res = new ArrayList<CommentDTO>();

		sql = "select * from comment order by commentNo desc";

		try {
			ptmt = con.prepareStatement(sql);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				CommentDTO dto = new CommentDTO();

				dto.setCommentNo(rs.getInt("commentNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setComment(rs.getString("comment"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setStatus(rs.getString("status"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public ArrayList<CommentDTO> qnaNoList(int no) {

		ArrayList<CommentDTO> res = new ArrayList<CommentDTO>();

		sql = "select * from comment where qnaNo = ? order by commentNo desc";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				CommentDTO dto = new CommentDTO();

				dto.setCommentNo(rs.getInt("commentNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setComment(rs.getString("comment"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setStatus(rs.getString("status"));
				res.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public CommentDTO detail(int no) {

		CommentDTO dto = null;

		sql = "select * from comment where commentNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
			rs = ptmt.executeQuery();

			while (rs.next()) {
				dto = new CommentDTO();

				dto.setCommentNo(rs.getInt("commentNo"));
				dto.setSubject(rs.getString("subject"));
				dto.setComment(rs.getString("comment"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setPname(rs.getString("pname"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setQnaNo(rs.getInt("qnaNo"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setStatus(rs.getString("status"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return dto;

	}

	public void insert(CommentDTO dto) {

		sql = "insert into comment(subject, comment, user_id, pname, reg_date, qnaNo, memberNo, status) values (?, ?, ?, ?, now(), ?, ?, ?)";
		
		String xSubject = dto.subject;
		xSubject = XssUtil.cleanXSS(xSubject);
		
		String xComment = dto.comment;
		xComment = XssUtil.cleanXSS(xComment);

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, xSubject);
			ptmt.setString(2, xComment);
			ptmt.setString(3, dto.user_id);
			ptmt.setString(4, dto.pname);
			ptmt.setInt(5, dto.qnaNo);
			ptmt.setInt(6, dto.memberNo);
			ptmt.setString(7, "답변");
			ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public int modify(CommentDTO dto) {

		int res = 0;

		sql = "update comment set subject = ?, comment = ?, reg_date = now() where commentNo = ?";
		
		String xSubject = dto.subject;
		xSubject = XssUtil.cleanXSS(xSubject);
		
		String xComment = dto.comment;
		xComment = XssUtil.cleanXSS(xComment);

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setString(1, xSubject);
			ptmt.setString(2, xComment);
			ptmt.setInt(3, dto.commentNo);

			res = ptmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return res;

	}

	public int postCount() {

		sql = "select count(*) from comment";

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

	public int answerCount(int no) {

		sql = "select count(*) from comment where qnaNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, no);
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

	public void answerCount(QnaDTO qnaDTO) {

		sql = "select count(*) from comment where qnaNo = ?";

		try {
			ptmt = con.prepareStatement(sql);
			ptmt.setInt(1, qnaDTO.getQnaNo());
			rs = ptmt.executeQuery();

			rs.next();

			qnaDTO.setAnswerCnt(rs.getInt(1));

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
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