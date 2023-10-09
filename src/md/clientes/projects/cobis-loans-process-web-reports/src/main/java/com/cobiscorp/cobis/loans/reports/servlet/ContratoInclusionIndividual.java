package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionIndividualDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.dto.LoanGroupDetail;
import com.cobiscorp.cobis.loans.reports.impl.ContratoCreditoInclusionIndividualListIMPL;
import com.cobiscorp.designer.api.util.ServerParamUtil;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfoApplicationResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "contratoCredSimpleIndividualAutoOnboard") })
public class ContratoInclusionIndividual implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(ContratoInclusionIndividual.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> arg0) {
		Collection<SolicitudCreditoGrupalDATABEAN> collection = new ArrayList<SolicitudCreditoGrupalDATABEAN>();
		try {
			SolicitudCreditoGrupalDATABEAN solicitudCreditoGrupalDATABEAN = new SolicitudCreditoGrupalDATABEAN();
			List<LoanGroupDetail> grp = new ArrayList<LoanGroupDetail>();
			solicitudCreditoGrupalDATABEAN.setLoanGroupDetail(grp);

			logger.logInfo("*****>>Reporte - ContratoCreditoInclusion Individual-Credito Simple Individual:");
			// Credito Individual-Inclusion Individual
			String sessionId = (String) arg0.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) arg0.get(ConstantValue.Params.APPLICATION);
			int applicationIn = 0;
			applicationIn = Integer.parseInt(application);
			Services services = new Services();
			logger.logError("*****>>Sub Reporte - ContratoCreditoRevolvente idTramite:" + applicationIn);

			// Contiene la Lista
			ContratoCreditoInclusionIndividualListIMPL cciListIndIMPL = new ContratoCreditoInclusionIndividualListIMPL();

			// Contiene la Lista de detalle
			List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> cciDetallePrincipalDTO = new ArrayList<ContratoCreditoInclusionIndividualDetallePrincipalDTO>();
			logger.logError("*****>>Reporte - ContratoCreditoRevolvente idTramite:" + applicationIn);

			LoanInfoApplicationResponse[] reportResponseList = services.getApplicationInfo(sessionId, 'E', applicationIn, 0, serviceIntegration);

			cciDetallePrincipalDTO = cciListIndIMPL.getDetallePrincipal(reportResponseList, sessionId, serviceIntegration);

			// Contrato
			solicitudCreditoGrupalDATABEAN.setContratoCreditoInclusionIndividualDetallePrincipal(cciDetallePrincipalDTO);

			// InformacionPrevia
			List<ContratoCreditoInclusionClausulaDTO> infoPrevia = new ArrayList<ContratoCreditoInclusionClausulaDTO>();
			infoPrevia = cciListIndIMPL.getClausula(sessionId, serviceIntegration); // Solo para que se visualice el texto
			solicitudCreditoGrupalDATABEAN.setContratoCreditoInclusionIndividualInfoPrevia(infoPrevia);

			// AnexoLegal
			List<ContratoCreditoInclusionClausulaDTO> anexoLegal = new ArrayList<ContratoCreditoInclusionClausulaDTO>();
			anexoLegal = cciListIndIMPL.getClausula(sessionId, serviceIntegration); // Solo para que se visualice el texto
			solicitudCreditoGrupalDATABEAN.setContratoCreditoInclusionIndividualAnexoLegal(anexoLegal);

			collection.add(solicitudCreditoGrupalDATABEAN);
		} catch (Exception e) {
			logger.logError("Error en Contrato Inclusion: ", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logInfo("Obtiene parametros para reporte Solicitud de Credito Grupal");

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->params: " + params);
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) params.get(ConstantValue.Params.APPLICATION);
			Services services = new Services();
			Method method = new Method();

			method.setPrmMain(params);
			if (application != null && sessionId != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				Map<String, Object> responseDebtor = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.DEBTOR, serviceIntegration);
				LoanCustomerResponse[] personalDataL = (LoanCustomerResponse[]) responseDebtor.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);
				LoanCustomerResponse personalData = personalDataL[0];
				if (logger.isDebugEnabled()) {
					logger.logDebug("response informacion de credito: " + loanData);
				}
				if (loanData != null) {
					method.mapValuesToParams("officeAddress", loanData.getOfficeAddress(), "");
					method.mapValuesToParams("city", loanData.getCityTr(), "");
					method.mapValuesToParams("date",
							Functions.changeStringDateFormat(ServerParamUtil.getProcessDate(), ConstantValue.valueConstant.DF_MMDDYYYY, ConstantValue.valueConstant.DF_DDMMYYYY),
							"");
					method.mapValuesToParams("representative", loanData.getRepresentative(), "");
					method.mapValuesToParams("amount", loanData.getAmount().toString(), "");
					method.mapValuesToParams("letterAmount", loanData.getLetterAmount(), "");
					method.mapValuesToParams("customerName", personalData.getCustomerName(), "");
					method.mapValuesToParams("account", personalData.getAccountNumber(), "");

					if (logger.isDebugEnabled()) {
						logger.logDebug("params Contrato de Inclusion: " + params);
					}
				}

				// texto condusef -- este parametro tambien se usa en Caratula Contrato Credito
				String condusef = "";
				//ParameterResponse recaParrafo = services.getParameter(4, "RDRECA", Mnemonic.MODULE, serviceIntegration, sessionId);
				ParameterResponse recaParrafo = services.getParameter(4, "CRSIAO", Mnemonic.MODULE, serviceIntegration, sessionId); //porCaso#185412 igual al de onbarding
				logger.logInfo("paramRECAParrafo ContratoCreditoInclusion " + recaParrafo);
				if (recaParrafo != null) {
					condusef = recaParrafo.getParameterValue();
				}
				method.mapValuesToParams("condusef", condusef, "");

				String footParam = "";
				//ParameterResponse foot = services.getParameter(4, "REPCRI", Mnemonic.MODULE, serviceIntegration, sessionId);
				ParameterResponse foot = services.getParameter(4, "PCTSIO", Mnemonic.MODULE, serviceIntegration, sessionId); //porCaso#185412 igual al de onbarding
				logger.logInfo("footParam ContratoCreditoInclusionIndividual " + foot.getParameterValue());
				if (foot != null) {
					footParam = foot.getParameterValue();
				}
				method.mapValuesToParams("footParam", footParam, "");

//			    select @w_condusef = (select pa_char from cobis..cl_parametro where pa_nemonico ='CRSIAO')
	//		    select @w_pie_pagina = (select pa_char from cobis..cl_parametro where pa_nemonico ='PCTSIO')				
				
				
				// firmas
				params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
				params.put("firmaNF1CCI", ConstantValue.Params.URLIMAG_firmaNF1CCI);
				params.put("firmaNF2CCI", ConstantValue.Params.URLIMAG_firmaNF2CCI);
				params.put("firmaNB1CCI", ConstantValue.Params.URLIMAG_firmaNB1CCI);
				params.put("firmaNB2CCI", ConstantValue.Params.URLIMAG_firmaNB2CCI);
			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Contrato de Inclusion:", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return ConstantValue.JasperPath.CONTRATO_INCLUSION_INDIVIDUAL_ONB; //porCaso#185412 igual al de onbarding
	}
}
