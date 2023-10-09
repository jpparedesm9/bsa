package com.cobiscorp.cobis.platform.customer.files;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.bsl.IAlfrescoServices;
import com.cobiscorp.cobis.assets.commons.bsl.IFileServletUtils;
import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;

public class GetFileHistoricalServlet extends HttpServlet {

	private static final long serialVersionUID = 3691862758547541410L;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private static ILogger logger = LogFactory.getLogger(GetFileHistoricalServlet.class);

	private ICTSServiceIntegration serviceIntegration;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		logger.logDebug("Inicia la descarga del historico");
		

		
		String fileName = request.getParameter("fileName");
		String processInstanceId = request.getParameter("processInstanceId");
		String groupId = request.getParameter("groupId");
		String customerId = request.getParameter("customerId");
		String version = request.getParameter("version");
		String folder = request.getParameter("folder");
		
		FilesUtilClass filesUtilClass = new FilesUtilClass();

		GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();

		getCredentialsImpl.setServiceIntegration(serviceIntegration);

		String session = filesUtilClass.getSession(request);

		CredentialsDTO credentials = getCredentialsImpl.getCredentials(session);

		String password = credentials.getPassword();

		ComponentLocator componetlocator = ComponentLocator.getInstance(this);

		IAlfrescoServices spl = componetlocator.find(IAlfrescoServices.class);
		IFileServletUtils fileServletUtils = componetlocator.find(IFileServletUtils.class);
		
		fileName = fileServletUtils.convertToServerDefinedEnconding(fileName);
		
		logger.logDebug("fileName es: " + fileName);
		logger.logDebug("processInstanceId es: " + processInstanceId);
		logger.logDebug("groupId es: " + groupId);
		logger.logDebug("customerId es: " + customerId);
		logger.logDebug("Version es: " + version);
		logger.logDebug("folder es: " + folder);
		
		ServletContext context = getServletConfig().getServletContext();
		String mimetype = context.getMimeType(fileName);
		response.setContentType((mimetype != null) ? mimetype : "application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		logger.logDebug("Pasa el setHeader attachment");
		ServletOutputStream outStream = response.getOutputStream();
		if (groupId != null && groupId.length() > 0) {
			String path = "/" + groupId;
			if (processInstanceId != null && !processInstanceId.equalsIgnoreCase("0"))
				path = path + "/" + processInstanceId;
			if (customerId != null && !customerId.equalsIgnoreCase("0"))
				path = path + "/" + customerId;
			if(folder != null){
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						folder + path + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
			} else{
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + path + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
			}
		} else if (processInstanceId != null && processInstanceId.length() > 0) {
			String path = "/" + processInstanceId;
			if (customerId != null && !customerId.equalsIgnoreCase("0"))
				path = path + "/" + customerId;
			if(folder != null){
				logger.logDebug("Ingresa a processInstance con Folder");
				logger.logDebug("dentro path:   " + path);
				logger.logDebug("dentro fileName: " + fileName);
				logger.logDebug("dentro version: " + version);
				logger.logDebug("dentro passord: " + password);
				logger.logDebug("getConfiguration: " + StorageConfiguration.getConfiguration(1, "library"));
				logger.logDebug("getConfiguration logim: " + StorageConfiguration.getConfiguration(1, "login"));
				logger.logDebug("spl: " + spl);
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						folder + path + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
				logger.logDebug("Pasa el write getFileHistorical");
			} else{
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + path + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
			}
			
		} else {
			if(folder != null){
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						folder + "/" + customerId + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
			} else{
				outStream.write(spl.getFileHistorical(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + "/" + customerId + "/" + fileName, version,
						StorageConfiguration.getConfiguration(1, "login"), password));
			}
		}
		outStream.flush();
		outStream.close();
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
