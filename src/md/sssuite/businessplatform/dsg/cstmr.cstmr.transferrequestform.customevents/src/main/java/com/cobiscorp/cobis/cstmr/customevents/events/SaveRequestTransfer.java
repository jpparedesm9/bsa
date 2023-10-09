package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.CustomerTransferRequest;
import com.cobiscorp.cobis.cstmr.model.TransferRequest;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class SaveRequestTransfer extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(SaveRequestTransfer.class);

	public SaveRequestTransfer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		try {
			LOGGER.logDebug("Ingreso executeCommand SaveRequestTransfer ");		
			DataEntity item = new DataEntity();
			DataEntityList lista = new DataEntityList();
			//officialOriginId=mgarcia, descriptionCause=null, idCause=7, isGroup=N, officeOriginId=1101, 
			//officeDestinationId=1101, officialDestinationId=ivinueza, org_officialOriginId=null, org_descriptionCause=null, org_idCause=null, org_isGroup=null, org_officeOriginId=null, org_officeDestinationId=null, org_officialDestinationId=null}, CustomerTransferRequest=[{customerName=ARIAS ARIAS CINCO, registrationDate=2019-07-03 00:00:00.0, customerId=20656, isChecked=true, cicles=0, customerStatus=A, lastUpdateDate=2019-07-03 00:00:00.0, dsgnrId=84ded474-5801-4053-8bed-9a8108797619, trackId=dbdf8e4f-dddd-479d-9ee0-f3637c7a51a4, officeId=null}, {customerName=ARIAS ARIAS CUARTO, registrationDate=2019-07-03 00:00:00.0, customerId=20655, isChecked=false, cicles=0, customerStatus=A, lastUpdateDate=2019-07-03 00:00:00.0, dsgnrId=7db47db4-c86d-4a75-8f3a-bde376bde350, officeId=null}, {customerName=ARIAS ARIAS OCHO , registrationDate=2019-07-03 00:00:00.0, customerId=20658, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-03 00:00:00.0, dsgnrId=c910f6d8-b568-4da2-a3ca-c926fefb67b6, officeId=null}, {customerName=ARIAS ARIAS SEXTO , registrationDate=2019-07-03 00:00:00.0, customerId=20657, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-03 00:00:00.0, dsgnrId=b0918e05-caeb-436d-9004-7287988adfa9, officeId=null}, {customerName=CLAVIJO CALA, registrationDate=2019-07-01 00:00:00.0, customerId=20853, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=3ba89feb-1cf9-4282-8e9e-fbf00b7ecba4, officeId=null}, {customerName=DEL GRUPO 1268  CLIENTE 20561  ROJAS , registrationDate=2019-07-01 00:00:00.0, customerId=20839, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=c322fbdd-1801-4404-9131-e1a3ad2114f6, officeId=null}, {customerName=GERSON  ARIAS , registrationDate=2019-06-10 00:00:00.0, customerId=20300, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-06-10 00:00:00.0, dsgnrId=23da0838-51ee-4860-93ac-2405f69099a1, officeId=null}, {customerName=LIONEL MESSI, registrationDate=2019-06-10 00:00:00.0, customerId=20591, isChecked=false, cicles=0, customerStatus=A, lastUpdateDate=2019-06-21 00:00:00.0, dsgnrId=53adfeee-867c-4c63-90b7-666cced3a70e, officeId=null}, {customerName=LOLITA  PEREZ , registrationDate=2019-07-01 00:00:00.0, customerId=21036, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=d469c0e1-5831-45e7-96db-8699367cdbe6, officeId=null}, {customerName=LUIS  ROMERO , registrationDate=2019-06-10 00:00:00.0, customerId=20302, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-06-10 00:00:00.0, dsgnrId=ac4a36eb-c6ca-4772-9efe-0330a1f2567b, officeId=null}, {customerName=LUISA HERNANDEZ, registrationDate=2019-07-01 00:00:00.0, customerId=20993, isChecked=false, cicles=0, customerStatus=A, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=d7d94ab4-cafa-483f-88d1-bae5de774866, officeId=null}, {customerName=LUISA POLANIA, registrationDate=2019-09-06 00:00:00.0, customerId=21443, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-09-06 00:00:00.0, dsgnrId=337b7fd0-0daf-46fe-8668-7289aca28d9d, officeId=null}, {customerName=LUPITA SEGUNDA DE RODRIGUEZ DE LOPEZ, registrationDate=2019-07-03 00:00:00.0, customerId=20659, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-04 00:00:00.0, dsgnrId=a0f05e1e-0b7c-46af-b4c9-79d22699a2ec, officeId=null}, {customerName=MARIA GARCIA, registrationDate=2019-09-24 00:00:00.0, customerId=21450, isChecked=false, cicles=0, customerStatus=A, lastUpdateDate=2019-09-24 00:00:00.0, dsgnrId=256197ae-04ed-44a3-a830-099050613fc3, officeId=null}, {customerName=MAX REPORTE  EXTERNO , registrationDate=2019-07-01 00:00:00.0, customerId=20838, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=57ef5452-87e2-4a89-8afd-64d17320b6f2, officeId=null}, {customerName=PAOLA  ZAPATA ZAPATA, registrationDate=2019-06-10 00:00:00.0, customerId=20332, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-06-10 00:00:00.0, dsgnrId=a0f9b826-e5ad-4cae-8c90-04ab4a076545, officeId=null}, {customerName=RAFAELA PRIMERO, registrationDate=2019-07-04 00:00:00.0, customerId=20660, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-04 00:00:00.0, dsgnrId=4e453d1a-7d26-4ab6-819e-5055663eb3bf, officeId=null}, {customerName=RAFELA SANTOS SEGUNDO , registrationDate=2019-07-04 00:00:00.0, customerId=20661, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-04 00:00:00.0, dsgnrId=9cd81581-31fb-40fb-9938-25be9bf4447d, officeId=null}, {customerName=REPORTE   EXTERNO , registrationDate=2019-07-01 00:00:00.0, customerId=20840, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=768b8d82-a18c-49ef-8073-f63a1441c953, officeId=null}, {customerName=REPORTE EXTERNO  UNO , registrationDate=2019-07-01 00:00:00.0, customerId=20835, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=79e6f7e6-9d3a-48c2-80cd-bdfcbdfa9b41, officeId=null}, {customerName=REPORTE EXTERNO DOS , registrationDate=2019-07-01 00:00:00.0, customerId=20836, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-07-01 00:00:00.0, dsgnrId=fc4105a7-1c4e-4fdb-92a2-374648528ca2, officeId=null}, {customerName=SANDRA  TORREZ , registrationDate=2019-06-10 00:00:00.0, customerId=20315, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-06-10 00:00:00.0, dsgnrId=c77312db-3212-4290-a1ce-f97d1ad2b487, officeId=null}, {customerName=SANTIAGO  MOSQUERA VIZUETE, registrationDate=2019-06-10 00:00:00.0, customerId=20590, isChecked=false, cicles=0, customerStatus=P, lastUpdateDate=2019-06-10 00:00:00.0, dsgnrId=d13c0a3a-6fb5-4b13-b6b8-5ab26b42ef43, officeId=null
			StringBuilder customers= new StringBuilder();
			item = arg0.getEntity(TransferRequest.ENTITY_NAME);
			lista = arg0.getEntityList(CustomerTransferRequest.ENTITY_NAME);
			for (Object entidad : lista.toArray()) {
				
				if (((DataEntity)entidad).get(CustomerTransferRequest.ISCHECKED)) {
					customers.append(((DataEntity)entidad).get(CustomerTransferRequest.CUSTOMERID).toString());
					customers.append(",");
				}
			}
					
			customers.deleteCharAt(customers.length()-1);
			TransferManager transferManager = new TransferManager(this.getServiceIntegration());
			transferManager.createRequestTransfer(item.get(TransferRequest.OFFICEORIGINID),
					item.get(TransferRequest.OFFICIALORIGINID), item.get(TransferRequest.ISGROUP),
					item.get(TransferRequest.OFFICEDESTINATIONID), item.get(TransferRequest.OFFICIALDESTINATIONID),
					item.get(TransferRequest.IDCAUSE), customers.toString(), item.get(TransferRequest.DESCRIPTIONCAUSE), arg1);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_ADDRESS, e, arg1, LOGGER);
		}
	}

}
