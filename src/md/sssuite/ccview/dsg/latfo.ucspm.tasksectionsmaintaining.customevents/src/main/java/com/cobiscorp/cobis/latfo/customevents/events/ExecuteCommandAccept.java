package com.cobiscorp.cobis.latfo.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.model.SectionsMaintaining;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;

public class ExecuteCommandAccept extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(ExecuteCommandAccept.class);

	public ExecuteCommandAccept(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		try {

			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicio executeCommand de la clase ExecuteCommandAccept");
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("1)----->Declaro los servicios que voy a utilizar ");
			}			
			if (logger.isDebugEnabled()) {
				logger.logDebug("2)----->Recupero mi seccion desde la presentacion");
			}
			DataEntity dataEntitySectionsMaintaining = entities.getEntity(SectionsMaintaining.ENTITY_NAME);
			if (logger.isDebugEnabled()) {
				logger.logDebug("3)----->Formo mi objeto a enviar por request");
			}
			DefaultProductAdministratorDTO section = new DefaultProductAdministratorDTO();
			section.setIdProduct(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDID).doubleValue());
			section.setMnemonic(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDMNEMONIC));
			section.setDescription(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDDESCRIPTION));
			section.setName(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDNAME));
			section.setParent(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDPARENT).doubleValue());
			section.setTypeClient(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDTYPECLIENT));
			section.setIdDtoFk(dataEntitySectionsMaintaining.get(SectionsMaintaining.DTOIDFK));
			section.setOrder(dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDORDER));
			if (logger.isDebugEnabled()) {
				logger.logDebug("4)----->Ejecuto mis servicios");
			}
			if (dataEntitySectionsMaintaining.get(SectionsMaintaining.PRDID) == 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("4)----->Ejecuto mi servicio para insertar");
				}
				ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.insertDefaultProductAdministrator",
						new Object[] { section });
				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("5)--------------------->Inserta el registro");
					}
					Double idSection = (Double) serviceResponse.getData();
					dataEntitySectionsMaintaining.set(SectionsMaintaining.PRDID, idSection.intValue());
					arg1.setSuccess(true);
					arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_RDARISION_75521");
				} else {
					logger.logDebug("6)--------------------->Error al Insertar el registro");					
					arg1.setSuccess(false);
					arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERRORGRUO_46058");
				}
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("4)----->Ejecuto mi servicio para update");
				}
				ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "clientviewer.Administration.updateDefaultProductAdministratorById",
						new Object[] { section });
				if (serviceResponse != null && serviceResponse.isResult()) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("8)--------------------->Actualiza el registro");
					}
					arg1.setSuccess(true);
					arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_CULZRNCIO_12107");
				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("9)--------------------->Error al Actualizar el registro");
					}					
					arg1.setSuccess(false);
					arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_RRLACTUIS_39276");
				}
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza executeCommand de la clase ExecuteCommandAccept");
			}

		} catch (Exception e) {
			logger.logError("Error en el método executeCommand de la clase ExecuteCommandAccept", e);
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_ERRORGRUO_46058");
		}
	}

}
