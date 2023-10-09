package com.cobiscorp.cobis.latfo.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.model.DTOS;
import com.cobiscorp.cobis.latfo.model.VccProperties;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;

public class InitdataDto extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(InitdataDto.class);

	public InitdataDto(ICTSServiceIntegration serviceIntegration) {
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
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa al método executeDataEvent de la clase InitdataDto");
			logger.logDebug("1)----->Recupero mi entidad desde la vista");
		}
		try {
			DataEntity dtoEntity = entities.getEntity(DTOS.ENTITY_NAME);
			Integer idDTO = dtoEntity.get(DTOS.DTOID);

			// Seteo los campos que son check
			dtoEntity.set(DTOS.ISLIST, false);

			if (idDTO != null && idDTO != 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("2)----->Ejecuto mi servicio");
				}
				ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.getDtoSectionById",
						new Object[] { idDTO });

				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("3)----->Recupero la informacion");
					}
					DtosDTO dto = (DtosDTO) serviceResponse.getData();
					dtoEntity.set(DTOS.DTOID, dto.getDtoId());
					dtoEntity.set(DTOS.SERIDFK, dto.getServiceId());
					dtoEntity.set(DTOS.MNEMONIC, dto.getMnemonic());
					dtoEntity.set(DTOS.NAME, dto.getDtoName());
					dtoEntity.set(DTOS.TEXT, dto.getDtoText());
					dtoEntity.set(DTOS.DESCRIPTION, dto.getDtoDescription());
					dtoEntity.set(DTOS.PARENT, dto.getDtoParent());
					Integer isList = dto.getIsList() == null ? 0 : dto.getIsList() ? 1 : 0;
					dtoEntity.set(DTOS.ISLIST, dto.getIsList());
					dtoEntity.set(DTOS.ORDER, dto.getDtoOrder());
					if (logger.isDebugEnabled()) {
						logger.logDebug("4---------------------------->Ejecuto mi servicio");
					}
					serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.getPropertiesByDto",
							new Object[] { idDTO });

					if (serviceResponse != null && serviceResponse.isResult()) {
						if (logger.isDebugEnabled()) {
							logger.logDebug("5---------------------------->Lleno la data");
						}
						DataEntityList dtoListProperties = new DataEntityList();
						List<PropertiesDTO> propertiesDtos = (List<PropertiesDTO>) serviceResponse.getData();

						for (PropertiesDTO properties : propertiesDtos) {
							if (logger.isDebugEnabled()) {
								logger.logDebug("6---------------------------->Lleno la data del grid");
							}
							DataEntity propertyEntity = new DataEntity();
							propertyEntity.set(VccProperties.PROID, properties.getPropertieId());
							propertyEntity.set(VccProperties.DTOID, properties.getDtoId());
							propertyEntity.set(VccProperties.NAME, properties.getName());
							propertyEntity.set(VccProperties.TEXT, properties.getText());
							propertyEntity.set(VccProperties.PRIMARYKEY, properties.getPrimaryKey());
							propertyEntity.set(VccProperties.GROUPING, properties.getGrouping());
							propertyEntity.set(VccProperties.DETAILSECTION, properties.getDetailSection());
							propertyEntity.set(VccProperties.VISIBLESUMARYDETAIL, properties.getVisibleSumaryDetail());
							propertyEntity.set(VccProperties.VISIBLESUMARYGROUP, properties.getVisibleSumaryGroup());
							propertyEntity.set(VccProperties.FILTERINPROCESS, properties.getFilterInProcess());
							propertyEntity.set(VccProperties.WIDTH, properties.getWidth());
							propertyEntity.set(VccProperties.FORMAT, properties.getFormat());
							propertyEntity.set(VccProperties.TYPE, properties.getType());
							propertyEntity.set(VccProperties.STYLE, properties.getStyle());
							propertyEntity.set(VccProperties.ORDER, properties.getOrder());
							dtoListProperties.add(propertyEntity);

						}
						entities.setEntityList(VccProperties.ENTITY_NAME, dtoListProperties);

					}

				}
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza al método executeDataEvent de la clase InitdataDto");
			}
		} catch (Exception e) {
			logger.logError("Error en al obteber los dtos en la clase InitdataDto -->" + e.getMessage());
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERRODTOSV_27906");
		}
	}
}
