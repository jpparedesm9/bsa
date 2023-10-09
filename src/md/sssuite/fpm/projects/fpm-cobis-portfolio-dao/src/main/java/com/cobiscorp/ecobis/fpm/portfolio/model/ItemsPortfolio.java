package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(ItemsPortfolioId.class)
@Table(name = "ca_rubro", schema = "cob_cartera")
@NamedQueries({
		@NamedQuery(name = "ItemsPortfolio.FindAll", query = "Select ip from ItemsPortfolio ip"),
		@NamedQuery(name = "ItemsPortfolio.FindSpecificItems", query = "Select ip from ItemsPortfolio ip where ip.operation =:operation and ip.currency =:currency"),
		@NamedQuery(name = "ItemsPortfolio.FindByOperation", query = "Select ip from ItemsPortfolio ip where ip.operation =:operation"),
		@NamedQuery(name = "ItemsPortfolio.findByOperationAndConcept", query = "select ip from ItemsPortfolio ip where ip.operation=:operation and ip.concept=:concept")})
public class ItemsPortfolio {

	@Id
	@Column(name = "ru_toperacion")
	private String operation;// catalogo

	@Id
	@Column(name = "ru_moneda")
	private long currency;// tinyint

	@Id
	@Column(name = "ru_concepto")
	private String concept;// catalogo

	@Column(name = "ru_prioridad")
	private long priority;// tinyint
	@Column(name = "ru_tipo_rubro")
	private String itemType;// catalogo
	@Column(name = "ru_paga_mora")
	private String ru_paga_mora;// char 1
	@Column(name = "ru_provisiona")
	private String provision;// char 1
	@Column(name = "ru_fpago")
	private String fPayment;// char 1
	@Column(name = "ru_crear_siempre")
	private String alwaysCreate;// char 1
	@Column(name = "ru_tperiodo")
	private String tPeriod;// catalogo 10
	@Column(name = "ru_periodo")
	private Integer period;// smallint 2
	@Column(name = "ru_referencial")
	private String reference;// catalogo 10
	@Column(name = "ru_reajuste")
	private String changeRate;// catalogo 10
	@Column(name = "ru_banco")
	private String bank;// char 1
	@Column(name = "ru_estado")
	private String state;// catalogo 10
	@Column(name = "ru_concepto_asociado")
	private String conceptAssociated;// catalogo 10
	@Column(name = "ru_valor_max")
	private long maxValue;// money 8
	@Column(name = "ru_valor_min")
	private long minValue;// money 8
	@Column(name = "ru_afectacion")
	private Integer affectation;// smallint 2
	@Column(name = "ru_diferir")
	private String defer;// char 1
	@Column(name = "ru_tipo_seguro")
	private String secureType;// catalogo 10
	@Column(name = "ru_tasa_efectiva")
	private String effectiveRate;// char 1

	public ItemsPortfolio() {

	}

	public ItemsPortfolio(String operation, long currency, String concept, long priority, String itemType, String ru_paga_mora, String provision,
			String fPayment, String alwaysCreate, String tPeriod, Integer period, String reference, String changeRate, String bank, String state,
			String conceptAssociated, long maxValue, long minValue, Integer affectation, String defer, String secureType, String effectiveRate) {
		this.operation = operation;
		this.currency = currency;
		this.concept = concept;
		this.priority = priority;
		this.itemType = itemType;
		this.ru_paga_mora = ru_paga_mora;
		this.provision = provision;
		this.fPayment = fPayment;
		this.alwaysCreate = alwaysCreate;
		this.tPeriod = tPeriod;
		this.period = period;
		this.reference = reference;
		this.changeRate = changeRate;
		this.bank = bank;
		this.state = state;
		this.conceptAssociated = conceptAssociated;
		this.maxValue = maxValue;
		this.minValue = minValue;
		this.affectation = affectation;
		this.defer = defer;
		this.secureType = secureType;
		this.effectiveRate = effectiveRate;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public long getCurrency() {
		return currency;
	}

	public void setCurrency(long currency) {
		this.currency = currency;
	}

	public String getConcept() {
		return concept;
	}

	public void setConcept(String concept) {
		this.concept = concept;
	}

	public long getPriority() {
		return priority;
	}

	public void setPriority(long priority) {
		this.priority = priority;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getRu_paga_mora() {
		return ru_paga_mora;
	}

	public void setRu_paga_mora(String ru_paga_mora) {
		this.ru_paga_mora = ru_paga_mora;
	}

	public String getProvision() {
		return provision;
	}

	public void setProvision(String provision) {
		this.provision = provision;
	}

	public String getfPayment() {
		return fPayment;
	}

	public void setfPayment(String fPayment) {
		this.fPayment = fPayment;
	}

	public String getAlwaysCreate() {
		return alwaysCreate;
	}

	public void setAlwaysCreate(String alwaysCreate) {
		this.alwaysCreate = alwaysCreate;
	}

	public String gettPeriod() {
		return tPeriod;
	}

	public void settPeriod(String tPeriod) {
		this.tPeriod = tPeriod;
	}

	public Integer getPeriod() {
		return period;
	}

	public void setPeriod(Integer period) {
		this.period = period;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getChangeRate() {
		return changeRate;
	}

	public void setChangeRate(String changeRate) {
		this.changeRate = changeRate;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getConceptAssociated() {
		return conceptAssociated;
	}

	public void setConceptAssociated(String conceptAssociated) {
		this.conceptAssociated = conceptAssociated;
	}

	public long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(long maxValue) {
		this.maxValue = maxValue;
	}

	public long getMinValue() {
		return minValue;
	}

	public void setMinValue(long minValue) {
		this.minValue = minValue;
	}

	public Integer getAffectation() {
		return affectation;
	}

	public void setAffectation(Integer affectation) {
		this.affectation = affectation;
	}

	public String getDefer() {
		return defer;
	}

	public void setDefer(String defer) {
		this.defer = defer;
	}

	public String getSecureType() {
		return secureType;
	}

	public void setSecureType(String secureType) {
		this.secureType = secureType;
	}

	public String getEffectiveRate() {
		return effectiveRate;
	}

	public void setEffectiveRate(String effectiveRate) {
		this.effectiveRate = effectiveRate;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		result = prime * result + (int) (currency ^ (currency >>> 32));
		result = prime * result + ((operation == null) ? 0 : operation.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemsPortfolio other = (ItemsPortfolio) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		if (currency != other.currency)
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		return true;
	}

	public String toString() {
		return "ItemsPortfolio [operation=" + operation + ", currency=" + currency + ", concept=" + concept + ", priority=" + priority + ", itemType="
				+ itemType + ", ru_paga_mora=" + ru_paga_mora + ", provision=" + provision + ", fPayment=" + fPayment + ", alwaysCreate=" + alwaysCreate
				+ ", tPeriod=" + tPeriod + ", period=" + period + ", reference=" + reference + ", changeRate=" + changeRate + ", bank=" + bank + ", state="
				+ state + ", conceptAssociated=" + conceptAssociated + ", maxValue=" + maxValue + ", minValue=" + minValue + ", affectation=" + affectation
				+ ", defer=" + defer + ", secureType=" + secureType + ", effectiveRate=" + effectiveRate + "]";
	}
}
