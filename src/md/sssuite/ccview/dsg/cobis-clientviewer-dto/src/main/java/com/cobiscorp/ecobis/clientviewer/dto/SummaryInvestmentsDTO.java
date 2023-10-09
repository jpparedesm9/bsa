package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO which is used in the method getAllCurrentsAccount
 * 
 * @author bbuendia
 * 
 */
public class SummaryInvestmentsDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer customer;
	private String user;
	private Integer sequence;
	private String product;
	private String typeDescription;
	private String operationNumber;
	private Float rate;
	private Date openingDate;
	private Date expirationDate;
	private String currencyDescription;
	private Date lastMovDate;
	private Double pledgedAmount;
	private Double overdraftLimit;
	private Double balance;
	private Double balanceLocalCurrency;
	private Double available;
	private Double availableLocalCurrency;
	private String status;
	private String statusDescription;
	private Double retentions;
	private Double blockades;
	private String rol;
	private Integer protests;
	private String category;
	private String customerName;
	private Integer term;
	private Date cancellationDate;
	private String officeDescription;

	public SummaryInvestmentsDTO() {

	}

	public SummaryInvestmentsDTO(Integer customer, String product,
			String typeDescription, String operationNumber, Float rate,
			Date openingDate, Date expirationDate, String currencyDescription,
			Double pledgedAmount, Double overdraftLimit, Double balance,
			Double balanceLocalCurrency, Double available,
			Double availableLocalCurrency, Integer protests,
			String statusDescription, Integer currency, String rol,
			Double retentions, Double blockades, String customerName,
			Integer term, Date cancellationDate, String officeDescription) {
		this.customer = customer;
		this.product = product;
		this.typeDescription = typeDescription;
		this.operationNumber = operationNumber;
		this.rate = rate;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currencyDescription = currencyDescription;
		this.pledgedAmount = pledgedAmount;
		this.overdraftLimit = overdraftLimit;
		this.balance = balance;
		this.balanceLocalCurrency = balanceLocalCurrency;
		this.available = available;
		this.availableLocalCurrency = availableLocalCurrency;
		this.protests = protests;
		this.statusDescription = statusDescription;
		this.rol = rol;
		this.retentions = retentions;
		this.blockades = blockades;
		this.customerName = customerName;
		this.term = term;
		this.cancellationDate = cancellationDate;
		this.officeDescription = officeDescription;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getTypeDescription() {
		return typeDescription;
	}

	public void setTypeDescription(String typeDescription) {
		this.typeDescription = typeDescription;
	}

	public String getOperationNumber() {
		return operationNumber;
	}

	public void setOperationNumber(String operationNumber) {
		this.operationNumber = operationNumber;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Date getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(Date openingDate) {
		this.openingDate = openingDate;
	}

	public String getCurrencyDescription() {
		return currencyDescription;
	}

	public void setCurrencyDescription(String currencyDescription) {
		this.currencyDescription = currencyDescription;
	}

	public Date getLastMovDate() {
		return lastMovDate;
	}

	public void setLastMovDate(Date lastMovDate) {
		this.lastMovDate = lastMovDate;
	}

	public Double getPledgedAmount() {
		return pledgedAmount;
	}

	public void setPledgedAmount(Double pledgedAmount) {
		this.pledgedAmount = pledgedAmount;
	}

	public Double getOverdraftLimit() {
		return overdraftLimit;
	}

	public void setOverdraftLimit(Double overdraftLimit) {
		this.overdraftLimit = overdraftLimit;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Double getBalanceLocalCurrency() {
		return balanceLocalCurrency;
	}

	public void setBalanceLocalCurrency(Double balanceLocalCurrency) {
		this.balanceLocalCurrency = balanceLocalCurrency;
	}

	public Double getAvailable() {
		return available;
	}

	public void setAvailable(Double available) {
		this.available = available;
	}

	public Double getAvailableLocalCurrency() {
		return availableLocalCurrency;
	}

	public void setAvailableLocalCurrency(Double availableLocalCurrency) {
		this.availableLocalCurrency = availableLocalCurrency;
	}

	public Integer getProtests() {
		return protests;
	}

	public void setProtests(Integer protests) {
		this.protests = protests;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getRetentions() {
		return retentions;
	}

	public void setRetentions(Double retentions) {
		this.retentions = retentions;
	}

	public Double getBlockades() {
		return blockades;
	}

	public void setBlockades(Double blockades) {
		this.blockades = blockades;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getStatusDescription() {
		return statusDescription;
	}

	public void setStatusDescription(String statusDescription) {
		this.statusDescription = statusDescription;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public Date getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(Date cancellationDate) {
		this.cancellationDate = cancellationDate;
	}

	public String getOfficeDescription() {
		return officeDescription;
	}

	public void setOfficeDescription(String officeDescription) {
		this.officeDescription = officeDescription;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + customer;
		result = prime * result + sequence;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SummaryInvestmentsDTO other = (SummaryInvestmentsDTO) obj;
		if (customer != other.customer)
			return false;
		if (sequence != other.sequence)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SummaryInvestments [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + ", product=" + product
				+ ", typeDescription=" + typeDescription + ", operationNumber="
				+ operationNumber + ", rate=" + rate + ", openingDate="
				+ openingDate + ", expirationDate=" + expirationDate
				+ ", currencyDescription=" + currencyDescription
				+ ", lastMovDate=" + lastMovDate + ", pledgedAmount="
				+ pledgedAmount + ", overdraftLimit=" + overdraftLimit
				+ ", balance=" + balance + ", balanceLocalCurrency="
				+ balanceLocalCurrency + ", available=" + available
				+ ", availableLocalCurrency=" + availableLocalCurrency
				+ ", status=" + status + ", retentions=" + retentions
				+ ", blockades=" + blockades + ", rol=" + rol + ", protests="
				+ protests + ", category=" + category + ", cancellationDate=" 
				+ cancellationDate +", officeDescription=" + officeDescription +"]";
	}

}
