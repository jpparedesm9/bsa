package com.cobiscorp.cobis.assts.massivepayments.customevents.events;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
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

import com.cobiscorp.cobis.assts.customevents.model.Payment;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.cobiscorp.cobis.assts.model.MassivePaymentFile;
import com.cobiscorp.cobis.assts.model.MassivePaymentRecord;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.massivepayment.exceptions.MassivePaymentsException;
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
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.payments.dto.PaymentRecord;

public class ReadFile extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ReadFile.class);

	private List<Payment> payments;

	// TODO:Agregar el tipo de archivo que SOPORTA

	public ReadFile(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		payments = new ArrayList<Payment>();
		String fileName = null;
		String filePath = null;
		String extension = null;

		try {
			DataEntity entityFile = entities.getEntity(MassivePaymentFile.ENTITY_NAME);
			fileName = entityFile.get(MassivePaymentFile.FILENAME);
			filePath = (String) SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH);
			String fileParts[] = fileName.split("\\.");
			extension = fileParts[fileParts.length - 1];
			LOGGER.logDebug("SMO extension >>>" + extension);
			LOGGER.logDebug("SMO fileName >> " + fileName);
			LOGGER.logDebug("SMO path >>>" + filePath);
			if ("xls".equals(extension)) {
				readContentExcel(fileName, filePath);
			} else if ("xlsx".equals(extension)) {
				readContentExcelXML(fileName, filePath);
			} else {
				throw new MassivePaymentsException("No soporta archivos con exensión " + extension);
			}
			registerPayment(fileName);
			validatePayments(entities, fileName);
			args.setSuccess(true);
		} catch (MassivePaymentsException ex) {
			args.getMessageManager().showErrorMsg(ex.getMessage());
			args.setSuccess(false);
		} catch (Exception e) {
			LOGGER.logError("Error procesando el archivo " + fileName, e);
			args.getMessageManager().showErrorMsg("Error procesando el archivo " + fileName);
			args.setSuccess(false);
		}
	}

	private void registerPayment(String fileName) throws MassivePaymentsException {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		PaymentRecord paymentRecord = new PaymentRecord();
		Payment payment = null;
		for (int i = 0; i < payments.size(); i++) {
			payment = payments.get(i);
			paymentRecord = new PaymentRecord();
			// Antes de registrar el primer registro, el sp debe borrar lo
			// anterior
			if (i == 0) {
				paymentRecord.setDelete("S");
			}
			paymentRecord.setRowNumber(payment.getRowNumber());
			paymentRecord.setCorresponsalCode(payment.getInternalCode());
			paymentRecord.setDate(payment.getPaymentDate());
			paymentRecord.setReference(payment.getReference());
			paymentRecord.setAmount(payment.getAmount());
			paymentRecord.setPaymentMethod(payment.getPaymentMethod());
			paymentRecord.setFileName(fileName);

			// Por cada uno invocar al servicio
			LOGGER.logDebug("SMO payment " + payment);
			request.addValue("inPaymentRecord", paymentRecord);
			try {
				response = this.execute(getServiceIntegration(), LOGGER, "Payments.MassivePayment.RegisterPayment",
						request);
			} catch (Exception ex) {
				LOGGER.logError("Error al registrar pagos " + fileName, ex);
				throw new MassivePaymentsException("Error al registrar pagos " + fileName);
			}
			if (!response.isResult()) {
				throw new MassivePaymentsException(
						"Error al registrar pagos " + fileName + ". " + getErrorMessages(response));
			}

		}
	}

	private void validatePayments(DynamicRequest entities, String fileName) throws MassivePaymentsException {
		DataEntity paymentRecordEntity = null;
		ServiceResponse response = null;
		PaymentRecord[] paymentRecords = null;
		DataEntityList paymentsList = new DataEntityList();
		ServiceRequestTO request = new ServiceRequestTO();
		int observationsNumber = 0;
		DataEntity entityFile = entities.getEntity(MassivePaymentFile.ENTITY_NAME);

		try {
			PaymentRecord paymentRecordRequest = new PaymentRecord();
			paymentRecordRequest.setFileName(fileName);
			request.addValue("inPaymentRecord", paymentRecordRequest);
			response = this.execute(getServiceIntegration(), LOGGER, "Payments.MassivePayment.ValidatePayments",
					request);

			if (!response.isResult()) {
				throw new MassivePaymentsException(
						"Error al validar pagos " + fileName + ". " + getErrorMessages(response));
			}
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			paymentRecords = (PaymentRecord[]) serviceResponseTO.getValue("returnPaymentRecord");

			for (PaymentRecord payment : paymentRecords) {
				paymentRecordEntity = new DataEntity();
				paymentRecordEntity.set(MassivePaymentRecord.ROWNUMBER, payment.getRowNumber());
				paymentRecordEntity.set(MassivePaymentRecord.AMOUNT, payment.getAmount());
				paymentRecordEntity.set(MassivePaymentRecord.PAYMENTDATE, payment.getDate());
				paymentRecordEntity.set(MassivePaymentRecord.CORRESPONSALCODE, payment.getCorresponsalCode());
				paymentRecordEntity.set(MassivePaymentRecord.OBSERVATIONS, payment.getObservations());
				paymentRecordEntity.set(MassivePaymentRecord.REFERENCE, payment.getReference());
				paymentRecordEntity.set(MassivePaymentRecord.PAYMENTMETHOD, payment.getPaymentMethod());
				if (payment.getObservations() != null && payment.getObservations().trim().length() != 0) {
					observationsNumber++;
				}
				paymentsList.add(paymentRecordEntity);
			}
			entityFile.set(MassivePaymentFile.FILEOBSERVATIONS, observationsNumber);

			entities.setEntityList(MassivePaymentRecord.ENTITY_NAME, paymentsList);
		} catch (MassivePaymentsException ex) {
			throw ex;
		} catch (Exception ex) {
			LOGGER.logError("Error al validar pagos " + fileName, ex);
			throw new MassivePaymentsException("Error al validar pagos " + fileName);
		}
	}

	private void readContent(String filePath) {
		String linea = "";
		File file = new File(filePath);
		FileReader fileReader;
		BufferedReader bufferedReader = null;
		String partes[];
		try {
			Payment payment = null;
			fileReader = new FileReader(file);
			bufferedReader = new BufferedReader(fileReader);
			while ((linea = bufferedReader.readLine()) != null) {
				LOGGER.logDebug(linea);
				partes = linea.split("-");
				payment = new Payment(Integer.parseInt(partes[0]), partes[1], partes[2], partes[3], partes[4],
						partes[5]);
				payments.add(payment);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

	private void readContentExcel(String fileName, String filePath) throws MassivePaymentsException {
		Payment payment = null;
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
				payment = new Payment();
				// VALIDAR ESTRUCTURA DE LA FILA
				payment.setRowNumber(hssfRow.getRowNum() + 1);
				if (isValidRow(hssfRow)) {
					payment.setPaymentDate(getDate(hssfRow.getCell(0)));
					payment.setReference(hssfRow.getCell(1).toString());
					payment.setAmount(hssfRow.getCell(2).toString());
					payment.setPaymentMethod(hssfRow.getCell(3).toString());
					payment.setInternalCode(getInteger(hssfRow.getCell(4)));
					payments.add(payment);
				}
			}
			LOGGER.logDebug("SMO Cargados los pagos> " + payments.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo " + fileName, e1);
			throw new MassivePaymentsException("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new MassivePaymentsException("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new MassivePaymentsException("Error al leer el archivo " + fileName);
				}
			}
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

	private void readContentExcelXML(String fileName, String filePath) throws MassivePaymentsException {
		Payment payment = null;
		FileInputStream entradaArchivo = null;
		try {
			entradaArchivo = new FileInputStream(filePath);
			XSSFWorkbook libro;

			libro = new XSSFWorkbook(entradaArchivo);
			XSSFSheet hoja = libro.getSheetAt(0);
			// EN LA PRIMERA HOJA
			Iterator filaIterador = hoja.rowIterator();
			// CABECERA
			/*
			 * if (filaIterador.hasNext()) { XSSFRow hssfRow = (XSSFRow)
			 * filaIterador.next(); if (hssfRow.getCell(0) == null ||
			 * !"Fecha de Pago".trim().equals(hssfRow.getCell(0).toString().trim
			 * ())) { throw new
			 * MassivePaymentsException("El archivo no tiene la cabecera correcta"
			 * ); } } else { throw new
			 * MassivePaymentsException("El archivo no tiene cabecera"); }
			 */

			while (filaIterador.hasNext()) {
				XSSFRow hssfRow = (XSSFRow) filaIterador.next();
				payment = new Payment();
				// VALIDAR ESTRUCTURA DE LA FILA
				payment.setRowNumber(hssfRow.getRowNum() + 1);
				if (isValidRow(hssfRow)) {
					payment.setPaymentDate(getDate(hssfRow.getCell(0)));
					payment.setReference(hssfRow.getCell(1).toString());
					payment.setAmount(hssfRow.getCell(2).toString());
					payment.setPaymentMethod(hssfRow.getCell(3).toString());
					payment.setInternalCode(getInteger(hssfRow.getCell(4)));
					payments.add(payment);
				}
			}
			LOGGER.logDebug("SMO Cargados los pagos> " + payments.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo " + fileName, e1);
			throw new MassivePaymentsException("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new MassivePaymentsException("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new MassivePaymentsException("Error al leer el archivo " + fileName);
				}
			}
		}
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
