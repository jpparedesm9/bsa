package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.ParameterService;
import com.cobiscorp.ecobis.cloud.service.dto.parameters.ConfigParameter;
import com.cobiscorp.ecobis.cloud.service.integration.BankingProductIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.ParameterIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

@Path("/cobis-cloud/mobile/parameters")
@Component
@Service({ ParameterService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class ParameterServiceRest implements ParameterService {

	private final ILogger logger = LogFactory.getLogger(ParameterServiceRest.class);

	private ParameterIntegrationService parameterService;
	private BankingProductIntegrationService bankingProductIntegrationService;

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getParameters() {
		try {
			logger.logInfo("/cobis-cloud/mobile/parameters");
			ServiceResponse response = new ServiceResponse();

			ParameterSearchResponse mdeResponse = parameterService.searchParameter("MDE", "ADM");
			ParameterSearchResponse emaxResponse = parameterService.searchParameter("EMAX", "CLI");
			ParameterSearchResponse dismaxResponse = parameterService.searchParameter("DISMAX", "CLI");
			ParameterSearchResponse intMinResponse = parameterService.searchParameter("MINIGR", "CLI");

			// ELAVON
			ParameterSearchResponse companyElavon = parameterService.searchParameter("ELACOM", "CLI");
			ParameterSearchResponse branchElavon = parameterService.searchParameter("ELABRN", "CLI");
			ParameterSearchResponse countryElavon = parameterService.searchParameter("ELACON", "CLI");
			ParameterSearchResponse userElavon = parameterService.searchParameter("ELAUSR", "CLI");
			ParameterSearchResponse passwordElavon = parameterService.searchParameter("ELAPWD", "CLI");
			ParameterSearchResponse urlElavon = parameterService.searchParameter("ELAURL", "CLI");
			ParameterSearchResponse businessEmailElavon = parameterService.searchParameter("ELAEMA", "CLI");
			ParameterSearchResponse merchantCashPayment = parameterService.searchParameter("ELAMCP", "CLI");
			ParameterSearchResponse merchantThreeMonthPayment = parameterService.searchParameter("ELAM3M", "CLI");
			ParameterSearchResponse merchantSixMonthPayment = parameterService.searchParameter("ELAM6M", "CLI");
			ParameterSearchResponse environmentElavon = parameterService.searchParameter("ELAENV", "CLI");

			// COLECTIVOS
			ParameterSearchResponse minMonthSalesCollective = parameterService.searchParameter("VENMIN", "CLI");
			ParameterSearchResponse maxMonthSalesCollective = parameterService.searchParameter("VENMAX", "CLI");

			// BIOMETRICOS
			ParameterSearchResponse renapo = parameterService.searchParameter("RENAPO", "CLI");

			// LCR V2.0
			ParameterSearchResponse defaultCollective = parameterService.searchParameter("CDDFCL", "CLI");
			ParameterSearchResponse defaultCollectiveLevel = parameterService.searchParameter("CDDFNC", "CLI");
			
			// Credito Simple
			ParameterSearchResponse defaultFrequencyTermInd = parameterService.searchParameter("FPDIND", "CRE");
			
			// Crédito Grupal Digital
			ParameterSearchResponse grupalMinAge = parameterService.searchParameter("EMING", "CRE");
			ParameterSearchResponse grupalMaxAge = parameterService.searchParameter("EMAXG", "CRE");
			ParameterSearchResponse grupalMinAmount = parameterService.searchParameter("MMING", "CRE");
			ParameterSearchResponse grupalMaxAmount = parameterService.searchParameter("MMAXG", "CRE");
			ParameterSearchResponse grupalFrequency1 = parameterService.searchParameter("FRQ1G", "CRE");
			ParameterSearchResponse grupalFrequency2 = parameterService.searchParameter("FRQ2G", "CRE");
			ParameterSearchResponse grupalMinIncome = parameterService.searchParameter("IMING", "CRE");
			ParameterSearchResponse grupalMinTerm = parameterService.searchParameter("PMING", "CRE");
			ParameterSearchResponse grupalRate = parameterService.searchParameter("TASAG", "CRE");
			ParameterSearchResponse grupalCommission = parameterService.searchParameter("CMATG", "CRE");
			ParameterSearchResponse grupalCAT = parameterService.searchParameter("CATVL", "CRE");
			ParameterSearchResponse grupalPromo = parameterService.searchParameter("VTSPRO", "CCA");
			ParameterSearchResponse grupalNoPromo = parameterService.searchParameter("VTNPRO", "CCA");
			
			//VALIDACION DE NUMERO Y CORREO
			ParameterSearchResponse validarMail = parameterService.searchParameter("VAMAIL", "CLI");
			ParameterSearchResponse validarSMS = parameterService.searchParameter("VASMS", "CLI");

			// OFERTA PRODUCTO
			List<GeneralParametersValuesHistory> terms = bankingProductIntegrationService.getCatalogGeneralParameter("GRUPAL", "Plazo");
			List<GeneralParametersValuesHistory> displacements = bankingProductIntegrationService.getCatalogGeneralParameter("GRUPAL", "Gracia");

			logger.logDebug("/cobis-cloud/mobile/parameters MDE" + mdeResponse.getTinyintValue());
			logger.logDebug("/cobis-cloud/mobile/parameters EMAX" + emaxResponse.getTinyintValue());
			logger.logDebug("/cobis-cloud/mobile/parameters DISMAX" + dismaxResponse.getIntValue());
			logger.logDebug("/cobis-cloud/mobile/parameters MINIGR" + intMinResponse.getIntValue());
			logger.logDebug("/cobis-cloud/mobile/parameters CDDFCL" + defaultCollective.getIntValue());
			logger.logDebug("/cobis-cloud/mobile/parameters CDDFNC" + defaultCollectiveLevel.getIntValue());
			

			ArrayList<ConfigParameter> parameters = new ArrayList<ConfigParameter>();

			ConfigParameter parameter = new ConfigParameter();
			parameter.setKey("MIN_AGE");// DISTANCE - LIMIT
			parameter.setValue("" + mdeResponse.getTinyintValue()); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("MAX_AGE");// MIN - AGE
			parameter.setValue("" + emaxResponse.getTinyintValue());

			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ALLOWEDDISTANCE");// MAX - AGE
			parameter.setValue("" + dismaxResponse.getIntValue());

			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("MIN_MEMBER");// MIN - INTEGRANTES DEL GRUPO
			parameter.setValue("" + intMinResponse.getIntValue());

			parameters.add(parameter);

			// ELAVON
			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_COMPANY");// Elavon Company
			parameter.setValue(companyElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_BRANCH");// Elavon Branch
			parameter.setValue(branchElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_COUNTRY");// Elavon Country
			parameter.setValue(countryElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_USER");// Elavon User
			parameter.setValue(userElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_PWD");// Elavon Password
			parameter.setValue(passwordElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_URL");// Elavon URL
			parameter.setValue(urlElavon.getCharValue()); 
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_BUSINESS_EMAIL");// Elavon Business Email
			parameter.setValue(businessEmailElavon.getCharValue()); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_MERCHANT_CASH_PAY");// Elavon Afiliación Contado
			parameter.setValue(merchantCashPayment.getCharValue()); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_MERCHANT_3MONTH_PAY");// Elavon Afiliación 3 meses
			parameter.setValue(merchantSixMonthPayment.getCharValue()); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_MERCHANT_6MONTH_PAY");// Elavon Afiliación 6 meses
			parameter.setValue(merchantThreeMonthPayment.getCharValue()); //
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("ELAVON_ENVIRONMENT");// Elavon Ambiente
			parameter.setValue(environmentElavon.getCharValue()); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("MIN_MONTH_SALES_COL");// Ventas Mínimas Mensuales Colectivos
			parameter.setValue(minMonthSalesCollective.getMoneyValue() == null ? "" : String.valueOf(minMonthSalesCollective.getMoneyValue().doubleValue())); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("MAX_MONTH_SALES_COL");// Ventas Máximas Mensuales Colectivos
			parameter.setValue(maxMonthSalesCollective.getMoneyValue() == null ? "" : String.valueOf(maxMonthSalesCollective.getMoneyValue().doubleValue())); //
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("RENAPO");// RENAPO
			parameter.setValue(renapo.getCharValue()); //
			parameters.add(parameter);

			for (GeneralParametersValuesHistory generalParametersValuesHistory : terms) {
				logger.logDebug("term value:" + generalParametersValuesHistory.getValue());
				parameter = new ConfigParameter();
				parameter.setKey("GRUPAL_TERM");// PLAZO GRUPAL
				parameter.setValue(generalParametersValuesHistory.getValue()); //
				parameters.add(parameter);

			}

			for (GeneralParametersValuesHistory generalParametersValuesHistory : displacements) {
				logger.logDebug("displacement value:" + generalParametersValuesHistory.getValue());
				parameter = new ConfigParameter();
				parameter.setKey("GRUPAL_DISPLACEMENT");// DESPLAZAMIENTO GRUPAL
				parameter.setValue(generalParametersValuesHistory.getValue()); //
				parameters.add(parameter);

			}
			
			parameter = new ConfigParameter();
			parameter.setKey("DEFAULT_COLLECTIVE");// COLECTIVO POR DEFECTO
			parameter.setValue(defaultCollective.getCharValue()); //
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DEFAULT_COLLECTIVE_LEVEL");// NIVEL COLECTIVO POR DEFECTO
			parameter.setValue(defaultCollectiveLevel.getCharValue()); //
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DEFAULT_FREQUENCY_TERM_IND");// PARAMETRO POR DEFECTO PARA CREDITO SIMPLE
			parameter.setValue(defaultFrequencyTermInd.getCharValue());
			parameters.add(parameter);
			
			
			// Crédito Grupal Digital
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MIN_AGE");
			parameter.setValue(String.valueOf(grupalMinAge.getIntValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MAX_AGE");
			parameter.setValue(String.valueOf(grupalMaxAge.getIntValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MIN_AMOUNT");
			parameter.setValue(String.valueOf(grupalMinAmount.getMoneyValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MAX_AMOUNT");
			parameter.setValue(String.valueOf(grupalMaxAmount.getMoneyValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_FREQUENCY_1");
			parameter.setValue(grupalFrequency1.getCharValue());
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_FREQUENCY_2");
			parameter.setValue(grupalFrequency2.getCharValue());
			parameters.add(parameter);

			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MIN_INCOME");
			parameter.setValue(String.valueOf(grupalMinIncome.getMoneyValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_MIN_TERM");
			parameter.setValue(String.valueOf(grupalMinTerm.getIntValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_RATE");
			parameter.setValue(String.valueOf(grupalRate.getFloatValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_COMMISSION");
			parameter.setValue(String.valueOf(grupalCommission.getFloatValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_GRUPAL_CAT");
			parameter.setValue(String.valueOf(grupalCAT.getFloatValue()));
			parameters.add(parameter);
			
			
			parameter = new ConfigParameter();
			parameter.setKey("GRUPAL_PROMO");
			parameter.setValue(String.valueOf(grupalPromo.getFloatValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("GRUPAL_NO_PROMO");
			parameter.setValue(String.valueOf(grupalNoPromo.getFloatValue()));
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_VALIDATE_EMAIL");
			parameter.setValue(validarMail.getCharValue());
			parameters.add(parameter);
			
			parameter = new ConfigParameter();
			parameter.setKey("DIGITAL_VALIDATE_PHONE");
			parameter.setValue(validarSMS.getCharValue());
			parameters.add(parameter);
			
			response.setResult(true);
			response.setData(parameters);

			return successResponse(response, true, "/cobis-cloud/mobile/parameters");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/parameters  Error al consultar parámetros", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/parameters Error al consultar parámetros", e);
			return errorResponse("/cobis-cloud/mobile/parameters Error al consultar parámetros");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.parameterService = new ParameterIntegrationService(serviceIntegration);
		this.bankingProductIntegrationService = new BankingProductIntegrationService(serviceIntegration);

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.parameterService = new ParameterIntegrationService(serviceIntegration);
		this.bankingProductIntegrationService = new BankingProductIntegrationService(serviceIntegration);
	}

}
