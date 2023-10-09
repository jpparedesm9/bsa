package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.customevents.bli.ItemsBLI;
import com.cobiscorp.cobis.busin.customevents.bli.OperationBLI;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ApplicationType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.AmortizationTableManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.LocationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.ApprovalCriteriaQuestion;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.CreditOtherData;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class InitDataPaymentPlan extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(InitDataPaymentPlan.class);

	public InitDataPaymentPlan(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso -> IInitDataEvent -> InitDataPaymentPlan");
		int numeroSolicitud, numeroTramite;
		String numeroOperacion;
		String etapaTramite = "";
		try {
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
			DataEntity creditOtherData = entities.getEntity(CreditOtherData.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");

			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			numeroSolicitud = paymentPlanHeader.get(PaymentPlanHeader.APPLICATIONNUMBER);
			if (logger.isDebugEnabled())
				logger.logDebug("numeroSolicitud ----->" + numeroSolicitud);
			etapaTramite = context.get(Context.REQUESTSTAGE);

			// Obtener feriados mayores a la fecha actual
			/*
			 * JCA HolidaysManagement holidayMngmt = new HolidaysManagement(
			 * super.getServiceIntegration()); holidayMngmt.getHolidays(entities, arg1);
			 */

			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());

			// RECUPERA NUMERO DE TRAMITE
			ProcessedNumber processedNumberDTO = tranManager.getProcessedNumber(numeroSolicitud, arg1, new BehaviorOption(true));
			if (processedNumberDTO == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}
			numeroTramite = processedNumberDTO.getTramite();
			if (logger.isDebugEnabled())
				logger.logDebug("numeroTramite---> " + numeroTramite);

			// Recupera el campo 7 del proceso
			String fieldSeven = "";
			if (processedNumberDTO.getFieldSeven() != null) {
				fieldSeven = processedNumberDTO.getFieldSeven().trim();
			}

			// RECUPERA DATOS DEL TRAMITE
			ApplicationResponse applicationResponseDTO = tranManager.getApplication(numeroTramite, arg1, new BehaviorOption(true));
			if (applicationResponseDTO == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
				return;
			}
			if (logger.isDebugEnabled())
				logger.logDebug("RECUPERA DATOS DEL TRAMITE ---> " + applicationResponseDTO.getOperationNumberBank());
			logger.logDebug(" TplaymentPlan - fieldSeven:" + fieldSeven);
			originalHeader.set(OriginalHeader.AMOUNTAPROBED, applicationResponseDTO.getApprovedAmount());
			context.set(Context.OFFICENAME, applicationResponseDTO.getOfficeDescriptionTr());
			context.set(Context.CYCLENUMBER, applicationResponseDTO.getCycleNumber());
			if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				if (logger.isDebugEnabled())
					logger.logDebug("applicationResponseDTO.getSumRequestedAmountGroup()" + applicationResponseDTO.getSumRequestedAmountGroup());
				if (applicationResponseDTO.getSumRequestedAmountGroup() != null) {
					context.set(Context.AMOUNTREQUESTED, applicationResponseDTO.getSumRequestedAmountGroup().doubleValue());
				}
				context.set(Context.CUSTOMERID, applicationResponseDTO.getGroup());
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug("applicationResponseDTO.getAmountRequested()" + applicationResponseDTO.getAmount());
				if (applicationResponseDTO.getAmountRequested() != null) {
					originalHeader.set(OriginalHeader.AMOUNTREQUESTED, applicationResponseDTO.getAmount());
				}
			}

			if (logger.isDebugEnabled())
				logger.logDebug("applicationResponseDTO.getExpirationDate()-->" + applicationResponseDTO.getExpirationDate());
			if (applicationResponseDTO.getExpirationDate() != null) {
				if (logger.isDebugEnabled())
					logger.logDebug("applicationResponseDTO.getExpirationDate().getTime()-->" + applicationResponseDTO.getExpirationDate().getTime());
				paymentPlanHeader.set(PaymentPlanHeader.FIRSTEXPIRATIONFEEDATE, applicationResponseDTO.getExpirationDate().getTime());

			}

			// -------------------------------------------------------------------------------------------------------------------------------
			// RECUPERACION DE FECHA DE DISPERSION Y LA FECHA DE VALIDACION CON EL PARAMETRO
			// DE DIAS HABILES
			if (applicationResponseDTO.getFechaValidacion() != null) {

				logger.logDebug("applicationResponseDTO.getFechaValidacion()-->" + applicationResponseDTO.getFechaValidacion().getTime());
				paymentPlanHeader.set(PaymentPlanHeader.DISPERSIONDATEVALIDATE, applicationResponseDTO.getFechaValidacion().getTime());
			}

			if (applicationResponseDTO.getFechaDispersion() != null) {

				logger.logDebug("applicationResponseDTO.getFechaDispersion()-->" + applicationResponseDTO.getFechaDispersion().getTime());
				paymentPlanHeader.set(PaymentPlanHeader.DISPERSIONDATE, applicationResponseDTO.getFechaDispersion().getTime());
			}
			// -------------------------------------------------------------------------------------------------------------------------------

			if (applicationResponseDTO.getCreditLineNumBank() != null) {
				originalHeader.set(OriginalHeader.CREDITLINEVALID, applicationResponseDTO.getCreditLineNumBank());
			}

			if (applicationResponseDTO.getOperationNumberBank() != null)
				numeroOperacion = applicationResponseDTO.getOperationNumberBank().trim();
			else
				numeroOperacion = String.valueOf(numeroTramite).trim();

			logger.logDebug("numeroOperacion JCA---> " + numeroOperacion);

			// COPIA DE DEFINITIVAS A TEMPORALES
			if (logger.isDebugEnabled())
				logger.logDebug("Copia de definivas a temporales, numeroOperacion --->" + numeroOperacion);
			tranManager.deleteTmpTables(numeroOperacion, arg1, new BehaviorOption(true));
			tranManager.copyFinalTablesToTmpTables(numeroOperacion, arg1, new BehaviorOption(true));

			// RECUPERAR LA OPERACION EN CASO DE QUE YA EXISTA
			if (OperationBLI.getAndMapping(numeroOperacion, entities, arg1, super.getServiceIntegration())) {
				// YA EXISTE LA OPERACION EN TABLAS TEMPORALES
				if (logger.isDebugEnabled())
					logger.logDebug("Busca Tabla de Amortización, numeroOperacion --->" + numeroOperacion);
				// 1.- BUSCA TABLA DE AMORTIZACION
				AmortizationTableManagement amortizationTableManagement = new AmortizationTableManagement(super.getServiceIntegration());
				amortizationTableManagement.getAndMapAmortizationTableTmp(numeroOperacion, entities, arg1, new BehaviorOption(true));

				// 5.- RECUPERA RUBROS
				if (logger.isDebugEnabled())
					logger.logDebug("Recupera Rubros, numeroOperacion --->" + numeroOperacion);
				ItemsBLI.read(entities, arg1, numeroOperacion, super.getServiceIntegration());

			} else { // ES PRIMERA VEZ QUE SE VA A CREAR LA OPERACION
				if (applicationResponseDTO.getStartDate() != null)
					paymentPlanHeader.set(PaymentPlanHeader.INITIALDATE, applicationResponseDTO.getStartDate().getTime());
			}
			if (applicationResponseDTO.getStartDate() != null)
				paymentPlanHeader.set(PaymentPlanHeader.INITIALDATE, applicationResponseDTO.getStartDate().getTime());

			// RECUPERA LA FORMA DE PAGO PARA CONDICIONES DE PAGO FLUJO INDIVIDUALES
			CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
			ParameterResponse parameterResponseDTO = catalogMngmnt.getParameter("NCDAHO", Mnemonic.MODULECCA, arg1, new BehaviorOption(true));
			logger.logDebug("cuenta individual >>>>" + parameterResponseDTO.getParameterValue());
			paymentPlanHeader.set(PaymentPlanHeader.WAYTOPAY, parameterResponseDTO.getParameterValue());

			// MAPEA DTOs A ENTIDADES
			paymentPlanHeader.set(PaymentPlanHeader.IDREQUESTED, numeroTramite);

			originalHeader.set(OriginalHeader.IDREQUESTED, numeroTramite + "");

			if (logger.isDebugEnabled())
				logger.logDebug("applicationResponseDTO.getStartDate()-->" + applicationResponseDTO.getStartDate());
			if (applicationResponseDTO.getStartDate() != null)
				originalHeader.set(OriginalHeader.INITIALDATE, applicationResponseDTO.getStartDate().getTime());
			if (applicationResponseDTO.getDestinationDescription() != null) {
				originalHeader.set(OriginalHeader.CREDITTARGET, applicationResponseDTO.getDestinationDescription());
			}
			paymentPlanHeader.set(PaymentPlanHeader.CLASSOPERATION, applicationResponseDTO.getClassOperation() == null ? "" : applicationResponseDTO.getClassOperation());
			logger.logDebug("applicationResponseDTO.getDaysPerYear()-->" + applicationResponseDTO.getDaysPerYear());
			paymentPlanHeader.set(PaymentPlanHeader.DAYSPERYEAR, applicationResponseDTO.getDaysPerYear() == null ? 1 : applicationResponseDTO.getDaysPerYear());
			// if(applicationResponseDTO.geta)
			// originalHeader.set(OriginalHeader.CITYCODE,
			// officeResponse.getCityId());
			originalHeader.set(OriginalHeader.STATUSREQUESTED, applicationResponseDTO.getState());
			if (applicationResponseDTO.getCurrencyRequested() != null) {
				originalHeader.set(OriginalHeader.CURRENCYREQUESTED, String.valueOf(applicationResponseDTO.getCurrencyRequested()));
			}
			if (applicationResponseDTO.getQuota() != null) {
				originalHeader.set(OriginalHeader.QUOTA, applicationResponseDTO.getQuota());
			}
			logger.logDebug("applicationResponseDTO.getOffice()" + applicationResponseDTO.getOffice().toString());
			if (applicationResponseDTO.getOffice() != null) {
				originalHeader.set(OriginalHeader.OFFICE, applicationResponseDTO.getOffice());
			}
			if (String.valueOf(applicationResponseDTO.getAgreement()) != null) {
				originalHeader.set(OriginalHeader.AGREEMENT, applicationResponseDTO.getAgreement());
			}
			originalHeader.set(OriginalHeader.OPNUMBERBANK, numeroOperacion);
			originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, applicationResponseDTO.getPaymentFrequency());
			originalHeader.set(OriginalHeader.TERM, String.valueOf(applicationResponseDTO.getTerm()));
			originalHeader.set(OriginalHeader.DISPLACEMENT, applicationResponseDTO.getDisplacement() == null ? "0" : String.valueOf(applicationResponseDTO.getDisplacement()));
			generalData.set(new Property<Integer>("plazo", Integer.class, false), applicationResponseDTO.getTerm());
			if (logger.isDebugEnabled())
				logger.logDebug("Header - Carga del plazo: " + applicationResponseDTO.getTerm());

			if (logger.isDebugEnabled())
				logger.logDebug("Carga del campo de vinculado");
			String clienteVinculado = applicationResponseDTO.getLinkedClient() + "";
			if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
				generalData.set(new Property<String>("vinculado", String.class, false), "Si");
			else
				generalData.set(new Property<String>("vinculado", String.class, false), "No");

			if (logger.isDebugEnabled())
				logger.logDebug("toma del campo simbolo de moneda");

			// Decimales moneda
			if (logger.isDebugEnabled())
				logger.logDebug("applicationResponseDTO.getCurrencyRequested()" + applicationResponseDTO.getCurrencyRequested());
			CatalogManagement catalogManagement = new CatalogManagement(super.getServiceIntegration());
			CatalogResponse[] allItemsByTable = catalogManagement.getAllItemsByTable("cl_moneda", arg1, new BehaviorOption());

			for (CatalogResponse catalogResponse : allItemsByTable) {
				if (logger.isDebugEnabled())
					logger.logDebug("currency:" + catalogResponse.getCode().trim() + ", " + catalogResponse.getValue());
				if (catalogResponse.getCode().trim().equals(String.valueOf(applicationResponseDTO.getCurrencyRequested()))) {
					generalData.set(new Property<String>("currencyDecimals", String.class, false), catalogResponse.getDecimals());
					break;
				}
			}

			String simboloMoneda = applicationResponseDTO.getSymbolCurrency().trim();
			generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);

			if (applicationResponseDTO.getCityDestination() != null) {
				officerAnalysis.set(OfficerAnalysis.CITY, applicationResponseDTO.getCityDestination());
			}

			if (logger.isDebugEnabled())
				logger.logDebug("applicationResponseDTO.getOfficer()" + applicationResponseDTO.getOfficer());
			if (applicationResponseDTO.getOfficer() != null) {
				officerAnalysis.set(OfficerAnalysis.OFFICER, String.valueOf(applicationResponseDTO.getOfficer() == null ? "" : applicationResponseDTO.getOfficer()));
			}
			officerAnalysis.set(OfficerAnalysis.SECTOR, applicationResponseDTO.getSector());
			officerAnalysis.set(OfficerAnalysis.CREDITLINE, applicationResponseDTO.getPortfolioType());
			// Pestaña Otros Datos del Credito
			if (logger.isDebugEnabled()) {
				logger.logDebug("CreditOtherData.CREDITPORPUSE" + applicationResponseDTO.getObjectCredit());
				logger.logDebug("CreditOtherData.ACTIVITYDESTINATIONCREDIT" + applicationResponseDTO.getActivity());
				logger.logDebug("CreditOtherData.CREDITDESTINATION" + applicationResponseDTO.getDestination());
				logger.logDebug("CreditOtherData.SOURCEOFFUNDING" + applicationResponseDTO.getFoundsSource());
				logger.logDebug("CreditOtherData.DESCRIPTIONDESTINATIONREQUESTED" + applicationResponseDTO.getOfficerDescription());
			}
			if (applicationResponseDTO.getObjectCredit() != null) {
				creditOtherData.set(CreditOtherData.CREDITPORPUSE, applicationResponseDTO.getObjectCredit());
			}
			if (applicationResponseDTO.getActivity() != null) {
				creditOtherData.set(CreditOtherData.ACTIVITYDESTINATIONCREDIT, applicationResponseDTO.getActivity());
			}
			if (applicationResponseDTO.getDestination() != null) {
				creditOtherData.set(CreditOtherData.CREDITDESTINATION, applicationResponseDTO.getDestination());
			}
			if (applicationResponseDTO.getFoundsSource() != null) {
				creditOtherData.set(CreditOtherData.SOURCEOFFUNDING, applicationResponseDTO.getFoundsSource());
			}
			if (applicationResponseDTO.getOfficerDescription() != null) {
				creditOtherData.set(CreditOtherData.DESCRIPTIONDESTINATIONREQUESTED, applicationResponseDTO.getOfficerDescription());
			}

			// 3.- RECUPERA DATOS DE OFICINA
			LocationManagement locManagement = new LocationManagement(super.getServiceIntegration());
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(false));
			if (officeResponse != null) {
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
			} else {
				originalHeader.set(OriginalHeader.CITYCODE, -1);
			}

			// Fin Pestaña Otros Datos del Credito

			if (applicationResponseDTO.getEffect() != null) {
				if (applicationResponseDTO.getEffect().equals(Mnemonic.STRING_N)) {
					paymentPlanHeader.set(PaymentPlanHeader.DEBIT, Mnemonic.CHAR_N);
				} else {
					paymentPlanHeader.set(PaymentPlanHeader.DEBIT, Mnemonic.CHAR_S);
				}
			}
			originalHeader.set(OriginalHeader.TYPEREQUEST, applicationResponseDTO.getType());
			originalHeader.set(OriginalHeader.SCORETYPE, applicationResponseDTO.getScoreType());
			if ((applicationResponseDTO.getScoreType() != null) && applicationResponseDTO.getScoreType().equals(Mnemonic.SCORETYPE_BUSINESSMANUAL)) {
				originalHeader.set(OriginalHeader.SCORE, applicationResponseDTO.getScore());
			}

			originalHeader.set(OriginalHeader.ISWARRANTYDESTINATION, Convert.CString.toCharacter(applicationResponseDTO.getIsWarrantyDestination()));
			originalHeader.set(OriginalHeader.ISDEBTOROWNER, Convert.CString.toCharacter(applicationResponseDTO.getIsDebtorOwner()));
			originalHeader.set(OriginalHeader.OFFICERID, applicationResponseDTO.getOfficer().toString());
			originalHeader.set(OriginalHeader.OFFICERNAME, applicationResponseDTO.getOfficialDescription());

			// CPN por validar ( Solución temporal)
			// Se valida el recalculo del monto desembolso y monto propuesto
			// cuando es Expromision, Refinanciamiento y Reprogramacion
			/*
			 * if (this.IsExpromission(applicationResponseDTO) ||
			 * this.IsRefinancing(applicationResponseDTO) ||
			 * this.IsReschedule(applicationResponseDTO)) { logger.logInfo(
			 * "1.......................................ENTRO A REFINANCIAMIENTO" );
			 * BigDecimal sum = new BigDecimal(0); Double amountInCurrencyDestination = 0.0;
			 * RenewLoanRequest dtoBalanceRequest = new RenewLoanRequest(); //
			 * dtoBalanceRequest.setRequestId(numeroOperacion);
			 * dtoBalanceRequest.setRequestId(Integer.toString(numeroTramite));
			 * dtoBalanceRequest.setCustomerId(-1); // Se obtiene el valor de cada una de
			 * las operaciones
			 * 
			 * RenewLoanResponse[] balanceResponse =
			 * tranManager.getBalancebyOperation(dtoBalanceRequest, arg1, new
			 * BehaviorOption(true)); logger.logInfo(
			 * "22...............................balanceResponse.........................................."
			 * + balanceResponse); if (balanceResponse != null) { if
			 * (logger.isDebugEnabled()) logger.logDebug(
			 * "<< INGRESA A OBTENER LOS VALORES DE LAS OPERACIONES >>"); if
			 * (applicationResponseDTO.getType() != null) { // Se valida // que tenga //
			 * tipo de // credito originalHeader.set(OriginalHeader.TYPEREQUEST,
			 * applicationResponseDTO.getType()); // SOLO CUANDO ES UNA EXPROMISION if
			 * (this.IsExpromission(applicationResponseDTO)) {
			 * originalHeader.set(OriginalHeader.EXPROMISSION,
			 * applicationResponseDTO.getExpromission());
			 * paymentPlanHeader.set(PaymentPlanHeader.PRODUCTTYPE,
			 * applicationResponseDTO.getOpertationType());
			 * 
			 * if (applicationResponseDTO.getCurrencyRequested() != null) {
			 * paymentPlanHeader.set(PaymentPlanHeader.CURRENCY,
			 * applicationResponseDTO.getCurrencyRequested()); }
			 * 
			 * if (logger.isDebugEnabled())
			 * logger.logDebug("<<< 1. TIPO -> EXPROMISION >>>");
			 * 
			 * for (RenewLoanResponse response : balanceResponse) {// Recorre // la // lista
			 * // de // resultados // de // la // ejecucion // del // servicio
			 * logger.logDebug("<<< 2. TIPO -> EXPROMISION >>> VALORES FOR: " +
			 * response.getBalance()); if (Integer.parseInt(response.getOperationMoney()) ==
			 * applicationResponseDTO.getCurrencyRequested()) { logger.logDebug(
			 * "<<< 3. TIPO -> EXPROMISION >>> MONEDAS IGUALES >>> VALOR: " +
			 * response.getBalance()); sum = sum.add(new BigDecimal(response.getBalance()));
			 * logger.logDebug(
			 * "<<< 4. TIPO -> EXPROMISION >>> SUMA MONEDAS IGUALES >>> VALOR: " + sum); }
			 * else { logger.logDebug(
			 * "<<< 5. TIPO -> EXPROMISION >>> MONEDAS DIFERENTES >>> VALOR: " +
			 * response.getBalance()); amountInCurrencyDestination = tranManager.
			 * getQuote(Integer.parseInt(response.getOperationMoney()),
			 * applicationResponseDTO.getCurrencyRequested(), response.getBalance(), arg1,
			 * new BehaviorOption(true)); logger.logDebug
			 * ("<<< 6. TIPO -> EXPROMISION >>> CONVERSION >>> VALOR: " +
			 * amountInCurrencyDestination); sum = sum.add(new
			 * BigDecimal(amountInCurrencyDestination)); logger.logDebug(
			 * "<<< 7. TIPO -> EXPROMISION >>> SUMA MONEDAS DISTINTAS >>> VALOR: " + sum); }
			 * }// FIN FOR
			 * 
			 * paymentPlanHeader.set(PaymentPlanHeader.AMOUNT, sum);
			 * paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT, sum);
			 * 
			 * // FIN EXPROMISION } else if (this.IsRefinancing(applicationResponseDTO)) {
			 * // SOLO // CUANDO // ES // UN // REFINANCIAMIENTO
			 * paymentPlanHeader.set(PaymentPlanHeader.PRODUCTTYPE,
			 * applicationResponseDTO.getOpertationType());
			 * 
			 * if (logger.isDebugEnabled())
			 * logger.logDebug("<<< 1. TIPO -> REFINANCIAMIENTO >>>");
			 * 
			 * // RECUPERA LOS DATOS VARIABLES PARA EL RECALCULO if
			 * (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(etapaTramite)) { if
			 * (etapaTramite.equals(Mnemonic.STAGE_PAYMENT_PLAN_RECALCULATION)) { if
			 * (logger.isDebugEnabled()) {
			 * logger.logDebug("<<< OOPCION DEL RECALCULO AMOUNT>>> " + etapaTramite +
			 * "VALOR >> " + paymentPlanHeader.get(PaymentPlanHeader.AMOUNT));
			 * logger.logDebug("<<< OPCION DEL RECALCULO APPROVEDAMOUNT>>> " + etapaTramite
			 * + "VALOR >> " + paymentPlanHeader.get(PaymentPlanHeader.APPROVEDAMOUNT)); }
			 * paymentPlanHeader.set(PaymentPlanHeader.AMOUNT,
			 * paymentPlanHeader.get(PaymentPlanHeader.AMOUNT));
			 * paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT,
			 * paymentPlanHeader.get(PaymentPlanHeader.APPROVEDAMOUNT)); } else { if
			 * (logger.isDebugEnabled())
			 * logger.logDebug("<<< OPCION DE TABLA DE AMORTIZACION >>>" + etapaTramite);
			 * for (RenewLoanResponse response : balanceResponse) {// Recorre // la // lista
			 * // de // resultados // de // la // ejecucion // del // servicio
			 * logger.logDebug("<<< 2. TIPO -> REFINANCIAMIENTO >>> VALORES FOR: " +
			 * response.getBalance()); if (Integer.parseInt(response.getOperationMoney()) ==
			 * applicationResponseDTO.getCurrencyRequested()) { logger.logDebug(
			 * "<<< 3. TIPO -> REFINANCIAMIENTO >>> MONEDAS IGUALES >>> VALOR: " +
			 * response.getBalance()); sum = sum.add(new BigDecimal(response.getBalance()));
			 * logger.logDebug(
			 * "<<< 4. TIPO -> REFINANCIAMIENTO >>> SUMA MONEDAS IGUALES >>> VALOR: " +
			 * sum); } else { logger.logDebug(
			 * "<<< 5. TIPO -> REFINANCIAMIENTO >>> MONEDAS DIFERENTES >>> VALOR: " +
			 * response.getBalance()); amountInCurrencyDestination = tranManager
			 * .getQuote(Integer.parseInt(response.getOperationMoney()),
			 * applicationResponseDTO.getCurrencyRequested(), response.getBalance(), arg1,
			 * new BehaviorOption(true)); logger.logDebug
			 * ("<<< 6. TIPO -> REFINANCIAMIENTO >>> CONVERSION >>> VALOR: " +
			 * amountInCurrencyDestination); sum = sum.add(new
			 * BigDecimal(amountInCurrencyDestination)); logger.logDebug(
			 * "<<< 7. TIPO -> REFINANCIAMIENTO >>> SUMA MONEDAS DISTINTAS >>> VALOR: " +
			 * sum); } }// FIN FOR
			 * 
			 * paymentPlanHeader.set(PaymentPlanHeader.AMOUNT, sum);
			 * paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT, sum);
			 * 
			 * } } else { if (logger.isDebugEnabled())
			 * logger.logDebug("<<< OPCION DE TABLA DE AMORTIZACION >>>"); for
			 * (RenewLoanResponse response : balanceResponse) {// Recorre // la // lista //
			 * de // resultados // de // la // ejecucion // del // servicio
			 * logger.logDebug("<<< 2. TIPO -> REFINANCIAMIENTO >>> VALORES FOR: " +
			 * response.getBalance()); if (Integer.parseInt(response.getOperationMoney()) ==
			 * applicationResponseDTO.getCurrencyRequested()) { logger.logDebug(
			 * "<<< 3. TIPO -> REFINANCIAMIENTO >>> MONEDAS IGUALES >>> VALOR: " +
			 * response.getBalance()); sum = sum.add(new BigDecimal(response.getBalance()));
			 * logger.logDebug(
			 * "<<< 4. TIPO -> REFINANCIAMIENTO >>> SUMA MONEDAS IGUALES >>> VALOR: " +
			 * sum); } else { logger.logDebug(
			 * "<<< 5. TIPO -> REFINANCIAMIENTO >>> MONEDAS DIFERENTES >>> VALOR: " +
			 * response.getBalance()); amountInCurrencyDestination = tranManager
			 * .getQuote(Integer.parseInt(response.getOperationMoney()),
			 * applicationResponseDTO.getCurrencyRequested(), response.getBalance(), arg1,
			 * new BehaviorOption(true)); logger.logDebug
			 * ("<<< 6. TIPO -> REFINANCIAMIENTO >>> CONVERSION >>> VALOR: " +
			 * amountInCurrencyDestination); sum = sum.add(new
			 * BigDecimal(amountInCurrencyDestination)); logger.logDebug(
			 * "<<< 7. TIPO -> REFINANCIAMIENTO >>> SUMA MONEDAS DISTINTAS >>> VALOR: " +
			 * sum); } }// FIN FOR
			 * 
			 * paymentPlanHeader.set(PaymentPlanHeader.AMOUNT, sum);
			 * paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT, sum); }
			 * 
			 * // FIN REFINANCIAMIENTO } else if (this.IsReschedule(applicationResponseDTO))
			 * { // SOLO // CUANDO // ES // UNA // REPROGRAMACION if
			 * (logger.isDebugEnabled())
			 * logger.logDebug("<<< 1. TIPO -> REPROGRAMACION >>>");
			 * 
			 * for (RenewLoanResponse response : balanceResponse) {// Recorre // la // lista
			 * // de // resultados // de // la // ejecucion // del // servicio
			 * logger.logDebug("<<< 2. TIPO -> REPROGRAMACION >>> VALORES FOR: " +
			 * response.getBalance()); if (Integer.parseInt(response.getOperationMoney()) ==
			 * applicationResponseDTO.getCurrencyRequested()) { logger.logDebug(
			 * "<<< 3. TIPO -> REPROGRAMACION >>> MONEDAS IGUALES >>> VALOR: " +
			 * response.getBalance()); sum = sum.add(new BigDecimal(response.getBalance()));
			 * logger.logDebug(
			 * "<<< 4. TIPO -> REPROGRAMACION >>> SUMA MONEDAS IGUALES >>> VALOR: " + sum);
			 * } else { logger.logDebug(
			 * "<<< 5. TIPO -> REPROGRAMACION >>> MONEDAS DIFERENTES >>> VALOR: " +
			 * response.getBalance()); amountInCurrencyDestination = tranManager
			 * .getQuote(Integer.parseInt(response.getOperationMoney()),
			 * applicationResponseDTO.getCurrencyRequested(), response.getBalance(), arg1,
			 * new BehaviorOption(true)); logger.logDebug
			 * ("<<< 6. TIPO -> REPROGRAMACION >>> CONVERSION >>> VALOR: " +
			 * amountInCurrencyDestination); sum = sum.add(new
			 * BigDecimal(amountInCurrencyDestination)); logger.logDebug(
			 * "<<< 7. TIPO -> REPROGRAMACION >>> SUMA MONEDAS DISTINTAS >>> VALOR: " +
			 * sum); } }// FIN FOR
			 * 
			 * paymentPlanHeader.set(PaymentPlanHeader.AMOUNT, sum);
			 * paymentPlanHeader.set(PaymentPlanHeader.APPROVEDAMOUNT, sum);
			 * 
			 * }// FIN REPROGRAMACION
			 * 
			 * // RECUPERA LOS DATOS VARIABLES PARA EL CREDITO DE // VIVIENDA DE INTERES
			 * SOCIAL
			 * 
			 * @SuppressWarnings("unchecked") Map<String, Object> task = (Map<String,
			 * Object>) arg1.getParameters().getCustomParameters().get("Task");
			 * 
			 * @SuppressWarnings("unchecked") Map<String, Object> url = (Map<String,
			 * Object>) task.get("urlParams"); if (!url.isEmpty() && (url.get("tipo") !=
			 * null)) { String paramTipo = url.get("tipo").toString(); if
			 * (paramTipo.equals(Mnemonic.SOCIALHOUSING)) {
			 * paymentPlanHeader.set(PaymentPlanHeader.PRODUCTTYPE,
			 * applicationResponseDTO.getOpertationType()); } } }
			 * 
			 * }
			 * 
			 * }
			 */

			// Valida si es Crédito con Convenio.
			if (OperationBLI.validateRequestWithAgreement(entities)) {
				arg1.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_CETDOVENI_82322");
			}

			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) == null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() == ""
					|| originalHeader.get(OriginalHeader.PRODUCTTYPE) == "null") {
				if (logger.isDebugEnabled())
					logger.logDebug("applicationResponseDTO.getOpertationType()" + applicationResponseDTO.getOpertationType());
				originalHeader.set(OriginalHeader.PRODUCTTYPE, applicationResponseDTO.getOpertationType());
			}

			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null && originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != ""
					&& originalHeader.get(OriginalHeader.PRODUCTTYPE) != "null") {
				if (logger.isDebugEnabled()) {
					logger.logDebug(":>:>productType :>:>" + originalHeader.get(OriginalHeader.PRODUCTTYPE));
				}
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				// Recupero el parámetro Sector
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
						originalHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");

				// Asocio el valor del sector
				for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
					generalData.set(new Property<String>("sectorNegCod", String.class, false), sectorNeg.getValue());
					logger.logDebug("sector codigo<<<: " + sectorNeg.getValue());
					/*
					 * generalData.set(new Property<String>("sectorNeg", String.class, false),
					 * sectorNeg.getDescription());
					 */
				}
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);
			} else {
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");
			}

			// nombre de la frecuencia de pago
			if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {
				CatalogDto frecuencyCatalogDto = OperationBLI.getFrecuencyCatalog(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim(), arg1, getServiceIntegration());
				if (frecuencyCatalogDto != null) {
					generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), frecuencyCatalogDto.getName());
					if (logger.isDebugEnabled())
						logger.logDebug("---->Frecuencia de Pago: " + frecuencyCatalogDto.getName());
				}
			}

			if (logger.isDebugEnabled())
				logger.logDebug("---->Ejecucion de servicio para recuperar el sector desde apf");
			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());

			// Recupero el parámetro Sector
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE),
					"Sector");

			// Asocio el valor del sector
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getDescription());
			}

			if (logger.isDebugEnabled())
				logger.logDebug("Salida -> IInitDataEvent -> InitDataPaymentPlan");
		} catch (BusinessException bex) {
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, bex.getMessage());
			arg1.setSuccess(false);
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("Exception -> IInitDataEvent -> InitDataPaymentPlan\n", e);
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
			arg1.setSuccess(false);
		}
	}

	public DataEntity getMaxQualification(DataEntity entity, DataEntityList debtors) {
		ArrayList<String> qualification = new ArrayList<String>();
		if (debtors != null) {
			for (DataEntity debtor : debtors) {
				qualification.add(debtor.get(DebtorGeneral.QUALIFICATION));
			}
		}
		Collections.sort(qualification);
		String qual = qualification.isEmpty() ? "" : qualification.get(0);
		entity.set(ApprovalCriteriaQuestion.PREVIOUSRATEFIE, qual);

		for (DataEntity debtor : debtors) {
			if (qual.equals(debtor.get(DebtorGeneral.QUALIFICATION))) {
				return debtor;
			}
		}

		return null;
	}

	private boolean IsExpromission(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.EXPROMISSIONREQUEST) && applicationResponseDTO.getExpromission() != null
				&& !applicationResponseDTO.getExpromission().isEmpty());
	}

	private boolean IsRefinancing(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.REFINANCINGREQUEST));
	}

	private boolean IsReschedule(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.RESCHEDULEREQUEST));
	}

}
