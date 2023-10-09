package com.cobiscorp.cobis.latfo.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.customevents.view.VW_DTOLISTTJE03_ViewEvent;
import com.cobiscorp.cobis.latfo.model.DTOS;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;

public class InitdataDtoList extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(VW_DTOLISTTJE03_ViewEvent.class);

	public InitdataDtoList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.designer.api.customization.IDesignerDataEvent#executeDataEvent (com.cobiscorp.designer.api.DynamicRequest,
	 * com.cobiscorp.designer.api.customization.arguments.IDataEventArgs)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia el método executeDataEvent en la clase InitdataDtoList");
				logger.logDebug("2---------------------------->Creo la una lista de data entities");
			}
			DataEntityList dtoList = new DataEntityList();
			ServiceResponse serviceResponse = null;

			// llamar al servicio creado con el serverResponce
			if (logger.isDebugEnabled()) {
				logger.logDebug("3---------------------------->Ejecuto mi servicio");
			}
			serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.getAllDtos", new Object[] {});

			if (serviceResponse != null && serviceResponse.isResult()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("4---------------------------->Lleno la data");
				}
				List<DtosDTO> dtos = (List<DtosDTO>) serviceResponse.getData();
				for (DtosDTO dto : dtos) {
					DataEntity dtoEntity = new DataEntity();
					dtoEntity.set(DTOS.DTOID, dto.getDtoId());
					dtoEntity.set(DTOS.SERIDFK, dto.getServiceId());
					dtoEntity.set(DTOS.NAME, dto.getDtoName());
					dtoEntity.set(DTOS.TEXT, dto.getDtoText());
					dtoEntity.set(DTOS.DESCRIPTION, dto.getDtoDescription());
					dtoEntity.set(DTOS.PARENT, dto.getDtoParent() == null ? 0 : dto.getDtoParent());
					dtoEntity.set(DTOS.ISLIST, dto.getIsList());
					dtoEntity.set(DTOS.MNEMONIC, dto.getMnemonic());
					dtoEntity.set(DTOS.ORDER, dto.getDtoOrder() == null ? 0 : dto.getDtoOrder());
					dtoEntity.set(DTOS.PARENTNAME, dto.getDtoNameParent() == null ? "" : dto.getDtoNameParent());
					dtoList.add(dtoEntity);
				}
				entities.setEntityList(DTOS.ENTITY_NAME, dtoList);
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza el método executeDataEvent en la clase InitdataDtoList");
			}

		} catch (Exception e) {
			logger.logError("Error al cargar la lista de dtos en la clase InitdataDtoList");
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERODTSLST_24578");
		}
	}
}
