package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

public class RenapoClientRequest {
	private String channel;
	private String branch;
	private String transactionType;
	private String transactionId;
	private String curp;

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RenapoClientRequest [channel=");
		builder.append(channel);
		builder.append(", branch=");
		builder.append(branch);
		builder.append(", transactionType=");
		builder.append(transactionType);
		builder.append(", transactionId=");
		builder.append(transactionId);
		builder.append(", curp=");
		builder.append(curp);
		builder.append("]");
		return builder.toString();
	}

}
