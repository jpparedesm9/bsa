package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

/**
 * DTO which is used in the method getAllDebtsLoans
 * 
 * @author bbuendia
 * 
 */
public class DebtTmpDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private static ILogger logger = LogFactory.getLogger(DebtTmpDTO.class);

	private Integer spidDebt;
	private Integer client;
	private Integer processed;
	private String product;
	private String operationType;
	private String operationTypeDesc;
	private String operation;
	private String line;
	private String dateApt;
	private String dateVto;
	private String currencyDesc;
	private Double amountOrigin;
	private Double amountLosing;
	private Double amountQuota;
	private Double subtotal;
	private Double amountCapital;
	private Double contractValue;
	private Double amountTotal;
	private Double amountMl;
	private String rate;
	private String refinancing;
	private String nextPaymentDate;
	private String lastPaymentDate;
	private String stateConta;
	private String classification;
	private String state;
	private String typeCar;
	private Integer currency;
	private String role;
	private String stateCode;
	private String clientName;
	private String debtType;
	private Integer daysLate;
	private Integer term;
	private String reason;
	private String typeTerm;
	private String restructuring;
	private Date cancellationDate;
	private String refinanced;
	private Double amountPaid;
	private String calification;
	private String stage;
	private String alternateCode;

	public String getCalification() {
		return calification;
	}

	public void setCalification(String calification) {
		this.calification = calification;
	}

	public Double getAmountPaid() {
		return amountPaid;
	}

	public void setAmountPaid(Double amountPaid) {
		this.amountPaid = amountPaid;
	}

	public Integer getSpidDebt() {
		return spidDebt;
	}

	public void setSpidDebt(Integer spidDebt) {
		this.spidDebt = spidDebt;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public Integer getProcessed() {
		return processed;
	}

	public void setProcessed(Integer processed) {
		this.processed = processed;
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

	public String getOperationTypeDesc() {
		return operationTypeDesc;
	}

	public void setOperationTypeDesc(String operationTypeDesc) {
		this.operationTypeDesc = operationTypeDesc;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getDateApt() {
		return dateApt;
	}

	public void setDateApt(String dateApt) {
		this.dateApt = dateApt;
	}

	public String getDateVto() {
		return dateVto;
	}

	public void setDateVto(String dateVto) {
		this.dateVto = dateVto;
	}

	public String getCurrencyDesc() {
		return currencyDesc;
	}

	public void setCurrencyDesc(String currencyDesc) {
		this.currencyDesc = currencyDesc;
	}

	public Double getAmountOrigin() {
		return amountOrigin;
	}

	public void setAmountOrigin(Double amountOrigin) {
		this.amountOrigin = amountOrigin;
	}

	public Double getAmountLosing() {
		return amountLosing;
	}

	public void setAmountLosing(Double amountLosing) {
		this.amountLosing = amountLosing;
	}

	public Double getAmountQuota() {
		return amountQuota;
	}

	public void setAmountQuota(Double amountQuota) {
		this.amountQuota = amountQuota;
	}

	public Double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(Double subtotal) {
		this.subtotal = subtotal;
	}

	public Double getAmountCapital() {
		return amountCapital;
	}

	public void setAmountCapital(Double amountCapital) {
		this.amountCapital = amountCapital;
	}

	public Double getContractValue() {
		return contractValue;
	}

	public void setContractValue(Double contractValue) {
		this.contractValue = contractValue;
	}

	public Double getAmountTotal() {
		return amountTotal;
	}

	public void setAmountTotal(Double amountTotal) {
		this.amountTotal = amountTotal;
	}

	public Double getAmountMl() {
		return amountMl;
	}

	public void setAmountMl(Double amountMl) {
		this.amountMl = amountMl;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getRefinancing() {
		return refinancing;
	}

	public void setRefinancing(String refinancing) {
		this.refinancing = refinancing;
	}

	public String getNextPaymentDate() {
		return nextPaymentDate;
	}

	public void setNextPaymentDate(String nextPaymentDate) {
		this.nextPaymentDate = nextPaymentDate;
	}

	public String getLastPaymentDate() {
		return lastPaymentDate;
	}

	public void setLastPaymentDate(String lastPaymentDate) {
		this.lastPaymentDate = lastPaymentDate;
	}

	public String getStateConta() {
		return stateConta;
	}

	public void setStateConta(String stateConta) {
		this.stateConta = stateConta;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getTypeCar() {
		return typeCar;
	}

	public void setTypeCar(String typeCar) {
		this.typeCar = typeCar;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public Integer getDaysLate() {
		return daysLate;
	}

	public void setDaysLate(Integer daysLate) {
		this.daysLate = daysLate;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getTypeTerm() {
		return typeTerm;
	}

	public void setTypeTerm(String typeTerm) {
		this.typeTerm = typeTerm;
	}

	public String getRestructuring() {
		return restructuring;
	}

	public void setRestructuring(String restructuring) {
		this.restructuring = restructuring;
	}

	public Date getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(Date cancellationDate) {
		this.cancellationDate = cancellationDate;
	}

	public String getRefinanced() {
		return refinanced;
	}

	public void setRefinanced(String refinanced) {
		this.refinanced = refinanced;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getAlternateCode() {
		return alternateCode;
	}

	public void setAlternateCode(String alternateCode) {
		this.alternateCode = alternateCode;
	}

	public DebtTmpDTO() {
	}

	public DebtTmpDTO(Integer spid, Integer client, Integer processed,
			String product, String operationType, String operationTypeDesc,
			String operation, String line, String dateApt, String dateVto,
			String currencyDesc, Double amountOrigin, Double amountLosing,
			Double amountQuota, Double subtotal, Double amountCapital,
			Double contractValue, Double amountTotal, Double amountMl,
			String rate, String refinancing, String nextPaymentDate,
			String lastPaymentDate, String stateConta, String classification,
			String state, String typeCar, Integer currency, String role,
			String stateCode, String clientName, Integer daysLate,
			Integer term, String reason, String typeTerm, String restructuring,
			Date cancellationDate, String refinanced, String calification,
			String etapa, String alterCode) {

		super();

		this.spidDebt = spid;
		this.client = client;
		this.processed = processed;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDesc = operationTypeDesc;
		this.operation = operation;
		this.line = line;
		this.dateApt = dateApt;
		this.dateVto = dateVto;
		this.currencyDesc = currencyDesc;
		this.amountOrigin = amountOrigin;
		this.amountLosing = amountLosing;
		this.amountQuota = amountQuota;
		this.subtotal = subtotal;
		this.amountCapital = amountCapital;
		this.contractValue = contractValue;
		this.amountTotal = amountTotal;
		this.amountMl = amountMl;
		this.rate = rate;
		this.refinancing = refinancing;
		this.nextPaymentDate = nextPaymentDate;
		this.lastPaymentDate = lastPaymentDate;
		this.stateConta = stateConta;
		this.classification = classification;
		this.state = state;
		this.typeCar = typeCar;
		this.currency = currency;
		if ("G".equals(role)) {
			this.role = "GARANTE";
		} else {
			this.role = role;
		}
		this.stateCode = stateCode;
		this.clientName = clientName;
		this.daysLate = daysLate;
		this.term = term;
		this.reason = reason;
		this.typeTerm = typeTerm;
		this.restructuring = restructuring;
		this.cancellationDate = cancellationDate;
		this.refinanced = refinanced;
		this.calification = calification;
		if (amountCapital != null && amountOrigin != null) {
			this.amountPaid = amountCapital - amountOrigin;
		}
		this.stage = etapa;
		this.alternateCode = alterCode;

	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((amountCapital == null) ? 0 : amountCapital.hashCode());
		result = prime * result
				+ ((amountLosing == null) ? 0 : amountLosing.hashCode());
		result = prime * result
				+ ((amountMl == null) ? 0 : amountMl.hashCode());
		result = prime * result
				+ ((amountOrigin == null) ? 0 : amountOrigin.hashCode());
		result = prime * result
				+ ((amountQuota == null) ? 0 : amountQuota.hashCode());
		result = prime * result
				+ ((amountTotal == null) ? 0 : amountTotal.hashCode());
		result = prime * result
				+ ((classification == null) ? 0 : classification.hashCode());
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result
				+ ((clientName == null) ? 0 : clientName.hashCode());
		result = prime * result
				+ ((contractValue == null) ? 0 : contractValue.hashCode());
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		result = prime * result
				+ ((currencyDesc == null) ? 0 : currencyDesc.hashCode());
		result = prime * result + ((dateApt == null) ? 0 : dateApt.hashCode());
		result = prime * result + ((dateVto == null) ? 0 : dateVto.hashCode());
		result = prime * result
				+ ((lastPaymentDate == null) ? 0 : lastPaymentDate.hashCode());
		result = prime * result + ((line == null) ? 0 : line.hashCode());
		result = prime * result
				+ ((nextPaymentDate == null) ? 0 : nextPaymentDate.hashCode());
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		result = prime * result
				+ ((operationType == null) ? 0 : operationType.hashCode());
		result = prime
				* result
				+ ((operationTypeDesc == null) ? 0 : operationTypeDesc
						.hashCode());
		result = prime * result
				+ ((processed == null) ? 0 : processed.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((rate == null) ? 0 : rate.hashCode());
		result = prime * result
				+ ((refinancing == null) ? 0 : refinancing.hashCode());
		result = prime * result + ((role == null) ? 0 : role.hashCode());
		result = prime * result
				+ ((spidDebt == null) ? 0 : spidDebt.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result
				+ ((stateCode == null) ? 0 : stateCode.hashCode());
		result = prime * result
				+ ((stateConta == null) ? 0 : stateConta.hashCode());
		result = prime * result
				+ ((subtotal == null) ? 0 : subtotal.hashCode());
		result = prime * result + ((typeCar == null) ? 0 : typeCar.hashCode());
		result = prime * result
				+ ((restructuring == null) ? 0 : restructuring.hashCode());
		result = prime
				* result
				+ ((cancellationDate == null) ? 0 : cancellationDate.hashCode());
		result = prime * result
				+ ((refinanced == null) ? 0 : refinanced.hashCode());
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
		DebtTmpDTO other = (DebtTmpDTO) obj;
		if (amountCapital == null) {
			if (other.amountCapital != null)
				return false;
		} else if (!amountCapital.equals(other.amountCapital))
			return false;
		if (amountLosing == null) {
			if (other.amountLosing != null)
				return false;
		} else if (!amountLosing.equals(other.amountLosing))
			return false;
		if (amountMl == null) {
			if (other.amountMl != null)
				return false;
		} else if (!amountMl.equals(other.amountMl))
			return false;
		if (amountOrigin == null) {
			if (other.amountOrigin != null)
				return false;
		} else if (!amountOrigin.equals(other.amountOrigin))
			return false;
		if (amountQuota == null) {
			if (other.amountQuota != null)
				return false;
		} else if (!amountQuota.equals(other.amountQuota))
			return false;
		if (amountTotal == null) {
			if (other.amountTotal != null)
				return false;
		} else if (!amountTotal.equals(other.amountTotal))
			return false;
		if (classification == null) {
			if (other.classification != null)
				return false;
		} else if (!classification.equals(other.classification))
			return false;
		if (client == null) {
			if (other.client != null)
				return false;
		} else if (!client.equals(other.client))
			return false;
		if (clientName == null) {
			if (other.clientName != null)
				return false;
		} else if (!clientName.equals(other.clientName))
			return false;
		if (contractValue == null) {
			if (other.contractValue != null)
				return false;
		} else if (!contractValue.equals(other.contractValue))
			return false;
		if (currency == null) {
			if (other.currency != null)
				return false;
		} else if (!currency.equals(other.currency))
			return false;
		if (currencyDesc == null) {
			if (other.currencyDesc != null)
				return false;
		} else if (!currencyDesc.equals(other.currencyDesc))
			return false;
		if (dateApt == null) {
			if (other.dateApt != null)
				return false;
		} else if (!dateApt.equals(other.dateApt))
			return false;
		if (dateVto == null) {
			if (other.dateVto != null)
				return false;
		} else if (!dateVto.equals(other.dateVto))
			return false;
		if (lastPaymentDate == null) {
			if (other.lastPaymentDate != null)
				return false;
		} else if (!lastPaymentDate.equals(other.lastPaymentDate))
			return false;
		if (line == null) {
			if (other.line != null)
				return false;
		} else if (!line.equals(other.line))
			return false;
		if (nextPaymentDate == null) {
			if (other.nextPaymentDate != null)
				return false;
		} else if (!nextPaymentDate.equals(other.nextPaymentDate))
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		if (operationType == null) {
			if (other.operationType != null)
				return false;
		} else if (!operationType.equals(other.operationType))
			return false;
		if (operationTypeDesc == null) {
			if (other.operationTypeDesc != null)
				return false;
		} else if (!operationTypeDesc.equals(other.operationTypeDesc))
			return false;
		if (processed == null) {
			if (other.processed != null)
				return false;
		} else if (!processed.equals(other.processed))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (rate == null) {
			if (other.rate != null)
				return false;
		} else if (!rate.equals(other.rate))
			return false;
		if (refinancing == null) {
			if (other.refinancing != null)
				return false;
		} else if (!refinancing.equals(other.refinancing))
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		if (spidDebt == null) {
			if (other.spidDebt != null)
				return false;
		} else if (!spidDebt.equals(other.spidDebt))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (stateCode == null) {
			if (other.stateCode != null)
				return false;
		} else if (!stateCode.equals(other.stateCode))
			return false;
		if (stateConta == null) {
			if (other.stateConta != null)
				return false;
		} else if (!stateConta.equals(other.stateConta))
			return false;
		if (subtotal == null) {
			if (other.subtotal != null)
				return false;
		} else if (!subtotal.equals(other.subtotal))
			return false;
		if (typeCar == null) {
			if (other.typeCar != null)
				return false;
		} else if (!typeCar.equals(other.typeCar))
			return false;
		if (restructuring == null) {
			if (other.restructuring != null)
				return false;
		} else if (!restructuring.equals(other.restructuring))
			return false;
		if (cancellationDate == null) {
			if (other.cancellationDate != null)
				return false;
		} else if (!cancellationDate.equals(other.cancellationDate))
			return false;
		if (refinanced == null) {
			if (other.refinanced != null)
				return false;
		} else if (!refinanced.equals(other.refinanced))
			return false;

		return true;
	}

	@Override
	public String toString() {
		return "DebtTmpDTO [spidDebt=" + spidDebt + ", client=" + client
				+ ", processed=" + processed + ", product=" + product
				+ ", operationType=" + operationType + ", operationTypeDesc="
				+ operationTypeDesc + ", operation=" + operation + ", line="
				+ line + ", dateApt=" + dateApt + ", dateVto=" + dateVto
				+ ", currencyDesc=" + currencyDesc + ", amountOrigin="
				+ amountOrigin + ", amountLosing=" + amountLosing
				+ ", amountQuota=" + amountQuota + ", subtotal=" + subtotal
				+ ", amountCapital=" + amountCapital + ", contractValue="
				+ contractValue + ", amountTotal=" + amountTotal
				+ ", amountMl=" + amountMl + ", rate=" + rate
				+ ", refinancing=" + refinancing + ", nextPaymentDate="
				+ nextPaymentDate + ", lastPaymentDate=" + lastPaymentDate
				+ ", stateConta=" + stateConta + ", classification="
				+ classification + ", state=" + state + ", typeCar=" + typeCar
				+ ", currency=" + currency + ", role=" + role + ", stateCode="
				+ stateCode + ", clientName=" + clientName + ", debtType="
				+ debtType + ", restructuring=" + restructuring
				+ ", cancellationDate=" + cancellationDate + ", refinanced="
				+ refinanced + "]";
	}

}
