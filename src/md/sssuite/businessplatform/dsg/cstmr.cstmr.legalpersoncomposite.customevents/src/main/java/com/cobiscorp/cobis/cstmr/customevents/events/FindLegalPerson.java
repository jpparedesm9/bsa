package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CompanyRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CompanyResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.EconomicInformationLegalPerson;
import com.cobiscorp.cobis.cstmr.model.LegalPerson;
import com.cobiscorp.cobis.cstmr.model.LegalRepresentative;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.LegalPersonManager;

public class FindLegalPerson extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory
			.getLogger(FindLegalPerson.class);

	public FindLegalPerson(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs arg1) {
		LOGGER.logDebug("ejecuta executeCommand en el servidor>>");
		try {
			DataEntity legalPerson = entities
					.getEntity(LegalPerson.ENTITY_NAME);
			 DataEntity legalRepresentative=entities.getEntity(LegalRepresentative.ENTITY_NAME);
			DataEntity
			 economicInformation=entities.getEntity(EconomicInformationLegalPerson.ENTITY_NAME);
			
			int companyCode = legalPerson.get(LegalPerson.PERSONSECUENTIAL);
			CompanyRequest companyRequest = new CompanyRequest();
			companyRequest.setIdCompany(companyCode);
			companyRequest.setOperation("Q");
			
			
			LegalPersonManager legalPersonManager = new LegalPersonManager(
					getServiceIntegration());

			CompanyResponse companyResponse=legalPersonManager.findLegalPerson(companyRequest, arg1);
			LOGGER.logDebug("retorna la compania>>"+companyResponse);
			legalPerson.set(LegalPerson.DOCUMENTTYPE, companyResponse.getNitType());
			legalPerson.set(LegalPerson.DOCUMENTTYPEDESCRIPTION, companyResponse.getNitTypeDescription());
			legalPerson.set(LegalPerson.DOCUMENTNUMBER, companyResponse.getNit());
			LOGGER.logDebug("BUSINESS NAME>>"+companyResponse.getBusinessName());
			LOGGER.logDebug("NAME>>"+companyResponse.getName());
			
			legalPerson.set(LegalPerson.BUSINESSNAME, companyResponse.getBusinessName());
			legalPerson.set(LegalPerson.TRADENAME, companyResponse.getName());
			//el sp no devuelve
			LOGGER.logDebug("ACRONYM>>"+companyResponse.getAcronym());
			legalPerson.set(LegalPerson.ACRONYM, companyResponse.getAcronym());
			
			legalPerson.set(LegalPerson.CONSTITUTIONPLACECODE, companyResponse.getCountry());
			LOGGER.logDebug("CONSTITUTIONPLACECODE>>"+companyResponse.getCountry());
			LOGGER.logDebug("COVERAGE>>"+companyResponse.getCoverage());
			LOGGER.logDebug("SEGMENT>>"+companyResponse.getSegment());
			LOGGER.logDebug("LEGAL PERSON TYPE>>"+companyResponse.getLegalPersonType());
			
			legalPerson.set(LegalPerson.COVERAGECODE, companyResponse.getCoverage());
			
			legalPerson.set(LegalPerson.SEGMENTCODE,companyResponse.getSegment());
			legalPerson.set(LegalPerson.LEGALPERSONTYPECODE,companyResponse.getLegalPersonType());
			legalPerson.set(LegalPerson.DOCUMENTNUMBER,companyResponse.getRuc());
			legalPerson.set(LegalPerson.DOCUMENTTYPE,companyResponse.getNitType());
			legalPerson.set(LegalPerson.DOCUMENTTYPEDESCRIPTION,companyResponse.getNitTypeDescription());
			
			
					
			String date=companyResponse.getEffectiveDate();
			SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yy");
	
			LOGGER.logDebug("SIPLA>>"+companyResponse.getSipla());
			LOGGER.logDebug("VALIDATED DOC>>"+companyResponse.getValidatedDoc());
			
			legalPerson.set(LegalPerson.SIPLA, companyResponse.getSipla());
			legalPerson.set(LegalPerson.VALIDATEDDOC, companyResponse.getValidatedDoc());

			//TODO: Convertir la fecha
			LOGGER.logDebug("FECHA DE VIGENCIA>>"+companyResponse.getEffectiveDate());
			if(date!=null){
				legalRepresentative.set(LegalRepresentative.EFFECTIVEDATE, sdf.parse(date));
			}else{
				legalRepresentative.set(LegalRepresentative.EFFECTIVEDATE,null);		
			}
			legalRepresentative.set(LegalRepresentative.LEGALREPRESENTATIVECODE, companyResponse.getLegalRepresentative());
			legalRepresentative.set(LegalRepresentative.LEGALREPRESENTATIVEDESCRIPTION, companyResponse.getLegalRepresentativeName());
			LOGGER.logDebug("NOMBRE REPRESENTANTE>>"+companyResponse.getLegalRepresentativeName());
			
			LOGGER.logDebug("LEGAL REPRESENTATIVE>>"+companyResponse.getLegalRepresentative());
			
			legalRepresentative.set(LegalRepresentative.NOTARY,companyResponse.getNotary());
			legalRepresentative.set(LegalRepresentative.NOTARYOFFICE, companyResponse.getNotaryOffice());
			LOGGER.logDebug("UNDEFINED>>"+companyResponse.getUndefinedEffectiveDate());
			boolean undefinedDate=(companyResponse.getUndefinedEffectiveDate()=='S')?true:false;
			legalRepresentative.set(LegalRepresentative.UNDEFINEDEFFECTIVEDATE, undefinedDate);
			
			economicInformation.set(EconomicInformationLegalPerson.COMMENT, companyResponse.getComment());
			economicInformation.set(EconomicInformationLegalPerson.EXPENSES, companyResponse.getExpenses());
			economicInformation.set(EconomicInformationLegalPerson.NETWORTH, companyResponse.getNetWorth());
			economicInformation.set(EconomicInformationLegalPerson.NUMBEROFEMPLOYESS, companyResponse.getNumberOfEmployees());
			LOGGER.logDebug("RELATION TYPE>>"+companyResponse.getRelationType());
			
			economicInformation.set(EconomicInformationLegalPerson.RELATION, companyResponse.getRelationType());
			boolean retention=companyResponse.getRetentionTax()=='S'?true:false;
			economicInformation.set(EconomicInformationLegalPerson.RETENTIONTAX, retention);
			economicInformation.set(EconomicInformationLegalPerson.REVENUES, companyResponse.getRevenues());
			economicInformation.set(EconomicInformationLegalPerson.TOTALCAPITAL, companyResponse.getTotalCapital());

		} catch (BusinessException e) {
			arg1.setSuccess(false);
			LOGGER.logError(e.getMessage(),e);
			throw e;
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos",e);
		}

	}
}
