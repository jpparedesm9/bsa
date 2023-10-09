package com.cobiscorp.cloud.notificationservice.factory;

import java.util.Arrays;
import java.util.Collection;

import com.cobiscorp.cloud.notificationservice.dto.report.Pago;
import com.cobiscorp.cloud.notificationservice.impl.AlertaRiesgo;
import com.cobiscorp.cloud.notificationservice.impl.AperturaCuentasN4;
import com.cobiscorp.cloud.notificationservice.impl.CargaDomiciliacion;
import com.cobiscorp.cloud.notificationservice.impl.CargaListasNegras;
import com.cobiscorp.cloud.notificationservice.impl.CargaNegativeFile;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteAlertas;
import com.cobiscorp.cloud.notificationservice.impl.CargaReportePagos;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteReintegros;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteSeguroFuneralNetAltas;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteSeguroFuneralNetBajas;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteSeguros;
import com.cobiscorp.cloud.notificationservice.impl.CargaReporteSegurosNoCobrados;
import com.cobiscorp.cloud.notificationservice.impl.CargaReportesReestructura;
import com.cobiscorp.cloud.notificationservice.impl.CobranzaMcCollect;
import com.cobiscorp.cloud.notificationservice.impl.CopiaReporteAlertas;
import com.cobiscorp.cloud.notificationservice.impl.CopiaReportePagos;
import com.cobiscorp.cloud.notificationservice.impl.CopiaReporteSeguroFuneral;
import com.cobiscorp.cloud.notificationservice.impl.CreacionCreditoRevolvente;
import com.cobiscorp.cloud.notificationservice.impl.CustomerAndProspectInventory;
import com.cobiscorp.cloud.notificationservice.impl.DescargaDomiciliacion;
import com.cobiscorp.cloud.notificationservice.impl.DescargaListasNegras;
import com.cobiscorp.cloud.notificationservice.impl.EnvioEstadoCuenta;
import com.cobiscorp.cloud.notificationservice.impl.EstadoCuenta;
import com.cobiscorp.cloud.notificationservice.impl.EstadoCuentaIndividual;
import com.cobiscorp.cloud.notificationservice.impl.EstadoCuentaLCR;
import com.cobiscorp.cloud.notificationservice.impl.ExtraccionReporteAlertas;
import com.cobiscorp.cloud.notificationservice.impl.ExtraccionReportePagos;
import com.cobiscorp.cloud.notificationservice.impl.ExtraccionReporteReintegros;
import com.cobiscorp.cloud.notificationservice.impl.ExtraccionReporteSeguroFuneral;
import com.cobiscorp.cloud.notificationservice.impl.ExtraccionReportesSeguros;
import com.cobiscorp.cloud.notificationservice.impl.GenerateArchMcCCobis;
import com.cobiscorp.cloud.notificationservice.impl.GenerateReportAutoOnBoarding;
import com.cobiscorp.cloud.notificationservice.impl.GrupoVencidoCoord;
import com.cobiscorp.cloud.notificationservice.impl.GrupoVencidoGerent;
import com.cobiscorp.cloud.notificationservice.impl.IncumplimientoAval;
import com.cobiscorp.cloud.notificationservice.impl.InterFacturaGlobal;
import com.cobiscorp.cloud.notificationservice.impl.InterFacturas;
import com.cobiscorp.cloud.notificationservice.impl.InterfacturaRfcRXml;
import com.cobiscorp.cloud.notificationservice.impl.NotificacionGeneral;
import com.cobiscorp.cloud.notificationservice.impl.NotificacionPagoDescuento;
import com.cobiscorp.cloud.notificationservice.impl.NotificationGeneric;
import com.cobiscorp.cloud.notificationservice.impl.NotificationGenericFile;
import com.cobiscorp.cloud.notificationservice.impl.PagoCorresponsalJob;
import com.cobiscorp.cloud.notificationservice.impl.PagoCorresponsalias;
import com.cobiscorp.cloud.notificationservice.impl.PagoGarantiaLiquida;
import com.cobiscorp.cloud.notificationservice.impl.PagoGarantiaLiquidaIndividual;
import com.cobiscorp.cloud.notificationservice.impl.PaymentCard;
import com.cobiscorp.cloud.notificationservice.impl.RechazoCreditoRevolvente;
import com.cobiscorp.cloud.notificationservice.impl.ReferenciaPreCancelacion;
import com.cobiscorp.cloud.notificationservice.impl.ReintentoCargaAlfresco;
import com.cobiscorp.cloud.notificationservice.impl.SocialImpactReport;
import com.cobiscorp.cloud.notificationservice.impl.Traspaso;
import com.cobiscorp.cloud.notificationservice.impl.VencimientoCuota;
import com.cobiscorp.cloud.notificationservice.impl.VencimientoProxCuota;

public class NotificationServiceFactory {

	private static Pago[] dataCollection = { new Pago("Open Pay1", "10000"), new Pago("Open Pay2", "10000"), new Pago("Open Pay3", "10000") };

	/**
	 *
	 */
	public static Object[] getBeanArray() {
		return dataCollection;
	}

	/**
	 *
	 */
	public static Collection<Pago> getBeanCollection() {
		return Arrays.asList(dataCollection);

	}

	public static void setData(Pago[] data) {
		dataCollection = data;

	}

	private enum paramReport {
		PFPCO, // REPORTE DE PAGO DE CORRESPONSAL
		PFGVG, // REPORTE DE GRUPO VENCIDO GERENTE
		PFGVC, // REPORTE DE GRUPO VENCIDO COORDINADOR
		PFIAV, // REPORTE DE INCUMPLIMIENTO PARA AVALISTA
		PFCVE, // REPORTE DE VENCIMIENTO DE CUOTAS
		PPCVE, // REPORTE DE PROXIMO VENCIMIENTO DE CUOTAS
		PFGLQ, // REPORTE PAGO DE GARANTIAS LIQUIDAS
		PFGLI, // REPORTE PAGO DE GARANTIAS LIQUIDAS INDIVIDUALES
		PFEEC, // ENVIO DE ESTADO DE CUENTA
		NTGNR, // REPORTE NOTIFICACIONES GENERALES
		DSCLN, // DESCARGA DE LISTAS NEGRAS DESDE EL PROVEEDOR
		CRGLN, // CARGA DE LISTAS NEGRAS EN BASE DE DATOS
		GRPCN, // GENEREACION DE REFERENCIA DE PRECANCELACION DE GARANTIA LIQUIDA
		ETCUE, // ESTADO DE CUENTA
		ETCIN, // ESTADO DE CUENTA INDIVIDUALES
		INFAC, // DESCARGAR INTEFACTURAS
		CRGNF, // CARGA NEGATIVE FILE
		DSCDM, // DESCARGA DOMICILIACION
		CRGDM, // CARGA DOMICILIACION
		CRGRS, // CARGA DE REPORTES SEGUROS
		CRGRN, // CARGA DE REPORTES SEGUROS NO COBRADOS
		ALRRG, // ALERTAS DE RIESGO
		CPYRA, // COPIA DE REPORTE DE ALERTAS
		CRGRA, // CARGA DE REPORTE DE ALERTAS
		CPYSF, // Copiar Archivos Reportes de Seguros Funeral
		XTRSF, // Extrar Archivos Reportes de Seguros Funeral
		CRFAL, // Carga Reportes Seguro Funeral Net Altas
		CRFBA, // Carga Reportes Seguro Funeral Net Bajas
		XTRRS, // EXTRACCION DE REPORTES DE SEGUROS
		CPYRP, // Copiar Archivos Reportes de Pagos
		XTRRP, // Extrar Archivos Reportes de Pagos
		CRRPA, // Carga Reportes de Pagos
		TRSPS, // Envio de Traspasos
		CPYIF, // Copiar Archivos xml de Interfactura a carpeta Entrada para el dia anterior
		IFXML, // Procesamiento de archivos txt rechazados por interfactura
		INFACG, // Procesamiento de archivos de Interfactura con Rfc erroneos Global,
		CPYIFD, // Copiar Archivos xml de Interfactura a carpeta Entrada en mismo dia
		RELCR, // Rechazo de Credito LCR
		CRLCR, // Creacion de linea de credito revolvente
		XTRRA, // extraccion de Reportes de Alertas.
		PRDEAU, // Procesar desembolsos automaticos
		LCRFP, GRPCO, // REporte de pagos Corresponsal
		NPDTD, ETLCR, // Estado de Cuenta para LCR
		APCTN4, // Apertura de Cuentas N4
		CMCLI, // Comportameinto de Clientes Activos por Credito
		INVCL, // Inventario de clientes y Prospectos
		GSCMC, // Servicio de Cobranza Mc Collect
		GAMCC, // Servicio de Cobranza Mc Collect
		ESMSC, // ENVIO DE SMS COBRANZAS
		ESMSR, // ENVIO DE SMS RECORDATORIOS
		DAFAC, // Descarga archivo de respuesta para interfactura
		CRREE, // Carga Reportes Reestructura
		CPYREE, // Copia Reportes Reestructura
		CPYRR, // Copiar Archivos Reportes de Reintegros
		XTRRR, // Extrar Archivos Reportes de Reintegros
		CRRRR, // Carga Reportes de Reintegros,
		GRAOB, // Genera reportes AutoOnBoarding // genera segun el jobConfiguracion //NO TIENE properties // se disparan para que peudan ejecutar el
				// job
		COPYBTI, // Copia el archivo desde la base de datos al servidor web(internet)
		CHARITS, // Carga el archivo desde el servidor web(internet) a la ruta(sftp)
		RCAUPD // Reintento de carga archivos a alfresco y actualizacion cobis
	}

	public static NotificationGeneric getClass(String reportType) {
		if (paramReport.PFGVG.toString().equals(reportType)) {
			return new GrupoVencidoGerent();
		} else if (paramReport.PFGVC.toString().equals(reportType)) {
			return new GrupoVencidoCoord();
		} else if (paramReport.PFPCO.toString().equals(reportType)) {
			return new PagoCorresponsalias();
		} else if (paramReport.PFIAV.toString().equals(reportType)) {
			return new IncumplimientoAval();
		} else if (paramReport.PFCVE.toString().equals(reportType)) {
			return new VencimientoCuota();
		} else if (paramReport.PPCVE.toString().equals(reportType)) {
			return new VencimientoProxCuota();
		} else if (paramReport.PFGLQ.toString().equals(reportType)) {
			return new PagoGarantiaLiquida();
		} else if (paramReport.PFGLI.toString().equals(reportType)) {
			return new PagoGarantiaLiquidaIndividual();
		} else if (paramReport.PFEEC.toString().equals(reportType)) {
			return new EnvioEstadoCuenta();
		} else if (paramReport.NTGNR.toString().equals(reportType)) {
			return new NotificacionGeneral();
		} else if (paramReport.DSCLN.toString().equals(reportType)) {
			return new DescargaListasNegras();
		} else if (paramReport.CRGLN.toString().equals(reportType)) {
			return new CargaListasNegras();
		} else if (paramReport.GRPCN.toString().equals(reportType)) {
			return new ReferenciaPreCancelacion();
		} else if (paramReport.ETCUE.toString().equals(reportType)) {
			return new EstadoCuenta();
		} else if (paramReport.ETCIN.toString().equals(reportType)) {
			return new EstadoCuentaIndividual();
		} else if (paramReport.CRGNF.toString().equals(reportType)) {
			return new CargaNegativeFile();
		} else if (paramReport.DSCDM.toString().equals(reportType)) {
			return new DescargaDomiciliacion();
		} else if (paramReport.CRGDM.toString().equals(reportType)) {
			return new CargaDomiciliacion();
		} else if (paramReport.CRGRS.toString().equals(reportType)) {
			return new CargaReporteSeguros();
		} else if (paramReport.CRGRN.toString().equals(reportType)) {
			return new CargaReporteSegurosNoCobrados();
		} else if (paramReport.ALRRG.toString().equals(reportType)) {
			return new AlertaRiesgo();
		} else if (paramReport.CPYRA.toString().equals(reportType)) {
			return new CopiaReporteAlertas();
		} else if (paramReport.CRGRA.toString().equals(reportType)) {
			return new CargaReporteAlertas();
		} else if (paramReport.CPYSF.toString().equals(reportType)) {
			return new CopiaReporteSeguroFuneral();
		} else if (paramReport.XTRSF.toString().equals(reportType)) {
			return new ExtraccionReporteSeguroFuneral();
		} else if (paramReport.CRFAL.toString().equals(reportType)) {
			return new CargaReporteSeguroFuneralNetAltas();
		} else if (paramReport.CRFBA.toString().equals(reportType)) {
			return new CargaReporteSeguroFuneralNetBajas();
		} else if (paramReport.XTRRS.toString().equals(reportType)) {
			return new ExtraccionReportesSeguros();
		} else if (paramReport.CPYRP.toString().equals(reportType)) {
			return new CopiaReportePagos();
		} else if (paramReport.XTRRP.toString().equals(reportType)) {
			return new ExtraccionReportePagos();
		} else if (paramReport.CRRPA.toString().equals(reportType)) {
			return new CargaReportePagos();
		} else if (paramReport.TRSPS.toString().equals(reportType)) {
			return new Traspaso();
		} else if (paramReport.IFXML.toString().equals(reportType)) {
			return new InterfacturaRfcRXml();
		} else if (paramReport.RELCR.toString().equals(reportType)) {
			return new RechazoCreditoRevolvente();
		} else if (paramReport.CRLCR.toString().equals(reportType)) {
			return new CreacionCreditoRevolvente();
		} else if (paramReport.XTRRA.toString().equals(reportType)) {
			return new ExtraccionReporteAlertas();
		} else if (paramReport.LCRFP.toString().equals(reportType)) {
			return new PaymentCard();
		} else if (paramReport.GRPCO.toString().equals(reportType)) {
			return new PagoCorresponsalJob();
		} else if (paramReport.NPDTD.toString().equals(reportType)) {
			return new NotificacionPagoDescuento();
		} else if (paramReport.APCTN4.toString().equals(reportType)) {
			return new AperturaCuentasN4();
		} else if (paramReport.ETLCR.toString().equals(reportType)) {
			return new EstadoCuentaLCR();
		} else if (paramReport.CMCLI.toString().equals(reportType)) {
			return new SocialImpactReport();
		} else if (paramReport.INVCL.toString().equals(reportType)) {
			return new CustomerAndProspectInventory();
		} else if (paramReport.GSCMC.toString().equals(reportType)) {
			return new CobranzaMcCollect();
		} else if (paramReport.GAMCC.toString().equals(reportType)) {
			return new GenerateArchMcCCobis();
		} else if (paramReport.XTRRR.toString().equals(reportType)) {
			return new ExtraccionReporteReintegros();
		} else if (paramReport.CRRRR.toString().equals(reportType)) {
			return new CargaReporteReintegros();
		} else if (paramReport.CRREE.toString().equals(reportType)) {
			return new CargaReportesReestructura();
		} else if (paramReport.DAFAC.toString().equals(reportType)) {
			return new GenerateArchMcCCobis();
		} else if (paramReport.GRAOB.toString().equals(reportType)) {
			return new GenerateReportAutoOnBoarding();
		} else if (paramReport.RCAUPD.toString().equals(reportType)) {
			return new ReintentoCargaAlfresco();
		}
		return null;
	}

	public static NotificationGenericFile getGenericFileClass(String reportType) {
		if (paramReport.INFAC.toString().equals(reportType)) {
			return new InterFacturas();
		} else if (paramReport.INFACG.toString().equals(reportType)) {
			return new InterFacturaGlobal();
		}
		return null;
	}

}
