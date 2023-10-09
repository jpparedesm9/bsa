package com.cobiscorp.cobis.loans.reports.impl;

import java.math.BigDecimal;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.dto.SolicitudIndividualDTO;
import com.cobiscorp.cobis.loans.reports.services.ServicesLongIndividualCreditApplication;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenAddressCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenInfoCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerBussiness;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;

public class SolicitudCreditoIndividualIMPL {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoIndividualIMPL.class);
	static ServicesLongIndividualCreditApplication servicesLongIndCreditApp = new ServicesLongIndividualCreditApplication();

	public static SolicitudIndividualDTO getCreditRequestData(LoanInfResponse loanData, Map<String, Object> customerData, Map<String, Object> endorsementData) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Mapeo de Datos de Prestamo y Cliente Solicitud Individual");
		}
		if (loanData != null && customerData != null) {
			LoanCustomerResponse[] personalDataL = (LoanCustomerResponse[]) customerData.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);
			LoanCustomerResponse[] personalDebtorDataL = (LoanCustomerResponse[]) endorsementData.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);
			LoanCustomerBussiness[] bussinessDataL = (LoanCustomerBussiness[]) customerData.get(ConstantValue.valueConstant.ADD_CUSTOMER_INFORMATION);

			LoanCustomerResponse personalData = personalDataL[0];

			SolicitudIndividualDTO response = new SolicitudIndividualDTO();
			response.setAccountNumber(personalData.getAccountNumber());
			response.setAccountOrigin(personalData.getOfficeAccount());
			response.setActualCycle(personalData.getCycle() != null ? personalData.getCycle().toString() : "");
			response.setAddress(personalData.getAddress());
			response.setAgency(loanData.getOfficeDesc());
			response.setBirthDay(personalData.getBithDate());

			response.setBussReferences("");
			response.setCellPhone(personalData.getCellPhone());
			response.setCity(personalData.getCity());
			response.setColony(personalData.getColony());
			response.setCp(personalData.getCp());
			response.setCreditType(loanData.getCreditType());
			response.setCurp(personalData.getCurp());
			response.setCustomerName(personalData.getCustomerName());
			response.setDelegation(personalData.getDelegation());

			if (personalDebtorDataL.length > 0) {
				LoanCustomerResponse personalEndorsementData = personalDebtorDataL[0];
				response.setEdsAddress(personalEndorsementData.getAddress());
				response.setEdsBirthDay(personalEndorsementData.getBithDate());
				response.setEdsCellPhone(personalEndorsementData.getCellPhone());
				response.setEdsCity(personalEndorsementData.getCity());
				response.setEdsColony(personalEndorsementData.getColony());
				response.setEdsCp(personalEndorsementData.getCp());
				response.setEdsCurp(personalEndorsementData.getCurp());
				response.setEdsCustomerName(personalEndorsementData.getCustomerName());
				response.setEdsDelegation(personalEndorsementData.getDelegation());
				response.setEdsHomePhone(personalEndorsementData.getPhone());
				response.setEdsIdCustomer(personalEndorsementData.getCustomer());
				response.setEdsMaritalStatus(personalEndorsementData.getCivilStatus());
				response.setEdsNacionality(personalEndorsementData.getNationality());
				response.setEdsRfc(personalEndorsementData.getRfc());
				response.setEdsSex(personalEndorsementData.getSex());
				response.setEdsState(personalEndorsementData.getState());
			} else {
				response.setEdsAddress("");
				response.setEdsBirthDay("");
				response.setEdsCellPhone("");
				response.setEdsCity("");
				response.setEdsColony("");
				response.setEdsCp("");
				response.setEdsCurp("");
				response.setEdsCustomerName("");
				response.setEdsDelegation("");
				response.setEdsHomePhone("");
				response.setEdsIdCustomer(null);
				response.setEdsMaritalStatus("");
				response.setEdsNacionality("");
				response.setEdsRfc("");
				response.setEdsSex("");
				response.setEdsState("");
			}

			if (bussinessDataL.length > 0) {
				LoanCustomerBussiness bussinessData = bussinessDataL[0];
				response.setBussAddress(bussinessData.getAddress());
				response.setBussCity(bussinessData.getCity());
				response.setBussColony(bussinessData.getColony());
				response.setBussCP(bussinessData.getCp());
				response.setBussDelgation(bussinessData.getDelegation());
				response.setBussName(bussinessData.getBussinessName());
				response.setBussPhone(bussinessData.getPhone());
				response.setBussPropName(bussinessData.getOwnerName());
				response.setBussState(bussinessData.getState());
			} else {
				response.setBussAddress("");
				response.setBussCity("");
				response.setBussColony("");
				response.setBussCP("");
				response.setBussDelgation("");
				response.setBussName("");
				response.setBussPhone("");
				response.setBussPropName("");
				response.setBussState("");
			}

			response.setFrecuency(loanData.getTermType());
			response.setHomePhone(personalData.getPhone());
			response.setIdCustomer(loanData.getIdDebtor());
			response.setMaritalStatus(personalData.getCivilStatus());
			response.setNacionality(personalData.getNationality());
			response.setPayDate(loanData.getEndDate());
			response.setPays(loanData.getPaysNumber());
			response.setRate(loanData.getInterest());
			response.setRequestAmout(new BigDecimal(loanData.getAmount()));
			response.setRequestDate(loanData.getCreateDate());
			response.setResponsibleAdvisor(loanData.getResponsibleAdvisor());
			response.setRfc(personalData.getRfc());
			response.setSex(personalData.getSex());
			response.setState(personalData.getState());
			response.setTerm(String.valueOf(loanData.getTerm()));

			return response;

		}
		return null;
	}

	public static SolicitudIndividualDTO getContenido(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Mapeo de Datos de Prestamo y Cliente");
		}
		SolicitudIndividualDTO solicitudCreditoIndividual = new SolicitudIndividualDTO();
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

					// Dirección
					reportRequest.setOperation("DI");
					reportRequest.setType("RE");
					ReportLongIndCreditGenAddressCustomerResponse[] infoAddressResponse = servicesLongIndCreditApp.getAddressCustomer(reportRequest, sessionId, serviceIntegration);
					if (infoAddressResponse != null && infoAddressResponse.length > 0) {
						ReportLongIndCreditGenAddressCustomerResponse addressResponse = infoAddressResponse[0];
						if (addressResponse != null) {
							solicitudCreditoIndividual.setDireccion(addressResponse.getCalle());
							solicitudCreditoIndividual.setColonia(addressResponse.getParroquia());
							solicitudCreditoIndividual.setEstado(addressResponse.getProvincia());
							solicitudCreditoIndividual.setMunicipio(addressResponse.getCiudad());
							solicitudCreditoIndividual.setPais(addressResponse.getPais());
							solicitudCreditoIndividual.setCodigoPostal(addressResponse.getCodPostal());
							solicitudCreditoIndividual.setRefDomicilio(addressResponse.getReferenciaDomi());

							// CodigoPostal
							String codPostal = addressResponse.getCodPostal();
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
				}
			}
		} catch (Exception ex) {
			throw ex;
		}
		return solicitudCreditoIndividual;
	}
}
