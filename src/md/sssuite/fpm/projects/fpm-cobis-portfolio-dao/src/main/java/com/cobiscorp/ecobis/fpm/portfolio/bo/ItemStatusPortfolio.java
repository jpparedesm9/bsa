package com.cobiscorp.ecobis.fpm.portfolio.bo;


public class ItemStatusPortfolio {

	/** Banking Product Id. */
	private String operation;

	/** Items Id. */
	private String itemId;

	/** Status Id */
	private String statusId;

	/** Start Days */
	private int startdays;

	/** Finish Days */
	private int finishdays;

	/**
	 * Default Constructor.
	 */
	public ItemStatusPortfolio() {
	}

	/**
	 * Constructor
	 * 
	 * @param productId
	 * @param itemId
	 * @param statusId
	 * @param startdays
	 * @param finishdays
	 */
	public ItemStatusPortfolio(String operation, String itemId, String statusId,
			int startdays, int finishdays) {
		this.operation = operation;
		this.itemId = itemId;
		this.statusId = statusId;
		this.startdays = startdays;
		this.finishdays = finishdays;
	}

	/**
	 * Get Operation type
	 * 
	 * @return the productId
	 */
	public String getOperation() {
		return operation;
	}

	/**
	 * Set Operation type
	 * 
	 * @param productId
	 *            the productId to set
	 */
	public void setOperation(String operation) {
		this.operation = operation;
	}

	/**
	 * Get Item ID
	 * 
	 * @return the itemId
	 */
	public String getItemId() {
		return itemId;
	}

	/**
	 * Set Item ID
	 * 
	 * @param itemId
	 *            the itemId to set
	 */
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	/**
	 * Get Status ID
	 * 
	 * @return the statusId
	 */
	public String getStatusId() {
		return statusId;
	}

	/**
	 * Set Status ID
	 * 
	 * @param statusId
	 *            the statusId to set
	 */
	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}

	/**
	 * Get Start Days
	 * 
	 * @return the startdays
	 */
	public int getStartdays() {
		return startdays;
	}

	/**
	 * Set Start Days
	 * 
	 * @param startdays
	 *            the startdays to set
	 */
	public void setStartdays(int startdays) {
		this.startdays = startdays;
	}

	/**
	 * Get Finish Days
	 * 
	 * @return the finishdays
	 */
	public int getFinishdays() {
		return finishdays;
	}

	/**
	 * Set Finish Days
	 * 
	 * @param finishdays
	 *            the finishdays to set
	 */
	public void setFinishdays(int finishdays) {
		this.finishdays = finishdays;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((itemId == null) ? 0 : itemId.hashCode());
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		result = prime * result
				+ ((statusId == null) ? 0 : statusId.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemStatusPortfolio other = (ItemStatusPortfolio) obj;
		if (itemId == null) {
			if (other.itemId != null)
				return false;
		} else if (!itemId.equals(other.itemId))
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		if (statusId == null) {
			if (other.statusId != null)
				return false;
		} else if (!statusId.equals(other.statusId))
			return false;
		return true;
	}

	public String toString() {
		return "ItemStatus [operation=" + operation + ", itemId=" + itemId
				+ ", statusId=" + statusId + ", startdays=" + startdays
				+ ", finishdays=" + finishdays + "]";
	}

}
