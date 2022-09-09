package model.main;

import java.util.Date;

public class MainNoticeDTO {

	int MainNoticeNo, noticeNo;
	String subject, pname, status;
	Date reg_date;

	public int getMainNoticeNo() {
		return MainNoticeNo;
	}

	public void setMainNoticeNo(int mainNoticeNo) {
		MainNoticeNo = mainNoticeNo;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "MainNoticeDTO [MainNoticeNo=" + MainNoticeNo + ", noticeNo=" + noticeNo + ", subject=" + subject
				+ ", pname=" + pname + ", status=" + status + ", reg_date=" + reg_date + "]";
	}
	
}
