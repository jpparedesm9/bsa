package com.cobiscorp.ecobis.fpm.portfolio.bo;


public class OpManualStatus {

	/** Banking Product Id. */
	private String productId;

	/** Change Type Id. */
	private String changeType;

	/** Initial Status Id. */
	private String initialStatusId;

	/** Final Status Id. */
	private String finalStatusId;

	/** Start Days */
	private int startDays;

	/** Finish Days */
	private int finishDays;

	/**
	 * Default Constructor.
	 */
	public OpManualStatus() {
	}

	/**
	 * Constructor
	 * 
	 * @param productId
	 * @param changeType
	 * @param initialStatusId
	 * @param finalStatusId
	 * @param startDays
	 * @param finishDays
	 */
	public OpManualStatus(String productId, String changeType,
			String initialStatusId, String finalStatusId, int startDays,
			int finishDays) {
		this.productId = productId;
		this.changeType = changeType;
		this.initialStatusId = initialStatusId;
		this.finalStatusId = finalStatusId;
		this.startDays = startDays;
		this.finishDays = finishDays;
	}

	/**
	 * Get Product Id
	 * 
	 * @return the productId
	 */
	public String getProductId() {
		return productId;
	}

	/**
	 * Set Product Id
	 * 
	 * @param productId
	 *            the productId to set
	 */
	public void setProductId(String productId) {
		this.productId = productId;
	}

	/**
	 * Get Change Type
	 * 
	 * @return the changeType
	 */
	public String getChangeType() {
		return changeType;
	}

	/**
	 * Set Change Type
	 * 
	 * @param changeType
	 *            the changeType to set
	 */
	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	/**
	 * Get Initial Status Id
	 * 
	 * @return the initialStatusId
	 */
	public String getInitialStatusId() {
		return initialStatusId;
	}

	/**
	 * Set Initial Status Id
	 * 
	 * @param initialStatusId
	 *            the initialStatusId to set
	 */
	public void setInitialStatusId(String initialStatusId) {
		this.initialStatusId = initialStatusId;
	}

	/**
	 * Get Final Status Id
	 * 
	 * @return the finalStatusId
	 */
	public String getFinalStatusId() {
		return finalStatusId;
	}

	/**
	 * Set Final Status Id
	 * 
	 * @param finalStatusId
	 *            the finalStatusId to set
	 */
	public void setFinalStatusId(String finalStatusId) {
		this.finalStatusId = finalStatusId;
	}

	/**
	 * Get Start Days
	 * 
	 * @return the startDays
	 */
	public int getStartDays() {
		return startDays;
	}

	/**
	 * Set Start Days
	 * 
	 * @param startDays
	 *            the startDays to set
	 */
	public void setStartDays(int startDays) {
		this.startDays = startDays;
	}

	/**
	 * Get Finish Days
	 * 
	 * @return the finishDays
	 */
	public int getFinishDays() {
		return finishDays;
	}

	/**
	 * Set Finish Days
	 * 
	 * @param finishDays
	 *            the finishDays to set
	 */
	public void setFinishDays(int finishDays) {
		this.finishDays = finishDays;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((changeType == null) ? 0 : changeType.hashCode());
		result = prime * result
				+ ((finalStatusId == null) ? 0 : finalStatusId.hashCode());
		result = prime * result
				+ ((initialStatusId == null) ? 0 : initialStatusId.hashCode());
		result = prime * result
				+ ((productId == null) ? 0 : productId.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OpManualStatus other = (OpManualStatus) obj;
		if (changeType == null) {
			if (other.changeType != null)
				return false;
		} else if (!changeType.equals(other.changeType))
			return false;
		if (finalStatusId == null) {
			if (other.finalStatusId != null)
				return false;
		} else if (!finalStatusId.equals(other.finalStatusId))
			return false;
		if (initialStatusId == null) {
			if (other.initialStatusId != null)
				return false;
		} else if (!initialStatusId.equals(other.initialStatusId))
			return false;
		if (productId == null) {
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		return true;
	}

	public String toString() {
		return "OpManualStatus [productId=" + productId + ", changeType="
				+ changeType + ", initialStatusId=" + initialStatusId
				+ ", finalStatusId=" + finalStatusId + ", startDays="
				+ startDays + ", finishDays=" + finishDays + "]";
	}

	

}
