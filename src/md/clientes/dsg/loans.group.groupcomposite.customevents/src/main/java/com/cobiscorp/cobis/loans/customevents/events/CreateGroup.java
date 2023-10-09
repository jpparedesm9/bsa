package com.cobiscorp.cobis.loans.customevents.events;

import java.util.Calendar;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.GroupManager;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.Constants;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.BiometricManager;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class CreateGroup extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(CreateGroup.class);

	public CreateGroup(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		String INFO = "CreateGroup - executeCommand -->> ";
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand in CreateGroup class");
			LOGGER.logDebug(INFO + "entities: " + entities + " -->> args: " + args);
		}
		
		try {
			// mapeo atributos de Entrada (tipo de dato - nombre)
			DataEntity group = entities.getEntity(Group.ENTITY_NAME);
			DataEntityList members = entities.getEntityList(Member.ENTITY_NAME);
			DataEntityList membersModified = new DataEntityList();
			LOGGER.logDebug(INFO + "Data entity -->group: " + group);
			LOGGER.logDebug(INFO + "Data entity -->members: " + members);

			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "RENAPO", "CLI", args, new BehaviorOption(false, false));
			String parametro = parameterDto.getParameterValue().toString();

			ParameterResponse actRENAPOQueryByCurp = catalogManagement.getParameter(4, "ACRXCR", "CLI", args, new BehaviorOption(false, false));
			String pActRENAPOQueryByCurp = actRENAPOQueryByCurp.getParameterValue().toString();
			
			/* Consultar Renapo para clientes faltantes */
			if (members != null) {
				for (DataEntity entity : members) {

					/* Obtener cliente */
					BiometricManager biometricManager = new BiometricManager(getServiceIntegration());

					int personCode = entity.get(Member.CUSTOMERID);
					/* Consultar Cliente */
					CustomerRequest customerRequest = new CustomerRequest();
					customerRequest.setOperation('M');
					customerRequest.setFormatDate(103);
					customerRequest.setCustomerId(personCode);

					MemberManager memberManager = new MemberManager(getServiceIntegration());
					CustomerResponse customerResponse = memberManager.queryMemberInformation(customerRequest, args);

					if (customerResponse != null) {
						if (Constants.RENAPO_ACTIVE.equals(parametro) && Constants.INACTIVE.equals(pActRENAPOQueryByCurp) && !Constants.RENAPO_VALIDATED.equals(customerResponse.getCheckRenapo())) {

							StringBuilder name = new StringBuilder();
							name.append(customerResponse.getCustomerName());
							name.append(customerResponse.getCustomerSecondName() == null || customerResponse.getCustomerSecondName().trim().equals("") ? "" : " " + customerResponse.getCustomerSecondName());

							RenapoRequest renapoRequest = new RenapoRequest();
							renapoRequest.setName(name.toString());
							renapoRequest.setBirthDate((null != customerResponse.getCustomerBirthdate() && "" != customerResponse.getCustomerBirthdate()) ? customerResponse.getCustomerBirthdate() : null);
							renapoRequest.setBirthPlace(String.valueOf(customerResponse.getCountyOfBirth()));
							renapoRequest.setLastName(customerResponse.getCustomerLastName());
							renapoRequest.setSecondLastName(customerResponse.getCustomerSecondLastName());
							renapoRequest.setGender(customerResponse.getGenderCode());

							LOGGER.logDebug(INFO + "RenapoRequest [" + renapoRequest.toString() + "]");

							RenapoResponse renapoResponse = biometricManager.queryCurpFromRenapo(renapoRequest);
							String curp = renapoResponse.getCurp() == null || "".equals(renapoResponse.getCurp().trim()) ? customerResponse.getCustomerIdentificaction() : renapoResponse.getCurp().trim();
							String status = renapoResponse.getStatus() == null || "".equals(renapoResponse.getStatus().trim()) ? customerResponse.getCheckRenapo() : renapoResponse.getStatus().trim();

							if (!Constants.RENAPO_VALIDATED.equals(status)) {
								for (RenapoMessage message : renapoResponse.getMessages()) {
									args.getMessageManager().showErrorMsg(message.getMessage() + "- CLIENTE -" + name);
								}
							}
							CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
							customerTotalRequest.setMode(1);
							customerTotalRequest.setIdentification(curp);
							customerTotalRequest.setCheckRenapo(status);
							customerTotalRequest.setCodePerson(personCode);

							memberManager.updateMemberRenapo(customerTotalRequest, args, new BehaviorOption());
							entity.set(Member.CHECKRENAPO, status);

						} else {
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug(INFO + "El servicio de RENAPO se encuentra INACTIVO/ El Cliente ya se encuentra validado.");
						}
					} else {
						LOGGER.logDebug(INFO + "Error al consultar datos del cliente.");
					}
					membersModified.add(entity);
				}
				if (membersModified.size() == 0) {
					entities.setEntityList(Member.ENTITY_NAME, members);
				} else {
					entities.setEntityList(Member.ENTITY_NAME, membersModified);
				}
			} else {
				LOGGER.logDebug(INFO + "No se puede obtener los miembros ");
			}
			// Llamada y seteo DTO entrada
			// No todos los eventos reciben las entidades. Ejemplo: Si es un
			// executeQuery se debe recuperar los filtros. Modificar de ser
			// necesario
			GroupRequest groupRequest = new cobiscorp.ecobis.loangroup.dto.GroupRequest();
			groupRequest.setOperation(group.get(Group.OPERATION));
			groupRequest.setNameGroup(group.get(Group.NAMEGROUP));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(group.get(Group.CONSTITUTIONDATE));
			LOGGER.logDebug("Fecha de constitucion -->: " + group.get(Group.CONSTITUTIONDATE));

			groupRequest.setConstitutionDate(calendar);
			groupRequest.setState(group.get(Group.STATE));
			Calendar calendar2 = Calendar.getInstance();
			if (group.get(Group.NEXTVISITDATE) != null) {
				calendar2.setTime(group.get(Group.NEXTVISITDATE));
			}
			groupRequest.setNextVisitDate(calendar2);
			groupRequest.setOfficer(group.get(Group.OFFICER));
			if (group.get(Group.MEETINGADDRESS) != null) {
				groupRequest.setMeetingAddres(group.get(Group.MEETINGADDRESS));
				LOGGER.logDebug("SET Group.MEETINGADDRESS >>" + Group.OTHERPLACE);
			} else {
				groupRequest.setMeetingAddres(" ");
			}
			groupRequest.setDay(group.get(Group.DAY));
			Calendar calendar3 = Calendar.getInstance();
			calendar3.setTime(group.get(Group.TIME));
			groupRequest.setTime(calendar3);
			groupRequest.setGroupType("S");
			groupRequest.setGroupAccount(group.get(Group.GROUPACCOUNT));
			groupRequest.setGroupOffice(group.get(Group.GROUPOFFICE));
			LOGGER.logDebug("otherPlacePSfuera>>" + Group.OTHERPLACE);
			LOGGER.logDebug("otherPlacePSfuera1>>" + group.get(Group.OTHERPLACE));
			if (group.get(Group.OTHERPLACE) != null) {
				LOGGER.logDebug("otherPlacePS>>" + Group.OTHERPLACE);
				if (group.get(Group.OTHERPLACE) == true) {
					groupRequest.setMeetingPlaceGroup("OT");
					LOGGER.logDebug("otherPlacePS>>" + groupRequest.getMeetingPlaceGroup());
				}
			}

			if (group.get(Group.ADDRESSMEMBER) != null) {
				if (group.get(Group.ADDRESSMEMBER) == true) {
					groupRequest.setMeetingPlaceGroup("DT");
					LOGGER.logDebug("DirecINtePS>>" + groupRequest.getMeetingPlaceGroup());
				}
			}
			LOGGER.logDebug("HASGROUPACCOUNT>>" + group.get(Group.HASGROUPACCOUNT));
			if (group.get(Group.HASGROUPACCOUNT) != null) {
				if (group.get(Group.HASGROUPACCOUNT) == true) {
					groupRequest.setHasGroupAccount("S");
					if (group.get(Group.TITULARCLIENT1) != null) {
						groupRequest.setTitularClient1(group.get(Group.TITULARCLIENT1));
					}
					if (group.get(Group.TITULARCLIENT2) != null) {
						groupRequest.setTitularClient2(group.get(Group.TITULARCLIENT2));
					}
				} else {
					groupRequest.setHasGroupAccount("N");
				}
			}
			LOGGER.logDebug("IndividualAccount>>" + Group.HASINDIVIDUALACCOUNT);
			if (group.get(Group.HASINDIVIDUALACCOUNT) != null) {
				if (group.get(Group.HASINDIVIDUALACCOUNT) == true) {
					groupRequest.setHasIndividualAccount("S");
				} else {
					groupRequest.setHasIndividualAccount("N");
				}
			}
			if (group.get(Group.PAYMENT) == null) {
				groupRequest.setPayment(0);
			} else if (group.get(Group.PAYMENT) != null) {
				groupRequest.setPayment(Integer.parseInt(group.get(Group.PAYMENT)));
			}
			if (group.get(Group.CYCLENUMBER) == null) {
				groupRequest.setCycleNumber(0);
			} else if (group.get(Group.CYCLENUMBER) != null) {
				groupRequest.setCycleNumber(group.get(Group.CYCLENUMBER));
			}
			LOGGER.logDebug("Group.HASLIQUIDGAR--->" + Group.HASLIQUIDGAR);
			if (group.get(Group.HASLIQUIDGAR) != null) {
				groupRequest.setHasLiquidGar(group.get(Group.HASLIQUIDGAR).toString());
			}
			LOGGER.logDebug("HASLIQUIDGAR--->" + groupRequest.getHasLiquidGar());
			GroupManager groupManager = new GroupManager(getServiceIntegration());
			Integer idGrupo = null;
			LOGGER.logDebug(" group.get(Group.OPERATION) -->: " + group.get(Group.OPERATION));
			if (group.get(Group.OPERATION) == 'I') {
				LOGGER.logDebug(" Llama al servicio CreateGroup-->: ");
				LOGGER.logDebug("GroupType" + groupRequest.getGroupType());
				LOGGER.logDebug("GroupAccount" + groupRequest.getGroupAccount());
				LOGGER.logDebug("GroupOffice" + groupRequest.getGroupOffice());
				LOGGER.logDebug("TitularClient1" + groupRequest.getTitularClient1());
				LOGGER.logDebug("TitularClient2" + groupRequest.getTitularClient2());
				LOGGER.logDebug("Group.CODE -->: UpdateGroup" + Group.CODE);
				idGrupo = groupManager.createGroup(groupRequest, args);
				LOGGER.logDebug(" Llama idGrupo CreateGroup-->: " + idGrupo);

				if (idGrupo != null) {
					group.set(Group.CODE, idGrupo);
					LOGGER.logDebug("Group.CODE CreateGroup-->: " + Group.CODE);
				}
			} else if (group.get(Group.OPERATION) == 'U') {
				groupRequest.setCode(group.get(Group.CODE));
				LOGGER.logDebug("Ingresando a la Actualizacion");
				LOGGER.logDebug("GroupType" + groupRequest.getGroupType());
				LOGGER.logDebug("GroupAccount" + groupRequest.getGroupAccount());
				LOGGER.logDebug("GroupOffice" + groupRequest.getGroupOffice());
				LOGGER.logDebug("Group.CODE -->: UpdateGroup" + Group.CODE);

				LOGGER.logDebug(" Llama al servicio UpdateGroup-->: ");
				groupManager.updateGroup(groupRequest, args);
			}

		} catch (Exception e) {
			LOGGER.logError("Exception in CreateGroup class", e);
			ExceptionUtils.showError(ExceptionMessage.Clients.CREATE_GROUP, e, args, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish executeCommand in CreateGroup class");
			}
		}
	}
}
