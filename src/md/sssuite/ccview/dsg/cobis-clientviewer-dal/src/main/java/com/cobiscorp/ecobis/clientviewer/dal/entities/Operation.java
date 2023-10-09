package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Date;
import java.math.BigDecimal;

@Entity
@Table(name = "ca_operacion", schema = "cob_cartera")
@NamedQuery(name = "Operation.findAll", query = "SELECT c FROM Operation c")
public class Operation implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "op_abono_ini")
	private BigDecimal downPayment;

	@Column(name = "op_aceptar_anticipos")
	private String paymentAccept;

	@Column(name = "op_agencia_venta")
	private String sellAgency;

	@Column(name = "op_ajuste_moneda")
	private String adjustCurrency;

	@Column(name = "op_anterior")
	private String antOperation;

	@Column(name = "op_banco")
	private String bank;

	@Column(name = "op_base_calculo")
	private String calculationBasis;

	@Column(name = "op_beneficiario")
	private String beneficiary;

	@Column(name = "op_canal_venta")
	private String salesChannel;

	@Column(name = "op_ciudad")
	private int city;

	@Column(name = "op_clabas")
	private String clabas;

	@Column(name = "op_clabope")
	private String clabope;

	@Column(name = "op_cliente")
	private int clientId;

	@Column(name = "op_comentario")
	private String commentary;

	@Column(name = "op_comision_agencia")
	private BigDecimal agencyCommission;

	@Column(name = "op_comision_pro")
	private double proCommission;

	@Column(name = "op_comision_ven")
	private BigDecimal venCommission;

	@Column(name = "op_compra_operacion")
	private String buyingOperation;

	@Column(name = "op_cuenta")
	private String account;

	@Column(name = "op_cuenta_agencia")
	private String agencyAccount;

	@Column(name = "op_cuenta_vendedor")
	private String sellerAccount;

	@Column(name = "op_cuota")
	private BigDecimal fee;

	@Column(name = "op_cuota_ballom")
	private String ballomFee;

	@Column(name = "op_cuota_completa")
	private String wholeFee;

	@Column(name = "op_cuota_incluye")
	private String includeFee;

	@Column(name = "op_cuota_menor")
	private String smallerFee;

	@Column(name = "op_cuota_promocion")
	private BigDecimal promoFee;

	@Column(name = "op_cupos_terceros")
	private String thirdPartQuota;

	@Column(name = "op_destino")
	private String destiny;

	@Column(name = "op_dia_fijo")
	private short staticDay;

	@Column(name = "op_dias_anio")
	private short dayYear;

	@Column(name = "op_dias_desembolso")
	private int disbursementDay;

	@Column(name = "op_dias_prorroga")
	private short extensionDays;

	@Column(name = "op_dist_gracia")
	private String opDistGrace;

	@Column(name = "op_dividendo_vig")
	private short currentAmount;

	@Column(name = "op_efecto_pago")
	private String paymentEfect;

	@Column(name = "op_entrevistador")
	private String interviewer;

	@Column(name = "op_estado")
	private short status;

	@Column(name = "op_estado_deuda")
	private String debtStatus;

	@Column(name = "op_estado_manual")
	private String manualStatus;

	@Column(name = "op_evitar_feriados")
	private String avoidHolidays;

	@Column(name = "op_factura")
	private String bill;

	@Column(name = "op_fecha_cambio_est")
	private Date statusChangeDate;

	@Column(name = "op_fecha_fin")
	private Date endingDate;

	@Column(name = "op_fecha_ini")
	private Date startingDate;

	@Column(name = "op_fecha_ins_desembolso")
	private Date disbursementInsDate;

	@Column(name = "op_fecha_liq")
	private Date liqDate;

	@Column(name = "op_fecha_reajuste")
	private Date resetDate;

	@Column(name = "op_fecha_ult_mod")
	private Date lastModificationDate;

	@Column(name = "op_fecha_ult_pago")
	private Date lastPaymentDate;

	@Column(name = "op_fecha_ult_pago_cap")
	private Date lastCapitalPaymentDay;

	@Column(name = "op_fecha_ult_pago_int")
	private Date lastIntPaymentDate;

	@Column(name = "op_fecha_ult_proceso")
	private Date lastProcessDate;

	@Column(name = "op_fecha_ult_reaj")
	private Date lastResetDate;

	@Column(name = "op_fecha_ult_reest")
	private Date lastRestructureDate;

	@Column(name = "op_fecha_ven_legal")
	private Date legalExpirationDate;

	@Column(name = "op_financia")
	private String finances;

	@Column(name = "op_fondos_propios")
	private String ownFunds;

	@Column(name = "op_forma_pago")
	private String paymentWay;

	@Column(name = "op_garant_emi")
	private String emiWarranty;

	@Column(name = "op_gracia_cap")
	private short capGrace;

	@Column(name = "op_gracia_int")
	private short intGrace;

	@Column(name = "op_gracia_mora")
	private String graceBeforeFee;

	@Column(name = "op_iniciador")
	private String initiator;

	@Column(name = "op_lin_comext")
	private String linComext;

	@Column(name = "op_lin_credito")
	private String linCredit;

	@Column(name = "op_mes_gracia")
	private short monthGrace;

	@Column(name = "op_migrada")
	private String migrated;

	@Column(name = "op_modo_reest")
	private String restructureMode;

	@Column(name = "op_moneda")
	private short currency;

	@Column(name = "op_moneda_ajuste")
	private short currencyAdjusting;

	@Column(name = "op_monto")
	private BigDecimal amount;

	@Column(name = "op_monto_aprobado")
	private BigDecimal approvedAmount;

	@Column(name = "op_monto_preferencial")
	private BigDecimal preferencialAmount;

	@Column(name = "op_monto_promocion")
	private BigDecimal promoAmount;

	@Column(name = "op_monto_ult_pago")
	private BigDecimal lastAmountPayment;

	@Column(name = "op_monto_ult_pago_cap")
	private BigDecimal lastCapitalPayment;

	@Column(name = "op_monto_ult_pago_int")
	private BigDecimal lastIntPayment;

	@Column(name = "op_nombre")
	private String name;

	@Column(name = "op_nro_bmi")
	private String bmiNumber;

	@Column(name = "op_num_prorroga")
	private short extensionNumber;

	@Column(name = "op_num_reajuste")
	private short adjustNumber;

	@Column(name = "op_num_reest")
	private short restructureNumber;

	@Column(name = "op_num_renovacion")
	private short renewNumber;

	@Column(name = "op_oficial")
	private short official;

	@Column(name = "op_oficial_cont")
	private short officialCont;

	@Column(name = "op_oficina")
	private short office;

	@Column(name = "op_opcion_compra")
	private BigDecimal buyingChoice;

	@Column(name = "op_operacion")
	private int operation;

	@Column(name = "op_origen_fondo")
	private String sourceFunds;

	@Column(name = "op_periodo_cap")
	private short capitalPeriod;

	@Column(name = "op_periodo_int")
	private short intPeriod;

	@Column(name = "op_periodo_reajuste")
	private short opPeriodoReajust;

	@Column(name = "op_plazo")
	private short term;

	@Column(name = "op_plazo_contable")
	private String accountingTerm;

	@Column(name = "op_porcentaje_preferencial")
	private double preferencialPercentage;

	@Column(name = "op_porcentaje_subsidio")
	private double subsidyPercentage;

	@Column(name = "op_prd_cobis")
	private short cobisProduct;

	@Column(name = "op_precancelacion")
	private String precancelation;

	@Column(name = "op_premios")
	private BigDecimal awards;

	@Column(name = "op_product_group")
	private String productGroup;

	@Column(name = "op_promotor")
	private int promoter;

	@Column(name = "op_reajustable")
	private String readjustable;

	@Column(name = "op_reajuste_especial")
	private String specialReadjust;

	@Column(name = "op_reest_int")
	private String intReestructure;

	@Column(name = "op_ref_exterior")
	private String externalReference;

	@Column(name = "op_referido")
	private String refered;

	@Column(name = "op_renovacion")
	private String renovate;

	@Column(name = "op_saldo")
	private BigDecimal balance;

	@Column(name = "op_saldo_promocion")
	private BigDecimal promoBalance;

	@Column(name = "op_sec_ult_pago")
	private int lastSecPayment;

	@Column(name = "op_sector")
	private String sector;

	@Column(name = "op_sector_contable")
	private String accountingSector;

	@Column(name = "op_subsidio")
	private String subsidy;

	@Column(name = "op_sujeta_nego")
	private String sujetaNego;

	@Column(name = "op_tasa_anterior")
	private double lastRate;

	@Column(name = "op_tcertificado")
	private String tCertification;

	@Column(name = "op_tdividendo")
	private String tAmount;

	@Column(name = "op_tipo")
	private String type;

	@Column(name = "op_tipo_amortizacion")
	private String amortizationType;

	@Column(name = "op_tipo_aplicacion")
	private String applicationType;

	@Column(name = "op_tipo_cobro")
	private String collectType;

	@Column(name = "op_tipo_prioridad")
	private String priorityType;

	@Column(name = "op_tipo_promocion")
	private String promoType;

	@Column(name = "op_tipo_reduccion")
	private String reductionType;

	@Column(name = "op_toperacion")
	private String tOperation;

	@Column(name = "op_tplazo")
	private String tTerm;

	@Column(name = "op_tpreferencial")
	private String tPreferential;

	@Column(name = "op_tramite")
	private int procedureNumber;

	@Column(name = "op_usuario_mod")
	private String opUserMod;

	@Column(name = "op_vendedor")
	private String seller;

	@Column(name = "op_via_judicial")
	private String courtProcedure;

	public Operation() {
	}

	public BigDecimal getDownPayment() {
		return downPayment;
	}

	public void setDownPayment(BigDecimal downPayment) {
		this.downPayment = downPayment;
	}

	public String getPaymentAccept() {
		return paymentAccept;
	}

	public void setPaymentAccept(String paymentAccept) {
		this.paymentAccept = paymentAccept;
	}

	public String getSellAgency() {
		return sellAgency;
	}

	public void setSellAgency(String sellAgency) {
		this.sellAgency = sellAgency;
	}

	public String getAdjustCurrency() {
		return adjustCurrency;
	}

	public void setAdjustCurrency(String adjustCurrency) {
		this.adjustCurrency = adjustCurrency;
	}

	public String getAntOperation() {
		return antOperation;
	}

	public void setAntOperation(String antOperation) {
		this.antOperation = antOperation;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getCalculationBasis() {
		return calculationBasis;
	}

	public void setCalculationBasis(String calculationBasis) {
		this.calculationBasis = calculationBasis;
	}

	public String getBeneficiary() {
		return beneficiary;
	}

	public void setBeneficiary(String beneficiary) {
		this.beneficiary = beneficiary;
	}

	public String getSalesChannel() {
		return salesChannel;
	}

	public void setSalesChannel(String salesChannel) {
		this.salesChannel = salesChannel;
	}

	public int getCity() {
		return city;
	}

	public void setCity(int city) {
		this.city = city;
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

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getCommentary() {
		return commentary;
	}

	public void setCommentary(String commentary) {
		this.commentary = commentary;
	}

	public BigDecimal getAgencyCommission() {
		return agencyCommission;
	}

	public void setAgencyCommission(BigDecimal agencyCommission) {
		this.agencyCommission = agencyCommission;
	}

	public double getProCommission() {
		return proCommission;
	}

	public void setProCommission(double proCommission) {
		this.proCommission = proCommission;
	}

	public BigDecimal getVenCommission() {
		return venCommission;
	}

	public void setVenCommission(BigDecimal venCommission) {
		this.venCommission = venCommission;
	}

	public String getBuyingOperation() {
		return buyingOperation;
	}

	public void setBuyingOperation(String buyingOperation) {
		this.buyingOperation = buyingOperation;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAgencyAccount() {
		return agencyAccount;
	}

	public void setAgencyAccount(String agencyAccount) {
		this.agencyAccount = agencyAccount;
	}

	public String getSellerAccount() {
		return sellerAccount;
	}

	public void setSellerAccount(String sellerAccount) {
		this.sellerAccount = sellerAccount;
	}

	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public String getBallomFee() {
		return ballomFee;
	}

	public void setBallomFee(String ballomFee) {
		this.ballomFee = ballomFee;
	}

	public String getWholeFee() {
		return wholeFee;
	}

	public void setWholeFee(String wholeFee) {
		this.wholeFee = wholeFee;
	}

	public String getIncludeFee() {
		return includeFee;
	}

	public void setIncludeFee(String includeFee) {
		this.includeFee = includeFee;
	}

	public String getSmallerFee() {
		return smallerFee;
	}

	public void setSmallerFee(String smallerFee) {
		this.smallerFee = smallerFee;
	}

	public BigDecimal getPromoFee() {
		return promoFee;
	}

	public void setPromoFee(BigDecimal promoFee) {
		this.promoFee = promoFee;
	}

	public String getThirdPartQuota() {
		return thirdPartQuota;
	}

	public void setThirdPartQuota(String thirdPartQuota) {
		this.thirdPartQuota = thirdPartQuota;
	}

	public String getDestiny() {
		return destiny;
	}

	public void setDestiny(String destiny) {
		this.destiny = destiny;
	}

	public short getStaticDay() {
		return staticDay;
	}

	public void setStaticDay(short staticDay) {
		this.staticDay = staticDay;
	}

	public short getDayYear() {
		return dayYear;
	}

	public void setDayYear(short dayYear) {
		this.dayYear = dayYear;
	}

	public int getDisbursementDay() {
		return disbursementDay;
	}

	public void setDisbursementDay(int disbursementDay) {
		this.disbursementDay = disbursementDay;
	}

	public short getExtensionDays() {
		return extensionDays;
	}

	public void setExtensionDays(short extensionDays) {
		this.extensionDays = extensionDays;
	}

	public String getOpDistGrace() {
		return opDistGrace;
	}

	public void setOpDistGrace(String opDistGrace) {
		this.opDistGrace = opDistGrace;
	}

	public short getCurrentAmount() {
		return currentAmount;
	}

	public void setCurrentAmount(short currentAmount) {
		this.currentAmount = currentAmount;
	}

	public String getPaymentEfect() {
		return paymentEfect;
	}

	public void setPaymentEfect(String paymentEfect) {
		this.paymentEfect = paymentEfect;
	}

	public String getInterviewer() {
		return interviewer;
	}

	public void setInterviewer(String interviewer) {
		this.interviewer = interviewer;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public String getDebtStatus() {
		return debtStatus;
	}

	public void setDebtStatus(String debtStatus) {
		this.debtStatus = debtStatus;
	}

	public String getManualStatus() {
		return manualStatus;
	}

	public void setManualStatus(String manualStatus) {
		this.manualStatus = manualStatus;
	}

	public String getAvoidHolidays() {
		return avoidHolidays;
	}

	public void setAvoidHolidays(String avoidHolidays) {
		this.avoidHolidays = avoidHolidays;
	}

	public String getBill() {
		return bill;
	}

	public void setBill(String bill) {
		this.bill = bill;
	}

	public Date getStatusChangeDate() {
		return statusChangeDate;
	}

	public void setStatusChangeDate(Date statusChangeDate) {
		this.statusChangeDate = statusChangeDate;
	}

	public Date getEndingDate() {
		return endingDate;
	}

	public void setEndingDate(Date endingDate) {
		this.endingDate = endingDate;
	}

	public Date getStartingDate() {
		return startingDate;
	}

	public void setStartingDate(Date startingDate) {
		this.startingDate = startingDate;
	}

	public Date getDisbursementInsDate() {
		return disbursementInsDate;
	}

	public void setDisbursementInsDate(Date disbursementInsDate) {
		this.disbursementInsDate = disbursementInsDate;
	}

	public Date getLiqDate() {
		return liqDate;
	}

	public void setLiqDate(Date liqDate) {
		this.liqDate = liqDate;
	}

	public Date getResetDate() {
		return resetDate;
	}

	public void setResetDate(Date resetDate) {
		this.resetDate = resetDate;
	}

	public Date getLastModificationDate() {
		return lastModificationDate;
	}

	public void setLastModificationDate(Date lastModificationDate) {
		this.lastModificationDate = lastModificationDate;
	}

	public Date getLastPaymentDate() {
		return lastPaymentDate;
	}

	public void setLastPaymentDate(Date lastPaymentDate) {
		this.lastPaymentDate = lastPaymentDate;
	}

	public Date getLastCapitalPaymentDay() {
		return lastCapitalPaymentDay;
	}

	public void setLastCapitalPaymentDay(Date lastCapitalPaymentDay) {
		this.lastCapitalPaymentDay = lastCapitalPaymentDay;
	}

	public Date getLastIntPaymentDate() {
		return lastIntPaymentDate;
	}

	public void setLastIntPaymentDate(Date lastIntPaymentDate) {
		this.lastIntPaymentDate = lastIntPaymentDate;
	}

	public Date getLastProcessDate() {
		return lastProcessDate;
	}

	public void setLastProcessDate(Date lastProcessDate) {
		this.lastProcessDate = lastProcessDate;
	}

	public Date getLastResetDate() {
		return lastResetDate;
	}

	public void setLastResetDate(Date lastResetDate) {
		this.lastResetDate = lastResetDate;
	}

	public Date getLastRestructureDate() {
		return lastRestructureDate;
	}

	public void setLastRestructureDate(Date lastRestructureDate) {
		this.lastRestructureDate = lastRestructureDate;
	}

	public Date getLegalExpirationDate() {
		return legalExpirationDate;
	}

	public void setLegalExpirationDate(Date legalExpirationDate) {
		this.legalExpirationDate = legalExpirationDate;
	}

	public String getFinances() {
		return finances;
	}

	public void setFinances(String finances) {
		this.finances = finances;
	}

	public String getOwnFunds() {
		return ownFunds;
	}

	public void setOwnFunds(String ownFunds) {
		this.ownFunds = ownFunds;
	}

	public String getPaymentWay() {
		return paymentWay;
	}

	public void setPaymentWay(String paymentWay) {
		this.paymentWay = paymentWay;
	}

	public String getEmiWarranty() {
		return emiWarranty;
	}

	public void setEmiWarranty(String emiWarranty) {
		this.emiWarranty = emiWarranty;
	}

	public short getCapGrace() {
		return capGrace;
	}

	public void setCapGrace(short capGrace) {
		this.capGrace = capGrace;
	}

	public short getIntGrace() {
		return intGrace;
	}

	public void setIntGrace(short intGrace) {
		this.intGrace = intGrace;
	}

	public String getGraceBeforeFee() {
		return graceBeforeFee;
	}

	public void setGraceBeforeFee(String graceBeforeFee) {
		this.graceBeforeFee = graceBeforeFee;
	}

	public String getInitiator() {
		return initiator;
	}

	public void setInitiator(String initiator) {
		this.initiator = initiator;
	}

	public String getLinComext() {
		return linComext;
	}

	public void setLinComext(String linComext) {
		this.linComext = linComext;
	}

	public String getLinCredit() {
		return linCredit;
	}

	public void setLinCredit(String linCredit) {
		this.linCredit = linCredit;
	}

	public short getMonthGrace() {
		return monthGrace;
	}

	public void setMonthGrace(short monthGrace) {
		this.monthGrace = monthGrace;
	}

	public String getMigrated() {
		return migrated;
	}

	public void setMigrated(String migrated) {
		this.migrated = migrated;
	}

	public String getRestructureMode() {
		return restructureMode;
	}

	public void setRestructureMode(String restructureMode) {
		this.restructureMode = restructureMode;
	}

	public short getCurrency() {
		return currency;
	}

	public void setCurrency(short currency) {
		this.currency = currency;
	}

	public short getCurrencyAdjusting() {
		return currencyAdjusting;
	}

	public void setCurrencyAdjusting(short currencyAdjusting) {
		this.currencyAdjusting = currencyAdjusting;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getApprovedAmount() {
		return approvedAmount;
	}

	public void setApprovedAmount(BigDecimal approvedAmount) {
		this.approvedAmount = approvedAmount;
	}

	public BigDecimal getPreferencialAmount() {
		return preferencialAmount;
	}

	public void setPreferencialAmount(BigDecimal preferencialAmount) {
		this.preferencialAmount = preferencialAmount;
	}

	public BigDecimal getPromoAmount() {
		return promoAmount;
	}

	public void setPromoAmount(BigDecimal promoAmount) {
		this.promoAmount = promoAmount;
	}

	public BigDecimal getLastAmountPayment() {
		return lastAmountPayment;
	}

	public void setLastAmountPayment(BigDecimal lastAmountPayment) {
		this.lastAmountPayment = lastAmountPayment;
	}

	public BigDecimal getLastCapitalPayment() {
		return lastCapitalPayment;
	}

	public void setLastCapitalPayment(BigDecimal lastCapitalPayment) {
		this.lastCapitalPayment = lastCapitalPayment;
	}

	public BigDecimal getLastIntPayment() {
		return lastIntPayment;
	}

	public void setLastIntPayment(BigDecimal lastIntPayment) {
		this.lastIntPayment = lastIntPayment;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBmiNumber() {
		return bmiNumber;
	}

	public void setBmiNumber(String bmiNumber) {
		this.bmiNumber = bmiNumber;
	}

	public short getExtensionNumber() {
		return extensionNumber;
	}

	public void setExtensionNumber(short extensionNumber) {
		this.extensionNumber = extensionNumber;
	}

	public short getAdjustNumber() {
		return adjustNumber;
	}

	public void setAdjustNumber(short adjustNumber) {
		this.adjustNumber = adjustNumber;
	}

	public short getRestructureNumber() {
		return restructureNumber;
	}

	public void setRestructureNumber(short restructureNumber) {
		this.restructureNumber = restructureNumber;
	}

	public short getRenewNumber() {
		return renewNumber;
	}

	public void setRenewNumber(short renewNumber) {
		this.renewNumber = renewNumber;
	}

	public short getOfficial() {
		return official;
	}

	public void setOfficial(short official) {
		this.official = official;
	}

	public short getOfficialCont() {
		return officialCont;
	}

	public void setOfficialCont(short officialCont) {
		this.officialCont = officialCont;
	}

	public short getOffice() {
		return office;
	}

	public void setOffice(short office) {
		this.office = office;
	}

	public BigDecimal getBuyingChoice() {
		return buyingChoice;
	}

	public void setBuyingChoice(BigDecimal buyingChoice) {
		this.buyingChoice = buyingChoice;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public String getSourceFunds() {
		return sourceFunds;
	}

	public void setSourceFunds(String sourceFunds) {
		this.sourceFunds = sourceFunds;
	}

	public short getCapitalPeriod() {
		return capitalPeriod;
	}

	public void setCapitalPeriod(short capitalPeriod) {
		this.capitalPeriod = capitalPeriod;
	}

	public short getIntPeriod() {
		return intPeriod;
	}

	public void setIntPeriod(short intPeriod) {
		this.intPeriod = intPeriod;
	}

	public short getOpPeriodoReajust() {
		return opPeriodoReajust;
	}

	public void setOpPeriodoReajust(short opPeriodoReajust) {
		this.opPeriodoReajust = opPeriodoReajust;
	}

	public short getTerm() {
		return term;
	}

	public void setTerm(short term) {
		this.term = term;
	}

	public String getAccountingTerm() {
		return accountingTerm;
	}

	public void setAccountingTerm(String accountingTerm) {
		this.accountingTerm = accountingTerm;
	}

	public double getPreferencialPercentage() {
		return preferencialPercentage;
	}

	public void setPreferencialPercentage(double preferencialPercentage) {
		this.preferencialPercentage = preferencialPercentage;
	}

	public double getSubsidyPercentage() {
		return subsidyPercentage;
	}

	public void setSubsidyPercentage(double subsidyPercentage) {
		this.subsidyPercentage = subsidyPercentage;
	}

	public short getCobisProduct() {
		return cobisProduct;
	}

	public void setCobisProduct(short cobisProduct) {
		this.cobisProduct = cobisProduct;
	}

	public String getPrecancelation() {
		return precancelation;
	}

	public void setPrecancelation(String precancelation) {
		this.precancelation = precancelation;
	}

	public BigDecimal getAwards() {
		return awards;
	}

	public void setAwards(BigDecimal awards) {
		this.awards = awards;
	}

	public String getProductGroup() {
		return productGroup;
	}

	public void setProductGroup(String productGroup) {
		this.productGroup = productGroup;
	}

	public int getPromoter() {
		return promoter;
	}

	public void setPromoter(int promoter) {
		this.promoter = promoter;
	}

	public String getReadjustable() {
		return readjustable;
	}

	public void setReadjustable(String readjustable) {
		this.readjustable = readjustable;
	}

	public String getSpecialReadjust() {
		return specialReadjust;
	}

	public void setSpecialReadjust(String specialReadjust) {
		this.specialReadjust = specialReadjust;
	}

	public String getIntReestructure() {
		return intReestructure;
	}

	public void setIntReestructure(String intReestructure) {
		this.intReestructure = intReestructure;
	}

	public String getExternalReference() {
		return externalReference;
	}

	public void setExternalReference(String externalReference) {
		this.externalReference = externalReference;
	}

	public String getRefered() {
		return refered;
	}

	public void setRefered(String refered) {
		this.refered = refered;
	}

	public String getRenovate() {
		return renovate;
	}

	public void setRenovate(String renovate) {
		this.renovate = renovate;
	}

	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	public BigDecimal getPromoBalance() {
		return promoBalance;
	}

	public void setPromoBalance(BigDecimal promoBalance) {
		this.promoBalance = promoBalance;
	}

	public int getLastSecPayment() {
		return lastSecPayment;
	}

	public void setLastSecPayment(int lastSecPayment) {
		this.lastSecPayment = lastSecPayment;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getAccountingSector() {
		return accountingSector;
	}

	public void setAccountingSector(String accountingSector) {
		this.accountingSector = accountingSector;
	}

	public String getSubsidy() {
		return subsidy;
	}

	public void setSubsidy(String subsidy) {
		this.subsidy = subsidy;
	}

	public String getSujetaNego() {
		return sujetaNego;
	}

	public void setSujetaNego(String sujetaNego) {
		this.sujetaNego = sujetaNego;
	}

	public double getLastRate() {
		return lastRate;
	}

	public void setLastRate(double lastRate) {
		this.lastRate = lastRate;
	}

	public String gettCertification() {
		return tCertification;
	}

	public void settCertification(String tCertification) {
		this.tCertification = tCertification;
	}

	public String gettAmount() {
		return tAmount;
	}

	public void settAmount(String tAmount) {
		this.tAmount = tAmount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAmortizationType() {
		return amortizationType;
	}

	public void setAmortizationType(String amortizationType) {
		this.amortizationType = amortizationType;
	}

	public String getApplicationType() {
		return applicationType;
	}

	public void setApplicationType(String applicationType) {
		this.applicationType = applicationType;
	}

	public String getCollectType() {
		return collectType;
	}

	public void setCollectType(String collectType) {
		this.collectType = collectType;
	}

	public String getPriorityType() {
		return priorityType;
	}

	public void setPriorityType(String priorityType) {
		this.priorityType = priorityType;
	}

	public String getPromoType() {
		return promoType;
	}

	public void setPromoType(String promoType) {
		this.promoType = promoType;
	}

	public String getReductionType() {
		return reductionType;
	}

	public void setReductionType(String reductionType) {
		this.reductionType = reductionType;
	}

	public String gettOperation() {
		return tOperation;
	}

	public void settOperation(String tOperation) {
		this.tOperation = tOperation;
	}

	public String gettTerm() {
		return tTerm;
	}

	public void settTerm(String tTerm) {
		this.tTerm = tTerm;
	}

	public String gettPreferential() {
		return tPreferential;
	}

	public void settPreferential(String tPreferential) {
		this.tPreferential = tPreferential;
	}

	public int getProcedureNumber() {
		return procedureNumber;
	}

	public void setProcedureNumber(int procedureNumber) {
		this.procedureNumber = procedureNumber;
	}

	public String getOpUserMod() {
		return opUserMod;
	}

	public void setOpUserMod(String opUserMod) {
		this.opUserMod = opUserMod;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public String getCourtProcedure() {
		return courtProcedure;
	}

	public void setCourtProcedure(String courtProcedure) {
		this.courtProcedure = courtProcedure;
	}

}