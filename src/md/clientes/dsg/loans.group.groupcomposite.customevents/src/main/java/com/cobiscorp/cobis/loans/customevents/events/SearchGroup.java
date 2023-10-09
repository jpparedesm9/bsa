package com.cobiscorp.cobis.loans.customevents.events;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.AmountManager;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.GroupManager;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.QueryBureau;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.QueryRules;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.QuerySantander;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.Constants;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.cobis.loans.model.Context;
import com.cobiscorp.cobis.loans.model.Credit;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponseRenovation;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class SearchGroup extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchGroup.class);
	private static final Object RENOVATION_MODE = "R";

	public SearchGroup(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("Ingreso executeCommand SearchGroup");
		LOGGER.logDebug("entra");

		try {

			// mapeo atributos de Entrada (tipo de dato - nombre)
			DataEntity group = entities.getEntity(Group.ENTITY_NAME);
			DataEntity credit = entities.getEntity(Credit.ENTITY_NAME);
			LOGGER.logDebug("credit --->" + credit);
			int applicationNumber = credit.get(Credit.APPLICATIONNUMBER) == null ? 0 : credit.get(Credit.APPLICATIONNUMBER);
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "ESTVIG", "CLI", args, new BehaviorOption(false, false));
			String paramStateVig = "V";

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

				if (codigoTramite != 0) {
					LOGGER.logDebug("---->Recupera los datos del tramite");
					ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, args, new BehaviorOption(true));

					if (creditApplication != null) {
						credit.set(Credit.OPERATIONNUMBER, creditApplication.getOperationNumber());
						credit.set(Credit.OFFICE, creditApplication.getOffice() == null ? null : String.valueOf(creditApplication.getOffice()));
						credit.set(Credit.TERM, creditApplication.getTerm());

						credit.set(Credit.AMOUNTREQUESTED,
								creditApplication.getSumRequestedAmountGroup() == null ? null : creditApplication.getSumRequestedAmountGroup().doubleValue());
						credit.set(Credit.APPROVEDAMOUNT, creditApplication.getSumAmountGroup() == null ? null : creditApplication.getSumAmountGroup().doubleValue());

						String clienteVinculado = creditApplication.getLinkedClient() + "";
						if (clienteVinculado.equalsIgnoreCase("S"))
							credit.set(Credit.LINKED, "Si");
						else
							credit.set(Credit.LINKED, "No");

						credit.set(Credit.PERCENTAGEWARRANTY, creditApplication.getPercentageGuarantee());
						credit.set(Credit.OFFICENAME, creditApplication.getOfficeDescriptionTr());
					}

					LOGGER.logDebug("---->Recupero los parametros de categoria");
					List<GeneralParametersValuesHistory> categoryCatalog = bankingProductManager.getCatalogGeneralParameter(args, credit.get(Credit.PRODUCTTYPE), "Categoría");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : categoryCatalog) {
						credit.set(Credit.CATEGORY, generalParametersValuesHistory.getDescription());
					}

					List<GeneralParametersValuesHistory> frecuencyCatalog = bankingProductManager.getCatalogGeneralParameter(args, credit.get(Credit.PRODUCTTYPE), "Tipo de cuota");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : frecuencyCatalog) {
						credit.set(Credit.PAYMENTFRECUENCY, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de tipo");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, credit.get(Credit.PRODUCTTYPE), "Tipo");
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
			group.set(Group.UPDATEGROUP, groupResponse.getUpdateGroup());
			LOGGER.logDebug(" Actualiza el SearchGroup >>> " + groupResponse.getUpdateGroup());

			if (parameterDto != null) {
				if (parameterDto.getParameterValue() != null) {
					paramStateVig = parameterDto.getParameterValue().trim();
				}
			}

			if (groupResponse.getState() != null) {
				group.set(Group.STATE, groupResponse.getState());
			} else {
				group.set(Group.STATE, paramStateVig);
			}

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

			LOGGER.logDebug("Group.HASLIQUIDGAR -->: " + Group.HASLIQUIDGAR);

			group.set(Group.HASLIQUIDGAR, groupResponse.getHasGarLiquid().charAt(0));

			LOGGER.logDebug("CODIGO DEL CLIENTE SEARCHGROUP -->: " + credit.get(Credit.CREDITCODE));
			if (credit.get(Credit.CREDITCODE) != null) { // REVISAR LUEGO QUE PASE LA VARIABLE DEL WORKFLOW
				LOGGER.logDebug("Entro a la busqueda de montos--> ");
				searchAmount(entities, args);
				LOGGER.logDebug("Busca montos de credito -->: ");

				if (RENOVATION_MODE.equals(credit.get(Credit.ISRENOVATION))) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("INGRESA A BUSCAR MONTOS PARA RENOVACION");
					}
					searchAmountsRenovation(entities, args);
				}
			} else {
				LOGGER.logDebug("No ingreso a montos -->: ");
			}

			LOGGER.logDebug("--------------->>> Inicia busqueda de Miembros");
			SearchMember searchMember = new SearchMember();
			searchMember.searhMemberList(entities, args, getServiceIntegration());

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_GROUP, e, args, LOGGER);
		}
	}

	public void searchAmount(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("Ingreso executeCommand SearchAmount");

		try {
			GroupLoanAmountRequest serviceRequest = new GroupLoanAmountRequest();
			// DataEntity amountEntity = entities.getEntity(Amount.ENTITY_NAME);
			DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);

			// int amountCustomerId = amountEntity.get(Amount.MEMBERID);
			// serviceRequest.setSolicitude(amountEntity.get(Amount.CREDIT));
			serviceRequest.setSolicitude(creditEntity.get(Credit.CREDITCODE));
			LOGGER.logDebug("codigo del credito Amount-->" + creditEntity.get(Credit.CREDITCODE));
			serviceRequest.setGroupId(creditEntity.get(Credit.CUSTOMERID));
			LOGGER.logDebug("codigo del grupo Amount -->" + creditEntity.get(Credit.CUSTOMERID));

			AmountManager amountManager = new AmountManager(getServiceIntegration());
			// DataEntityList amounts = entities.getEntityList(Amount.ENTITY_NAME);

			LOGGER.logDebug(" Llama al servicio CalcAmount : ");

			// amountManager.calcAmount(serviceRequest, args);// comentado por que cada vez
			// que se recarga la pantalla
			// en la etapa de ingreso de datos se vuelve a calcular los montos

			LOGGER.logDebug(" Llama al servicio SearchAmount");
			GroupLoanAmountResponse responseAmountList[] = amountManager.searchAmount(serviceRequest, args);

			DataEntityList amountListEntity = new DataEntityList();
			int indice = 0;

			if (responseAmountList != null) {
				for (GroupLoanAmountResponse amount : responseAmountList) {
					DataEntity amountEntity = new DataEntity();
					LOGGER.logDebug(" Recuperando data SearchAmount-->: ");
					indice += 1;
					amountEntity.set(Amount.SECUENTIAL, indice);
					amountEntity.set(Amount.MEMBERID, amount.getCustomerId());
					amountEntity.set(Amount.MEMBERNAME, amount.getCustumerName());

					if (amount.getAuthorizedAmount() != null) {
						amountEntity.set(Amount.AMOUNT, new BigDecimal(amount.getAuthorizedAmount()));
					} else {
						amountEntity.set(Amount.AMOUNT, new BigDecimal(0));
					}

					if (amount.getAmount() != null) {
						amountEntity.set(Amount.AUTHORIZEDAMOUNT, new BigDecimal(amount.getAmount()));
					} else {
						amountEntity.set(Amount.AUTHORIZEDAMOUNT, new BigDecimal(0));
					}

					amountEntity.set(Amount.CREDIT, creditEntity.get(Credit.CREDITCODE));
					amountEntity.set(Amount.CYCLEPARTICIPATION, amount.getCycleParticipation());

					if (amount.getVoluntarySavings() != null) {
						amountEntity.set(Amount.VOLUNTARYSAVINGS, new BigDecimal(amount.getVoluntarySavings()));
					} else {
						amountEntity.set(Amount.VOLUNTARYSAVINGS, new BigDecimal(0));
					}

					if (amount.getProposedMaximumSaving() != null) {
						amountEntity.set(Amount.PROPOSEDMAXIMUMSAVING, new BigDecimal(amount.getProposedMaximumSaving()));
					} else {
						amountEntity.set(Amount.PROPOSEDMAXIMUMSAVING, new BigDecimal(0));
					}
					if (amount.getIncrement() != null) {
						amountEntity.set(Amount.INCREMENT, new BigDecimal(amount.getIncrement()));
						LOGGER.logDebug("INGRESO AL INCREMENTO");
					} else {
						amountEntity.set(Amount.INCREMENT, new BigDecimal(0));
					}

					LOGGER.logDebug(amount.getCheckRenapo());
					amountEntity.set(Amount.CHECKRENAPO, amount.getCheckRenapo());
					amountEntity.set(Amount.SAFEPACKAGE,
							(amount.getSafePackage() != null && !"".equals(amount.getSafePackage().trim()) ? amount.getSafePackage().trim() : "BASICO"));
					LOGGER.logDebug("PAQUETE " + amount.getSafePackage());

					amountEntity.set(Amount.OLDBALANCE, null);
					amountEntity.set(Amount.OLDOPERATION, null);
					amountEntity.set(Amount.RESULTAMOUNT, null);

					amountListEntity.add(amountEntity);
				}
				LOGGER.logDebug("Mapeando entidad designer SearchAmount SIZE-->: " + amountListEntity.size());
				entities.setEntityList(Amount.ENTITY_NAME, amountListEntity);
				queryBureau(entities, args);
				// Se comenta para no ejecutar altair en la busqueda de grupos
				// querySantander(entities, args); //Carga la informacion del cliente Santander
				queryRulesExecute(entities, args); // Carga la informacion de la regla

			}

		} catch (Exception e) {
			LOGGER.logError("Exception", e);
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_AMOUNT, e, args, LOGGER);
		}
	}

	private void searchAmountsRenovation(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logInfo("INGRESA MONTOS PARA RENOVACION");
		GroupLoanAmountRequest serviceRequest = new GroupLoanAmountRequest();
		try {
			DataEntity creditEntity = entities.getEntity(Credit.ENTITY_NAME);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("codigo del credito Amount-->" + creditEntity.get(Credit.CREDITCODE));
				LOGGER.logDebug("codigo del grupo Amount -->" + creditEntity.get(Credit.CUSTOMERID));
			}
			serviceRequest.setSolicitude(creditEntity.get(Credit.CREDITCODE));
			serviceRequest.setGroupId(creditEntity.get(Credit.CUSTOMERID));

			AmountManager amountManager = new AmountManager(getServiceIntegration());
			MemberResponseRenovation responseRenovationList[] = amountManager.searchAmountRenovation(serviceRequest, args);

			DataEntityList amountListEntity = entities.getEntityList(Amount.ENTITY_NAME);

			for (DataEntity amountMember : amountListEntity) {
				for (MemberResponseRenovation amountMemberRenovation : responseRenovationList) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("OPERACION ANTERIOR: " + amountMemberRenovation.getOperationId() + "-" + amountMemberRenovation.getBankId());
						LOGGER.logDebug("SALDO ANTERIOR: " + amountMemberRenovation.getBalance());
						LOGGER.logDebug("CLIENTE: " + amountMemberRenovation.getCustomer());
					}
					if (amountMember.get(Amount.MEMBERID).equals(amountMemberRenovation.getCustomer())) {
						if (LOGGER.isDebugEnabled()) {
							LOGGER.logDebug("INICIA SETEO DE MONTOS PARA RENOVACION");
						}
						amountMember.set(Amount.OLDBALANCE, amountMemberRenovation.getBalance());
						amountMember.set(Amount.OLDOPERATION, amountMemberRenovation.getBankId());
						amountMember.set(Amount.RESULTAMOUNT, amountMember.get(Amount.AMOUNT).subtract(amountMember.get(Amount.OLDBALANCE)));
						if (amountMemberRenovation.getIncrement() != null) {
							amountMember.set(Amount.INCREMENT, new BigDecimal(amountMemberRenovation.getIncrement()));
						} else {
							amountMember.set(Amount.INCREMENT, new BigDecimal(0));
						}
					}

				}
			}
		} catch (Exception e) {
			LOGGER.logError("ERROR AL OBTENER MONTOS DE RENOVACION", e);
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_AMOUNT, e, args, LOGGER);
		} finally {
			LOGGER.logInfo("Finaliza searchAmountsRenovation");
		}

	}

	public void queryBureau(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeCommand QueryBureau");
		}

		try {
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "RENAPO", "CLI", args, new BehaviorOption(false, false));
			String renapo = Constants.RENAPO_INACTIVE;
			if (parameterDto != null && parameterDto.getParameterValue() != null) {
				renapo = parameterDto.getParameterValue().trim();
			}
			QueryBureau queryBureau = new QueryBureau(this.getServiceIntegration());

			DataEntity groupEntity = entities.getEntity(Group.ENTITY_NAME);
			DataEntity contextEntity = entities.getEntity(Context.ENTITY_NAME);
			DataEntityList amountEntityList = entities.getEntityList(Amount.ENTITY_NAME);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("GroupId " + groupEntity.get(Group.CODE));
			}

			Integer channel = contextEntity.get(Context.CHANNEL);
			List<CustomerDto> clientIds = new ArrayList<CustomerDto>();

			for (DataEntity d : amountEntityList) {
				LOGGER.logDebug(d.get(Amount.CHECKRENAPO));
				clientIds.add(new CustomerDto(d.get(Amount.MEMBERID), d.get(Amount.MEMBERNAME), d.get(Amount.CHECKRENAPO)));
			}

			DataEntity credit = entities.getEntity(Credit.ENTITY_NAME);
			int instProc = credit.get(Credit.APPLICATIONNUMBER);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("SearchGroup>>queryBureau>>instProc: " + instProc);
			}
			
			List<BuroExecutionResponse> buroExecutionResponseList = queryBureau.excuteQueryBureauForGroup(groupEntity.get(Group.CODE), clientIds, renapo, instProc, channel);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("buroExecutionResponseList " + buroExecutionResponseList);
			}

			boolean found = false;

			if (buroExecutionResponseList != null) {
				found = false;
				for (DataEntity d : amountEntityList) {
					LOGGER.logError("--->>>>>>>----->>>>");
					LOGGER.logError("--->>>>>>>d.get(Amount.MEMBERID):" + d.get(Amount.MEMBERID));
					for (BuroExecutionResponse br : buroExecutionResponseList) {
						LOGGER.logError("--->>>>>>>br.getClientId():" + br.getClientId());
						if (d.get(Amount.MEMBERID).equals(br.getClientId())) {
							// d.set(Amount.CREDITBUREAU, String.valueOf(br.getRiskScore()));
							d.set(Amount.RISKLEVEL, br.getRuleExecutionResult());
							found = true;
							break;
						}
					}
					if (!found) {
						d.set(Amount.CREDITBUREAU, "Error");
						d.set(Amount.RISKLEVEL, "");
					}
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_BURO, e, args, LOGGER);
		}
	}

	public void querySantander(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeCommand QuerySatander");
		}

		QuerySantander querySantander = new QuerySantander(this.getServiceIntegration());

		List<Integer> clientIds = new ArrayList<Integer>();

		DataEntity groupEntity = entities.getEntity(Group.ENTITY_NAME);
		DataEntityList amountEntityList = entities.getEntityList(Amount.ENTITY_NAME);

		for (DataEntity d : amountEntityList) {
			clientIds.add(d.get(Amount.MEMBERID));
		}

		querySantander.executeQuerySantanderForGroup(groupEntity.get(Group.CODE), clientIds);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto querySantander");
		}

	}

	public void queryRulesExecute(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeCommand queryRulesExecute");
		}

		QueryRules queryRules = new QueryRules(this.getServiceIntegration());

		List<Integer> clientIds = new ArrayList<Integer>();

		DataEntity groupEntity = entities.getEntity(Group.ENTITY_NAME);
		DataEntityList amountEntityList = entities.getEntityList(Amount.ENTITY_NAME);

		for (DataEntity d : amountEntityList) {
			clientIds.add(d.get(Amount.MEMBERID));
		}

		queryRules.executeQueryRules(groupEntity.get(Group.CODE), clientIds);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto queryRulesExecute");
		}

	}
}
