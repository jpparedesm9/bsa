package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CargoRecurrenteIndividualDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.MemberChargesDTO;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "cargoRecurrenteIndiv") })
public class AutorizacionCargoRecurrente implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(AutorizacionCargoRecurrente.class);
	private static final String FECHAPROCESO = "fechaProceso";
	private static final String PERIODICIDADPAGO = "periodicidadPago";
	private static final String NUMTARJCUENTA = "numeroTarjetaCuenta";
	private static final String CLAVEBANCARIAEST = "claveBancariaEst";
	private static final String MONTOMAXIMOFIJO = "montoMaximoFijo";
	private static final String FECHAVENCIMIENTO = "fechaVencimiento";
	private static final String NOMBRECLIENTE = "nombreCliente";
	private static final String NUMEROCREDITO = "numeroCredito";

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> aParams) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> aParams) {

		logger.logDebug("AutorizacionCargoRecurrente - FORMATO DE DOMICIALICIACION -- getDatasourceReport - INI");

		String wSessionId = (String) aParams.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String wApplication = (String) aParams.get(ConstantValue.Params.APPLICATION);
		Collection<CargoRecurrenteIndividualDATABEAN> wCargoRecurrenteCollection = new ArrayList<CargoRecurrenteIndividualDATABEAN>();
		try {
			if (wSessionId != null && wApplication != null) {
				CargoRecurrenteIndividualDATABEAN wcargoCreIndDATABEANDATABEAN = new CargoRecurrenteIndividualDATABEAN();
				List<MemberChargesDTO> memberChargesList = new ArrayList<MemberChargesDTO>();
				wcargoCreIndDATABEANDATABEAN.setListaMiembros(memberChargesList);

				wCargoRecurrenteCollection.add(wcargoCreIndDATABEANDATABEAN);
				return new JRBeanCollectionDataSource(wCargoRecurrenteCollection);
			}

		} catch (Exception e) {
			logger.logDebug("*****>>Error - Solicitud Caratula Credito Indiv:", e);
			throw new RuntimeException(e);
		}

		return null;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> aParams) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> aParams) {
		logger.logDebug("*****>>Inicio AutorizacionCargoRecurrente - getParamsReport - INI");
		initParamHeader(aParams);
		Services services = new Services();
		Method method = new Method();
		
		try {
			String wSessionId = (String) aParams.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			// String wUser = (String) ((Map) aParams.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);
			String wApplication = (String) aParams.get(ConstantValue.Params.APPLICATION);
			method.setPrmMain(aParams);

			logger.logDebug("*****>>AutorizacionCargoRecurrente IND - applicationCode:" + wApplication);

			GroupLoanInfResponse[] recurringChargeResponses = services.getRecurringChargeMembers(wSessionId, wApplication, serviceIntegration);
			if (recurringChargeResponses != null) {
				logger.logDebug("*****>>AutorizacionCargoRecurrente IND - recurringChargeResponses.length:" + recurringChargeResponses.length);
				if (recurringChargeResponses.length > 0) {
					method.mapValuesToParams(FECHAPROCESO, Functions.convertCalendarToString(recurringChargeResponses[0].getSettlementDate(), ConstantValue.valueConstant.DF_DDMMYYYY), "");
					method.mapValuesToParams(PERIODICIDADPAGO, recurringChargeResponses[0].getPeriodicity(), "");
					method.mapValuesToParams(NUMTARJCUENTA, recurringChargeResponses[0].getAccountNumber(), "");
					method.mapValuesToParams(CLAVEBANCARIAEST, "", "");
					method.mapValuesToParams(MONTOMAXIMOFIJO, (Functions.getStringCurrencyFormated(recurringChargeResponses[0].getMaxAmount())), "");
					method.mapValuesToParams(FECHAVENCIMIENTO, Functions.convertCalendarToString(recurringChargeResponses[0].getDueDate(), ConstantValue.valueConstant.DF_DDMMYYYY), "");
					method.mapValuesToParams(NOMBRECLIENTE, recurringChargeResponses[0].getCustomerName(), "");
					method.mapValuesToParams(NUMEROCREDITO, recurringChargeResponses[0].getCreditNumber(), "");
					method.mapValuesToParams("importeSemanaAPagar", (Functions.getStringCurrencyFormated(recurringChargeResponses[0].getWeeklyAmountToPay())), "0.0");
				} else {
					initParamHeader(aParams);
				}
			} else {
				initParamHeader(aParams);
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - CaratulaCreditoIndividual:", e);
			throw new RuntimeException(e);
		}
		return aParams;
	}

	@Override
	public String getReportLocation(Map<String, Object> aParams) {
		return getFileLocationReport(ConstantValue.JasperPath.CARGO_RECURRENTE_INDIV);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.CARGO_RECURRENTE_INDIV;
	}

	private void initParamHeader(Map<String, Object> aParams) {
		logger.logDebug("*****>>AutorizacionCargoRecurrente IND - initParamHeader INICIO");
		aParams.put(FECHAPROCESO, "");
		aParams.put(PERIODICIDADPAGO, "");
		aParams.put(NUMTARJCUENTA, "");
		aParams.put(CLAVEBANCARIAEST, "");
		aParams.put(MONTOMAXIMOFIJO, "");
		aParams.put(FECHAVENCIMIENTO, "");
		aParams.put(NOMBRECLIENTE, "");
		aParams.put(NUMEROCREDITO, "");
		aParams.put("importeSemanaAPagar", "0.0");
	}
}
