package com.cobiscorp.cobis.loans.reports.dto;

import java.util.HashMap;
import java.util.Map;

public class TransactionContextReport {
	private boolean success;
	private Map<String, Object> data;

	public TransactionContextReport() {
		this(false);
	}

	public TransactionContextReport(boolean putSuccess) {
		this.success = putSuccess;
		this.data = new HashMap<String, Object>();
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public void addValue(String key, Object value) {
		if (this.data.containsKey(key)) {
			this.data.remove(key);
		}
		this.data.put(key, value);
	}

	public Object getValue(String key) {
		return this.data.get(key);
	}

	public void remove(String key) {
		this.data.remove(key);
	}

	public String getStringValue(String key) {
		if (this.data.containsKey(key))
			return this.data.get(key).toString();
		return "";
	}
}
