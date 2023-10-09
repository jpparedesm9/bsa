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
@Table(name = "cr_situacion_inversiones", schema = "cob_credito")
@NamedQueries({
		@NamedQuery(name = "SummaryInvestments.getSummaryFixedTerms", query = "SELECT 'PASIVAS', si.product, si.typeDescription, si.balanceLocalCurrency,"
				+ " si.operationNumber , si.statusDescription  FROM  SummaryInvestments si" + " WHERE si.user = :user" + "   AND (si.customer = :customer OR :customer = 0)"
				+ "   AND si.sequence = :sequence" + "   AND ((si.status = 'A') OR (si.status IS NULL) OR (si.status ='ACT'))" + "   AND si.product  = 'PFI'" + "   AND si.rol = 'T'"),

		@NamedQuery(name = "SummaryInvestments.getSummayAccounts", query = "SELECT 'PASIVAS', si.product, si.typeDescription, si.balanceLocalCurrency,"
				+ " si.operationNumber , si.statusDescription  FROM  SummaryInvestments si" + " WHERE si.user = :user" + "   AND (si.customer = :customer OR :customer = 0)"
				+ "   AND si.sequence = :sequence" + "   AND ((si.status = 'A') OR (si.status IS NULL) OR (si.status ='I'))" + "   AND si.product  <> 'PFI'"
				+ "   AND si.rol IN ('T','C')"),

		@NamedQuery(name = "SummaryInvestments.getAllCurrentsAccount", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO(s.customer, s.product, s.typeDescription, s.operationNumber, s.rate, s.openingDate, s.expirationDate, c.mnemonic, s.pledgedAmount, s.overdraftLimit, s.balance, s.balanceLocalCurrency, s.available, s.availableLocalCurrency, s.protests, s.statusDescription, c.id, s.rol, s.retentions, s.blockades, sc.customerName, s.term, s.cancellationDate, s.officeDescription)"
				+ " from SummaryInvestments s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE (s.customer = :customer OR :customer = 0) AND (s.product = 'CTE') AND (s.user = :user) AND (s.sequence = :sequence) ORDER BY s.openingDate,s.operationNumber DESC"),

		@NamedQuery(name = "SummaryInvestments.getAllSavingsAccount", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO(s.customer, s.product, s.typeDescription, s.operationNumber, s.rate, s.openingDate, s.expirationDate, c.mnemonic, s.pledgedAmount, s.overdraftLimit, s.balance, s.balanceLocalCurrency, s.available, s.availableLocalCurrency, s.protests, s.statusDescription, c.id, s.rol, s.retentions, s.blockades, sc.customerName, s.term, s.cancellationDate, s.officeDescription)"
				+ " from SummaryInvestments s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE (s.customer = :customer OR :customer = 0) AND (s.product = 'AHO') AND (s.user = :user) AND (s.sequence = :sequence) ORDER BY s.openingDate, s.operationNumber DESC"),

		@NamedQuery(name = "SummaryInvestments.getAllFixedTerms", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO(s.customer, s.product, s.typeDescription, s.operationNumber, s.rate, s.openingDate, s.expirationDate, c.mnemonic, s.pledgedAmount, s.overdraftLimit, s.balance, s.balanceLocalCurrency, s.available, s.availableLocalCurrency, s.protests, s.statusDescription, c.id, s.rol, s.retentions, s.blockades, sc.customerName, s.term, s.cancellationDate, s.officeDescription)"
				+ " from SummaryInvestments s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE (s.customer = :customer OR :customer = 0) AND (s.category = '02') AND (s.product = 'PFI')  AND (s.user = :user) AND (s.sequence = :sequence) ORDER BY s.openingDate, s.operationNumber DESC") })
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_inversiones bdd: cob_credito
 * @author bbuendia
 *
 */
public class SummaryInvestments {

	@Id
	@Column(name = "si_cliente")
	private Integer customer;

	@Id
	@Column(name = "si_usuario")
	private String user;

	@Id
	@Column(name = "si_secuencia")
	private Integer sequence;

	@Column(name = "si_producto")
	private String product;

	@Column(name = "si_desc_tipo_op")
	private String typeDescription;

	@Column(name = "si_numero_operacion")
	private String operationNumber;

	@Column(name = "si_tasa")
	private Float rate;

	@Column(name = "si_fecha_apt")
	private Date openingDate;

	@Column(name = "si_fecha_vct")
	private Date expirationDate;

	@ManyToOne
	@JoinColumn(name = "si_moneda", referencedColumnName = "mo_moneda")
	private Currency currency;

	@Transient
	private String currencyDescription;

	@Column(name = "si_fecha_ult_mov")
	private Date lastMovDate;

	@Column(name = "si_monto_prendado")
	private Double pledgedAmount;

	@Column(name = "si_valor_mercado")
	private Double overdraftLimit;

	@Column(name = "si_saldo")
	private Double balance;

	@Column(name = "si_saldo_ml")
	private Double balanceLocalCurrency;

	@Column(name = "si_interes_acumulado")
	private Double available;

	@Column(name = "si_valor_mercado_ml")
	private Double availableLocalCurrency;

	@Column(name = "si_estado")
	private String status;

	@Column(name = "si_desc_estado")
	private String statusDescription;

	@Column(name = "si_valor_garantia")
	private Double retentions;

	@Column(name = "si_bloqueos")
	private Double blockades;

	@Column(name = "si_rol")
	private String rol;

	// CURRENT ACCOUNT
	@Column(name = "si_operacion")
	private Integer protests;

	// FIXED TERMS
	@Column(name = "si_categoria")
	private String category;

	// FIXED TERMS
	@Column(name = "si_plazo")
	private Integer term;

	@Column(name = "si_fecha_can")
	private Date cancellationDate;

	@Column(name = "si_desc_oficina")
	private String officeDescription;

	@Transient
	private String customerName;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "si_cliente", referencedColumnName = "sc_cliente"), @JoinColumn(name = "si_usuario", referencedColumnName = "sc_usuario"),
			@JoinColumn(name = "si_secuencia", referencedColumnName = "sc_secuencia"), @JoinColumn(name = "si_tramite", referencedColumnName = "sc_tramite") })
	private SummaryCustomer summaryCustomer;

	public SummaryInvestments() {

	}

	public SummaryInvestments(Integer customer, String product, String typeDescription, String operationNumber, Float rate, Date openingDate, Date expirationDate,
			String currencyDescription, Double pledgedAmount, Double overdraftLimit, Double balance, Double balanceLocalCurrency, Double available, Double availableLocalCurrency,
			Integer protests, String statusDescription, Integer currency, String rol, Double retentions, Double blockades, String customerName) {
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
		this.currency = new Currency();
		this.currency.setId(currency);
		this.rol = rol;
		this.retentions = retentions;
		this.blockades = blockades;
		this.customerName = customerName;
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
		SummaryInvestments other = (SummaryInvestments) obj;
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
		return "SummaryInvestments [customer=" + customer + ", user=" + user + ", sequence=" + sequence + ", product=" + product + ", typeDescription=" + typeDescription
				+ ", operationNumber=" + operationNumber + ", rate=" + rate + ", openingDate=" + openingDate + ", expirationDate=" + expirationDate + ", currency=" + currency
				+ ", currencyDescription=" + currencyDescription + ", lastMovDate=" + lastMovDate + ", pledgedAmount=" + pledgedAmount + ", overdraftLimit=" + overdraftLimit
				+ ", balance=" + balance + ", balanceLocalCurrency=" + balanceLocalCurrency + ", available=" + available + ", availableLocalCurrency=" + availableLocalCurrency
				+ ", status=" + status + ", retentions=" + retentions + ", blockades=" + blockades + ", rol=" + rol + ", protests=" + protests + ", category=" + category
				+ ", cancellationDate=" + cancellationDate + ", officeDescription=" + officeDescription + "]";
	}

}
