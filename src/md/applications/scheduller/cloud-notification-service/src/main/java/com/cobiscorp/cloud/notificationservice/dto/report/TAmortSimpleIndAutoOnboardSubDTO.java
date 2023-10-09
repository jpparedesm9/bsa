package com.cobiscorp.cloud.notificationservice.dto.report;

public class TAmortSimpleIndAutoOnboardSubDTO {

	private Integer dividend;
	private String expirationDate;
	private Double capital;
	private Double ordinarInterest;
	private Double interestIVA;
	private Double balance;
	private Double share;

	public Integer getDividend() {
		return dividend;
	}

	public void setDividend(Integer dividend) {
		this.dividend = dividend;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Double getCapital() {
		return capital;
	}

	public void setCapital(Double capital) {
		this.capital = capital;
	}

	public Double getOrdinarInterest() {
		return ordinarInterest;
	}

	public void setOrdinarInterest(Double ordinarInterest) {
		this.ordinarInterest = ordinarInterest;
	}

	public Double getInterestIVA() {
		return interestIVA;
	}

	public void setInterestIVA(Double interestIVA) {
		this.interestIVA = interestIVA;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Double getShare() {
		return share;
	}

	public void setShare(Double share) {
		this.share = share;
	}

}
