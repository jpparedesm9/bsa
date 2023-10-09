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

import com.cobiscorp.cobis.clcol.customevents.exceptions.PersonColectiveExeption;
import com.cobiscorp.cobis.clcol.customevents.model.PersonColective;
import com.cobiscorp.cobis.clcol.customevents.util.Utils;
import com.cobiscorp.cobis.clcol.model.CollectivePersonFile;
import com.cobiscorp.cobis.clcol.model.CollectivePersonRecord;
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
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;
import com.cobiscorp.ecobis.busin.model.CatalogDto;

//import com.cobiscorp.cobis.cstmr.commons.loadCatalog.LoadCatalogExecutiveCustomer;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.collective.dto.ProspectFilename;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficeResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.CustomerCatalogManager;
import com.cobiscorp.ecobis.collective.commons.services.ProcessEntityManager;

public class UploadFile extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UploadFile.class);
	private static final int CELL_NUMBERS = 15; //22;
	private List<PersonColective> personColectivoList;
	private static final String UTF8 = "UTF-8";
	private static final String ISO = "ISO-8859-1";
	private static final String NOTEXISTS = "No Existe";
	private static final String FML_CODE = "F";
	private static final String ML_CODE = "M";
	private static final String WRMG_CODE = "X";

	public UploadFile(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("Inicio executeCommand VA_VABUTTONSFBIETG_385908 >>>");

		personColectivoList = new ArrayList<PersonColective>();
		String fileName = null;
		String filePath = null;
		String extension = null;
		try {
			DataEntity entityFile = entities.getEntity(CollectivePersonFile.ENTITY_NAME);
			fileName = entityFile.get(CollectivePersonFile.FILENAME);
			filePath = (String) SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH);
			String fileParts[] = fileName.split("\\.");
			extension = fileParts[fileParts.length - 1];
			LOGGER.logDebug("PXSG extension >>>" + extension);
			LOGGER.logDebug("PXSG fileName >> " + fileName);
			LOGGER.logDebug("PXSG path >>>" + filePath);
			if ("xls".equals(extension)) {
				readContentExcel(fileName, filePath);
			} else if ("xlsx".equals(extension)) {
				readContentExcelXML(fileName, filePath);
			} else {
				throw new PersonColectiveExeption("No soporta archivos con extensión " + extension);
			}
			validateRecord(entities, fileName, args);
			args.setSuccess(true);

		} catch (PersonColectiveExeption ex) {
			args.getMessageManager().showErrorMsg(ex.getMessage());
			args.setSuccess(false);
		} catch (Exception e) {
			LOGGER.logError("Error procesando el archivo " + fileName, e);
			args.getMessageManager().showErrorMsg("Error procesando el archivo " + fileName);
			args.setSuccess(false);
		}

	}

	/*
	 * private void readContent(String filePath) { String linea = ""; File file =
	 * new File(filePath); FileReader fileReader; BufferedReader bufferedReader =
	 * null; String partes[]; try { Payment payment = null; fileReader = new
	 * FileReader(file); bufferedReader = new BufferedReader(fileReader); while
	 * ((linea = bufferedReader.readLine()) != null) { LOGGER.logDebug(linea);
	 * partes = linea.split("-"); payment = new Payment(Integer.parseInt(partes[0]),
	 * partes[1], partes[2], partes[3], partes[4], partes[5]);
	 * payments.add(payment); } } catch (FileNotFoundException e) {
	 * e.printStackTrace(); } catch (IOException e) { e.printStackTrace(); } finally
	 * { if (bufferedReader != null) { try { bufferedReader.close(); } catch
	 * (IOException e) { e.printStackTrace(); } } }
	 * 
	 * }
	 */
	private void readContentExcel(String fileName, String filePath) throws PersonColectiveExeption {
		LOGGER.logDebug("readContentExcel");
		PersonColective person = null;
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
				person = new PersonColective();
				// VALIDAR ESTRUCTURA DE LA FILA
				LOGGER.logError("hssfRow.getRowNum" + hssfRow.getRowNum());
				person.setNumber(hssfRow.getRowNum() + 1);
				if (hssfRow.getRowNum() > 0) {
					if (isValidRow(hssfRow)) {
						person.setSurname(hssfRow.getCell(0) == null ? null : hssfRow.getCell(0).toString());
						person.setSecondSurname(hssfRow.getCell(1) == null ? null : hssfRow.getCell(1).toString());
						person.setFirstName(hssfRow.getCell(2) == null ? null : hssfRow.getCell(2).toString());
						person.setSecondName(hssfRow.getCell(3) == null ? null : hssfRow.getCell(3).toString());
						person.setBirthDate(hssfRow.getCell(4) == null ? null : getDate(hssfRow.getCell(4)));
						person.setBirthEntity(hssfRow.getCell(5) == null ? null : hssfRow.getCell(5).toString());
						person.setGender(hssfRow.getCell(6) == null ? null : hssfRow.getCell(6).toString().toUpperCase());
						//person.setStreetAddress(hssfRow.getCell(7) == null ? null : hssfRow.getCell(7).toString());
						//person.setNumberIntAddress(Utils.cellToString(hssfRow.getCell(8)));
						//person.setNumberExtAddress(Utils.cellToString(hssfRow.getCell(9)));
						//person.setColonyAddress(hssfRow.getCell(10) == null ? null : hssfRow.getCell(10).toString());
						//person.setCpAddress(Utils.cellToString(hssfRow.getCell(11)));
						person.setEmail(hssfRow.getCell(7) == null ? null : hssfRow.getCell(7).toString());
						person.setCellPhoneNumber(Utils.cellToString(hssfRow.getCell(8)));
						person.setOfficeId(Utils.cellToString(hssfRow.getCell(9)));
						person.setCurp(hssfRow.getCell(10) == null ? null : hssfRow.getCell(10).toString());
						person.setRfc(hssfRow.getCell(11) == null ? null : hssfRow.getCell(11).toString());
						
						person.setNameColectivo(hssfRow.getCell(12) == null ? null : hssfRow.getCell(12).toString().toUpperCase());
						person.setLevelClient(hssfRow.getCell(13) == null ? null : hssfRow.getCell(13).toString().toUpperCase());
						person.setOfficialLogin(hssfRow.getCell(14) == null ? null : hssfRow.getCell(14).toString().toLowerCase());
						//person.setActivityEconomic(Utils.cellToString(hssfRow.getCell(18)));
						//person.setMonthSales(getInteger(hssfRow.getCell(19)));
						//person.setNumberChildren(Utils.cellToString(hssfRow.getCell(20)));
						//person.setPeridocity(hssfRow.getCell(21) == null ? null : hssfRow.getCell(21).toString());
						personColectivoList.add(person);
					}
				}
			}
			LOGGER.logDebug("Se cargan los datoss> " + personColectivoList.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo " + fileName, e1);
			throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
				}
			}
		}
	}

	private void readContentExcelXML(String fileName, String filePath) throws PersonColectiveExeption {
		LOGGER.logDebug("readContentExcelXML");
		PersonColective person = null;
		FileInputStream entradaArchivo = null;
		try {
			entradaArchivo = new FileInputStream(filePath);
			XSSFWorkbook libro;
			libro = new XSSFWorkbook(entradaArchivo);
			XSSFSheet hoja = libro.getSheetAt(0);
			// EN LA PRIMERA HOJA
			Iterator filaIterador = hoja.rowIterator();
			// CABECERA
			// /
			// if (filaIterador.hasNext()) { XSSFRow hssfRow = (XSSFRow)
			// filaIterador.next(); if (hssfRow.getCell(0) == null ||
			// !"Fecha de Pago".trim().equals(hssfRow.getCell(0).toString().trim
			// ())) { throw new
			// MassivePaymentsException("El archivo no tiene la cabecera correcta"
			// ); } } else { throw new
			// MassivePaymentsException("El archivo no tiene cabecera"); }

			while (filaIterador.hasNext()) {
				XSSFRow hssfRow = (XSSFRow) filaIterador.next();
				person = new PersonColective();
				LOGGER.logError("hssfRow.getRowNum" + hssfRow.getRowNum());
				person.setNumber(hssfRow.getRowNum() + 1);

				if (hssfRow.getRowNum() > 0) {
					if (isValidRow(hssfRow)) {

						person.setSurname(hssfRow.getCell(0) == null ? null : hssfRow.getCell(0).toString());
						person.setSecondSurname(hssfRow.getCell(1) == null ? null : hssfRow.getCell(1).toString());
						person.setFirstName(hssfRow.getCell(2) == null ? null : hssfRow.getCell(2).toString());
						person.setSecondName(hssfRow.getCell(3) == null ? null : hssfRow.getCell(3).toString());
						person.setBirthDate(hssfRow.getCell(4) == null ? null : getDate(hssfRow.getCell(4)));
						LOGGER.logError("hssfRow.getCell(5)" + hssfRow.getCell(5));
						person.setBirthEntity(hssfRow.getCell(5) == null ? null : hssfRow.getCell(5).toString());
						person.setGender(hssfRow.getCell(6) == null ? null : hssfRow.getCell(6).toString().toUpperCase());
						//person.setStreetAddress(hssfRow.getCell(7) == null ? null : hssfRow.getCell(7).toString());
						//person.setNumberIntAddress(Utils.cellToString(hssfRow.getCell(8)));
						//person.setNumberExtAddress(Utils.cellToString(hssfRow.getCell(9)));
						//person.setColonyAddress(hssfRow.getCell(10) == null ? null : hssfRow.getCell(10).toString());
						//person.setCpAddress(Utils.cellToString(hssfRow.getCell(11)));
						person.setEmail(hssfRow.getCell(7) == null ? null : hssfRow.getCell(7).toString());
						person.setCellPhoneNumber(Utils.cellToString(hssfRow.getCell(8)));
						person.setOfficeId(Utils.cellToString(hssfRow.getCell(9)));
						person.setCurp(hssfRow.getCell(10) == null ? null : hssfRow.getCell(10).toString());
						person.setRfc(hssfRow.getCell(11) == null ? null : hssfRow.getCell(11).toString());
						person.setNameColectivo(hssfRow.getCell(12) == null ? null : hssfRow.getCell(12).toString().toUpperCase());
						person.setLevelClient(hssfRow.getCell(13) == null ? null : hssfRow.getCell(13).toString().toUpperCase());
						person.setOfficialLogin(hssfRow.getCell(14) == null ? null : hssfRow.getCell(14).toString().toLowerCase());
						//person.setActivityEconomic(Utils.cellToString(hssfRow.getCell(18)));
						//person.setMonthSales(getInteger(hssfRow.getCell(19)));
						//person.setNumberChildren(Utils.cellToString(hssfRow.getCell(20)));
						//person.setPeridocity(hssfRow.getCell(21) == null ? null : hssfRow.getCell(21).toString());
						personColectivoList.add(person);
					}
				}
			}

			LOGGER.logDebug("datos cargados xlsx> " + personColectivoList.size());
		} catch (IOException e1) {
			LOGGER.logError("Error al leer el archivo  xlsx" + fileName, e1);
			throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
		} catch (Exception ex) {
			LOGGER.logError("Error al leer el archivo " + fileName, ex);
			throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
		} finally {
			if (entradaArchivo != null) {
				try {
					entradaArchivo.close();
				} catch (IOException e) {
					LOGGER.logError("Error al leer el archivo " + fileName, e);
					throw new PersonColectiveExeption("Error al leer el archivo " + fileName);
				}
			}
		}
	}

	private void validateRecord(DynamicRequest entities, String fileName, IExecuteCommandEventArgs args)
			throws PersonColectiveExeption {
		DataEntity personColectiveRecordEntity = null;
		// ServiceResponse response = null;
		// PaymentRecord[] paymentRecords = null;
		DataEntityList listPersonColective = new DataEntityList();
		ServiceRequestTO request = new ServiceRequestTO();

		int observationsNumber = 0;
		DataEntity entityFile = entities.getEntity(CollectivePersonFile.ENTITY_NAME);

		try {
			TransferManager transferManager = new TransferManager(this.getServiceIntegration());
			OfficeResponse[] aOfficeRespList = transferManager.searchOffice("admuser", args);

			CustomerCatalogManager customerCatalogoManager = new CustomerCatalogManager(this.getServiceIntegration());
			List<CatalogDto> catalogDtoList = customerCatalogoManager.getCountriesOfBirth(args, new BehaviorOption(true));

			// PaymentRecord paymentRecordRequest = new PaymentRecord();
			// paymentRecordRequest.setFileName(fileName);
			// request.addValue("inPaymentRecord", paymentRecordRequest);
			// response = this.execute(getServiceIntegration(), LOGGER,
			// "Payments.MassivePayment.ValidatePayments",
			// request);

			/*
			 * if (!response.isResult()) { throw new MassivePaymentsException(
			 * "Error al validar pagos " + fileName + ". " + getErrorMessages(response)); }
			 * ServiceResponseTO serviceResponseTO = (ServiceResponseTO) response.getData();
			 * paymentRecords = (PaymentRecord[])
			 * serviceResponseTO.getValue("returnPaymentRecord");
			 */
			if(validateFilenameExists(entityFile, personColectivoList,args)){
				for (PersonColective personcolective : personColectivoList) {
					personColectiveRecordEntity = new DataEntity();
					personColectiveRecordEntity.set(CollectivePersonRecord.SURNAME, personcolective.getSurname() == null ? "" : personcolective.getSurname().toUpperCase());
					personColectiveRecordEntity.set(CollectivePersonRecord.SECONDSURNAME,
							personcolective.getSecondSurname() == null ? "" : personcolective.getSecondSurname().toUpperCase());
					personColectiveRecordEntity.set(CollectivePersonRecord.FIRSTNAME, personcolective.getFirstName() == null ? "" : personcolective.getFirstName().toUpperCase());
					personColectiveRecordEntity.set(CollectivePersonRecord.SECONDNAME, personcolective.getSecondName() == null ? "" : personcolective.getSecondName().toUpperCase());
					personColectiveRecordEntity.set(CollectivePersonRecord.BIRTHDATE, personcolective.getBirthDate());

					personColectiveRecordEntity.set(CollectivePersonRecord.BIRTHENTITY, personcolective.getBirthEntity());
					personColectiveRecordEntity.set(CollectivePersonRecord.BIRTHENTITYDESC, getCountriesOfBirth(personcolective.getBirthEntity(),catalogDtoList));
					personColectiveRecordEntity.set(CollectivePersonRecord.GENDER, validateGender(personcolective.getGender()));
					//personColectiveRecordEntity.set(CollectivePersonRecord.STREETADDRESS, personcolective.getStreetAddress());
					//personColectiveRecordEntity.set(CollectivePersonRecord.NUMBERINTADDRESS, personcolective.getNumberIntAddress());
					//personColectiveRecordEntity.set(CollectivePersonRecord.NUMBEREXTADDRESS, personcolective.getNumberExtAddress());
					//personColectiveRecordEntity.set(CollectivePersonRecord.COLONYADDRESS, personcolective.getColonyAddress());
					//personColectiveRecordEntity.set(CollectivePersonRecord.CPADDRESS, personcolective.getCpAddress());
					personColectiveRecordEntity.set(CollectivePersonRecord.EMAIL, personcolective.getEmail());
					personColectiveRecordEntity.set(CollectivePersonRecord.CELLPHONENUMBER, personcolective.getCellPhoneNumber());

					personColectiveRecordEntity.set(CollectivePersonRecord.OFFICEID, personcolective.getOfficeId());
					personColectiveRecordEntity.set(CollectivePersonRecord.OFFICEDESC, getOfficeDescription(personcolective.getOfficeId(),  aOfficeRespList));
					
					personColectiveRecordEntity.set(CollectivePersonRecord.CURP, personcolective.getCurp());
					personColectiveRecordEntity.set(CollectivePersonRecord.RFC, personcolective.getRfc());
					personColectiveRecordEntity.set(CollectivePersonRecord.COLLECTIVENAME, personcolective.getNameColectivo());
					personColectiveRecordEntity.set(CollectivePersonRecord.CLIENTLEVEL, personcolective.getLevelClient());
					personColectiveRecordEntity.set(CollectivePersonRecord.OFFICIALLOGIN, personcolective.getOfficialLogin());
					//personColectiveRecordEntity.set(CollectivePersonRecord.ECONOMICACTIVITY, personcolective.getActivityEconomic());
					//personColectiveRecordEntity.set(CollectivePersonRecord.MONTHSALES, personcolective.getMonthSales());
					//personColectiveRecordEntity.set(CollectivePersonRecord.NUMBERCHILDREN, personcolective.getNumberChildren());
					//personColectiveRecordEntity.set(CollectivePersonRecord.PERIODICITY, personcolective.getPeridocity());
					/*
					* if (payment.getObservations() != null &&
					* payment.getObservations().trim().length() != 0) { observationsNumber++; }
					*/
					listPersonColective.add(personColectiveRecordEntity);
				}
				// entityFile.set(CollectivePersonRecord.OBSERVATIONS,
				// personcolective);

				entities.setEntityList(CollectivePersonRecord.ENTITY_NAME, listPersonColective);
			}else{
				args.getMessageManager().showInfoMsg("Archivo " + entityFile.get(CollectivePersonFile.FILENAME) + " ya fué procesado anteriormente.");
				args.setSuccess(false);
				
			}
		} catch (Exception ex) {
			LOGGER.logError("al cagar los datos del archivo " + fileName, ex);
			throw new PersonColectiveExeption("Error al cagar los datos del archivo " + fileName);
		}
	}

	private boolean isValidRow(HSSFRow hssfRow) {
		int emptyCells = 0;
		for (int i = 0; i < CELL_NUMBERS; i++) {
			emptyCells = emptyCells + (hssfRow.getCell(i) == null || !"".contentEquals(hssfRow.getCell(i).toString().trim()) ? 1 : 0);
		}

		return !(emptyCells == CELL_NUMBERS);
	}

	private boolean isValidRow(XSSFRow hssfRow) {
		int emptyCells = 0;
		for (int i = 0; i < CELL_NUMBERS; i++) {
			emptyCells = emptyCells + (hssfRow.getCell(i) == null || "".contentEquals(hssfRow.getCell(i).toString().trim()) ? 1 : 0);
		}

		return !(emptyCells == CELL_NUMBERS);
	}

	private String getDate(HSSFCell cell) {
		// SimpleDateFormat
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
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

	private String getOfficeDescription(String officeId, OfficeResponse[] aOfficeRespList){
		for ( OfficeResponse officeResponse : aOfficeRespList) {
			if(officeId.equals(String.valueOf(officeResponse.getOfficeId()))){
				return officeResponse.getOfficeName();
			}
		}
		return NOTEXISTS;
	}

	private String getCountriesOfBirth(String entityId, List<CatalogDto> catalogDtoList) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("UploadFile Ciudad Nacimiento>>getCountriesOfBirth");
		}
		try{
			if(entityId != null && !"".equals(entityId)){
				for (CatalogDto catalogDto : catalogDtoList) {
					if(entityId.equals(catalogDto.getCode().trim()) ){
						return new String(catalogDto.getName().getBytes(ISO), UTF8);
					}
				}
			}
		}
		catch (Exception e) {
			LOGGER.logError("getCountriesOfBirth Consulta Ciudades",e);
		}
		return NOTEXISTS;
	}

	private Boolean validateFilenameExists(DataEntity entityFile, List<PersonColective> personList, IExecuteCommandEventArgs args){
		int numberOfRecords = personList.size();
		String fileName = entityFile.get(CollectivePersonFile.FILENAME);
		
		ProspectFilename reqProspectFilename = new ProspectFilename();
		reqProspectFilename.setFilename(fileName);
		reqProspectFilename.setTotalRec(numberOfRecords);

		ProcessEntityManager processEntityManager = new ProcessEntityManager(this.getServiceIntegration());
		try{
			ProspectFilename[] prospFileList = (ProspectFilename[])processEntityManager.validateProspectFilename(reqProspectFilename, args);
			if(prospFileList!=null && prospFileList.length >= 1){
				return false;
			}
		}catch (Exception e) {
			LOGGER.logError("getCountriesOfBirth Consulta Ciudades",e);
		}
		return true;
	}

	private String validateGender(String gndrCode){
		if(!FML_CODE.equals(gndrCode) && !ML_CODE.equals(gndrCode)){
			return WRMG_CODE;
		}
		return gndrCode;
	}

	

}
