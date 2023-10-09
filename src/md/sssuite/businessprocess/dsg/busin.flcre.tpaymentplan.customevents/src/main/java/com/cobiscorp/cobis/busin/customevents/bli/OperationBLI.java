package com.cobiscorp.cobis.busin.customevents.bli;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert.CDate;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.AmortizationTableHeader;
import com.cobiscorp.cobis.busin.model.AmortizationTableItem;
import com.cobiscorp.cobis.busin.model.ApprovalCriteriaQuestion;
import com.cobiscorp.cobis.busin.model.CreditOtherData;
import com.cobiscorp.cobis.busin.model.GeneralParameterLoan;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentCapacity;
import com.cobiscorp.cobis.busin.model.PaymentCapacityHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import java.util.Date;

public class OperationBLI {

	private static final ILogger LOGGER = LogFactory.getLogger(OperationBLI.class);

	public OperationBLI() {
	}

	public static Boolean getAndMapping(String numeroOperacion, DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration iServiceIntegration) throws Exception {
		// DEFINE ENTIDADES

		try {
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
			DataEntity generalParameterLoan = entities.getEntity(GeneralParameterLoan.ENTITY_NAME);
			DataEntity aprovalQueApprovalCriteriaQuestion = entities.getEntity(ApprovalCriteriaQuestion.ENTITY_NAME);
			paymentPlanHeader.set(PaymentPlanHeader.OPERATIONCODE, 0);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("------>getAndMapping numeroOperacion" + numeroOperacion);
			TransactionManagement tranManager = new TransactionManagement(iServiceIntegration);
			LoanResponse loanResponseDTO = tranManager.getLoanTmp(numeroOperacion, arg1, new BehaviorOption(true));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("------>loanResponseDTO" + loanResponseDTO);

			if (loanResponseDTO != null && loanResponseDTO.getCode() > 0) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("------>loanResponseDTO.getCode()" + loanResponseDTO.getCode());
				// DATOS DE LA CABECERA
				paymentPlanHeader.set(PaymentPlanHeader.OPERATIONCODE, loanResponseDTO.getCode());// 1
				paymentPlanHeader.set(PaymentPlanHeader.PRODUCTTYPE, loanResponseDTO.getProductType());// 7
				paymentPlanHeader.set(PaymentPlanHeader.CURRENCY, loanResponseDTO.getCurrency());// 9
				paymentPlanHeader.set(PaymentPlanHeader.INITIALDATE, Convert.CString.toDate(loanResponseDTO.getInitialDate()));// 13

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("JCA PaymentPlanHeader.AMOUNT " + loanResponseDTO.getAmount().toString());// 20

				paymentPlanHeader.set(PaymentPlanHeader.AMOUNT, loanResponseDTO.getAmount());// 16
				paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT, loanResponseDTO.getApprovedAmount());// 74
				paymentPlanHeader.set(PaymentPlanHeader.RATE, new BigDecimal(loanResponseDTO.getRate()));// 59
				paymentPlanHeader.set(PaymentPlanHeader.APR, new BigDecimal(loanResponseDTO.getApr()));// 109
				paymentPlanHeader.set(PaymentPlanHeader.DEBITACCOUNT, loanResponseDTO.getAccount());// 33
				paymentPlanHeader.set(PaymentPlanHeader.WAYTOPAY, loanResponseDTO.getPaymentWay() == null ? null : loanResponseDTO.getPaymentWay().trim());// 31

				// paymentPlanHeader.set(PaymentPlanHeader.DEBIT,
				// loanResponseDTO.getDebit());
				if (loanResponseDTO.getExpirationFeeDate() != null) {
					paymentPlanHeader.set(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE, Convert.CString.toDate(loanResponseDTO.getExpirationFeeDate()));// 15
				}
				// DATOS DE LA TABLA
				paymentPlan.set(PaymentPlan.BANK, numeroOperacion);// op_banco
				paymentPlan.set(PaymentPlan.TABLETYPE, loanResponseDTO.getTableType() != null ? loanResponseDTO.getTableType().trim() : loanResponseDTO.getTableType());// 49
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug(paymentPlan.get(PaymentPlan.TABLETYPE) + "---<");
				paymentPlan.set(PaymentPlan.DAYSPERYEAR, loanResponseDTO.getDaysPerYear());// 48

				paymentPlan.set(PaymentPlan.CALCULATIONBASED, loanResponseDTO.getCalculationBased().charAt(0));// 106

				paymentPlan.set(PaymentPlan.BASCALCULATIONINTEREST,

						String.valueOf(loanResponseDTO.getCalculationBased()));// 95
				paymentPlan.set(PaymentPlan.CAPITAL, loanResponseDTO.getCapitalValue());// 52
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("JCA loanResponseDTO.getQuotaValue()" + loanResponseDTO.getQuotaValue().toString());// 20
				paymentPlan.set(PaymentPlan.QUOTA, loanResponseDTO.getQuotaValue());// 51

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getQuotaType()" + loanResponseDTO.getQuotaType());// 20
				paymentPlan.set(PaymentPlan.QUOTATYPE, loanResponseDTO.getQuotaType() != null ? loanResponseDTO.getQuotaType().trim() : loanResponseDTO.getQuotaType());// 17
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getQuotaInterest()" + loanResponseDTO.getQuotaInterest());
				paymentPlan.set(PaymentPlan.QUOTAINTEREST, String.valueOf(loanResponseDTO.getQuotaInterest()));// 26
				paymentPlan.set(PaymentPlan.CAPITALPERIOD, loanResponseDTO.getCapitalPeriod());// 22
				paymentPlan.set(PaymentPlan.INTERESTPERIOD, loanResponseDTO.getInterestPeriod());// 23
				paymentPlan.set(PaymentPlan.CAPITALPERIODGRACE, loanResponseDTO.getCapitalPeriodGrace());// 24
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("PaymentPlan.INTERESTPERIODGRACE" + loanResponseDTO.getInterestPeriodGrace());
				paymentPlan.set(PaymentPlan.INTERESTPERIODGRACE, loanResponseDTO.getInterestPeriodGrace());// 25
				LOGGER.logDebug("------------loanResponseDTO.getFixedpPaymentDate()-------" + loanResponseDTO.getFixedpPaymentDate());

				paymentPlan.set(PaymentPlan.FIXEDPPAYMENTDATE, loanResponseDTO.getFixedpPaymentDate().charAt(0));// 79

				paymentPlan.set(PaymentPlan.PAYMENTDAY, loanResponseDTO.getPaymentDay());// 54
				paymentPlan.set(PaymentPlan.MONTHNOPAYMENT, loanResponseDTO.getMonthNoPayment());// 77
				paymentPlan.set(PaymentPlan.GRACEARREARSDAYS, loanResponseDTO.getGraceArrearsDays());// 53
				paymentPlan.set(PaymentPlan.AVOIDHOLIDAYS, loanResponseDTO.getAvoidHolidays().charAt(0));// 81

				generalParameterLoan.set(GeneralParameterLoan.EXCHANGERATE, loanResponseDTO.getReadjustment().charAt(0)); // 80
				generalParameterLoan.set(GeneralParameterLoan.PERIODICITY, loanResponseDTO.getPeriodReadjustment()); // 34

				generalParameterLoan.set(GeneralParameterLoan.KEEPTERM, loanResponseDTO.getSpecialReadjustment()); // 64

				if (LOGGER.isDebugEnabled())
					LOGGER.logInfo("1..LoanResponseDTO.getAnticipatedValueIndicated......JCA" + loanResponseDTO.getAnticipatedValueIndicated());

				generalParameterLoan.set(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS, loanResponseDTO.getAnticipatedValueIndicated().charAt(0));

				generalParameterLoan.set(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT, loanResponseDTO.getReductionQuota().charAt(0));
				if (LOGGER.isDebugEnabled())
					LOGGER.logInfo("33.................Pago Extraordniario.................." + loanResponseDTO.getReductionQuota());

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getAllowsRenovation()" + loanResponseDTO.getAllowsRenovation());
				if (loanResponseDTO.getAllowsRenovation() != null) {
					generalParameterLoan.set(GeneralParameterLoan.ALLOWSRENEWAL, loanResponseDTO.getAllowsRenovation().toString()); // 37
				}

				if (loanResponseDTO.getPrecancellation() != null) {
					generalParameterLoan.set(GeneralParameterLoan.ALLOWSPREPAY, loanResponseDTO.getPrecancellation().toString()); // 39
				}

				generalParameterLoan.set(GeneralParameterLoan.PERIODICITY, loanResponseDTO.getPeriodReadjustment()); // 34
				generalParameterLoan.set(GeneralParameterLoan.ESPECIALREADJUSTMENT, loanResponseDTO.getSpecialReadjustment());// 64
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getApplicationType()" + loanResponseDTO.getApplicationType());
				generalParameterLoan.set(GeneralParameterLoan.PAYMENT, loanResponseDTO.getApplicationType().charAt(0));// 75

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getReductionQuota()" + loanResponseDTO.getReductionQuota());
				if (loanResponseDTO.getReductionQuota() != null && (loanResponseDTO.getReductionQuota().charAt(0) == 'P' || loanResponseDTO.getReductionQuota().charAt(0) == 'T')) {
					generalParameterLoan.set(GeneralParameterLoan.PAYMENTTYPE, "E");
					generalParameterLoan.set(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT, loanResponseDTO.getReductionQuota().charAt(0));// 46

				} else if (loanResponseDTO.getReductionQuota() != null && loanResponseDTO.getReductionQuota().charAt(0) == 'N') {
					generalParameterLoan.set(GeneralParameterLoan.PAYMENTTYPE, loanResponseDTO.getReductionQuota());
					generalParameterLoan.set(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT, '\0');
				}

				generalParameterLoan.set(GeneralParameterLoan.ONLYCOMPLETEFEEPAYMENTS, loanResponseDTO.getQuotaComplete().charAt(0)); // 43
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getInterestAnticipated()" + loanResponseDTO.getInterestAnticipated());
				generalParameterLoan.set(GeneralParameterLoan.INTERESTPAYMENT, loanResponseDTO.getInterestAnticipated().charAt(0)); // 44
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getDailyReadjustment()" + loanResponseDTO.getDailyReadjustment());
				generalParameterLoan.set(GeneralParameterLoan.READJUSTMENTPERIODICITY, loanResponseDTO.getDailyReadjustment().charAt(0));// 94
				generalParameterLoan.set(GeneralParameterLoan.PREPAYMENTTYPE, loanResponseDTO.getEffectPayment()); // 114
				if (loanResponseDTO.getPriorityType() != null) {
					generalParameterLoan.set(GeneralParameterLoan.APPLYONLYCAPITAL, loanResponseDTO.getPriorityType().toString()); // 107
				}

				if (aprovalQueApprovalCriteriaQuestion.get(ApprovalCriteriaQuestion.TARIFFRATE) == null && paymentPlanHeader.get(PaymentPlanHeader.RATE) != null) {
					aprovalQueApprovalCriteriaQuestion.set(ApprovalCriteriaQuestion.TARIFFRATE, paymentPlanHeader.get(PaymentPlanHeader.RATE).doubleValue());
				}

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("loanResponseDTO.getTermType()" + loanResponseDTO.getTermType());
				paymentPlan.set(PaymentPlan.TERMTYPE, loanResponseDTO.getTermType() != null ? loanResponseDTO.getTermType().trim() : loanResponseDTO.getTermType());// 17
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug(paymentPlan.get(PaymentPlan.TERMTYPE) + "---<");
				paymentPlan.set(PaymentPlan.TERM, loanResponseDTO.getTerm());// 19

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("OperationBLI recuperado para - IDREQUESTED: " + numeroOperacion);
				return true;
			} else { // ES PRIMERA VEZ QUE SE VA A CREAR LA OPERACION
				return false;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_BLI_OPERATION, e, arg1, LOGGER);
			throw e;
		}
	}

	public static boolean CreateLoanTmp(DynamicRequest entities, IExecuteCommandEventArgs args, ICTSServiceIntegration iServiceIntegration) {
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
		DataEntity creditOtherData = entities.getEntity(CreditOtherData.ENTITY_NAME);
		DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);

		cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest loanRequestDTO = new cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest();
		loanRequestDTO.setCode(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)); // @i_tramite
		loanRequestDTO.setCustomer(paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERCODE)); // @i_cliente
		loanRequestDTO.setCustomerName(paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERNAME)); // @i_nombre
		loanRequestDTO.setCurrency(paymentPlanHeader.get(PaymentPlanHeader.CURRENCY)); // @i_moneda
		loanRequestDTO.setSector(officerAnalysis.get(OfficerAnalysis.SECTOR)); // @i_sector
		loanRequestDTO.setOperationCode(paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE)); // @i_toperacion
		loanRequestDTO.setOffice(originalHeader.get(OriginalHeader.OFFICE)); // @i_oficina
		loanRequestDTO.setOfficer(Integer.parseInt(officerAnalysis.get(OfficerAnalysis.OFFICER))); // @i_oficial
		loanRequestDTO.setInitDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
		loanRequestDTO.setDisbursementAmount(paymentPlanHeader.get(PaymentPlanHeader.AMOUNT)); // @i_monto
		loanRequestDTO.setApprovedAmount(paymentPlanHeader.get(PaymentPlanHeader.APPROVEDAMOUNT)); // @i_monto_aprobado
		loanRequestDTO.setDebit(paymentPlanHeader.get(PaymentPlanHeader.DEBIT)); // @i_debcta
		loanRequestDTO.setExpirationFeeDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE)));// @i_fecha_vcmto1
		loanRequestDTO.setDestination(creditOtherData.get(CreditOtherData.CREDITDESTINATION)); // @i_destino
		loanRequestDTO.setCity(originalHeader.get(OriginalHeader.CITYCODE)); // @i_ciudad
		loanRequestDTO.setCityDestination(officerAnalysis.get(OfficerAnalysis.CITY)); // @i_ciudad_destino
		loanRequestDTO.setDateFormat(SessionContext.getFormatDate()); // @i_formato_fecha
		loanRequestDTO.setNoBank(Mnemonic.CHAR_N); // @i_no_banco
		loanRequestDTO.setFundingSource(creditOtherData.get(CreditOtherData.SOURCEOFFUNDING)); // @i_origen_fondo
		loanRequestDTO.setOwnFunding(Mnemonic.CHAR_S); // @i_fondos_propios
		loanRequestDTO.setType(Mnemonic.CHAR_O); // @i_tipo_tr
		// loanRequestDTO.setTermTime(paymentPlan.get(PaymentPlan.TERMTYPE));//
		// @i_tplazo
		// loanRequestDTO.setTerm(paymentPlan.get(PaymentPlan.TERM));// @i_plazo
		// loanRequestDTO.setTerm(paymentPlanHeader.get(PaymentPlan.TERM));
		// @i_plazo
		// loanRequestDTO.setTermTime(paymentPlan.get(PaymentPlan.PAYMENTFREQUENCY));
		// @i_tplazo

		loanRequestDTO.setBank(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED) + ""); // @i_numero_banco
		// SOLO PARA LINEA CREDITO
		boolean isCreditLine = (originalHeader.get(OriginalHeader.NUMBERLINE) != null && !originalHeader.get(OriginalHeader.NUMBERLINE).isEmpty());
		if (isCreditLine) {
			loanRequestDTO.setCreditLine(originalHeader.get(OriginalHeader.NUMBERLINE));// @i_linea_credito
		}

		// CONSUMO EL SERVCIO
		TransactionManagement transactionManagement = new TransactionManagement(iServiceIntegration);
		return transactionManagement.CreateLoanTmp(loanRequestDTO, args);
	}

	public static boolean UpdateLoanTmp(DynamicRequest entities, IExecuteCommandEventArgs args, ICTSServiceIntegration iServiceIntegration, Integer operationCode) {
		String numeroOperacion;
		Date fechaDispersion;
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity creditOtherData = entities.getEntity(CreditOtherData.ENTITY_NAME);
		DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
		DataEntityList amortizationTableHeader = entities.getEntityList(AmortizationTableHeader.ENTITY_NAME);
		cobiscorp.ecobis.loan.dto.LoanRequest loanRequestDTO = new cobiscorp.ecobis.loan.dto.LoanRequest();

		if (originalHeader.get(OriginalHeader.OPNUMBERBANK) != null)
			numeroOperacion = originalHeader.get(OriginalHeader.OPNUMBERBANK);
		else
			numeroOperacion = String.valueOf(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));

		// DATOS FECHA DE DISPERSION
		LOGGER.logDebug("SE AGREGA FECHA DISP");
		fechaDispersion = paymentPlanHeader.get(PaymentPlanHeader.DISPERSIONDATE);

		loanRequestDTO.setFechaDispersion(Convert.CDate.toCalendar(fechaDispersion));

		// DATOS CONTEXTO
		loanRequestDTO.setDateFormat(SessionContext.getFormatDate()); // @i_formato_fecha
		loanRequestDTO.setBank(numeroOperacion); // @i_banco
		loanRequestDTO.setBeneficiary(paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERNAME));// @i_nombre
		// @i_sector
		loanRequestDTO.setOfficeChg(originalHeader.get(OriginalHeader.OFFICE));// @i_oficina
		String officerAnaliysis = officerAnalysis.get(OfficerAnalysis.OFFICER);
		loanRequestDTO.setOfficer(officerAnalysis.get(OfficerAnalysis.OFFICER) == null ? null : Integer.parseInt(officerAnalysis.get(OfficerAnalysis.OFFICER))); // @i_oficial
		loanRequestDTO.setDestination(creditOtherData.get(CreditOtherData.CREDITDESTINATION)); // @i_destino
		loanRequestDTO.setCity(originalHeader.get(OriginalHeader.CITYCODE)); // @i_ciudad

		// DATOS CABECERA
		loanRequestDTO.setProduct(paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE)); // @i_toperacion
		loanRequestDTO.setCurrency(paymentPlanHeader.get(PaymentPlanHeader.CURRENCY)); // @i_moneda
		loanRequestDTO.setAmountDs(paymentPlanHeader.get(PaymentPlanHeader.AMOUNT).doubleValue()); // @i_monto
		loanRequestDTO.setAmountDsDec(paymentPlanHeader.get(PaymentPlanHeader.APPROVEDAMOUNT).doubleValue()); // @i_monto_aprobado
		loanRequestDTO.setInitDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));// @i_fecha_ini
		loanRequestDTO.setDebit(paymentPlanHeader.get(PaymentPlanHeader.DEBIT)); // @i_debcta
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE)" + paymentPlanHeader.get(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE));
		if (paymentPlanHeader.get(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE) == null) {
			loanRequestDTO.setExpirationFeeDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
		} else {
			// Se aumenta cuando se guarda/elimina un nuevo rubro y se recalcula
			// tabla
			loanRequestDTO.setExpirationFeeDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE)));// @i_fecha_vcmto1
		}
		loanRequestDTO.setCalculateTable('S');

		// Inicio Req.194284 Dia de Pago
		loanRequestDTO.setPaymentDayDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.PAYMENTDAY)));// @i_dia_pago
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Dia de Pago Pantalla--->" + paymentPlanHeader.get(PaymentPlanHeader.PAYMENTDAY));
			LOGGER.logDebug("Dia de Pago Request ----->" + loanRequestDTO.getPaymentDay());
		}
		// Fin Req.194284 Dia de Pago

		// DATOS DETALLE
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Tipo de Tabla --->" + paymentPlan.get(PaymentPlan.TABLETYPE));
			LOGGER.logDebug("Cuota ----->" + paymentPlan.get(PaymentPlan.QUOTA));
		}
		loanRequestDTO.setTableType(paymentPlan.get(PaymentPlan.TABLETYPE));// @i_tipo_amortizacion

		if (paymentPlan.get(PaymentPlan.TABLETYPE).equals(Mnemonic.CAPITALFIXED)) { // @i_cuota
			loanRequestDTO.setQuotaOrCapital(paymentPlan.get(PaymentPlan.CAPITAL));
		} else if (paymentPlan.get(PaymentPlan.TABLETYPE).equals(Mnemonic.QUOTAFIXED)) {

			BigDecimal quota = BigDecimal.valueOf(0.0);
			if (paymentPlan.get(PaymentPlan.QUOTA) == null) {
				quota = BigDecimal.valueOf(0.0);
			} else {
				quota = paymentPlan.get(PaymentPlan.QUOTA);

			}
			loanRequestDTO.setQuotaOrCapital(quota);
		}
		loanRequestDTO.setDaysPerYear(paymentPlan.get(PaymentPlan.DAYSPERYEAR));// @i_dias_anio
		// loanRequestDTO.setCalculationBased(paymentPlan.get(PaymentPlan.CALCULATIONBASED));
		// // @i_base_calculo
		loanRequestDTO
				.setCalculationBased(paymentPlan.get(PaymentPlan.BASCALCULATIONINTEREST) == null || "".equals(paymentPlan.get(PaymentPlan.BASCALCULATIONINTEREST).trim()) ? '\0'
						: paymentPlan.get(PaymentPlan.BASCALCULATIONINTEREST).trim().charAt(0)); // @i_base_dias_int
		loanRequestDTO.setTermType(paymentPlan.get(PaymentPlan.TERMTYPE));// @i_tplazo
		loanRequestDTO.setTerm(paymentPlan.get(PaymentPlan.TERM));// @i_plazo
		loanRequestDTO.setQuotaType(paymentPlan.get(PaymentPlan.QUOTATYPE));// @i_tdividendo
		loanRequestDTO.setCapitalPeriod(paymentPlan.get(PaymentPlan.CAPITALPERIOD)); // @i_periodo_cap
		loanRequestDTO.setInterestPeriod(paymentPlan.get(PaymentPlan.INTERESTPERIOD)); // @i_periodo_int
		loanRequestDTO.setCapitalPeriodGrace(paymentPlan.get(PaymentPlan.CAPITALPERIODGRACE));// @i_gracia_cap
		loanRequestDTO.setInterestPeriodGrace(paymentPlan.get(PaymentPlan.INTERESTPERIODGRACE));// @i_gracia_int

		if (paymentPlan.get(PaymentPlan.QUOTAINTEREST) == null) {
			loanRequestDTO.setQuotaInterest(null);
		} else {
			loanRequestDTO.setQuotaInterest("".equals(paymentPlan.get(PaymentPlan.QUOTAINTEREST).trim()) ? '\0' : paymentPlan.get(PaymentPlan.QUOTAINTEREST).trim().charAt(0));// @i_dist_gracia
		}

		// PaymentPlan.FIXEDPPAYMENTDATE = CALCULADA EN EL SP
		loanRequestDTO.setPaymentDay(paymentPlan.get(PaymentPlan.PAYMENTDAY));// @i_dia_fijo
		loanRequestDTO.setMonthNoPayment(paymentPlan.get(PaymentPlan.MONTHNOPAYMENT));// @i_mes_gracia
		loanRequestDTO.setGraceArrearsDays(paymentPlan.get(PaymentPlan.GRACEARREARSDAYS));// @i_dias_gracia
		loanRequestDTO.setAvoidHolidays(paymentPlan.get(PaymentPlan.AVOIDHOLIDAYS));// @i_evitar_feriados
		loanRequestDTO.setDisplacement(originalHeader.get(OriginalHeader.DISPLACEMENT) == null ? 0 : Integer.valueOf(originalHeader.get(OriginalHeader.DISPLACEMENT)));
		// SOLO PARA LINEA CREDITO
		boolean isCreditLine = (originalHeader.get(OriginalHeader.NUMBERLINE) != null && !originalHeader.get(OriginalHeader.NUMBERLINE).isEmpty());
		if (isCreditLine) {
			loanRequestDTO.setCreditLine(originalHeader.get(OriginalHeader.NUMBERLINE));// @i_linea_credito
		}

		Boolean successService = false;
		// CONSUMO EL SERVICIO
		TransactionManagement transactionManagement = new TransactionManagement(iServiceIntegration);
		// successService = transactionManagement.UpdateLoanTmp(loanRequestDTO,
		// args);
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Tipo tabla amortización-->" + paymentPlan.get(PaymentPlan.TABLETYPE));
		if (!paymentPlan.get(PaymentPlan.TABLETYPE).equals(Mnemonic.MANUAL)) {
			@SuppressWarnings("unchecked")
			// llama a actualizar la operacion JCA
			// **************************************************************
			// **************************************************************
			Map responseMap = transactionManagement.UpdateLoanTmpAndGetRates(loanRequestDTO, args);

			if (responseMap != null) {
				if (responseMap.containsKey("@o_tir")) {
					BigDecimal tir = new BigDecimal(String.valueOf(responseMap.get("@o_tir")));
					paymentPlanHeader.set(PaymentPlanHeader.TIR, tir);
				}
				if (responseMap.containsKey("@o_tea")) {
					BigDecimal tea = new BigDecimal(String.valueOf(responseMap.get("@o_tea")));
					paymentPlanHeader.set(PaymentPlanHeader.TEA, tea);
				}
				if (responseMap.containsKey("@o_plazo")) {
					String term = String.valueOf(responseMap.get("@o_plazo"));
					paymentPlan.set(PaymentPlan.TERM, Integer.valueOf(term));
					originalHeader.set(OriginalHeader.TERM, term);
				}
				if (responseMap.containsKey("@o_tplazo")) {
					paymentPlan.set(PaymentPlan.TERMTYPE, String.valueOf(responseMap.get("@o_tplazo")));
					originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, String.valueOf(responseMap.get("@o_tplazo")));
				}
				if (responseMap.containsKey("@o_cuota")) {
					BigDecimal quota = new BigDecimal(String.valueOf(responseMap.get("@o_cuota")));
					paymentPlan.set(PaymentPlan.QUOTA, quota);
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Response TIR -->" + paymentPlanHeader.get(PaymentPlanHeader.TIR));
					LOGGER.logDebug("Response TEA -->" + paymentPlanHeader.get(PaymentPlanHeader.TEA));
					LOGGER.logDebug("Response TERM -->" + paymentPlan.get(PaymentPlan.TERM));
					LOGGER.logDebug("Response TERMTYPE -->" + paymentPlan.get(PaymentPlan.TERMTYPE));
					LOGGER.logDebug("Response QUOTA -->" + paymentPlan.get(PaymentPlan.QUOTA));
				}
				successService = true;
			}
		}

		paymentPlan.set(PaymentPlan.CALCULATIONSTATUS, successService);
		if (!paymentPlan.get(PaymentPlan.TABLETYPE).equals(Mnemonic.MANUAL)) {
			return successService;
		} // INGRESA SOLO CUANDO ES TABLA MANUAL
		else {
			generateManualAmortizationTable(entities, args, paymentPlanHeader, paymentPlan, amortizationTableHeader, transactionManagement, operationCode);
			return true;
		}

	}

	private static void generateManualAmortizationTable(DynamicRequest entities, IExecuteCommandEventArgs args, DataEntity paymentPlanHeader, DataEntity paymentPlan,
			DataEntityList amortizationTableHeader, TransactionManagement transactionManagement, Integer operationCode) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingresa por ser tabla de amortización Manual");
		DataEntityList manualAmoritizacionList = entities.getEntityList(AmortizationTableItem.ENTITY_NAME);
		int maxRows = 10;
		String separador = ";";
		String strTrama = "";
		int rows = 1;
		int rowsAsig = 1;

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("manualAmoritizacionList-->" + manualAmoritizacionList.size());
		int interators = (int) (manualAmoritizacionList.size() / maxRows);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("maxRows-->" + maxRows);
			LOGGER.logDebug("interators-->" + interators);
		}
		cobiscorp.ecobis.loan.dto.LoanRequest loanRequestManual = new cobiscorp.ecobis.loan.dto.LoanRequest();
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)" + paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));
		if (operationCode != null) {
			loanRequestManual.setCode(String.valueOf(operationCode)); // Código
																		// de
																		// operaci�n
																		// de
																		// cartera
		}

		for (int i = 1; i <= interators; i++) {
			rowsAsig = rows;
			for (int j = 1; j <= maxRows; j++) {
				strTrama = getArguments(manualAmoritizacionList, separador, rows, amortizationTableHeader);
				asingParameters(strTrama, loanRequestManual, j);
				rows++;
			}
			if (operationCode != null) {
				// Codigo de operación
				loanRequestManual.setCode(String.valueOf(operationCode));
				// loanRequestManual.setCode(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED).toString());
				// // @i_tramite
			}
			if (rows - 1 == manualAmoritizacionList.size()) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Ingresa a colocar parámetros finales en interación " + i);
				loanRequestManual.setAction("A");
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)" + Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
				loanRequestManual.setInitDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("paymentPlan.get(PaymentPlan.DAYSPERYEAR)-->" + paymentPlan.get(PaymentPlan.DAYSPERYEAR));
				loanRequestManual.setDaysPerYear(paymentPlan.get(PaymentPlan.DAYSPERYEAR));

			}
			loanRequestManual.setRow(rowsAsig);
			transactionManagement.ManualLoanSave(loanRequestManual, args);
			loanRequestManual = new cobiscorp.ecobis.loan.dto.LoanRequest();

		}
		// int modSise = manualAmoritizacionList.size() % maxRows;
		if (manualAmoritizacionList.size() % maxRows != 0) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Modulos " + manualAmoritizacionList.size() % maxRows);
			int finalInterator = interators * maxRows;
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("finalInterator-->" + finalInterator);
			loanRequestManual = new cobiscorp.ecobis.loan.dto.LoanRequest();
			int j = 1;
			for (int i = finalInterator + 1; i <= manualAmoritizacionList.size(); i++) {
				strTrama = getArguments(manualAmoritizacionList, separador, i, amortizationTableHeader);
				asingParameters(strTrama, loanRequestManual, j);
				j++;
			}
			// loanRequestManual.setRow(i);
			if (operationCode != null) {
				loanRequestManual.setCode(String.valueOf(operationCode)); // @i_tramite
			}
			loanRequestManual.setRow(finalInterator + 1);
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingresa a colocar parámetros finales");
			loanRequestManual.setAction("A");
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)" + Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
			loanRequestManual.setInitDate(Convert.CDate.toCalendar(paymentPlanHeader.get(PaymentPlanHeader.INITIALDATE)));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlan.get(PaymentPlan.DAYSPERYEAR)-->" + paymentPlan.get(PaymentPlan.DAYSPERYEAR));
			loanRequestManual.setDaysPerYear(paymentPlan.get(PaymentPlan.DAYSPERYEAR));
			transactionManagement.ManualLoanSave(loanRequestManual, args);
		}
	}

	private static void asingParameters(String strTrama, cobiscorp.ecobis.loan.dto.LoanRequest loanRequestManual, int i) {
		if (!"".equals(strTrama) && strTrama != null) {
			strTrama = strTrama + "&";
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("strTrama-->" + strTrama);
			switch (i) {
			case 1:
				loanRequestManual.setStr1(strTrama);
				break;
			case 2:
				loanRequestManual.setStr2(strTrama);
				break;
			case 3:
				loanRequestManual.setStr3(strTrama);
				break;
			case 4:
				loanRequestManual.setStr4(strTrama);
				break;
			case 5:
				loanRequestManual.setStr5(strTrama);
				break;
			case 6:
				loanRequestManual.setStr6(strTrama);
				break;
			case 7:
				loanRequestManual.setStr7(strTrama);
				break;
			case 8:
				loanRequestManual.setStr8(strTrama);
				break;
			case 9:
				loanRequestManual.setStr9(strTrama);
				break;
			case 10:
				loanRequestManual.setStr10(strTrama);
				break;
			default:
				break;
			}
		}
	}

	private static String getArguments(DataEntityList manualAmoritizacionList, String separador, int i, DataEntityList amortizationTableHeader) {
		String strTrama = "";
		if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.EXPIRATIONDATE) != null) {
			String date = CDate.toString(SessionContext.DATE101, manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.EXPIRATIONDATE));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("FECHA--->" + date);
			// strTrama = manualAmoritizacionList.get(i -
			// 1).get(AmortizationTableItem.EXPIRATIONDATE).toString();
			strTrama = date;
		}
		if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.BALANCE) != null) {
			strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.BALANCE).toString();
		}
		// número máximo de rubros
		int maxItems = 13;
		if (amortizationTableHeader.size() <= maxItems) {
			maxItems = amortizationTableHeader.size();
		}
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("maxItems-->" + maxItems);
		for (int a = 0; a < maxItems; a++) {

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("amortizationTableHeader-->" + amortizationTableHeader.get(a).get(AmortizationTableHeader.DESCRIPTION));
			switch (a) {
			case 1:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 1:" + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM1));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM1) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM1).toString();
				}
				break;
			case 2:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 2:" + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM2));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM2) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM2).toString();
				}
				break;
			case 3:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 3:" + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM3));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM3) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM3).toString();
				}
				break;
			case 4:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 4:" + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM4));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM4) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM4).toString();
				}
				break;
			case 5:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 5:" + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM5));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM5) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM5).toString();
				}
				break;
			case 6:
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("case 6:" + manualAmoritizacionList.get(i - 1));
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM6) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM6).toString();
				}
				break;
			case 7:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM7) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM7).toString();
				}
				break;
			case 8:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM8) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM8).toString();
				}
				break;
			case 9:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM9) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM9).toString();
				}
				break;
			case 10:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM10) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM10).toString();
				}
				break;
			case 11:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM11) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM11).toString();
				}
				break;
			case 12:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM12) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM12).toString();
				}
				break;
			case 13:
				if (manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM13) != null) {
					strTrama = strTrama + separador + manualAmoritizacionList.get(i - 1).get(AmortizationTableItem.ITEM13).toString();
				}
				break;
			default:
				break;
			}

		}

		return strTrama;
	}

	public static boolean computeQuoteVsBalance(DynamicRequest entities, ICommonEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start computeQuoteVsBalance");
		DataEntityList amortizationTableItemsList = entities.getEntityList(AmortizationTableItem.ENTITY_NAME);
		DataEntity paymentCapacityHeaderENT = entities.getEntity(PaymentCapacityHeader.ENTITY_NAME);
		DataEntityList paymentCapacityList = entities.getEntityList(PaymentCapacity.ENTITY_NAME);
		DataEntity saldoDisponibleMensualENT = paymentCapacityList.get(paymentCapacityList.size() - 1);
		paymentCapacityHeaderENT.set(PaymentCapacityHeader.COUNTTERM, 0);
		entities.setEntityList(AmortizationTableItem.ENTITY_NAME, amortizationTableItemsList);
		boolean validationOk = true;
		Property<BigDecimal> BALANCE;
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("---->PaymentCapacityHeader Status" + paymentCapacityHeaderENT.get(PaymentCapacityHeader.STATUS));
		if (paymentCapacityHeaderENT.get(PaymentCapacityHeader.STATUS).equals("OK")) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("---->OK");
			int maxRows = 12;
			if (amortizationTableItemsList.size() < maxRows) {
				maxRows = amortizationTableItemsList.size();
			}
			paymentCapacityHeaderENT.set(PaymentCapacityHeader.COUNTTERM, maxRows);
			DataEntity flujoCajaAcumuladoENT = new DataEntity();
			DataEntity cuotaPropuestaENT = new DataEntity();
			DataEntity margenDeAhorroENT = new DataEntity();
			flujoCajaAcumuladoENT.set(PaymentCapacity.CUSTOMERID, -2);
			flujoCajaAcumuladoENT.set(PaymentCapacity.CUSTOMERNAME, "");
			cuotaPropuestaENT.set(PaymentCapacity.CUSTOMERID, -3);
			cuotaPropuestaENT.set(PaymentCapacity.CUSTOMERNAME, "");
			margenDeAhorroENT.set(PaymentCapacity.CUSTOMERID, -4);
			margenDeAhorroENT.set(PaymentCapacity.CUSTOMERNAME, "");

			BigDecimal margenDeAhorro = new BigDecimal(0);
			BigDecimal totalCuotaPropuesta = new BigDecimal(0);
			BigDecimal totalMargenDeAhorro = new BigDecimal(0);
			BigDecimal totalFlujoCajaAcumulado = new BigDecimal(0);
			BigDecimal zero = new BigDecimal(0);
			for (int i = 1; i <= maxRows; i++) {
				BALANCE = new Property<BigDecimal>("Balance" + i, BigDecimal.class, false);

				BigDecimal flujoCajaAcumulado = saldoDisponibleMensualENT.get(BALANCE).add(margenDeAhorro);
				BigDecimal cuotaPropuesta = amortizationTableItemsList.get(i - 1).get(AmortizationTableItem.FEE);
				margenDeAhorro = flujoCajaAcumulado.subtract(cuotaPropuesta);

				totalFlujoCajaAcumulado = totalFlujoCajaAcumulado.add(flujoCajaAcumulado);
				totalCuotaPropuesta = totalCuotaPropuesta.add(cuotaPropuesta);
				totalMargenDeAhorro = totalMargenDeAhorro.add(margenDeAhorro);

				flujoCajaAcumuladoENT.set(BALANCE, flujoCajaAcumulado);
				cuotaPropuestaENT.set(BALANCE, cuotaPropuesta);
				margenDeAhorroENT.set(BALANCE, margenDeAhorro);
				// VALIDACION DEL MONTO
				if (margenDeAhorro.compareTo(new BigDecimal(0)) < 0) {
					validationOk = false;
				}
			}
			// LLENAR CON null LOS QUE FALTAN
			for (int i = maxRows + 1; i <= 12; i++) {
				BALANCE = new Property<BigDecimal>("Balance" + i, BigDecimal.class, false);
				flujoCajaAcumuladoENT.set(BALANCE, zero);
				cuotaPropuestaENT.set(BALANCE, zero);
				margenDeAhorroENT.set(BALANCE, zero);

			}
			// LLENAR PROMEDIOS Y TOTALES
			if (maxRows > 0) {
				flujoCajaAcumuladoENT.set(PaymentCapacity.MONTHAVERAGE, totalFlujoCajaAcumulado.divide(new BigDecimal(maxRows), 2, RoundingMode.HALF_UP));
				flujoCajaAcumuladoENT.set(PaymentCapacity.TOTALANNUAL, null);

				cuotaPropuestaENT.set(PaymentCapacity.MONTHAVERAGE, totalCuotaPropuesta.divide(new BigDecimal(maxRows), 2, RoundingMode.HALF_UP));
				cuotaPropuestaENT.set(PaymentCapacity.TOTALANNUAL, totalCuotaPropuesta);

				margenDeAhorroENT.set(PaymentCapacity.MONTHAVERAGE, totalMargenDeAhorro.divide(new BigDecimal(maxRows), 2, RoundingMode.HALF_UP));
				margenDeAhorroENT.set(PaymentCapacity.TOTALANNUAL, saldoDisponibleMensualENT.get(PaymentCapacity.TOTALANNUAL).subtract(totalCuotaPropuesta));
			} else {
				validationOk = false;
				args.setSuccess(false);
			}

			paymentCapacityList.add(flujoCajaAcumuladoENT);
			paymentCapacityList.add(cuotaPropuestaENT);
			paymentCapacityList.add(margenDeAhorroENT);

			// CARGA LAS ENTIDADES
			entities.setEntityList(PaymentCapacity.ENTITY_NAME, paymentCapacityList);

			// INDICA QUE LA VALIDACION FUE CORRECTA
			paymentCapacityHeaderENT.set(PaymentCapacityHeader.VALIDATIONSUCCESS, validationOk);
			return validationOk;
		} else {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("----!OK");
			validationOk = false;
			paymentCapacityHeaderENT.set(PaymentCapacityHeader.VALIDATIONSUCCESS, validationOk);
			args.setSuccess(false);
			return validationOk;
		}
	}

	public static boolean validateRequestWithAgreement(DynamicRequest entities) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity generalParameterLoan = entities.getEntity(GeneralParameterLoan.ENTITY_NAME);
		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Validacion Credito-Convenio" + originalHeader.get(OriginalHeader.AGREEMENT) + " " + generalParameterLoan.get(GeneralParameterLoan.EXCHANGERATE));
		if (originalHeader.get(OriginalHeader.AGREEMENT).equals(Mnemonic.CHAR_S)) {
			generalParameterLoan.set(GeneralParameterLoan.EXCHANGERATE, Mnemonic.CHAR_N);
			return true;
		} else {
			return false;
		}

	}

	public static CatalogDto getFrecuencyCatalog(String frecuencyCode, ICommonEventArgs args, ICTSServiceIntegration serviceIntegration) {
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(serviceIntegration);
		try {
			for (CatalogDto catalogDto : queryStoredProcedureManagement.getPaymentFrequency(args, new BehaviorOption(true))) {
				if (catalogDto.getCode().trim().equalsIgnoreCase(frecuencyCode)) {
					return catalogDto;
				}
			}
			return null;

		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Error al cargar getFrecuencyCatalog", e);
		}
		return null;
	}
}
