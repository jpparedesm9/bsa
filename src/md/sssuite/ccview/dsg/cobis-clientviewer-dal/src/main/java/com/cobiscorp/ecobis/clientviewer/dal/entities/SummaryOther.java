package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.text.SimpleDateFormat;
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
@Table(name = "cr_situacion_otras", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "SummaryOther.getAllOtherContingencies", query = "select new com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO(sc.customer, so.product, so.operationType, so.operationTypeDescription, so.numberOperation, so.processedRegistry, so.dateAPRRegistry, so.dateVTCRegistry, c.mnemonic, so.amount, so.amountML, so.balance, so.balanceML, so.shipmentDate, so.insurance, so.beneficiary, sc.customerName,so.subType,so.warrantyClass,so.status,so.rol)"
		+ " from SummaryOther so left join so.currency c join so.summaryCustomer sc"
		+ " where so.product = 'CEX' and sc.user = :user and sc.sequence = :sequence and sc.processId = 0 and so.debtType = 'D' "
		+ " order by so.dateAPRRegistry DESC, so.processedRegistry, so.operation"),
		
		@NamedQuery(name = "SummaryOther.getOtherContingencies", query = "SELECT CASE so.product"
				+ " WHEN 'CEX' THEN 'CONTINGENTES'"
				+ " ELSE 'NA'"
				+ " END,"
				+ " so.product, so.operationTypeDescription, so.amountML, so.numberOperation, so.insurance FROM  SummaryOther so"
				+ " WHERE  so.product = 'CEX'"
				+ " AND so.customer = :customer"
				+ " AND so.user = :user"
				+ " AND so.debtType = 'D'")})
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_otras bdd: cob_credito
 * @author bbuendia
 *
 */
public class SummaryOther {

	@Id
	@Column(name = "so_cliente")
	private Integer customer;

	@Id
	@Column(name = "so_usuario")
	private String user;

	@Id
	@Column(name = "so_secuencia")
	private Integer sequence;

	@Transient
	private Integer cilent;

	@Column(name = "so_producto")
	private String product;
	@Column(name = "so_tipo_op")
	private String operationType;
	@Column(name = "so_desc_tipo_op")
	private String operationTypeDescription;
	@Column(name = "so_numero_operacion")
	private String numberOperation;
	@Column(name = "so_operacion")
	private Integer operation;

	@Transient
	private Integer processed;
	@Column(name = "so_tramite_d")
	private Integer processedRegistry;

	@Transient
	private String dateAPR; // dd/mm/yy
	@Column(name = "so_fecha_apr")
	private Date dateAPRRegistry;

	@Transient
	private String dateVTC; // dd/mm/yy
	@Column(name = "so_fecha_vct")
	private Date dateVTCRegistry;

	@Transient
	private String currencyDesc;

	@Column(name = "so_monto")
	private Double amount;
	@Column(name = "so_monto_ml")
	private Double amountML;
	@Column(name = "so_saldo_x_vencer")
	private Double balance;
	@Column(name = "so_saldo_vencido")
	private Double balanceML;
	@Column(name = "so_fechas_embarque")
	private String shipmentDate;
	@Column(name = "so_aprobado")
	private String insurance;
	@Column(name = "so_beneficiario")
	private String beneficiary;
	@Column(name = "so_tipo_deuda")
	private String debtType;
	@Column(name = "so_clase_garantia")
	private String warrantyClass;
	@Column(name = "so_subtipo")
	private String subType;

	@Column(name = "so_estado")
	private String status;
	@Column(name = "so_rol")
	private String rol;

	@Transient
	private String clientName;

	@ManyToOne
	@JoinColumn(name = "so_moneda", referencedColumnName = "mo_moneda")
	private Currency currency;

	@ManyToOne
	@JoinColumns({
			@JoinColumn(name = "so_cliente", referencedColumnName = "sc_cliente"),
			@JoinColumn(name = "so_usuario", referencedColumnName = "sc_usuario"),
			@JoinColumn(name = "so_secuencia", referencedColumnName = "sc_secuencia"),
			@JoinColumn(name = "so_tramite", referencedColumnName = "sc_tramite") })
	private SummaryCustomer summaryCustomer;

	public SummaryOther() {
	}

	public SummaryOther(Integer cilent, String product, String operationType,
			String operationTypeDescription, String numberOperation,
			Integer processed, Date dateAPR, Date dateVTC, String currencyDesc,
			Double amount, Double amountML, Double balance, Double balanceML,
			String shipmentDate, String insurance, String beneficiary,
			String clientName, String subType, String warrantyClass,
			String status, String rol) {
		this.cilent = cilent;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDescription = operationTypeDescription;
		this.numberOperation = numberOperation;
		this.processed = processed;

		SimpleDateFormat dateformat = new SimpleDateFormat("dd/mm/yy");
		this.dateAPR = dateformat.format(dateAPR);
		this.dateVTC = dateformat.format(dateVTC);

		this.currencyDesc = currencyDesc;
		this.amount = amount;
		this.amountML = amountML;
		this.balance = balance;
		this.balanceML = balanceML;
		this.shipmentDate = shipmentDate;
		this.insurance = insurance;
		this.beneficiary = beneficiary;
		this.clientName = clientName;
		this.warrantyClass = warrantyClass;
		this.subType = subType;
		this.status = status;
		this.rol = rol;
	}
	
	public SummaryOther(Integer cilent, String product, String operationType,
			String operationTypeDescription, String numberOperation,
			Integer processed, Date dateAPR, Date dateVTC, String currencyDesc,
			Double amount, Double amountML, Double balance, Double balanceML,
			String shipmentDate, String insurance, String beneficiary,
			String clientName, String subType, String warrantyClass) {
		this.cilent = cilent;
		this.product = product;
		this.operationType = operationType;
		this.operationTypeDescription = operationTypeDescription;
		this.numberOperation = numberOperation;
		this.processed = processed;

		SimpleDateFormat dateformat = new SimpleDateFormat("dd/mm/yy");
		this.dateAPR = dateformat.format(dateAPR);
		this.dateVTC = dateformat.format(dateVTC);

		this.currencyDesc = currencyDesc;
		this.amount = amount;
		this.amountML = amountML;
		this.balance = balance;
		this.balanceML = balanceML;
		this.shipmentDate = shipmentDate;
		this.insurance = insurance;
		this.beneficiary = beneficiary;
		this.clientName = clientName;
		this.warrantyClass = warrantyClass;
		this.subType = subType;
	}

	public Integer getCilent() {
		return cilent;
	}

	public void setCilent(Integer cilent) {
		this.cilent = cilent;
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

	public void setNumberOperation(String operation) {
		this.numberOperation = operation;
	}

	public Integer getProcessed() {
		return processed;
	}

	public void setProcessed(Integer processed) {
		this.processed = processed;
	}

	public String getDateAPT() {
		return dateAPR;
	}

	public void setDateAPT(String dateAPT) {
		this.dateAPR = dateAPT;
	}

	public String getDateVTO() {
		return dateVTC;
	}

	public void setDateVTO(String dateVTO) {
		this.dateVTC = dateVTO;
	}

	public String getCurrencyDesc() {
		return currencyDesc;
	}

	public void setCurrencyDesc(String currencyDesc) {
		this.currencyDesc = currencyDesc;
	}

	public String getDateVTC() {
		return dateVTC;
	}

	public void setDateVTC(String dateVTC) {
		this.dateVTC = dateVTC;
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

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getDateAPR() {
		return dateAPR;
	}

	public void setDateAPR(String dateAPR) {
		this.dateAPR = dateAPR;
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

	public Currency getCurrency() {
		return currency;
	}

	public void setCurrency(Currency currency) {
		this.currency = currency;
	}

	public SummaryCustomer getSummaryCustomer() {
		return summaryCustomer;
	}

	public void setSummaryCustomer(SummaryCustomer summaryCustomer) {
		this.summaryCustomer = summaryCustomer;
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

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public Integer getProcessedRegistry() {
		return processedRegistry;
	}

	public void setProcessedRegistry(Integer processedRegistry) {
		this.processedRegistry = processedRegistry;
	}

	public Integer getOperation() {
		return operation;
	}

	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	public String getWarrantyClass() {
		return warrantyClass;
	}

	public void setWarrantyClass(String warrantyClass) {
		this.warrantyClass = warrantyClass;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
		result = prime * result + ((amount == null) ? 0 : amount.hashCode());
		result = prime * result
				+ ((amountML == null) ? 0 : amountML.hashCode());
		result = prime * result + ((balance == null) ? 0 : balance.hashCode());
		result = prime * result
				+ ((balanceML == null) ? 0 : balanceML.hashCode());
		result = prime * result
				+ ((beneficiary == null) ? 0 : beneficiary.hashCode());
		result = prime * result
				+ ((clientName == null) ? 0 : clientName.hashCode());
		result = prime * result + cilent;
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		result = prime * result
				+ ((currencyDesc == null) ? 0 : currencyDesc.hashCode());
		result = prime * result + customer;
		result = prime * result + ((dateAPR == null) ? 0 : dateAPR.hashCode());
		result = prime * result
				+ ((dateAPRRegistry == null) ? 0 : dateAPRRegistry.hashCode());
		result = prime * result + ((dateVTC == null) ? 0 : dateVTC.hashCode());
		result = prime * result
				+ ((dateVTCRegistry == null) ? 0 : dateVTCRegistry.hashCode());
		result = prime * result
				+ ((insurance == null) ? 0 : insurance.hashCode());
		result = prime * result
				+ ((numberOperation == null) ? 0 : numberOperation.hashCode());
		result = prime * result
				+ ((operationType == null) ? 0 : operationType.hashCode());
		result = prime
				* result
				+ ((operationTypeDescription == null) ? 0
						: operationTypeDescription.hashCode());
		result = prime * result + processed;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + sequence;
		result = prime * result
				+ ((shipmentDate == null) ? 0 : shipmentDate.hashCode());
		result = prime * result
				+ ((summaryCustomer == null) ? 0 : summaryCustomer.hashCode());
		result = prime * result + ((subType == null) ? 0 : subType.hashCode());
		result = prime * result
				+ ((warrantyClass == null) ? 0 : warrantyClass.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((rol == null) ? 0 : rol.hashCode());
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
		SummaryOther other = (SummaryOther) obj;
		if (amount == null) {
			if (other.amount != null)
				return false;
		} else if (!amount.equals(other.amount))
			return false;
		if (amountML == null) {
			if (other.amountML != null)
				return false;
		} else if (!amountML.equals(other.amountML))
			return false;
		if (balance == null) {
			if (other.balance != null)
				return false;
		} else if (!balance.equals(other.balance))
			return false;
		if (balanceML == null) {
			if (other.balanceML != null)
				return false;
		} else if (!balanceML.equals(other.balanceML))
			return false;
		if (beneficiary == null) {
			if (other.beneficiary != null)
				return false;
		} else if (!beneficiary.equals(other.beneficiary))
			return false;
		if (clientName == null) {
			if (other.clientName != null)
				return false;
		} else if (!clientName.equals(other.clientName))
			return false;
		if (cilent != other.cilent)
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
		if (customer != other.customer)
			return false;
		if (dateAPR == null) {
			if (other.dateAPR != null)
				return false;
		} else if (!dateAPR.equals(other.dateAPR))
			return false;
		if (dateAPRRegistry == null) {
			if (other.dateAPRRegistry != null)
				return false;
		} else if (!dateAPRRegistry.equals(other.dateAPRRegistry))
			return false;
		if (dateVTC == null) {
			if (other.dateVTC != null)
				return false;
		} else if (!dateVTC.equals(other.dateVTC))
			return false;
		if (dateVTCRegistry == null) {
			if (other.dateVTCRegistry != null)
				return false;
		} else if (!dateVTCRegistry.equals(other.dateVTCRegistry))
			return false;
		if (insurance == null) {
			if (other.insurance != null)
				return false;
		} else if (!insurance.equals(other.insurance))
			return false;
		if (numberOperation == null) {
			if (other.numberOperation != null)
				return false;
		} else if (!numberOperation.equals(other.numberOperation))
			return false;
		if (operationType == null) {
			if (other.operationType != null)
				return false;
		} else if (!operationType.equals(other.operationType))
			return false;
		if (operationTypeDescription == null) {
			if (other.operationTypeDescription != null)
				return false;
		} else if (!operationTypeDescription
				.equals(other.operationTypeDescription))
			return false;
		if (processed != other.processed)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (sequence != other.sequence)
			return false;
		if (shipmentDate == null) {
			if (other.shipmentDate != null)
				return false;
		} else if (!shipmentDate.equals(other.shipmentDate))
			return false;
		if (summaryCustomer == null) {
			if (other.summaryCustomer != null)
				return false;
		} else if (!summaryCustomer.equals(other.summaryCustomer))
			return false;
		if (warrantyClass == null) {
			if (other.warrantyClass != null)
				return false;
		} else if (!warrantyClass.equals(other.warrantyClass))
			return false;
		if (subType == null) {
			if (other.subType != null)
				return false;
		} else if (!subType.equals(other.subType))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (rol == null) {
			if (other.rol != null)
				return false;
		} else if (!rol.equals(other.rol))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SummaryOther [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + ", cilent=" + cilent
				+ ", product=" + product + ", operationType=" + operationType
				+ ", operationTypeDescription=" + operationTypeDescription
				+ ", operation=" + numberOperation + ", processed=" + processed
				+ ", dateAPR=" + dateAPR + ", dateAPRRegistry="
				+ dateAPRRegistry + ", dateVTC=" + dateVTC
				+ ", dateVTCRegistry=" + dateVTCRegistry + ", currencyDesc="
				+ currencyDesc + ", amount=" + amount + ", amountML="
				+ amountML + ", balance=" + balance + ", balanceML="
				+ balanceML + ", shipmentDate=" + shipmentDate + ", insurance="
				+ insurance + ", beneficiary=" + beneficiary + ", clientName="
				+ clientName + ", currency=" + currency + ", summaryCustomer="
				+ summaryCustomer + ", warrantyClass=" + warrantyClass
				+ ", subType=" + subType + ", status=" + status + ", rol=" + rol + "]";

	}
}
