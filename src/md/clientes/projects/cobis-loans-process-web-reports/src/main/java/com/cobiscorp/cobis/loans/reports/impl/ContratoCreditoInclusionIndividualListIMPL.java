package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionIndividualDeclaracionDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionIndividualDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.dto.FirmasDTO;
import com.cobiscorp.cobis.loans.reports.dto.TransactionContextReport;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanInfoApplicationResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class ContratoCreditoInclusionIndividualListIMPL {
	private static final ILogger logger = LogFactory.getLogger(ContratoCreditoInclusionIndividualListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	private Services services = new Services();

	// metodos para Contrato de Credito Individual - Inclusion Individual
	public List<ContratoCreditoInclusionClausulaDTO> getClausula(String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionClausulaDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionClausulaDTO>();
		logger.logError("*****>>ContratoCreditoInclusionIndividualListIMPL - Inicia getClausula");

		ContratoCreditoInclusionClausulaDTO clausula = new ContratoCreditoInclusionClausulaDTO();
		clausula.setCampo(".");
		dataBeanList.add(clausula);

		return dataBeanList;
	}

	public List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> getDetallePrincipal(LoanInfoApplicationResponse[] reportResponse, String sessionId,
			ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionIndividualDetallePrincipalDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetallePrincipal - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetallePrincipal - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					ContratoCreditoInclusionIndividualDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoInclusionIndividualDetallePrincipalDTO();
					String fecha = "";

					List<ContratoCreditoInclusionIndividualDeclaracionDTO> declaracion = new ArrayList<ContratoCreditoInclusionIndividualDeclaracionDTO>();
					List<ContratoCreditoInclusionClausulaDTO> clausula = new ArrayList<ContratoCreditoInclusionClausulaDTO>();

					for (int i = 0; i < reportResponse.length; i++) {

						fecha = reportResponse[i].getDate();
						cciDetallePrincipalDTO.setDia(UtilFunctions.getDay(fecha));
						cciDetallePrincipalDTO.setMes(UtilFunctions.getMonth(fecha));
						cciDetallePrincipalDTO.setAnio(UtilFunctions.getYear(fecha));

						cciDetallePrincipalDTO.setNombreCliente(reportResponse[i].getName());
						cciDetallePrincipalDTO.setNombreInclusionRepUno(reportResponse[i].getInclOne());
						cciDetallePrincipalDTO.setNombreInclusionRepDos(reportResponse[i].getInclTwo());
						cciDetallePrincipalDTO.setNombreBancoRepUno(reportResponse[i].getBanckOne());
						cciDetallePrincipalDTO.setNombreBancoRepDos(reportResponse[i].getBanckTwo());
						cciDetallePrincipalDTO.setCiudadOfi(reportResponse[i].getCityApplication());
					}

					String condusef = "";
					ParameterResponse recaParrafo = services.getParameter(4, "RDRECA", Mnemonic.MODULE, serviceIntegration, sessionId);
					logger.logInfo("paramRECAParrafo ContratoCreditoInclusion " + recaParrafo);
					if (recaParrafo != null) {
						condusef = recaParrafo.getParameterValue();
					}

					declaracion = getDeclaracion(condusef);
					clausula = getClausula(sessionId, serviceIntegration);
					TransactionContextReport transContextReportFirm = new TransactionContextReport();
					List<FirmasDTO> firmasDTOUno = new ArrayList<FirmasDTO>();
					firmasDTOUno = getDetalleFirma(reportResponse, sessionId, serviceIntegration);
					cciDetallePrincipalDTO.setContratoCreditoInclusionDeclaracion(declaracion);
					cciDetallePrincipalDTO.setContratoCreditoInclusionClausula(clausula);

					// Envio de listas
					transContextReportFirm = services.dataListFirm(firmasDTOUno);
					firmasDTOUno = (List<FirmasDTO>) transContextReportFirm.getValue(ConstantValue.valueConstant.list1);

					cciDetallePrincipalDTO.setCciDetalleFirmaUno(firmasDTOUno);
					dataBeanList.add(cciDetallePrincipalDTO);
				} else {
					this.initDetallePrincipal(dataBeanList);
				}
			} else {
				this.initDetallePrincipal(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionIndividualListIMPL - Error getDetallePrincipal", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	public List<ContratoCreditoInclusionIndividualDeclaracionDTO> getDeclaracion(String condusef) {
		List<ContratoCreditoInclusionIndividualDeclaracionDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionIndividualDeclaracionDTO>();
		ContratoCreditoInclusionIndividualDeclaracionDTO dataBean = new ContratoCreditoInclusionIndividualDeclaracionDTO();
		logger.logError("*****>>ContratoCreditoInclusionIndividualListIMPL - Inicia getDeclaracion");
		dataBean.setCondusef(condusef);
		dataBeanList.add(dataBean);
		return dataBeanList;
	}

	public List<FirmasDTO> getDetalleFirma(LoanInfoApplicationResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<FirmasDTO> dataBeanList = new ArrayList<FirmasDTO>();
		logger.logError("*****>>ContratoCreditoInclusionIndividualListIMPL - Inicia getDetalleFirma - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetalleFirma - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					for (LoanInfoApplicationResponse report : reportResponse) {
						FirmasDTO firmasDTO = new FirmasDTO();
						firmasDTO.setNombre(report.getName());
						dataBeanList.add(firmasDTO);
					}
				} else {
					this.initDetalleFirma(dataBeanList);
				}
			} else {
				this.initDetalleFirma(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionIndividualListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	private void initDetallePrincipal(List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetallePrincipal");
		ContratoCreditoInclusionIndividualDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoInclusionIndividualDetallePrincipalDTO();
		cciDetallePrincipalDTO.setNombreCliente("");
		cciDetallePrincipalDTO.setDia("");
		cciDetallePrincipalDTO.setMes("");
		cciDetallePrincipalDTO.setAnio("");
		cciDetallePrincipalDTO.setNombreBancoRepUno("");
		cciDetallePrincipalDTO.setNombreBancoRepDos("");
		cciDetallePrincipalDTO.setNombreInclusionRepUno("");
		cciDetallePrincipalDTO.setNombreInclusionRepDos("");
		// Lista para el detalle
		List<ContratoCreditoInclusionIndividualDeclaracionDTO> declaracion = new ArrayList<ContratoCreditoInclusionIndividualDeclaracionDTO>();
		List<FirmasDTO> firmasDTO = new ArrayList<FirmasDTO>();
		cciDetallePrincipalDTO.setContratoCreditoInclusionDeclaracion(declaracion);
		cciDetallePrincipalDTO.setCciDetalleFirmaUno(firmasDTO);
		cciDetallePrincipalDTO.setCciDetalleFirmaDos(firmasDTO);

		dataBeanList.add(cciDetallePrincipalDTO);
	}

	private void initDetalleFirma(List<FirmasDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionIndividualeListIMPL - initDetalleFirma");
		FirmasDTO firmasDTO = new FirmasDTO();
		firmasDTO.setCargo("");
		firmasDTO.setNombre("");
		dataBeanList.add(firmasDTO);
	}
}
