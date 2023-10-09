package com.cobiscorp.cobis.loans.reports.servlet;

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
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.CaratulaCreditoGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;
import com.cobiscorp.cobis.loans.reports.impl.CaratulaCreditoGrupalIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "caratulaCreditoGrupal") })
public class CaratulaCreditoGrupal implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(CaratulaCreditoGrupal.class);
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
	private static final String GRACIA = "gracia";

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
						method.mapValuesToParams(COSTOANUALTOTAL, groupCreditCoverResponse.getTotalAnnualCost().toString(), "");
					} else {
						params.put(COSTOANUALTOTAL, "");
					}

					if (groupCreditCoverResponse.getAnnualInterestRate() != null) {
						method.mapValuesToParams(TASAINTERESANUAL, groupCreditCoverResponse.getAnnualInterestRate().toString(), "");
					} else {
						params.put(TASAINTERESANUAL, "");
					}

					method.mapValuesToParams(MONTOCREDITO, groupCreditCoverResponse.getCreditAmount(), "");
					if (logger.isDebugEnabled()) {
						logger.logDebug("getParamsReport - CreditAmount= " + groupCreditCoverResponse.getCreditAmount());
					}
					logger.logDebug("PMO displacement CaratulaCreditoGrupal: " + groupCreditCoverResponse.getDisplacement());
					method.mapValuesToParams(MONTOTOTALPAGAR, groupCreditCoverResponse.getTotalAmountPayable(), "");
					method.mapValuesToParams(LISTACOMISIONES, groupCreditCoverResponse.getCommissions(), "");
					method.mapValuesToParams(PORCENTAJEMORA, groupCreditCoverResponse.getPercentageForDelay(), "");
					method.mapValuesToParams(PLAZOCREDITO, groupCreditCoverResponse.getCrediTimeLimit(), "");
					method.mapValuesToParams(DESCRIP_MONEDA, groupCreditCoverResponse.getCurrencyDesc(), "");
					method.mapValuesToParams(DESCRIP_PLAZO, groupCreditCoverResponse.getTimeLimitDesc(), "");
					method.mapValuesToParams(FECHA_PAGO, groupCreditCoverResponse.getPaymentDate(), "");
					method.mapValuesToParams(FECHA_CORTE, groupCreditCoverResponse.getProcessDate(), "");
					method.mapValuesToParams(GRACIA, groupCreditCoverResponse.getDisplacement(), "");
					
					// method.mapValuesToParams(FECHA_LIQUIDA, groupCreditCoverResponse.getDueDate(), "");

					StringBuilder aseguradoraS = new StringBuilder();
					String contraAdhesionS = "";
					String seguroS = "";
					ParameterResponse aseguradora_pt1 = services.getParameter(4, "RGASE1", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse aseguradora_pt2 = services.getParameter(4, "RGASE2", Mnemonic.MODULE, serviceIntegration, sessionId);

					if (aseguradora_pt1 != null) {
						aseguradoraS.append(aseguradora_pt1.getParameterValue());
					}

					if (aseguradora_pt2 != null) {
						aseguradoraS.append(aseguradora_pt2.getParameterValue());
					}
					
					method.mapValuesToParams("aseguradora", aseguradoraS.toString(), "");


					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					String paramRECA = "";
					int gracia = groupCreditCoverResponse.getDisplacement() == null ? 0 : Integer.valueOf(groupCreditCoverResponse.getDisplacement());

					if (gracia > 0) {
						paramRECA = "RDRECA";
					} else {
						paramRECA = "RECASG";
					}
					
					logger.logInfo("PMO paramRECA CaratulaCreditoGrupal " + paramRECA);
					ParameterResponse reca = services.getParameter(4, paramRECA, Mnemonic.MODULE, serviceIntegration, sessionId);
						contraAdhesionS = reca.getParameterValue();

					method.mapValuesToParams("contraAdhesion", contraAdhesionS, "");
					
					// Pie de pagina -- PIE PERIODO REPORTES en SolicitudCreditoRevolventeIMPL, ContratoCreditoinclusion, 
					ParameterResponse pieAnio = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (pieAnio != null) {
						method.mapValuesToParams("pieAnio", pieAnio.getParameterValue(), "");
					}

					// Nombre Solicitud - dirección, telefono
					ParameterResponse porCovit = services.getParameter(4, "DESCUO", Mnemonic.MODULECCA, serviceIntegration, sessionId);
					method.mapValuesToParams("porCovit", "N", "");					
					if (porCovit != null) {
						// porCovit = S (muestra titulo por covit) o N (muestra titulo normal)
						method.mapValuesToParams("porCovit", porCovit.getParameterValue().trim(), "");
					}

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
					
					method.mapValuesToParams("nombreComercProd", groupCreditCoverResponse.getProductTradeName(), "");

				}
				if (logger.isDebugEnabled()) {
					logger.logDebug("params CaratulaCreditoGrupal: " + params);
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
		return getFileLocationReport(ConstantValue.JasperPath.CARAT_CREDIT_MAIN);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.CARAT_CREDIT_MAIN;
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
		params.put(GRACIA, "");

	}
}