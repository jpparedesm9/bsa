package com.cobiscorp.cobis.latfo.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.model.SectionsMaintaining;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;

public class InitdataSectionsMaintaining extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(InitdataSectionsMaintaining.class);

	public InitdataSectionsMaintaining(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.designer.api.customization.IDesignerDataEvent#executeDataEvent (com.cobiscorp.designer.api.DynamicRequest,
	 * com.cobiscorp.designer.api.customization.arguments.IDataEventArgs)
	 */
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		try {
			DataEntity dataEntitySectionsMaintaining = entities.getEntity(SectionsMaintaining.ENTITY_NAME);
			if (logger.isDebugEnabled()) {
				logger.logDebug("1)----->Recupero mi entidad desde la vista" + dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDID));
			}
			Integer idSection = dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDID);
			if (logger.isDebugEnabled()) {
				logger.logDebug("2)----->Recupero el idSection " + idSection);
			}
			ServiceResponse serviceResponse = null;
			if (idSection != 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("3)----->Ejecuto mi servicio");
				}
				serviceResponse = execute(logger, "clientviewer.Administration.getProductAdministratorDefaultByIdProduct", new Object[] { new Double(
						idSection) });

				if (serviceResponse != null && serviceResponse.isResult()) {
					logger.logDebug("4)----->Recupero la data");
					DefaultProductAdministratorDTO defaultProductAdministratorDTO = (DefaultProductAdministratorDTO) serviceResponse.getData();
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDID, defaultProductAdministratorDTO.getIdProduct().intValue());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.DTOIDFK, defaultProductAdministratorDTO.getIdDtoFk());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDMNEMONIC, defaultProductAdministratorDTO.getMnemonic());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDNAME, defaultProductAdministratorDTO.getName());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDDESCRIPTION, defaultProductAdministratorDTO.getDescription());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDPARENT, defaultProductAdministratorDTO.getParent().intValue());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDTYPECLIENT, defaultProductAdministratorDTO.getTypeClient());
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDORDER, defaultProductAdministratorDTO.getOrder());

					logger.logDebug("5)----->Verifico si el padre es null y recupero al padre");
					if (defaultProductAdministratorDTO.getParent() != null) {
						serviceResponse = execute(logger, "clientviewer.Administration.getProductAdministratorDefaultByIdProduct",
								new Object[] { new Double(defaultProductAdministratorDTO.getParent().intValue()) });
						if (serviceResponse != null && serviceResponse.isResult()) {
							logger.logDebug("6)----->Recupero data al padre");
							DefaultProductAdministratorDTO defaultProductAdministratorDTOParent = (DefaultProductAdministratorDTO) serviceResponse
									.getData();
							dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDPARENTDESC,
									defaultProductAdministratorDTOParent.getDescription());
						}
					}

					logger.logDebug("6)----->Verifico si el dto es null y recupero al dto");
					if (defaultProductAdministratorDTO.getIdDtoFk() != null) {
						serviceResponse = execute(logger, "clientviewer.Administration.getDtoSectionById",
								new Object[] { defaultProductAdministratorDTO.getIdDtoFk() });
						if (serviceResponse != null && serviceResponse.isResult()) {
							logger.logDebug("7)----->Recupero data del dto");
							DtosDTO dtoId = (DtosDTO) serviceResponse.getData();
							dataEntitySectionsMaintaining.set(SectionsMaintaining.DTOIDFKDESC, dtoId.getDtoDescription());
						}
					}

				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Id de la sección es nula");
					}
				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("serviceResponse != null && serviceResponse.isResult()");
				}

			}
		} catch (Exception e) {
			logger.logError("Error --> " + e.getMessage());
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_RRSECIOMA_86573");
		}
	}

}