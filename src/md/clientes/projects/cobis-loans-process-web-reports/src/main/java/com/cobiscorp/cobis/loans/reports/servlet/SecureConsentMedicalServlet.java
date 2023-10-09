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
import com.cobiscorp.cobis.loans.reports.dataBean.ConsentOfSegurityMedicalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dataBean.ConsentSecurityfullDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsDeclareDTO;
import com.cobiscorp.cobis.loans.reports.dto.BenefitsInformationTableDTO;
import com.cobiscorp.cobis.loans.reports.dto.InformationHeadLineDTO;
import com.cobiscorp.cobis.loans.reports.services.ConsultingClientTeamServices;
import com.cobiscorp.cobis.loans.reports.services.SecureConsentMedicalService;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ClientInformationBenefisResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeBenefitsResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeResponse;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "SecureConsentMedical") })
public class SecureConsentMedicalServlet implements ICOBISReportResourcesService<JRBeanCollectionDataSource>, AssembleMedicalDataBean {
	private static final String CLASSEXEUTE = "SecureConsentMedicalServlet>>>";
	private static final ILogger logger = LogFactory.getLogger(SecureConsentMedicalServlet.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public String getReportLocation(Map<String, Object> params) {
		return getFileLocationReport(ConstantValue.JasperPath.PATH_SECURE_CONSENT_MEDICAL_PRU);
	}

	private String getFileLocationReport(String jasperFile) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASSEXEUTE + "LINE 49>>>>>jasperFile" + jasperFile);
		}
		return ConstantValue.JasperPath.PATH_SECURE_CONSENT_MEDICAL_PRU;
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
				logger.logError("----->>>> Reporte getDatasourceReport consentimiento seguro ");
				logger.logDebug("START getDatasourceReport SECURECONSENTSMEDICALERVLET");
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String identificationclient = (String) params.get(ConstantValue.valueConstant.IDENTIFICATIONCLIENT);
			String idTramite = (String) params.get(ConstantValue.Params.APPLICATION);

			if (logger.isDebugEnabled()) {
				logger.logDebug("LINE 76>>>>>sessionId" + sessionId);
				logger.logDebug("LINE 77>>>>>identificationclient" + identificationclient);
				logger.logDebug("LINE 78>>>>idTramite" + idTramite);

			}
			List<ConsentSecurityfullDATABEAN> jasperDataBeanListfull = new ArrayList<ConsentSecurityfullDATABEAN>();

			for (String clientReport : consultingClientMedical(idTramite, sessionId)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("LINE 85>>>>>clientReport" + clientReport);
				}
				// consulta la informacion del titular
				List<InformationHeadLineDTO> dataJasperHedLineMedical = jasperDatabeanHedLine(clientReport, idTramite, sessionId);
				// consulta de declaracion de beneficios
				List<BenefitsDeclareDTO> dataJasperDeclareBenefitsMedical = jasperDatabeanSafeBenefits(clientReport, sessionId);
				// informacion de cobertura
				List<BenefitsInformationTableDTO> dataJasperInformationTableMedical = jasperDatabeanInformaBenefits(clientReport, sessionId);

				// almaceno datos del cliente
				ConsentOfSegurityMedicalDATABEAN jasperListReportDataMedical = new ConsentOfSegurityMedicalDATABEAN();
				jasperListReportDataMedical.setListInformationHeadLineMedical(dataJasperHedLineMedical);
				jasperListReportDataMedical.setListBenefitsDeclareMedical(dataJasperDeclareBenefitsMedical);
				jasperListReportDataMedical.setListBenefitsInformationTableMedical(dataJasperInformationTableMedical);

				List<ConsentOfSegurityMedicalDATABEAN> listclientFullSecurity = new ArrayList<ConsentOfSegurityMedicalDATABEAN>();
				listclientFullSecurity.add(jasperListReportDataMedical);

				ConsentSecurityfullDATABEAN clientSecurityfull = new ConsentSecurityfullDATABEAN();
				clientSecurityfull.setListConsentSecurityfull(listclientFullSecurity);

				jasperDataBeanListfull.add(clientSecurityfull);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("LINE 111>>>>>TOTAL register full" + jasperDataBeanListfull.size());
			}
			if (jasperDataBeanListfull.isEmpty()) {
				jasperDataBeanListfull.add(returnDataEmptyReport());
				logger.logDebug("LINE 114>>>>>Register Empty" + jasperDataBeanListfull.size());
				return new JRBeanCollectionDataSource(jasperDataBeanListfull, false);
			}

			return new JRBeanCollectionDataSource(jasperDataBeanListfull, false);

		} catch (Exception e) {
			logger.logError("----->>>> Error Reporte Solicitud Credito Revolvente:", e);
			throw new RuntimeException(e);
		}
	}

	/**
	 * datasource Empty report
	 * 
	 * @return ConsentSecurityfullDATABEAN
	 */
	public ConsentSecurityfullDATABEAN returnDataEmptyReport() {
		ConsentOfSegurityMedicalDATABEAN jasperListReportDataMedicalEmpty = new ConsentOfSegurityMedicalDATABEAN();
		jasperListReportDataMedicalEmpty.setListInformationHeadLineMedical(new ArrayList<InformationHeadLineDTO>());
		jasperListReportDataMedicalEmpty.setListBenefitsDeclareMedical(new ArrayList<BenefitsDeclareDTO>());
		jasperListReportDataMedicalEmpty.setListBenefitsInformationTableMedical(new ArrayList<BenefitsInformationTableDTO>());

		List<ConsentOfSegurityMedicalDATABEAN> listclientFullSecurityEmpty = new ArrayList<ConsentOfSegurityMedicalDATABEAN>();
		listclientFullSecurityEmpty.add(jasperListReportDataMedicalEmpty);

		ConsentSecurityfullDATABEAN clientSecurityfullEmpty = new ConsentSecurityfullDATABEAN();
		clientSecurityfullEmpty.setListConsentSecurityfull(listclientFullSecurityEmpty);
		return clientSecurityfullEmpty;

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		return params;
	}

	@Override
	public List<String> consultingClientMedical(String idProcess, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "LINE 170 execute consultingClientMedical");
		List<String> clientsOfTeam = new ArrayList<String>();
		ConsultingClientTeamResponse[] response = new ConsultingClientTeamServices().consultingClientOfteams(idProcess, sessionId, serviceIntegration);
		for (ConsultingClientTeamResponse consultingClientTeamResponse : response) {
			if (consultingClientTeamResponse.getTypeSecure() != null && (ConstantValue.valueConstant.EXTENDIDO).equals(consultingClientTeamResponse.getTypeSecure()))
				clientsOfTeam.add(String.valueOf(consultingClientTeamResponse.getIdclient()));
		}
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "LINE 178 size()" + clientsOfTeam.size());

		return clientsOfTeam;
	}

	@Override
	public List<InformationHeadLineDTO> jasperDatabeanHedLine(String identificationclient, String idTramite, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "LINE 180>>START jasperDatabeanHedLine ");

		List<InformationHeadLineDTO> listMedicalHeadLine = new ArrayList<InformationHeadLineDTO>();
		ClientSafeResponse[] responseHeadLine = new SecureConsentMedicalService().queryHeadLineMedical(identificationclient, idTramite, sessionId, serviceIntegration);
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "listMedicalHeadLine" + responseHeadLine.length);

		if (responseHeadLine != null && responseHeadLine.length > 0) {
			for (ClientSafeResponse clientInformationHeadLine : responseHeadLine) {
				InformationHeadLineDTO headLineDTO = new InformationHeadLineDTO();
				headLineDTO.setBirthDate(clientInformationHeadLine.getBirthDate());
				headLineDTO.setFullName(clientInformationHeadLine.getFullname());
				listMedicalHeadLine.add(headLineDTO);
			}
			return listMedicalHeadLine;
		}
		return new ArrayList<InformationHeadLineDTO>();

	}

	@Override
	public List<BenefitsDeclareDTO> jasperDatabeanSafeBenefits(String identificationclient, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "LINE 204>>START jasperDatabeanSafeBenefits ");

		List<BenefitsDeclareDTO> listMedicalBenefitsDeclare = new ArrayList<BenefitsDeclareDTO>();
		ClientSafeBenefitsResponse[] responseDeclaration = new SecureConsentMedicalService().queryDeclareBenefitsMedical(identificationclient, sessionId, serviceIntegration);
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "responseDeclaration" + responseDeclaration.length);

		if (responseDeclaration != null && responseDeclaration.length > 0) {
			for (ClientSafeBenefitsResponse clientSafeBenefits : responseDeclaration) {
				BenefitsDeclareDTO benefitsDeclareDTO = new BenefitsDeclareDTO();
				benefitsDeclareDTO.setFullNameBenefits(clientSafeBenefits.getFullname());
				benefitsDeclareDTO.setRelationshipBenefits(clientSafeBenefits.getRelationship());
				benefitsDeclareDTO.setBirthdateBenefits(clientSafeBenefits.getBirthDate());
				benefitsDeclareDTO.setPercentageBenefits(clientSafeBenefits.getPorcentage());
				benefitsDeclareDTO.setTotalPorcentage("0.0");
				listMedicalBenefitsDeclare.add(benefitsDeclareDTO);
			}
			return listMedicalBenefitsDeclare;
		}
		return new ArrayList<BenefitsDeclareDTO>();

	}

	@Override
	public List<BenefitsInformationTableDTO> jasperDatabeanInformaBenefits(String identificationclient, String sessionId) {
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "LINE 231>>START jasperDatabeanInformaBenefits ");

		List<BenefitsInformationTableDTO> listBenefitsMedicalTable = new ArrayList<BenefitsInformationTableDTO>();
		ClientInformationBenefisResponse[] responseMedicalBenefits = new SecureConsentMedicalService().querySecureBenefitsMedical(identificationclient, sessionId,
				serviceIntegration);
		if (logger.isDebugEnabled())
			logger.logDebug(CLASSEXEUTE + "responseinformationBenefits" + responseMedicalBenefits.length);

		if (responseMedicalBenefits != null && responseMedicalBenefits.length > 0) {
			for (ClientInformationBenefisResponse clientInformationBenefits : responseMedicalBenefits) {
				BenefitsInformationTableDTO benefitsInformationTableDTO = new BenefitsInformationTableDTO();
				benefitsInformationTableDTO.setCoverageBenefitstable(clientInformationBenefits.getCoverage());
				benefitsInformationTableDTO.setTitleBenefitstable(clientInformationBenefits.getTitle());
				benefitsInformationTableDTO.setPairBenefitstable(clientInformationBenefits.getPair());
				benefitsInformationTableDTO.setSonBenefitstable(clientInformationBenefits.getSon());
				benefitsInformationTableDTO.setColorBenefitsTable((listBenefitsMedicalTable.size() % 2 != 0) ? true : false);
				if (logger.isDebugEnabled()) {
					logger.logDebug("1" + listBenefitsMedicalTable.size());
					logger.logDebug("2" + (listBenefitsMedicalTable.size() % 2 != 0));
					logger.logDebug("3" + benefitsInformationTableDTO.isColorBenefitsTable());
				}
				listBenefitsMedicalTable.add(benefitsInformationTableDTO);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("CLASSEXEUTE+listBenefitsMedicalTable size" + listBenefitsMedicalTable.size());

			}

			return listBenefitsMedicalTable;
		} else {
			BenefitsInformationTableDTO benefitsInformationTableDTO = new BenefitsInformationTableDTO();
			benefitsInformationTableDTO.setCoverageBenefitstable("");
			benefitsInformationTableDTO.setTitleBenefitstable("");
			benefitsInformationTableDTO.setPairBenefitstable("");
			benefitsInformationTableDTO.setSonBenefitstable("");
			benefitsInformationTableDTO.setColorBenefitsTable(false);
			listBenefitsMedicalTable.add(benefitsInformationTableDTO);
		}
		return new ArrayList<BenefitsInformationTableDTO>();

	}

}

interface AssembleMedicalDataBean {
	/***
	 * consulting section head Line
	 * 
	 * @param identificationclient
	 * @return List<InformationHeadLineDTO>
	 */
	List<InformationHeadLineDTO> jasperDatabeanHedLine(String identificationclient, String idTramite, String sessionId);

	/**
	 * consulting section secure benefits
	 * 
	 * @param identificationclient
	 * @return List<BenefitsDeclareDTO>
	 */
	List<BenefitsDeclareDTO> jasperDatabeanSafeBenefits(String identificationclient, String sessionId);

	/***
	 * consulting section information benefits
	 * 
	 * @param identificationclient
	 * @return List<BenefitsInformationTableDTO>
	 */
	List<BenefitsInformationTableDTO> jasperDatabeanInformaBenefits(String identificationclient, String sessionId);

	/***
	 * 
	 * @param identificationclient
	 * @param sessionId
	 * @return
	 */
	List<String> consultingClientMedical(String idProcess, String sessionId);

}
