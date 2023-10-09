package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.OrdenDesembolsoDTO;
import com.cobiscorp.cobis.loans.reports.dto.OrdenDesembolsoPrincipalDTO;

public class OrdenDesembolsoListIMPL {
	private static final ILogger logger = LogFactory.getLogger(OrdenDesembolsoListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;
	private Services services = new Services();

	private void initListOrdenDesembolsoC(ArrayList<OrdenDesembolsoPrincipalDTO> dataBeanList) {
		OrdenDesembolsoPrincipalDTO ordenDesembolsoPrincipalDTO = new OrdenDesembolsoPrincipalDTO();
		ordenDesembolsoPrincipalDTO.setNumRuc("");
		ordenDesembolsoPrincipalDTO.setSucursal("");
		ordenDesembolsoPrincipalDTO.setFechaSistema("");
		ordenDesembolsoPrincipalDTO.setRecibo("");
		ordenDesembolsoPrincipalDTO.setNumOperacion("");
		ordenDesembolsoPrincipalDTO.setDeudorPrincipal("");
		ordenDesembolsoPrincipalDTO.setGrupo("");
		ordenDesembolsoPrincipalDTO.setIdentificacion("");
		ordenDesembolsoPrincipalDTO.setFechaLiquidacion("");
		ordenDesembolsoPrincipalDTO.setFechaDesembolso("");
		ordenDesembolsoPrincipalDTO.setTelefonoOD("");
		ordenDesembolsoPrincipalDTO.setFechaOD("");
		List<OrdenDesembolsoDTO> ordenDesembolso = new ArrayList<OrdenDesembolsoDTO>();
		ordenDesembolsoPrincipalDTO.setMoneyDescription(ordenDesembolso);
		dataBeanList.add(ordenDesembolsoPrincipalDTO);
	}

	private ArrayList<OrdenDesembolsoPrincipalDTO> getPrincipal(ReportResponse reportResponse, ArrayList<OrdenDesembolsoPrincipalDTO> dataBeanList, String sessionId, ICTSServiceIntegration serviceIntegration) {

		if (logger.isDebugEnabled())
			logger.logDebug("*****>>Inicia getPrincipal");
		try {
			OrdenDesembolsoPrincipalDTO ordenDesembolsoPrincipalDTO = new OrdenDesembolsoPrincipalDTO();

			if (reportResponse != null) {
				ordenDesembolsoPrincipalDTO.setNumRuc(reportResponse.getRuc());
				ordenDesembolsoPrincipalDTO.setSucursal(reportResponse.getBranchOffice());
				ordenDesembolsoPrincipalDTO.setFechaSistema(reportResponse.getDate());
				ordenDesembolsoPrincipalDTO.setRecibo(reportResponse.getReceiptNumber());
				ordenDesembolsoPrincipalDTO.setNumOperacion(reportResponse.getOperation());
				ordenDesembolsoPrincipalDTO.setDeudorPrincipal(reportResponse.getClient());
				ordenDesembolsoPrincipalDTO.setGrupo(reportResponse.getGroup());
				ordenDesembolsoPrincipalDTO.setIdentificacion(reportResponse.getIdentification());
				ordenDesembolsoPrincipalDTO.setFechaLiquidacion(reportResponse.getSettlementDate());
				ordenDesembolsoPrincipalDTO.setFechaDesembolso(reportResponse.getDisbursementDate());
				ordenDesembolsoPrincipalDTO.setTelefonoOD(reportResponse.getPhone());
				ordenDesembolsoPrincipalDTO.setFechaOD(reportResponse.getDateOther());

				ReportResponse[] reportResponseOrdenDesembolso = services.getDisbursementOrderDetail(sessionId, reportResponse.getOperation(), "1", 1, serviceIntegration);

				List<OrdenDesembolsoDTO> ordenDesembolso = getListOrdenDesembolso(reportResponseOrdenDesembolso);
				ordenDesembolsoPrincipalDTO.setMoneyDescription(ordenDesembolso);

				dataBeanList.add(ordenDesembolsoPrincipalDTO);
			} else {
				initListOrdenDesembolsoC(dataBeanList);
			}
			
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte Orden de Desembolso - getPrincipal", e);
			
		}
		return dataBeanList;
	}

	public List<OrdenDesembolsoPrincipalDTO> getListOrdenDesembolsoPrincipal(ReportResponse[] response, String sessionId, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled())
			logger.logDebug("*****>>Inicia getListOrdenDesembolsoPrincipal");
		ArrayList<OrdenDesembolsoPrincipalDTO> dataBeanList = new ArrayList<OrdenDesembolsoPrincipalDTO>();
		try {
			
			ReportResponse reportResponse;
			logger.logDebug("*****>>Inicia getListOrdenDesembolsoPrincipal-responseLista:" + response);
			if (response != null) {
				if (response.length > 0) {
					for (ReportResponse aux : response) {
						logger.logDebug("*****>>Inicia getListOrdenDesembolsoPrincipal-getBank:" + aux.getBank());
						reportResponse = services.getDisbursementOrderHeader(sessionId, aux.getBank(), serviceIntegration);
						dataBeanList = getPrincipal(reportResponse, dataBeanList, sessionId, serviceIntegration);
					}
				} else {
					initListOrdenDesembolsoC(dataBeanList);
				}
			} else {
				initListOrdenDesembolsoC(dataBeanList);
			}
			
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte Orden de Desembolso - getListOrdenDesembolsoPrincipal", e);
		
		}
		return dataBeanList;
	}

	public List<OrdenDesembolsoDTO> getListOrdenDesembolso(ReportResponse[] ordenDesembolso) {
		ArrayList<OrdenDesembolsoDTO> dataBeanList = new ArrayList<OrdenDesembolsoDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getListOrdenDesembolso");

			if (ordenDesembolso != null) {
				logger.logDebug("*****>>getListOrdenDesembolso - size:" + ordenDesembolso.length);

				if (ordenDesembolso.length > 0) {
					for (int i = 0; i < ordenDesembolso.length; i++) {
						OrdenDesembolsoDTO ordenDesembolsoDTO = new OrdenDesembolsoDTO();
						if (ordenDesembolso[i].getDisbursementOffice() != null) {
							ordenDesembolsoDTO.setOfficerNameDisbursement(ordenDesembolso[i].getDisbursementOffice());
						} else {
							ordenDesembolsoDTO.setOfficerNameDisbursement("");
						}

						if (ordenDesembolso[i].getDisbursementForm() != null) {
							ordenDesembolsoDTO.setDisbursementrate(ordenDesembolso[i].getDisbursementForm());
						} else {
							ordenDesembolsoDTO.setDisbursementrate("");
						}
						if (ordenDesembolso[i].getReference() != null) {
							ordenDesembolsoDTO.setReference(ordenDesembolso[i].getReference());
						} else {
							ordenDesembolsoDTO.setReference("");
						}

						if (ordenDesembolso[i].getCurrencyDescrip() != null) {
							ordenDesembolsoDTO.setCurrency(ordenDesembolso[i].getCurrencyDescrip());
						} else {
							ordenDesembolsoDTO.setCurrency("");
						}
						if (ordenDesembolso[i].getQuotation() != null) {
							ordenDesembolsoDTO.setQuote(ordenDesembolso[i].getQuotation());
						} else {
							ordenDesembolsoDTO.setQuote(0.0);
						}
						if (ordenDesembolso[i].getAmount() != null) {
							ordenDesembolsoDTO.setAmount(ordenDesembolso[i].getAmount());
						} else {
							ordenDesembolsoDTO.setAmount(0.0);
						}

						dataBeanList.add(ordenDesembolsoDTO);
					}
				} else {
					initListOrdenDesembolso(dataBeanList);
				}
			} else {
				logger.logDebug("*****>>getListOrdenDesembolso - lista Vacia");
				initListOrdenDesembolso(dataBeanList);
			}
		}
		return dataBeanList;
	}

	private void initListOrdenDesembolso(ArrayList<OrdenDesembolsoDTO> dataBeanList) {
		OrdenDesembolsoDTO ordenDesembolso = new OrdenDesembolsoDTO();
		ordenDesembolso.setOfficerNameDisbursement("");
		ordenDesembolso.setDisbursementrate("");
		ordenDesembolso.setReference("");
		ordenDesembolso.setCurrency("");
		ordenDesembolso.setQuote(0.0);
		ordenDesembolso.setAmount(0.0);
		dataBeanList.add(ordenDesembolso);
	}

}
