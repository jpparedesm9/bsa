package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenAddressCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenBusinessCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenInfoCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenReferensCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoIndividualLargaDTO;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoIndividualLargaNegociosDTO;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudCreditoIndividualLargaReferenciaDTO;
import com.cobiscorp.cobis.loans.reports.services.ServicesLongIndividualCreditApplication;

public class SolicitudCreditoIndividualLargaIMPL {
	private static final ILogger logger = LogFactory.getLogger(PagareListIMPL.class);

	ServicesLongIndividualCreditApplication servicesLongIndCreditApp = new ServicesLongIndividualCreditApplication();

	// Public
	public SolicitudCreditoIndividualLargaDTO getContenido(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {

		SolicitudCreditoIndividualLargaDTO solCredIndividualLargaDTO = new SolicitudCreditoIndividualLargaDTO();

		// Envio de parametros sueltos
		reportRequest.setOperation("IG");
		ReportLongIndCreditGenInfoCustomerResponse[] infoCustomerResponse = servicesLongIndCreditApp.getInfoCustomer(reportRequest, sessionId, serviceIntegration);

		//Cliente
		if (infoCustomerResponse != null) {
			if (infoCustomerResponse.length > 0) {

				solCredIndividualLargaDTO.setTiSucursal(infoCustomerResponse[0].getSucursal());
				solCredIndividualLargaDTO.setTiImporteSolicitado(infoCustomerResponse[0].getImporteSolicitado());
				solCredIndividualLargaDTO.setTiFecha(infoCustomerResponse[0].getFechaSolicitud());
				solCredIndividualLargaDTO.setDgApePaterno(infoCustomerResponse[0].getApellidoPaterno());
				solCredIndividualLargaDTO.setDgApeMaterno(infoCustomerResponse[0].getApellidoMaterno());
				solCredIndividualLargaDTO.setDgNombres(infoCustomerResponse[0].getPrimerNombre() + " " + infoCustomerResponse[0].getSegundoNombre());

				if (infoCustomerResponse[0].getFechaNacimiento() != null) {
					String fechaNac = infoCustomerResponse[0].getFechaNacimiento();
					String[] parts = fechaNac.split("/");
					solCredIndividualLargaDTO.setDgFechaNacDD(parts[0]);
					solCredIndividualLargaDTO.setDgFechaNacMM(parts[1]);
					solCredIndividualLargaDTO.setDgFechaNacAA(parts[2]);
				}

				if (infoCustomerResponse[0].getNumeroRFC() != null) {
					String telefCel = infoCustomerResponse[0].getNumeroRFC();
					for (int n = 0; n < telefCel.length(); n++) {
						char c = telefCel.charAt(n);
						if (n == 0)
							solCredIndividualLargaDTO.setDgRFC01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgRFC02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgRFC03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgRFC04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgRFC05(String.valueOf(c));
						if (n == 5)
							solCredIndividualLargaDTO.setDgRFC06(String.valueOf(c));
						if (n == 6)
							solCredIndividualLargaDTO.setDgRFC07(String.valueOf(c));
						if (n == 7)
							solCredIndividualLargaDTO.setDgRFC08(String.valueOf(c));
						if (n == 8)
							solCredIndividualLargaDTO.setDgRFC09(String.valueOf(c));
						if (n == 9)
							solCredIndividualLargaDTO.setDgRFC010(String.valueOf(c));
						if (n == 10)
							solCredIndividualLargaDTO.setDgRFC011(String.valueOf(c));
						if (n == 11)
							solCredIndividualLargaDTO.setDgRFC012(String.valueOf(c));
						if (n == 12)
							solCredIndividualLargaDTO.setDgRFC013(String.valueOf(c));
					}
				}

				if (infoCustomerResponse[0].getCodigoEstadoCivil() != null) {
					if (infoCustomerResponse[0].getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_CASADO))
						solCredIndividualLargaDTO.setDgEstCivCasado("X");
					if (infoCustomerResponse[0].getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_SOLETERO))
						solCredIndividualLargaDTO.setDgEstCivSoltero("X");
					if (infoCustomerResponse[0].getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_VIUDO))
						solCredIndividualLargaDTO.setDgEstCivViudo("X");
					if (infoCustomerResponse[0].getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_DIVORCIADO))
						solCredIndividualLargaDTO.setDgEstCivDivorciado("X");
					if (infoCustomerResponse[0].getCodigoEstadoCivil().trim().equals(ConstantValue.valueConstantCatalog.cl_ecivil_UNILIBRE))
						solCredIndividualLargaDTO.setDgEstCivUniLibre("X");
				}

				logger.logDebug("--->> infoCustomerResponse[0].getNumeroIfe():" + infoCustomerResponse[0].getNumeroIfe());
				logger.logDebug("--->> infoCustomerResponse[0].getNumeroPasaporte():" + infoCustomerResponse[0].getNumeroPasaporte());

				if (infoCustomerResponse[0].getNumeroIfe() != null) {
					if (infoCustomerResponse[0].getNumeroIfe().trim().equals("")) {
						if (infoCustomerResponse[0].getNumeroPasaporte() != null) {
							if (!infoCustomerResponse[0].getNumeroPasaporte().trim().equals("")) {
								String dato = infoCustomerResponse[0].getNumeroPasaporte();
								cargaPassIfe(dato, solCredIndividualLargaDTO);
								solCredIndividualLargaDTO.setDgPassSI("X");
							}
						}						
					} else {
						String dato = infoCustomerResponse[0].getNumeroIfe();
						cargaPassIfe(dato, solCredIndividualLargaDTO);
						solCredIndividualLargaDTO.setDgIfeSI("X");
					}
				} else {
					if (infoCustomerResponse[0].getNumeroPasaporte() != null) {
						if (!infoCustomerResponse[0].getNumeroPasaporte().trim().equals("")) {
							String dato = infoCustomerResponse[0].getNumeroPasaporte();
							cargaPassIfe(dato, solCredIndividualLargaDTO);
							solCredIndividualLargaDTO.setDgPassSI("X");
						}
					}
				}

				if (infoCustomerResponse[0].getCodigoGenero() != null) {
					if (infoCustomerResponse[0].getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_FEMEMINO))
						solCredIndividualLargaDTO.setDgGenFeme("X");

					if (infoCustomerResponse[0].getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_MASCULINO))
						solCredIndividualLargaDTO.setDgGenMasc("X");
				}

				if (infoCustomerResponse[0].getNumeroDocumento() != null) {

				}

				if (infoCustomerResponse[0].getNumeroDocumento() != null) {
					String curp = infoCustomerResponse[0].getNumeroDocumento();
					for (int n = 0; n < curp.length(); n++) {
						char c = curp.charAt(n);
						if (n == 0)
							solCredIndividualLargaDTO.setDgCurp01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgCurp02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgCurp03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgCurp04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgCurp05(String.valueOf(c));
						if (n == 5)
							solCredIndividualLargaDTO.setDgCurp06(String.valueOf(c));
						if (n == 6)
							solCredIndividualLargaDTO.setDgCurp07(String.valueOf(c));
						if (n == 7)
							solCredIndividualLargaDTO.setDgCurp08(String.valueOf(c));
						if (n == 8)
							solCredIndividualLargaDTO.setDgCurp09(String.valueOf(c));
						if (n == 9)
							solCredIndividualLargaDTO.setDgCurp10(String.valueOf(c));
						if (n == 10)
							solCredIndividualLargaDTO.setDgCurp11(String.valueOf(c));
						if (n == 11)
							solCredIndividualLargaDTO.setDgCurp12(String.valueOf(c));
						if (n == 12)
							solCredIndividualLargaDTO.setDgCurp13(String.valueOf(c));
						if (n == 13)
							solCredIndividualLargaDTO.setDgCurp14(String.valueOf(c));
						if (n == 14)
							solCredIndividualLargaDTO.setDgCurp15(String.valueOf(c));
						if (n == 15)
							solCredIndividualLargaDTO.setDgCurp16(String.valueOf(c));
						if (n == 16)
							solCredIndividualLargaDTO.setDgCurp17(String.valueOf(c));
						if (n == 17)
							solCredIndividualLargaDTO.setDgCurp18(String.valueOf(c));
					}
				}
				solCredIndividualLargaDTO.setDgPaisNacimiento(infoCustomerResponse[0].getDescripionPaisNacimiento());
				solCredIndividualLargaDTO.setDgEntidFederativaNac(infoCustomerResponse[0].getDescripcionEntidadNacimiento());
				solCredIndividualLargaDTO.setDgNacionalidad(infoCustomerResponse[0].getDescripcionPaisNacionalidad());
			}
		}

		// Direccion Domiciliaria - @i_operacion = 'DI', @i_tipo = 'RE' --Informacion Direcciones de Domiciliaria
		reportRequest.setOperation("DI");
		reportRequest.setType("RE");
		ReportLongIndCreditGenAddressCustomerResponse[] infoAddressResponse = servicesLongIndCreditApp.getAddressCustomer(reportRequest, sessionId, serviceIntegration);

		if (infoAddressResponse != null) {
			if (infoAddressResponse.length > 0) {
				solCredIndividualLargaDTO.setDgDireccionCalle(infoAddressResponse[0].getCalle());
				solCredIndividualLargaDTO.setDgNumExt(infoAddressResponse[0].getNroCalle());
				solCredIndividualLargaDTO.setDgNumInt(infoAddressResponse[0].getNroCalleInter());
				solCredIndividualLargaDTO.setRefCalle(infoAddressResponse[0].getReferenciaDomi());
				solCredIndividualLargaDTO.setDgColonia(infoAddressResponse[0].getParroquia());
				solCredIndividualLargaDTO.setDgEstado(infoAddressResponse[0].getProvincia());
				solCredIndividualLargaDTO.setDgMuniDelegacion(infoAddressResponse[0].getCiudad());
				solCredIndividualLargaDTO.setDgPais(infoAddressResponse[0].getPais());

				if (infoAddressResponse[0].getCodPostal() != null) {
					String curp = infoAddressResponse[0].getCodPostal();
					for (int n = 0; n < curp.length(); n++) {
						char c = curp.charAt(n);
						if (n == 0)
							solCredIndividualLargaDTO.setDgCodPostal01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgCodPostal02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgCodPostal03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgCodPostal04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgCodPostal05(String.valueOf(c));
					}
				}
			}
		}

		if (infoCustomerResponse != null) {
			if (infoCustomerResponse.length > 0) {
				if (infoCustomerResponse[0].getDiaLocalizacion() != null && infoCustomerResponse[0].getHoraLocalizacion() != null
						&& !infoCustomerResponse[0].getDiaLocalizacion().equals("") && !infoCustomerResponse[0].getHoraLocalizacion().equals("")) {
					solCredIndividualLargaDTO.setDgDiaHoraLocalizacion(infoCustomerResponse[0].getDiaLocalizacion() + " - " + infoCustomerResponse[0].getHoraLocalizacion());
					logger.logError("----->>>>Localizacion: dia= " + infoCustomerResponse[0].getDiaLocalizacion() + " hora= " + infoCustomerResponse[0].getHoraLocalizacion());
				} else {
					solCredIndividualLargaDTO.setDgDiaHoraLocalizacion("");
					logger.logError("----->>>>Sin Dia - Hora de Localizacion");
				}
				solCredIndividualLargaDTO.setDgEscolaridad(infoCustomerResponse[0].getDescripcionEscolaridad());
				solCredIndividualLargaDTO.setDgNumDependiente(String.valueOf(infoCustomerResponse[0].getNumeroDependientes()));
				solCredIndividualLargaDTO.setDgNumSerieFirmElecAvanzad(infoCustomerResponse[0].getNumeroSerieFirma());
			}
		}

		logger.logError("----->>>> !!!!!AAAA-- DDDD");

		if (infoAddressResponse != null) {
			if (infoAddressResponse.length > 0) {
				solCredIndividualLargaDTO.setDgArraigoDomicilio(infoAddressResponse[0].getTiempoResidencia());
				solCredIndividualLargaDTO.setDgNumPersVivenEnEstDomic(infoAddressResponse[0].getNroResidentes());

				// TipoVivienda
				if (infoAddressResponse[0].getCodTipoVivienda() != null) {
					if (infoAddressResponse[0].getCodTipoVivienda().trim().equals(ConstantValue.valueConstantCatalog.cl_tpropiedad_PROPIO))
						solCredIndividualLargaDTO.setDgTipoVivPropio("X");
					if (infoAddressResponse[0].getCodTipoVivienda().trim().equals(ConstantValue.valueConstantCatalog.cl_tpropiedad_RENTADO))
						solCredIndividualLargaDTO.setDgTipoVivRenta("X");
					if (infoAddressResponse[0].getCodTipoVivienda().trim().equals(ConstantValue.valueConstantCatalog.cl_tpropiedad_FAMILIARES))
						solCredIndividualLargaDTO.setDgTipoVivFamiliar("X");

				}
			}
		}

		if (infoCustomerResponse != null) {
			if (infoCustomerResponse.length > 0) {

				if (infoCustomerResponse[0].getCodigoOcupacion() != null) {
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_HOGAR))
						solCredIndividualLargaDTO.setDgOcupHogar("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_COMERCIANTE))
						solCredIndividualLargaDTO.setDgOcupComerciante("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_EMPRESARIO))
						solCredIndividualLargaDTO.setDgOcupEmpresario("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_JUBILADO))
						solCredIndividualLargaDTO.setDgOcupJubilado("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_ESTUDIANTE))
						solCredIndividualLargaDTO.setDgOcupEstudiante("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_DESEMPLEADO))
						solCredIndividualLargaDTO.setDgOcupDesempleado("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_ASALARIADO))
						solCredIndividualLargaDTO.setDgOcupAsalariado("X");
					if (infoCustomerResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_OTRO))
						solCredIndividualLargaDTO.setDgOcupOtros("X");
				}

				solCredIndividualLargaDTO.setDgActividad(infoCustomerResponse[0].getDescripcionActividad());

				// En el documento no se tiene este dato
				if (infoCustomerResponse[0].getCodigoActividad() != null) {
					if (infoCustomerResponse[0].getCodigoActividad().equals(""))
						solCredIndividualLargaDTO.setDgCatalogo("X");
					if (infoCustomerResponse[0].getCodigoActividad().equals(""))
						solCredIndividualLargaDTO.setDgLocal("X");
					if (infoCustomerResponse[0].getCodigoActividad().equals(""))
						solCredIndividualLargaDTO.setDgPuesto("X");
				}

				solCredIndividualLargaDTO.setDgCorreoElectronico(infoCustomerResponse[0].getCorreoElectronico());

				if (infoCustomerResponse[0].getTelefonoFijo() != null) {
					String curp = infoCustomerResponse[0].getTelefonoFijo();
					for (int n = 0; n < curp.length(); n++) {
						char c = curp.charAt(n);

						if (n == 0)
							solCredIndividualLargaDTO.setDgTelefFijo01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgTelefFijo02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgTelefFijo03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgTelefFijo04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgTelefFijo05(String.valueOf(c));
						if (n == 5)
							solCredIndividualLargaDTO.setDgTelefFijo06(String.valueOf(c));
						if (n == 6)
							solCredIndividualLargaDTO.setDgTelefFijo07(String.valueOf(c));
						if (n == 7)
							solCredIndividualLargaDTO.setDgTelefFijo08(String.valueOf(c));
						if (n == 8)
							solCredIndividualLargaDTO.setDgTelefFijo09(String.valueOf(c));
						if (n == 9)
							solCredIndividualLargaDTO.setDgTelefFijo010(String.valueOf(c));
					}
				}

				if (infoCustomerResponse[0].getTelefonoCelular() != null) {
					String curp = infoCustomerResponse[0].getTelefonoCelular();
					for (int n = 0; n < curp.length(); n++) {
						char c = curp.charAt(n);
						if (n == 0)
							solCredIndividualLargaDTO.setDgTelefCel01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgTelefCel02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgTelefCel03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgTelefCel04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgTelefCel05(String.valueOf(c));
						if (n == 5)
							solCredIndividualLargaDTO.setDgTelefCel06(String.valueOf(c));
						if (n == 6)
							solCredIndividualLargaDTO.setDgTelefCel07(String.valueOf(c));
						if (n == 7)
							solCredIndividualLargaDTO.setDgTelefCel08(String.valueOf(c));
						if (n == 8)
							solCredIndividualLargaDTO.setDgTelefCel09(String.valueOf(c));
						if (n == 9)
							solCredIndividualLargaDTO.setDgTelefCel010(String.valueOf(c));
					}
				}

				if (infoCustomerResponse[0].getTelefonoRecado() != null) {
					String curp = infoCustomerResponse[0].getTelefonoRecado();
					for (int n = 0; n < curp.length(); n++) {
						char c = curp.charAt(n);
						if (n == 0)
							solCredIndividualLargaDTO.setDgTelefRecados01(String.valueOf(c));
						if (n == 1)
							solCredIndividualLargaDTO.setDgTelefRecados02(String.valueOf(c));
						if (n == 2)
							solCredIndividualLargaDTO.setDgTelefRecados03(String.valueOf(c));
						if (n == 3)
							solCredIndividualLargaDTO.setDgTelefRecados04(String.valueOf(c));
						if (n == 4)
							solCredIndividualLargaDTO.setDgTelefRecados05(String.valueOf(c));
						if (n == 5)
							solCredIndividualLargaDTO.setDgTelefRecados06(String.valueOf(c));
						if (n == 6)
							solCredIndividualLargaDTO.setDgTelefRecados07(String.valueOf(c));
						if (n == 7)
							solCredIndividualLargaDTO.setDgTelefRecados08(String.valueOf(c));
						if (n == 8)
							solCredIndividualLargaDTO.setDgTelefRecados09(String.valueOf(c));
						if (n == 9)
							solCredIndividualLargaDTO.setDgTelefRecados010(String.valueOf(c));
					}
				}
				solCredIndividualLargaDTO.setDgNombrePersonaDejarRecado(infoCustomerResponse[0].getNombrePersonaRecado());

				if (infoCustomerResponse[0].getCtaEnBuroCredito() != null) {
					if (infoCustomerResponse[0].getCtaEnBuroCredito().equals("S"))
						solCredIndividualLargaDTO.setDgCuentaConBuroCredSI("X");
					if (infoCustomerResponse[0].getCtaEnBuroCredito().equals("N"))
						solCredIndividualLargaDTO.setDgCuentaConBuroCredNO("X");
				}

				if (infoCustomerResponse[0].getCargoPublico() != null) {
					if (infoCustomerResponse[0].getCargoPublico().trim().equals("") || infoCustomerResponse[0].getCargoPublico().trim().equals("null") || infoCustomerResponse[0].getCargoPublico() == "null") {
						solCredIndividualLargaDTO.setDgUstedDesemNO("X");
						solCredIndividualLargaDTO.setDgUstedDesemFuncion("");
					} else {
						solCredIndividualLargaDTO.setDgUstedDesemSI("X");
						solCredIndividualLargaDTO.setDgUstedDesemFuncion(infoCustomerResponse[0].getCargoPublico());
					}
				} else {
					solCredIndividualLargaDTO.setDgUstedDesemNO("X");
					solCredIndividualLargaDTO.setDgUstedDesemFuncion("");
				}

				if (infoCustomerResponse[0].getParentescoCargoPublico() != null) {
					if (infoCustomerResponse[0].getParentescoCargoPublico().trim().equals("") || infoCustomerResponse[0].getParentescoCargoPublico().equals("null") || infoCustomerResponse[0].getParentescoCargoPublico() == "null") {
						solCredIndividualLargaDTO.setDgUstedConyugeNO("X");
						solCredIndividualLargaDTO.setDgUstedConyugeTipoParentesco("");
					} else {
						solCredIndividualLargaDTO.setDgUstedConyugeSI("X");
						solCredIndividualLargaDTO.setDgUstedConyugeTipoParentesco(infoCustomerResponse[0].getParentescoCargoPublico());
					}
				} else {
					solCredIndividualLargaDTO.setDgUstedConyugeNO("X");
					solCredIndividualLargaDTO.setDgUstedConyugeTipoParentesco("");
				}

			}
		}

		// CONYUGE
		if (infoCustomerResponse != null) {
			if (infoCustomerResponse.length > 0) {
				logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga - Principal - conyug inicio");

				// if (infoCustomerResponse[0].getCodigoConyuge() != null) {
					logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga - Principal - conyug: " + infoCustomerResponse[0].getCodigoConyuge());
					ReportRequest reportRequestConyu = new ReportRequest();
					reportRequestConyu.setCustomerId(reportRequest.getCustomerId());
					reportRequestConyu.setDateFormat(ConstantValue.Params.FORMAT_DATE);
					reportRequestConyu.setOperation("IG");
					reportRequestConyu.setMode(1);
					ReportLongIndCreditGenInfoCustomerResponse[] infoConyugResponse = servicesLongIndCreditApp.getInfoCustomer(reportRequestConyu, sessionId, serviceIntegration);
					
					if (infoConyugResponse != null) {
						if (infoConyugResponse.length > 0) {

							solCredIndividualLargaDTO.setDatConyApePaterno(infoConyugResponse[0].getApellidoPaterno());
							solCredIndividualLargaDTO.setDatConyApeMaterno(infoConyugResponse[0].getApellidoMaterno());
							solCredIndividualLargaDTO.setDatConyNombres(infoConyugResponse[0].getPrimerNombre() + " " + infoConyugResponse[0].getSegundoNombre());

							if (infoConyugResponse[0].getCodigoOcupacion() != null) {
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_HOGAR))
									solCredIndividualLargaDTO.setDatConyOcupHogar("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_COMERCIANTE))
									solCredIndividualLargaDTO.setDatConyOcupComerciante("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_EMPRESARIO))
									solCredIndividualLargaDTO.setDatConyOcupEmpresario("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_JUBILADO))
									solCredIndividualLargaDTO.setDatConyOcupJubilado("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_ESTUDIANTE))
									solCredIndividualLargaDTO.setDatConyOcupEstudiante("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_DESEMPLEADO))
									solCredIndividualLargaDTO.setDatConyOcupDesempleado("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_ASALARIADO))
									solCredIndividualLargaDTO.setDatConyOcupAsalariado("X");
								if (infoConyugResponse[0].getCodigoOcupacion().trim().equals(ConstantValue.valueConstantCatalog.cl_profesion_OTRO))
									solCredIndividualLargaDTO.setDatConyOcupOtros("X");
							}
							
							if (infoConyugResponse[0].getFechaNacimiento() != null) {
								String conyFechaNac = infoConyugResponse[0].getFechaNacimiento();
								String[] parts = conyFechaNac.split("/");
								solCredIndividualLargaDTO.setDatConyFechaNacDD(parts[0]);
								solCredIndividualLargaDTO.setDatConyFechaNacMM(parts[1]);
								solCredIndividualLargaDTO.setDatConyFechaNacAA(parts[2]);
							}

							if (infoConyugResponse[0].getCodigoGenero() != null) {
								if (infoConyugResponse[0].getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_FEMEMINO))
									solCredIndividualLargaDTO.setDatConyGenFeme("X");
								if (infoConyugResponse[0].getCodigoGenero().trim().equals(ConstantValue.valueConstantCatalog.cl_sexo_MASCULINO))
									solCredIndividualLargaDTO.setDatConyGenMasc("X");
							}

							solCredIndividualLargaDTO.setDatConyPaisNacimiento(infoConyugResponse[0].getDescripionPaisNacimiento());
							solCredIndividualLargaDTO.setDatConyEntidFinanciera(infoConyugResponse[0].getDescripcionEntidadNacimiento());
							solCredIndividualLargaDTO.setDatConyNacionalidad(infoConyugResponse[0].getDescripcionPaisNacionalidad());
							solCredIndividualLargaDTO.setDatConyEscolaridad(infoConyugResponse[0].getDescripcionEscolaridad());
						}
					}

					// Direccion Domiciliaria - @i_operacion = 'DI', @i_tipo = 'RE' --Informacion Direcciones de Domiciliaria
					reportRequestConyu.setOperation("DI");
					reportRequestConyu.setType("RE");
					ReportLongIndCreditGenAddressCustomerResponse[] infoAddressConyugeResponse = servicesLongIndCreditApp.getAddressCustomer(reportRequestConyu, sessionId, serviceIntegration);

					if (infoAddressConyugeResponse != null) {
						if (infoAddressConyugeResponse.length > 0) {
							solCredIndividualLargaDTO.setDatConyDireccionTrabCalle(infoAddressConyugeResponse[0].getCalle());
							solCredIndividualLargaDTO.setDatConyNumExt(infoAddressConyugeResponse[0].getNroCalle());
							solCredIndividualLargaDTO.setDatConyNumInt(infoAddressConyugeResponse[0].getNroCalleInter());
							solCredIndividualLargaDTO.setDatConyColonia(infoAddressConyugeResponse[0].getParroquia());
							solCredIndividualLargaDTO.setDatConyEstado(infoAddressConyugeResponse[0].getProvincia());
							solCredIndividualLargaDTO.setDatConyMuniDelegacion(infoAddressConyugeResponse[0].getCiudad());
							solCredIndividualLargaDTO.setDatConyPais(infoAddressConyugeResponse[0].getPais());

							if (infoAddressConyugeResponse[0].getCodPostal() != null) {
								String curp = infoAddressConyugeResponse[0].getCodPostal();
								for (int n = 0; n < curp.length(); n++) {
									char c = curp.charAt(n);
									if (n == 0)
										solCredIndividualLargaDTO.setDatConyCodPostal01(String.valueOf(c));
									if (n == 1)
										solCredIndividualLargaDTO.setDatConyCodPostal02(String.valueOf(c));
									if (n == 2)
										solCredIndividualLargaDTO.setDatConyCodPostal03(String.valueOf(c));
									if (n == 3)
										solCredIndividualLargaDTO.setDatConyCodPostal04(String.valueOf(c));
									if (n == 4)
										solCredIndividualLargaDTO.setDatConyCodPostal05(String.valueOf(c));
								}
							}
						}
					}

					if (infoConyugResponse != null) {
						if (infoConyugResponse.length > 0) {
							if (infoConyugResponse[0].getTelefonoCelular() != null) {
								String curp = infoConyugResponse[0].getTelefonoCelular();
								for (int n = 0; n < curp.length(); n++) {
									char c = curp.charAt(n);
									if (n == 0)
										solCredIndividualLargaDTO.setDatConyTelefCel01(String.valueOf(c));
									if (n == 1)
										solCredIndividualLargaDTO.setDatConyTelefCel02(String.valueOf(c));
									if (n == 2)
										solCredIndividualLargaDTO.setDatConyTelefCel03(String.valueOf(c));
									if (n == 3)
										solCredIndividualLargaDTO.setDatConyTelefCel04(String.valueOf(c));
									if (n == 4)
										solCredIndividualLargaDTO.setDatConyTelefCel05(String.valueOf(c));
									if (n == 5)
										solCredIndividualLargaDTO.setDatConyTelefCel06(String.valueOf(c));
									if (n == 6)
										solCredIndividualLargaDTO.setDatConyTelefCel07(String.valueOf(c));
									if (n == 7)
										solCredIndividualLargaDTO.setDatConyTelefCel08(String.valueOf(c));
									if (n == 8)
										solCredIndividualLargaDTO.setDatConyTelefCel09(String.valueOf(c));
									if (n == 9)
										solCredIndividualLargaDTO.setDatConyTelefCel010(String.valueOf(c));
								}
							}
						}
					}
				//}
				solCredIndividualLargaDTO.setEcoMMNIngresoVentas(infoCustomerResponse[0].getIngresosVentas());
				solCredIndividualLargaDTO.setEcoMMNOtrosIngresos(infoCustomerResponse[0].getOtrosIngresos());
				solCredIndividualLargaDTO.setEcoMMNTotalIngresosSum(infoCustomerResponse[0].getTotalIngresos());
				solCredIndividualLargaDTO.setEcoMMNGastosNegocios(infoCustomerResponse[0].getGastosNegocio());
				solCredIndividualLargaDTO.setEcoMMNGastosFamiliares(infoCustomerResponse[0].getGastosFamiliares());
				solCredIndividualLargaDTO.setEcoMMNTotalGastos(infoCustomerResponse[0].getTotalGastos());
				solCredIndividualLargaDTO.setEcoMMNCapacidadPago(infoCustomerResponse[0].getCapacidadPago());
				solCredIndividualLargaDTO.setFirmaNombreSolicitante(infoCustomerResponse[0].getApellidoPaterno() + " " + infoCustomerResponse[0].getApellidoMaterno() + " " + infoCustomerResponse[0].getPrimerNombre() + " "
						+ infoCustomerResponse[0].getSegundoNombre());
				solCredIndividualLargaDTO.setFirmaNombreAsesor(infoCustomerResponse[0].getNombreAsesor());
				solCredIndividualLargaDTO.setFirmaNombreCoordinador(infoCustomerResponse[0].getNombreCoordinador());
				solCredIndividualLargaDTO.setFirmaNombreAnalistaOper(infoCustomerResponse[0].getNombreAnalista());				
				
			}
		} else {
			initDataInfoCustomer(solCredIndividualLargaDTO);
		}

		// Envio de Listas
		List<SolicitudCreditoIndividualLargaReferenciaDTO> referencia = new ArrayList<SolicitudCreditoIndividualLargaReferenciaDTO>();
		List<SolicitudCreditoIndividualLargaNegociosDTO> negocio = new ArrayList<SolicitudCreditoIndividualLargaNegociosDTO>();

		referencia = getReferences(reportRequest, sessionId, serviceIntegration);
		negocio = getNegocios(reportRequest, sessionId, serviceIntegration);

		solCredIndividualLargaDTO.setNegocio(negocio);
		solCredIndividualLargaDTO.setReferencia(referencia);

		return solCredIndividualLargaDTO;

	}

	public List<SolicitudCreditoIndividualLargaReferenciaDTO> getReferences(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getReferences");
		reportRequest.setOperation("RP");
		ReportLongIndCreditGenReferensCustomerResponse[] responseResult = servicesLongIndCreditApp.getReferencesCustomer(reportRequest, sessionId, serviceIntegration);
		List<SolicitudCreditoIndividualLargaReferenciaDTO> dataBeanList = new ArrayList<SolicitudCreditoIndividualLargaReferenciaDTO>();

		if (responseResult != null) {
			logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getReferences-length:" + responseResult.length);
			if (responseResult.length > 0) {
				for (ReportLongIndCreditGenReferensCustomerResponse response : responseResult) {
					SolicitudCreditoIndividualLargaReferenciaDTO scilReferenc = new SolicitudCreditoIndividualLargaReferenciaDTO();
					scilReferenc.setReferNum(String.valueOf(response.getNumero()));
					scilReferenc.setReferApePaterno(response.getPrimerApellido());
					scilReferenc.setReferApeMaterno(response.getSegundoApellido());
					scilReferenc.setReferNombres(response.getNombre());

					if (response.getTelefonoCelular() != null) {
						String telefCel = response.getTelefonoCelular();
						for (int n = 0; n < telefCel.length(); n++) {
							char c = telefCel.charAt(n);
							if (n == 0)
								scilReferenc.setReferTelefCel01(String.valueOf(c));
							if (n == 1)
								scilReferenc.setReferTelefCel02(String.valueOf(c));
							if (n == 2)
								scilReferenc.setReferTelefCel03(String.valueOf(c));
							if (n == 3)
								scilReferenc.setReferTelefCel04(String.valueOf(c));
							if (n == 4)
								scilReferenc.setReferTelefCel05(String.valueOf(c));
							if (n == 5)
								scilReferenc.setReferTelefCel06(String.valueOf(c));
							if (n == 6)
								scilReferenc.setReferTelefCel07(String.valueOf(c));
							if (n == 7)
								scilReferenc.setReferTelefCel08(String.valueOf(c));
							if (n == 8)
								scilReferenc.setReferTelefCel09(String.valueOf(c));
							if (n == 9)
								scilReferenc.setReferTelefCel10(String.valueOf(c));
						}
					}

					logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getTelefonoDomicilio:" + response.getTelefonoDomicilio());
					if (response.getTelefonoDomicilio() != null) {
						logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getTelefonoDomicilio---A");
						String telefFijo = response.getTelefonoDomicilio();
						for (int n = 0; n < telefFijo.length(); n++) {
							char c = telefFijo.charAt(n);
							if (n == 0)
								scilReferenc.setReferTelefFijo01(String.valueOf(c));
							if (n == 1)
								scilReferenc.setReferTelefFijo02(String.valueOf(c));
							if (n == 2)
								scilReferenc.setReferTelefFijo03(String.valueOf(c));
							if (n == 3)
								scilReferenc.setReferTelefFijo04(String.valueOf(c));
							if (n == 4)
								scilReferenc.setReferTelefFijo05(String.valueOf(c));
							if (n == 5)
								scilReferenc.setReferTelefFijo06(String.valueOf(c));
							if (n == 6)
								scilReferenc.setReferTelefFijo07(String.valueOf(c));
							if (n == 7)
								scilReferenc.setReferTelefFijo08(String.valueOf(c));
							if (n == 8)
								scilReferenc.setReferTelefFijo09(String.valueOf(c));
							if (n == 9)
								scilReferenc.setReferTelefFijo10(String.valueOf(c));
						}
					}
					scilReferenc.setReferCorreoElect(response.getCorreo());
					scilReferenc.setReferTiempoConocerlo(String.valueOf(response.getTiempoConocido()));
					dataBeanList.add(scilReferenc);
				}
			} else {
				initReferences(dataBeanList);
			}
		} else {
			logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getReferences - null");
			initReferences(dataBeanList);
		}
		return dataBeanList;
	}

	private static void initReferences(List<SolicitudCreditoIndividualLargaReferenciaDTO> dataBeanList) {
		SolicitudCreditoIndividualLargaReferenciaDTO scilReferenc = new SolicitudCreditoIndividualLargaReferenciaDTO();
		scilReferenc.setReferNum("");
		scilReferenc.setReferApePaterno("");
		scilReferenc.setReferApeMaterno("");
		scilReferenc.setReferNombres("");
		scilReferenc.setReferTelefCel01("");
		scilReferenc.setReferTelefCel02("");
		scilReferenc.setReferTelefCel03("");
		scilReferenc.setReferTelefCel04("");
		scilReferenc.setReferTelefCel05("");
		scilReferenc.setReferTelefCel06("");
		scilReferenc.setReferTelefCel07("");
		scilReferenc.setReferTelefCel08("");
		scilReferenc.setReferTelefCel09("");
		scilReferenc.setReferTelefCel10("");
		scilReferenc.setReferTelefFijo01("");
		scilReferenc.setReferTelefFijo02("");
		scilReferenc.setReferTelefFijo03("");
		scilReferenc.setReferTelefFijo04("");
		scilReferenc.setReferTelefFijo05("");
		scilReferenc.setReferTelefFijo06("");
		scilReferenc.setReferTelefFijo07("");
		scilReferenc.setReferTelefFijo08("");
		scilReferenc.setReferTelefFijo09("");
		scilReferenc.setReferTelefFijo10("");
		scilReferenc.setReferCorreoElect("");
		scilReferenc.setReferTiempoConocerlo("");
		dataBeanList.add(scilReferenc);
	}

	public List<SolicitudCreditoIndividualLargaNegociosDTO> getNegocios(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getNegocios");
		reportRequest.setOperation("NC");
		ReportLongIndCreditGenBusinessCustomerResponse[] responseResult = servicesLongIndCreditApp.getBusinessCustomer(reportRequest, sessionId, serviceIntegration);
		List<SolicitudCreditoIndividualLargaNegociosDTO> dataBeanList = new ArrayList<SolicitudCreditoIndividualLargaNegociosDTO>();

		if (responseResult != null) {
			logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getNegocios-length:" + responseResult.length);
			if (responseResult.length > 0) {
				// for (ReportLongIndCreditGenBusinessCustomerResponse response : responseResult) {
				ReportLongIndCreditGenBusinessCustomerResponse response = responseResult[0];
				SolicitudCreditoIndividualLargaNegociosDTO scilNegocios = new SolicitudCreditoIndividualLargaNegociosDTO();
				scilNegocios.setDgnNombreNegocio(response.getNegocio());
				logger.logDebug("----->>>> AAAAA-response.getGiro():" + response.getGiro());
				scilNegocios.setDgnFechaApertura(response.getFechaApertura());
				scilNegocios.setDgnGiroNegocio(response.getGiro());

				if (response.getDestinoCredito() != null) {
					if (response.getDestinoCredito().trim().equals(ConstantValue.valueConstantCatalog.cl_destino_credito_COMPRA_ACTIVO))
						scilNegocios.setDgnDestinoCredCompraActivo("X");
					if (response.getDestinoCredito().trim().equals(ConstantValue.valueConstantCatalog.cl_destino_credito_CAPITAL_TRABAJO))
						scilNegocios.setDgnDestinoCredCapTrabajo("X");
				}

				scilNegocios.setDgnDireccion(response.getDireccion());
				
				if (response.getNumeroExterno() != null) {
					scilNegocios.setDgnNumExterno(String.valueOf(response.getNumeroExterno()));
				} else {
					scilNegocios.setDgnNumExterno("");
				}
				logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - response.getNumeroInterno():" + response.getNumeroInterno()+"--");
				if (response.getNumeroInterno() != null) {
					scilNegocios.setDgnNumInterno(String.valueOf(response.getNumeroInterno()));
				}else{
					scilNegocios.setDgnNumInterno(" ");	
				}				
				scilNegocios.setDgnColonia(response.getColonia());
				scilNegocios.setDgnEstado(response.getDescEstado());
				scilNegocios.setDgnMunicDelegacion(response.getMunicipio());
				scilNegocios.setDgnPais(response.getDescPais());

				if (response.getCodPostal() != null) {
					String codPostal = response.getCodPostal();
					for (int n = 0; n < codPostal.length(); n++) {
						char c = codPostal.charAt(n);
						if (n == 0)
							scilNegocios.setDgnCodPostal01(String.valueOf(c));
						if (n == 1)
							scilNegocios.setDgnCodPostal02(String.valueOf(c));
						if (n == 2)
							scilNegocios.setDgnCodPostal03(String.valueOf(c));
						if (n == 3)
							scilNegocios.setDgnCodPostal04(String.valueOf(c));
						if (n == 4)
							scilNegocios.setDgnCodPostal05(String.valueOf(c));
					}
				}

				if (response.getTelefono() != null) {
					String telef = response.getTelefono();
					for (int n = 0; n < telef.length(); n++) {
						char c = telef.charAt(n);
						if (n == 0)
							scilNegocios.setDgnTelefCel01(String.valueOf(c));
						if (n == 1)
							scilNegocios.setDgnTelefCel02(String.valueOf(c));
						if (n == 2)
							scilNegocios.setDgnTelefCel03(String.valueOf(c));
						if (n == 3)
							scilNegocios.setDgnTelefCel04(String.valueOf(c));
						if (n == 4)
							scilNegocios.setDgnTelefCel05(String.valueOf(c));
						if (n == 5)
							scilNegocios.setDgnTelefCel06(String.valueOf(c));
						if (n == 6)
							scilNegocios.setDgnTelefCel07(String.valueOf(c));
						if (n == 7)
							scilNegocios.setDgnTelefCel08(String.valueOf(c));
						if (n == 8)
							scilNegocios.setDgnTelefCel09(String.valueOf(c));
						if (n == 9)
							scilNegocios.setDgnTelefCel010(String.valueOf(c));
					}
				}

				scilNegocios.setDgnExperienciaActi(response.getTiempoActividad());
				scilNegocios.setDgnArraigoNegocio(response.getTiempoArraigo());
				// ¿CON QUE RECURSOS PAGARÍA USTED EL CRÉDITO?
				if (response.getTipoRecurso() != null) {
					if (response.getTipoRecurso().trim().equals(ConstantValue.valueConstantCatalog.cl_recursos_credito_NEGOCIO_PROPIO))
						scilNegocios.setDgnPagarCredNegPropio("X");
					if (response.getTipoRecurso().trim().equals(ConstantValue.valueConstantCatalog.cl_recursos_credito_ENVIO_DINERO))
						scilNegocios.setDgnPagarCredEnvioDinero("X");
					if (response.getTipoRecurso().trim().equals(ConstantValue.valueConstantCatalog.cl_recursos_credito_TERCEROS))
						scilNegocios.setDgnPagarCredTerceros("X");
					if (response.getTipoRecurso().trim().equals(ConstantValue.valueConstantCatalog.cl_recursos_credito_APOYO_FAMILIAR))
						scilNegocios.setDgnPagarCredApoyoFamiliar("X");
					if (response.getTipoRecurso().trim().equals(ConstantValue.valueConstantCatalog.cl_recursos_credito_PENSION))
						scilNegocios.setDgnPagarCredPension("X");
				}

				// Tipo Local
				if (response.getTipoLocal() != null) {
					if (response.getTipoLocal().trim().equals(ConstantValue.valueConstantCatalog.cr_tipo_local_PROPIO))
						scilNegocios.setDgnTipoLocalPropio("X");
					if (response.getTipoLocal().trim().equals(ConstantValue.valueConstantCatalog.cr_tipo_local_RENTADO))
						scilNegocios.setDgnTipoLocalRentado("X");
					if (response.getTipoLocal().trim().equals(ConstantValue.valueConstantCatalog.cr_tipo_local_MISMO_DOMICILIO))
						scilNegocios.setDgnTipoLocalMismoDom("X");
					if (response.getTipoLocal().trim().equals(ConstantValue.valueConstantCatalog.cr_tipo_local_AMBULANTE))
						scilNegocios.setDgnPagarCredAmbutante("X");
					if (response.getTipoLocal().trim().equals(ConstantValue.valueConstantCatalog.cr_tipo_local_MERCADO))
						scilNegocios.setDgnPagarCredMercado("X");
				}

				scilNegocios.setDgnActividadEco(response.getDescActividad());
				dataBeanList.add(scilNegocios);
				// }
			} else {
				initNegocios(dataBeanList);
			}
		} else {
			logger.logDebug("----->>>> Reporte Solicitud Credito Individual Larga Inicio Sub - SolicitudCreditoIndividualLargaIMPL - getNegocios - null");
			initNegocios(dataBeanList);
		}
		return dataBeanList;
	}

	private static void initNegocios(List<SolicitudCreditoIndividualLargaNegociosDTO> dataBeanList) {
		SolicitudCreditoIndividualLargaNegociosDTO scilNegocios = new SolicitudCreditoIndividualLargaNegociosDTO();
		scilNegocios.setDgnNombreNegocio("");
		scilNegocios.setDgnFechaApertura("");
		scilNegocios.setDgnGiroNegocio("");
		scilNegocios.setDgnDestinoCredCompraActivo("");
		scilNegocios.setDgnDestinoCredCapTrabajo("");
		scilNegocios.setDgnDireccion("");
		scilNegocios.setDgnNumExterno("");
		scilNegocios.setDgnNumInterno("");
		scilNegocios.setDgnColonia("");
		scilNegocios.setDgnEstado("");
		scilNegocios.setDgnMunicDelegacion("");
		scilNegocios.setDgnPais("");
		scilNegocios.setDgnCodPostal01("");
		scilNegocios.setDgnCodPostal02("");
		scilNegocios.setDgnCodPostal03("");
		scilNegocios.setDgnCodPostal04("");
		scilNegocios.setDgnCodPostal05("");
		scilNegocios.setDgnTelefCel01("");
		scilNegocios.setDgnTelefCel02("");
		scilNegocios.setDgnTelefCel03("");
		scilNegocios.setDgnTelefCel04("");
		scilNegocios.setDgnTelefCel05("");
		scilNegocios.setDgnTelefCel06("");
		scilNegocios.setDgnTelefCel07("");
		scilNegocios.setDgnTelefCel08("");
		scilNegocios.setDgnTelefCel09("");
		scilNegocios.setDgnTelefCel010("");
		scilNegocios.setDgnExperienciaActi("");
		scilNegocios.setDgnArraigoNegocio("");
		scilNegocios.setDgnPagarCredNegPropio("");
		scilNegocios.setDgnPagarCredEnvioDinero("");
		scilNegocios.setDgnPagarCredTerceros("");
		scilNegocios.setDgnPagarCredApoyoFamiliar("");
		scilNegocios.setDgnPagarCredPension("");
		scilNegocios.setDgnTipoLocalPropio("");
		scilNegocios.setDgnTipoLocalRentado("");
		scilNegocios.setDgnTipoLocalMismoDom("");
		scilNegocios.setDgnPagarCredAmbutante("");
		scilNegocios.setDgnPagarCredMercado("");
		scilNegocios.setDgnActividadEco("");
		dataBeanList.add(scilNegocios);
	}

	public void initDataInfoCustomer(SolicitudCreditoIndividualLargaDTO solCredIndividualLargaDTO) {
		solCredIndividualLargaDTO.setTiSucursal("");
		solCredIndividualLargaDTO.setTiImporteSolicitado(0.0);
		solCredIndividualLargaDTO.setTiFecha("");
		solCredIndividualLargaDTO.setDgApePaterno("");
		solCredIndividualLargaDTO.setDgApeMaterno("");
		solCredIndividualLargaDTO.setDgNombres("");
		solCredIndividualLargaDTO.setDgFechaNacDD("");
		solCredIndividualLargaDTO.setDgFechaNacMM("");
		solCredIndividualLargaDTO.setDgFechaNacAA("");
		solCredIndividualLargaDTO.setDgRFC01("");
		solCredIndividualLargaDTO.setDgRFC02("");
		solCredIndividualLargaDTO.setDgRFC03("");
		solCredIndividualLargaDTO.setDgRFC04("");
		solCredIndividualLargaDTO.setDgRFC05("");
		solCredIndividualLargaDTO.setDgRFC06("");
		solCredIndividualLargaDTO.setDgRFC07("");
		solCredIndividualLargaDTO.setDgRFC08("");
		solCredIndividualLargaDTO.setDgRFC09("");
		solCredIndividualLargaDTO.setDgRFC010("");
		solCredIndividualLargaDTO.setDgRFC011("");
		solCredIndividualLargaDTO.setDgRFC012("");
		solCredIndividualLargaDTO.setDgRFC013("");
		solCredIndividualLargaDTO.setDgEstCivCasado("");
		solCredIndividualLargaDTO.setDgEstCivSoltero("");
		solCredIndividualLargaDTO.setDgEstCivViudo("");
		solCredIndividualLargaDTO.setDgEstCivDivorciado("");
		solCredIndividualLargaDTO.setDgEstCivUniLibre("");
		solCredIndividualLargaDTO.setDgNumPas01("");
		solCredIndividualLargaDTO.setDgNumPas02("");
		solCredIndividualLargaDTO.setDgNumPas03("");
		solCredIndividualLargaDTO.setDgNumPas04("");
		solCredIndividualLargaDTO.setDgNumPas05("");
		solCredIndividualLargaDTO.setDgNumPas06("");
		solCredIndividualLargaDTO.setDgNumPas07("");
		solCredIndividualLargaDTO.setDgNumPas08("");
		solCredIndividualLargaDTO.setDgNumPas09("");
		solCredIndividualLargaDTO.setDgNumPas10("");
		solCredIndividualLargaDTO.setDgNumPas11("");
		solCredIndividualLargaDTO.setDgNumPas12("");
		solCredIndividualLargaDTO.setDgNumPas13("");
		solCredIndividualLargaDTO.setDgGenFeme("");
		solCredIndividualLargaDTO.setDgGenMasc("");
		solCredIndividualLargaDTO.setDgCurp01("");
		solCredIndividualLargaDTO.setDgCurp02("");
		solCredIndividualLargaDTO.setDgCurp03("");
		solCredIndividualLargaDTO.setDgCurp04("");
		solCredIndividualLargaDTO.setDgCurp05("");
		solCredIndividualLargaDTO.setDgCurp06("");
		solCredIndividualLargaDTO.setDgCurp07("");
		solCredIndividualLargaDTO.setDgCurp08("");
		solCredIndividualLargaDTO.setDgCurp09("");
		solCredIndividualLargaDTO.setDgCurp10("");
		solCredIndividualLargaDTO.setDgCurp11("");
		solCredIndividualLargaDTO.setDgCurp12("");
		solCredIndividualLargaDTO.setDgCurp13("");
		solCredIndividualLargaDTO.setDgCurp14("");
		solCredIndividualLargaDTO.setDgCurp15("");
		solCredIndividualLargaDTO.setDgCurp16("");
		solCredIndividualLargaDTO.setDgCurp17("");
		solCredIndividualLargaDTO.setDgCurp18("");
		solCredIndividualLargaDTO.setDgPaisNacimiento("");
		solCredIndividualLargaDTO.setDgEntidFederativaNac("");
		solCredIndividualLargaDTO.setDgNacionalidad("");
		solCredIndividualLargaDTO.setDgDireccionCalle("");
		solCredIndividualLargaDTO.setDgNumExt("");
		solCredIndividualLargaDTO.setDgNumInt("");
		solCredIndividualLargaDTO.setDgColonia("");
		solCredIndividualLargaDTO.setDgEstado("");
		solCredIndividualLargaDTO.setDgMuniDelegacion("");
		solCredIndividualLargaDTO.setDgPais("");
		solCredIndividualLargaDTO.setDgCodPostal01("");
		solCredIndividualLargaDTO.setDgCodPostal02("");
		solCredIndividualLargaDTO.setDgCodPostal03("");
		solCredIndividualLargaDTO.setDgCodPostal04("");
		solCredIndividualLargaDTO.setDgCodPostal05("");
		solCredIndividualLargaDTO.setDgDiaHoraLocalizacion("");
		solCredIndividualLargaDTO.setDgEscolaridad("");
		solCredIndividualLargaDTO.setDgNumDependiente("");
		solCredIndividualLargaDTO.setDgNumSerieFirmElecAvanzad("");
		solCredIndividualLargaDTO.setDgArraigoDomicilio("");
		solCredIndividualLargaDTO.setDgNumPersVivenEnEstDomic("");
		solCredIndividualLargaDTO.setDgTipoVivPropio("");
		solCredIndividualLargaDTO.setDgTipoVivRenta("");
		solCredIndividualLargaDTO.setDgTipoVivFamiliar("");
		solCredIndividualLargaDTO.setDgOcupHogar("");
		solCredIndividualLargaDTO.setDgOcupComerciante("");
		solCredIndividualLargaDTO.setDgOcupEmpresario("");
		solCredIndividualLargaDTO.setDgOcupJubilado("");
		solCredIndividualLargaDTO.setDgOcupEstudiante("");
		solCredIndividualLargaDTO.setDgOcupDesempleado("");
		solCredIndividualLargaDTO.setDgOcupAsalariado("");
		solCredIndividualLargaDTO.setDgOcupOtros("");
		solCredIndividualLargaDTO.setDgActividad("");
		solCredIndividualLargaDTO.setDgCatalogo("");
		solCredIndividualLargaDTO.setDgLocal("");
		solCredIndividualLargaDTO.setDgPuesto("");
		solCredIndividualLargaDTO.setDgCorreoElectronico("");
		solCredIndividualLargaDTO.setDgTelefFijo01("");
		solCredIndividualLargaDTO.setDgTelefFijo02("");
		solCredIndividualLargaDTO.setDgTelefFijo03("");
		solCredIndividualLargaDTO.setDgTelefFijo04("");
		solCredIndividualLargaDTO.setDgTelefFijo05("");
		solCredIndividualLargaDTO.setDgTelefFijo06("");
		solCredIndividualLargaDTO.setDgTelefFijo07("");
		solCredIndividualLargaDTO.setDgTelefFijo08("");
		solCredIndividualLargaDTO.setDgTelefFijo09("");
		solCredIndividualLargaDTO.setDgTelefFijo010("");
		solCredIndividualLargaDTO.setDgTelefCel01("");
		solCredIndividualLargaDTO.setDgTelefCel02("");
		solCredIndividualLargaDTO.setDgTelefCel03("");
		solCredIndividualLargaDTO.setDgTelefCel04("");
		solCredIndividualLargaDTO.setDgTelefCel05("");
		solCredIndividualLargaDTO.setDgTelefCel06("");
		solCredIndividualLargaDTO.setDgTelefCel07("");
		solCredIndividualLargaDTO.setDgTelefCel08("");
		solCredIndividualLargaDTO.setDgTelefCel09("");
		solCredIndividualLargaDTO.setDgTelefCel010("");
		solCredIndividualLargaDTO.setDgTelefRecados01("");
		solCredIndividualLargaDTO.setDgTelefRecados02("");
		solCredIndividualLargaDTO.setDgTelefRecados03("");
		solCredIndividualLargaDTO.setDgTelefRecados04("");
		solCredIndividualLargaDTO.setDgTelefRecados05("");
		solCredIndividualLargaDTO.setDgTelefRecados06("");
		solCredIndividualLargaDTO.setDgTelefRecados07("");
		solCredIndividualLargaDTO.setDgTelefRecados08("");
		solCredIndividualLargaDTO.setDgTelefRecados09("");
		solCredIndividualLargaDTO.setDgTelefRecados010("");
		solCredIndividualLargaDTO.setDgNombrePersonaDejarRecado("");
		solCredIndividualLargaDTO.setDgCuentaConBuroCredSI("");
		solCredIndividualLargaDTO.setDgCuentaConBuroCredNO("");
		solCredIndividualLargaDTO.setDgUstedDesemSI("");
		solCredIndividualLargaDTO.setDgUstedDesemFuncion("");
		solCredIndividualLargaDTO.setDgUstedDesemNO("");
		solCredIndividualLargaDTO.setDgUstedConyugeSI("");
		solCredIndividualLargaDTO.setDgUstedConyugeTipoParentesco("");
		solCredIndividualLargaDTO.setDgUstedConyugeNO("");
		solCredIndividualLargaDTO.setDatConyApePaterno("");
		solCredIndividualLargaDTO.setDatConyApeMaterno("");
		solCredIndividualLargaDTO.setDatConyNombres("");
		solCredIndividualLargaDTO.setDatConyOcupHogar("");
		solCredIndividualLargaDTO.setDatConyOcupComerciante("");
		solCredIndividualLargaDTO.setDatConyOcupEmpresario("");
		solCredIndividualLargaDTO.setDatConyOcupJubilado("");
		solCredIndividualLargaDTO.setDatConyOcupEstudiante("");
		solCredIndividualLargaDTO.setDatConyOcupDesempleado("");
		solCredIndividualLargaDTO.setDatConyOcupAsalariado("");
		solCredIndividualLargaDTO.setDatConyOcupOtros("");
		solCredIndividualLargaDTO.setDatConyFechaNacDD("");
		solCredIndividualLargaDTO.setDatConyFechaNacMM("");
		solCredIndividualLargaDTO.setDatConyFechaNacAA("");
		solCredIndividualLargaDTO.setDatConyGenFeme("");
		solCredIndividualLargaDTO.setDatConyGenMasc("");
		solCredIndividualLargaDTO.setDatConyPaisNacimiento("");
		solCredIndividualLargaDTO.setDatConyEntidFinanciera("");
		solCredIndividualLargaDTO.setDatConyNacionalidad("");
		solCredIndividualLargaDTO.setDatConyEscolaridad("");
		solCredIndividualLargaDTO.setDatConyDireccionTrabCalle("");
		solCredIndividualLargaDTO.setDatConyNumExt("");
		solCredIndividualLargaDTO.setDatConyNumInt("");
		solCredIndividualLargaDTO.setDatConyColonia("");
		solCredIndividualLargaDTO.setDatConyEstado("");
		solCredIndividualLargaDTO.setDatConyMuniDelegacion("");
		solCredIndividualLargaDTO.setDatConyPais("");
		solCredIndividualLargaDTO.setDatConyCodPostal01("");
		solCredIndividualLargaDTO.setDatConyCodPostal02("");
		solCredIndividualLargaDTO.setDatConyCodPostal03("");
		solCredIndividualLargaDTO.setDatConyCodPostal04("");
		solCredIndividualLargaDTO.setDatConyCodPostal05("");
		solCredIndividualLargaDTO.setDatConyTelefCel01("");
		solCredIndividualLargaDTO.setDatConyTelefCel02("");
		solCredIndividualLargaDTO.setDatConyTelefCel03("");
		solCredIndividualLargaDTO.setDatConyTelefCel04("");
		solCredIndividualLargaDTO.setDatConyTelefCel05("");
		solCredIndividualLargaDTO.setDatConyTelefCel06("");
		solCredIndividualLargaDTO.setDatConyTelefCel07("");
		solCredIndividualLargaDTO.setDatConyTelefCel08("");
		solCredIndividualLargaDTO.setDatConyTelefCel09("");
		solCredIndividualLargaDTO.setDatConyTelefCel010("");
		solCredIndividualLargaDTO.setEcoMMNIngresoVentas(0.0);
		solCredIndividualLargaDTO.setEcoMMNOtrosIngresos(0.0);
		solCredIndividualLargaDTO.setEcoMMNTotalIngresosSum(0.0);
		solCredIndividualLargaDTO.setEcoMMNGastosNegocios(0.0);
		solCredIndividualLargaDTO.setEcoMMNGastosFamiliares(0.0);
		solCredIndividualLargaDTO.setEcoMMNTotalGastos(0.0);
		solCredIndividualLargaDTO.setEcoMMNCapacidadPago(0.0);
		solCredIndividualLargaDTO.setFirmaNombreSolicitante("");
		solCredIndividualLargaDTO.setFirmaNombreAsesor("");
		solCredIndividualLargaDTO.setFirmaNombreCoordinador("");
		solCredIndividualLargaDTO.setFirmaNombreAnalistaOper("");
	}

	private void cargaPassIfe(String dato, SolicitudCreditoIndividualLargaDTO solCredIndividualLargaDTO) {
		for (int n = 0; n < dato.length(); n++) {
			char c = dato.charAt(n);
			if (n == 0)
				solCredIndividualLargaDTO.setDgNumPas01(String.valueOf(c));
			if (n == 1)
				solCredIndividualLargaDTO.setDgNumPas02(String.valueOf(c));
			if (n == 2)
				solCredIndividualLargaDTO.setDgNumPas03(String.valueOf(c));
			if (n == 3)
				solCredIndividualLargaDTO.setDgNumPas04(String.valueOf(c));
			if (n == 4)
				solCredIndividualLargaDTO.setDgNumPas05(String.valueOf(c));
			if (n == 5)
				solCredIndividualLargaDTO.setDgNumPas06(String.valueOf(c));
			if (n == 6)
				solCredIndividualLargaDTO.setDgNumPas07(String.valueOf(c));
			if (n == 7)
				solCredIndividualLargaDTO.setDgNumPas08(String.valueOf(c));
			if (n == 8)
				solCredIndividualLargaDTO.setDgNumPas09(String.valueOf(c));
			if (n == 9)
				solCredIndividualLargaDTO.setDgNumPas10(String.valueOf(c));
			if (n == 10)
				solCredIndividualLargaDTO.setDgNumPas11(String.valueOf(c));
			if (n == 11)
				solCredIndividualLargaDTO.setDgNumPas12(String.valueOf(c));
			if (n == 12)
				solCredIndividualLargaDTO.setDgNumPas13(String.valueOf(c));
		}

	}
}
