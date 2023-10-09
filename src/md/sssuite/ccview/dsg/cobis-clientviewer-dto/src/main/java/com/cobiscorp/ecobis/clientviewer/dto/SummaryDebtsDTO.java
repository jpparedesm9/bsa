package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO which is used in the method getMaxDebt
 * 
 * @author bbuendia
 * 
 */
public class SummaryDebtsDTO implements Serializable {
	private String user;
	private Integer sequence;
	private String typeCon;
	private Integer customer;
	private Integer processId;
	private Integer processIdD;
	private String product;
	private String operationType;
	private String descriptionType;
	private Double amountRisk;
	private Double totalAmountDeal;
	private String numberOperation;
	private String state;
	private Integer customerCon;
	private String debtsType;
	private Double amounLocalMoney;
	private Double usedAmount;
	private Double usedAmoutLocalMoney;
	private Double totalCharges;
	private String warrantyDescription;
	private Date openingDate;
	private Date expirationDate;
	private String currencyDescription;
	private String currencyMnemonic;
	private Double amount;
	private Date shippingDate;
	private String beneficiary;
	private Float rate;
	private Double available;
	private String category;
	private Integer currencyId;
	private Double originalAmount;
	private Double overdueBalance;
	private String role;
	private String rating;
	private Double currentContract;
	private String customerName;
	private Integer daysLate;
	private String office;
	private Date dateCancellation;
	private Integer term;
	private Integer daysOverdue;
	private String reasonCredit;
	private String termType;
	private String refinancing;
	private String reprogramming;
	private String tradeMark;
	private String lineNumber;
	private String associateAmount;
	private String productType;

	public SummaryDebtsDTO() {

	}

	/* Constructor for getAllContingencies */
	public SummaryDebtsDTO(Integer customer, String product, String operationType, String descriptionType, String numberOperation, String warrantyDescription,
			Date openingDate, Date expirationDate, Integer currency, String currencyDescription, Double amount, Date shippingDate, String beneficiary,
			String state, String clientName, String associateAmount) {
		super();
		this.customer = customer;
		this.product = product;
		this.operationType = operationType;
		this.descriptionType = descriptionType;
		this.numberOperation = numberOperation;
		this.warrantyDescription = warrantyDescription;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currencyId = currency;
		this.currencyDescription = currencyDescription;
		this.amount = amount;
		this.shippingDate = shippingDate;
		this.beneficiary = beneficiary;
		this.state = state;
		this.customerName = clientName;
		this.associateAmount = associateAmount;
	}

	/* Constructor for getAllOverdrafts */
	public SummaryDebtsDTO(Integer customer, String product, String descriptionType, String numberOperation, Float rate, String currencyDescription,
			Double usedAmount, Double available, Integer currency, Double amountRisk, String clientName) {
		this.customer = customer;
		this.product = product;
		this.descriptionType = descriptionType;
		this.numberOperation = numberOperation;
		this.rate = rate;
		this.currencyDescription = currencyDescription;
		this.usedAmount = usedAmount;
		this.available = available;
		this.currencyId = currency;
		this.amountRisk = amountRisk;
		this.customerName = clientName;
	}

	// (s.customer, s.product, s.operationType, s.descriptionType,
	// s.processIdD, s.numberOperation, s.state, s.beneficiary, s.rate,
	// s.openingDate, s.expirationDate, c.id,
	// s.originalAmount, s.overdueBalance, s.totalCharges,
	// s.available, s.amounLocalMoney, s.rating, s.currentContract, s.role,
	// 'NCliente')

	/* Constructor for getAllDebtsLoans */
	public SummaryDebtsDTO(Integer customer, String product, String operationType, String descriptionType, Integer processIdD, String numberOperation,
			String state, String beneficiary, Float rate, Date openingDate, Date expirationDate, Integer currency, Double originalAmount,
			Double overdueBalance, Double totalCharges, Double available, Double amounLocalMoney, String rating, Double currentContract, String role,
			String clientName, Date dateCancellation, Double amount, Integer term, Integer daysOverdue, String reasonCredit, String termType,
			String refinancing, String reprogramming, String currencyDescription) {

		this.customer = customer;
		this.product = product;
		this.operationType = operationType;
		this.descriptionType = descriptionType;
		this.processIdD = processIdD;
		this.numberOperation = numberOperation;
		this.state = state;
		this.beneficiary = beneficiary;
		this.rate = rate;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currencyId = currency;
		this.originalAmount = originalAmount;
		this.overdueBalance = overdueBalance;
		this.totalCharges = totalCharges;
		this.available = available;
		this.amounLocalMoney = amounLocalMoney;
		this.rating = rating;
		this.currentContract = currentContract;
		this.role = role;
		this.customerName = clientName;
		this.dateCancellation = dateCancellation;
		this.amount = amount;
		this.term = term;
		this.daysOverdue = daysOverdue;
		this.reasonCredit = reasonCredit;
		this.termType = termType;
		this.refinancing = refinancing;
		this.reprogramming = reprogramming;
		this.currencyDescription = currencyDescription;
	}

	/* Constructor for getMaxDebtAmounts */
	public SummaryDebtsDTO(String user, Integer sequence, String typeCon, Integer customer, Integer processId, Integer processIdD, String product,
			String operationType, String descriptionType, Double amountRisk, String numberOperation, String state, Integer customerCon, String debtsType,
			Double amounLocalMoney, Double usedAmount, Double usedAmoutLocalMoney, Double totalCharges, String warrantyDescription, Date openingDate,
			Date expirationDate, Double amount, Date shippingDate, String beneficiary, Float rate, Double available, String category, Double originalAmount,
			Double overdueBalance, String role, String rating, Double currentContract) {
		this.user = user;
		this.sequence = sequence;
		this.typeCon = typeCon;
		this.customer = customer;
		this.processId = processId;
		this.processIdD = processIdD;
		this.product = product;
		this.operationType = operationType;
		this.descriptionType = descriptionType;
		this.amountRisk = amountRisk;
		this.numberOperation = numberOperation;
		this.state = state;
		this.customerCon = customerCon;
		this.debtsType = debtsType;
		this.amounLocalMoney = amounLocalMoney;
		this.usedAmount = usedAmount;
		this.usedAmoutLocalMoney = usedAmoutLocalMoney;
		this.totalCharges = totalCharges;
		this.warrantyDescription = warrantyDescription;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.amount = amount;
		this.shippingDate = shippingDate;
		this.beneficiary = beneficiary;
		this.rate = rate;
		this.available = available;
		this.category = category;
		this.originalAmount = originalAmount;
		this.overdueBalance = overdueBalance;
		this.role = role;
		this.rating = rating;
		this.currentContract = currentContract;
	}

	/* Constructor for getPledgeAmount */
	public SummaryDebtsDTO(Double totalAmountDeal) {
		this.totalAmountDeal = totalAmountDeal;
	}

	/* Constructor for getPledgeAmount */
	public SummaryDebtsDTO(String user, Double totalAmountDeal) {
		if (overdueBalance == null) {
			this.overdueBalance = (double) 0;
		} else {
			this.overdueBalance = overdueBalance;
		}
		if (available == null) {
			this.available = (double) 0;
		} else {
			this.available = available;
		}
	}

	/* Constructor for getTotalAmountDeal */
	public SummaryDebtsDTO(String user, Integer sequence, Integer customer, Double amountRisk) {

		this.user = user;
		this.sequence = sequence;
		this.customer = customer;
		this.amountRisk = amountRisk;
	}

	public SummaryDebtsDTO(String user, Integer sequence, Integer customer, Double amountRisk, String state, String product, String category) {
		this.user = user;
		this.sequence = sequence;
		this.customer = customer;
		this.amountRisk = amountRisk;
		this.state = state;
		this.product = product;
		this.category = category;
	}

	
	
	public String getAssociateAmount() {
		return associateAmount;
	}

	public void setAssociateAmount(String associateAmount) {
		this.associateAmount = associateAmount;
	}

	public String getRefinancing() {
		return refinancing;
	}

	public void setRefinancing(String refinancing) {
		this.refinancing = refinancing;
	}

	public String getReprogramming() {
		return reprogramming;
	}

	public void setReprogramming(String reprogramming) {
		this.reprogramming = reprogramming;
	}

	public Date getDateCancellation() {
		return dateCancellation;
	}

	public void setDateCancellation(Date dateCancellation) {
		this.dateCancellation = dateCancellation;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public Integer getDaysOverdue() {
		return daysOverdue;
	}

	public void setDaysOverdue(Integer daysOverdue) {
		this.daysOverdue = daysOverdue;
	}

	public String getReasonCredit() {
		return reasonCredit;
	}

	public void setReasonCredit(String reasonCredit) {
		this.reasonCredit = reasonCredit;
	}

	public String getTermType() {
		return termType;
	}

	public void setTermType(String termType) {
		this.termType = termType;
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

	public String getTypeCon() {
		return typeCon;
	}

	public void setTypeCon(String typeCon) {
		this.typeCon = typeCon;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

	public Integer getProcessId() {
		return processId;
	}

	public void setProcessId(Integer processId) {
		this.processId = processId;
	}

	public Integer getProcessIdD() {
		return processIdD;
	}

	public void setProcessIdD(Integer processIdD) {
		this.processIdD = processIdD;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDescriptionType() {
		return descriptionType;
	}

	public void setDescriptionType(String descriptionType) {
		this.descriptionType = descriptionType;
	}

	public Double getAmountRisk() {
		return amountRisk;
	}

	public void setAmountRisk(Double amountRisk) {
		this.amountRisk = amountRisk;
	}

	public String getNumberOperation() {
		return numberOperation;
	}

	public void setNumberOperation(String numberOperation) {
		this.numberOperation = numberOperation;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getCustomerCon() {
		return customerCon;
	}

	public void setCustomerCon(Integer customerCon) {
		this.customerCon = customerCon;
	}

	public String getDebtsType() {
		return debtsType;
	}

	public void setDebtsType(String debtsType) {
		this.debtsType = debtsType;
	}

	public Double getAmounLocalMoney() {
		return amounLocalMoney;
	}

	public void setAmounLocalMoney(Double amounLocalMoney) {
		this.amounLocalMoney = amounLocalMoney;
	}

	public Double getUsedAmoutLocalMoney() {
		return usedAmoutLocalMoney;
	}

	public void setUsedAmoutLocalMoney(Double usedAmoutLocalMoney) {
		this.usedAmoutLocalMoney = usedAmoutLocalMoney;
	}

	public Double getTotalCharges() {
		return totalCharges;
	}

	public void setTotalCharges(Double totalCharges) {
		this.totalCharges = totalCharges;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getWarrantyDescription() {
		return warrantyDescription;
	}

	public void setWarrantyDescription(String warrantyDescription) {
		this.warrantyDescription = warrantyDescription;
	}

	public Date getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(Date openingDate) {
		this.openingDate = openingDate;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getCurrencyDescription() {
		return currencyDescription;
	}

	public void setCurrencyDescription(String currencyDescription) {
		this.currencyDescription = currencyDescription;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Date getShippingDate() {
		return shippingDate;
	}

	public void setShippingDate(Date shippingDate) {
		this.shippingDate = shippingDate;
	}

	public String getBeneficiary() {
		return beneficiary;
	}

	public void setBeneficiary(String beneficiary) {
		this.beneficiary = beneficiary;
	}

	public Double getUsedAmount() {
		return usedAmount;
	}

	public void setUsedAmount(Double usedAmount) {
		this.usedAmount = usedAmount;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Double getAvailable() {
		return available;
	}

	public void setAvailable(Double available) {
		this.available = available;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Integer getCurrencyId() {
		return currencyId;
	}

	public void setCurrencyId(Integer currencyId) {
		this.currencyId = currencyId;
	}

	public Double getOriginalAmount() {
		return originalAmount;
	}

	public void setOriginalAmount(Double originalAmount) {
		this.originalAmount = originalAmount;
	}

	public Double getOverdueBalance() {
		return overdueBalance;
	}

	public void setOverdueBalance(Double overdueBalance) {
		this.overdueBalance = overdueBalance;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public Double getCurrentContract() {
		return currentContract;
	}

	public void setCurrentContract(Double currentContract) {
		this.currentContract = currentContract;
	}

	public String getClientName() {
		return customerName;
	}

	public void setClientName(String clientName) {
		this.customerName = clientName;
	}

	public Double getTotalAmountDeal() {
		return totalAmountDeal;
	}

	public void setTotalAmountDeal(Double totalAmountDeal) {
		this.totalAmountDeal = totalAmountDeal;
	}

	public Integer getDaysLate() {
		return daysLate;
	}

	public void setDaysLate(Integer daysLate) {
		this.daysLate = daysLate;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
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
		SummaryDebtsDTO other = (SummaryDebtsDTO) obj;
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
		return "SummaryDebts [user=" + user + ", sequence=" + sequence + ", typeCon=" + typeCon + ", customer=" + customer + ", processId=" + processId
				+ ", processIdD=" + processIdD + ", product=" + product + ", operationType=" + operationType + ", descriptionType=" + descriptionType
				+ ", amountRisk=" + amountRisk + ", numberOperation=" + numberOperation + ", state=" + state + ", customerCon=" + customerCon + ", debtsType="
				+ debtsType + ", amounLocalMoney=" + amounLocalMoney + ", usedAmount=" + usedAmount + ", usedAmoutLocalMoney=" + usedAmoutLocalMoney
				+ ", totalCharges=" + totalCharges + ", warrantyDescription=" + warrantyDescription + ", openingDate=" + openingDate + ", expirationDate="
				+ expirationDate + ", currencyDescription=" + currencyDescription + ", amount=" + amount + ", shippingDate=" + shippingDate + ", beneficiary="
				+ beneficiary + ", rate=" + rate + ", available=" + available + ", category=" + category + ", currencyId=" + currencyId + ", originalAmount="
				+ originalAmount + ", overdueBalance=" + overdueBalance + ", role=" + role + ", office=" + office + "]";
	}

	public String getTradeMark() {
		return tradeMark;
	}

	public void setTradeMark(String tradeMark) {
		this.tradeMark = tradeMark;
	}

	public String getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
	}

	public String getCurrencyMnemonic() {
		return currencyMnemonic;
	}

	public void setCurrencyMnemonic(String currencyMnemonic) {
		this.currencyMnemonic = currencyMnemonic;
	}
}
