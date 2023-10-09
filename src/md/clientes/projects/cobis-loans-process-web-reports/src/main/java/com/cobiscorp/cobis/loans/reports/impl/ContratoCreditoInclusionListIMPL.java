package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleDosDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleDosDatosOpDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleUnoDTO;
import com.cobiscorp.cobis.loans.reports.dto.FirmasDTO;
import com.cobiscorp.cobis.loans.reports.dto.TransactionContextReport;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

public class ContratoCreditoInclusionListIMPL {
	private static final ILogger logger = LogFactory.getLogger(ContratoCreditoInclusionListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	private Services services = new Services();

	public List<ContratoCreditoInclusionDetallePrincipalDTO> getDetallePrincipal(ReportResponse[] reportResponse, LoanInfResponse loanData, String sessionId,
			ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionDetallePrincipalDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetallePrincipalDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetallePrincipal - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetallePrincipal - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					ContratoCreditoInclusionDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoInclusionDetallePrincipalDTO();
					String nombres = "";
					String fecha = "";
					String documento = "";
					for (int i = 0; i < reportResponse.length; i++) {
						nombres = nombres + reportResponse[i].getClient() + ",";
						logger.logDebug(
								" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - reportResponse[i].getAddressCustomer(): " + reportResponse[i].getAddressCustomer());
						if (reportResponse[i].getAddressCustomer() != null) {
							documento = documento + reportResponse[i].getAddressCustomer() + ",";
						}
					}

					logger.logError("*****>> Inicia getDetallePrincipal - loanData" + loanData);

					if (loanData != null) {
						logger.logError("*****>> Inicia getDetallePrincipal - loanData!= null loanData.getSettlementDate():" + loanData.getSettlementDate());
						fecha = loanData.getSettlementDate();
						cciDetallePrincipalDTO.setDia(UtilFunctions.getDay(fecha));
						cciDetallePrincipalDTO.setMes(UtilFunctions.getMonth(fecha));
						cciDetallePrincipalDTO.setAnio(UtilFunctions.getYear(fecha));
					}

					// Para nombres en las firmas finales-NRGCCI se cambio por RDRECA
					ParameterResponse inclFinUno = services.getParameter(4, "NF1CCI", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse inclFinDos = services.getParameter(4, "NF2CCI", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse bancoUno = services.getParameter(4, "NB1CCI", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse bancoDos = services.getParameter(4, "NB2CCI", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago = services.getParameter(4, "LPGCC1", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago2 = services.getParameter(4, "LPGCC2", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago3 = services.getParameter(4, "LPGCC3", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago4 = services.getParameter(4, "LPGCC4", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago5 = services.getParameter(4, "LPGCC5", Mnemonic.MODULE, serviceIntegration, sessionId);
					ParameterResponse lugarPago6 = services.getParameter(4, "LPGCC6", Mnemonic.MODULE, serviceIntegration, sessionId);

					logger.logDebug("SRO loanData.getDisplacement():" + loanData.getDisplacement());
					int gracia = loanData.getDisplacement() == null ? 0 : Integer.valueOf(loanData.getDisplacement());
					String paramRECA = "";
					if (gracia > 0) {
						paramRECA = "RDRECA";
					} else {
						paramRECA = "RECASG";
					}
					ParameterResponse numRegistro = services.getParameter(4, paramRECA, Mnemonic.MODULE, serviceIntegration, sessionId);

					String inclFinUnoS = "--";
					String inclFinDosS = "--";
					String bancoUnoS = "--";
					String bancoDosS = "--";
					String numRegistroS = "--";
					String lugarPagoS = "--";

					if (inclFinUno != null) {
						inclFinUnoS = inclFinUno.getParameterValue();
					}
					if (inclFinDos != null) {
						inclFinDosS = inclFinDos.getParameterValue();
					}
					if (bancoUno != null) {
						bancoUnoS = bancoUno.getParameterValue();
					}
					if (bancoDos != null) {
						bancoDosS = bancoDos.getParameterValue();
					}
					if (numRegistro != null) {
						numRegistroS = numRegistro.getParameterValue();
					}
					if (lugarPago != null) {
						lugarPagoS = lugarPago.getParameterValue();
					}
					if (lugarPago2 != null) {
						lugarPagoS = lugarPagoS + " " + lugarPago2.getParameterValue();
					}
					if (lugarPago3 != null) {
						lugarPagoS = lugarPagoS + " " + lugarPago3.getParameterValue();
					}
					if (lugarPago4 != null) {
						lugarPagoS = lugarPagoS + " " + lugarPago4.getParameterValue();
					}
					if (lugarPago5 != null) {
						lugarPagoS = lugarPagoS + " " + lugarPago5.getParameterValue();
					}
					if (lugarPago6 != null) {
						lugarPagoS = lugarPagoS + " " + lugarPago6.getParameterValue();
					}

					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - inclFinUnoS: " + inclFinUnoS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - inclFinDosS: " + inclFinDosS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - bancoUnoS: " + bancoUnoS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - bancoDosS: " + bancoDosS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - numRegistroS: " + numRegistroS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - lugarPagoS: " + lugarPagoS);
					logger.logDebug(" *****--- >> ContratoCreditoInclusion - getDetallePrincipal - documento: " + documento);

					TransactionContextReport transContextReportFirm = new TransactionContextReport();
					cciDetallePrincipalDTO.setNombreCliente(nombres);
					cciDetallePrincipalDTO.setDia(UtilFunctions.getDay(fecha));
					cciDetallePrincipalDTO.setMes(UtilFunctions.getMonth(fecha));
					cciDetallePrincipalDTO.setAnio(UtilFunctions.getYear(fecha));

					cciDetallePrincipalDTO.setNombreInclusionRepUno(inclFinUnoS);
					cciDetallePrincipalDTO.setNombreInclusionRepDos(inclFinDosS);

					cciDetallePrincipalDTO.setNombreBancoRepUno(bancoUnoS);
					cciDetallePrincipalDTO.setNombreBancoRepDos(bancoDosS);

					// Sin datos
					List<ContratoCreditoInclusionDetalleUnoDTO> ccinclusionDetalleDTOUno = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
					// Va la lista
					List<ContratoCreditoInclusionDetalleDosDTO> ccinclusionDetalleDTODos = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
					List<FirmasDTO> firmasDTOUno = new ArrayList<FirmasDTO>();
					List<FirmasDTO> firmasDTODos = new ArrayList<FirmasDTO>();

					ccinclusionDetalleDTOUno = getDetalleUno(numRegistroS);
					ccinclusionDetalleDTODos = getDetalleDos(reportResponse, lugarPagoS, documento, sessionId, serviceIntegration);

					firmasDTOUno = getDetalleFirma(reportResponse, sessionId, serviceIntegration);
					firmasDTODos = getDetalleFirma(reportResponse, sessionId, serviceIntegration);

					cciDetallePrincipalDTO.setCciDetalleUno(ccinclusionDetalleDTOUno);
					cciDetallePrincipalDTO.setCciDetalleDos(ccinclusionDetalleDTODos);

					// Envio de listas
					transContextReportFirm = services.dataListFirm(firmasDTOUno);
					firmasDTOUno = (List<FirmasDTO>) transContextReportFirm.getValue(ConstantValue.valueConstant.list1);
					firmasDTODos = (List<FirmasDTO>) transContextReportFirm.getValue(ConstantValue.valueConstant.list2);

					cciDetallePrincipalDTO.setCciDetalleFirmaUno(firmasDTOUno);
					cciDetallePrincipalDTO.setCciDetalleFirmaDos(firmasDTODos);
					dataBeanList.add(cciDetallePrincipalDTO);
				} else {
					this.initDetallePrincipal(dataBeanList);
				}
			} else {
				this.initDetallePrincipal(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionListIMPL - Error getDetallePrincipal", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	// Lleva una lista
	public List<ContratoCreditoInclusionDetalleUnoDTO> getDetalleUno(String numRegistro) {
		List<ContratoCreditoInclusionDetalleUnoDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
		ContratoCreditoInclusionDetalleUnoDTO dataBean = new ContratoCreditoInclusionDetalleUnoDTO();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleUno - Sin Datos");
		dataBean.setNumeroRegistro(numRegistro);
		dataBeanList.add(dataBean);
		return dataBeanList;
	}

	// Lleva una lista
	public List<ContratoCreditoInclusionDetalleDosDTO> getDetalleDos(ReportResponse[] reportResponse, String lugarPago, String documento, String sessionId,
			ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleDos - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetalleDos - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					ContratoCreditoInclusionDetalleDosDTO cciDetalleDTO = new ContratoCreditoInclusionDetalleDosDTO();
					List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
					List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacionMontos = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
					datosOperacion = getDetalleDosDatosOp(reportResponse, sessionId, serviceIntegration);
					datosOperacionMontos = getDetalleDosDatosOp(reportResponse, sessionId, serviceIntegration);
					cciDetalleDTO.setDatosOperacion(datosOperacion);
					cciDetalleDTO.setDatosOperacionMontos(datosOperacionMontos);
					cciDetalleDTO.setLugarPago(lugarPago);
					cciDetalleDTO.setDocumento(documento);
					dataBeanList.add(cciDetalleDTO);
				} else {
					this.initDetalleDos(dataBeanList);
				}
			
			} else {
				this.initDetalleDos(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionListIMPL - Error getDetalle", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	public List<ContratoCreditoInclusionDetalleDosDatosOpDTO> getDetalleDosDatosOp(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionDetalleDosDatosOpDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleDosDatosOp - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetalleDosDatosOp - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					for (ReportResponse report : reportResponse) {
						ContratoCreditoInclusionDetalleDosDatosOpDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDatosOpDTO();
						cciDetalleDosDatosOpDTO.setNombre(report.getClient());
						cciDetalleDosDatosOpDTO.setMonto(Functions.getStringCurrencyFormated(report.getAmount()));
						cciDetalleDosDatosOpDTO.setMontoDestAdeudo(Functions.getStringCurrencyFormated(report.getAmountPreviousDebt()));
						cciDetalleDosDatosOpDTO.setMontoDestCap(Functions.getStringCurrencyFormated(report.getAmountWorkingCapital()));
						cciDetalleDosDatosOpDTO.setMontoRecibir(Functions.getStringCurrencyFormated(report.getAmountTotalReceive()));						
						dataBeanList.add(cciDetalleDosDatosOpDTO);
						
					}
				} else {
					this.initDetalleDosDatosOp(dataBeanList);
				}
			} else {
				this.initDetalleDosDatosOp(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	public List<FirmasDTO> getDetalleFirma(ReportResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<FirmasDTO> dataBeanList = new ArrayList<FirmasDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleFirma - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetalleFirma - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					for (ReportResponse report : reportResponse) {
						FirmasDTO firmasDTO = new FirmasDTO();
						firmasDTO.setCargo("");
						firmasDTO.setNombre(report.getClient());
						dataBeanList.add(firmasDTO);
					}
				} else {
					this.initDetalleFirma(dataBeanList);
				}
			} else {
				this.initDetalleFirma(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("*****>>ContratoCreditoInclusionListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	private void initDetallePrincipal(List<ContratoCreditoInclusionDetallePrincipalDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetallePrincipal");
		ContratoCreditoInclusionDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoInclusionDetallePrincipalDTO();
		cciDetallePrincipalDTO.setNombreCliente("");
		cciDetallePrincipalDTO.setDia("");
		cciDetallePrincipalDTO.setMes("");
		cciDetallePrincipalDTO.setAnio("");
		cciDetallePrincipalDTO.setNombreBancoRepUno("");
		cciDetallePrincipalDTO.setNombreBancoRepDos("");
		cciDetallePrincipalDTO.setNombreInclusionRepUno("");
		cciDetallePrincipalDTO.setNombreInclusionRepDos("");
		// Lista para el detalle
		List<ContratoCreditoInclusionDetalleUnoDTO> ccInclusionDetalleUnoDTO = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
		List<ContratoCreditoInclusionDetalleDosDTO> ccInclusionDetalleDosDTO = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
		List<FirmasDTO> firmasDTO = new ArrayList<FirmasDTO>();
		cciDetallePrincipalDTO.setCciDetalleUno(ccInclusionDetalleUnoDTO);
		cciDetallePrincipalDTO.setCciDetalleDos(ccInclusionDetalleDosDTO);
		cciDetallePrincipalDTO.setCciDetalleFirmaUno(firmasDTO);
		cciDetallePrincipalDTO.setCciDetalleFirmaDos(firmasDTO);

		dataBeanList.add(cciDetallePrincipalDTO);
	}

	private void initDetalleFirma(List<FirmasDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetalleFirma");
		FirmasDTO firmasDTO = new FirmasDTO();
		firmasDTO.setCargo("");
		firmasDTO.setNombre("");
		dataBeanList.add(firmasDTO);
	}

	private void initDetalleDos(List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetalleDosDatosOpDTO");
		ContratoCreditoInclusionDetalleDosDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDTO();
		List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
		cciDetalleDosDatosOpDTO.setDatosOperacion(datosOperacion);
		cciDetalleDosDatosOpDTO.setLugarPago("");
		dataBeanList.add(cciDetalleDosDatosOpDTO);
	}

	private void initDetalleDosDatosOp(List<ContratoCreditoInclusionDetalleDosDatosOpDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetalleDosDatosOpDTO");
		ContratoCreditoInclusionDetalleDosDatosOpDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDatosOpDTO();
		cciDetalleDosDatosOpDTO.setNombre("");
		cciDetalleDosDatosOpDTO.setMonto("");
		dataBeanList.add(cciDetalleDosDatosOpDTO);
	}
}
