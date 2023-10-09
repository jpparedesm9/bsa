package com.cobiscorp.mobile.services.impl;

import java.security.Key;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.request.DocumentUploadRequest;
import com.cobiscorp.mobile.service.interfaces.IDocumentUpload;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IDocumentUpload.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class DocumentUploadImpl extends ServiceBase implements IDocumentUpload {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private static final String ID_APPLICATION = "bancaMovil";

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> DocumentUploadImpl] ";

	/** Logger. */
	private ILogger LOGGER = LogFactory.getLogger(DocumentUploadImpl.class);

	private Map<String, Key> privateKeysMap;

	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	@Override
	public void documentUploadImp(DocumentUploadRequest documentUploadRequest) throws MobileServiceException {

		// llamar al serivicio
		try {
			LOGGER.logDebug(">>>>>>>>>>>metodo documentUploadImp ");
			LOGGER.logDebug(">>>>>>>>>>>metodo documentUploadImp -- llamar al servicio");

		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public Map<String, Key> getPrivateKeysMap() {
		return this.privateKeysMap;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
