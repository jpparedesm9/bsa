package com.cobis.cloud.sofom.operationsexecution.santander.dto;

/**
 * @author srojas
 * 
 */
public class SantanderAccountBucDTO {

	private String account;
	private String buc;

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getBuc() {
		return buc;
	}

	public void setBuc(String buc) {
		this.buc = buc;
	}

	@Override
	public String toString() {
		return "SantanderAccountBucDTO [account=" + account + ", buc=" + buc + "]";
	}

}
