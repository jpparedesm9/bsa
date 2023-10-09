package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(SummaryId.class)
@Table(name = "cr_situacion_lineas", schema = "cob_credito")

@NamedQueries({
		@NamedQuery(name = "SummaryCredits.getSummaryContingencies", query = "SELECT DISTINCT CASE sl.product "
				+ " WHEN 'SGC' THEN 'CONTINGENTES' "
				+ " WHEN 'CRE' THEN 'CONTINGENTES' "
				+ " WHEN 'ATM' THEN 'CONTINGENTES' "
				+ " ELSE 'NA' "
				+ " END, "
				+ " sl.product, sl.product, sl.riskAmount, sl.lineNumber, sl.status FROM  SummaryCredits sl "
				+ " WHERE  sl.user  = :user "
				+ " AND (sl.customer = :customer OR :customer = 0) "
				+ " AND sl.sequence = :sequence "
				//+ " AND (sl.status <> 'PRO' OR sl.status is null)"
				+ " AND sl.lineNumber <> '' "
				+ " AND sl.lineNumber IS NOT NULL "),

		@NamedQuery(name = "SummaryCredits.getAllCreditLines", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO(s.customer, s.operation, CASE WHEN (s.operationType IS NULL OR s.operationType = '') THEN 'CRE' ELSE s.operationType END , s.opTypeDescription, s.lineNumber, s.openingDate, s.expirationDate, c.id, c.mnemonic, s.limitApproved, s.usedAmount, s.usedAmountLocalCurrency, s.available, s.availableLocalCurrency, s.rate, s.contractAmount, s.status, sc.customerName, s.riskAmount, s.product, s.term, s.termType, s.role, s.rotaryType)"
				+ " from SummaryCredits s left join s.currency c left join s.summaryCustomer sc "
				+ " WHERE (s.customer = :customer) AND (s.user = :user) AND (s.sequence = :sequence) AND (s.debtType = 'D') "
				+ " AND s.lineNumber <> '' "
				+ " AND s.lineNumber IS NOT NULL "
				+ " ORDER BY s.openingDate DESC, s.operation, s.lineNumber "),
		
		@NamedQuery(name ="SummaryCredits.getMaxDebtAmounts", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO(s.customer, s.user,s.sequence,s.product,s.operation,s.operationType,s.opTypeDescription,s.lineNumber,s.openingDate,s.expirationDate,s.limitApproved,s.usedAmount,s.usedAmountLocalCurrency,s.available,s.availableLocalCurrency,s.rate,s.contractAmount,s.riskAmount,s.status,s.debtType,s.conType,s.processIdD, s.term, s.termType)"
				+ " FROM SummaryCredits s WHERE  s.user = :user AND s.sequence = :sequence AND s.processIdD = :processId"),
		
		@NamedQuery(name ="SummaryCredits.getCustomerRisk", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO(sl.customer, sl.user, sl.sequence, sl.riskAmount, sl.conType) "
				+ "  FROM  SummaryCredits sl "
				+ "  WHERE sl.user  = :user "
				+ "  AND sl.sequence = :sequence"
				+ "  AND (sl.debtType = 'T' or sl.debtType is null)"
				+ "  AND (sl.customer = :customer OR sl.customer = 0 )")
		})
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_lineas bdd: cob_credito	
 * @author bbuendia
 *
 */
public class SummaryCredits {

	@Id
	@Column(name = "sl_cliente")
	private Integer customer;

	@Id
	@Column(name = "sl_usuario")
	private String user;

	@Id
	@Column(name = "sl_secuencia")
	private Integer sequence;

	@Column(name = "sl_producto")
	private String product;

	@Column(name = "sl_tramite_d")
	private Integer operation;

	@Column(name = "sl_tipo")
	private String operationType;

	@Column(name = "sl_desc_tipo")
	private String opTypeDescription;

	@Column(name = "sl_numero_op_banco")
	private String lineNumber;

	@Column(name = "sl_fecha_apr")
	private Date openingDate;

	@Column(name = "sl_fecha_vct")
	private Date expirationDate;

	@ManyToOne
	@JoinColumn(name = "sl_moneda", referencedColumnName = "mo_moneda")
	private Currency currency;

	@Transient
	private String currencyDescription;

	@Column(name = "sl_limite_credito")
	private Double limitApproved;

	@Column(name = "sl_utilizado_ml")
	private Double usedAmount;

	@Column(name = "sl_val_utilizado")
	private Double usedAmountLocalCurrency;

	@Column(name = "sl_disponible")
	private Double available;

	@Column(name = "sl_disponible_ml")
	private Double availableLocalCurrency;

	@Column(name = "sl_tasa")
	private Float rate;

	@Column(name = "sl_valor_contrato")
	private Double contractAmount;

	@Column(name = "sl_monto_riesgo")
	private Double riskAmount;

	@Column(name = "sl_desc_estado")
	private String status;

	@Column(name = "sl_tipo_deuda")
	private String debtType;
	
	@Column(name = "sl_tipo_con")
	private String conType;

	@Column(name = "sl_plazo")
	private Integer term;
	
	@Column(name = "sl_frecuencia")
	private String termType;

	@Transient
	private String customerName;
	
	@Column(name = "sl_tramite_d")
	private Integer processIdD;

	@Column(name = "sl_rol")
	private String role;
	
	@Column(name = "sl_tipo_rotativo")
	private String rotaryType ;

	@ManyToOne
	@JoinColumns({
			@JoinColumn(name = "sl_cliente_con", referencedColumnName = "sc_cliente_con"),
			@JoinColumn(name = "sl_usuario", referencedColumnName = "sc_usuario"),
			@JoinColumn(name = "sl_secuencia", referencedColumnName = "sc_secuencia"),
			@JoinColumn(name = "sl_tramite", referencedColumnName = "sc_tramite") })
	private SummaryCustomer summaryCustomer;

	public SummaryCredits() {

	}

	public SummaryCredits(Integer customer, Integer operation,
			String operationType, String opTypeDescription, String lineNumber,
			Date openingDate, Date expirationDate, Integer currency,
			String currencyDescription, Double limitApproved,
			Double usedAmount, Double usedAmountLocalCurrency,
			Double available, Double availableLocalCurrency, Float rate,
			Double contractAmount, String status, String customerName) {
		this.customer = customer;
		this.operation = operation;
		this.operationType = operationType;
		this.opTypeDescription = opTypeDescription;
		this.lineNumber = lineNumber;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currency = new Currency();
		this.currency.setId(currency);
		this.currencyDescription = currencyDescription;
		this.limitApproved = limitApproved;
		this.usedAmount = usedAmount;
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
		this.available = available;
		this.availableLocalCurrency = availableLocalCurrency;
		this.rate = rate;
		this.contractAmount = contractAmount;
		this.status = status;
		this.customerName = customerName;
	}

	public SummaryCredits(Integer customer, String user, Integer sequence,
			Double riskAmount, String debtType) {
		super();
		this.customer = customer;
		this.user = user;
		this.sequence = sequence;
		this.riskAmount = riskAmount;
		this.debtType = debtType;
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

	public Integer getOperation() {
		return operation;
	}

	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getOpTypeDescription() {
		return opTypeDescription;
	}

	public void setOpTypeDescription(String opTypeDescription) {
		this.opTypeDescription = opTypeDescription;
	}

	public String getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
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

	public Currency getCurrency() {
		return currency;
	}

	public void setCurrency(Currency currency) {
		this.currency = currency;
	}

	public String getCurrencyDescription() {
		return currencyDescription;
	}

	public void setCurrencyDescription(String currencyDescription) {
		this.currencyDescription = currencyDescription;
	}

	public Double getLimitApproved() {
		return limitApproved;
	}

	public void setLimitApproved(Double limitApproved) {
		this.limitApproved = limitApproved;
	}

	public Double getUsedAmount() {
		return usedAmount;
	}

	public void setUsedAmount(Double usedAmount) {
		this.usedAmount = usedAmount;
	}

	public Double getUsedAmountLocalCurrency() {
		return usedAmountLocalCurrency;
	}

	public void setUsedAmountLocalCurrency(Double usedAmountLocalCurrency) {
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
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

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Double getContractAmount() {
		return contractAmount;
	}

	public void setContractAmount(Double contractAmount) {
		this.contractAmount = contractAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public Double getRiskAmount() {
		return riskAmount;
	}

	public void setRiskAmount(Double riskAmount) {
		this.riskAmount = riskAmount;
	}

	public SummaryCustomer getSummaryCustomer() {
		return summaryCustomer;
	}

	public void setSummaryCustomer(SummaryCustomer summaryCustomer) {
		this.summaryCustomer = summaryCustomer;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}	

	public String getConType() {
		return conType;
	}

	public void setConType(String conType) {
		this.conType = conType;
	}
	
	public Integer getProcessIdD() {
		return processIdD;
	}

	public void setProcessIdD(Integer processIdD) {
		this.processIdD = processIdD;
	}	
	
	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getTermType() {
		return termType;
	}

	public void setTermType(String termType) {
		this.termType = termType;
	}
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRotaryType() {
		return rotaryType;
	}

	public void setRotaryType(String rotaryType) {
		this.rotaryType = rotaryType;
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
		SummaryCredits other = (SummaryCredits) obj;
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
		return "SummaryCredits [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + ", product=" + product
				+ ", operation=" + operation + ", operationType="
				+ operationType + ", opTypeDescription=" + opTypeDescription
				+ ", lineNumber=" + lineNumber + ", openingDate=" + openingDate
				+ ", expirationDate=" + expirationDate + ", currency="
				+ currency + ", currencyDescription=" + currencyDescription
				+ ", limitApproved=" + limitApproved + ", usedAmount="
				+ usedAmount + ", usedAmountLocalCurrency="
				+ usedAmountLocalCurrency + ", available=" + available
				+ ", availableLocalCurrency=" + availableLocalCurrency
				+ ", rate=" + rate + ", contractAmount=" + contractAmount
				+ ", riskAmount=" + riskAmount + ", status=" + status
				+ ", debtType=" + debtType + ", conType=" + conType
				+ ", customerName=" + customerName + ", processIdD="
				+ processIdD + ", summaryCustomer=" + summaryCustomer + "]";
	}

}
