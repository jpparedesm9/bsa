package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.dataBean.ConsentOfSegurityDATABEAN;
import com.cobiscorp.cobis.loans.reports.dataBean.ConsentSecurityBasicDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsDeclareDTO;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsInformationTableDTO;
import com.cobiscorp.cobis.loans.reports.dto.InformationHeadLineDTO;
import com.cobiscorp.cobis.loans.reports.services.ConsultingClientTeamServices;
import com.cobiscorp.cobis.loans.reports.services.SecureConsentService;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ClientInformationBenefisResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeBenefitsResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeResponse;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "SecureConsentGru") })
public class SecureConsentServletGru implements ICOBISReportResourcesService<JRBeanCollectionDataSource>, AssembleDataBean {

	private static final ILogger logger = LogFactory.getLogger(SecureConsentServletGru.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public String getReportLocation(Map<String, Object> params) {
		return getFileLocationReport(ConstantValue.JasperPath.PATH_SECURE_CONSENT_PRU_GRU);
	}

	private String getFileLocationReport(String jasperFile) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("LINE 51>>>>>jasperFile" + jasperFile);
		}
		return ConstantValue.JasperPath.PATH_SECURE_CONSENT_PRU_GRU;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> params) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Boolean controlReportGeneration(Map<String, Object> params) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logError("----->>>> Reporte getDatasourceReport consentimiento seguro gr");
				logger.logDebug("START getDatasourceReport SECURECONSENTSERVLET gr");
			}

			// String application = (String) params.get(ConstantValue.Params.APPLICATION);
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String identificationclient = (String) params.get(ConstantValue.valueConstant.IDENTIFICATIONCLIENT);
			String idTramite = (String) params.get(ConstantValue.Params.APPLICATION);

			String reportNemonic = (String) params.get(ConstantValue.Params.REPORTNEMONIC);
			String operation = ConstantValue.valueConstant.CERCONIND.equals(reportNemonic) ? "C" : ConstantValue.valueConstant.CONSTANT_I;

			if (logger.isDebugEnabled()) {
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>>sessionId:" + sessionId);
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>>identificationclient:" + identificationclient);
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>idTramite:" + idTramite);
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>>reportNemonic:" + reportNemonic);
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>>operation:" + operation);
			}

			List<ConsentSecurityBasicDATABEAN> jasperDataBeanList = new ArrayList<ConsentSecurityBasicDATABEAN>();
			for (String clientReport : consultingClient(idTramite, sessionId)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>Cliente: " + clientReport);
				}
				// consulta la informacion del titular
				ClientSafeResponse[] responseHeadLine = new SecureConsentService().queryInformationHeadLine(clientReport, idTramite, operation, sessionId, serviceIntegration);
				String name = "";
				String cobertura = "";
				String fechaContraAsis = "";
				String fechaFinVig = "";
				String eventoMedEsp = "";
				String eventoCheckUps = "";
				String eventoServDent = "";
				String lineaEmbarazo = "";
				String lineaDiabetes = "";
				String lineaViolencia = "";
				if (responseHeadLine != null && responseHeadLine.length > 0) {
					for (ClientSafeResponse clientInformationHeadLine : responseHeadLine) {
						name = name + " " + clientInformationHeadLine.getFullname();
						cobertura = clientInformationHeadLine.getCoverage();
						fechaContraAsis = clientInformationHeadLine.getIniDate();
						fechaFinVig = clientInformationHeadLine.getFinalDate();
						eventoMedEsp = clientInformationHeadLine.getMedicServ();
						eventoCheckUps = clientInformationHeadLine.getCheckupServ();
						eventoServDent = clientInformationHeadLine.getDentalServ();
						lineaEmbarazo = clientInformationHeadLine.getPregnancyLine();
						lineaDiabetes = clientInformationHeadLine.getDiabetesLine();
						lineaViolencia = clientInformationHeadLine.getViolenceLine();
					}
				}
				List<InformationHeadLineDTO> dataJasperHedLine = jasperDatabeanHedLine(responseHeadLine);

				// consulta de declaracion de beneficios
				List<BenefitsDeclareDTO> dataJasperDeclareBenefits = jasperDatabeanSafeBenefits(clientReport, sessionId);
				// informacion de cobertura
				List<BenefitsInformationTableDTO> dataJasperInformationTable = jasperDatabeanInformaBenefits(clientReport, sessionId);

				// almaceno datos del cliente
				ConsentOfSegurityDATABEAN consentOfSegurityDatabean = new ConsentOfSegurityDATABEAN();
				consentOfSegurityDatabean.setListInformationHeadLine(dataJasperHedLine);
				consentOfSegurityDatabean.setListBenefitsDeclare(dataJasperDeclareBenefits);
				consentOfSegurityDatabean.setListBenefitsInformationTable(dataJasperInformationTable);
				consentOfSegurityDatabean.setFullNameP(name);
				consentOfSegurityDatabean.setCobertura(cobertura);
				consentOfSegurityDatabean.setFechaContraAsis(fechaContraAsis);
				consentOfSegurityDatabean.setFechaFinVig(fechaFinVig);
				consentOfSegurityDatabean.setEventoMedEsp(eventoMedEsp);
				consentOfSegurityDatabean.setEventoCheckUps(eventoCheckUps);
				consentOfSegurityDatabean.setEventoServDent(eventoServDent);
				consentOfSegurityDatabean.setLineaEmbarazo(lineaEmbarazo);
				consentOfSegurityDatabean.setLineaDiabetes(lineaDiabetes);
				consentOfSegurityDatabean.setLineaViolencia(lineaViolencia);

				List<ConsentOfSegurityDATABEAN> listClientReport = new ArrayList<ConsentOfSegurityDATABEAN>();
				listClientReport.add(consentOfSegurityDatabean);
				// almaceno cada objeto del cliente
				ConsentSecurityBasicDATABEAN clientOfSecurityBasic = new ConsentSecurityBasicDATABEAN();
				clientOfSecurityBasic.setListConsentSecurityBasic(listClientReport);

				jasperDataBeanList.add(clientOfSecurityBasic);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>TOTAL register basic" + jasperDataBeanList.size());
			}
			if (jasperDataBeanList.isEmpty()) {
				jasperDataBeanList.add(returnDataEmptyReport());
				logger.logDebug("SecureConsentServlet gr-getDatasourceReport>>>>Register Empty" + jasperDataBeanList.size());
				return new JRBeanCollectionDataSource(jasperDataBeanList, false);
			}
			return new JRBeanCollectionDataSource(jasperDataBeanList, false);
		} catch (Exception e) {
			logger.logError("----->>>> Error Reporte SecureConsentServlet gr-getDatasourceReport>>>>:", e);
			throw new RuntimeException(e);
		}

	}

	/**
	 * datasource Empty report
	 * 
	 * @return ConsentSecurityfullDATABEAN
	 */
	public ConsentSecurityBasicDATABEAN returnDataEmptyReport() {
		// almaceno datos del cliente
		ConsentOfSegurityDATABEAN consentOfSegurityDatabeanEmpty = new ConsentOfSegurityDATABEAN();
		consentOfSegurityDatabeanEmpty.setListInformationHeadLine(new ArrayList<InformationHeadLineDTO>());
		consentOfSegurityDatabeanEmpty.setListBenefitsDeclare(new ArrayList<BenefitsDeclareDTO>());
		consentOfSegurityDatabeanEmpty.setListBenefitsInformationTable(new ArrayList<BenefitsInformationTableDTO>());

		List<ConsentOfSegurityDATABEAN> listClientReportEmpty = new ArrayList<ConsentOfSegurityDATABEAN>();
		listClientReportEmpty.add(consentOfSegurityDatabeanEmpty);
		// almaceno cada objeto del cliente
		ConsentSecurityBasicDATABEAN clientOfSecurityBasic = new ConsentSecurityBasicDATABEAN();
		clientOfSecurityBasic.setListConsentSecurityBasic(listClientReportEmpty);
		return clientOfSecurityBasic;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("----->>>> SecureConsentServletGru -getParamsReport ");
		Method method = new Method();
		method.setPrmMain(params);
		try {
			params.put("urlPathWhatsapp", ConstantValue.Params.URLIMAG_WHATSAPP);
		} catch (Exception e) {
			logger.logDebug("Error SecureConsentServletGru -getParamsReport:", e);
			throw new RuntimeException("Error: SecureConsentServletGru -getParamsReport", e);
		}

		return params;
	}

	@Override
	public List<String> consultingClient(String idProcess, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-consultingClient>>>>consultingClient");
		List<String> clientsOfTeam = new ArrayList<String>();
		ConsultingClientTeamResponse[] response = new ConsultingClientTeamServices().consultingClientOfteams(idProcess, sessionId, serviceIntegration);
		for (ConsultingClientTeamResponse consultingClientTeamResponse : response) {
			if (consultingClientTeamResponse.getTypeSecure() != null && (ConstantValue.valueConstant.EXTENDIDO).equals(consultingClientTeamResponse.getTypeSecure()))
				clientsOfTeam.add(String.valueOf(consultingClientTeamResponse.getIdclient()));
		}
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-consultingClient>>>>clientsOfTeam:size():" + clientsOfTeam.size());

		return clientsOfTeam;
	}

	@Override
	public List<InformationHeadLineDTO> jasperDatabeanHedLine(ClientSafeResponse[] responseHeadLine) {
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-jasperDatabeanHedLine>>>>START jasperDatabeanHedLine ");

		List<InformationHeadLineDTO> listInformationHeadLine = new ArrayList<InformationHeadLineDTO>();

		if (responseHeadLine != null && responseHeadLine.length > 0) {
			for (ClientSafeResponse clientInformationHeadLine : responseHeadLine) {
				InformationHeadLineDTO headLineDTO = new InformationHeadLineDTO();
				headLineDTO.setBirthDate(clientInformationHeadLine.getBirthDate());
				headLineDTO.setFullName(clientInformationHeadLine.getFullname());
				listInformationHeadLine.add(headLineDTO);
			}
			return listInformationHeadLine;
		}
		return new ArrayList<InformationHeadLineDTO>();
	}

	@Override
	public List<BenefitsDeclareDTO> jasperDatabeanSafeBenefits(String identificationclient, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-jasperDatabeanSafeBenefits>>>>START jasperDatabeanSafeBenefits ");
		List<BenefitsDeclareDTO> listBenefitsDeclare = new ArrayList<BenefitsDeclareDTO>();
		ClientSafeBenefitsResponse[] responseDeclaration = new SecureConsentService().queryConsultinginDeclareBenefits(identificationclient, sessionId, serviceIntegration);
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-jasperDatabeanSafeBenefits>>>>responseDeclaration.lengh:" + responseDeclaration.length);

		if (responseDeclaration != null && responseDeclaration.length > 0) {
			for (ClientSafeBenefitsResponse clientSafeBenefits : responseDeclaration) {
				BenefitsDeclareDTO benefitsDeclareDTO = new BenefitsDeclareDTO();
				benefitsDeclareDTO.setFullNameBenefits(clientSafeBenefits.getFullname());
				benefitsDeclareDTO.setRelationshipBenefits(clientSafeBenefits.getRelationship());
				benefitsDeclareDTO.setBirthdateBenefits(clientSafeBenefits.getBirthDate());
				benefitsDeclareDTO.setPercentageBenefits(clientSafeBenefits.getPorcentage());
				benefitsDeclareDTO.setTotalPorcentage("0.0");
				listBenefitsDeclare.add(benefitsDeclareDTO);
			}
			return listBenefitsDeclare;
		}
		return new ArrayList<BenefitsDeclareDTO>();

	}

	@Override
	public List<BenefitsInformationTableDTO> jasperDatabeanInformaBenefits(String identificationclient, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>>>START jasperDatabeanInformaBenefits ");

		List<BenefitsInformationTableDTO> listBenefitsInformationTable = new ArrayList<BenefitsInformationTableDTO>();
		ClientInformationBenefisResponse[] responseinformationBenefits = new SecureConsentService().queryConsultinginSecureBenefits(identificationclient, sessionId,
				serviceIntegration);
		if (logger.isDebugEnabled())
			logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>responseinformationBenefits.lengh:" + responseinformationBenefits.length);

		if (responseinformationBenefits != null && responseinformationBenefits.length > 0) {
			for (ClientInformationBenefisResponse clientInformationBenefits : responseinformationBenefits) {
				BenefitsInformationTableDTO benefitsInformationTableDTO = new BenefitsInformationTableDTO();
				benefitsInformationTableDTO.setCoverageBenefitstable(clientInformationBenefits.getCoverage());
				benefitsInformationTableDTO.setTitleBenefitstable(clientInformationBenefits.getTitle());
				benefitsInformationTableDTO.setPairBenefitstable(clientInformationBenefits.getPair());
				benefitsInformationTableDTO.setSonBenefitstable(clientInformationBenefits.getSon());
				benefitsInformationTableDTO.setColorBenefitsTable((listBenefitsInformationTable.size() % 2 != 0) ? true : false);
				if (logger.isDebugEnabled()) {
					logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>1:" + listBenefitsInformationTable.size());
					logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>2:" + (listBenefitsInformationTable.size() % 2 != 0));
					logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>3:" + benefitsInformationTableDTO.isColorBenefitsTable());
				}
				listBenefitsInformationTable.add(benefitsInformationTableDTO);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("SecureConsentServlet-jasperDatabeanInformaBenefits>>>>listBenefitsInformationTable.size:" + listBenefitsInformationTable.size());
			}

			return listBenefitsInformationTable;
		}
		return new ArrayList<BenefitsInformationTableDTO>();

	}

}
