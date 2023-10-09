package com.cobiscorp.cobis.assets.commons.utils;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.bsl.IFileServletUtils;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.EncodingConfiguration;

public class FileServletUtils implements IFileServletUtils{
	
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private static ILogger logger = LogFactory.getLogger(FileServletUtils.class);
	
	private ICTSServiceIntegration serviceIntegration;
	
	@Override
	public String convertToServerDefinedEnconding(String fileName){
		String filter = EncodingConfiguration.getFilterEntity(1).replaceAll("\\(|\\)|\\bserver\\b|=", "");
		String encondedFileName = "";
		if(null != filter && !filter.isEmpty() 
				&& FileServletConstants.WEBLOGIC.equalsIgnoreCase(filter)
				&& !EncodingConfiguration.getConfiguration(1, "serverEncoding").isEmpty()){
			String encoding = EncodingConfiguration.getConfiguration(1, "serverEncoding");
			//Print user's defined encoding charset
			if(logger.isDebugEnabled())
				logger.logDebug("GetFileServlet >>> User's defined charset >>> " + encoding);
			CharsetEncoder isoEncoder = Charset.forName(encoding).newEncoder();
			if (isoEncoder.canEncode(fileName)){
				try{
					encondedFileName = new String(fileName.getBytes(encoding), FileServletConstants.UTF8_ENCODING);
					if(logger.isDebugEnabled())
						logger.logDebug("GetFileServlet >>> Filename after re-enconding >>> " + fileName);
				}catch(UnsupportedEncodingException e){
					logger.logError("GetFileServlet >>> An error ocurred during fileName re-encoding >>> Source: " + encoding + " Destination: " + FileServletConstants.UTF8_ENCODING);
				}
			}
		}
		return !encondedFileName.isEmpty() ? encondedFileName : fileName;
	}
	
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
