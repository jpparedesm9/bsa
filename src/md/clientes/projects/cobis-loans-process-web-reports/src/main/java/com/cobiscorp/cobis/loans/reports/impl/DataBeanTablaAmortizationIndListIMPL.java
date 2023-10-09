package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaAmortizationIndDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ReportDebtors;
import com.cobiscorp.cobis.loans.reports.dto.TablaAmortizacionIndDetalleDTO;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

public class DataBeanTablaAmortizationIndListIMPL {
	private static final ILogger logger = LogFactory.getLogger(DataBeanTablaAmortizationIndListIMPL.class);
	@Reference
	private static ICTSServiceIntegration serviceIntegration;
	static CatalogManagement catalogMngnt = new CatalogManagement(serviceIntegration);

	public static TablaAmortizationIndDATABEAN dataContenido() {
		TablaAmortizationIndDATABEAN tablaAmortizacionDetalleDTO = new TablaAmortizationIndDATABEAN();
		List<TablaAmortizacionIndDetalleDTO> tablaAmortizacionDTO = new ArrayList<TablaAmortizacionIndDetalleDTO>();
		tablaAmortizacionDetalleDTO.setTablaAmortizacion(tablaAmortizacionDTO);
		return tablaAmortizacionDetalleDTO;
	}

	public static List<TablaAmortizacionIndDetalleDTO> getDataBeanList(ReportResponse[] refTablaAmortizacionP) {
		List<TablaAmortizacionIndDetalleDTO> dataBeanList = new ArrayList<TablaAmortizacionIndDetalleDTO>();
		logger.logDebug("----->>>Inicio metodo --getDataBeanList -- refTablaAmortizacionP:" + refTablaAmortizacionP);
		if (refTablaAmortizacionP != null) {

			for (ReportResponse rtabP : refTablaAmortizacionP) {

				TablaAmortizacionIndDetalleDTO tablaAmortizacionDetalleDTO = new TablaAmortizacionIndDetalleDTO();

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getDividend -- No. del Periodo:" + rtabP.getDividend());
				tablaAmortizacionDetalleDTO.setDividend(rtabP.getDividend());

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getExpirationDate -- Fecha de Pago:" + rtabP.getExpirationDate());
				if (rtabP.getExpirationDate() != null) {
					tablaAmortizacionDetalleDTO.setExpirationDate(rtabP.getExpirationDate());
				} else {
					tablaAmortizacionDetalleDTO.setExpirationDate("");
				}

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getCapital -- Abono al Principal:" + rtabP.getCapital());
				if (rtabP.getCapital() != null) {
					tablaAmortizacionDetalleDTO.setCapital(rtabP.getCapital());
				} else {
					tablaAmortizacionDetalleDTO.setCapital(0.0);
				}

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getInterest -- Intereses Ordinarios:" + rtabP.getInterest());
				if (rtabP.getInterest() != null) {
					tablaAmortizacionDetalleDTO.setOrdinarInterest(rtabP.getInterest());
				} else {
					tablaAmortizacionDetalleDTO.setOrdinarInterest(0.0);
				}

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getInterestIVA -- Iva de Intereses Ordinarios:" + rtabP.getInterestIVA());
				if (rtabP.getInterestIVA() != null) {
					tablaAmortizacionDetalleDTO.setInterestIVA(rtabP.getInterestIVA());
				} else {
					tablaAmortizacionDetalleDTO.setInterestIVA(0.0);
				}

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getCapitalBalance -- Saldo Insoluto Capital:" + rtabP.getCapitalBalance());
				if (rtabP.getCapitalBalance() != null) {
					tablaAmortizacionDetalleDTO.setBalance(rtabP.getCapitalBalance());
				} else {
					tablaAmortizacionDetalleDTO.setBalance(0.0);
				}

				logger.logDebug("----->>>Inicio metodo --getDataBeanList -- getQuota -- Monto Pago:" + rtabP.getQuota());
				if (rtabP.getQuota() != null) {
					tablaAmortizacionDetalleDTO.setShare(rtabP.getQuota());
				} else {
					tablaAmortizacionDetalleDTO.setShare(0.0);
				}

				if (rtabP.getOthers() != null) {
					tablaAmortizacionDetalleDTO.setOthers(rtabP.getOthers());
				} else {
					tablaAmortizacionDetalleDTO.setOthers(0.0);
				}
				if (rtabP.getDelay() != null) {
					tablaAmortizacionDetalleDTO.setCriminalInterest(rtabP.getDelay());
				} else {
					tablaAmortizacionDetalleDTO.setCriminalInterest(0.0);
				}

				dataBeanList.add(tablaAmortizacionDetalleDTO);
			}
		}

		return dataBeanList;
	}

	public static List<ReportDebtors> getDataBeanDebtorsList(ReportResponse reportResponseHeader, ICTSServiceIntegration serviceIntegration) {

		ArrayList<ReportDebtors> dataBeanListDebtors = new ArrayList<ReportDebtors>();
		ReportDebtors resolucionDeCreditoSubReportDeudores = new ReportDebtors();
		if (reportResponseHeader != null) {

			logger.logDebug("------>>>>getDataBeanDebtorsList-reportResponseHeader.getGroup():" + reportResponseHeader.getGroup());

			resolucionDeCreditoSubReportDeudores.setClienteCodigo(reportResponseHeader.getGroupId());
			if (reportResponseHeader.getMeetings() != null) {
				resolucionDeCreditoSubReportDeudores.setClienteDireccion(reportResponseHeader.getMeetings());
			} else {
				resolucionDeCreditoSubReportDeudores.setClienteDireccion("");
			}
			if (reportResponseHeader.getGroup() != null) {
				resolucionDeCreditoSubReportDeudores.setClienteNombre(reportResponseHeader.getGroup());
			} else {
				resolucionDeCreditoSubReportDeudores.setClienteNombre("");
			}
			dataBeanListDebtors.add(resolucionDeCreditoSubReportDeudores);
		} else {
			dataDebtos(dataBeanListDebtors);
		}
		return dataBeanListDebtors;
	}

	private static void dataDebtos(ArrayList<ReportDebtors> dataBeanList) {
		ReportDebtors resolucionDeCreditoSubReportDeudores = new ReportDebtors();
		resolucionDeCreditoSubReportDeudores.setClienteDireccion("");
		resolucionDeCreditoSubReportDeudores.setClienteNombre("");
		resolucionDeCreditoSubReportDeudores.setClienteCodigo(0);
		dataBeanList.add(resolucionDeCreditoSubReportDeudores);
	}

}
