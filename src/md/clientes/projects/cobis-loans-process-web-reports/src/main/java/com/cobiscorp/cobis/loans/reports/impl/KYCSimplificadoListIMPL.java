package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.KYCSimplificadoDetalleDTO;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

public class KYCSimplificadoListIMPL {
	private static final ILogger logger = LogFactory.getLogger(KYCSimplificadoListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<KYCSimplificadoDetalleDTO> getDetalle(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<KYCSimplificadoDetalleDTO> dataBeanList = new ArrayList<KYCSimplificadoDetalleDTO>();
		logger.logError("*****>>KYCSimplificado - KYCSimplificadoListIMPL - Inicia getDetalle");

		try {
			if (reportResponse != null) {
				if (reportResponse.length > 0) {
					for (ReportResponse report : reportResponse) {
						KYCSimplificadoDetalleDTO kYCSimplificadoDetalleDTO = new KYCSimplificadoDetalleDTO();
						logger.logError("*****>>KYCSimplificado - KYCSimplificadoListIMPL - Inicia getDetalle - report.getDate():" + report.getDate());
						kYCSimplificadoDetalleDTO.setDiaProceso(UtilFunctions.getDay(report.getDate()));
						kYCSimplificadoDetalleDTO.setMesProceso(UtilFunctions.getMonth(report.getDate()));
						kYCSimplificadoDetalleDTO.setAnioProceso(UtilFunctions.getYear(report.getDate()));
						kYCSimplificadoDetalleDTO.setNombre(report.getClient());
						kYCSimplificadoDetalleDTO.setGenero(report.getGender());
						kYCSimplificadoDetalleDTO.setRfcHomoclave(report.getRfc());
						kYCSimplificadoDetalleDTO.setEntidadFederativaNacimiento(report.getBirthCity());

						String dd = UtilFunctions.getDay(report.getBirthDate());
						String mm = UtilFunctions.getMonth(report.getBirthDate());
						String yy = UtilFunctions.getYear(report.getBirthDate());
						String getBirthDate = dd + " " + mm + " " + yy;
						kYCSimplificadoDetalleDTO.setFechaNacimiento(getBirthDate);

						kYCSimplificadoDetalleDTO.setPaisNacimiento(report.getBirthCountry());
						kYCSimplificadoDetalleDTO.setNacionalidad(report.getNationality());
						kYCSimplificadoDetalleDTO.setCalleNumero(report.getStreetNumber());
						kYCSimplificadoDetalleDTO.setColonia(report.getColony());
						kYCSimplificadoDetalleDTO.setDelegacionMunicipio(report.getMunicipality());
						kYCSimplificadoDetalleDTO.setCiudadEstadoEntFed(report.getState());
						kYCSimplificadoDetalleDTO.setCodigoPostal(report.getPostalCode());
						kYCSimplificadoDetalleDTO.setPais(report.getCountry());
						kYCSimplificadoDetalleDTO.setOcupacionProfesionActividad(report.getOccupation());
						kYCSimplificadoDetalleDTO.setActEcoGenerica(report.getActEcoGeneric());
						kYCSimplificadoDetalleDTO.setActEcoEspecifica(report.getActEcoEspecific());
						kYCSimplificadoDetalleDTO.setCurp(report.getCurp());
						kYCSimplificadoDetalleDTO.setTelefono(report.getPhone());
						kYCSimplificadoDetalleDTO.setCorreoElectronico(report.getEmail());
						kYCSimplificadoDetalleDTO.setFirmaElectronicaAvanzada(report.getAdvancedSignature());
						kYCSimplificadoDetalleDTO.setOrigenRecursos(report.getOriginResources());
						kYCSimplificadoDetalleDTO.setDestinoRecursos(report.getDestinationResources());

						if (report.getOtherA().equals("SI")) {
							kYCSimplificadoDetalleDTO.setRespA1("X");
						} else {
							kYCSimplificadoDetalleDTO.setRespA2("X");
						}
						if (report.getOtherB().equals("SI")) {
							kYCSimplificadoDetalleDTO.setRespB1("X");
						} else {
							kYCSimplificadoDetalleDTO.setRespB2("X");
						}

						if (report.getOtherB().equals("SI")) {
							kYCSimplificadoDetalleDTO.setRespC1("X");
						} else {
							kYCSimplificadoDetalleDTO.setRespC2("X");
						}
						kYCSimplificadoDetalleDTO.setNumEstimadoOperEnv(report.getNumEstOperSend());						
						kYCSimplificadoDetalleDTO.setMontoEstimadoOperEnv(report.getAmountEstOperSend());						
						kYCSimplificadoDetalleDTO.setNumEstimadoOperRec(report.getNumEstOperRec());						
						kYCSimplificadoDetalleDTO.setMontoEstimadoOperRec(report.getAmountEstOperRec());						
						kYCSimplificadoDetalleDTO.setNumEstimadoOperEfe(report.getNumEstOperEfec());						
						kYCSimplificadoDetalleDTO.setMontoEstimadoOperEfe(report.getAmountEstOperEfec());						
						kYCSimplificadoDetalleDTO.setNumEstimadoOperNoEfe(report.getNumEstOperEfecNot());						
						kYCSimplificadoDetalleDTO.setMontoEstimadoOperNoEfe(report.getAmountEstOperEfecNot());
						
						kYCSimplificadoDetalleDTO.setComentarios("");
						kYCSimplificadoDetalleDTO.setNombreEjecutivo(report.getOfficerName());
						kYCSimplificadoDetalleDTO.setNumContraparte(report.getCounterpartNumber());
						kYCSimplificadoDetalleDTO.setCanalContratacion(report.getRecruitmentChannel());
						kYCSimplificadoDetalleDTO.setFechaNacConst(report.getConstitutionDate());
												
						dataBeanList.add(kYCSimplificadoDetalleDTO);
					}
				} else {
					this.initDetalle(dataBeanList);
				}
			} else {
				this.initDetalle(dataBeanList);
			}

		} catch (Exception e) {
			logger.logError("*****>>KYCSimplificado - Error getDetalle", e);
		}
		return dataBeanList;
	}

	private void initDetalle(List<KYCSimplificadoDetalleDTO> dataBeanList) {
		logger.logError("*****>>KYCSimplificado - KYCSimplificadoListIMPL - Inicia initDetalle");
		KYCSimplificadoDetalleDTO kYCSimplificadoDetalleDTO = new KYCSimplificadoDetalleDTO();
		kYCSimplificadoDetalleDTO.setDiaProceso("");
		kYCSimplificadoDetalleDTO.setMesProceso("");
		kYCSimplificadoDetalleDTO.setAnioProceso("");
		kYCSimplificadoDetalleDTO.setNombre("");
		kYCSimplificadoDetalleDTO.setGenero("");
		kYCSimplificadoDetalleDTO.setRfcHomoclave("");
		kYCSimplificadoDetalleDTO.setEntidadFederativaNacimiento("");
		kYCSimplificadoDetalleDTO.setFechaNacimiento("");
		kYCSimplificadoDetalleDTO.setPaisNacimiento("");
		kYCSimplificadoDetalleDTO.setNacionalidad("");
		kYCSimplificadoDetalleDTO.setCalleNumero("");
		kYCSimplificadoDetalleDTO.setColonia("");
		kYCSimplificadoDetalleDTO.setDelegacionMunicipio("");
		kYCSimplificadoDetalleDTO.setCiudadEstadoEntFed("");
		kYCSimplificadoDetalleDTO.setCodigoPostal("");
		kYCSimplificadoDetalleDTO.setPais("");
		kYCSimplificadoDetalleDTO.setOcupacionProfesionActividad("");
		kYCSimplificadoDetalleDTO.setActEcoGenerica("");
		kYCSimplificadoDetalleDTO.setActEcoEspecifica("");
		kYCSimplificadoDetalleDTO.setCurp("");
		kYCSimplificadoDetalleDTO.setTelefono("");
		kYCSimplificadoDetalleDTO.setCorreoElectronico("");
		kYCSimplificadoDetalleDTO.setFirmaElectronicaAvanzada("");
		kYCSimplificadoDetalleDTO.setOrigenRecursos("");
		kYCSimplificadoDetalleDTO.setDestinoRecursos("");
		kYCSimplificadoDetalleDTO.setRespA1("");
		kYCSimplificadoDetalleDTO.setRespA2("");
		kYCSimplificadoDetalleDTO.setRespB1("");
		kYCSimplificadoDetalleDTO.setRespB2("");
		kYCSimplificadoDetalleDTO.setRespC1("");
		kYCSimplificadoDetalleDTO.setRespC2("");
		kYCSimplificadoDetalleDTO.setNumEstimadoOperEnv("");
		kYCSimplificadoDetalleDTO.setMontoEstimadoOperEnv("");
		kYCSimplificadoDetalleDTO.setNumEstimadoOperRec("");
		kYCSimplificadoDetalleDTO.setMontoEstimadoOperRec("");
		kYCSimplificadoDetalleDTO.setNumEstimadoOperEfe("");
		kYCSimplificadoDetalleDTO.setMontoEstimadoOperEfe("");
		kYCSimplificadoDetalleDTO.setNumEstimadoOperNoEfe("");
		kYCSimplificadoDetalleDTO.setMontoEstimadoOperNoEfe("");
		kYCSimplificadoDetalleDTO.setComentarios("");
		kYCSimplificadoDetalleDTO.setNombreEjecutivo("");
		dataBeanList.add(kYCSimplificadoDetalleDTO);
	}

}
