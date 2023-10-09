package com.cobiscorp.cobis.busin.view.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.WorkloadOfficerResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.OfficerManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogOfficial extends BaseEvent implements ILoadCatalog {

	public LoadCatalogOfficial(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogOfficial.class);

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs arg1) {
		// TODO Auto-generated method stub
		LOGGER.logError("Entro al load CATALOGO*********");
		List<ItemDTO> listOficer = new ArrayList<ItemDTO>();
		List<ItemDTO> listOficer1 = new ArrayList<ItemDTO>();
		List<ItemDTO> listOficerAll = new ArrayList<ItemDTO>();
		try{

			// ******************llenando el catalogo de oficiales***************//
			listOficer = this.listOficer(entities, Mnemonic.CHAR_S, arg1);
			listOficer1 = this.listOficer(entities, Mnemonic.CHAR_N, arg1);
			listOficerAll.addAll(listOficer);
			listOficerAll.addAll(listOficer1);
			return listOficerAll;
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_OFFICIAL, e, arg1, LOGGER);
		}
		return listOficerAll;
	}

	public List<ItemDTO> listOficer(DynamicRequest entities, char opcion, ILoadCatalogDataEventArgs arg1) {

		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		WorkloadOfficerRequest workloadOfficerRequest1 = new WorkloadOfficerRequest();
		List<ItemDTO> listOficer = new ArrayList<ItemDTO>();
		workloadOfficerRequest1.setConnectionOffice(originalHeader.get(OriginalHeader.OFFICE));
		workloadOfficerRequest1.setProcessInstance(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
		workloadOfficerRequest1.setOption(opcion);
		OfficerManagement officerManagement = new OfficerManagement(super.getServiceIntegration());
		WorkloadOfficerResponse[] workloadOfficerResponse = officerManagement.getOfficialList(workloadOfficerRequest1, arg1, new BehaviorOption(true));

		if (workloadOfficerResponse != null) {
			LOGGER.logInfo("***************servicio de oficiales !=null loadCatalogo:" + opcion);
			if (workloadOfficerResponse.length > 0) {
				for (WorkloadOfficerResponse officerResponse : workloadOfficerResponse) {
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(officerResponse.getOfficerId().toString());
					itemDTO.setValue(officerResponse.getNameOfficer());
					listOficer.add(itemDTO);
				}
			}
		}
		return listOficer;
	}
}
