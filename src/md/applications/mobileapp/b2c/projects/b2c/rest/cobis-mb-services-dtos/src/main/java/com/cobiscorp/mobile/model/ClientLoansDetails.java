package com.cobiscorp.mobile.model;

/**
 * 
 * The Class ClientLoansDetails
 * 
 * @author jsanchez
 *
 */
public class ClientLoansDetails {

	private String movementType;
	private String movementDate;
	private String movementValue;
	private String trnState;

	/**
	 * Builder empty
	 */
	public ClientLoansDetails() {
		super();
	}

	/**
	 * Builder with fields
	 * 
	 * @param movementType  the movement type
	 * @param movementDate  the movement date
	 * @param movementValue the movement value
	 * @param trnState      the transaction state
	 */
	public ClientLoansDetails(String movementType, String movementDate, String movementValue, String trnState) {
		super();
		this.movementType = movementType;
		this.movementDate = movementDate;
		this.movementValue = movementValue;
		this.trnState = trnState;
	}

	/**
	 * Get movement type
	 * 
	 * @return the movementType
	 */
	public String getMovementType() {
		return movementType;
	}

	/**
	 * Set movement type
	 * 
	 * @param movementType the movementType to set
	 */
	public void setMovementType(String movementType) {
		this.movementType = movementType;
	}

	/**
	 * Get movement date
	 * 
	 * @return the movementDate
	 */
	public String getMovementDate() {
		return movementDate;
	}

	/**
	 * Set movement date
	 * 
	 * @param movementDate the movementDate to set
	 */
	public void setMovementDate(String movementDate) {
		this.movementDate = movementDate;
	}

	/**
	 * @return the movementValue
	 */
	public String getMovementValue() {
		return movementValue;
	}

	/**
	 * @param movementValue the movementValue to set
	 */
	public void setMovementValue(String movementValue) {
		this.movementValue = movementValue;
	}

	/**
	 * Get transaction state
	 * 
	 * @return the trnState
	 */
	public String getTrnState() {
		return trnState;
	}

	/**
	 * Set transaction state
	 * 
	 * @param trnState the trnState to set
	 */
	public void setTrnState(String trnState) {
		this.trnState = trnState;
	}

}
