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
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IGridCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;

public class GridRowDeletingDto extends BaseEvent implements IGridCommand {

	private static final ILogger logger = LogFactory.getLogger(VW_DTOLISTTJE03_ViewEvent.class);

	public GridRowDeletingDto(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void executeGridCommad(DataEntityList arg0, IGridExecuteCommandEventArgs arg1) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingresa al método executeGridCommad en la clase GridRowDeletingDto");
			}
			DataEntity dataEntity = arg1.getDynamicRequest().getEntity("DtoTmp");
			Integer idDTO = dataEntity.get(new Property<Integer>("idDTO", Integer.class, false));
			// Integer indexDTO = dataEntity.get(new Property<Integer>("indexDTO", Integer.class, false));
			if (logger.isDebugEnabled()) {
				logger.logDebug("1)--------------------->Declaro los servicios");
			}
			ServiceResponse serviceResponse = null;
			if (logger.isDebugEnabled()) {
				logger.logDebug("2)--------------------->Ejecuto el servicio");
			}
			serviceResponse = execute(logger, "clientviewer.Administration.deleteDtoSection", new Object[] { idDTO });
			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("3)--------------------->Elimina el registro");
				}
				arg1.setSuccess(true);
				arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_ELIAIOSCS_69033");

				serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.getAllDtos", new Object[] {});

				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("4---------------------------->Lleno la data");
					}
					DataEntityList dtoList = new DataEntityList();
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
					arg1.getDynamicRequest().setEntityList(DTOS.ENTITY_NAME, dtoList);
				}

			} else {
				logger.logError("4)--------------------->Error al eliminar el registro " + serviceResponse.getMessages());
				arg1.setSuccess(false);
				arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_EAELMRERO_86463");
			}
		} catch (Exception e) {
			logger.logError("Error al cargar la lista de dtos en la clase InitdataDtoList");
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERODTSLST_24578");
		}
	}

}
