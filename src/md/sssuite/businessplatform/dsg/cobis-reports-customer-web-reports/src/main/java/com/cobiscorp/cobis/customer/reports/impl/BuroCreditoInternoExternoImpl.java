package com.cobiscorp.cobis.customer.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAccountClientResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIELoanResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTODom;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTOHis;
import com.cobiscorp.cobis.customer.reports.dto.BuroCreditoInternoExternoDTOSisFin;

public class BuroCreditoInternoExternoImpl {
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoInternoExternoImpl.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public List<BuroCreditoInternoExternoDTODom> getDetalleDom(ReportIEAddressResponse[] rIEAddressResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoInternoExternoDTODom> dataBeanList = new ArrayList<BuroCreditoInternoExternoDTODom>();
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - getDetalleDom");
		try {
			if (rIEAddressResponse != null) {
				logger.logDebug("---->> BuroCreditoInternoExternoList - getDetalleDom - DTO BuroCreditoInternoExternoDTODom lenght:" + rIEAddressResponse.length);
				if (rIEAddressResponse.length > 0) {
					for (ReportIEAddressResponse responde : rIEAddressResponse) {
						BuroCreditoInternoExternoDTODom dto = new BuroCreditoInternoExternoDTODom();
						logger.logDebug("---->> XXX0");
						dto.setDomNumero(responde.getSequentialId());
						logger.logDebug("---->> XXX1");
						dto.setDomCalleNum(responde.getStreetNum());
						logger.logDebug("---->> XXX2");
						dto.setDomColoniaPoblacion(responde.getColony());
						logger.logDebug("---->> XXX3");
						dto.setDomDelegacionMunicipio(responde.getDlegation());
						logger.logDebug("---->> XXX4");
						dto.setDomCiudad(responde.getCity());
						logger.logDebug("---->> XXX5");
						dto.setDomEstado(responde.getState());
						logger.logDebug("---->> XXX6");
						dto.setDomCP(responde.getPostalCode());
						logger.logDebug("---->> XXX7");
						dto.setDomFechaRegistroBC(responde.getRecordDate());
						logger.logDebug("---->> XXX8");
						dataBeanList.add(dto);
					}
				} else {
					initDetalleDom(dataBeanList);
				}
			} else {
				initDetalleDom(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoInternoExternoList - getDetalleDom:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoInternoExternoList - getDetalleDom:", e);
		}
		return dataBeanList;
	}

	private void initDetalleDom(List<BuroCreditoInternoExternoDTODom> dataBeanList) {
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - initDetalleDom");
		BuroCreditoInternoExternoDTODom dto = new BuroCreditoInternoExternoDTODom();
		logger.logDebug("---->> YYYY1");
		dto.setDomNumero(1);
		logger.logDebug("---->> YYYY2");
		dto.setDomCalleNum("");
		logger.logDebug("---->> YYYY3");
		dto.setDomColoniaPoblacion("");
		logger.logDebug("---->> YYYY4");
		dto.setDomDelegacionMunicipio("");
		logger.logDebug("---->> YYYY5");
		dto.setDomCiudad("");
		logger.logDebug("---->> YYYY6");
		dto.setDomEstado("");
		logger.logDebug("---->> YYYY7");
		dto.setDomCP("");
		logger.logDebug("---->> YYYY8");
		dto.setDomFechaRegistroBC("");
		logger.logDebug("---->> YYYY9");
		dataBeanList.add(dto);
	}

	public List<BuroCreditoInternoExternoDTOHis> getDetalleHis(ReportIELoanResponse[] rIELoanResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoInternoExternoDTOHis> dataBeanList = new ArrayList<BuroCreditoInternoExternoDTOHis>();
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - getDetalleHis");
		try {
			if (rIELoanResponse != null) {
				logger.logDebug("---->> BuroCreditoInternoExternoList - getDetalleHis - DTO BuroCreditoInternoExternoDTOHis lenght:" + rIELoanResponse.length);
				if (rIELoanResponse.length > 0) {
					for (ReportIELoanResponse responde : rIELoanResponse) {
						BuroCreditoInternoExternoDTOHis dto = new BuroCreditoInternoExternoDTOHis();
						logger.logDebug("---->> MMMM1");
						dto.setHisNum(responde.getSequential());
						logger.logDebug("---->> MMMM2");
						dto.setHisLICredito(responde.getBank());
						logger.logDebug("---->> MMMM3");
						dto.setHisNumCiclo(responde.getCycle());
						logger.logDebug("---->> MMMM4");
						dto.setHisFechaApertura(responde.getOpeningDate());
						logger.logDebug("---->> MMMM5");
						dto.setHisFechaFin(responde.getEndDate());
						logger.logDebug("---->> MMMM6");
						dto.setHisFechaLiq(responde.getSettlementDate());
						logger.logDebug("---->> MMMM7");
						dto.setHisDiasAtrasoVenc(responde.getDaysLate());
						logger.logDebug("---->> MMMM8");
						dto.setHisMontoAprobIndividual(responde.getAmountApproved());
						logger.logDebug("---->> MMMM9");
						dto.setHisEstado(responde.getState());
						logger.logDebug("---->> MMMM10");
						dto.setHisSaldoTotalCap(responde.getCapitalBalance());
						logger.logDebug("---->> MMMM11");
						dto.setHisSaldoCapMora(responde.getArrearsCapitalBalance());
						logger.logDebug("---->> MMMM12");
						dto.setHisDiasMoraAcumulado(responde.getAccumulatedArrearsDays());
						logger.logDebug("---->> MMMM13");
						dto.setHisMaxDiasMora(responde.getMaximumDaysArrears());
						logger.logDebug("---->> MMMM14");
						dto.setHisCalificacion("");
						logger.logDebug("---->> MMMM15");
						dataBeanList.add(dto);
					}
				} //else {
					//initDetalleHis(dataBeanList);
				//}
			//} else {
				//initDetalleHis(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoInternoExternoList - getDetalleHis:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoInternoExternoList - getDetalleHis:", e);
		}
		return dataBeanList;
	}

	private void initDetalleHis(List<BuroCreditoInternoExternoDTOHis> dataBeanList) {
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - initDetalleHis");
		BuroCreditoInternoExternoDTOHis dto = new BuroCreditoInternoExternoDTOHis();
		logger.logDebug("---->> RRRR1");
		dto.setHisNum(0);
		logger.logDebug("---->> RRRR2");
		dto.setHisLICredito("");
		logger.logDebug("---->> RRRR3");
		dto.setHisNumCiclo(0);
		logger.logDebug("---->> RRRR4");
		dto.setHisFechaApertura("");
		logger.logDebug("---->> RRRR5");
		dto.setHisFechaFin("");
		logger.logDebug("---->> RRRR6");
		dto.setHisFechaLiq("");
		logger.logDebug("---->> RRRR7");
		dto.setHisDiasAtrasoVenc(0);
		logger.logDebug("---->> RRRR8");
		dto.setHisMontoAprobIndividual(0.0);
		logger.logDebug("---->> RRRR9");
		dto.setHisEstado("");
		logger.logDebug("---->> RRRR10");
		dto.setHisSaldoTotalCap(0.0);
		logger.logDebug("---->> RRRR11");
		dto.setHisSaldoCapMora(0.0);
		logger.logDebug("---->> RRRR12");
		dto.setHisDiasMoraAcumulado(0);
		logger.logDebug("---->> RRRR13");
		dto.setHisMaxDiasMora(0);
		logger.logDebug("---->> RRRR14");
		dto.setHisCalificacion("");
		logger.logDebug("---->> RRRR15");
		dataBeanList.add(dto);
	}

	public List<BuroCreditoInternoExternoDTOSisFin> getDetalleSisFin(ReportIEAccountClientResponse[] rIEAccountClientResponse, ICTSServiceIntegration serviceIntegration) {
		List<BuroCreditoInternoExternoDTOSisFin> dataBeanList = new ArrayList<BuroCreditoInternoExternoDTOSisFin>();
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - getDetalleSisFin");
		try {
			if (rIEAccountClientResponse != null) {
				logger.logDebug("---->> BuroCreditoInternoExternoList - getDetalleSisFin - DTO BuroCreditoInternoExternoDTOSisFin lenght:" + rIEAccountClientResponse.length);
				if (rIEAccountClientResponse.length > 0) {
					
					for (ReportIEAccountClientResponse responde : rIEAccountClientResponse) {
						BuroCreditoInternoExternoDTOSisFin dto = new BuroCreditoInternoExternoDTOSisFin();
						logger.logDebug("---->> AAA0");
						dto.setSisFInMop(responde.getMop());
						logger.logDebug("---->> AAA1");
						dto.setSisFInTotalCuentas(responde.getNumber());
						logger.logDebug("---->> AAA2");
						dto.setSisFInCuentasAbi(responde.getOpenAccounts());
						logger.logDebug("---->> AAA3");
						dto.setSisFInLimCredCuentaAbi(responde.getLimitOpenAccounts());
						logger.logDebug("---->> AAA4");
						dto.setSisFInSaldoActualCuentasAbi(responde.getCurrentOpenBalance());
						logger.logDebug("---->> AAA5");
						dto.setSisFInSaldoVencidoCuentasAbi(responde.getOutstandingBalanceDue());
						logger.logDebug("---->> AAA6");
						dto.setSisFInPagoPago(responde.getRelizarOpenPayment());
						logger.logDebug("---->> AAA7");
						dto.setSisFInPagoSemanal(responde.getWeeklypayment());
						logger.logDebug("---->> AAA8");
						dto.setSisFInPagoCatorcenal(responde.getFourteenthpayment());
						logger.logDebug("---->> AAA9");
						dto.setSisFInPagoMensual(responde.getMonthlypayment());
						logger.logDebug("---->> AAA10");
						dto.setSisFInCuentasCerradas(responde.getClosedAccounts());
						logger.logDebug("---->> AAA11");
						dto.setSisFInLimiteCredCuentasAbi(responde.getLimitClosedAccounts());
						logger.logDebug("---->> AAA12");
						dataBeanList.add(dto);
					}
				} else {
					initDetalleSisFin(dataBeanList);
				}
			} else {
				initDetalleSisFin(dataBeanList);
			}
		} catch (Exception e) {
			logger.logError("---->> ERROR BuroCreditoInternoExternoList - getDetalleSisFin:", e);
			throw new RuntimeException("---->> ERROR BuroCreditoInternoExternoList - getDetalleSisFin:", e);
		}
		return dataBeanList;
	}

	private void initDetalleSisFin(List<BuroCreditoInternoExternoDTOSisFin> dataBeanList) {
		logger.logDebug("---->> INICIO BuroCreditoInternoExternoList - initDetalleSisFin");
		BuroCreditoInternoExternoDTOSisFin dto = new BuroCreditoInternoExternoDTOSisFin();
		logger.logDebug("---->> FFFF1");
		dto.setSisFInMop("");
		logger.logDebug("---->> FFFF1");
		dto.setSisFInTotalCuentas(0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInCuentasAbi(0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInLimCredCuentaAbi(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInSaldoActualCuentasAbi(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInSaldoVencidoCuentasAbi(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInPagoPago(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInPagoSemanal(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInPagoCatorcenal(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInPagoMensual(0.0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInCuentasCerradas(0);
		logger.logDebug("---->> FFFF1");
		dto.setSisFInLimiteCredCuentasAbi(0.0);
		logger.logDebug("---->> FFFF1");
		dataBeanList.add(dto);
	}
}
