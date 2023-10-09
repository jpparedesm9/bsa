package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.bind.UnmarshalException;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.ComprobantePax;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.GetFile;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class InterFacturas extends NotificationGenericFile implements Job {
	private static final Logger LOGGER = Logger.getLogger(InterFacturas.class);
	CopyFileJob copyFileJob = null;
	FileExchangeResponse fileExchangeResponse;

	@Override
	public Object xmlToDTO(File inputData) {
		if(LOGGER.isDebugEnabled()) {
			LOGGER.debug("Archivo a procesar: " + inputData);
		}
		ComprobantePax interFactura = new ComprobantePax();
		try {
			File fileTemp = null;
			Map<String, String> toReplace = new HashMap<String, String>();
			toReplace.put("cfdi:", "");
			toReplace.put("if:", "");
			toReplace.put("tfd:", "");
			fileTemp = GetFile.replaceFileString(toReplace, inputData);
			JaxbUtil jxb = new JaxbUtil();
			try {
				interFactura = (ComprobantePax) jxb.unmarshall(interFactura, fileTemp);
			} catch (UnmarshalException un) {
				LOGGER.error("La extructura del Xml no es la correcta para el archivo-->" + inputData.getName());
			}
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
			fileExchangeResponse = copyFileJob.moveFileToWorkFolder(inputData);
			if (!fileExchangeResponse.isSuccess()) {
				LOGGER.error(fileExchangeResponse.getErrorMessage());
			}
		}
		return interFactura;
	}

	/**
	 * Genera facturas
	 */
	public void generateInvoices(CopyFileJob copyFileJob) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia generateInvoices");
		}

		File[] xmlFiles = copyFileJob.getlistFiles();

		if (xmlFiles != null) {
			try {
				List<ComprobantePax> invoices = (List<ComprobantePax>) GetFile.getFileXML(copyFileJob.getProcess().name(), xmlFiles);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Total de facturas: " + invoices.size());
				}

				if (invoices.size() > 0) {
					XMLGregorianCalendar fecha;
					java.util.Date fechaAsDate = null;
					String numeroOperacion;
					String rfc;
					String uuid;
					String certificadoSAT;
					String selloCFD;
					String selloSAT;
					XMLGregorianCalendar fechaTimbrado;
					java.util.Date fechaTimbradoAsDate = null;
					String cadenaOriginal;
					String nombreArchivo;
					String fechaSistema;
					String rfcEmisor;
					String montoFactura;
					String metodoFactura;
					String estadoTimbrado;

					ConfigManager ds = ConfigManager.getInstance();
					Connection cn = null;
					CallableStatement executeSPXml = null;
					String queryXml;
					ResultSet result;

					try {
						for (int i = 0; i < invoices.size(); i++) {
							try {

								// INSERCIÓN EN TABLA DE XML TIMBRADOS
								cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
								queryXml = "{ call cob_conta_super..sp_lee_inter_factura(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
								executeSPXml = cn.prepareCall(queryXml);

								// 1: Operación I
								executeSPXml.setString(1, "I");

								// 2: Fecha de archivo
								fecha = invoices.get(i).getFecha();
								if (fecha != null) {
									fechaAsDate = toDate(fecha);
									executeSPXml.setTimestamp(2, new java.sql.Timestamp(fechaAsDate.getTime()));
								}

								// 3: Número de operación
								numeroOperacion = invoices.get(i).getConceptos().getConcepto().getNoIdentificacion();
								if (numeroOperacion != null) {
									executeSPXml.setString(3, numeroOperacion);
								}

								// 4: RFC cliente
								rfc = invoices.get(i).getReceptor().getRfc();
								if (rfc != null) {
									executeSPXml.setString(4, rfc);
								}
								// 5: Mail
								executeSPXml.setString(5, "mail");

								// 6: Folio fiscal
								uuid = invoices.get(i).getComplemento().getTimbreFiscalDigital().getUUID();
								if (uuid != null) {
									executeSPXml.setString(6, uuid);
								}

								// 7: Certificado SAT
								certificadoSAT = invoices.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT();
								if (certificadoSAT != null) {
									executeSPXml.setString(7, certificadoSAT);
								}

								// 8: Sello CFD
								selloCFD = invoices.get(i).getComplemento().getTimbreFiscalDigital().getSelloCFD();
								if (selloCFD != null) {
									executeSPXml.setString(8, selloCFD);
								}

								// 9: Sello SAT
								selloSAT = invoices.get(i).getComplemento().getTimbreFiscalDigital().getSelloSAT();
								if (selloSAT != null) {
									executeSPXml.setString(9, selloSAT);
								}

								// 10: Certificado SAT
								if (certificadoSAT != null) {
									executeSPXml.setString(10, certificadoSAT);
								}

								// 11: Fecha timbrado
								fechaTimbrado = invoices.get(i).getComplemento().getTimbreFiscalDigital().getFechaTimbrado();
								if (fechaTimbrado != null) {
									fechaTimbradoAsDate = toDate(fechaTimbrado);
									executeSPXml.setTimestamp(11, new java.sql.Timestamp(fechaTimbradoAsDate.getTime()));
								}

								// 12: Cadena original timbre
								cadenaOriginal = invoices.get(i).getAddenda().getAd().getCadenaOriginal();
								if (cadenaOriginal != null) {
									executeSPXml.setString(12, cadenaOriginal);
								}

								// 13: Archivo
								nombreArchivo = xmlFiles[i].getName();
								executeSPXml.setString(13, nombreArchivo);

								// 14: Fecha de proceso
								fechaSistema = GetFile.getProcessDate();
								if (fechaSistema != null) {
									executeSPXml.setString(14, fechaSistema);
								}

								// 15 RcfEmisor
								rfcEmisor = invoices.get(i).getEmisor().getRfc();
								if (rfcEmisor != null) {
									executeSPXml.setString(15, rfcEmisor);
								}

								// Estado Timbrado
								estadoTimbrado = "S";
								executeSPXml.setString(16, estadoTimbrado);

								// Monto para qr
								montoFactura = String.valueOf(invoices.get(i).getTotal());

								if (montoFactura != null) {
									executeSPXml.setString(17, montoFactura);
								}
								// Metodo Facturacion

								metodoFactura = invoices.get(i).getMetodoPago();
								if (metodoFactura != null) {
									executeSPXml.setString(18, metodoFactura);
								}

								if (LOGGER.isDebugEnabled()) {
									
									LOGGER.debug("*** FACTURA " + i);
									LOGGER.debug("2 - getFecha(): " + fecha);
									LOGGER.debug("2 - getFecha() as Date: " + fechaAsDate);
									LOGGER.debug("3 - getCodigo(): " + numeroOperacion);
									LOGGER.debug("4 - getRfc(): " + rfc);
									LOGGER.debug("6 - getUUID(): " + uuid);
									LOGGER.debug("7 - getNoCertificadoSAT(): " + certificadoSAT);
									LOGGER.debug("8 - getSelloCFD(): " + selloCFD);
									LOGGER.debug("9 - getSelloSAT(): " + selloSAT);
									LOGGER.debug("10 - getNoCertificadoSAT(): " + certificadoSAT);
									LOGGER.debug("11 - getFechaTimbrado(): " + fechaTimbrado);
									LOGGER.debug("11 - getFechaTimbrado() as Date: " + fechaTimbradoAsDate);
									LOGGER.debug("12 - getCadenaOriginalTimbre(): " + cadenaOriginal);
									LOGGER.debug("13 - Archivo: " + nombreArchivo);
									LOGGER.debug("14 - Fecha de Sistema: " + fechaSistema);
									LOGGER.debug("15 - rfcEmisor: " + rfcEmisor);
									LOGGER.debug("16 - estadoTimbrado: " + estadoTimbrado);
									LOGGER.debug("17 - montoFactura: " + montoFactura);
									LOGGER.debug("18 - metodoFactura: " + metodoFactura);

								}

								executeSPXml.execute();

								result = executeSPXml.getResultSet();
								
								LOGGER.debug("Resultado de la actualización " + result);

								if (result != null) {
									while (result.next()) {
										if (LOGGER.isDebugEnabled()) {
											LOGGER.debug("result: " + result);
											LOGGER.debug("result.getInt(1);" + result.getInt(1));
										}
										if (result.getInt(1) == 70201) {
											throw new Exception("[70201] ERROR EN INGRESO DE ESTADO DE CUENTA");
										} else if (result.getInt(1) == 70200) {
											throw new Exception("[70200] ERROR EN INGRESO DE INTERFACTURA");
										}
									}
								}

								cn.close();

								// XML OK
								fileExchangeResponse = copyFileJob.moveFileToDestination(xmlFiles[i]);

							} catch (SQLException e) {
								LOGGER.error("SQLException1..:", e);
								fileExchangeResponse = copyFileJob.moveFileToWorkFolder(xmlFiles[i]);
							} catch (Exception e) {
								LOGGER.error("Exception1..:", e);
								fileExchangeResponse = copyFileJob.moveFileToWorkFolder(xmlFiles[i]);
							}

							if (!fileExchangeResponse.isSuccess()) {
								LOGGER.error(fileExchangeResponse.getErrorMessage());
							}
						}
					} finally {
						if (executeSPXml != null) {
							try {
								executeSPXml.close();
							} catch (SQLException e) {
								LOGGER.error("SQLException 2 -->", e);
							}
						}
						if (cn != null) {
							try {
								cn.close();
							} catch (SQLException e) {
								LOGGER.error("SQLException 2 -->", e);
							}
						}
						System.gc();
					}
				}

			} catch (Exception e) {
				LOGGER.error("Exception2...:", e);
			}
		} else {
			LOGGER.error("No existen Archivos en el Directorio..");
		}

	}

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			LOGGER.debug("Inicia generación de Estados de Cuenta");
		}

		try {
			copyFileJob = new CopyFileJob(FileJob.Job.INFAC);
			generateInvoices(copyFileJob);
		} catch (Exception ex) {
			LOGGER.error("Error al copiar archivos de interfactura Procesados: ", ex);
		}
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		return null;
	}

	public static Date toDate(XMLGregorianCalendar calendar) {
		if (calendar == null) {
			return null;
		}
		return calendar.toGregorianCalendar().getTime();
	}

}
