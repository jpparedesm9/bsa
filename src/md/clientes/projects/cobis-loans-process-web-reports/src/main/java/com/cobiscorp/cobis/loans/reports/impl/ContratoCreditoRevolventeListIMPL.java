package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanInfoApplicationResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleDosDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleDosDatosOpDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetalleUnoDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.dto.FirmasDTO;
import com.cobiscorp.cobis.loans.reports.dto.TransactionContextReport;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

public class ContratoCreditoRevolventeListIMPL {
	private static final ILogger logger = LogFactory.getLogger(ContratoCreditoRevolventeListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	private Services services = new Services();

	public List<ContratoCreditoRevolventeDetallePrincipalDTO> getDetallePrincipal(LoanInfoApplicationResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoRevolventeDetallePrincipalDTO> dataBeanList = new ArrayList<ContratoCreditoRevolventeDetallePrincipalDTO>();
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Inicia getDetallePrincipal - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetallePrincipal - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					ContratoCreditoRevolventeDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoRevolventeDetallePrincipalDTO();
					String fecha = "";

					List<ContratoCreditoInclusionDetalleUnoDTO> ccinclusionDetalleDTOUno = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
					List<ContratoCreditoInclusionDetalleDosDTO> ccinclusionDetalleDTODos = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();

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
						ccinclusionDetalleDTOUno = getDetalleUno(reportResponse[i].getRegNumber());
						ccinclusionDetalleDTODos = getDetalleDos(reportResponse, reportResponse[i].getPlacePayment(), "", sessionId, serviceIntegration);

					}
					TransactionContextReport transContextReportFirm = new TransactionContextReport();
					List<FirmasDTO> firmasDTOUno = new ArrayList<FirmasDTO>();
					firmasDTOUno = getDetalleFirma(reportResponse, sessionId, serviceIntegration);
					cciDetallePrincipalDTO.setCciDetalleUno(ccinclusionDetalleDTOUno);
					cciDetallePrincipalDTO.setCciDetalleDos(ccinclusionDetalleDTODos);

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
			logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Error getDetallePrincipal", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	public List<ContratoCreditoRevolventeClausulaDTO> getClausula(String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoRevolventeClausulaDTO> dataBeanList = new ArrayList<ContratoCreditoRevolventeClausulaDTO>();
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Inicia getClausula");

		ContratoCreditoRevolventeClausulaDTO clausula = new ContratoCreditoRevolventeClausulaDTO();
		clausula.setCampo(".");
		dataBeanList.add(clausula);

		return dataBeanList;
	}

	// Lleva una lista
	public List<ContratoCreditoInclusionDetalleUnoDTO> getDetalleUno(String numRegistro) {
		List<ContratoCreditoInclusionDetalleUnoDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleUnoDTO>();
		ContratoCreditoInclusionDetalleUnoDTO dataBean = new ContratoCreditoInclusionDetalleUnoDTO();
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Inicia getDetalleUno - Sin Datos");
		dataBean.setNumeroRegistro(numRegistro);
		dataBeanList.add(dataBean);
		return dataBeanList;
	}

	// Solo para dejarle la estructura similar al contratoGrupal
	public List<ContratoCreditoInclusionDetalleDosDTO> getDetalleDos(LoanInfoApplicationResponse[] reportResponse, String lugarPago, String documento, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList = new ArrayList<ContratoCreditoInclusionDetalleDosDTO>();
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - Inicia getDetalleDos - reportResponse" + reportResponse);
		try {
			if (reportResponse != null) {
				logger.logError("*****>> Inicia getDetalleDos - reportResponse.length" + reportResponse.length);
				if (reportResponse.length > 0) {
					ContratoCreditoInclusionDetalleDosDTO cciDetalleDTO = new ContratoCreditoInclusionDetalleDosDTO();
					List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
					// datosOperacion = getDetalleDosDatosOp(reportResponse, sessionId, serviceIntegration);
					cciDetalleDTO.setDatosOperacion(datosOperacion);
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

	private void initDetalleDos(List<ContratoCreditoInclusionDetalleDosDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoInclusionListIMPL - initDetalleDosDatosOpDTO");
		ContratoCreditoInclusionDetalleDosDTO cciDetalleDosDatosOpDTO = new ContratoCreditoInclusionDetalleDosDTO();
		List<ContratoCreditoInclusionDetalleDosDatosOpDTO> datosOperacion = new ArrayList<ContratoCreditoInclusionDetalleDosDatosOpDTO>();
		cciDetalleDosDatosOpDTO.setDatosOperacion(datosOperacion);
		cciDetalleDosDatosOpDTO.setLugarPago("");
		dataBeanList.add(cciDetalleDosDatosOpDTO);
	}

	// Solo para dejarle la estructura similar al contratoGrupal
	public List<FirmasDTO> getDetalleFirma(LoanInfoApplicationResponse[] reportResponse, String sessionId, ICTSServiceIntegration serviceIntegration) {
		List<FirmasDTO> dataBeanList = new ArrayList<FirmasDTO>();
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Inicia getDetalleFirma - reportResponse" + reportResponse);
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
			logger.logError("*****>>ContratoCreditoRevolventeListIMPL - Error getDetalleFirma", e);
			throw new RuntimeException(e);
		}
		return dataBeanList;
	}

	private void initDetallePrincipal(List<ContratoCreditoRevolventeDetallePrincipalDTO> dataBeanList) {
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - initDetallePrincipal");
		ContratoCreditoRevolventeDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoCreditoRevolventeDetallePrincipalDTO();
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
		logger.logError("*****>>ContratoCreditoRevolventeListIMPL - initDetalleFirma");
		FirmasDTO firmasDTO = new FirmasDTO();
		firmasDTO.setCargo("");
		firmasDTO.setNombre("");
		dataBeanList.add(firmasDTO);
	}
}
