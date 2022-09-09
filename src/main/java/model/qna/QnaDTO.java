package model.qna;

import java.util.Date;

public class QnaDTO {
	int qnaNo, hits, commnet, memberNo, answerCnt;
	String subject, content, pname, replied, user_id, status, ordered_num;
	Date reg_date, answer_date;

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public int getCommnet() {
		return commnet;
	}

	public void setCommnet(int commnet) {
		this.commnet = commnet;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getAnswerCnt() {
		return answerCnt;
	}

	public void setAnswerCnt(int answerCnt) {
		this.answerCnt = answerCnt;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getReplied() {
		return replied;
	}

	public void setReplied(String replied) {
		this.replied = replied;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOrdered_num() {
		return ordered_num;
	}

	public void setOrdered_num(String ordered_num) {
		this.ordered_num = ordered_num;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}

	@Override
	public String toString() {
		return "QnaDTO [qnaNo=" + qnaNo + ", hits=" + hits + ", commnet=" + commnet + ", memberNo=" + memberNo
				+ ", answerCnt=" + answerCnt + ", subject=" + subject + ", content=" + content + ", pname=" + pname
				+ ", replied=" + replied + ", user_id=" + user_id + ", status=" + status + ", ordered_num="
				+ ordered_num + ", reg_date=" + reg_date + ", answer_date=" + answer_date + "]";
	}

}
