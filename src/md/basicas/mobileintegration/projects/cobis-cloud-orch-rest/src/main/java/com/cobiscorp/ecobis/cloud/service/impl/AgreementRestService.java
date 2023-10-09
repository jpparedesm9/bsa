package com.cobiscorp.ecobis.cloud.service.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.ecobis.cloud.conf.service.reader.PrivaceNoticeConfiguration;
import com.cobiscorp.ecobis.cloud.service.AgreementService;

@Path("/cobis-cloud/mobile/agreementService")
@Component
@Service({ AgreementService.class })
public class AgreementRestService implements AgreementService {

	@Path("/privaceNotice")
	@GET
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_HTML)
	@Override
	public String getPrivaceNotice() {
		return PrivaceNoticeConfiguration.getContent();
	}

}
