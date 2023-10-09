package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.References;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.cloud.service.CatalogService;
import com.cobiscorp.ecobis.cloud.service.integration.CatalogIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;

import cobiscorp.ecobis.admin.catalog.dto.CatalogoItem;
import cobiscorp.ecobis.admin.catalog.dto.CatalogoReq;
import cobiscorp.ecobis.admin.catalog.dto.CatalogoResp;
import cobiscorp.ecobis.admin.catalog.services.ICatalogoService;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Path("/cobis/web/catalog")
@Component
@Service({ CatalogRestService.class })
@References(value = { @Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY), 
		              @Reference(name = "catalogService", referenceInterface = ICatalogoService.class, bind = "setCatalogoService", unbind = "unSetCatalogoService", cardinality = ReferenceCardinality.MANDATORY_UNARY)})

public class CatalogRestService implements CatalogService {
	private final ILogger logger = LogFactory.getLogger(CatalogRestService.class);

	private CatalogIntegrationService catalogIntegrationService;

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.catalogIntegrationService = new CatalogIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.catalogIntegrationService = new CatalogIntegrationService(serviceIntegration);
	}
	
	private ICatalogoService catalogService;
	
	protected void setCatalogoService(ICatalogoService catalogService) {
		this.catalogService = catalogService;
	}

	protected void unSetCatalogoService(ICatalogoService catalogService) {
		this.catalogService = null;
	}

	@Path("/{frecuency}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getTermByFrecuency(@PathParam("frecuency") String frecuency) {
		try {

			List<CatalogDto> terms = catalogIntegrationService.getTermByFrecuency(frecuency);
			if (terms == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			} else {
				return successResponse(terms, "/cobis/web/catalog/getTermByFrecuency");
			}

		} catch (IntegrationException ie) {
			logger.logError("/cobis/web/catalog/getTermByFrecuency Error al obtener los plazos por Frencuencia de Pago ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis/web/catalog/getTermByFrecuency Error al obtener los plazos por Frencuencia de Pago ", e);
			return errorResponse("/cobis/web/catalog/getTermByFrecuency Error al obtener los plazos por Frencuencia de Pago ");
		}

	}
	
	@Path("/getPaymentFrequency")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getPaymentFrequency() {
		try {

			List<CatalogDto> terms = catalogIntegrationService.getPaymentFrequency();
			if (terms == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			} else {
				return successResponse(terms, "/cobis/web/catalog/getPaymentFrequency");
			}

		} catch (IntegrationException ie) {
			logger.logError("/cobis/web/catalog/getPaymentFrequency Error al obtener los plazos grupales ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis/web/catalog/getPaymentFrequency Error al obtener los plazos grupales ", e);
			return errorResponse("/cobis/web/catalog/getPaymentFrequency Error al obtener los plazos grupales ");
		}

	}
	
	@Path("/getCatalogByName/{catalogName}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getCatalogByName(@PathParam("catalogName") String catalogName) {
		CatalogoReq catalogoReq = new CatalogoReq();
		catalogoReq.setTable(catalogName);
		CatalogoResp catalogoResp = catalogService.getCatalogo(catalogoReq);
		List<CatalogDto> catalogItems = new ArrayList<CatalogDto>();
		if(catalogoResp != null && catalogoResp.isSucess() && catalogoResp.getItems() != null) {
			for (CatalogoItem iterator : catalogoResp.getItems()) {
				CatalogDto catalogTemp = new CatalogDto();
				catalogTemp.setCode(iterator.getCode());
				catalogTemp.setName(iterator.getValue());
				catalogItems.add(catalogTemp);
			}
		}
		return successResponse(catalogItems, "/cobis/web/catalog/getCatalogByName");
	}
	
	
	@Path("/getCatalogByListName")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getCatalogByListName(String[] catalogNameList) {
		HashMap<String, List<CatalogDto>> responseCatalog = new HashMap<String, List<CatalogDto>>();
		for (String catalogName : catalogNameList) {
			CatalogoReq catalogoReq = new CatalogoReq();
			catalogoReq.setTable(catalogName);
			CatalogoResp catalogoResp = catalogService.getCatalogo(catalogoReq);
			List<CatalogDto> catalogItems = new ArrayList<CatalogDto>();
			if(catalogoResp != null && catalogoResp.isSucess()  && catalogoResp.getItems() != null) {
				for (CatalogoItem iterator : catalogoResp.getItems() ) {
					CatalogDto catalogTemp = new CatalogDto();
					catalogTemp.setCode(iterator.getCode());
					catalogTemp.setName(iterator.getValue());
					catalogItems.add(catalogTemp);
				}
				
			}
			responseCatalog.put(catalogName, catalogItems);
		}
		return successResponse(responseCatalog, "/cobis/web/catalog/getCatalogByListName");
	}
	
	
	@Path("/getSynchronyzedTable")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getSyncronyzedTable() {
		return successResponse(catalogIntegrationService.getSynchronizedCatalog(), "/cobis/web/catalog/getSynchronyzedTable");
	}
	
	
}
