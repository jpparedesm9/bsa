package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CaratulaContratoCreditoDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;
import com.cobiscorp.cobis.loans.reports.impl.CaratulaContractoCreditoIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "caratulaCreditoSimpleAutoOnboard") })
public class CaratulaContratoCredito implements ICOBISReportResourcesService<JRDataSource> {
	private static final ILogger logger = LogFactory.getLogger(CaratulaContratoCredito.class);
	private static final String COSTOANUALTOTAL = "costoAnualTotal";
	private static final String TASAINTERESANUAL = "tasaInteresAnual";
	private static final String MONTOTOTALPAGAR = "montoTotalPagar";
	private static final String MONTOCREDITO = "montoCredito";
	private static final String LISTACOMISIONES = "listaComisiones";
	private static final String PORCENTAJEMORA = "porcentajeMora";
	private static final String PLAZOCREDITO = "plazoCredito";
	private static final String DESCRIP_MONEDA = "descripMoneda";
	private static final String DESCRIP_PLAZO = "descripPlazo";
	private static final String FECHA_LIQUIDA = "fechaLiquida";
	private static final String FECHA_CORTE = "fechaCorte";
	private static final String FECHA_PAGO = "fechaPago";

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}

	@Override
	public JRDataSource getDatasourceReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("CaratulaCreditoGrupal - getDatasourceReport - INI");
		}
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Collection<CaratulaContratoCreditoDATABEAN> collection = new ArrayList<CaratulaContratoCreditoDATABEAN>();
		CaratulaContratoCreditoDATABEAN caratulaCreditoDATABEAN = new CaratulaContratoCreditoDATABEAN();
		Services services = new Services();
		
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getDatasourceReport - sessionId= " + sessionId);
				logger.logDebug("getDatasourceReport - application= " + application);
			}
			LoanInfResponse[] loanInfResponseList = services.getSearchCreditPaymentList(sessionId, application, serviceIntegration);
			List<CreditPaymentsDTO> paymentsList = CaratulaContractoCreditoIMPL.getCreditPaymentsList(loanInfResponseList);
			if (logger.isDebugEnabled()) {
				logger.logDebug("getDatasourceReport - paymentsList");
				logger.logDebug("getDatasourceReport - paymentsList: " + paymentsList);
			}
			caratulaCreditoDATABEAN.setListaPagos(paymentsList);

			collection.add(caratulaCreditoDATABEAN);

			if (logger.isDebugEnabled()) {
				logger.logDebug("getDatasourceReport -> collection: " + collection);
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud Caratula Credito Individual:", e);
			throw new RuntimeException(e);
		}

		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		initParamHeader(params);
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>RPT CaratulaCreditoIndividual - getParamsReport - INI");
		}
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
				LoanInfResponse[] loanInfResponseList = services.getCreditContractCover(sessionId, applicationCode, serviceIntegration);

				if (loanInfResponseList != null) {
					logger.logDebug("getParamsReport - response Commissions: " + loanInfResponseList[0].getCommissions());

					LoanInfResponse creditContractCoverResponse = loanInfResponseList[0];
					if (creditContractCoverResponse.getTotalAnnualCost() != null) {
						method.mapValuesToParams(COSTOANUALTOTAL, creditContractCoverResponse.getTotalAnnualCost().toString(), "");
					} else {
						params.put(COSTOANUALTOTAL, "");
					}

					if (creditContractCoverResponse.getAnnualInterestRate() != null) {
						method.mapValuesToParams(TASAINTERESANUAL, creditContractCoverResponse.getAnnualInterestRate().toString(), "");
					} else {
						params.put(TASAINTERESANUAL, "");
					}

					method.mapValuesToParams(MONTOCREDITO, Functions.getStringCurrencyFormated(creditContractCoverResponse.getCreditAmountDouble()), "");
					method.mapValuesToParams(MONTOTOTALPAGAR, Functions.getStringCurrencyFormated(creditContractCoverResponse.getTotalAmountPayableDouble()), "");
					method.mapValuesToParams(LISTACOMISIONES, creditContractCoverResponse.getCommissions(), "");
					method.mapValuesToParams(PORCENTAJEMORA, creditContractCoverResponse.getPercentageForDelay(), "");
					method.mapValuesToParams(PLAZOCREDITO, creditContractCoverResponse.getCrediTimeLimit(), "");
					method.mapValuesToParams(DESCRIP_MONEDA, creditContractCoverResponse.getCurrencyDesc(), "");
					method.mapValuesToParams(DESCRIP_PLAZO, creditContractCoverResponse.getTimeLimitDesc(), "");
					method.mapValuesToParams(FECHA_LIQUIDA, Functions.fechaN(creditContractCoverResponse.getDueDate()), "");
					method.mapValuesToParams(FECHA_PAGO, creditContractCoverResponse.getPaymentDate(), "");
					method.mapValuesToParams(FECHA_CORTE, creditContractCoverResponse.getProcessDate(), "");
					method.mapValuesToParams("seguro", "", "");
					method.mapValuesToParams("aseguradora", "", "");
					method.mapValuesToParams("contraAdhesion", "", "");
					
					String contraAdhesionS = "";
					String seguroS = "";
					
					String aseguradoraS = ""; 
					ParameterResponse aseguradora_pt1 = services.getParameter(4, "RGASE1", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse aseguradora_pt2 = services.getParameter(4, "RGASE2", Mnemonic.MODULE, serviceIntegration, sessionId);

					if (aseguradora_pt1 != null) {
						aseguradoraS = aseguradora_pt1.getParameterValue();//aseguradoraS.append(aseguradora_pt1.getParameterValue());
					}

					if (aseguradora_pt2 != null) {
						aseguradoraS = aseguradoraS + aseguradora_pt2.getParameterValue();
					}
					//method.mapValuesToParams("aseguradora", aseguradoraS.toString(), "");
					method.mapValuesToParams("aseguradora", aseguradoraS, "");									
					
					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					// ParameterResponse reca = services.getParameter(4, "RDRECA", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse reca = services.getParameter(4, "CRSIAO", Mnemonic.MODULE, serviceIntegration, sessionId); // caso#185412 igual a onboarding
					if (reca != null) {
						contraAdhesionS = reca.getParameterValue();
					}
					method.mapValuesToParams("contraAdhesion", contraAdhesionS, "");

					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					ParameterResponse seguro = services.getParameter(4, "RCGSG1", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse seguro2 = services.getParameter(4, "RCGSG2", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (seguro != null) {
						seguroS = seguro.getParameterValue();
					}
					if (seguro2 != null) {
						seguroS = seguroS + seguro2.getParameterValue();
					}
					//method.mapValuesToParams("seguro", seguroS, "");
					//method.mapValuesToParams("seguro", "(Opcional)", "");
					method.mapValuesToParams("seguro", "Obligatorio", "");
					
					String footParam = "";
					//ParameterResponse foot = services.getParameter(4, "REPCRI", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse foot = services.getParameter(4, "PRSIAO", Mnemonic.MODULE, serviceIntegration, sessionId); // caso#185412 igual a onboarding
					logger.logInfo("footParam ContratoCreditoInclusionIndividual " + foot.getParameterValue());
					if (foot != null) {
						footParam = foot.getParameterValue();
					}
					method.mapValuesToParams("footParam", footParam, "");							   
				}
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - CaratulaCreditoIndividual:", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		return getFileLocationReport(ConstantValue.JasperPath.CARAT_CREDIT_MAIN_IND_ONB); //porCaso#185412 igual al de onbarding
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.CARAT_CREDIT_MAIN_IND_ONB;
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
	}
}
