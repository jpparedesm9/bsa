package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.InterfacturaRfcGlobal;
import com.cobiscorp.cloud.scheduler.utils.GetFile;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;


public class InterFacturaGlobal extends NotificationGenericFile implements Job {
	private static final Logger LOGGER = Logger.getLogger(InterFacturaGlobal.class);
	private static String filesPathXmlGlobal = " "; // patch de origen
	private static String filesToHistPath = " ";// patch de destino de los
												// historicos

	@Override
	public Object xmlToDTO(File inputData) {
		InterfacturaRfcGlobal interFacturaGlobal = new InterfacturaRfcGlobal();
		try {
			File fileTemp = null;
			Map<String, String> toReplace = new HashMap<String, String>();
			toReplace.put("cfdi:", "");
			toReplace.put("if:", "");
			toReplace.put("tfd:", "");
			toReplace.put("as:", "");
			fileTemp = GetFile.replaceFileString(toReplace, inputData);
			JaxbUtil jxb = new JaxbUtil();
			interFacturaGlobal = (InterfacturaRfcGlobal) jxb.unmarshall(interFacturaGlobal, fileTemp);
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO Factura Global -->", e);
			GetFile.moveFileToHistoricalFolderError(inputData, filesToHistPath, "XMLError");
		}
		return interFacturaGlobal;
	}

	public void executeByInterFacturas(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByInterFacturas Global");
		}
		if (filesPathXmlGlobal == null || filesPathXmlGlobal.equals(" ") || filesPathXmlGlobal.equals("")) {
			filesPathXmlGlobal = pathInFacGlobalFileXml();
			LOGGER.debug("filesPathXmlGlobal.." + filesPathXmlGlobal);
		}
		if (filesToHistPath == null || filesToHistPath.equals(" ") || filesToHistPath.equals("")) {
			filesToHistPath = pathInFacHisFileXml();
			LOGGER.debug("filesToHistPath.." + filesToHistPath);
		}
		
	

		File[] xmlFile = GetFile.returnFile(arg0.getJobDetail().getName(), filesPathXmlGlobal);
		if (xmlFile != null) {
			try {
				if(GetFile.createHistoricalFolderError(filesToHistPath, "XMLError")!=null)
				{
				GetFile.createHistoricalFolderError(filesToHistPath, "XMLError");
				}
				Connection cn = null;
				CallableStatement executeSPXml = null;
				ConfigManager ds = ConfigManager.getInstance();
				LOGGER.debug("arg0.getJobDetail().getName() Global....." + arg0.getJobDetail().getName());
				List<InterfacturaRfcGlobal> interFacuturaList1 = new ArrayList<InterfacturaRfcGlobal>();
				interFacuturaList1 = (List<InterfacturaRfcGlobal>) GetFile.getFileXML(arg0.getJobDetail().getName(), xmlFile);
				LOGGER.debug("interFacuturaList1.size() Global" + interFacuturaList1.size());
				try {
					for (int i = 0; i < interFacuturaList1.size(); i++) {

						try {
							LOGGER.debug("i.." + i);
							cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
							String queryXml = "{ call cob_conta_super..sp_lee_inter_factura(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
							executeSPXml = cn.prepareCall(queryXml);
							// executeSPXml.setEscapeProcessing(true);
							// 1 opcion I
							executeSPXml.setString(1, "I");
							// 2 fecha de proceso
							
							if (interFacuturaList1.get(i).getFecha() != null) {
								LOGGER.debug("in_fecha Global..." + interFacuturaList1.get(i).getFecha());
								java.util.Date in_fecha = new java.util.Date();
								in_fecha = toDate(interFacuturaList1.get(i).getFecha());
								LOGGER.debug("in_fecha11 Global..."+in_fecha);
								executeSPXml.setTimestamp(2, new java.sql.Timestamp(in_fecha.getTime()));
							}
							//
							executeSPXml.setString(3, "banco");

						
							// 4 Rfc Cliente...
							if (interFacuturaList1.get(i).getReceptor().getRfc() != null) {
								LOGGER.debug("4 Rfc Cliente Global..." + interFacuturaList1.get(i).getReceptor().getRfc());
								executeSPXml.setString(4, interFacuturaList1.get(i).getReceptor().getRfc());
							}
							// 5 Email se saca en el sp de acuerdo al Rfc del
							// cliente
							executeSPXml.setString(5, "mail Global");
							// 6 Folio
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getUUID() != null) {
								LOGGER.debug("6 Folio Fiscal Global..." + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getUUID());
								executeSPXml.setString(6, interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getUUID());
							}
							// 7 certificado
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT() != null) {
								LOGGER.debug("7 Certificado global..." + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT());
								executeSPXml.setString(7, interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT());
							}
							// 8 Sello Digital
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloCFD() != null) {
								LOGGER.debug("8 Sello Digital Global" + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloCFD());
								executeSPXml.setString(8, interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloCFD());
							}
							// 9 Sello Sat...
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloSAT() != null) {
								LOGGER.debug("9 Sello Sat Global..." + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloSAT());
								executeSPXml.setString(9, interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getSelloSAT());
							}
							// 10 Num Certificado...
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT() != null) {
								LOGGER.debug("10 Num Certificado Global..." + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT());
								executeSPXml.setString(10, interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getNoCertificadoSAT());
							}
							// 11 Fecha hora Certificacion...
							if (interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getFechaTimbrado() != null) {
								LOGGER.debug("11 Fecha hora Certificacion Global..." + interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getFechaTimbrado());
								java.util.Date in_fecha1 = new java.util.Date();
								in_fecha1 = toDate(interFacuturaList1.get(i).getComplemento().getTimbreFiscalDigital().getFechaTimbrado());
								executeSPXml.setTimestamp(11, new java.sql.Timestamp(in_fecha1.getTime()));
							}
							executeSPXml.setString(12, "cadena Original Timbre");
							// 12 Cadena Original del Complemento del Sat
							/*if (interFacuturaList1.get(i).getAddenda().getFacturaInterfactura().getEncabezado().getCadenaOriginalTimbre() != null) {
								LOGGER.debug("12 Cadena Original del Complemento del Sat..."
										+ interFacuturaList1.get(i).getAddenda().getFacturaInterfactura().getEncabezado().getCadenaOriginalTimbre());
								executeSPXml.setString(12, interFacuturaList1.get(i).getAddenda().getFacturaInterfactura().getEncabezado().getCadenaOriginalTimbre());
							}*/
							String nombreArchivo=xmlFile[i].getName();
							if (nombreArchivo != null) {
								LOGGER.debug("13 nombreArchivo Global..."
										+ nombreArchivo);
								executeSPXml.setString(13, nombreArchivo);
							}
							
							String getProcessDate=GetFile.getProcessDate();
							LOGGER.debug("getProcessDate Global.." + getProcessDate);
							if (getProcessDate != null) {
								LOGGER.debug("14 getProcessDate Global..."
										+ getProcessDate);
								executeSPXml.setString(14, getProcessDate);
							}
							boolean ad = true;
							ad = executeSPXml.execute();
							LOGGER.debug("resulset.toString() Global:" + ad);
							// Opcion F
							String queryXml1 = "{ call cob_conta_super..sp_lee_inter_factura(?,?,?,?,?) }";
							executeSPXml = cn.prepareCall(queryXml1);
							// Opcion
							executeSPXml.setString(1, "F");
							// 2 fecha de proceso	
							if (interFacuturaList1.get(i).getFecha() != null) {
								LOGGER.debug("in_fecha2 Global..." + interFacuturaList1.get(i).getFecha());
								java.util.Date in_fecha2 = new java.util.Date();
								in_fecha2 = toDate(interFacuturaList1.get(i).getFecha());
								executeSPXml.setTimestamp(2, new java.sql.Timestamp(in_fecha2.getTime()));
							}
							//3 op_banco
							executeSPXml.setString(3, "banco");
							
							// 4 Rfc Cliente...
							if (interFacuturaList1.get(i).getReceptor().getRfc() != null) {
								LOGGER.debug("4 Rfc Cliente Global..." + interFacuturaList1.get(i).getReceptor().getRfc());
								executeSPXml.setString(4, interFacuturaList1.get(i).getReceptor().getRfc());
							}
							// 5 Email se saca en el sp de acuerdo al Rfc del
							// cliente
							executeSPXml.setString(5, "mail");

							executeSPXml.execute();
							ResultSet result = executeSPXml.getResultSet();

							if (result != null) {
								while (result.next()) {
									LOGGER.debug("result Global: " + result);
									LOGGER.debug("result.getInt(1) Global;" + result.getInt(1));
									if (result.getInt(1) == 70201) {
										throw new Exception("[70201] ERROR EN INGRESO DE ESTADO DE CUENTA");
									} else if (result.getInt(1) == 70200) {
										throw new Exception("[70200] ERROR EN INGRESO DE INTERFACTURA");
									}
								}
							}

							GetFile.moveFileToHistoricalFolder(xmlFile[i], filesToHistPath);

						} catch (SQLException e) {
							LOGGER.error("SQLException1 Global..:", e);
							GetFile.moveFileToHistoricalFolderError(xmlFile[i], filesToHistPath, "XMLError");
							throw e;
						} catch (Exception e) {
							LOGGER.error("Exception1 Global..:", e);
							GetFile.moveFileToHistoricalFolderError(xmlFile[i], filesToHistPath, "XMLError");
							throw e;
						}

					}
				} finally {
					if (executeSPXml != null) {
						try {
							executeSPXml.close();
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							LOGGER.error("SQLException 2 -->", e);
						}
					}
					System.gc();
				}

			} catch (Exception e) {
				LOGGER.error("Exception2...:", e);

			}
		} else {
			LOGGER.error("No existen Archivos en el Directorio Global..");
		}

	}

	private static String pathInFacGlobalFileXml() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa pathInFacGlobalFileXml");
		}

		ConfigManager config = ConfigManager.getInstance();
		String inFacGlobalFileXmlPath = "";
		inFacGlobalFileXmlPath = config.getXmlInFacGlobalFeliPath();
		LOGGER.debug(" ruta para getXmlInFacGlobalFeliPath" + inFacGlobalFileXmlPath);
		if (inFacGlobalFileXmlPath == null || inFacGlobalFileXmlPath.equals("") || inFacGlobalFileXmlPath.equals(" ")) {
			LOGGER.debug("No existe ruta para inFacGlobalFileXmlPath");
			return null;
		}
		return inFacGlobalFileXmlPath;
	}

	private static String pathInFacHisFileXml() {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa pathInFacHisFileXml");
		}
		ConfigManager config = ConfigManager.getInstance();
		String InFacHistFileXmlPath = "";
		InFacHistFileXmlPath = config.getXmlInFacFeliHisPath();
		LOGGER.debug(" ruta para InFacHistFileXmlPath" + InFacHistFileXmlPath);
		if (InFacHistFileXmlPath == null || InFacHistFileXmlPath.equals("") || InFacHistFileXmlPath.equals(" ")) {
			LOGGER.debug("No existe ruta para InFacHistFileXmlPath");
			return null;
		}
		return InFacHistFileXmlPath;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			executeByInterFacturas(arg0);

		} catch (Exception ex) {
			LOGGER.error("Exception: ", ex);
		}

	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		// TODO Auto-generated method stub
		return null;
	}

	public static Date toDate(XMLGregorianCalendar calendar) {
		if (calendar == null) {
			return null;
		}
		return calendar.toGregorianCalendar().getTime();
	}

}
