package com.cobiscorp.cobis.clcol.customevents.events;

import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.cobiscorp.cobis.clcol.customevents.exceptions.AdvisorColectiveExeption;
import com.cobiscorp.cobis.clcol.customevents.model.AdvisorColective;
import com.cobiscorp.cobis.clcol.model.CollectiveAdvisor;
import com.cobiscorp.cobis.clcol.model.CollectiveAdvisorFile;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class UploadFileAdvisor  extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(UploadFileAdvisor.class);
	private List<AdvisorColective> advisorColectivoList;
	
	public UploadFileAdvisor(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("Inicio executeCommand UploadFileAdvisor >>>" );
		advisorColectivoList = new ArrayList<AdvisorColective>();
		String fileName = null;
		String filePath = null;
		String extension = null;
		int  ejecucionActual=0;
		int  ejecucionSig=0;
		
		try {
			DataEntity entityFile = entities.getEntity(CollectiveAdvisorFile.ENTITY_NAME);
			ejecucionActual=entityFile.get(CollectiveAdvisorFile.EJECUTION);
			if(ejecucionActual==1)
			{
				ejecucionSig=ejecucionActual+1;
				LOGGER.logDebug("Primera llamada" );
				entityFile.set(CollectiveAdvisorFile.EJECUTION,ejecucionSig);
				DataEntityList listAdvisorColective = new DataEntityList();
				entities.setEntityList(CollectiveAdvisor.ENTITY_NAME, listAdvisorColective);
				args.setSuccess(true);
				
			}
			if(ejecucionActual==2)
			{
				LOGGER.logDebug("Segunda llamada" );
			fileName = entityFile.get(CollectiveAdvisorFile.NAMEFILE);
			filePath = (String) SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH);
			String fileParts[] = fileName.split("\\.");
			extension = fileParts[fileParts.length - 1];
			LOGGER.logDebug("PXSG extension asesor >>>" + extension);
			LOGGER.logDebug("PXSG fileName asesor >> " + fileName);
			LOGGER.logDebug("PXSG path asesor >>>" + filePath);
			if ("xls".equals(extension)) {
				readContentExcel(fileName, filePath);
			} else if ("xlsx".equals(extension)) {
				readContentExcelXML(fileName, filePath);
			} else {
				throw new AdvisorColectiveExeption("No soporta archivos con exensión " + extension);
			}
			validateRecord(entities, fileName);
			ejecucionSig=ejecucionActual+1;
			entityFile.set(CollectiveAdvisorFile.EJECUTION,ejecucionSig);
			args.setSuccess(true);
			
			}
		} catch (AdvisorColectiveExeption ex) {
			args.getMessageManager().showErrorMsg(ex.getMessage());
			args.setSuccess(false);
		} catch (Exception e) {
			LOGGER.logError("Error procesando el archivo " + fileName, e);
			args.getMessageManager().showErrorMsg("Error procesando el archivo " + fileName);
			args.setSuccess(false);
		}
		
	}
	
	private void readContentExcel(String fileName, String filePath) throws AdvisorColectiveExeption {
		AdvisorColective advisor = null;
		FileInputStream entradaArchivo = null;
		try {
			entradaArchivo = new FileInputStream(filePath);
			HSSFWorkbook libro;
			libro = new HSSFWorkbook(entradaArchivo);
			HSSFSheet hoja = libro.getSheetAt(0);
			// EN LA PRIMERA HOJA
			Iterator filaIterador = hoja.rowIterator();

			while (filaIterador.hasNext()) {
				HSSFRow hssfRow = (HSSFRow) filaIterador.next();
				advisor = new AdvisorColective();
				// VALIDAR ESTRUCTURA DE LA FILA
				LOGGER.logError("hssfRow.getRowNum" + hssfRow.getRowNum());
				//person.setNumber(hssfRow.getRowNum() + 1);
				
				if(hssfRow.getRowNum()>0){
				if (isValidRow(hssfRow)) {
					advisor.setCollective(hssfRow.getCell(0).toString());
					advisor.setCustomerName(hssfRow.getCell(1).toString());
					advisor.setCustomerId(getInteger(hssfRow.getCell(2)));
					advisor.setCustomerAddress(hssfRow.getCell(3).toString());
					advisor.setCustomerCell(hssfRow.getCell(4).toString());
					advisor.setEmail(hssfRow.getCell(5).toString());
					advisor.setAsesorExterno(getInteger(hssfRow.getCell(6)));
					LOGGER.logDebug("collective1"+advisor.getCollective());
					LOGGER.logDebug("name1"+advisor.getCustomerName());
					LOGGER.logDebug("id1"+advisor.getCustomerId());
					LOGGER.logDebug("address1"+advisor.getCustomerAddress());
					LOGGER.logDebug("cell1"+advisor.getCustomerCell());
					LOGGER.logDebug("email1"+advisor.getEmail());
					LOGGER.logDebug("Ase Externo12"+advisor.getAsesorExterno() );
				
					advisorColectivoList.add(advisor);
				}
				}
			}
			LOGGER.logDebug("Se cargan los datoss> " + advisorColectivoList.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo " + fileName, e1);
			throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
				}
			}
		}
	}
	
	private void readContentExcelXML(String fileName, String filePath) throws AdvisorColectiveExeption {
		AdvisorColective advisor = null;
		FileInputStream entradaArchivo = null;
		try {
			entradaArchivo = new FileInputStream(filePath);
			XSSFWorkbook libro;
			libro = new XSSFWorkbook(entradaArchivo);
			XSSFSheet hoja = libro.getSheetAt(0);
			// EN LA PRIMERA HOJA
			Iterator filaIterador = hoja.rowIterator();
			// CABECERA
			///
			 // if (filaIterador.hasNext()) { XSSFRow hssfRow = (XSSFRow)
			 // filaIterador.next(); if (hssfRow.getCell(0) == null ||
			// !"Fecha de Pago".trim().equals(hssfRow.getCell(0).toString().trim
			 // ())) { throw new
			 // MassivePaymentsException("El archivo no tiene la cabecera correcta"
			 //); } } else { throw new
			 // MassivePaymentsException("El archivo no tiene cabecera"); }
			 

			while (filaIterador.hasNext()) {
				XSSFRow hssfRow = (XSSFRow) filaIterador.next();
				advisor = new AdvisorColective();
				LOGGER.logError("hssfRow.getRowNum" + hssfRow.getRowNum());
              // advisor.setNumber(hssfRow.getRowNum() + 1);
               if(hssfRow.getRowNum()>0){
				if (isValidRow(hssfRow)) {
					
					advisor.setCollective(hssfRow.getCell(0).toString());
					advisor.setCustomerName(hssfRow.getCell(1).toString());
					advisor.setCustomerId(getInteger(hssfRow.getCell(2)));
					advisor.setCustomerAddress(hssfRow.getCell(3).toString());
					advisor.setCustomerCell(hssfRow.getCell(4).toString());
					advisor.setEmail(hssfRow.getCell(5).toString());
					advisor.setAsesorExterno(getInteger(hssfRow.getCell(6)));
					
					LOGGER.logDebug("collective1"+advisor.getCollective());
					LOGGER.logDebug("name1"+advisor.getCustomerName());
					LOGGER.logDebug("id1"+advisor.getCustomerId());
					LOGGER.logDebug("address1"+advisor.getCustomerAddress());
					LOGGER.logDebug("cell1"+advisor.getCustomerCell());
					LOGGER.logDebug("email1"+advisor.getEmail());
					LOGGER.logDebug("Ase Externo1"+advisor.getAsesorExterno() );
				

					advisorColectivoList.add(advisor);
				}
               }
			}
			
			LOGGER.logDebug("datos cargados xlsx> " + advisorColectivoList.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo  xlsx" + fileName, e1);
			throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new AdvisorColectiveExeption("Error al leer el archivo " + fileName);
				}
			}
		}
	}
	
	private void validateRecord(DynamicRequest entities, String fileName) throws AdvisorColectiveExeption {
		DataEntity advisorColectiveRecordEntity = null;
		//ServiceResponse response = null;
		//PaymentRecord[] paymentRecords = null;
		DataEntityList listAdvisorColective = new DataEntityList();
		ServiceRequestTO request = new ServiceRequestTO();
		int observationsNumber = 0;
		DataEntity entityFile = entities.getEntity(CollectiveAdvisorFile.ENTITY_NAME);

		try {
			//PaymentRecord paymentRecordRequest = new PaymentRecord();
			//paymentRecordRequest.setFileName(fileName);
			//request.addValue("inPaymentRecord", paymentRecordRequest);
			//response = this.execute(getServiceIntegration(), LOGGER, "Payments.MassivePayment.ValidatePayments",
			//		request);

			/*if (!response.isResult()) {
				throw new MassivePaymentsException(
						"Error al validar pagos " + fileName + ". " + getErrorMessages(response));
			}
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			paymentRecords = (PaymentRecord[]) serviceResponseTO.getValue("returnPaymentRecord");*/

			for (AdvisorColective advisorcolective : advisorColectivoList) {
				advisorColectiveRecordEntity = new DataEntity();
				advisorColectiveRecordEntity.set(CollectiveAdvisor.COLLECTIVE, advisorcolective.getCollective());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.CUSTOMERNAME, advisorcolective.getCustomerName());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.CUSTOMERID, advisorcolective.getCustomerId());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.CUSTOMERADDRESS, advisorcolective.getCustomerAddress());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.CUSTOMERCELL, advisorcolective.getCustomerCell());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.CUSTOMERMAIL, advisorcolective.getEmail());
				advisorColectiveRecordEntity.set(CollectiveAdvisor.EXTERNALADVISOR, advisorcolective.getAsesorExterno());
				/*if (payment.getObservations() != null && payment.getObservations().trim().length() != 0) {
					observationsNumber++;
				}*/
				listAdvisorColective.add(advisorColectiveRecordEntity);
			}
			//entityFile.set(CollectivePersonRecord.OBSERVATIONS, personcolective);

			entities.setEntityList(CollectiveAdvisor.ENTITY_NAME, listAdvisorColective);
		} catch (Exception ex) {
			LOGGER.logError("al cagar los datos del archivo " + fileName, ex);
			throw new AdvisorColectiveExeption("Error al cagar los datos del archivo " + fileName);
		}
	}


	private boolean isValidRow(HSSFRow hssfRow) {
		if (hssfRow.getCell(0) != null && !"".equals(hssfRow.getCell(0).toString().trim()) && hssfRow.getCell(1) != null
				&& !"".equals(hssfRow.getCell(1).toString().trim())) {
			return true;
		}
		return false;
	}

	private boolean isValidRow(XSSFRow hssfRow) {
		if (hssfRow.getCell(0) != null && !"".equals(hssfRow.getCell(0).toString().trim()) && hssfRow.getCell(1) != null
				&& !"".equals(hssfRow.getCell(1).toString().trim())) {
			return true;
		}
		return false;
	}

	

	private String getDate(HSSFCell cell) {
		// SimpleDateFormat
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date date = null;
		LOGGER.logDebug("Invocando getDate TYPE-->> " + cell.getCellType());
		if (cell.getCellType() == 0) {
			// si no resulta
			LOGGER.logDebug("getDate Convierte con SDF");
			date = cell.getDateCellValue();
			return sdf.format(date);
		} else {
			LOGGER.logDebug("getDate Convierte con toString");
			return cell.toString();
		}
	}

	private String getInteger(HSSFCell cell) {
		int valor;
		if (cell == null) {
			return "";
		}
		try {
			LOGGER.logDebug("getInteger Convierte con BigDecimal");
			valor = new BigDecimal(cell.toString()).intValue();
			return valor + "";
		} catch (Exception ex) {
			LOGGER.logDebug("getInteger Convierte con toString");
			return cell.toString();
		}
	}

	private String getDate(XSSFCell cell) {
		// SimpleDateFormat
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date date = null;
		LOGGER.logDebug("Invocando getDate TYPE-->> " + cell.getCellType());
		if (cell.getCellType() == 0) {
			// si no resulta
			LOGGER.logDebug("getDate Convierte con SDF");
			date = cell.getDateCellValue();
			return sdf.format(date);
		} else {
			LOGGER.logDebug("getDate Convierte con toString");
			return cell.toString();
		}
	}

	private String getInteger(XSSFCell cell) {
		int valor;
		if (cell == null) {
			return "";
		}
		try {
			LOGGER.logDebug("getInteger Convierte con BigDecimal");
			valor = new BigDecimal(cell.toString()).intValue();
			return valor + "";
		} catch (Exception ex) {
			LOGGER.logDebug("getInteger Convierte con toString");
			return cell.toString();
		}
	}

	private String getErrorMessages(ServiceResponse response) {
		List<Message> messages = response.getMessages();
		String errorMessage = "";
		for (Message message : messages) {
			if (message.getCode() != null && !"0".equals(message.getCode())) {
				errorMessage += message.getMessage();
			}
		}
		return errorMessage;
	}


}
