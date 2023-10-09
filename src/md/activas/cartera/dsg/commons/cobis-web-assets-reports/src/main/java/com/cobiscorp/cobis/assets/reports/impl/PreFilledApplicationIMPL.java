package com.cobiscorp.cobis.assets.reports.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.PreFilledApplicationContentDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.PreFilledApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class PreFilledApplicationIMPL {

	private static final ILogger logger = LogFactory.getLogger(PreFilledApplicationIMPL.class);

	public List<PreFilledApplicationContentDTO> getContenido(PreFilledApplicationResponse[] preFilledApplicationResponse, ICTSServiceIntegration serviceIntegration) throws Exception {
		logger.logDebug("Mapeo de Datos de Prestamo y Cliente");

		List<PreFilledApplicationContentDTO> preFilledApplicationContentDTOList = new ArrayList<PreFilledApplicationContentDTO>();
		try {
			if (preFilledApplicationResponse != null) {
				if (preFilledApplicationResponse.length > 0) {

					for (PreFilledApplicationResponse a : preFilledApplicationResponse) {
						PreFilledApplicationContentDTO preFilledApplicationContentDTO = new PreFilledApplicationContentDTO();

						preFilledApplicationContentDTO.setSucursal(a.getBranchOffice());
						preFilledApplicationContentDTO.setImporteSolicitado(0.0);

						String fechaSolicitud = a.getDate();
						logger.logDebug("fechaSolicitud: " + fechaSolicitud);

						if (fechaSolicitud != null) {
							String fechaSolicitudTemp[] = fechaSolicitud.split("/");
							preFilledApplicationContentDTO.setDiaFecha(fechaSolicitudTemp[0]);
							preFilledApplicationContentDTO.setMesFecha(fechaSolicitudTemp[1]);
							preFilledApplicationContentDTO.setAnioFecha(fechaSolicitudTemp[2]);
						}

						preFilledApplicationContentDTO.setApellidoPaterno(a.getLastName());
						preFilledApplicationContentDTO.setApellidoMaterno(a.getMaternalLastName());
						preFilledApplicationContentDTO.setNombres(a.getName());

						preFilledApplicationContentDTO.setDireccion(a.getAddress());
						preFilledApplicationContentDTO.setNumExt(a.getNumExt());
						preFilledApplicationContentDTO.setNumInt(a.getNumInt());
						preFilledApplicationContentDTO.setColonia(a.getSuburb());
						preFilledApplicationContentDTO.setMunicipio(a.getMunicipality());
						preFilledApplicationContentDTO.setEstado(a.getState());
						preFilledApplicationContentDTO.setPais(a.getCountry());

						if (a.getGender() != null) {
							if (a.getGender().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_FEMEMINO))
								preFilledApplicationContentDTO.setEsFemenino("X");
							if (a.getGender().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_MASCULINO))
								preFilledApplicationContentDTO.setEsMasculino("X");
						}

						preFilledApplicationContentDTO.setCorreoElectronico(a.getEmail());

						String celular = a.getCellPhone();
						if (celular != null) {
							for (int n = 0; n < celular.length(); n++) {
								char c = celular.charAt(n);
								switch (n) {
								case 0:
									preFilledApplicationContentDTO.setDgCel01(String.valueOf(c));
									break;
								case 1:
									preFilledApplicationContentDTO.setDgCel02(String.valueOf(c));
									break;
								case 2:
									preFilledApplicationContentDTO.setDgCel03(String.valueOf(c));
									break;
								case 3:
									preFilledApplicationContentDTO.setDgCel04(String.valueOf(c));
									break;
								case 4:
									preFilledApplicationContentDTO.setDgCel05(String.valueOf(c));
									break;
								case 5:
									preFilledApplicationContentDTO.setDgCel06(String.valueOf(c));
									break;
								case 6:
									preFilledApplicationContentDTO.setDgCel07(String.valueOf(c));
									break;
								case 7:
									preFilledApplicationContentDTO.setDgCel08(String.valueOf(c));
									break;
								case 8:
									preFilledApplicationContentDTO.setDgCel09(String.valueOf(c));
									break;
								case 9:
									preFilledApplicationContentDTO.setDgCel10(String.valueOf(c));
									break;
								}
							}
						}

						// Estado Civil
						String estadoCivil = a.getMaritalStatus();
						if (estadoCivil != null) {
							if (a.getMaritalStatus().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_CASADO))
								preFilledApplicationContentDTO.setEsCasado("X");
							if (estadoCivil.trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_SOLETERO))
								preFilledApplicationContentDTO.setEsSoltero("X");
							if (estadoCivil.trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_VIUDO))
								preFilledApplicationContentDTO.setEsViudo("X");
							if (estadoCivil.trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_DIVORCIADO))
								preFilledApplicationContentDTO.setEsDivorciado("X");
							if (estadoCivil.trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_UNILIBRE))
								preFilledApplicationContentDTO.setEsUnionLibre("X");
						} // Género if

						preFilledApplicationContentDTO.setContraAdhesionS(a.getCondusef());
						preFilledApplicationContentDTO.setFootParam(a.getFooter());
						preFilledApplicationContentDTO.setRefDomicilio(a.getAddressReference());
						preFilledApplicationContentDTO.setFechaNacimiento(a.getBirthDate());
						preFilledApplicationContentDTO.setTramiteAnterior(a.getPreviousCreditNumber());
						
						preFilledApplicationContentDTO.setEntidadNacimiento(a.getBirthEntity());
						preFilledApplicationContentDTO.setAsesor(a.getAdvisorName());
						
						if(a.getManagerName().equals("")) {
							preFilledApplicationContentDTO.setGerente(a.getCoordinatorName());
						} else {
							preFilledApplicationContentDTO.setGerente(a.getManagerName());
						}
						
						preFilledApplicationContentDTO.setAnalista(a.getAnalystName());
						preFilledApplicationContentDTO.setNombreGrupo(a.getGroupName());
						preFilledApplicationContentDTO.setNombreDirector(a.getDirectorName());
						preFilledApplicationContentDTO.setNombreSubdirector(a.getSubdirectorName());
						// CodigoPostal
						String codPostal = a.getPostalCode();
						if (codPostal != null) {
							for (int n = 0; n < codPostal.length(); n++) {
								char c = codPostal.charAt(n);
								switch (n) {
								case 0:
									preFilledApplicationContentDTO.setCodigoPostal1(String.valueOf(c));
									break;
								case 1:
									preFilledApplicationContentDTO.setCodigoPostal2(String.valueOf(c));
									break;
								case 2:
									preFilledApplicationContentDTO.setCodigoPostal3(String.valueOf(c));
									break;
								case 3:
									preFilledApplicationContentDTO.setCodigoPostal4(String.valueOf(c));
									break;
								case 4:
									preFilledApplicationContentDTO.setCodigoPostal5(String.valueOf(c));
									break;
								}
							}

							preFilledApplicationContentDTOList.add(preFilledApplicationContentDTO);

						}
					}
				} else {
					this.getEmptyContent();
				}
			} else {
				this.getEmptyContent();
			}
		} catch (Exception ex) {
			this.getEmptyContent();
			logger.logError("----->>>> Reporte Solicitud Credito Grupal Inicio Listado:", ex);
		}
		return preFilledApplicationContentDTOList;
	}

	public List<PreFilledApplicationContentDTO> getEmptyContent() {

		List<PreFilledApplicationContentDTO> preFilledApplicationContentDTOList = new ArrayList<PreFilledApplicationContentDTO>();
		PreFilledApplicationContentDTO preFilledApplicationContentDTO = new PreFilledApplicationContentDTO();

		preFilledApplicationContentDTO.setSucursal("");
		preFilledApplicationContentDTO.setImporteSolicitado(0.0);
		preFilledApplicationContentDTO.setDiaFecha("");
		preFilledApplicationContentDTO.setMesFecha("");
		preFilledApplicationContentDTO.setAnioFecha("");
		preFilledApplicationContentDTO.setApellidoPaterno("");
		preFilledApplicationContentDTO.setApellidoMaterno("");
		preFilledApplicationContentDTO.setNombres("");
		preFilledApplicationContentDTO.setDgRFC01("");
		preFilledApplicationContentDTO.setDgRFC02("");
		preFilledApplicationContentDTO.setDgRFC03("");
		preFilledApplicationContentDTO.setDgRFC04("");
		preFilledApplicationContentDTO.setDgRFC05("");
		preFilledApplicationContentDTO.setDgRFC06("");
		preFilledApplicationContentDTO.setDgRFC07("");
		preFilledApplicationContentDTO.setDgRFC08("");
		preFilledApplicationContentDTO.setDgRFC09("");
		preFilledApplicationContentDTO.setDgRFC10("");
		preFilledApplicationContentDTO.setDgRFC11("");
		preFilledApplicationContentDTO.setDgRFC12("");
		preFilledApplicationContentDTO.setDgRFC13("");
		preFilledApplicationContentDTO.setNumExt("");
		preFilledApplicationContentDTO.setNumInt("");
		preFilledApplicationContentDTO.setDireccion("");
		preFilledApplicationContentDTO.setColonia("");
		preFilledApplicationContentDTO.setMunicipio("");
		preFilledApplicationContentDTO.setEstado("");
		preFilledApplicationContentDTO.setPais("");
		preFilledApplicationContentDTO.setEsFemenino("");
		preFilledApplicationContentDTO.setEsMasculino("");
		preFilledApplicationContentDTO.setCorreoElectronico("");
		preFilledApplicationContentDTO.setDgTelfFijo01("");
		preFilledApplicationContentDTO.setDgTelfFijo02("");
		preFilledApplicationContentDTO.setDgTelfFijo03("");
		preFilledApplicationContentDTO.setDgTelfFijo04("");
		preFilledApplicationContentDTO.setDgTelfFijo05("");
		preFilledApplicationContentDTO.setDgTelfFijo06("");
		preFilledApplicationContentDTO.setDgTelfFijo07("");
		preFilledApplicationContentDTO.setDgTelfFijo08("");
		preFilledApplicationContentDTO.setDgTelfFijo09("");
		preFilledApplicationContentDTO.setDgTelfFijo10("");
		preFilledApplicationContentDTO.setDgCel01("");
		preFilledApplicationContentDTO.setDgCel02("");
		preFilledApplicationContentDTO.setDgCel03("");
		preFilledApplicationContentDTO.setDgCel04("");
		preFilledApplicationContentDTO.setDgCel05("");
		preFilledApplicationContentDTO.setDgCel06("");
		preFilledApplicationContentDTO.setDgCel07("");
		preFilledApplicationContentDTO.setDgCel08("");
		preFilledApplicationContentDTO.setDgCel09("");
		preFilledApplicationContentDTO.setDgCel10("");
		preFilledApplicationContentDTO.setEsCasado("");
		preFilledApplicationContentDTO.setEsSoltero("");
		preFilledApplicationContentDTO.setEsViudo("");
		preFilledApplicationContentDTO.setEsDivorciado("");
		preFilledApplicationContentDTO.setEsUnionLibre("");
		preFilledApplicationContentDTO.setTieneAntecedentesBuro("");
		preFilledApplicationContentDTO.setNoTieneAntecedentesBuro("");
		preFilledApplicationContentDTO.setTieneCredGrupal("");
		preFilledApplicationContentDTO.setNoTieneCredGrupal("");
		preFilledApplicationContentDTO.setAutoriza("");
		preFilledApplicationContentDTO.setNoAutoriza("");
		preFilledApplicationContentDTO.setContraAdhesionS("");
		preFilledApplicationContentDTO.setPieAnio("");
		preFilledApplicationContentDTO.setRefDomicilio("");
		preFilledApplicationContentDTO.setFechaNacimiento("");
		preFilledApplicationContentDTO.setEntidadNacimiento("");
		preFilledApplicationContentDTO.setFootParam("");
		preFilledApplicationContentDTO.setAsesor("");
		preFilledApplicationContentDTO.setGerente("");
		preFilledApplicationContentDTO.setAnalista("");
		preFilledApplicationContentDTO.setCodigoPostal1("");
		preFilledApplicationContentDTO.setCodigoPostal2("");
		preFilledApplicationContentDTO.setCodigoPostal3("");
		preFilledApplicationContentDTO.setCodigoPostal4("");
		preFilledApplicationContentDTO.setCodigoPostal5("");

		preFilledApplicationContentDTOList.add(preFilledApplicationContentDTO);
		return preFilledApplicationContentDTOList;
	}

}
