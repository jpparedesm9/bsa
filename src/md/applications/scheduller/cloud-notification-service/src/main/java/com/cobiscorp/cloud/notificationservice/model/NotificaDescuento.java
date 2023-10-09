package com.cobiscorp.cloud.notificationservice.model;

import java.math.BigDecimal;
import java.util.List;

public class NotificaDescuento {
	private Integer parentOper;
	private String groupName;
	private String groupPresident;
	private String mailTo;
	private float rate;
	private BigDecimal discount;
	private float discountRate;
	private List<DiscountDetail> discountDetailList;
	
	public List<DiscountDetail> getDiscountDetailList() {
		return discountDetailList;
	}
	public void setDiscountDetailList(List<DiscountDetail> discountDetailList) {
		this.discountDetailList = discountDetailList;
	}
	public Integer getParentOper() {
		return parentOper;
	}
	public void setParentOper(Integer parentOper) {
		this.parentOper = parentOper;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupPresident() {
		return groupPresident;
	}
	public void setGroupPresident(String groupPresident) {
		this.groupPresident = groupPresident;
	}
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public float getRate() {
		return rate;
	}
	public void setRate(float rate) {
		this.rate = rate;
	}
	public BigDecimal getDiscount() {
		return discount;
	}
	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}
	public float getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(float discountRate) {
		this.discountRate = discountRate;
	}
	@Override
	public String toString() {
		return "NotificaDescuento [parentOper=" + parentOper + ", groupName=" + groupName + ", groupPresident="
				+ groupPresident + ", mailTo=" + mailTo + ", rate=" + rate + ", discount=" + discount
				+ ", discountRate=" + discountRate + ", discountDetailList=" + discountDetailList + "]";
	}
	
}
