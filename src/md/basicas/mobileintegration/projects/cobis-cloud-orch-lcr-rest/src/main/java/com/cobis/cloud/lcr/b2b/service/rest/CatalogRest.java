package com.cobis.cloud.lcr.b2b.service.rest;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobis.cloud.lcr.b2b.service.CatalogService;
import com.cobis.cloud.lcr.b2b.service.common.dto.CatalogDto;
import com.cobis.cloud.lcr.b2b.service.utils.ServiceResponseUtil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

@Path("/commons")
@Component
@Service({ CatalogService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)

public class CatalogRest implements CatalogService{

	private final ILogger logger = LogFactory.getLogger(CatalogRest.class);
	
	@Override
	@GET
	@Path("/catalog/{catalogName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getCatalog(@PathParam("id") String catalogName) {
		logger.logDebug("/commons/catalog/getCatalog catalogName>>"+catalogName);
		ArrayList<CatalogDto> catalogList=new ArrayList<CatalogDto>();
		CatalogDto c1=new CatalogDto();
		c1.setCode("BW");
		c1.setValue("CATORCENAL");
		CatalogDto c2=new CatalogDto();
		c2.setCode("M");
		c2.setValue("MENSUAL");
		CatalogDto c3=new CatalogDto();
		c3.setCode("W");
		c3.setValue("SEMANAL");
		catalogList.add(c1);
		catalogList.add(c2);
		catalogList.add(c3);
		return ServiceResponseUtil.successResponse(catalogList, "/commons/catalog/getCatalog");
	}
	
	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {

	}
}
