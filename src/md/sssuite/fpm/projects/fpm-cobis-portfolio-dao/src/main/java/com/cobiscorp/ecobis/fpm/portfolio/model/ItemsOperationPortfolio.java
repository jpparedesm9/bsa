package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "ca_rubro_op_tmp", schema = "cob_cartera")
@IdClass(ItemsOperationPortfolioId.class)
@NamedQueries({
		@NamedQuery(name = "ItemsOperationPortfolio.FindAll", query = "Select iop from ItemsOperationPortfolio iop"),
		@NamedQuery(name = "ItemsOperationPortfolio.FindSpecificItemOperation", query = "Select iop from ItemsOperationPortfolio iop where iop.operation = :operation and  iop.reference = :reference"),
		@NamedQuery(name = "ItemsOperationPortfolio.FindSpecificItemOperationForConcept", query = "Select iop from ItemsOperationPortfolio iop where iop.operation = :operation and  iop.concept = :concept"),
		@NamedQuery(name = "ItemsOperationPortfolio.FindSpecificItemOperationForChangeRate", query = "Select iop from ItemsOperationPortfolio iop where iop.operation = :operation and  iop.changeReference = :changeReference")})
public class ItemsOperationPortfolio {
	@Id
	@Column(name = "rot_operacion")
	private int operation;
	@Id
	@Column(name = "rot_concepto")
	private String concept;
	@Column(name = "rot_tipo_rubro")
	private String itemType;
	@Column(name = "rot_fpago")
	private String fPayment;
	@Column(name = "rot_prioridad")
	private long priority;
	@Column(name = "rot_paga_mora")
	private String payArrears;
	@Column(name = "rot_provisiona")
	private String provisional;
	@Column(name = "rot_signo")
	private String sign;
	@Column(name = "rot_factor")
	private long factor;
	@Column(name = "rot_referencial")
	private String reference;
	@Column(name = "rot_signo_reajuste")
	private String changeSign;
	@Column(name = "rot_factor_reajuste")
	private long changeFactor;
	@Column(name = "rot_referencial_reajuste")
	private String changeReference;
	@Column(name = "rot_valor")
	private long value;
	@Column(name = "rot_porcentaje")
	private long percentage;
	@Column(name = "rot_gracia")
	private long grace;
	@Column(name = "rot_concepto_asociado")
	private String associateConcept;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "rot_fecha_desde")
	private Date dateFrom;
	@Column(name = "rot_fecha_hasta")
	private Date dateTo;
	@Column(name = "rot_valor_max")
	private long valueMax;
	@Column(name = "rot_valor_min")
	private long valueMin;
	@Column(name = "rot_base_calculo")
	private long baseCalculation;
	@Column(name = "rot_cuenta_abono")
	private long creditAccount;
	@Column(name = "rot_porcentaje_tea")
	private long percentageTea;
	@Column(name = "rot_porcentaje_dia")
	private long percentageDia;
	@Column(name = "rot_afectacion")
	private short affectation;
	@Column(name = "rot_diferir")
	private String defer;
	@Column(name = "rot_dias_diferir")
	private int deferDays;
	@Column(name = "rot_saldo_diferir")
	private long deferBalance;
	@Column(name = "rot_fdescuento")
	private String discount;
	@Column(name = "rot_saldo_xpagar")
	private long balancePayable;
	@Column(name = "rot_tipo_seguro")
	private String typeSafe;
	@Column(name = "rot_provision_acum")
	private long provisionAcum;
	@Column(name = "rot_provision_actual")
	private long currentProvision;
	@Column(name = "rot_cobrado")
	private String charged;
	@Column(name = "rot_financiado")
	private String funded;
	@Column(name = "rot_fpago_tercero")
	private String fPaymentThrid;
	@Column(name = "rot_cuenta_pago")
	private String balancePayment;
	@Column(name = "rot_tasa_minima")
	private long minRate;

	public ItemsOperationPortfolio() {
	}

	public ItemsOperationPortfolio(int operation, String concept,
			String itemType, String fPayment, long priority, String payArrears,
			String provisional, String sign, long factor, String reference,
			String changeSign, long changeFactor, String changeReference,
			long value, long percentage, long grace, String associateConcept,
			Date dateFrom, Date dateTo, long valueMax, long valueMin,
			long baseCalculation, long creditAccount, long percentageTea,
			long percentageDia, short affectation, String defer, int deferDays,
			long deferBalance, String discount, long balancePayable,
			String typeSafe, long provisionAcum, long currentProvision,
			String charged, String funded, String fPaymentThrid,
			String balancePayment, long minRate) {
		this.operation = operation;
		this.concept = concept;
		this.itemType = itemType;
		this.fPayment = fPayment;
		this.priority = priority;
		this.payArrears = payArrears;
		this.provisional = provisional;
		this.sign = sign;
		this.factor = factor;
		this.reference = reference;
		this.changeSign = changeSign;
		this.changeFactor = changeFactor;
		this.changeReference = changeReference;
		this.value = value;
		this.percentage = percentage;
		this.grace = grace;
		this.associateConcept = associateConcept;
		this.dateFrom = dateFrom;
		this.dateTo = dateTo;
		this.valueMax = valueMax;
		this.valueMin = valueMin;
		this.baseCalculation = baseCalculation;
		this.creditAccount = creditAccount;
		this.percentageTea = percentageTea;
		this.percentageDia = percentageDia;
		this.affectation = affectation;
		this.defer = defer;
		this.deferDays = deferDays;
		this.deferBalance = deferBalance;
		this.discount = discount;
		this.balancePayable = balancePayable;
		this.typeSafe = typeSafe;
		this.provisionAcum = provisionAcum;
		this.currentProvision = currentProvision;
		this.charged = charged;
		this.funded = funded;
		this.fPaymentThrid = fPaymentThrid;
		this.balancePayment = balancePayment;
		this.minRate = minRate;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public String getConcept() {
		return concept;
	}

	public void setConcept(String concept) {
		this.concept = concept;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getfPayment() {
		return fPayment;
	}

	public void setfPayment(String fPayment) {
		this.fPayment = fPayment;
	}

	public long getPriority() {
		return priority;
	}

	public void setPriority(long priority) {
		this.priority = priority;
	}

	public String getPayArrears() {
		return payArrears;
	}

	public void setPayArrears(String payArrears) {
		this.payArrears = payArrears;
	}

	public String getProvisional() {
		return provisional;
	}

	public void setProvisional(String provisional) {
		this.provisional = provisional;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public long getFactor() {
		return factor;
	}

	public void setFactor(long factor) {
		this.factor = factor;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getChangeSign() {
		return changeSign;
	}

	public void setChangeSign(String changeSign) {
		this.changeSign = changeSign;
	}

	public long getChangeFactor() {
		return changeFactor;
	}

	public void setChangeFactor(long changeFactor) {
		this.changeFactor = changeFactor;
	}

	public String getChangeReference() {
		return changeReference;
	}

	public void setChangeReference(String changeReference) {
		this.changeReference = changeReference;
	}

	public long getValue() {
		return value;
	}

	public void setValue(long value) {
		this.value = value;
	}

	public long getPercentage() {
		return percentage;
	}

	public void setPercentage(long percentage) {
		this.percentage = percentage;
	}

	public long getGrace() {
		return grace;
	}

	public void setGrace(long grace) {
		this.grace = grace;
	}

	public String getAssociateConcept() {
		return associateConcept;
	}

	public void setAssociateConcept(String associateConcept) {
		this.associateConcept = associateConcept;
	}

	public Date getDateFrom() {
		return dateFrom;
	}

	public void setDateFrom(Date dateFrom) {
		this.dateFrom = dateFrom;
	}

	public Date getDateTo() {
		return dateTo;
	}

	public void setDateTo(Date dateTo) {
		this.dateTo = dateTo;
	}

	public long getValueMax() {
		return valueMax;
	}

	public void setValueMax(long valueMax) {
		this.valueMax = valueMax;
	}

	public long getValueMin() {
		return valueMin;
	}

	public void setValueMin(long valueMin) {
		this.valueMin = valueMin;
	}

	public long getBaseCalculation() {
		return baseCalculation;
	}

	public void setBaseCalculation(long baseCalculation) {
		this.baseCalculation = baseCalculation;
	}

	public long getCreditAccount() {
		return creditAccount;
	}

	public void setCreditAccount(long creditAccount) {
		this.creditAccount = creditAccount;
	}

	public long getPercentageTea() {
		return percentageTea;
	}

	public void setPercentageTea(long percentageTea) {
		this.percentageTea = percentageTea;
	}

	public long getPercentageDia() {
		return percentageDia;
	}

	public void setPercentageDia(long percentageDia) {
		this.percentageDia = percentageDia;
	}

	public short getAffectation() {
		return affectation;
	}

	public void setAffectation(short affectation) {
		this.affectation = affectation;
	}

	public String getDefer() {
		return defer;
	}

	public void setDefer(String defer) {
		this.defer = defer;
	}

	public int getDeferDays() {
		return deferDays;
	}

	public void setDeferDays(int deferDays) {
		this.deferDays = deferDays;
	}

	public long getDeferBalance() {
		return deferBalance;
	}

	public void setDeferBalance(long deferBalance) {
		this.deferBalance = deferBalance;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public long getBalancePayable() {
		return balancePayable;
	}

	public void setBalancePayable(long balancePayable) {
		this.balancePayable = balancePayable;
	}

	public String getTypeSafe() {
		return typeSafe;
	}

	public void setTypeSafe(String typeSafe) {
		this.typeSafe = typeSafe;
	}

	public long getProvisionAcum() {
		return provisionAcum;
	}

	public void setProvisionAcum(long provisionAcum) {
		this.provisionAcum = provisionAcum;
	}

	public long getCurrentProvision() {
		return currentProvision;
	}

	public void setCurrentProvision(long currentProvision) {
		this.currentProvision = currentProvision;
	}

	public String getCharged() {
		return charged;
	}

	public void setCharged(String charged) {
		this.charged = charged;
	}

	public String getFunded() {
		return funded;
	}

	public void setFunded(String funded) {
		this.funded = funded;
	}

	public String getfPaymentThrid() {
		return fPaymentThrid;
	}

	public void setfPaymentThrid(String fPaymentThrid) {
		this.fPaymentThrid = fPaymentThrid;
	}

	public String getBalancePayment() {
		return balancePayment;
	}

	public void setBalancePayment(String balancePayment) {
		this.balancePayment = balancePayment;
	}

	public long getMinRate() {
		return minRate;
	}

	public void setMinRate(long minRate) {
		this.minRate = minRate;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		result = prime * result + operation;
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemsOperationPortfolio other = (ItemsOperationPortfolio) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		if (operation != other.operation)
			return false;
		return true;
	}

	public String toString() {
		return "ItemsOperationPortfolio [operation=" + operation + ", concept="
				+ concept + ", itemType=" + itemType + ", fPayment=" + fPayment
				+ ", priority=" + priority + ", payArrears=" + payArrears
				+ ", provisional=" + provisional + ", sign=" + sign
				+ ", factor=" + factor + ", reference=" + reference
				+ ", changeSign=" + changeSign + ", changeFactor="
				+ changeFactor + ", changeReference=" + changeReference
				+ ", value=" + value + ", percentage=" + percentage
				+ ", grace=" + grace + ", associateConcept=" + associateConcept
				+ ", dateFrom=" + dateFrom + ", dateTo=" + dateTo
				+ ", valueMax=" + valueMax + ", valueMin=" + valueMin
				+ ", baseCalculation=" + baseCalculation + ", creditAccount="
				+ creditAccount + ", percentageTea=" + percentageTea
				+ ", percentageDia=" + percentageDia + ", affectation="
				+ affectation + ", defer=" + defer + ", deferDays=" + deferDays
				+ ", deferBalance=" + deferBalance + ", discount=" + discount
				+ ", balancePayable=" + balancePayable + ", typeSafe="
				+ typeSafe + ", provisionAcum=" + provisionAcum
				+ ", currentProvision=" + currentProvision + ", charged="
				+ charged + ", funded=" + funded + ", fPaymentThrid="
				+ fPaymentThrid + ", balancePayment=" + balancePayment
				+ ", minRate=" + minRate + "]";
	}
}
