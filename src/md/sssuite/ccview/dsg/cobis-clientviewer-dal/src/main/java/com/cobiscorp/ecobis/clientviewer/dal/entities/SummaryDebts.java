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
@Table(name = "cr_situacion_deudas", schema = "cob_credito")
@IdClass(SummaryId.class)
@NamedQueries({
		@NamedQuery(name = "SummaryDebts.getSummaryIndirectCredit", query = "SELECT CASE sd.product" + " WHEN 'CCA' THEN 'INDIRECTO'" + " WHEN 'CEX' THEN 'INDIRECTO'"
				+ " ELSE 'NA'" + " END," + " CONCAT(sd.product, '-IND')," + " sd.descriptionType, sd.amountRisk, sd.numberOperation, sd.state FROM SummaryDebts sd"
				+ " WHERE sd.user  = :user" + " AND (sd.customerCon = :customer OR :customer = 0)" + " AND sd.sequence = :sequence" + " AND sd.debtsType = 'I'"
				+ " AND sd.product <> 'TRA'" + " AND sd.state <> 'CREDITO'"),

		@NamedQuery(name = "SummaryDebts.getSummayOverdrafts", query = "SELECT CASE sd.product" + " WHEN 'SOB' THEN 'DEUDAS'" + " ELSE 'NA'" + " END,"
				+ " sd.product, sd.descriptionType, sd.amountRisk, sd.numberOperation, sd.state FROM  SummaryDebts sd" + " WHERE  sd.user  =: user"
				+ " AND (sd.customerCon = :customer OR :customer = 0)" + " AND sd.sequence = :sequence" + " AND sd.product  = 'SOB'"
				+ " AND (sd.state <> 'CREDITO' OR sd.state is null)"),

		@NamedQuery(name = "SummaryDebts.getSummaryCEXContingencies", query = "SELECT CASE sd.product" + " WHEN 'CEX' THEN 'CONTINGENTES'" + " ELSE 'NA'" + " END,"
				+ " sd.product, sd.descriptionType, sd.amountRisk, sd.numberOperation, sd.state FROM  SummaryDebts sd" + " WHERE sd.user  =: user"
				+ " AND (sd.customer =: customer  OR :customer = 0)" + " AND sd.product not in ('TRA','CCA', 'SOB')" + " AND (sd.state <> 'CREDITO' OR sd.state is null)"),

		@NamedQuery(name = "SummaryDebts.getSummaryDebts", query = "SELECT 'DEUDAS', sd.product, sd.descriptionType, sd.totalCharges,"
				+ " sd.numberOperation , sd.state  FROM  SummaryDebts sd" + " WHERE  sd.user  =: user" + " AND (sd.customer  =: customer OR :customer = 0)"
				+ " AND sd.sequence = :sequence" + " AND sd.product  = 'CCA'" + " AND sd.debtsType = 'D'" + " AND (sd.state NOT IN ('CREDITO', 'NO VIGENTE') OR sd.state IS NULL )" + "AND sd.numberOperation IS NOT NULL" ),

		@NamedQuery(name = "SummaryDebts.getAllContingencies", query = "select new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(s.customer, s.product, s.operationType, s.descriptionType, s.numberOperation, s.warrantyDescription, s.openingDate, s.expirationDate, c.id , c.mnemonic, s.amount, s.shippingDate, s.beneficiary, s.state, sc.customerName )"
				+ " from SummaryDebts s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE (s.customer = :customer) AND (s.product = 'CEX') AND (s.user = :user) AND (s.sequence = :sequence) AND (s.debtsType = 'T') ORDER BY s.openingDate DESC, s.processIdD"),

		@NamedQuery(name = "SummaryDebts.getAllOverdrafts", query = "select new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(s.customer, s.product, s.descriptionType, s.numberOperation, s.rate, c.mnemonic, s.usedAmount, s.available, c.id, s.amountRisk, sc.customerName)"
				+ " from SummaryDebts s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE (s.customer = :customer) AND (s.category = '07') AND (s.user = :user) AND (s.sequence = :sequence) AND (s.debtsType = 'D') ORDER BY s.openingDate DESC, s.numberOperation, s.customer, s.operationType"),

		/* COMPLETAR LA RELACION CON TABLA cr_situacion_clientes */
		@NamedQuery(name = "SummaryDebts.getAllDebtsLoans", query = "select new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(s.customer, s.product, s.operationType, s.descriptionType, s.processIdD, s.numberOperation, s.state, s.beneficiary, s.rate, s.openingDate, s.expirationDate, c.id, s.originalAmount, s.overdueBalance, s.totalCharges, s.available, s.amounLocalMoney, s.rating, s.currentContract, s.role, sc.customerName, s.dateCancellation, s.amount, s.term, s.daysOverdue, s.reasonCredit, s.termType, s.refinancing, s.restructuring, c.mnemonic)"
				+ " FROM SummaryDebts s left join s.currency c left join s.summaryCustomer sc"
				+ " WHERE s.product = 'CCA'"
				+ " AND (s.user = :user) AND (s.sequence = :sequence) "
				+ " AND s.debtsType = 'D'" 
				+ " AND s.customer =: customer"
				+ " ORDER BY s.openingDate DESC, s.customer, s.category, s.product"),

		@NamedQuery(name = "SummaryDebts.getPledgeAmount", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryDebts(s.overdueBalance, s.available)"
				+ " FROM SummaryDebts s " + " WHERE s.user = :user " + " AND s.sequence = :sesn "
				+ " AND (s.proposedGuarantee.custody.type = :typeGarBack OR s.proposedGuarantee.custody.type = :typeGarBack2) "
				+ " AND s.proposedGuarantee.custody.status IN ('V','F','X')"),

		@NamedQuery(name = "SummaryDebts.getMaxDebtAmounts", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(s.user, s.sequence, s.typeCon,s.customer,s.processId,s.processIdD,s.product,s.operationType,s.descriptionType,s.amountRisk, s.numberOperation,s.state,s.customerCon,s.debtsType,s.amounLocalMoney,s.usedAmount,s.usedAmoutLocalMoney,s.totalCharges,s.warrantyDescription,s.openingDate,s.expirationDate,s.amount,s.shippingDate,s.beneficiary,s.rate,s.available,s.category,s.originalAmount,s.overdueBalance,s.role,s.rating,s.currentContract)"
				+ "FROM SummaryDebts s WHERE (s.customer = :customer OR (:group IS NOT NULL AND :customer IS NULL)) AND s.user = :user AND s.sequence = :sequence AND s.processId = :processId"),
		@NamedQuery(name = "SummaryDebts.getPledgeAmountOperation", query = "SELECT sum(s.proposedGuarantee.custody.fixedTermOperation.amountPaid)" + " FROM SummaryDebts s "
				+ " WHERE s.user = :user " + " AND s.sequence = :sesn " + " AND s.product = 'CCA' " + " AND s.proposedGuarantee.custody.fixedTermOperation.status = 'ACT' "),

		@NamedQuery(name = "SummaryDebts.getCustomerRisk", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(sd.user, sd.sequence, sd.customer, sd.amountRisk, sd.state, sd.product) "
				+ " FROM SummaryDebts sd "
				+ "WHERE sd.user = :user "
				+ " AND sd.sequence = :sesn"
				+ " AND (sd.customer =: customer  OR :customer = 0)"
				+ " AND (sd.debtsType = 'T' or sd.debtsType is null)"),

		@NamedQuery(name = "SummaryDebts.getTotalDealRisk", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(sd.user, sd.sequence, sd.customer, sd.amountRisk) "
				+ " FROM SummaryDebts sd "
				+ " WHERE sd.customerCon=:customer "
				+ " AND sd.user=:user "
				+ " AND sd.sequence=:sequence "
				// + " AND sd.processId = 0 "
				+ " AND ((sd.operationType in ('CCI','CCD','GRA','GRB','STB','AVB','AVE') AND sd.product = 'CEX') OR sd.product = 'CCA') "
				+ " AND sd.state in ('NO VIGENTE', 'CREDITO') "),

		@NamedQuery(name = "SummaryDebts.getTotalDealAditional", query = "SELECT new com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO(sd.user, sd.sequence, sd.customer, sd.amountRisk) "
				+ " FROM SummaryDebts sd "
				+ " WHERE sd.user = :user "
				+ " AND sd.sequence = :sequence"
				+ " AND (sd.customer =: customer  OR :customer = 0)"
				+ " AND (sd.debtsType = 'T' or sd.debtsType is null)" + " AND (sd.category IN ( '011', '07', '08', '06' ) OR sd.product = 'CEX' )")

})
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_deudas bdd: cob_credito
 * @author bbuendia
 *
 */
public class SummaryDebts {

	@Id
	@Column(name = "sd_usuario")
	private String user;

	@Id
	@Column(name = "sd_secuencia")
	private Integer sequence;

	@Column(name = "sd_tipo_con")
	private String typeCon;

	@Id
	@Column(name = "sd_cliente")
	private Integer customer;

	@Column(name = "sd_tramite")
	private Integer processId;

	@Column(name = "sd_tramite_d")
	private Integer processIdD;

	@Column(name = "sd_producto")
	private String product;

	@Column(name = "sd_tipo_op")
	private String operationType;

	@Column(name = "sd_desc_tipo_op")
	private String descriptionType;

	@Column(name = "sd_monto_riesgo")
	private Double amountRisk;

	@Column(name = "sd_numero_operacion")
	private String numberOperation;

	@Column(name = "sd_estado")
	private String state;

	@Column(name = "sd_cliente_con")
	private Integer customerCon;

	@Column(name = "sd_tipo_deuda")
	private String debtsType;

	@Column(name = "sd_monto_ml")
	private Double amounLocalMoney;

	@Column(name = "sd_val_utilizado")
	private Double usedAmount;

	@Column(name = "sd_val_utilizado_ml")
	private Double usedAmoutLocalMoney;

	@Column(name = "sd_total_cargos")
	private Double totalCharges;

	@Column(name = "sd_descrip_gar")
	private String warrantyDescription;

	@Column(name = "sd_fecha_apr")
	private Date openingDate;

	@Column(name = "sd_fecha_vct")
	private Date expirationDate;

	@Transient
	private String currencyDescription;

	@Column(name = "sd_monto")
	private Double amount;

	@Column(name = "sd_fechas_embarque")
	private Date shippingDate;

	@Column(name = "sd_beneficiario")
	private String beneficiary;

	@Column(name = "sd_tasa")
	private Float rate;

	@Column(name = "sd_saldo_x_vencer")
	private Double available;

	@Column(name = "sd_categoria")
	private String category;

	@Transient
	private Integer currencyId;

	@Column(name = "sd_monto_orig")
	private Double originalAmount;

	@Column(name = "sd_saldo_vencido")
	private Double overdueBalance;

	@Column(name = "sd_rol")
	private String role;

	@Column(name = "sd_calificacion")
	private String rating;

	@Column(name = "sd_contrato_act")
	private Double currentContract;

	@Column(name = "sd_fecha_cancelacion")
	private Date dateCancellation;

	@Column(name = "sd_refinanciamiento")
	private String refinancing;

	@Column(name = "sd_restructuracion")
	private String restructuring;

	@Column(name = "sd_plazo")
	private Integer term;

	@Column(name = "sd_dias_atraso")
	private Integer daysOverdue;

	@Column(name = "sd_motivo_credito")
	private String reasonCredit;

	@Column(name = "sd_tipo_plazo")
	private String termType;

	@Transient
	private String customerName;

	@ManyToOne
	@JoinColumn(name = "sd_moneda", referencedColumnName = "mo_moneda")
	private Currency currency;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "sd_cliente", referencedColumnName = "sc_cliente"), @JoinColumn(name = "sd_usuario", referencedColumnName = "sc_usuario"),
			@JoinColumn(name = "sd_secuencia", referencedColumnName = "sc_secuencia"), @JoinColumn(name = "sd_tramite", referencedColumnName = "sc_tramite") })
	private SummaryCustomer summaryCustomer;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "sd_tramite_d", referencedColumnName = "gp_tramite") })
	private ProposedGuarantee proposedGuarantee;

	/** ProductAdmin relation entity */
	/*
	 * @ManyToOne
	 * 
	 * @JoinColumn(name = "pr_productAdminSummaryDebts", referencedColumnName =
	 * "prd_mnemonic") private ProductAdminDefault productAdminSummary;
	 */

	public SummaryDebts() {

	}

	/* Constructor for getAllContingencies */
	public SummaryDebts(Integer customer, String product, String operationType, String descriptionType, String numberOperation, String warrantyDescription, Date openingDate,
			Date expirationDate, Integer currency, String currencyDescription, Double amount, Date shippingDate, String beneficiary, String state, String clientName) {
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
	}

	/* Constructor for getAllOverdrafts */
	public SummaryDebts(Integer customer, String product, String descriptionType, String numberOperation, Float rate, String currencyDescription, Double usedAmount,
			Double available, Integer currency, Double amountRisk, String clientName) {
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
	public SummaryDebts(Integer customer, String product, String operationType, String descriptionType, Integer processIdD, String numberOperation, String state,
			String beneficiary, Float rate, Date openingDate, Date expirationDate, Integer currency, Double originalAmount, Double overdueBalance, Double totalCharges,
			Double available, Double amounLocalMoney, String rating, Double currentContract, String role, String clientName) {

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
	}

	/* Constructor for getPledgeAmount */
	public SummaryDebts(Double overdueBalance, Double available) {
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

	// contructor for getCustomerRisk
	public SummaryDebts(String user, Integer sequence, Integer customer, Double amountRisk, String debtsType) {
		super();
		this.user = user;
		this.sequence = sequence;
		this.customer = customer;
		this.amountRisk = amountRisk;
		this.debtsType = debtsType;
	}

	// contructor for getCustomerRisk
	public SummaryDebts(String user, Integer sequence, Integer customer, Double amountRisk) {
		super();
		this.user = user;
		this.sequence = sequence;
		this.customer = customer;
		this.amountRisk = amountRisk;
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

	public ProposedGuarantee getProposedGuarantee() {
		return proposedGuarantee;
	}

	public void setProposedGuarantee(ProposedGuarantee proposedGuarantee) {
		this.proposedGuarantee = proposedGuarantee;
	}

	public Date getdateCancellationn() {
		return dateCancellation;
	}

	public void setdateCancellation(Date dateCancellation) {
		this.dateCancellation = dateCancellation;
	}

	public String getRefinancing() {
		return refinancing;
	}

	public void setRefinancing(String refinancing) {
		this.refinancing = refinancing;
	}

	public String getRestructuring() {
		return restructuring;
	}

	public void setRestructuring(String restructuring) {
		this.restructuring = restructuring;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public Date getDateCancellation() {
		return dateCancellation;
	}

	public void setDateCancellation(Date dateCancellation) {
		this.dateCancellation = dateCancellation;
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
		SummaryDebts other = (SummaryDebts) obj;
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
		return "SummaryDebts [user=" + user + ", sequence=" + sequence + ", typeCon=" + typeCon + ", customer=" + customer + ", processId=" + processId + ", processIdD="
				+ processIdD + ", product=" + product + ", operationType=" + operationType + ", descriptionType=" + descriptionType + ", amountRisk=" + amountRisk
				+ ", numberOperation=" + numberOperation + ", state=" + state + ", customerCon=" + customerCon + ", debtsType=" + debtsType + ", amounLocalMoney="
				+ amounLocalMoney + ", usedAmount=" + usedAmount + ", usedAmoutLocalMoney=" + usedAmoutLocalMoney + ", totalCharges=" + totalCharges + ", warrantyDescription="
				+ warrantyDescription + ", openingDate=" + openingDate + ", expirationDate=" + expirationDate + ", currencyDescription=" + currencyDescription + ", amount="
				+ amount + ", shippingDate=" + shippingDate + " beneficiary=" + beneficiary + ", rate=" + rate + ", available=" + available + ", category=" + category
				+ ", currencyId=" + currencyId + ", originalAmount=" + originalAmount + ", overdueBalance=" + overdueBalance + ", role=" + role + ", rating=" + rating
				+ ", currentContract=" + currentContract + ", dateCancellation=" + dateCancellation + ", refinancing=" + refinancing + ", restructuring=" + restructuring
				+ ", term=" + term + ", daysOverdue=" + daysOverdue + ", reasonCredit=" + reasonCredit + ", customerName=" + customerName + ", currency=" + currency
				+ ", summaryCustomer=" + summaryCustomer + ", proposedGuarantee=" + proposedGuarantee + "]";
	}

	/*
	 * public ProductAdminDefault getProductAdmin() { return
	 * productAdminSummary; }
	 * 
	 * public void setProductAdmin(ProductAdminDefault productAdmin) {
	 * this.productAdminSummary = productAdmin; }
	 */

	/*
	 * public String getType() { if (this.product.equals("")) { return ""; }
	 * else { return ""; } }
	 * 
	 * public void setType(String type) {
	 * 
	 * 
	 * }
	 */
}
