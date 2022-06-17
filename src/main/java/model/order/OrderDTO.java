package model.order;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class OrderDTO {
	int orderNo;
	String ordered_num;
	Date ordered_date;
	int memberNo;
	String name, addr1, addr2, tel;
	Date reg_date;
	int itemNo;
	int select_count;
	String item_name, manufacture, category, switchs, spec;
	int price;
	String item_img1, item_img2;
	String status;
	String refund;
	Date refund_date;
	String zip_code;
	
	public String getDate_format(Date date) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		String date_format = dateFormat.format(date);
		return date_format;
	}
	
	public String getRefund() {
		return refund;
	}
	public void setRefund(String refund) {
		this.refund = refund;
	}
	public Date getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(Date refund_date) {
		this.refund_date = refund_date;
	}
	public int getSelect_count() {
		return select_count;
	}
	public void setSelect_count(int select_count) {
		this.select_count = select_count;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrdered_num() {
		return ordered_num;
	}
	public void setOrdered_num(String ordered_num) {
		this.ordered_num = ordered_num;
	}
	public Date getOrdered_date() {
		return ordered_date;
	}
	public void setOrdered_date(Date ordered_date) {
		this.ordered_date = ordered_date;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getManufacture() {
		return manufacture;
	}
	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSwitchs() {
		return switchs;
	}
	public void setSwitchs(String switchs) {
		this.switchs = switchs;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getItem_img1() {
		return item_img1;
	}
	public void setItem_img1(String item_img1) {
		this.item_img1 = item_img1;
	}
	public String getItem_img2() {
		return item_img2;
	}
	public void setItem_img2(String item_img2) {
		this.item_img2 = item_img2;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getZip_code() {
		return zip_code;
	}
	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}
	@Override
	public String toString() {
		return "OrderDTO [orderNo=" + orderNo + ", ordered_num=" + ordered_num + ", ordered_date=" + ordered_date
				+ ", memberNo=" + memberNo + ", name=" + name + ", addr1=" + addr1 + ", addr2=" + addr2 + ", tel=" + tel
				+ ", reg_date=" + reg_date + ", itemNo=" + itemNo + ", select_count=" + select_count + ", item_name="
				+ item_name + ", manufacture=" + manufacture + ", category=" + category + ", switchs=" + switchs
				+ ", spec=" + spec + ", price=" + price + ", item_img1=" + item_img1 + ", item_img2=" + item_img2
				+ ", status=" + status + ", refund=" + refund + ", refund_date=" + refund_date + ", zip_code="
				+ zip_code + "]";
	}
	
	


	
}
