package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(DefaultOperationId.class)
@Table(name="ca_default_toperacion", schema="cob_cartera")
@NamedQueries({
	@NamedQuery(name="DefaultOperation.FindAll", query="Select do from DefaultOperation do"),
	@NamedQuery(name="DefaultOperation.findByOperation", query="select do from  DefaulOperation do where do.operation=:operation")
})
@NamedNativeQuery(name="DefaultOperation.Insert", 
query="insert into cob_cartera..ca_default_toperacion(dt_toperacion,dt_moneda,dt_reajustable,dt_periodo_reaj,dt_reajuste_especial," +
		"dt_renovacion,dt_tipo,dt_estado,dt_precancelacion,dt_cuota_completa,dt_tipo_cobro,dt_tipo_reduccion,dt_aceptar_anticipos," +
		"dt_tipo_aplicacion,dt_tplazo,dt_plazo,dt_tdividendo,dt_periodo_cap,dt_periodo_int,dt_gracia_cap,dt_gracia_int,dt_dist_gracia," +
		"dt_dias_anio,dt_tipo_amortizacion,dt_fecha_fija,dt_dia_pago,dt_cuota_fija,dt_dias_gracia,dt_evitar_feriados,dt_mes_gracia," +
		"dt_fondos_propios,dt_destino,dt_origen_fondo,dt_cupos_terceros,dt_sector_contable,dt_clabas,dt_clabope,dt_cuota_menor,dt_prd_cobis," +
		"dt_base_calculo,dt_ajuste_moneda,dt_moneda_ajuste,dt_plazo_contable,dt_familia,dt_tipo_prioridad,dt_dia_ppago,dt_subsidio," +
		"dt_tpreferencial,dt_grupo_informe,dt_modo_reest,dt_efecto_pago,dt_filial) values(?1,?2,?3,?4,?5,?6,?7,?8,?9,?10,?11,?12,?13," +
		"?14,?15,?16,?17,?18,?19,?20,?21,?22,?23,?24,?25,?26,?27,?28,?29,?30,?31,?32,?33,?34,?35,?36,?37,?38,?39,?40,?41,?42,?43,?44," +
		"?45,?46,?47,?48,?49,?50,?51,?52)")
public class DefaultOperation {

	@Id
	@Column(name="dt_toperacion")
	private String operation;//	dt_toperacion                  varchar
	@Id
	@Column(name="dt_moneda")
	private long currency;//	dt_moneda                      tinyint
	@Column(name="dt_reajustable")
	private String change;//	dt_reajustable                 char
	@Column(name="dt_periodo_reaj")
	private Integer changePeriod;//	dt_periodo_reaj                tinyint
	@Column(name="dt_reajuste_especial")
	private String specialChange;//	dt_reajuste_especial           char
	@Column(name="dt_renovacion")
	private String renew; //	dt_renovacion                  char
	@Column(name="dt_tipo")
	private String type;//	dt_tipo                        char
	@Column(name="dt_estado")
	private String state;//	dt_estado                      catalogo
	@Column(name="dt_precancelacion")
	private String prePayment;//	dt_precancelacion              char
	@Column(name="dt_cuota_completa")
	private String completeQuota;//	dt_cuota_completa              char
	@Column(name="dt_tipo_cobro")
	private String chargeType;//	dt_tipo_cobro                  char
	@Column(name="dt_tipo_reduccion")
	private String reductionType;//	dt_tipo_reduccion              char
	@Column(name="dt_aceptar_anticipos")
	private String aceptAdvances; //	dt_aceptar_anticipos           char
	@Column(name="dt_tplazo")
	private String tTerm;//	dt_tplazo                      catalogo
	@Column(name="dt_tipo_aplicacion")
	private String applicationType;//	dt_tipo_aplicacion             char
	@Column(name="dt_plazo")
	private int term;//	dt_plazo                       smallint
	@Column(name="dt_tdividendo")
	private String tDividend;//	dt_tdividendo                  catalogo
	@Column(name="dt_periodo_cap")
	private int capPeriod;//	dt_periodo_cap                 smallint
	@Column(name="dt_periodo_int")
	private int intPeriod;//	dt_periodo_int                 smallint
	@Column(name="dt_gracia_cap")
	private int capGrace;//	dt_gracia_cap                  smallint
	@Column(name="dt_gracia_int")
	private int intGrace;//	dt_gracia_int                  smallint
	@Column(name="dt_dist_gracia")
	private String distGrace;//	dt_dist_gracia                 char
	@Column(name="dt_dias_anio")
	private int daysYear;//	dt_dias_anio                   smallint
	@Column(name="dt_tipo_amortizacion")
	private String amortizationType;//	dt_tipo_amortizacion           catalogo
	@Column(name="dt_fecha_fija")
	private String fixedDate;//	dt_fecha_fija                  char
	@Column(name="dt_dia_pago")
	private long dayPayment; //	dt_dia_pago                    tinyint
	@Column(name="dt_cuota_fija")
	private String fixedQuota;//	dt_cuota_fija                  char
	@Column(name="dt_dias_gracia")
	private long daysGrace;//	dt_dias_gracia                 tinyint
	@Column(name="dt_evitar_feriados")
	private String avoidHolidays;//	dt_evitar_feriados             char
	@Column(name="dt_mes_gracia")
	private long monthGrace;//	dt_mes_gracia                  tinyint
	@Column(name="dt_fondos_propios")
	private String fundsOwns;//	dt_fondos_propios              char
	@Column(name="dt_destino")
	private String destination;//	dt_destino                     catalogo
	@Column(name="dt_origen_fondo")
	private String originFunds;//	dt_origen_fondo                catalogo
	@Column(name="dt_cupos_terceros")
	private String quotaThrid;//	dt_cupos_terceros              catalogo
	@Column(name="dt_sector_contable")
	private String sectionAccountant; //	dt_sector_contable             catalogo
	@Column(name="dt_clabas")
	private String clabas;//	dt_clabas                      catalogo
	@Column(name="dt_clabope")
	private String clabope;//	dt_clabope                     catalogo
	@Column(name="dt_cuota_menor")
	private String quotaLess;//	dt_cuota_menor                 char
	@Column(name="dt_prd_cobis")
	private long prdCobis;//	dt_prd_cobis                   tinyint
	@Column(name="dt_base_calculo")
	private String calculationBase;//	dt_base_calculo                char
	@Column(name="dt_ajuste_moneda")
	private String currencyAdjustment;//	dt_ajuste_moneda               char
	@Column(name="dt_moneda_ajuste")
	private Long adjustmentCurrency; //	dt_moneda_ajuste               tinyint
	@Column(name="dt_plazo_contable")
	private String accountingPeriod; //	dt_plazo_contable              catalogo
	@Column(name="dt_familia")
	private String family;//	dt_familia                     catalogo
	@Column(name="dt_tipo_prioridad")
	private String priorityType;//	dt_tipo_prioridad              char
	@Column(name="dt_dia_ppago")
	private long dayPPayment;//	dt_dia_ppago                   tinyint
	@Column(name="dt_subsidio")
	private String subsidy;//	dt_subsidio                    char
	@Column(name="dt_tpreferencial")
	private String tPreference;//	dt_tpreferencial               char
	@Column(name="dt_grupo_informe")
	private String groupReport;//	dt_grupo_informe               catalogo
	@Column(name="dt_modo_reest")
	private String modeReest;//	dt_modo_reest                  char
	@Column(name="dt_efecto_pago")
	private String paymentEffect;//	dt_efecto_pago                 char
	@Column(name="dt_filial")
	private Long affiliate;//	dt_filial                      tinyint    

	
	public DefaultOperation() {
	}


	public DefaultOperation(String operation, long currency, String change,
			Integer changePeriod, String specialChange, String renew, String type,
			String state, String prePayment, String completeQuota,
			String chargeType, String reductionType, String aceptAdvances,
			String tTerm, String applicationType, int term, String tDividend,
			int capPeriod, int intPeriod, int capGrace, int intGrace,
			String distGrace, int daysYear, String amortizationType,
			String fixedDate, long dayPayment, String fixedQuota,
			long daysGrace, String avoidHolidays, long monthGrace, String fundsOwns,
			String destination, String originFunds, String quotaThrid,
			String sectionAccountant, String clabas, String clabope,
			String quotaLess, long prdCobis, String calculationBase,
			String currencyAdjustment, Long adjustmentCurrency,
			String accountingPeriod, String family, String priorityType,
			long dayPPayment, String subsidy, String tPreference,
			String groupReport, String modeReest, String paymentEffect,
			Long affiliate) {
		super();
		this.operation = operation;
		this.currency = currency;
		this.change = change;
		this.changePeriod = changePeriod;
		this.specialChange = specialChange;
		this.renew = renew;
		this.type = type;
		this.state = state;
		this.prePayment = prePayment;
		this.completeQuota = completeQuota;
		this.chargeType = chargeType;
		this.reductionType = reductionType;
		this.aceptAdvances = aceptAdvances;
		this.tTerm = tTerm;
		this.applicationType = applicationType;
		this.term = term;
		this.tDividend = tDividend;
		this.capPeriod = capPeriod;
		this.intPeriod = intPeriod;
		this.capGrace = capGrace;
		this.intGrace = intGrace;
		this.distGrace = distGrace;
		this.daysYear = daysYear;
		this.amortizationType = amortizationType;
		this.fixedDate = fixedDate;
		this.dayPayment = dayPayment;
		this.fixedQuota = fixedQuota;
		this.daysGrace = daysGrace;
		this.avoidHolidays = avoidHolidays;
		this.monthGrace = monthGrace;
		this.fundsOwns = fundsOwns;
		this.destination = destination;
		this.originFunds = originFunds;
		this.quotaThrid = quotaThrid;
		this.sectionAccountant = sectionAccountant;
		this.clabas = clabas;
		this.clabope = clabope;
		this.quotaLess = quotaLess;
		this.prdCobis = prdCobis;
		this.calculationBase = calculationBase;
		this.currencyAdjustment = currencyAdjustment;
		this.adjustmentCurrency = adjustmentCurrency;
		this.accountingPeriod = accountingPeriod;
		this.family = family;
		this.priorityType = priorityType;
		this.dayPPayment = dayPPayment;
		this.subsidy = subsidy;
		this.tPreference = tPreference;
		this.groupReport = groupReport;
		this.modeReest = modeReest;
		this.paymentEffect = paymentEffect;
		this.affiliate = affiliate;
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


	public String getChange() {
		return change;
	}


	public void setChange(String change) {
		this.change = change;
	}


	public Integer getChangePeriod() {
		return changePeriod;
	}


	public void setChangePeriod(Integer changePeriod) {
		this.changePeriod = changePeriod;
	}


	public String getSpecialChange() {
		return specialChange;
	}


	public void setSpecialChange(String specialChange) {
		this.specialChange = specialChange;
	}


	public String getRenew() {
		return renew;
	}


	public void setRenew(String renew) {
		this.renew = renew;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getPrePayment() {
		return prePayment;
	}


	public void setPrePayment(String prePayment) {
		this.prePayment = prePayment;
	}


	public String getCompleteQuota() {
		return completeQuota;
	}


	public void setCompleteQuota(String completeQuota) {
		this.completeQuota = completeQuota;
	}


	public String getChargeType() {
		return chargeType;
	}


	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}


	public String getReductionType() {
		return reductionType;
	}


	public void setReductionType(String reductionType) {
		this.reductionType = reductionType;
	}


	public String getAceptAdvances() {
		return aceptAdvances;
	}


	public void setAceptAdvances(String aceptAdvances) {
		this.aceptAdvances = aceptAdvances;
	}


	public String gettTerm() {
		return tTerm;
	}


	public void settTerm(String tTerm) {
		this.tTerm = tTerm;
	}


	public String getApplicationType() {
		return applicationType;
	}


	public void setApplicationType(String applicationType) {
		this.applicationType = applicationType;
	}


	public int getTerm() {
		return term;
	}


	public void setTerm(int term) {
		this.term = term;
	}


	public String gettDividend() {
		return tDividend;
	}


	public void settDividend(String tDividend) {
		this.tDividend = tDividend;
	}


	public int getCapPeriod() {
		return capPeriod;
	}


	public void setCapPeriod(int capPeriod) {
		this.capPeriod = capPeriod;
	}


	public int getIntPeriod() {
		return intPeriod;
	}


	public void setIntPeriod(int intPeriod) {
		this.intPeriod = intPeriod;
	}


	public int getCapGrace() {
		return capGrace;
	}


	public void setCapGrace(int capGrace) {
		this.capGrace = capGrace;
	}


	public int getIntGrace() {
		return intGrace;
	}


	public void setIntGrace(int intGrace) {
		this.intGrace = intGrace;
	}


	public String getDistGrace() {
		return distGrace;
	}


	public void setDistGrace(String distGrace) {
		this.distGrace = distGrace;
	}


	public int getDaysYear() {
		return daysYear;
	}


	public void setDaysYear(int daysYear) {
		this.daysYear = daysYear;
	}


	public String getAmortizationType() {
		return amortizationType;
	}


	public void setAmortizationType(String amortizationType) {
		this.amortizationType = amortizationType;
	}


	public String getFixedDate() {
		return fixedDate;
	}


	public void setFixedDate(String fixedDate) {
		this.fixedDate = fixedDate;
	}


	public long getDayPayment() {
		return dayPayment;
	}


	public void setDayPayment(long dayPayment) {
		this.dayPayment = dayPayment;
	}


	public String getFixedQuota() {
		return fixedQuota;
	}


	public void setFixedQuota(String fixedQuota) {
		this.fixedQuota = fixedQuota;
	}


	public long getDaysGrace() {
		return daysGrace;
	}


	public void setDaysGrace(long daysGrace) {
		this.daysGrace = daysGrace;
	}


	public String getAvoidHolidays() {
		return avoidHolidays;
	}


	public void setAvoidHolidays(String avoidHolidays) {
		this.avoidHolidays = avoidHolidays;
	}


	public long getMonthGrace() {
		return monthGrace;
	}


	public void setMonth(long monthGrace) {
		this.monthGrace = monthGrace;
	}


	public String getFundsOwns() {
		return fundsOwns;
	}


	public void setFundsOwns(String fundsOwns) {
		this.fundsOwns = fundsOwns;
	}


	public String getDestination() {
		return destination;
	}


	public void setDestination(String destination) {
		this.destination = destination;
	}


	public String getOriginFunds() {
		return originFunds;
	}


	public void setOriginFunds(String originFunds) {
		this.originFunds = originFunds;
	}


	public String getQuotaThrid() {
		return quotaThrid;
	}


	public void setQuotaThrid(String quotaThrid) {
		this.quotaThrid = quotaThrid;
	}


	public String getSectionAccountant() {
		return sectionAccountant;
	}


	public void setSectionAccountant(String sectionAccountant) {
		this.sectionAccountant = sectionAccountant;
	}


	public String getClabas() {
		return clabas;
	}


	public void setClabas(String clabas) {
		this.clabas = clabas;
	}


	public String getClabope() {
		return clabope;
	}


	public void setClabope(String clabope) {
		this.clabope = clabope;
	}


	public String getQuotaLess() {
		return quotaLess;
	}


	public void setQuotaLess(String quotaLess) {
		this.quotaLess = quotaLess;
	}


	public long getPrdCobis() {
		return prdCobis;
	}


	public void setPrdCobis(long prdCobis) {
		this.prdCobis = prdCobis;
	}


	public String getCalculationBase() {
		return calculationBase;
	}


	public void setCalculationBase(String calculationBase) {
		this.calculationBase = calculationBase;
	}


	public String getCurrencyAdjustment() {
		return currencyAdjustment;
	}


	public void setCurrencyAdjustment(String currencyAdjustment) {
		this.currencyAdjustment = currencyAdjustment;
	}


	public Long getAdjustmentCurrency() {
		return adjustmentCurrency;
	}


	public void setAdjustmentCurrency(Long adjustmentCurrency) {
		this.adjustmentCurrency = adjustmentCurrency;
	}


	public String getAccountingPeriod() {
		return accountingPeriod;
	}


	public void setAccountingPeriod(String accountingPeriod) {
		this.accountingPeriod = accountingPeriod;
	}


	public String getFamily() {
		return family;
	}


	public void setFamily(String family) {
		this.family = family;
	}


	public String getPriorityType() {
		return priorityType;
	}


	public void setPriorityType(String priorityType) {
		this.priorityType = priorityType;
	}


	public long getDayPPayment() {
		return dayPPayment;
	}


	public void setDayPPayment(long dayPPayment) {
		this.dayPPayment = dayPPayment;
	}


	public String getSubsidy() {
		return subsidy;
	}


	public void setSubsidy(String subsidy) {
		this.subsidy = subsidy;
	}


	public String gettPreference() {
		return tPreference;
	}


	public void settPreference(String tPreference) {
		this.tPreference = tPreference;
	}


	public String getGroupReport() {
		return groupReport;
	}


	public void setGroupReport(String groupReport) {
		this.groupReport = groupReport;
	}


	public String getModeReest() {
		return modeReest;
	}


	public void setModeReest(String modeReest) {
		this.modeReest = modeReest;
	}


	public String getPaymentEffect() {
		return paymentEffect;
	}


	public void setPaymentEffect(String paymentEffect) {
		this.paymentEffect = paymentEffect;
	}


	public Long getAffiliate() {
		return affiliate;
	}


	public void setAffiliate(Long affiliate) {
		this.affiliate = affiliate;
	}


	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (currency ^ (currency >>> 32));
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DefaultOperation other = (DefaultOperation) obj;
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
		return "DefaultOperation [operation=" + operation + ", currency="
				+ currency + ", change=" + change + ", changePeriod="
				+ changePeriod + ", specialChange=" + specialChange
				+ ", renew=" + renew + ", type=" + type + ", state=" + state
				+ ", prePayment=" + prePayment + ", completeQuota="
				+ completeQuota + ", chargeType=" + chargeType
				+ ", reductionType=" + reductionType + ", aceptAdvances="
				+ aceptAdvances + ", tTerm=" + tTerm + ", applicationType="
				+ applicationType + ", term=" + term + ", tDividend="
				+ tDividend + ", capPeriod=" + capPeriod + ", intPeriod="
				+ intPeriod + ", capGrace=" + capGrace + ", intGrace="
				+ intGrace + ", distGrace=" + distGrace + ", daysYear="
				+ daysYear + ", amortizationType=" + amortizationType
				+ ", fixedDate=" + fixedDate + ", dayPayment=" + dayPayment
				+ ", fixedQuota=" + fixedQuota + ", daysGrace=" + daysGrace
				+ ", avoidHolidays=" + avoidHolidays + ", monthGrace=" + monthGrace
				+ ", fundsOwns=" + fundsOwns + ", destination=" + destination
				+ ", originFunds=" + originFunds + ", quotaThrid=" + quotaThrid
				+ ", sectionAccountant=" + sectionAccountant + ", clabas="
				+ clabas + ", clabope=" + clabope + ", quotaLess=" + quotaLess
				+ ", prdCobis=" + prdCobis + ", calculationBase="
				+ calculationBase + ", currencyAdjustment="
				+ currencyAdjustment + ", adjustmentCurrency="
				+ adjustmentCurrency + ", accountingPeriod=" + accountingPeriod
				+ ", family=" + family + ", priorityType=" + priorityType
				+ ", dayPPayment=" + dayPPayment + ", subsidy=" + subsidy
				+ ", tPreference=" + tPreference + ", groupReport="
				+ groupReport + ", modeReest=" + modeReest + ", paymentEffect="
				+ paymentEffect + ", affiliate=" + affiliate + "]";
	}


	
	
	
	

	

}
