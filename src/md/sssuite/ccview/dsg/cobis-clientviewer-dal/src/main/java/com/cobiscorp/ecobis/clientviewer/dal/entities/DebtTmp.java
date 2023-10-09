package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

//new com.cobiscorp.ecobis.clientviewer.dal.entities.DebtTmp(d.spid, d.client,
//d.processed, d.product, d.operationType, d.operationTypeDesc,d.operation,
//d.line, d.dateApt, d.dateVto,d.currencyDesc, d.amountOrigin,
//d.amountLosing,d.amountQuota, d.subtotal, d.amountCapital,d.contractValue,
//d.amountTotal, d.amountMl,d.rate, d.refinancing,
//d.nextPaymentDate,d.lastPaymentDate, d.stateConta, d.classification,d.state,
//d.typeCar, d.currency, d.role,d.stateCode, d.clientName)

@Entity
@IdClass(DebtTmpId.class)
@Table(name = "cr_deud1_tmp", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "DebtTmp.getAllDebtsLoans", query = "select new com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO(d.spidDebt, d.client, d.processed, d.product, d.operationType, d.operationTypeDesc, d.operation, d.line, d.dateApt, d.dateVto, d.currencyDesc, d.amountOrigin, d.amountLosing, d.amountQuota, d.subtotal, d.amountCapital, d.contractValue, d.amountTotal, d.amountMl, d.rate, d.refinancing, d.nextPaymentDate, d.lastPaymentDate, d.stateConta, d.classification, d.state, d.typeCar, d.currency, d.role, d.stateCode, d.clientName, d.daysLate, d.term, d.reason, d.typeTerm, d.restructuring, d.cancellationDate, d.refinanced, d.calification,d.etapa, d.codigoAlterno)"
		+ " from DebtTmp d" + " where d.processed > 0 and d.spidDebt = :spid and d.debtType = :debtType and (d.stateConta not in ('CREDITO', 'NO VIGENTE') OR d.stateConta is null) ORDER BY d.dateApt DESC"),
@NamedQuery(name = "DebtTmp.getAllInProgresRequest", query = "select new com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO(d.spidDebt, d.client, d.processed, d.product, d.operationType, d.operationTypeDesc, d.operation, d.line, d.dateApt, d.dateVto, d.currencyDesc, d.amountOrigin, d.amountLosing, d.amountQuota, d.subtotal, d.amountCapital, d.contractValue, d.amountTotal, d.amountMl, d.rate, d.refinancing, d.nextPaymentDate, d.lastPaymentDate, d.stateConta, d.classification, d.state, d.typeCar, d.currency, d.role, d.stateCode, d.clientName, d.daysLate, d.term, d.reason, d.typeTerm, d.restructuring, d.cancellationDate, d.refinanced, d.calification, d.etapa, d.codigoAlterno)"
		+ " from DebtTmp d" + " where d.processed > 0 and d.spidDebt = :spid and d.debtType = '' and d.stateCode in ('0','98','99') ORDER BY d.dateApt DESC")
})
@NamedNativeQueries({ @NamedNativeQuery(name = "DebtTmp.delete", query = "Delete from cob_credito..cr_deud1_tmp where spid = ?1") })
/**
 * Class used to access the database using JPA
 * related table: cr_deud1_tmp bdd: cob_credito
 * @author bbuendia
 *
 */
public class DebtTmp {

	@Id
	@Column(name = "spid")
	private Integer spidDebt;
	@Id
	@Column(name = "cliente")
	private Integer client;
	@Id
	@Column(name = "tramite")
	private Integer processed;

	@Column(name = "producto")
	private String product;
	@Column(name = "tipo_operacion")
	private String operationType;
	@Column(name = "desc_tipo_op")
	private String operationTypeDesc;
	@Column(name = "operacion")
	private String operation;
	@Column(name = "linea")
	private String line;
	@Column(name = "fecha_apt")
	private String dateApt;
	@Column(name = "fecha_vto")
	private String dateVto;
	@Column(name = "desc_moneda")
	private String currencyDesc;
	@Column(name = "monto_orig")
	private Double amountOrigin;
	@Column(name = "saldo_vencido")
	private Double amountLosing;
	@Column(name = "saldo_cuota")
	private Double amountQuota;
	@Column(name = "subtotal")
	private Double subtotal;
	@Column(name = "saldo_capital")
	private Double amountCapital;
	@Column(name = "valorcontrato")
	private Double contractValue;
	@Column(name = "saldo_total")
	private Double amountTotal;
	@Column(name = "saldo_ml")
	private Double amountMl;
	@Column(name = "tasa")
	private String rate;
	@Column(name = "refinanciamiento")
	private String refinancing;
	@Column(name = "prox_fecha_pag_int")
	private String nextPaymentDate;
	@Column(name = "ult_fecha_pg")
	private String lastPaymentDate;
	@Column(name = "estado_conta")
	private String stateConta;
	@Column(name = "clasificacion")
	private String classification;
	@Column(name = "estado")
	private String state;
	@Column(name = "tipocar")
	private String typeCar;
	@Column(name = "moneda")
	private Integer currency;
	@Column(name = "rol")
	private String role;
	@Column(name = "cod_estado")
	private String stateCode;
	@Column(name = "nombre_cliente")
	private String clientName;
	@Column(name = "tipo_deuda")
	private String debtType;
	@Column(name = "dias_atraso")
	private Integer daysLate;
	@Column(name = "plazo")
	private Integer term;
	@Column(name = "motivo_credito")
	private String reason;
	@Column(name = "tipo_plazo")
	private String typeTerm;
	@Column(name = "restructuracion")
	private String restructuring;
	@Column(name = "fecha_cancelacion")
	private Date cancellationDate;
	@Column(name = "refinanciado")
	private String refinanced;
	@Column(name = "calificacion")
	private String calification;
	@Column(name = "etapa_act")
	private String etapa;
	@Column(name = "codigo_alterno")
	private String codigoAlterno;

	public DebtTmp() {

	}

	public DebtTmp(Integer spid, Integer client, Integer processed, String product, String operationType, String operationTypeDesc, String operation, String line, String dateApt,
			String dateVto, String currencyDesc, Double amountOrigin, Double amountLosing, Double amountQuota, Double subtotal, Double amountCapital, Double contractValue,
			Double amountTotal, Double amountMl, String rate, String refinancing, String nextPaymentDate, String lastPaymentDate, String stateConta, String classification,
			String state, String typeCar, Integer currency, String role, String stateCode, String clientName) {
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
		this.role = role;
		this.stateCode = stateCode;
		this.clientName = clientName;
	}

	public Integer getSpid() {
		return spidDebt;
	}

	public void setSpid(Integer spid) {
		this.spidDebt = spid;
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

	public Integer getSpidDebt() {
		return spidDebt;
	}

	public void setSpidDebt(Integer spidDebt) {
		this.spidDebt = spidDebt;
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

	public String getCalification() {
		return calification;
	}

	public void setCalification(String calification) {
		this.calification = calification;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((amountCapital == null) ? 0 : amountCapital.hashCode());
		result = prime * result + ((amountLosing == null) ? 0 : amountLosing.hashCode());
		result = prime * result + ((amountMl == null) ? 0 : amountMl.hashCode());
		result = prime * result + ((amountOrigin == null) ? 0 : amountOrigin.hashCode());
		result = prime * result + ((amountQuota == null) ? 0 : amountQuota.hashCode());
		result = prime * result + ((amountTotal == null) ? 0 : amountTotal.hashCode());
		result = prime * result + ((classification == null) ? 0 : classification.hashCode());
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result + ((clientName == null) ? 0 : clientName.hashCode());
		result = prime * result + ((contractValue == null) ? 0 : contractValue.hashCode());
		result = prime * result + ((currency == null) ? 0 : currency.hashCode());
		result = prime * result + ((currencyDesc == null) ? 0 : currencyDesc.hashCode());
		result = prime * result + ((dateApt == null) ? 0 : dateApt.hashCode());
		result = prime * result + ((dateVto == null) ? 0 : dateVto.hashCode());
		result = prime * result + ((lastPaymentDate == null) ? 0 : lastPaymentDate.hashCode());
		result = prime * result + ((line == null) ? 0 : line.hashCode());
		result = prime * result + ((nextPaymentDate == null) ? 0 : nextPaymentDate.hashCode());
		result = prime * result + ((operation == null) ? 0 : operation.hashCode());
		result = prime * result + ((operationType == null) ? 0 : operationType.hashCode());
		result = prime * result + ((operationTypeDesc == null) ? 0 : operationTypeDesc.hashCode());
		result = prime * result + ((processed == null) ? 0 : processed.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((rate == null) ? 0 : rate.hashCode());
		result = prime * result + ((refinancing == null) ? 0 : refinancing.hashCode());
		result = prime * result + ((role == null) ? 0 : role.hashCode());
		result = prime * result + ((spidDebt == null) ? 0 : spidDebt.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((stateCode == null) ? 0 : stateCode.hashCode());
		result = prime * result + ((stateConta == null) ? 0 : stateConta.hashCode());
		result = prime * result + ((subtotal == null) ? 0 : subtotal.hashCode());
		result = prime * result + ((typeCar == null) ? 0 : typeCar.hashCode());
		result = prime * result + ((restructuring == null) ? 0 : restructuring.hashCode());
		result = prime * result + ((cancellationDate == null) ? 0 : cancellationDate.hashCode());
		result = prime * result + ((refinanced == null) ? 0 : refinanced.hashCode());
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
		DebtTmp other = (DebtTmp) obj;
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
		return "DebtTmp [spid=" + spidDebt + ", client=" + client + ", processed=" + processed + ", product=" + product + ", operationType=" + operationType
				+ ", operationTypeDesc=" + operationTypeDesc + ", operation=" + operation + ", line=" + line + ", dateApt=" + dateApt + ", dateVto=" + dateVto + ", currencyDesc="
				+ currencyDesc + ", amountOrigin=" + amountOrigin + ", amountLosing=" + amountLosing + ", amountQuota=" + amountQuota + ", subtotal=" + subtotal
				+ ", amountCapital=" + amountCapital + ", contractValue=" + contractValue + ", amountTotal=" + amountTotal + ", amountMl=" + amountMl + ", rate=" + rate
				+ ", refinancing=" + refinancing + ", nextPaymentDate=" + nextPaymentDate + ", lastPaymentDate=" + lastPaymentDate + ", stateConta=" + stateConta
				+ ", classification=" + classification + ", state=" + state + ", typeCar=" + typeCar + ", currency=" + currency + ", role=" + role + ", stateCode=" + stateCode
				+ ", clientName=" + clientName + ", restructuring=" + restructuring + ", cancellationDate=" + cancellationDate + ", refinanced=" + refinanced + "]";
	}

}
