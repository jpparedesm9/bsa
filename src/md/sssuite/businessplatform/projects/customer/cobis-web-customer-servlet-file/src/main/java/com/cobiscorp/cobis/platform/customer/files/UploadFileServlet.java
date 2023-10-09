package com.cobiscorp.cobis.platform.customer.files;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.inbox.storage.services.IStorageService;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;

public class UploadFileServlet extends HttpServlet {

	private static final long serialVersionUID = -775357019226614150L;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(UploadFileServlet.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {

		if (logger.isDebugEnabled())
			logger.logDebug("Inicio Subida de archivo");

		try {
			String transactionType = request.getParameter("transactionType");

			if (transactionType != null && transactionType.length() > 0) {

				int type = Integer.parseInt(transactionType);
				String customerId = request.getParameter("customerId");
				String capturedDocumentType = request.getParameter("capturedDocumentType");
				if (capturedDocumentType == null) {
					throw new Exception("El parámetro capturedDocumentType es obligatorio");
				}

				String processInstanceId = request.getParameter("processInstanceId");
				String groupId = request.getParameter("groupId");
				String captureDate = request.getParameter("captureDate");

				logger.logDebug("transactionType: " + transactionType);
				logger.logDebug("customerId: " + customerId);
				logger.logDebug("capturedDocumentType: " + capturedDocumentType);
				logger.logDebug("processInstanceId: " + processInstanceId);
				logger.logDebug("groupId: " + groupId);
				logger.logDebug("captureDate: " + captureDate);

				FilesUtilClass filesUtilClass = new FilesUtilClass();

				GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();
				getCredentialsImpl.setServiceIntegration(serviceIntegration);

				String session = filesUtilClass.getSession(request);
				CredentialsDTO credentials = null;
				try {
					credentials = getCredentialsImpl.getCredentials(session);
				} catch (Exception e) {
					resp.setStatus(HttpServletResponse.SC_NON_AUTHORITATIVE_INFORMATION);
					throw new Exception("No se encuentra autorizado para realizar esta acción");
				}
				String password = credentials.getPassword();

				FileItem item = null;
				boolean isMultipart = ServletFileUpload.isMultipartContent(request);
				if (isMultipart) {

					FileItemFactory factory = new DiskFileItemFactory();
					ServletFileUpload upload = new ServletFileUpload(factory);
					List<FileItem> items = upload.parseRequest(request);
					Iterator<FileItem> iter = items.iterator();
					while (iter.hasNext()) {
						item = (FileItem) iter.next();
					}
				}

				if (item != null) {
					ComponentLocator componetlocator = ComponentLocator.getInstance(this);

					IStorageService spl = null;

					if (componetlocator != null) {
						spl = componetlocator.find(IStorageService.class, StorageConfiguration.getFilterEntity(1));
					}

					if (spl != null) {

						String ext = item.getName().substring(item.getName().lastIndexOf('.'));

						String fileName = capturedDocumentType + ext;

						spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
								FilesUtilClass.ROOT_FOLDER, StorageConfiguration.getConfiguration(1, "login"),
								password);
						if (type == 1) {
							if (customerId != null && !customerId.equalsIgnoreCase("0")) {
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + "/" + customerId,
										StorageConfiguration.getConfiguration(1, "login"), password);
								spl.saveFile(
										StorageConfiguration.getConfiguration(1, "library") + "/"
												+ FilesUtilClass.ROOT_FOLDER + "/" + customerId,
										fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);
							} else {
								throw new Exception(
										"Para el tipo de transacción 1 el parámetro customerId es obligatorio");
							}
						}
						if (type == 2) {
							if (processInstanceId != null && customerId != null) {
								String path = "/" + processInstanceId;
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + path,
										StorageConfiguration.getConfiguration(1, "login"), password);
								if (customerId != null && !customerId.equalsIgnoreCase("0")) {
									path = path + "/" + customerId;
									spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
											FilesUtilClass.ROOT_FOLDER + path,
											StorageConfiguration.getConfiguration(1, "login"), password);
								}
								spl.saveFile(
										StorageConfiguration.getConfiguration(1, "library") + "/"
												+ FilesUtilClass.ROOT_FOLDER + path,
										fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);
							} else {
								throw new Exception(
										"Para el tipo de transacción 2 los parámetros processInstanceId y customerId son obligatorios");
							}

						}
						if (type == 3) {
							if (groupId != null && processInstanceId != null && customerId != null) {
								String path = "/" + groupId;
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + path,
										StorageConfiguration.getConfiguration(1, "login"), password);
								if (processInstanceId != null && !processInstanceId.equalsIgnoreCase("0")) {
									path = path + "/" + processInstanceId;
									spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
											FilesUtilClass.ROOT_FOLDER + path,
											StorageConfiguration.getConfiguration(1, "login"), password);
								}
								if (customerId != null && !customerId.equalsIgnoreCase("0")) {
									path = path + "/" + customerId;
									spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
											FilesUtilClass.ROOT_FOLDER + path,
											StorageConfiguration.getConfiguration(1, "login"), password);
								}
								spl.saveFile(
										StorageConfiguration.getConfiguration(1, "library") + "/"
												+ FilesUtilClass.ROOT_FOLDER + path,
										fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);
							} else {
								throw new Exception(
										"Para el tipo de transacción 3 los parámetros groupId, processInstanceId y customerId son obligatorios");
							}
						}

						ScannedDocumentsRequest scannedDocumentsRequest = new ScannedDocumentsRequest();
						if (capturedDocumentType != null)
							scannedDocumentsRequest.setDocumentType(capturedDocumentType);
						if (groupId != null)
							scannedDocumentsRequest.setGroupId(Integer.parseInt(groupId));
						if (customerId != null)
							scannedDocumentsRequest.setCustomerId(Integer.parseInt(customerId));
						if (processInstanceId != null)
							scannedDocumentsRequest.setProcessInst(Integer.parseInt(processInstanceId));

						scannedDocumentsRequest.setExtension(ext.substring(1));
						scannedDocumentsRequest.setDate(this.toCalendar(captureDate));
						scannedDocumentsRequest.setLoaded("S");
						

						ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
						serviceRequestApplicationTO.addValue("inScannedDocumentsRequest", scannedDocumentsRequest);
						ServiceResponse response = this.execute("LoanGroup.ScannedDocuments.UpdateScannedDocuments",
								serviceRequestApplicationTO);
						if (!response.isResult()) {
							logger.logError(response.getMessages());
							throw new Exception("No se pudo guardar los datos en la base de datos");
						}

					}
				} else {
					logger.logError("No viene el archivo");
					throw new Exception("No se ha encontrado el archivo en el request");
				}
			} else {
				logger.logError("No viene el tipo de transaccion");
				throw new Exception("No se ha enviado el tipo de transacción");
			}
		} catch (Exception e) {
			logger.logError("Excepcion  --> ", e);
			resp.sendError(HttpServletResponse.SC_EXPECTATION_FAILED, e.getMessage());
			throw new RuntimeException(e);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Fin Subida de archivo");
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Set serviceIntegration:" + serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return this.serviceIntegration;
	}

	protected ServiceResponse execute(String serviceId, ServiceRequestTO serviceRequest) throws Exception {
		try {
			ServiceRequest header = new ServiceRequest();
			header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE,
					SessionManager.getSessionId());
			ServiceResponse serviceWebResponse = new ServiceResponse();
			serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
			serviceRequest.setSessionId(SessionManager.getSessionId());
			ServiceResponseTO serviceResponse = new ServiceResponseTO();
			serviceRequest.setServiceId(serviceId);
			serviceResponse = serviceIntegration.getResponseFromCTS(serviceRequest);
			if (!serviceResponse.isSuccess()) {
				serviceWebResponse.addMessages(serviceResponse.getMessages());
				serviceWebResponse.setResult(false);
				return serviceWebResponse;
			} else {
				serviceWebResponse.setData(serviceResponse);
				serviceWebResponse.setResult(true);
				return serviceWebResponse;
			}
		} catch (Exception ex) {
			throw new Exception(ex);
		}
	}

	private Calendar toCalendar(final String iso8601string) throws Exception {
		Calendar calendar = GregorianCalendar.getInstance();
		String s = iso8601string.replace("Z", "+00:00");
		try {
			s = s.substring(0, 22) + s.substring(23); // to get rid of the ":"
		} catch (IndexOutOfBoundsException e) {
			throw new ParseException("Invalid length", 0);
		}
		Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(s);
		calendar.setTime(date);
		return calendar;
	}
}
