package com.cobiscorp.cobis.loans.customevents.events;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.inbox.storage.services.IStorageService;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class UploadAlfresco {

	private static final ILogger logger = LogFactory.getLogger(UploadAlfresco.class);
	private ICTSServiceIntegration serviceIntegration;

	public UploadAlfresco(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void uploadFile(int transactionType, String custId, String documentType, String processInstId, String gId,
			String urlDocument) {
		InputStream input=null;
		try {
			int type = transactionType;
			if (transactionType > 0) {

				
				String customerId = custId;
				String capturedDocumentType = documentType;
				String processInstanceId = processInstId;
				String groupId = gId;

				logger.logDebug("transactionType: " + transactionType);
				logger.logDebug("customerId: " + customerId);
				logger.logDebug("capturedDocumentType: " + capturedDocumentType);
				logger.logDebug("processInstanceId: " + processInstanceId);
				logger.logDebug("groupId: " + groupId);
				logger.logDebug("urlDocumento: " + urlDocument);
				logger.logDebug("serviceIntegration: " + serviceIntegration);
				GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();
				getCredentialsImpl.setServiceIntegration(serviceIntegration);

				CredentialsDTO credentials = null;
				try {
					credentials = getCredentialsImpl.getCredentials(SessionManager.getSessionId());
				} catch (Exception e) {
					logger.logDebug("error --->" + e);
					return;
				}
				String password = credentials.getPassword();

				File file = new File(urlDocument);
				logger.logDebug("file: " + file.getName());
				DiskFileItem item = (DiskFileItem) new DiskFileItemFactory().createItem("fileData", "", true,
						file.getName());
				
				 input = new FileInputStream(file);
				OutputStream os = item.getOutputStream();
				int ret = input.read();
				while (ret != -1) {
					os.write(ret);
					ret = input.read();
				}
				os.flush();

				if (item == null) {
					logger.logError("No viene el archivo");
				} else {
					ComponentLocator componetlocator = ComponentLocator.getInstance(this);

					IStorageService spl = null;

					if (componetlocator != null) {
						spl = componetlocator.find(IStorageService.class, StorageConfiguration.getFilterEntity(1));
					}

					if (spl != null) {

						String ext = item.getName().substring(item.getName().lastIndexOf('.'));

						String fileName = capturedDocumentType.trim() + ext;

						spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
								FilesUtilClass.ROOT_FOLDER, StorageConfiguration.getConfiguration(1, "login"),
								password);
						if (type == 1) {
							spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
									FilesUtilClass.ROOT_FOLDER + "/" + customerId,
									StorageConfiguration.getConfiguration(1, "login"), password);
							spl.saveFile(
									StorageConfiguration.getConfiguration(1, "library") + "/"
											+ FilesUtilClass.ROOT_FOLDER + "/" + customerId,
									fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);
						}
						if (type == 2) {
							String path = "/" + processInstanceId;
							spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
									FilesUtilClass.ROOT_FOLDER + path,
									StorageConfiguration.getConfiguration(1, "login"), password);
							if (!customerId.equalsIgnoreCase("0")) {
								path = path + "/" + customerId;
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + path,
										StorageConfiguration.getConfiguration(1, "login"), password);
							}
							spl.saveFile(
									StorageConfiguration.getConfiguration(1, "library") + "/"
											+ FilesUtilClass.ROOT_FOLDER + path,
									fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);

						}
						if (type == 3) {
							String path = "/" + groupId;
							spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
									FilesUtilClass.ROOT_FOLDER + path,
									StorageConfiguration.getConfiguration(1, "login"), password);
							if (!processInstanceId.equalsIgnoreCase("0")) {
								path = path + "/" + processInstanceId;
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + path,
										StorageConfiguration.getConfiguration(1, "login"), password);
							}
							if (!customerId.equalsIgnoreCase("0")) {
								path = path + "/" + customerId;
								spl.createFolder(StorageConfiguration.getConfiguration(1, "library"),
										FilesUtilClass.ROOT_FOLDER + path,
										StorageConfiguration.getConfiguration(1, "login"), password);
							}
							spl.saveFile(
									StorageConfiguration.getConfiguration(1, "library") + "/"
											+ FilesUtilClass.ROOT_FOLDER + path,
									fileName, item, StorageConfiguration.getConfiguration(1, "login"), password);
						}
					}
				}
			} else {
				logger.logError("No viene el tipo de transaccion");
			}
		} catch (Exception e) {
			logger.logError("Excepcion  -->", e);
			throw new RuntimeException (e);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Fin Subida de archivo");
			try {
				input.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.logDebug("error al cerrar el archivo: " ,e);
			}
		}
	}

}
