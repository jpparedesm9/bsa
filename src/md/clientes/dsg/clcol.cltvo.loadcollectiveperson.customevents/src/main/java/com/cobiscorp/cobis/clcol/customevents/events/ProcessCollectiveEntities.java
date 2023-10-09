package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.Map;

import cobiscorp.ecobis.collective.dto.EntityRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.clcol.model.CollectivePersonRecord;
import com.cobiscorp.cobis.clcol.model.CollectivePersonFile;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.MessageDTO;
import com.cobiscorp.ecobis.collective.commons.services.ProcessEntityManager;
import com.cobiscorp.designer.exception.DesignerRuntimeException;

public class ProcessCollectiveEntities extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ProcessCollectiveEntities.class);
	private ICTSServiceIntegration serviceIntegration;

	public ProcessCollectiveEntities(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("Start executeCommand in ProcessCollectiveEntities");
		Map<String, Object> filter = args.getParameters().getCustomParameters();

		DataEntity entityFile = arg0.getEntity(CollectivePersonFile.ENTITY_NAME);
		String fileName = entityFile.get(CollectivePersonFile.FILENAME);
		//LOGGER.logDebug("executeCommand -> fileName" + fileName);

		String succRec = entityFile.get(CollectivePersonFile.SUCCESSRECORDS);
		Integer succRecInt = Integer.valueOf(succRec==null || "".equals(succRec.trim())? "0":succRec);
		LOGGER.logDebug("executeCommand -> succRecIntA=" + succRecInt);

		DataEntityList collectiveEntities = arg0.getEntityList(CollectivePersonRecord.ENTITY_NAME);
		Integer position = filter.get("position") == null ? null : Integer.parseInt(String.valueOf(filter.get("position")));
		if (position != null) {

			EntityRequest entityRequest = new EntityRequest();

			DataEntity entity = collectiveEntities.get(position);
			entityRequest.setLastName(entity.get(CollectivePersonRecord.SURNAME));
			entityRequest.setSurname(entity.get(CollectivePersonRecord.SECONDSURNAME));
			entityRequest.setFirstname(entity.get(CollectivePersonRecord.FIRSTNAME));
			entityRequest.setSecondname(entity.get(CollectivePersonRecord.SECONDNAME));
			entityRequest.setBirthDate(entity.get(CollectivePersonRecord.BIRTHDATE));
			entityRequest.setBirthPlace(entity.get(CollectivePersonRecord.BIRTHENTITY));
			entityRequest.setGender(entity.get(CollectivePersonRecord.GENDER));
			// entityRequest.setHomeStreet(entity.get(CollectivePersonRecord.STREETADDRESS));
			// entityRequest.setInternalHomeNumber(entity.get(CollectivePersonRecord.NUMBERINTADDRESS));
			// entityRequest.setExternalHomeNumber(entity.get(CollectivePersonRecord.NUMBEREXTADDRESS));
			// entityRequest.setColony(entity.get(CollectivePersonRecord.COLONYADDRESS));
			// entityRequest.setPostalCode(entity.get(CollectivePersonRecord.CPADDRESS));
			entityRequest.setMailAddress(entity.get(CollectivePersonRecord.EMAIL));
			entityRequest.setCellphoneNumber(entity.get(CollectivePersonRecord.CELLPHONENUMBER));
			entityRequest.setOfficeId(entity.get(CollectivePersonRecord.OFFICEID));
			entityRequest.setCurp(entity.get(CollectivePersonRecord.CURP));
			entityRequest.setRfc(entity.get(CollectivePersonRecord.RFC));
			entityRequest.setCollectiveName(entity.get(CollectivePersonRecord.COLLECTIVENAME));
			entityRequest.setClientLevel(entity.get(CollectivePersonRecord.CLIENTLEVEL));
			entityRequest.setOfficialLogin(entity.get(CollectivePersonRecord.OFFICIALLOGIN));
			// entityRequest.setEconomicActivity(entity.get(CollectivePersonRecord.ECONOMICACTIVITY));
			// entityRequest.setMonthlyIncome(entity.get(CollectivePersonRecord.MONTHSALES));
			// entityRequest.setChildrenNumber(entity.get(CollectivePersonRecord.NUMBERCHILDREN));
			// entityRequest.setPeriodicity(entity.get(CollectivePersonRecord.PERIODICITY));
			entityRequest.setProspFilename(fileName);
			try{
				ProcessEntityManager processEntityManager = new ProcessEntityManager(serviceIntegration);
				Map<String, Object> outputs = processEntityManager.processCollectiveEntity(entityRequest, args);
				if (outputs != null && outputs.size() > 0) {
					entity.set(CollectivePersonRecord.OBSERVATIONS, outputs.get("@o_msg") == null ? null : String.valueOf(outputs.get("@o_msg")));
					collectiveEntities.set(position, entity);
					arg0.setEntityList(CollectivePersonRecord.ENTITY_NAME, collectiveEntities);
					
					LOGGER.logDebug("executeCommand -> o_sev=" + outputs.get("@o_sev"));
					LOGGER.logDebug("executeCommand -> o_msg=" + outputs.get("@o_msg"));
					if("0".equals(String.valueOf(outputs.get("@o_sev")))){
						succRecInt++;
						entity.set(CollectivePersonRecord.OBSERVATIONS, outputs.get("@o_ente") == null ? null : String.valueOf(outputs.get("@o_ente")));
					}else if(null == outputs.get("@o_sev") && null == outputs.get("@o_msg") && null == outputs.get("@o_ente")){
						entity.set(CollectivePersonRecord.OBSERVATIONS, "ERROR:Tiempo de espera excedido");
					}
				} else {
					String messages = "";
					for (MessageDTO message : args.getMessageManager().getMessages()) {
						messages = messages + message;
					}
					entity.set(CollectivePersonRecord.OBSERVATIONS, messages);
					collectiveEntities.set(position, entity);
					arg0.setEntityList(CollectivePersonRecord.ENTITY_NAME, collectiveEntities);
				
				}
				entityFile.set(CollectivePersonFile.SUCCESSRECORDS, String.valueOf(succRecInt));
			} catch (Exception ex) {
				String timeExceeded = "40009";
				if ((ex instanceof DesignerRuntimeException)){
					DesignerRuntimeException ex2 = (DesignerRuntimeException)ex;
					LOGGER.logDebug("ProcessCollectiveEntities ex2=>" + ex2);
				}
			}
		} else {
			args.getMessageManager().showErrorMsg("Error al procesar los datos de la grilla.");
		}
	}
}
