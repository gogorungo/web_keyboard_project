package model.cart;

import java.util.Date;

public class CartDTO {
	int cartNo, selected_count;
	String item_name, manufacture, category, switchs, spec;
	String reg_date;
	int price, stock;
	String item_img1, item_img2;
	int memberNo, itemNo;
	
	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getSelected_count() {
		return selected_count;
	}

	public void setSelected_count(int selected_count) {
		this.selected_count = selected_count;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public CartDTO() {
		super();
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

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
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

	@Override
	public String toString() {
		return "CartDTO [cartNo=" + cartNo + ", selected_count=" + selected_count + ", item_name=" + item_name
				+ ", manufacture=" + manufacture + ", category=" + category + ", switchs=" + switchs + ", spec=" + spec
				+ ", reg_date=" + reg_date + ", price=" + price + ", stock=" + stock + ", item_img1=" + item_img1
				+ ", item_img2=" + item_img2 + ", memberNo=" + memberNo + ", itemNo=" + itemNo + "]";
	}
	
	
	
}
