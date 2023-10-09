package com.cobiscorp.ecobis.cloud.service.dto.simulation;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;


public class LoanSimulationRequest extends SimulationData implements InputData {
	
	private double amount;
	private Integer client;
	private Integer currency;
	private String iniDate;
	private String operationType;
	private String periodicity;
	private double rate;
	private Integer term;
	private int channel;	
	private Character promotion;
	
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public Integer getClient() {
		return client;
	}
	public void setClient(Integer client) {
		this.client = client;
	}
	public Integer getCurrency() {
		return currency;
	}
	public void setCurrency(Integer currency) {
		this.currency = currency;
	}
	public String getIniDate() {
		return iniDate;
	}
	public void setIniDate(String iniDate) {
		this.iniDate = iniDate;
	}
	public String getOperationType() {
		return operationType;
	}
	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	public String getPeriodicity() {
		return periodicity;
	}
	public void setPeriodicity(String periodicity) {
		this.periodicity = periodicity;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public Integer getTerm() {
		return term;
	}
	public void setTerm(Integer term) {
		this.term = term;
	}
	public int getChannel() {
		return channel;
	}
	public void setChannel(int channel) {
		this.channel = channel;
	}

	public Character getPromotion() {
		return promotion;
	}
	public void setPromotion(Character promotion) {
		this.promotion = promotion;
	}
	
	@Override
	public boolean isOnline() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void setOnline(boolean online) {
		// TODO Auto-generated method stub
		
	}
	
}
