package com.cobiscorp.mobile.model;

/**
 * 
 * The Class ClientLoans
 * 
 * @author jsanchez
 *
 */
public class ClientLoans {

	private String label;
	private String value;

	/**
	 * Builder empty
	 */
	public ClientLoans() {
		super();
	}

	/**
	 * Builder with fields
	 * 
	 * @param operation     the operation
	 * @param operationType the operation type
	 * @param label         the label
	 * @param value         the value
	 */
	public ClientLoans(String label, String value) {
		super();
		this.label = label;
		this.value = value;
	}

	/**
	 * Get label
	 * 
	 * @return the label
	 */
	public String getLabel() {
		return label;
	}

	/**
	 * Set label
	 * 
	 * @param label the label to set
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * Get value
	 * 
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * Set value
	 * 
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

}
