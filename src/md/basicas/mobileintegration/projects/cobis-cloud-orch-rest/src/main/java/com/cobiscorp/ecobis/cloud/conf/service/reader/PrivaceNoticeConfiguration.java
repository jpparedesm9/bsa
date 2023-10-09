package com.cobiscorp.ecobis.cloud.conf.service.reader;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.conf.service.IPrivaceNoticeConfiguration;
import com.cobiscorp.ecobis.cloud.service.dto.conf.PrivaceNoticeDTO;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;


@Component
@Service({ IPrivaceNoticeConfiguration.class })
public class PrivaceNoticeConfiguration implements IPrivaceNoticeConfiguration{
	
	private static PrivaceNoticeDTO privaceNotice;
	private static final ILogger log = LogFactory.getLogger(PrivaceNoticeConfiguration.class);

	
	@Override
    public void loadConfiguration(IConfigurationReader reader) {
        privaceNotice = new PrivaceNoticeDTO();    
        privaceNotice.setContent(reader.getNode("//config/privaceNotice/content/html").asXML());
        log.logDebug("Se cargan configuraciones " + privaceNotice);
    }
	public static String getTitle() {
		return privaceNotice.getTitle();
	}
	
	public static String getContent() {
		return privaceNotice.getContent();
	}
}
