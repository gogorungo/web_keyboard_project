package model.main;

public class MainDTO {
	int MainNo, itemNo;
	String status;
	
	public int getMainNo() {
		return MainNo;
	}
	public void setMainNo(int mainNo) {
		MainNo = mainNo;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "MainDTO [MainNo=" + MainNo + ", itemNo=" + itemNo + ", status=" + status + "]";
	}
	
	
}
