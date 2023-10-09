package com.cobiscorp.cobis.loans.reports.impl;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenAddressCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenInfoCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoRevolventeDTO;
import com.cobiscorp.cobis.loans.reports.services.ServicesLongIndividualCreditApplication;

public class SolicitudCreditoRevolventeIMPL {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoRevolventeIMPL.class);
	ServicesLongIndividualCreditApplication servicesLongIndCreditApp = new ServicesLongIndividualCreditApplication();

	public SolicitudCreditoRevolventeDTO getContenido(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Mapeo de Datos de Prestamo y Cliente");
		}
		SolicitudCreditoRevolventeDTO solicitudCreditoIndividual = new SolicitudCreditoRevolventeDTO();
		try {
			reportRequest.setOperation("IG");
			ReportLongIndCreditGenInfoCustomerResponse[] infoCustomerResponse = servicesLongIndCreditApp.getInfoCustomer(reportRequest, sessionId, serviceIntegration);

			if (infoCustomerResponse != null) {
				if (infoCustomerResponse.length > 0) {
					ReportLongIndCreditGenInfoCustomerResponse customerReponse = infoCustomerResponse[0];
					logger.logDebug("customerReponse: " + customerReponse.getSucursal());
					solicitudCreditoIndividual.setEsPersonal("X");
					solicitudCreditoIndividual.setSucursal(customerReponse.getSucursal());
					solicitudCreditoIndividual.setImporteSolicitado(customerReponse.getImporteSolicitado());
					solicitudCreditoIndividual.setFechaNacimiento(customerReponse.getFechaNacimiento());
					solicitudCreditoIndividual.setEntidadNacimiento(customerReponse.getDescripcionEntidadNacimiento());
					solicitudCreditoIndividual.setTramiteAnterior(customerReponse.getTramiteAnterior());
					
					String fechaSolicitud = customerReponse.getFechaSolicitud();
					logger.logDebug("fechaSolicitud: " + fechaSolicitud);
					if (fechaSolicitud != null) {
						String fechaSolicitudTemp[] = fechaSolicitud.split("/");
						solicitudCreditoIndividual.setDiaFecha(fechaSolicitudTemp[0]);
						solicitudCreditoIndividual.setMesFecha(fechaSolicitudTemp[1]);
						solicitudCreditoIndividual.setAnioFecha(fechaSolicitudTemp[2]);
					}
					solicitudCreditoIndividual.setApellidoPaterno(customerReponse.getApellidoPaterno());
					solicitudCreditoIndividual.setApellidoMaterno(customerReponse.getApellidoMaterno());
					solicitudCreditoIndividual.setNombres((customerReponse.getPrimerNombre() == null ? "" : customerReponse.getPrimerNombre()) + " "
							+ (customerReponse.getSegundoNombre() == null ? "" : customerReponse.getSegundoNombre()));
					solicitudCreditoIndividual.setCorreoElectronico(customerReponse.getCorreoElectronico());
					// RFC
					String rfc = customerReponse.getNumeroRFC();
					if (rfc != null) {
						for (int n = 0; n < rfc.length(); n++) {
							char c = rfc.charAt(n);
							switch (n) {
							case 0:
								solicitudCreditoIndividual.setDgRFC01(String.valueOf(c));
								break;
							case 1:
								solicitudCreditoIndividual.setDgRFC02(String.valueOf(c));
								break;
							case 2:
								solicitudCreditoIndividual.setDgRFC03(String.valueOf(c));
								break;
							case 3:
								solicitudCreditoIndividual.setDgRFC04(String.valueOf(c));
								break;
							case 4:
								solicitudCreditoIndividual.setDgRFC05(String.valueOf(c));
								break;
							case 5:
								solicitudCreditoIndividual.setDgRFC06(String.valueOf(c));
								break;
							case 6:
								solicitudCreditoIndividual.setDgRFC07(String.valueOf(c));
								break;
							case 7:
								solicitudCreditoIndividual.setDgRFC08(String.valueOf(c));
								break;
							case 8:
								solicitudCreditoIndividual.setDgRFC09(String.valueOf(c));
								break;
							case 9:
								solicitudCreditoIndividual.setDgRFC10(String.valueOf(c));
								break;
							case 10:
								solicitudCreditoIndividual.setDgRFC11(String.valueOf(c));
								break;
							case 11:
								solicitudCreditoIndividual.setDgRFC12(String.valueOf(c));
								break;
							case 12:
								solicitudCreditoIndividual.setDgRFC13(String.valueOf(c));
								break;

							}
						}
					}

					// Teléfono Fijo
					String telefonoFijo = customerReponse.getTelefonoFijo();
					if (telefonoFijo != null) {
						for (int n = 0; n < telefonoFijo.length(); n++) {
							char c = telefonoFijo.charAt(n);
							switch (n) {
							case 0:
								solicitudCreditoIndividual.setDgTelfFijo01(String.valueOf(c));
								break;
							case 1:
								solicitudCreditoIndividual.setDgTelfFijo02(String.valueOf(c));
								break;
							case 2:
								solicitudCreditoIndividual.setDgTelfFijo03(String.valueOf(c));
								break;
							case 3:
								solicitudCreditoIndividual.setDgTelfFijo04(String.valueOf(c));
								break;
							case 4:
								solicitudCreditoIndividual.setDgTelfFijo05(String.valueOf(c));
								break;
							case 5:
								solicitudCreditoIndividual.setDgTelfFijo06(String.valueOf(c));
								break;
							case 6:
								solicitudCreditoIndividual.setDgTelfFijo07(String.valueOf(c));
								break;
							case 7:
								solicitudCreditoIndividual.setDgTelfFijo08(String.valueOf(c));
								break;
							case 8:
								solicitudCreditoIndividual.setDgTelfFijo09(String.valueOf(c));
								break;
							case 9:
								solicitudCreditoIndividual.setDgTelfFijo10(String.valueOf(c));
								break;

							}
						}
					}
					// Celular
					String celular = customerReponse.getTelefonoCelular();
					if (celular != null) {
						for (int n = 0; n < celular.length(); n++) {
							char c = celular.charAt(n);
							switch (n) {
							case 0:
								solicitudCreditoIndividual.setDgCel01(String.valueOf(c));
								break;
							case 1:
								solicitudCreditoIndividual.setDgCel02(String.valueOf(c));
								break;
							case 2:
								solicitudCreditoIndividual.setDgCel03(String.valueOf(c));
								break;
							case 3:
								solicitudCreditoIndividual.setDgCel04(String.valueOf(c));
								break;
							case 4:
								solicitudCreditoIndividual.setDgCel05(String.valueOf(c));
								break;
							case 5:
								solicitudCreditoIndividual.setDgCel06(String.valueOf(c));
								break;
							case 6:
								solicitudCreditoIndividual.setDgCel07(String.valueOf(c));
								break;
							case 7:
								solicitudCreditoIndividual.setDgCel08(String.valueOf(c));
								break;
							case 8:
								solicitudCreditoIndividual.setDgCel09(String.valueOf(c));
								break;
							case 9:
								solicitudCreditoIndividual.setDgCel10(String.valueOf(c));
								break;

							}
						}
					}

					// Estado Civil
					if (customerReponse.getCodigoEstadoCivil() != null) {
						if (customerReponse.getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_CASADO))
							solicitudCreditoIndividual.setEsCasado("X");
						if (customerReponse.getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_SOLETERO))
							solicitudCreditoIndividual.setEsSoltero("X");
						if (customerReponse.getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_VIUDO))
							solicitudCreditoIndividual.setEsViudo("X");
						if (customerReponse.getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_DIVORCIADO))
							solicitudCreditoIndividual.setEsDivorciado("X");
						if (customerReponse.getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_UNILIBRE))
							solicitudCreditoIndividual.setEsUnionLibre("X");
					}
					// Género
					if (customerReponse.getCodigoGenero() != null) {
						if (customerReponse.getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_FEMEMINO))
							solicitudCreditoIndividual.setEsFemenino("X");

						if (customerReponse.getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_MASCULINO))
							solicitudCreditoIndividual.setEsMasculino("X");
					}
					// Tiene antecedentes buro
					if (customerReponse.getCtaEnBuroCredito() != null) {
						if ("S".equals(customerReponse.getCtaEnBuroCredito().trim()))
							solicitudCreditoIndividual.setTieneAntecedentesBuro("X");
						else if ("N".equals(customerReponse.getCtaEnBuroCredito().trim()))
							solicitudCreditoIndividual.setNoTieneAntecedentesBuro("X");
					} else {
						solicitudCreditoIndividual.setNoTieneAntecedentesBuro("X");
					}
					// Cuenta con un crédito grupal
					logger.logDebug("customerReponse.getTieneCreditoGrupal(): " + customerReponse.getTieneCreditoGrupal());
					if (customerReponse.getTieneCreditoGrupal() != null) {
						if ("S".equals(customerReponse.getTieneCreditoGrupal().trim()))
							solicitudCreditoIndividual.setTieneCredGrupal("X");
						else if ("N".equals(customerReponse.getTieneCreditoGrupal().trim()))
							solicitudCreditoIndividual.setNoTieneCredGrupal("X");
					} else {
						solicitudCreditoIndividual.setNoTieneCredGrupal("X");
					}

					// Dirección
					reportRequest.setOperation("DI");
					reportRequest.setType("RE");
					ReportLongIndCreditGenAddressCustomerResponse[] infoAddressResponse = servicesLongIndCreditApp.getAddressCustomer(reportRequest, sessionId, serviceIntegration);
					if (infoAddressResponse != null && infoAddressResponse.length > 0) {
						ReportLongIndCreditGenAddressCustomerResponse addressResponse = infoAddressResponse[0];
						if (addressResponse != null) {
							solicitudCreditoIndividual.setDireccion(addressResponse.getCalle());
							solicitudCreditoIndividual.setNumExt(addressResponse.getNroCalle());
							solicitudCreditoIndividual.setNumInt(addressResponse.getNroCalleInter());
							solicitudCreditoIndividual.setColonia(addressResponse.getParroquia());
							solicitudCreditoIndividual.setEstado(addressResponse.getProvincia());
							solicitudCreditoIndividual.setMunicipio(addressResponse.getCiudad());
							solicitudCreditoIndividual.setPais(addressResponse.getPais());
							solicitudCreditoIndividual.setCodigoPostal(addressResponse.getCodPostal());
							solicitudCreditoIndividual.setRefDomicilio(addressResponse.getReferenciaDomi());
							
							// CodigoPostal
							String codPostal= addressResponse.getCodPostal();
							if (codPostal != null) {
								for (int n = 0; n < codPostal.length(); n++) {
									char c = codPostal.charAt(n);
									switch (n) {
									case 0:
										solicitudCreditoIndividual.setCodigoPostal1(String.valueOf(c));
										break;
									case 1:
										solicitudCreditoIndividual.setCodigoPostal2(String.valueOf(c));
										break;
									case 2:
										solicitudCreditoIndividual.setCodigoPostal3(String.valueOf(c));
										break;
									case 3:
										solicitudCreditoIndividual.setCodigoPostal4(String.valueOf(c));
										break;
									case 4:
										solicitudCreditoIndividual.setCodigoPostal5(String.valueOf(c));
										break;
									}
								}
							}
							
						}

					}
					
					Services services = new Services();
					ParameterResponse reca = services.getParameter(4, "RDADHR", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (reca != null) {
						solicitudCreditoIndividual.setContraAdhesionS(reca.getParameterValue());
					}
					ParameterResponse pieAnio = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
					if (pieAnio != null) {
						solicitudCreditoIndividual.setPieAnio(pieAnio.getParameterValue());
					}					
				}
			}
		} catch (Exception ex) {
			throw ex;
		}
		return solicitudCreditoIndividual;
	}
}
