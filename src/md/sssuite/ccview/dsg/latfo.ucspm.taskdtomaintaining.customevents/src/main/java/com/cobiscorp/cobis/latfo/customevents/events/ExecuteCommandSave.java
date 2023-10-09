package com.cobiscorp.cobis.latfo.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.customevents.view.VW_PROPIDADES79_ViewEvent;
import com.cobiscorp.cobis.latfo.model.DTOS;
import com.cobiscorp.cobis.latfo.model.VccProperties;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;

public class ExecuteCommandSave extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(VW_PROPIDADES79_ViewEvent.class);

	public ExecuteCommandSave(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingrea al método executeCommand de la clase ExecuteCommandSave");
				logger.logDebug("1)----->Recupero mi link desde la presentacion");
			}

			DataEntity dataEntityDTO = entities.getEntity(DTOS.ENTITY_NAME);
			if (logger.isDebugEnabled()) {
				logger.logDebug("2)----->Declaro los servicios a utilizar");
			}
			ServiceResponse serviceResponse = null;
			if (logger.isDebugEnabled()) {
				logger.logDebug("3)----->Formo mi ojeto a enviar por el servicio" + dataEntityDTO.get(DTOS.PARENT));
			}
			DtosDTO dtosDTO = new DtosDTO();
			dtosDTO.setDtoId(dataEntityDTO.get(DTOS.DTOID));
			dtosDTO.setServiceId(dataEntityDTO.get(DTOS.SERIDFK));
			dtosDTO.setMnemonic(dataEntityDTO.get(DTOS.MNEMONIC));
			dtosDTO.setDtoName(dataEntityDTO.get(DTOS.NAME));
			dtosDTO.setDtoText(dataEntityDTO.get(DTOS.TEXT));
			dtosDTO.setDtoDescription(dataEntityDTO.get(DTOS.DESCRIPTION));
			dtosDTO.setDtoParent(dataEntityDTO.get(DTOS.PARENT) == null ? null : dataEntityDTO.get(DTOS.PARENT));
			dtosDTO.setDtoOrder(dataEntityDTO.get(DTOS.ORDER));
			dtosDTO.setIsList(dataEntityDTO.get(DTOS.ISLIST));

			if (dataEntityDTO.get(DTOS.DTOID) == 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("4)----->Ejecuto mi servicio para insertar la entidad");
				}
				serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.insertDtoSection", new Object[] { dtosDTO });
				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("5)--------------------->Inserta el registro");
					}
					arg1.setSuccess(true);
					arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_RDARISION_75521");
				} else {
					if (logger.isDebugEnabled()) {
						logger.logError("Error al Insertar el registro" + serviceResponse.getMessages());
					}
					arg1.setSuccess(false);
					arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERRORGRUO_46058");
				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("7)----->Ejecuto mi servicio para actualizar la entidad");
				}
				serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.updateDtoSection", new Object[] { dtosDTO });
				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("8)--------------------->Actualiza el registro");
					}
					arg1.setSuccess(true);
					arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_CULZRNCIO_12107");
				} else {
					logger.logError("Error al Actualizar el registro" + serviceResponse.getMessages());
					arg1.setSuccess(false);
					arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_RRLACTUIS_39276");
				}
			}

			if (serviceResponse != null && serviceResponse.isResult()) {

				Integer idDTO = (Integer) serviceResponse.getData();
				if (logger.isDebugEnabled()) {
					logger.logDebug("6)----->Inserto o Actualizo la entidad : " + idDTO);
				}
				DataEntityList dataEntityList = entities.getEntityList(VccProperties.ENTITY_NAME);
				if (logger.isDebugEnabled()) {
					logger.logDebug("7)----->Formo mi ojeto para la lista a enviar por el servicio");
				}
				for (DataEntity dataEntity : dataEntityList) {

					PropertiesDTO properties = new PropertiesDTO();
					if (logger.isDebugEnabled()) {
						logger.logDebug("8)----->dataEntity-------->" + dataEntity.get(VccProperties.PROID));
					}
					properties.setPropertieId(dataEntity.get(VccProperties.PROID));
					properties.setDtoId(idDTO);
					properties.setName(dataEntity.get(VccProperties.NAME));
					properties.setText(dataEntity.get(VccProperties.TEXT));
					properties.setPrimaryKey(dataEntity.get(VccProperties.PRIMARYKEY));
					properties.setGrouping(dataEntity.get(VccProperties.GROUPING));
					properties.setDetailSection(dataEntity.get(VccProperties.DETAILSECTION));
					properties.setVisibleSumaryDetail(dataEntity.get(VccProperties.VISIBLESUMARYDETAIL));
					properties.setVisibleSumaryGroup(dataEntity.get(VccProperties.VISIBLESUMARYGROUP));
					properties.setFilterInProcess(dataEntity.get(VccProperties.FILTERINPROCESS));
					// properties.setWidth(dataEntity.get(VccProperties.WIDTH));
					properties.setFormat(dataEntity.get(VccProperties.FORMAT));
					properties.setType(dataEntity.get(VccProperties.TYPE));
					properties.setStyle(dataEntity.get(VccProperties.STYLE));
					properties.setOrder(dataEntity.get(VccProperties.ORDER));

					if (dataEntity.get(VccProperties.PROID) == null || dataEntity.get(VccProperties.PROID) == 0) {
						if (logger.isDebugEnabled()) {
							logger.logDebug("9)----->Inserto mi detalle de entidades");
						}
						properties.setWidth(dataEntity.get(VccProperties.WIDTH) + "px");
						serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.insertPropertiesSection",
								new Object[] { properties });
					} else {
						if (logger.isDebugEnabled()) {
							logger.logDebug("10)----->Actualizo mi detalle de entidades");
						}
						properties.setWidth(dataEntity.get(VccProperties.WIDTH));
						serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.updatePropertiesSection",
								new Object[] { properties });
					}

					if (serviceResponse != null && serviceResponse.isResult()) {
						if (logger.isDebugEnabled()) {
							logger.logDebug("11)----->Inserto o Actualizo la entidad del detalle");
						}
						Integer idProperties = (Integer) serviceResponse.getData();
						dataEntity.set(VccProperties.PROID, idProperties);
					}

				}

			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza el método executeCommand de la clase ExecuteCommandSave");
			}
		} catch (Exception e) {
			logger.logError("Error en el método executeCommand de la clase ExecuteCommandSave");
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_RRLACTUIS_39276");
		}
	}
}
