package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * DTO which is used in the method getAllOtherContingencies
 * 
 * @author bbuendia
 * 
 */
public class SummaryOtherDTO implements Serializable {

	private Integer customer;
	private String user;
	private Integer sequence;
	private Integer client;
	private String product;
	private String operationType;
	private String operationTypeDescription;
	private String numberOperation;
	private Integer operation;
	private Integer processed;
	private Integer processedRegistry;
	private Date dateAPRRegistry;
	private Date dateVTCRegistry;
	private String currencyDesc;
	private Double amount;
	private Double amountML;
	private Double balance;
	private Double balanceML;
	private String shipmentDate;
	private String insurance;
	private String beneficiary;
	private String debtType;
	private String clientName;
	private String subTypeId;
	private String subType;
	private String warrantyClassId;
	private String warrantyClass;
	private String office;
	private Date cancellationDate;
	private String status;
	private List<Object> details;
	private String associateAcount;
	private String rol;

	public SummaryOtherDTO() {
	}

	public SummaryOtherDTO(Integer client, String product, String operationType, String operationTypeDescription, String numberOperation, Integer processed,
			Date dateAPR, Date dateVTC, String currencyDesc, Double amount, Double amountML, Double balance, Double balanceML, String shipmentDate,
			String insurance, String beneficiary, String clientName, String subTypeId, String warrantyClassId, 
			String status, String rol) {
		this.client = client;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDescription = operationTypeDescription;
		this.numberOperation = numberOperation;
		this.processed = processed;
		this.dateVTCRegistry = dateVTC;
		this.dateAPRRegistry = dateAPR;
		this.currencyDesc = currencyDesc;
		this.amount = amount;
		this.amountML = amountML;
		this.balance = balance;
		this.balanceML = balanceML;
		this.shipmentDate = shipmentDate;
		this.insurance = insurance;
		this.beneficiary = beneficiary;
		this.clientName = clientName;
		this.warrantyClassId = warrantyClassId;
		this.subTypeId = subTypeId;
		this.status = status;
		this.rol = rol;
	}
	
	public SummaryOtherDTO(Integer client, String product, String operationType, String operationTypeDescription, String numberOperation, Integer processed,
			Date dateAPR, Date dateVTC, String currencyDesc, Double amount, Double amountML, Double balance, Double balanceML, String shipmentDate,
			String insurance, String beneficiary, String clientName, String subTypeId, String warrantyClassId, String associateAcount) {
		this.client = client;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDescription = operationTypeDescription;
		this.numberOperation = numberOperation;
		this.processed = processed;
		this.dateVTCRegistry = dateVTC;
		this.dateAPRRegistry = dateAPR;
		this.currencyDesc = currencyDesc;
		this.amount = amount;
		this.amountML = amountML;
		this.balance = balance;
		this.balanceML = balanceML;
		this.shipmentDate = shipmentDate;
		this.insurance = insurance;
		this.beneficiary = beneficiary;
		this.clientName = clientName;
		this.warrantyClassId = warrantyClassId;
		this.subTypeId = subTypeId;
		this.associateAcount = associateAcount;
	}

	public SummaryOtherDTO(Integer client, String product, String operationType, String operationTypeDescription, String numberOperation, Integer processed,
			Date dateAPR, Date dateVTC, String currencyDesc, Double amount, Double amountML, Double balance, Double balanceML, String shipmentDate,
			String insurance, String beneficiary, String clientName, String subTypeId, String warrantyClassId) {
		this.client = client;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDescription = operationTypeDescription;
		this.numberOperation = numberOperation;
		this.processed = processed;
		this.dateVTCRegistry = dateVTC;
		this.dateAPRRegistry = dateAPR;
		this.currencyDesc = currencyDesc;
		this.amount = amount;
		this.amountML = amountML;
		this.balance = balance;
		this.balanceML = balanceML;
		this.shipmentDate = shipmentDate;
		this.insurance = insurance;
		this.beneficiary = beneficiary;
		this.clientName = clientName;
		this.warrantyClassId = warrantyClassId;
		this.subTypeId = subTypeId;
	}

	public String getAssociateAcount() {
		return associateAcount;
	}

	public void setAssociateAcount(String associateAcount) {
		this.associateAcount = associateAcount;
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

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getOperationTypeDescription() {
		return operationTypeDescription;
	}

	public void setOperationTypeDescription(String operationTypeDescription) {
		this.operationTypeDescription = operationTypeDescription;
	}

	public String getNumberOperation() {
		return numberOperation;
	}

	public void setNumberOperation(String numberOperation) {
		this.numberOperation = numberOperation;
	}

	public Integer getOperation() {
		return operation;
	}

	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	public Integer getProcessed() {
		return processed;
	}

	public void setProcessed(Integer processed) {
		this.processed = processed;
	}

	public Integer getProcessedRegistry() {
		return processedRegistry;
	}

	public void setProcessedRegistry(Integer processedRegistry) {
		this.processedRegistry = processedRegistry;
	}

	public Date getDateAPRRegistry() {
		return dateAPRRegistry;
	}

	public void setDateAPRRegistry(Date dateAPRRegistry) {
		this.dateAPRRegistry = dateAPRRegistry;
	}

	public Date getDateVTCRegistry() {
		return dateVTCRegistry;
	}

	public void setDateVTCRegistry(Date dateVTCRegistry) {
		this.dateVTCRegistry = dateVTCRegistry;
	}

	public String getCurrencyDesc() {
		return currencyDesc;
	}

	public void setCurrencyDesc(String currencyDesc) {
		this.currencyDesc = currencyDesc;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getAmountML() {
		return amountML;
	}

	public void setAmountML(Double amountML) {
		this.amountML = amountML;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public Double getBalanceML() {
		return balanceML;
	}

	public void setBalanceML(Double balanceML) {
		this.balanceML = balanceML;
	}

	public String getShipmentDate() {
		return shipmentDate;
	}

	public void setShipmentDate(String shipmentDate) {
		this.shipmentDate = shipmentDate;
	}

	public String getInsurance() {
		return insurance;
	}

	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}

	public String getBeneficiary() {
		return beneficiary;
	}

	public void setBeneficiary(String beneficiary) {
		this.beneficiary = beneficiary;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getSubTypeId() {
		return subTypeId;
	}

	public void setSubTypeId(String subTypeId) {
		this.subTypeId = subTypeId;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public String getWarrantyClassId() {
		return warrantyClassId;
	}

	public void setWarrantyClassId(String warrantyClassId) {
		this.warrantyClassId = warrantyClassId;
	}

	public String getWarrantyClass() {
		return warrantyClass;
	}

	public void setWarrantyClass(String warrantyClass) {
		this.warrantyClass = warrantyClass;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public Date getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(Date cancellationDate) {
		this.cancellationDate = cancellationDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<Object> getDetails() {
		return details;
	}

	public void setDetails(List<Object> details) {
		this.details = details;
	}
	
	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((customer == null) ? 0 : customer.hashCode());
		result = prime * result + ((sequence == null) ? 0 : sequence.hashCode());
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
		SummaryOtherDTO other = (SummaryOtherDTO) obj;
		if (customer == null) {
			if (other.customer != null)
				return false;
		} else if (!customer.equals(other.customer))
			return false;
		if (sequence == null) {
			if (other.sequence != null)
				return false;
		} else if (!sequence.equals(other.sequence))
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
		return "SummaryOtherDTO [customer=" + customer + ", user=" + user + ", sequence=" + sequence + ", client=" + client + ", product=" + product
				+ ", operationType=" + operationType + ", operationTypeDescription=" + operationTypeDescription + ", numberOperation=" + numberOperation
				+ ", operation=" + operation + ", processed=" + processed + ", processedRegistry=" + processedRegistry + ", dateAPR=" + ", dateVTCRegistry="
				+ dateVTCRegistry + ", currencyDesc=" + currencyDesc + ", amount=" + amount + ", amountML=" + amountML + ", balance=" + balance
				+ ", balanceML=" + balanceML + ", shipmentDate=" + shipmentDate + ", insurance=" + insurance + ", beneficiary=" + beneficiary + ", debtType="
				+ debtType + ", clientName=" + clientName + ", subTypeId=" + subTypeId + ", subType=" + subType + ", warrantyClassId=" + warrantyClassId
				+ ", warrantyClass=" + warrantyClass + ", office=" + office + ", cancellationDate=" + cancellationDate + "]";
	}

}
