package com.cobiscorp.cobis.latfo.customevents.listproperties.events;

import java.util.List;

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
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;

public class InitPropertiesGrid extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(VW_PROPIDADES79_ViewEvent.class);

	public InitPropertiesGrid(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {

		logger.logInfo("1---------------------------->Creo la una lista de data entities");
		DataEntityList dtoListProperties = new DataEntityList();

		DataEntity dataEntityDTO = arg0.getEntity(DTOS.ENTITY_NAME);
		logger.logInfo("2---------------------------->Recupero mi entidad desde la presentacion" + dataEntityDTO);
		Integer idList = dataEntityDTO.get(DTOS.DTOID); // dtoEntity.get(VccProperties.ID);

		if (idList != 0) {

			logger.logInfo("3---------------------------->Ejecuto mi servicio");
			ServiceResponse serviceResponses = execute(getServiceIntegration(), logger, "clientviewer.Administration.getPropertiesByDto",
					new Object[] { idList });

			if (serviceResponses != null && serviceResponses.isResult()) {

				logger.logInfo("4---------------------------->Lleno la data");
				List<PropertiesDTO> propertiesDtos = (List<PropertiesDTO>) serviceResponses.getData();

				for (PropertiesDTO properties : propertiesDtos) {

					logger.logInfo("5---------------------------->Lleno la data del grid");
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

			}
		}

		return dtoListProperties.getDataList();
	}
}
