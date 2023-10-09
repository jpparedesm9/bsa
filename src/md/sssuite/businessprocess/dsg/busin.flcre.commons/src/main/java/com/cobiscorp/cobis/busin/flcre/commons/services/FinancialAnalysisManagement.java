package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.Date;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.AnalysisResponse;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.AnalysisResponseHeader;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.FinanEvalRequest;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.FinanEvalResponse;
import cobiscorp.ecobis.finaneval.finanevalquery.dto.FinancialAnalysisResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.PaymentCapacity;
import com.cobiscorp.cobis.busin.model.PaymentCapacityHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class FinancialAnalysisManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(FinancialAnalysisManagement.class);
	private AnalysisResponseHeader analysisResponseHeader;
	private AnalysisResponse[] analysisResponseList;

	public FinancialAnalysisManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public AnalysisResponseHeader getAnalysisResponseHeader() {
		return analysisResponseHeader;
	}

	public AnalysisResponse[] getAnalysisResponseList() {
		return analysisResponseList;
	}

	public FinancialAnalysisResponse searchFinancialAnalysisByCustomerAndDate(FinanEvalRequest finanEvalRequest, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingresa a clase FinancialAnalysisManagement");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INFINANEVALREQUEST, finanEvalRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHFINANCIALANALYSIS, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceValidateResponseTO = (ServiceResponseTO) serviceResponse.getData();
			FinancialAnalysisResponse response = (FinancialAnalysisResponse) serviceValidateResponseTO.getValue(ReturnName.RETURNANALYSISRESPONSE);
			if (response != null) {
				return (FinancialAnalysisResponse) response;
			}
		}
		return null;
	}

	public FinanEvalResponse[] readFinanEvalAvailableBalance(int applicationNumber, Calendar entryDate, ICommonEventArgs arg1, BehaviorOption options) {
		FinanEvalRequest finanEvalRequest = new FinanEvalRequest();
		finanEvalRequest.setIdInstanciawf(applicationNumber);
		finanEvalRequest.setAnalisisDate(entryDate);

		ServiceRequestTO serviceRequestDisponibleTO = new ServiceRequestTO();
		serviceRequestDisponibleTO.getData().put(RequestName.INFINANEVALREQUEST, finanEvalRequest);

		ServiceResponse serviceDisponibleResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEFINANEVAL, serviceRequestDisponibleTO);
		if (serviceDisponibleResponse.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("LineCreditData recuperados para - " + applicationNumber);
				ServiceResponseTO serviceValidateResponseTO = (ServiceResponseTO) serviceDisponibleResponse.getData();
				FinanEvalResponse[] finanRes = (FinanEvalResponse[]) serviceValidateResponseTO.getValue(ReturnName.FINANEVALRESPONSE);
				return finanRes;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	public boolean queryFinancialAnalysis(DynamicRequest entities, char type, int requestId, Date expirationDate, int currencyId, ICommonEventArgs arg1, BehaviorOption options) {
		DataEntity paymentCapacityHeader = entities.getEntity(PaymentCapacityHeader.ENTITY_NAME);
		paymentCapacityHeader.set(PaymentCapacityHeader.PERIODGRACE, 0);
		paymentCapacityHeader.set(PaymentCapacityHeader.STATUS, "ERROR");
		paymentCapacityHeader.set(PaymentCapacityHeader.VALIDATIONSUCCESS, false);

		DataEntityList paymentCapacityList = new DataEntityList();

		FinanEvalRequest finanEvalRequestDTO = new FinanEvalRequest();
		finanEvalRequestDTO.setRequestId(requestId);// @i_tramite
		finanEvalRequestDTO.setAnalisisDate(Convert.CDate.toCalendar(expirationDate));// @i_fecha_analisis
		finanEvalRequestDTO.setCurrency(currencyId);// @i_moneda
		finanEvalRequestDTO.setType(type);// @i_tipo_analisis

		boolean returnValue = queryFinancialAnalysis(finanEvalRequestDTO, arg1, options);

		logger.logDebug("------>returnValue" + returnValue);
		if (returnValue) {
			// datos de la cabecera
			paymentCapacityHeader.set(PaymentCapacityHeader.PERIODGRACE, this.analysisResponseHeader.getPeriodGrace());
			paymentCapacityHeader.set(PaymentCapacityHeader.STARTMONTH, this.analysisResponseHeader.getStartMonth());
			// datos de los detalles
			for (AnalysisResponse analysisResponseDTO : this.analysisResponseList) {
				logger.logDebug("----------->analysisResponseDTO" + analysisResponseDTO.getCustomerId() + ", " + analysisResponseDTO.getCustomerName());
				DataEntity paymentCapacity = new DataEntity();
				paymentCapacity.set(PaymentCapacity.CUSTOMERID, analysisResponseDTO.getCustomerId());
				paymentCapacity.set(PaymentCapacity.CUSTOMERNAME, analysisResponseDTO.getCustomerName());
				paymentCapacity.set(PaymentCapacity.BALANCE1, analysisResponseDTO.getBalance1());
				paymentCapacity.set(PaymentCapacity.BALANCE2, analysisResponseDTO.getBalance2());
				paymentCapacity.set(PaymentCapacity.BALANCE3, analysisResponseDTO.getBalance3());
				paymentCapacity.set(PaymentCapacity.BALANCE4, analysisResponseDTO.getBalance4());
				paymentCapacity.set(PaymentCapacity.BALANCE5, analysisResponseDTO.getBalance5());
				paymentCapacity.set(PaymentCapacity.BALANCE6, analysisResponseDTO.getBalance6());
				paymentCapacity.set(PaymentCapacity.BALANCE7, analysisResponseDTO.getBalance7());
				paymentCapacity.set(PaymentCapacity.BALANCE8, analysisResponseDTO.getBalance8());
				paymentCapacity.set(PaymentCapacity.BALANCE9, analysisResponseDTO.getBalance9());
				paymentCapacity.set(PaymentCapacity.BALANCE10, analysisResponseDTO.getBalance10());
				paymentCapacity.set(PaymentCapacity.BALANCE11, analysisResponseDTO.getBalance11());
				paymentCapacity.set(PaymentCapacity.BALANCE12, analysisResponseDTO.getBalance12());
				paymentCapacity.set(PaymentCapacity.MONTHAVERAGE, analysisResponseDTO.getMonthAverage());
				paymentCapacity.set(PaymentCapacity.TOTALANNUAL, analysisResponseDTO.getTotalAnnual());
				paymentCapacityList.add(paymentCapacity);
			}
			paymentCapacityHeader.set(PaymentCapacityHeader.STATUS, "OK");
		}
		entities.setEntityList(PaymentCapacity.ENTITY_NAME, paymentCapacityList);
		return returnValue;
	}

	public boolean queryFinancialAnalysis(FinanEvalRequest finanEvalRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.analysisResponseHeader = null;
		this.analysisResponseList = null;
		if (logger.isDebugEnabled())
			logger.logDebug("Inicio Servicio -> FinancialAnalysisManagement -> " + ServiceId.QUERYFINANCIALANALYSIS);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INFINANEVALREQUEST, finanEvalRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERYFINANCIALANALYSIS, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceValidateResponseTO = (ServiceResponseTO) serviceResponse.getData();
			this.analysisResponseHeader = (AnalysisResponseHeader) serviceValidateResponseTO.getValue(ReturnName.ANALYSISRESPONSEHEADER);
			this.analysisResponseList = (AnalysisResponse[]) serviceValidateResponseTO.getValue(ReturnName.ANALYSISRESPONSE);
			if (logger.isDebugEnabled())
				logger.logDebug("Exito Servicio -> FinancialAnalysisManagement -> " + ServiceId.QUERYFINANCIALANALYSIS);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			if (logger.isDebugEnabled())
				logger.logDebug("Error Servicio -> FinancialAnalysisManagement -> " + ServiceId.QUERYFINANCIALANALYSIS);
		}
		return serviceResponse.isResult();
	}

	public boolean computeValidationQuotaVsAvailableBalance(DynamicRequest entities, ICommonEventArgs arg1, BigDecimal cuotaMaxima, BigDecimal cuotaMaximaLinea,
			DataEntity cuotaMaximaENT, DataEntity cuotaMaximaLineaENT, BehaviorOption options) {
		boolean validationOk = true;
		Property<BigDecimal> BALANCE;
		BigDecimal zero = new BigDecimal(0);
		int maxCols = 12;// Por ahora el calculo es para 12 meses

		DataEntity paymentCapacityHeaderENT = entities.getEntity(PaymentCapacityHeader.ENTITY_NAME);
		paymentCapacityHeaderENT.set(PaymentCapacityHeader.COUNTTERM, maxCols);

		DataEntityList paymentCapacityList = entities.getEntityList(PaymentCapacity.ENTITY_NAME);
		DataEntity saldoDisponibleMensualENT = paymentCapacityList.get(paymentCapacityList.size() - 1);
		DataEntity flujoCajaAcumuladoENT = FinancialAnalysisManagement.getPaymentCapacityEntity(-2);
		if (cuotaMaximaENT == null) {
			cuotaMaximaENT = FinancialAnalysisManagement.getPaymentCapacityEntity(-3, cuotaMaxima);
		}
		if (cuotaMaximaLineaENT == null) {
			cuotaMaximaLineaENT = FinancialAnalysisManagement.getPaymentCapacityEntity(-4, cuotaMaximaLinea);
		}
		DataEntity margenDeAhorroENT = FinancialAnalysisManagement.getPaymentCapacityEntity(-5);

		// CALCULA Y MAPEA TOTALES Y PROMEDIOS DE 'CUOTA MÁXIMA' Y 'CUOTA MÁXIMA
		// LÍNEA'
		BigDecimal totalCuotaMaxima = new BigDecimal(0);
		BigDecimal totalCuotaMaximaLinea = new BigDecimal(0);

		for (int i = 1; i <= maxCols; i++) {
			BALANCE = new Property<BigDecimal>("Balance" + i, BigDecimal.class, false);
			totalCuotaMaxima = totalCuotaMaxima.add(cuotaMaximaENT.get(BALANCE) != null ? cuotaMaximaENT.get(BALANCE) : zero);
			totalCuotaMaximaLinea = totalCuotaMaximaLinea.add(cuotaMaximaLineaENT.get(BALANCE) != null ? cuotaMaximaLineaENT.get(BALANCE) : zero);
		}

		if (totalCuotaMaxima.compareTo(zero) > 0) {
			cuotaMaximaENT.set(PaymentCapacity.MONTHAVERAGE, totalCuotaMaxima.divide(new BigDecimal(maxCols), 2, RoundingMode.HALF_UP));
			cuotaMaximaENT.set(PaymentCapacity.TOTALANNUAL, totalCuotaMaxima);
			cuotaMaximaLineaENT.set(PaymentCapacity.MONTHAVERAGE, totalCuotaMaximaLinea.divide(new BigDecimal(maxCols), 2, RoundingMode.HALF_UP));
			cuotaMaximaLineaENT.set(PaymentCapacity.TOTALANNUAL, totalCuotaMaxima);
		} else {
			validationOk = false;
			if (options.isSuccessFalse()) {
				arg1.setSuccess(false);
			}
		}

		// CALCULA Y MAPEA EL FLUJO DE CAJA ACUMULADO
		if (totalCuotaMaxima.compareTo(zero) > 0) {
			BigDecimal margenDeAhorro = new BigDecimal(0);
			BigDecimal totalMargenDeAhorro = new BigDecimal(0);
			BigDecimal totalFlujoCajaAcumulado = new BigDecimal(0);
			for (int i = 1; i <= maxCols; i++) {
				BALANCE = new Property<BigDecimal>("Balance" + i, BigDecimal.class, false);

				BigDecimal flujoCajaAcumulado = saldoDisponibleMensualENT.get(BALANCE).add(margenDeAhorro);
				cuotaMaxima = (cuotaMaximaENT.get(BALANCE) != null ? cuotaMaximaENT.get(BALANCE) : zero);
				margenDeAhorro = flujoCajaAcumulado.subtract(cuotaMaxima);

				totalFlujoCajaAcumulado = totalFlujoCajaAcumulado.add(flujoCajaAcumulado);
				totalMargenDeAhorro = totalMargenDeAhorro.add(margenDeAhorro);

				flujoCajaAcumuladoENT.set(BALANCE, flujoCajaAcumulado);
				margenDeAhorroENT.set(BALANCE, margenDeAhorro);
				// VALIDACION DEL MONTO
				if (margenDeAhorro.compareTo(new BigDecimal(0)) < 0) {
					validationOk = false;
				}
			}

			// LLENAR PROMEDIOS Y TOTALES
			flujoCajaAcumuladoENT.set(PaymentCapacity.MONTHAVERAGE, totalFlujoCajaAcumulado.divide(new BigDecimal(maxCols), 2, RoundingMode.HALF_UP));
			margenDeAhorroENT.set(PaymentCapacity.MONTHAVERAGE, totalMargenDeAhorro.divide(new BigDecimal(maxCols), 2, RoundingMode.HALF_UP));
			margenDeAhorroENT.set(PaymentCapacity.TOTALANNUAL, saldoDisponibleMensualENT.get(PaymentCapacity.TOTALANNUAL).subtract(totalCuotaMaxima));
		} else {
			validationOk = false;
			if (options.isSuccessFalse()) {
				arg1.setSuccess(false);
			}
		}

		// CARGA LAS ENTIDADES
		paymentCapacityList.add(flujoCajaAcumuladoENT);
		paymentCapacityList.add(cuotaMaximaENT);
		paymentCapacityList.add(cuotaMaximaLineaENT);
		paymentCapacityList.add(margenDeAhorroENT);
		entities.setEntityList(PaymentCapacity.ENTITY_NAME, paymentCapacityList);

		// INDICA SI LA VALIDACION FUE CORRECTA
		paymentCapacityHeaderENT.set(PaymentCapacityHeader.VALIDATIONSUCCESS, validationOk);
		return validationOk;
	}

	public static DataEntity getPaymentCapacityEntity(int customerId) {
		return FinancialAnalysisManagement.getPaymentCapacityEntity(customerId, "", null, null, null, null, null, null, null, null, null, null, null, null, null, null);
	}

	public static DataEntity getPaymentCapacityEntity(int customerId, BigDecimal unicBalance) {
		return FinancialAnalysisManagement.getPaymentCapacityEntity(customerId, "", unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, unicBalance,
				unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, null, null);
	}

	public static DataEntity getPaymentCapacityEntity(int customerId, BigDecimal unicBalance, BigDecimal mothAverage, BigDecimal totalAnnual) {
		return FinancialAnalysisManagement.getPaymentCapacityEntity(customerId, "", unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, unicBalance,
				unicBalance, unicBalance, unicBalance, unicBalance, unicBalance, mothAverage, totalAnnual);
	}

	public static DataEntity getPaymentCapacityEntity(int customerId, String customerName, BigDecimal balance1, BigDecimal balance2, BigDecimal balance3, BigDecimal balance4,
			BigDecimal balance5, BigDecimal balance6, BigDecimal balance7, BigDecimal balance8, BigDecimal balance9, BigDecimal balance10, BigDecimal balance11,
			BigDecimal balance12, BigDecimal mothAverage, BigDecimal totalAnnual) {
		DataEntity paymentCapacity = new DataEntity();
		paymentCapacity.set(PaymentCapacity.CUSTOMERID, customerId);
		paymentCapacity.set(PaymentCapacity.CUSTOMERNAME, customerName);
		paymentCapacity.set(PaymentCapacity.BALANCE1, balance1);
		paymentCapacity.set(PaymentCapacity.BALANCE2, balance2);
		paymentCapacity.set(PaymentCapacity.BALANCE3, balance3);
		paymentCapacity.set(PaymentCapacity.BALANCE4, balance4);
		paymentCapacity.set(PaymentCapacity.BALANCE5, balance5);
		paymentCapacity.set(PaymentCapacity.BALANCE6, balance6);
		paymentCapacity.set(PaymentCapacity.BALANCE7, balance7);
		paymentCapacity.set(PaymentCapacity.BALANCE8, balance8);
		paymentCapacity.set(PaymentCapacity.BALANCE9, balance9);
		paymentCapacity.set(PaymentCapacity.BALANCE10, balance10);
		paymentCapacity.set(PaymentCapacity.BALANCE11, balance11);
		paymentCapacity.set(PaymentCapacity.BALANCE12, balance12);
		paymentCapacity.set(PaymentCapacity.MONTHAVERAGE, mothAverage);
		paymentCapacity.set(PaymentCapacity.TOTALANNUAL, totalAnnual);
		return paymentCapacity;
	}
}
