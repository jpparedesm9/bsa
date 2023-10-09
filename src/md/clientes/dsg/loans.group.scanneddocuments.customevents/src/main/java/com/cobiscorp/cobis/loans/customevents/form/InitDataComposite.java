package com.cobiscorp.cobis.loans.customevents.form;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.GroupManager;
import com.cobiscorp.cobis.loans.customevents.events.SearchMember;
import com.cobiscorp.cobis.loans.model.Credit;
//import com.cobiscorp.cobis.loans.customevents.events.CreateGroup;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.OfficerManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class InitDataComposite extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(InitDataComposite.class);

	public InitDataComposite(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("-----> InitDataGroupScannedDocuments");

		DataEntity groupEntity = entities.getEntity(Group.ENTITY_NAME);
		if (groupEntity.get(Group.USERNAME) != null) {
			LOGGER.logDebug("-----> usuario " + groupEntity.get(Group.USERNAME));
		} else {
			LOGGER.logDebug("-----> usuario vacio");
		}
		OfficerManagement officeMngt = new OfficerManagement(getServiceIntegration());
		OfficerResponse officeResponseDTO = null;

		try {
			officeResponseDTO=officeMngt.getOfficerByLogin(groupEntity.get(Group.USERNAME), args);
			if (officeResponseDTO != null && officeResponseDTO.getOfficerId() != null) {
				groupEntity.set(Group.USERNAME, officeResponseDTO.getOfficerName());
				groupEntity.set(Group.OFFICER, officeResponseDTO.getOfficerId());
				
				entities.setEntity(Group.ENTITY_NAME, groupEntity);
			}

			/*---------Nuevos Campos de Cabecera-------------------*/
			// mapeo atributos de Entrada (tipo de dato - nombre)
			DataEntity group = entities.getEntity(Group.ENTITY_NAME);
			DataEntity credit = entities.getEntity(Credit.ENTITY_NAME);
			DataEntityList members = entities.getEntityList(Member.ENTITY_NAME);
			LOGGER.logDebug("credit --->" + credit);
						int applicationNumber = credit.get(Credit.APPLICATIONNUMBER) == null ? 0 : credit.get(Credit.APPLICATIONNUMBER);

			if (applicationNumber != 0) {
				LOGGER.logDebug("---->Recupera el numero del tramite");
							TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
							BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
							ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, args, new BehaviorOption(true));
				if (processedNumber == null) {
								MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
					return;
				}

				LOGGER.logDebug("---->Recupera el numero del tramite");
				int codigoTramite = processedNumber.getTramite();
				credit.set(Credit.CREDITCODE, codigoTramite);
							LOGGER.logDebug("codigoTramite: "+credit.get(Credit.CREDITCODE));

				if (codigoTramite != 0) {
					LOGGER.logDebug("---->Recupera los datos del tramite");
								ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, args, new BehaviorOption(true));

					if (creditApplication != null) {
						            credit.set(Credit.OFFICENAME, creditApplication.getOfficeDescriptionTr());
									credit.set(Credit.OPERATIONNUMBER, creditApplication.getOperationNumber());
									LOGGER.logDebug("OPERATIONNUMBER: "+credit.get(Credit.OPERATIONNUMBER));
									credit.set(Credit.OFFICE, creditApplication.getOffice() == null ? null : String.valueOf(creditApplication.getOffice()));
									LOGGER.logDebug("OFFICE: "+credit.get(Credit.OFFICE));
						credit.set(Credit.TERM, creditApplication.getTerm());
									LOGGER.logDebug("TERM: "+credit.get(Credit.TERM));
									credit.set(Credit.AMOUNTREQUESTED, creditApplication.getSumRequestedAmountGroup() == null ? null : creditApplication
											.getSumRequestedAmountGroup().doubleValue());
									LOGGER.logDebug("AMOUNTREQUESTED: "+credit.get(Credit.AMOUNTREQUESTED));
									credit.set(Credit.APPROVEDAMOUNT, creditApplication.getSumAmountGroup() == null ? null : creditApplication.getSumAmountGroup()
										.doubleValue());
									LOGGER.logDebug("APPROVEDAMOUNT: "+credit.get(Credit.APPROVEDAMOUNT));

									String clienteVinculado = creditApplication.getLinkedClient() + "";
						if (clienteVinculado.equalsIgnoreCase("S"))
							credit.set(Credit.LINKED, "Si");
						else
							credit.set(Credit.LINKED, "No");
					}

					LOGGER.logDebug("---->Recupero los parametros de categoria");
								List<GeneralParametersValuesHistory> categoryCatalog = bankingProductManager.getCatalogGeneralParameter(args,
									credit.get(Credit.PRODUCTTYPE), "Categoría");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : categoryCatalog) {
									credit.set(Credit.CATEGORY, generalParametersValuesHistory.getDescription());
					}

								List<GeneralParametersValuesHistory> frecuencyCatalog = bankingProductManager.getCatalogGeneralParameter(args,
										credit.get(Credit.PRODUCTTYPE), "Tipo de cuota");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : frecuencyCatalog) {
									credit.set(Credit.PAYMENTFRECUENCY, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de tipo");
								List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args,
									credit.get(Credit.PRODUCTTYPE), "Tipo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
									credit.set(Credit.SUBTYPE, generalParametersValuesHistory.getDescription());
					}

				}
			}
			LOGGER.logDebug("Data entity -->group: " + group);
			// Llamada y seteo DTO entrada
			// No todos los eventos reciben las entidades. Ejemplo: Si es un
			// executeQuery se debe recuperar los filtros. Modificar de ser
			// necesario
			GroupRequest groupRequest = new GroupRequest();

			int groupCode = group.get(Group.CODE);
			groupRequest.setCode(groupCode);

						GroupManager groupManager = new GroupManager(getServiceIntegration());
			GroupResponse groupResponse;
						LOGGER.logDebug("SearchGroup serviceIntegration " + getServiceIntegration());
			LOGGER.logDebug(" Llama al servicio SearchGroup-->: ");
			groupResponse = groupManager.searchGroup(groupRequest, args);

						group.set(Group.CONSTITUTIONDATE, groupResponse.getConstitutionDate().getTime());
						group.set(Group.CYCLENUMBER, Integer.parseInt(groupResponse.getCycleNumber()));
			group.set(Group.DAY, groupResponse.getDay());
			group.set(Group.MEETINGADDRESS, groupResponse.getMeetingAddress());
			group.set(Group.NAMEGROUP, groupResponse.getNameGroup());
						group.set(Group.NEXTVISITDATE, groupResponse.getNextVisitDate().getTime());
			group.set(Group.OFFICER, groupResponse.getOfficer());
			group.set(Group.PAYMENT, String.valueOf(groupResponse.getPayment()));
			group.set(Group.STATE, groupResponse.getState());
			group.set(Group.TIME, groupResponse.getTime().getTime());
			group.set(Group.GROUPACCOUNT, groupResponse.getGroupAccount());
			group.set(Group.GROUPOFFICE, groupResponse.getGroupOffice());
						LOGGER.logDebug("cuenta grupal -->: " + group.get(Group.GROUPACCOUNT));
			LOGGER.logDebug("oficina -->: " + group.get(Group.GROUPOFFICE));
			if (groupResponse.getMeetingPlaceGroup() != null) {
				if (groupResponse.getMeetingPlaceGroup().trim() != null) {
								if (groupResponse.getMeetingPlaceGroup().trim().equals("OT")) {
						group.set(Group.OTHERPLACE, true);
					} else {
									if (groupResponse.getMeetingPlaceGroup().trim().equals("DT")) {
							group.set(Group.ADDRESSMEMBER, true);
						}
					}
				}
			}
			LOGGER.logDebug("");
			if (groupResponse.getHasGroupAccount() != null) {
				if (groupResponse.getHasGroupAccount().equals("S")) {
					group.set(Group.HASGROUPACCOUNT, true);
								group.set(Group.TITULAR1NAME, groupResponse.getTitular1Name());
								group.set(Group.TITULAR2NAME, groupResponse.getTitular2Name());
								group.set(Group.TITULARCLIENT1, groupResponse.getTitular1Code());
								group.set(Group.TITULARCLIENT2, groupResponse.getTitular2Code());
				} else if (groupResponse.getHasGroupAccount().equals("N")) {
					group.set(Group.HASGROUPACCOUNT, false);
				}
			}
						group.set(Group.HASINDIVIDUALACCOUNT, ("S".equals(groupResponse.getHasIndividualAccount()) ? true : false));

		} catch (Exception e) {
			ExceptionUtils.showError(
					ExceptionMessage.Clients.INIT_DATA_COMPOSITE, e, args,
					LOGGER);
		}

	}

}
