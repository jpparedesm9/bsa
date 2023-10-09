package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaGrupalDTO;

public class EstadoCuentaGrupalListIMPL {
	private static final ILogger logger = LogFactory.getLogger(EstadoCuentaGrupalListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<EstadoCuentaGrupalDTO> getListSummaryCredit(ReportResponse[] summaryCredit, String sessionId, ICTSServiceIntegration serviceIntegration) {
		ArrayList<EstadoCuentaGrupalDTO> dataBeanList = new ArrayList<EstadoCuentaGrupalDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getListSummaryCredit");

			if (summaryCredit != null) {
				logger.logDebug("*****>>getListSummaryCredit - size:" + summaryCredit.length);

				if (summaryCredit.length > 0) {
					for (int i = 0; i < summaryCredit.length; i++) {
						EstadoCuentaGrupalDTO estadoCuentaGrupalDTO = new EstadoCuentaGrupalDTO();
						if (summaryCredit[i].getConcept() != null) {
							estadoCuentaGrupalDTO.setConcepto(summaryCredit[i].getConcept());
						} else {
							estadoCuentaGrupalDTO.setConcepto("");
						}

						if (summaryCredit[i].getBeginningBalance() != null) {
							estadoCuentaGrupalDTO.setSaldoInicial(summaryCredit[i].getBeginningBalance());
						} else {
							estadoCuentaGrupalDTO.setSaldoInicial(0.0);
						}
						if (summaryCredit[i].getPayment() != null) {
							estadoCuentaGrupalDTO.setAbonos(summaryCredit[i].getPayment());
						} else {
							estadoCuentaGrupalDTO.setAbonos(0.0);
						}

						if (summaryCredit[i].getCurrencyBalance() != null) {
							estadoCuentaGrupalDTO.setSaldoActual(summaryCredit[i].getCurrencyBalance());
						} else {
							estadoCuentaGrupalDTO.setSaldoActual(0.0);
						}
						if (summaryCredit[i].getExpired() != null) {
							estadoCuentaGrupalDTO.setVencido(summaryCredit[i].getExpired());
						} else {
							estadoCuentaGrupalDTO.setVencido(0.0);
						}

						dataBeanList.add(estadoCuentaGrupalDTO);
					}
				} else {
					initListSummaryCredit(dataBeanList);
				}
			} else {
				logger.logDebug("*****>>getListSummaryCredit - lista Vacia");
				initListSummaryCredit(dataBeanList);
			}
		}
		return dataBeanList;
	}

	private void initListSummaryCredit(ArrayList<EstadoCuentaGrupalDTO> dataBeanList) {
		EstadoCuentaGrupalDTO estadoCuentaGrupalDTO = new EstadoCuentaGrupalDTO();
		estadoCuentaGrupalDTO.setConcepto("");
		estadoCuentaGrupalDTO.setSaldoInicial(0.0);
		estadoCuentaGrupalDTO.setAbonos(0.0);
		estadoCuentaGrupalDTO.setSaldoActual(0.0);
		estadoCuentaGrupalDTO.setVencido(0.0);
		dataBeanList.add(estadoCuentaGrupalDTO);
	}

	// Plan Pagos
	public List<EstadoCuentaGrupalDTO> getListPaymentPlan(ReportResponse[] paymentPlan, String sessionId, ICTSServiceIntegration serviceIntegration) {
		ArrayList<EstadoCuentaGrupalDTO> dataBeanList = new ArrayList<EstadoCuentaGrupalDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getListPaymentPlan");

			if (paymentPlan != null) {
				logger.logDebug("*****>>getListPaymentPlan - size:" + paymentPlan.length);
				if (paymentPlan.length > 0) {
					for (int i = 0; i < paymentPlan.length; i++) {
						EstadoCuentaGrupalDTO estadoCuentaGrupalDTO = new EstadoCuentaGrupalDTO();
						estadoCuentaGrupalDTO.setPago(i + 1);
						if (paymentPlan[i].getDatePayment() != null) {
							estadoCuentaGrupalDTO.setFecha(paymentPlan[i].getDatePayment());
						} else {
							estadoCuentaGrupalDTO.setFecha("");
						}
						if (paymentPlan[i].getCapital() != null) {
							estadoCuentaGrupalDTO.setCapital(paymentPlan[i].getCapital());
						} else {
							estadoCuentaGrupalDTO.setCapital(0.0);
						}
						if (paymentPlan[i].getInterest() != null) {
							estadoCuentaGrupalDTO.setInteres(paymentPlan[i].getInterest());
						} else {
							estadoCuentaGrupalDTO.setInteres(0.0);
						}
						if (paymentPlan[i].getOthers() != null) {
							estadoCuentaGrupalDTO.setOtros(paymentPlan[i].getOthers());
						} else {
							estadoCuentaGrupalDTO.setOtros(0.0);
						}
						if (paymentPlan[i].getBalance() != null) {
							estadoCuentaGrupalDTO.setSaldo(paymentPlan[i].getBalance());
						} else {
							estadoCuentaGrupalDTO.setSaldo(0.0);
						}
						if (paymentPlan[i].getVoluntarySavings() != null) {
							estadoCuentaGrupalDTO.setVoluntario(paymentPlan[i].getVoluntarySavings());
						} else {
							estadoCuentaGrupalDTO.setVoluntario(0.0);
						}
						if (paymentPlan[i].getExtraSavings() != null) {
							estadoCuentaGrupalDTO.setExtra(paymentPlan[i].getExtraSavings());
						} else {
							estadoCuentaGrupalDTO.setExtra(0.0);
						}
						if (paymentPlan[i].getFee() != null) {
							estadoCuentaGrupalDTO.setCuota(paymentPlan[i].getFee());
						} else {
							estadoCuentaGrupalDTO.setCuota(0.0);
						}
						dataBeanList.add(estadoCuentaGrupalDTO);
					}
				} else {
					initListPaymentPlan(dataBeanList);
				}
			} else {
				logger.logDebug("*****>>getListPaymentPlan - lista Vacia");
				initListPaymentPlan(dataBeanList);
			}
		}
		return dataBeanList;
	}

	private void initListPaymentPlan(ArrayList<EstadoCuentaGrupalDTO> dataBeanList) {
		EstadoCuentaGrupalDTO estadoCuentaGrupalDTO = new EstadoCuentaGrupalDTO();
		estadoCuentaGrupalDTO.setPago(0);
		estadoCuentaGrupalDTO.setFecha("");
		estadoCuentaGrupalDTO.setCapital(0.0);
		estadoCuentaGrupalDTO.setInteres(0.0);
		estadoCuentaGrupalDTO.setOtros(0.0);
		estadoCuentaGrupalDTO.setSaldo(0.0);
		estadoCuentaGrupalDTO.setVoluntario(0.0);
		estadoCuentaGrupalDTO.setExtra(0.0);
		estadoCuentaGrupalDTO.setCuota(0.0);
		dataBeanList.add(estadoCuentaGrupalDTO);
	}

}
