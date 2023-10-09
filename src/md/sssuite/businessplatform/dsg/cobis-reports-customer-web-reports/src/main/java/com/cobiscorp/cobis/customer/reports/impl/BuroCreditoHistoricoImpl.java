package com.cobiscorp.cobis.customer.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCreditsSummaryPrincipalResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailConsultationsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailTheCreditsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistEmployeeHomeResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistScoreBuroResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODetConsultas;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODetCreditos;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTODom;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOEmp;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOResumenCredito;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoHistoricoDTOScoreBuro;

public class BuroCreditoHistoricoImpl {
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoHistoricoImpl.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<BuroCreditoHistoricoDTODom> getDetalleDom(ReportIEAddressResponse[] rhAddressResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTODom> dataBeanList = new ArrayList<BuroCreditoHistoricoDTODom>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - getDetalleDom");
		try {
			if (rhAddressResponse != null) {
				if (rhAddressResponse.length > 0) {
					for (ReportIEAddressResponse responde : rhAddressResponse) {
						BuroCreditoHistoricoDTODom dto = new BuroCreditoHistoricoDTODom();
						dto.setDomNumero(String.valueOf(responde.getSequentialId()));
						dto.setDomCalleNum(responde.getStreetNum());
						dto.setDomColonia(responde.getColony());
						dto.setDomDelegacion(responde.getDlegation());
						dto.setDomCiudad(responde.getCity());
						dto.setDomEstado(responde.getState());
						dto.setDomCP(responde.getPostalCode());
						dto.setDomRegistroBC(responde.getRecordDate());
						dataBeanList.add(dto);
					}
				} else {
					initDetalleDom(dataBeanList);
				}
			} else {
				initDetalleDom(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - getDetalleDom:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - getDetalleDom:", e);
		}
		return dataBeanList;
	}

	private void initDetalleDom(List<BuroCreditoHistoricoDTODom> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initDetalleDom");
		BuroCreditoHistoricoDTODom dto = new BuroCreditoHistoricoDTODom();
		dto.setDomNumero("");
		dto.setDomCalleNum("");
		dto.setDomColonia("");
		dto.setDomDelegacion("");
		dto.setDomCiudad("");
		dto.setDomEstado("");
		dto.setDomCP("");
		dto.setDomRegistroBC("");
		dataBeanList.add(dto);
	}

	public List<BuroCreditoHistoricoDTOEmp> getDetalleDomEmpRep(ReportHistEmployeeHomeResponse[] rhEmployeeHomeResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTOEmp> dataBeanList = new ArrayList<BuroCreditoHistoricoDTOEmp>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - getDetalleDomEmpRep");
		int num = 0;
		try {
			if (rhEmployeeHomeResponse != null) {
				if (rhEmployeeHomeResponse.length > 0) {
					for (ReportHistEmployeeHomeResponse responde : rhEmployeeHomeResponse) {
						BuroCreditoHistoricoDTOEmp dto = new BuroCreditoHistoricoDTOEmp();
						num = num + 1;
						dto.setDomEmpNum(String.valueOf(num));
						dto.setDomEmpCompania(responde.getCompanyName());
						dto.setDomEmpPuesto(responde.getPosition());
						dto.setDomEmpSalario(responde.getSalary());
						dto.setDomEmpBase(responde.getSalaryBase());
						dto.setDomEmpCalleNum(responde.getDirectionOne());
						dto.setDomEmpColonia(responde.getColony());
						dto.setDomEmpDelMPO(responde.getDelegation());
						dto.setDomEmpCiudad(responde.getCity());
						dto.setDomEmpEstado(responde.getState());
						dto.setDomEmpCP(responde.getPostalCode());
						dto.setDomEmpTel(responde.getTelephoneNumber());
						dto.setDomEmpFechaContrat(responde.getContractingDate());
						dataBeanList.add(dto);
					}
				} else {
					initDetalleDomEmpRep(dataBeanList);
				}
			} else {
				initDetalleDomEmpRep(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - getDetalleDomEmpRep:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - getDetalleDomEmpRep:", e);
		}
		return dataBeanList;
	}

	private void initDetalleDomEmpRep(List<BuroCreditoHistoricoDTOEmp> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initDetalleDomEmpRep");
		BuroCreditoHistoricoDTOEmp dto = new BuroCreditoHistoricoDTOEmp();
		dto.setDomEmpNum("");
		dto.setDomEmpCompania("");
		dto.setDomEmpPuesto("");
		dto.setDomEmpSalario("");
		dto.setDomEmpBase("");
		dto.setDomEmpCalleNum("");
		dto.setDomEmpColonia("");
		dto.setDomEmpDelMPO("");
		dto.setDomEmpCiudad("");
		dto.setDomEmpEstado("");
		dto.setDomEmpCP("");
		dto.setDomEmpTel("");
		dto.setDomEmpFechaContrat("");
		dataBeanList.add(dto);
	}

	public List<BuroCreditoHistoricoDTODetCreditos> detCreditos(ReportHistDetailTheCreditsResponse[] rhDetailTheCreditsResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTODetCreditos> dataBeanList = new ArrayList<BuroCreditoHistoricoDTODetCreditos>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - detCreditos");
		try {
			if (rhDetailTheCreditsResponse != null) {
				if (rhDetailTheCreditsResponse.length > 0) {
					for (ReportHistDetailTheCreditsResponse responde : rhDetailTheCreditsResponse) {
						BuroCreditoHistoricoDTODetCreditos dto = new BuroCreditoHistoricoDTODetCreditos();
						dto.setDetCNum(responde.getNumber());
						dto.setDetCTipoContrato(responde.getDescTypeContract());
						dto.setDetCTipoCuenta(responde.getDescTypeAccount());
						dto.setDetCTipoResp(responde.getDescTypeResponsibility());
						dto.setDetCOtorgante(responde.getAwardingName());
						dto.setDetCNumCuenta(responde.getCurrentAccountNumber());
						dto.setDetCMoneda(responde.getKeyMonetaryUnit());
						dto.setDetCActualizadoAl(responde.getDateupdate());
						dto.setDetCApertura(responde.getDateOpeningAccount());
						dto.setDetCUltimoPago(responde.getLastPaymentDate());
						dto.setDetCUltimaCompra(responde.getDateLastPurchase());
						dto.setDetCCierre(responde.getDateClosingAccount());
						dto.setDetCUltVezSaldo0(responde.getLastDateBalanceZero());
						dto.setDetCLimteDeCredito(responde.getLimitCredit());
						dto.setDetCCreditoMaximo(responde.getMaximumCredit());
						dto.setDetCSaldoActual(responde.getCurrentbalance());
						dto.setDetCSaldoVencido(responde.getOutstandingBalance());
						dto.setDetCAPagar(responde.getAmountPay());
						dto.setDetCFrecuenciaPagos(responde.getFrequencyPayments());
						dto.setDetCNumPagos(responde.getNumberPayments());
						dto.setDetCFormaDePagoMopActual(responde.getDescFormaActualPayment());
						dto.setDetCHPFechaMasReciente(responde.getMostRecentPaymentPayment());
						dto.setDetCHPFechaMasAntigua(responde.getEarlierDatePaymentHistoricos());
						dto.setDetCHistPagos(responde.getHistoricalPayments());
						dto.setDetCHistPagObserv(responde.getDescKeyObservation());
						dataBeanList.add(dto);
					}
				} else {
					initDetCreditos(dataBeanList);
				}
			} else {
				initDetCreditos(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - detCreditos:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - detCreditos:", e);
		}
		return dataBeanList;
	}

	private void initDetCreditos(List<BuroCreditoHistoricoDTODetCreditos> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initDetCreditos");
		BuroCreditoHistoricoDTODetCreditos dto = new BuroCreditoHistoricoDTODetCreditos();
		dto.setDetCNum(0);
		dto.setDetCTipoContrato("");
		dto.setDetCTipoCuenta("");
		dto.setDetCTipoResp("");
		dto.setDetCOtorgante("");
		dto.setDetCNumCuenta("");
		dto.setDetCMoneda("");
		dto.setDetCActualizadoAl("");
		dto.setDetCApertura("");
		dto.setDetCUltimoPago("");
		dto.setDetCUltimaCompra("");
		dto.setDetCCierre("");
		dto.setDetCUltVezSaldo0("");
		dto.setDetCLimteDeCredito(0.0);
		dto.setDetCCreditoMaximo(0.0);
		dto.setDetCSaldoActual(0.0);
		dto.setDetCSaldoVencido(0.0);
		dto.setDetCAPagar(0.0);
		dto.setDetCFrecuenciaPagos("");
		dto.setDetCNumPagos("");
		dto.setDetCFormaDePagoMopActual("");
		dto.setDetCHPFechaMasReciente("");
		dto.setDetCHPFechaMasAntigua("");
		dto.setDetCHistPagos("");
		dto.setDetCHistPagObserv("");
		dataBeanList.add(dto);
	}

	public List<BuroCreditoHistoricoDTOResumenCredito> resumenCreditos(ReportHistCreditsSummaryPrincipalResponse[] rhCreditsSummaryPrincipalResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTOResumenCredito> dataBeanList = new ArrayList<BuroCreditoHistoricoDTOResumenCredito>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - resumenCreditos");
		try {
			if (rhCreditsSummaryPrincipalResponse != null) {
				if (rhCreditsSummaryPrincipalResponse.length > 0) {
					for (ReportHistCreditsSummaryPrincipalResponse responde : rhCreditsSummaryPrincipalResponse) {
						BuroCreditoHistoricoDTOResumenCredito dto = new BuroCreditoHistoricoDTOResumenCredito();
						dto.setResCredMOP(responde.getMop());
						dto.setResCredCuentasAbi(responde.getOpenAccounts());
						dto.setResCredLimAbi(responde.getLimitOpenAccounts());
						dto.setResCredMaxAbi(responde.getMaximoOpen());
						dto.setResCredSaldoActAbi(responde.getCurrentBalanceOpen());
						dto.setResCredSaldoVencidAbi(responde.getOutstandingBalanceDue());
						dto.setResCredPagoRealizar(responde.getRelizarOpenPayment());
						dto.setResCredCuentasCerradas(responde.getClosedaccounts());
						dto.setResCredLimiCerradas(responde.getLimitClosedAccounts());
						dto.setResCredMaxCerradas(responde.getMaximumClosed());
						dto.setResCredSaldoActCerradas(responde.getCurrentBalanceClosed());
						dto.setResCredMontoCerradas(responde.getClosedAmount());
						dataBeanList.add(dto);
					}
				} else {
					initResumenCreditos(dataBeanList);
				}
			} else {
				initResumenCreditos(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - resumenCreditos:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - resumenCreditos:", e);
		}
		return dataBeanList;
	}

	private void initResumenCreditos(List<BuroCreditoHistoricoDTOResumenCredito> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initResumenCreditos");
		BuroCreditoHistoricoDTOResumenCredito dto = new BuroCreditoHistoricoDTOResumenCredito();
		dto.setResCredMOP("0");
		dto.setResCredCuentasAbi(0);
		dto.setResCredLimAbi(0.0);
		dto.setResCredMaxAbi(0.0);
		dto.setResCredSaldoActAbi(0.0);
		dto.setResCredSaldoVencidAbi(0.0);
		dto.setResCredPagoRealizar(0.0);
		dto.setResCredCuentasCerradas(0);
		dto.setResCredLimiCerradas(0.0);
		dto.setResCredMaxCerradas(0.0);
		dto.setResCredSaldoActCerradas(0.0);
		dto.setResCredMontoCerradas(0.0);
		dataBeanList.add(dto);
	}

	public List<BuroCreditoHistoricoDTODetConsultas> detConsult(ReportHistDetailConsultationsResponse[] rhDetailConsultationsResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTODetConsultas> dataBeanList = new ArrayList<BuroCreditoHistoricoDTODetConsultas>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - detConsult");
		try {
			if (rhDetailConsultationsResponse != null) {
				if (rhDetailConsultationsResponse.length > 0) {
					for (ReportHistDetailConsultationsResponse responde : rhDetailConsultationsResponse) {
						BuroCreditoHistoricoDTODetConsultas dto = new BuroCreditoHistoricoDTODetConsultas();
						dto.setDetConsOtorgante(responde.getGrantor());
						dto.setDetConsFechaConsulta(responde.getDateQuery());
						dto.setDetConsResponsabilidad(responde.getTypeResponsibility());
						dto.setDetTipoContrato(responde.getContractType());
						dto.setDetImporte(responde.getContractAmount());
						dto.setDetTipoMoneda(responde.getMonetaryUnitType());
						dataBeanList.add(dto);
					}
				} else {
					initDetConsult(dataBeanList);
				}
			} else {
				initDetConsult(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - detConsult:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - detConsult:", e);
		}
		return dataBeanList;
	}

	private void initDetConsult(List<BuroCreditoHistoricoDTODetConsultas> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initDetConsult");
		BuroCreditoHistoricoDTODetConsultas dto = new BuroCreditoHistoricoDTODetConsultas();
		dto.setDetConsOtorgante("");
		dto.setDetConsFechaConsulta("");
		dto.setDetConsResponsabilidad("");
		dto.setDetTipoContrato("");
		dto.setDetImporte("");
		dto.setDetTipoMoneda("");
		dataBeanList.add(dto);
	}

	//
	public List<BuroCreditoHistoricoDTOScoreBuro> scoreBuro(ReportHistScoreBuroResponse[] rhScoreBuroResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoHistoricoDTOScoreBuro> dataBeanList = new ArrayList<BuroCreditoHistoricoDTOScoreBuro>();
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - scoreBuro");
		try {
			if (rhScoreBuroResponse != null) {
				if (rhScoreBuroResponse.length > 0) {
					for (ReportHistScoreBuroResponse responde : rhScoreBuroResponse) {
						BuroCreditoHistoricoDTOScoreBuro dto = new BuroCreditoHistoricoDTOScoreBuro();
						dto.setSbcNombreDelScore(responde.getFirstName());
						dto.setSbcValorDelScore(responde.getValue());
						dto.setSbcCausasDelValorDelScore(responde.getReasonCode());
						dto.setSbcCausaDeNoScore(responde.getErrorCode());
						dataBeanList.add(dto);
					}
				} else {
					initScoreBuro(dataBeanList);
				}
			} else {
				initScoreBuro(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoHistoricoImpl - scoreBuro:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoHistoricoImpl - scoreBuro:", e);
		}
		return dataBeanList;
	}

	private void initScoreBuro(List<BuroCreditoHistoricoDTOScoreBuro> dataBeanList) {
		logger.logError("---->> INICIO BuroCreditoHistoricoImpl - initScoreBuro");
		BuroCreditoHistoricoDTOScoreBuro dto = new BuroCreditoHistoricoDTOScoreBuro();
		dto.setSbcNombreDelScore("");
		dto.setSbcValorDelScore("");
		dto.setSbcCausasDelValorDelScore("");
		dto.setSbcCausaDeNoScore("");
		dataBeanList.add(dto);
	}
}
