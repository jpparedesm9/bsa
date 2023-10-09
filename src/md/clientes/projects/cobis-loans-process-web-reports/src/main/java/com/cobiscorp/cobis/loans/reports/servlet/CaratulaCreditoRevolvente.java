package com.cobiscorp.cobis.loans.reports.servlet;

import java.math.BigDecimal;
import java.util.ArrayList;
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
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CaratulaCreditoGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;
import com.cobiscorp.cobis.loans.reports.impl.CaratulaCreditoGrupalIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "caratulaCreditoRevolvente") })
public class CaratulaCreditoRevolvente implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(CaratulaCreditoRevolvente.class);
	private static final String COSTOANUALTOTAL = "costoAnualTotal";
	private static final String TASAINTERESANUAL = "tasaInteresAnual";
	private static final String MONTOTOTALPAGAR = "montoTotalPagar";
	private static final String MONTOCREDITO = "montoCredito";
	private static final String LISTACOMISIONES = "listaComisiones";
	private static final String PORCENTAJEMORA = "porcentajeMora";
	private static final String PLAZOCREDITO = "plazoCredito";
	private static final String DESCRIP_MONEDA = "descripMoneda";
	private static final String DESCRIP_PLAZO = "descripPlazo";
	private static final String FECHA_PAGO = "fechaPago";
	private static final String FECHA_CORTE = "fechaCorte";
	private static final String COMISIONDISCREFEC = "comisionDisCrEfec";

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("CaratulaCreditoGrupal - getDatasourceReport - INI");
		}
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Collection<CaratulaCreditoGrupalDATABEAN> collection = new ArrayList<CaratulaCreditoGrupalDATABEAN>();
		Services services = new Services();
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getDatasourceReport - sessionId= " + sessionId);
				logger.logDebug("getDatasourceReport - application= " + application);
			}

			CaratulaCreditoGrupalDATABEAN caratulaCreditoGrupalDATABEAN = new CaratulaCreditoGrupalDATABEAN();

			GroupLoanInfResponse[] groupLoanInfResponseList = services.getSearchGroupCreditPaymentList(sessionId, application, serviceIntegration);

			List<CreditPaymentsDTO> paymentsList = CaratulaCreditoGrupalIMPL.getPaymentsList(groupLoanInfResponseList);
			caratulaCreditoGrupalDATABEAN.setListaPagos(paymentsList);
			collection.add(caratulaCreditoGrupalDATABEAN);
			if (logger.isDebugEnabled()) {
				logger.logDebug("getDatasourceReport -> collection: " + collection);
			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud Caratula Credito Grupal:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> params) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>RPT CaratulaCreditoGrupal - getParamsReport - INI");
		}
		initParamHeader(params);
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String user = (String) ((Map) params.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);
			String applicationCode = (String) params.get(ConstantValue.Params.APPLICATION);
			Services services = new Services();
			Method method = new Method();

			method.setPrmMain(params);
			if (logger.isDebugEnabled()) {
				logger.logDebug("getParamsReport - sessionId= " + sessionId);
				logger.logDebug("getParamsReport - user= " + user);
				logger.logDebug("getParamsReport - applicationCode= " + applicationCode);
			}
			if (applicationCode != null && sessionId != null) {
				GroupLoanInfResponse[] groupLoanInfResponseList = services.getGroupCreditCover(sessionId, applicationCode, serviceIntegration);
				if (logger.isDebugEnabled()) {
					logger.logDebug("getParamsReport - response inf: " + groupLoanInfResponseList);
				}
				if (groupLoanInfResponseList != null) {
					
					GroupLoanInfResponse groupCreditCoverResponse = groupLoanInfResponseList[0];
					if (groupCreditCoverResponse.getTotalAnnualCost() != null) {
						//String valor = Functions.StringNumerDecimal(groupCreditCoverResponse.getTotalAnnualCost().toString());						
						String valor = groupCreditCoverResponse.getTotalAnnualCost().toString();
						method.mapValuesToParams(COSTOANUALTOTAL, valor, "");						
					} else {
						params.put(COSTOANUALTOTAL, "");
					}
					
					if (groupCreditCoverResponse.getAnnualInterestRate() != null) {
						String valor = Functions.StringNumerDecimal(groupCreditCoverResponse.getAnnualInterestRate().toString());					
						method.mapValuesToParams(TASAINTERESANUAL, valor, "");						
					} else {
						params.put(TASAINTERESANUAL, "");
					}
			
					method.mapValuesToParams(MONTOCREDITO, groupCreditCoverResponse.getCreditAmount(), "");
					if (logger.isDebugEnabled()) {
						logger.logDebug("getParamsReport - CreditAmount= " + groupCreditCoverResponse.getCreditAmount());
					}
					method.mapValuesToParams(MONTOTOTALPAGAR, groupCreditCoverResponse.getTotalAmountPayable(), "");
					method.mapValuesToParams(LISTACOMISIONES, groupCreditCoverResponse.getCommissions(), "");
					method.mapValuesToParams(PORCENTAJEMORA, groupCreditCoverResponse.getPercentageForDelay(), "");
					method.mapValuesToParams(PLAZOCREDITO, groupCreditCoverResponse.getCrediTimeLimit(), "");
					method.mapValuesToParams(DESCRIP_MONEDA, groupCreditCoverResponse.getCurrencyDesc(), "");
					method.mapValuesToParams(DESCRIP_PLAZO, groupCreditCoverResponse.getTimeLimitDesc(), "");
					method.mapValuesToParams(FECHA_PAGO, groupCreditCoverResponse.getPaymentDate(), "");
					method.mapValuesToParams(FECHA_CORTE, groupCreditCoverResponse.getProcessDate(), "");
					
					// method.mapValuesToParams(FECHA_LIQUIDA, groupCreditCoverResponse.getDueDate(), "");
					
					method.mapValuesToParams(COMISIONDISCREFEC, groupCreditCoverResponse.getCommissionPercentage(), "");
					if (logger.isDebugEnabled()) {
						logger.logDebug("getParamsReport - comisionLCR= " + groupCreditCoverResponse.getCommissionPercentage());
					}					

					String aseguradoraS = "";
					String contraAdhesionS = "";
					String contraAdhesionRayas = "";
					String seguroS = "";
					ParameterResponse aseguradora = services.getParameter(4, "RCGASE", Mnemonic.MODULE, serviceIntegration, sessionId);

					if (aseguradora != null) {
						aseguradoraS = aseguradora.getParameterValue();
					}
					method.mapValuesToParams("aseguradora", aseguradoraS, "");

					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					ParameterResponse reca = services.getParameter(4, "RDADHS", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (reca != null) {
						contraAdhesionS = reca.getParameterValue();
					}
					method.mapValuesToParams("contraAdhesion", contraAdhesionS, "");

					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					ParameterResponse recaRayas = services.getParameter(4, "RDADHR", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (recaRayas != null) {
						contraAdhesionRayas = recaRayas.getParameterValue();
					}
					method.mapValuesToParams("contraAdhesionRayas", contraAdhesionRayas, "");

					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					ParameterResponse seguro = services.getParameter(4, "RCGSG1", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse seguro2 = services.getParameter(4, "RCGSG2", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (seguro != null) {
						seguroS = seguro.getParameterValue();
					}
					if (seguro2 != null) {
						seguroS = seguroS + seguro2.getParameterValue();
					}
					method.mapValuesToParams("seguro", seguroS, "");

					ParameterResponse pieAnio = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (pieAnio != null) {
						method.mapValuesToParams("pieAnio", pieAnio.getParameterValue(), "");
					}
					ParameterResponse param = services.getParameter(4, "PSOLCR", "CRE", serviceIntegration, sessionId);
					if (logger.isDebugEnabled()) {
						logger.logDebug("Parametro pie: " + param.getParameterValue());
					}

					method.mapValuesToParams("footParam", param.getParameterValue(), "");
					method.mapValuesToParams("nombreComercProd", groupCreditCoverResponse.getProductTradeName(), "");
				}
				if (logger.isDebugEnabled()) {
					logger.logDebug("params Caratula Credito Revolvente: " + params);
				}
			}

		} catch (Exception e) {
			logger.logError("*****>>Error - CaratulaCreditoGrupal:", e);
			throw new RuntimeException(e);
		}

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> params) {
		return getFileLocationReport(ConstantValue.JasperPath.CARAT_CREDIT_REV);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.CARAT_CREDIT_REV;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put(COSTOANUALTOTAL, "");
		params.put(TASAINTERESANUAL, "");
		params.put(MONTOCREDITO, "");
		params.put(MONTOTOTALPAGAR, "");
		params.put(LISTACOMISIONES, "");
		params.put(PORCENTAJEMORA, "");
		params.put(PLAZOCREDITO, "");
		params.put("seguro", "");
		params.put("aseguradora", "");
		params.put("contraAdhesion", "");
		params.put("pieAnio", "");
		params.put(COMISIONDISCREFEC, "");
	}
}
