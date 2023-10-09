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

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.inbox.storage.services.IStorageService;
import com.cobiscorp.cobis.platform.web.servlet.util.CredentialsDTO;
import com.cobiscorp.cobis.platform.web.servlet.util.FilesUtilClass;
import com.cobiscorp.cobis.platform.web.servlet.util.GetCredentialsImpl;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class GetFileServlet extends HttpServlet {

	private static final long serialVersionUID = 3691862758547541410L;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private static ILogger logger = LogFactory.getLogger(GetFileServlet.class);

	private ICTSServiceIntegration serviceIntegration;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		logger.logDebug("Inicia la descarga del archivo");

		String fileName = request.getParameter("fileName");
		String processInstanceId = request.getParameter("processInstanceId");
		String groupId = request.getParameter("groupId");
		String customerId = request.getParameter("customerId");
		String folder = request.getParameter("folder");
		
		logger.logDebug("Folder es: " + folder);
		
		FilesUtilClass filesUtilClass = new FilesUtilClass();

		GetCredentialsImpl getCredentialsImpl = new GetCredentialsImpl();

		getCredentialsImpl.setServiceIntegration(serviceIntegration);

		String session = filesUtilClass.getSession(request);

		CredentialsDTO credentials = getCredentialsImpl.getCredentials(session);

		String password = credentials.getPassword();

		ComponentLocator componetlocator = ComponentLocator.getInstance(this);

		IStorageService spl = componetlocator.find(IStorageService.class, StorageConfiguration.getFilterEntity(1));

		ServletContext context = getServletConfig().getServletContext();
		String mimetype = context.getMimeType(fileName);
		response.setContentType((mimetype != null) ? mimetype : "application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		ServletOutputStream outStream = response.getOutputStream();
		if (groupId != null && groupId.length() > 0) {
			String path = "/" + groupId;
			if (processInstanceId != null && !processInstanceId.equalsIgnoreCase("0"))
				path = path + "/" + processInstanceId;
			if (customerId != null && !customerId.equalsIgnoreCase("0"))
				path = path + "/" + customerId;
			if(folder != null){
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						folder + path + "/" + fileName, "",
						StorageConfiguration.getConfiguration(1, "login"), password));
			} else{
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + path + "/" + fileName, "",
						StorageConfiguration.getConfiguration(1, "login"), password));
			}
		} else if (processInstanceId != null && processInstanceId.length() > 0) {
			String path = "/" + processInstanceId;
			if (customerId != null && !customerId.equalsIgnoreCase("0"))
				path = path + "/" + customerId;
			if(folder != null){
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						folder + path + "/" + fileName, "",
						StorageConfiguration.getConfiguration(1, "login"), password));
			} else{
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + path + "/" + fileName, "",
						StorageConfiguration.getConfiguration(1, "login"), password));
			}
			
		} else {
			if(folder != null){
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						folder + "/" + customerId + "/" + fileName, "",
						StorageConfiguration.getConfiguration(1, "login"), password));
			} else{
				outStream.write(spl.getFile(StorageConfiguration.getConfiguration(1, "library"),
						FilesUtilClass.ROOT_FOLDER + "/" + customerId + "/" + fileName, "",
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
