package com.cobiscorp.mobile.response;

import java.util.List;

public class AltairResponse {

	private int customerId;
	private List<String> account;
	private String buc;

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public List<String> getAccount() {
		return account;
	}

	public void setAccount(List<String> account) {
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
		return "AltairResponse [customerId=" + customerId + ", account=" + account + ", buc=" + buc + "]";
	}

}
