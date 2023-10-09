package com.cobiscorp.mobile.model;

import java.util.Objects;

public class ShapeOfPayment {

	private double minimumPayment;
	private double maximumPayment;
	private String referencePayment;
	private String deadlinePayment;
	private String emailClient;
	private double valuePayment;

	public ShapeOfPayment() {
		super();
	}

	public ShapeOfPayment(double minimumPayment, double maximumPayment, String referencePayment, String deadlinePayment,
			String emailClient, double valuePayment) {
		this.minimumPayment = minimumPayment;
		this.maximumPayment = maximumPayment;
		this.referencePayment = referencePayment;
		this.deadlinePayment = deadlinePayment;
		this.emailClient = emailClient;
		this.valuePayment = valuePayment;
	}

	public ShapeOfPayment minimumPayment(double minimumPayment) {
		this.minimumPayment = minimumPayment;
		return this;
	}

	/**
	 * get minimumPayment
	 * 
	 * @return
	 */
	public double getMinimumPayment() {
		return minimumPayment;
	}

	public void setMinimumPayment(double minimumPayment) {
		this.minimumPayment = minimumPayment;
	}

	public ShapeOfPayment maximumPayment(double maximumPayment) {
		this.maximumPayment = maximumPayment;
		return this;
	}

	/**
	 * get maximumPayment
	 * 
	 * @return
	 */
	public double getMaximumPayment() {
		return maximumPayment;
	}

	public void setMaximumPayment(double maximumPayment) {
		this.maximumPayment = maximumPayment;
	}

	public ShapeOfPayment referencePayment(String referencePayment) {
		this.referencePayment = referencePayment;
		return this;
	}

	/**
	 * get referencePayment
	 * 
	 * @return
	 */
	public String getReferencePayment() {
		return referencePayment;
	}

	public void setReferencePayment(String referencePayment) {
		this.referencePayment = referencePayment;
	}

	public ShapeOfPayment deadlinePayment(String deadlinePayment) {
		this.deadlinePayment = deadlinePayment;
		return this;
	}

	/**
	 * get referencePayment
	 * 
	 * @return
	 */

	public String getDeadlinePayment() {
		return deadlinePayment;
	}

	public void setDeadlinePayment(String deadlinePayment) {
		this.deadlinePayment = deadlinePayment;
	}

	public ShapeOfPayment emailClient(String emailClient) {
		this.emailClient = emailClient;
		return this;
	}

	/**
	 * get referencePayment
	 * 
	 * @return
	 */

	public String getEmailClient() {
		return emailClient;
	}

	public void setEmailClient(String emailClient) {
		this.emailClient = emailClient;
	}

	public ShapeOfPayment valuePayment(double valuePayment) {
		this.valuePayment = valuePayment;
		return this;
	}

	/**
	 * get referencePayment
	 * 
	 * @return
	 */

	public double getValuePayment() {
		return valuePayment;
	}

	public void setValuePayment(double valuePayment) {
		this.valuePayment = valuePayment;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}

		ShapeOfPayment shapeOfPayment = (ShapeOfPayment) o;
		return Objects.equals(this.minimumPayment, shapeOfPayment.minimumPayment)
				&& Objects.equals(this.maximumPayment, shapeOfPayment.maximumPayment)
				&& Objects.equals(this.referencePayment, shapeOfPayment.referencePayment)
				&& Objects.equals(this.deadlinePayment, shapeOfPayment.deadlinePayment)
				&& Objects.equals(this.emailClient, shapeOfPayment.emailClient)
				&& Objects.equals(this.valuePayment, shapeOfPayment.valuePayment);
	}

	@Override
	public int hashCode() {
		return Objects.hash(minimumPayment, maximumPayment, referencePayment, deadlinePayment, emailClient,
				valuePayment);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class ShapeOfPayment {\n");

		sb.append("    minimumPayment: ").append(toIndentedString(minimumPayment)).append("\n");
		sb.append("    maximumPayment: ").append(toIndentedString(maximumPayment)).append("\n");
		sb.append("    referencePayment: ").append(toIndentedString(referencePayment)).append("\n");
		sb.append("    deadlinePayment: ").append(toIndentedString(deadlinePayment)).append("\n");
		sb.append("    emailClient: ").append(toIndentedString(emailClient)).append("\n");
		sb.append("    valuePayment: ").append(toIndentedString(valuePayment)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces
	 * (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}
}
