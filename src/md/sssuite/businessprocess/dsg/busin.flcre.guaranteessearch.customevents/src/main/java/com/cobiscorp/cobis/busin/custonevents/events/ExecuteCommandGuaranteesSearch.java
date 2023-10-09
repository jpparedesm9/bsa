package com.cobiscorp.cobis.busin.custonevents.events;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import cobiscorp.ecobis.collateral.dto.CollateralRequest;
import cobiscorp.ecobis.collateral.dto.CollateralResponse;
import cobiscorp.ecobis.collateral.dto.CollateralResponseList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.view.VW_WRRNTSEACH85_ViewEvent;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.GuaranteeSearchCriteria;
import com.cobiscorp.cobis.busin.model.Guarantees;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandGuaranteesSearch extends BaseEvent implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory.getLogger(VW_WRRNTSEACH85_ViewEvent.class);

	public ExecuteCommandGuaranteesSearch(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public final static String INCOLLATERALREQUEST = "inCollateralRequest";
	public final static String OUTCOLLATERALRESPONSELIST = "outCollateralResponseList";
	public final static String SERVICESEARCHCOLLATERAL = "Collateral.CollateralQuery.SearchCollateral";
	public final static String RETURNCOLLATERALRESPONSE = "returnCollateralResponse";

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {		
		
		try{
			DataEntityList gauranteesList = new DataEntityList();
			DataEntity guaranteesCriterial = entities.getEntity(GuaranteeSearchCriteria.ENTITY_NAME);
			CollateralRequest collateralRequest = new CollateralRequest();
			CollateralResponseList collateralResponseList = new CollateralResponseList();
			collateralRequest.setSubsidiaryId(1);
			
			collateralRequest.setDateFormat(SessionContext.getFormatDate());
			if (guaranteesCriterial.get(GuaranteeSearchCriteria.OFFICE) != null && !"".equals(guaranteesCriterial.get(GuaranteeSearchCriteria.OFFICE))){
				collateralRequest.setOfficeId(Integer.parseInt(guaranteesCriterial.get(GuaranteeSearchCriteria.OFFICE)));	
			}
			
			//MODIFICACION SERVICIO BUSQUEDA DE GARANTIAS IYU
			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.AMOUNT))) {
				collateralRequest.setAmount(guaranteesCriterial.get(GuaranteeSearchCriteria.AMOUNT));
			}
			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.ADMISSIBILITY))) {
				collateralRequest.setAdmissibility(guaranteesCriterial.get(GuaranteeSearchCriteria.ADMISSIBILITY));
			}
			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.CHARACTER))) {
				collateralRequest.setCharacter(guaranteesCriterial.get(GuaranteeSearchCriteria.CHARACTER));
			}
			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.SHARED))) {
				collateralRequest.setShared(guaranteesCriterial.get(GuaranteeSearchCriteria.SHARED));
			}
			if (guaranteesCriterial.get(GuaranteeSearchCriteria.WARRANTYMONEY) != null ){
				collateralRequest.setWarrantyMoney(guaranteesCriterial.get(GuaranteeSearchCriteria.WARRANTYMONEY));
			}
			//
			if (guaranteesCriterial.get(GuaranteeSearchCriteria.GUARANTEETYPE) != null && !"".equals(guaranteesCriterial.get(GuaranteeSearchCriteria.GUARANTEETYPE))){
				collateralRequest.setType(guaranteesCriterial.get(GuaranteeSearchCriteria.GUARANTEETYPE));
			}

			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.OFFICER))) {
				collateralRequest.setOfficerId(Integer.parseInt(guaranteesCriterial.get(GuaranteeSearchCriteria.OFFICER)));
			}

			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.CUSTOMER))) {
				String[] partCustomer = guaranteesCriterial.get(GuaranteeSearchCriteria.CUSTOMER).split("-");
				collateralRequest.setCustomerId(Integer.parseInt(partCustomer[0]));
			}

			if (guaranteesCriterial.get(GuaranteeSearchCriteria.STATUSGUARANTEE) != null && !"".equals(guaranteesCriterial.get(GuaranteeSearchCriteria.STATUSGUARANTEE))){
				collateralRequest.setState(guaranteesCriterial.get(GuaranteeSearchCriteria.STATUSGUARANTEE));
			}

			if (guaranteesCriterial.get(GuaranteeSearchCriteria.STARTDATEADMISSION) != null) {
				Calendar startDateAdmission = Calendar.getInstance();
				startDateAdmission.setTime(guaranteesCriterial.get(GuaranteeSearchCriteria.STARTDATEADMISSION));
				collateralRequest.setAdmissionDateFrom(startDateAdmission);
			}

			if (guaranteesCriterial.get(GuaranteeSearchCriteria.ENDDATEADMISSION) != null) {
				Calendar endDateAdmission = Calendar.getInstance();
				endDateAdmission.setTime(guaranteesCriterial.get(GuaranteeSearchCriteria.ENDDATEADMISSION));
				collateralRequest.setAdmissionDateTo(endDateAdmission);
			}

			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.EXTERNALCODE))) {
				collateralRequest.setExternalCode2(guaranteesCriterial.get(GuaranteeSearchCriteria.EXTERNALCODE));
			}

			if (guaranteesCriterial.get(GuaranteeSearchCriteria.CORRELATIVEEND).equals(2)) {
				gauranteesList = entities.getEntityList(Guarantees.ENTITY_NAME);

				if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(guaranteesCriterial.get(GuaranteeSearchCriteria.EXTERNALCODENEXT))) {
					collateralRequest.setExternalCode(guaranteesCriterial.get(GuaranteeSearchCriteria.EXTERNALCODENEXT));
				}					
			}
			
			ServiceRequestTO serviceGauranteeRequestTO = new ServiceRequestTO();
			ServiceResponse serviceGauranteeResponse;
			ServiceResponseTO serviceGauranteeResponseTO = new ServiceResponseTO();

			serviceGauranteeRequestTO.addValue(INCOLLATERALREQUEST, collateralRequest);
			serviceGauranteeRequestTO.addValue(OUTCOLLATERALRESPONSELIST, collateralResponseList);

			serviceGauranteeResponse = execute(getServiceIntegration(), LOGGER, SERVICESEARCHCOLLATERAL, serviceGauranteeRequestTO);

			if (serviceGauranteeResponse.isResult()) {
				serviceGauranteeResponseTO = (ServiceResponseTO) serviceGauranteeResponse.getData();

				CollateralResponse[] CollateralResponses = (CollateralResponse[]) serviceGauranteeResponseTO.getValue(RETURNCOLLATERALRESPONSE);
				
				for (CollateralResponse collateralResponse : CollateralResponses) {
					DataEntity eCollateral = new DataEntity();

					// eCollateral.set(Guarantees.IDGUARANTEE, 1);
					if (collateralResponse.getExternalCode() != null) {
						eCollateral.set(Guarantees.GUARANTEECODE, collateralResponse.getExternalCode());
						guaranteesCriterial.set(GuaranteeSearchCriteria.EXTERNALCODENEXT, collateralResponse.getExternalCode());
					} else {
						eCollateral.set(Guarantees.GUARANTEECODE, "");
					}

					if (collateralResponse.getType() != null) {
						eCollateral.set(Guarantees.GUARANTEETYPE, collateralResponse.getType());
					} else {
						eCollateral.set(Guarantees.GUARANTEETYPE, "");
					}

					if (collateralResponse.getDescription() != null) {
						eCollateral.set(Guarantees.DESCRIPTION, collateralResponse.getDescription());
					} else {
						eCollateral.set(Guarantees.DESCRIPTION, "");
					}

					if (collateralResponse.getOpenClosed() != null) {
						eCollateral.set(Guarantees.CLOSEOPEN, collateralResponse.getOpenClosed());
					} else {
						eCollateral.set(Guarantees.CLOSEOPEN, "");
					}

					if (collateralResponse.getGuarantorId() != null) {
						eCollateral.set(Guarantees.GUARANTORID, collateralResponse.getGuarantorId());
					} else {
						eCollateral.set(Guarantees.GUARANTORID, 0);
					}

					if (collateralResponse.getCustomerId() != null) {
						eCollateral.set(Guarantees.CUSTOMERID, collateralResponse.getCustomerId());
					} else {
						eCollateral.set(Guarantees.CUSTOMERID, 0);
					}

					if (collateralResponse.getGuarantorName() != null) {
						eCollateral.set(Guarantees.GUARANTORNAME, collateralResponse.getGuarantorName());
					} else {
						eCollateral.set(Guarantees.GUARANTORNAME, "");
					}

					if (collateralResponse.getCustody() != null) {
						eCollateral.set(Guarantees.CUSTODY, collateralResponse.getCustody());
					} else {
						eCollateral.set(Guarantees.CUSTODY, 0);
					}

					if (collateralResponse.getSubsidiary() != null) {
						eCollateral.set(Guarantees.OFFICE, collateralResponse.getSubsidiary().toString());
					} else {
						eCollateral.set(Guarantees.OFFICE, "");
					}

					if (collateralResponse.getOffice() != null) {
						eCollateral.set(Guarantees.OFFICENAME, collateralResponse.getOffice());
					} else {
						eCollateral.set(Guarantees.OFFICENAME, "");
					}

					if (collateralResponse.getCurrency() != null) {
						eCollateral.set(Guarantees.CURRENCY, collateralResponse.getCurrency().toString());
					} else {
						eCollateral.set(Guarantees.CURRENCY, "0");
					}

					if (collateralResponse.getActualValue() != null) {
						eCollateral.set(Guarantees.CURRENTVALUE, new BigDecimal(collateralResponse.getActualValue()));
					} else {
						eCollateral.set(Guarantees.CURRENTVALUE, new BigDecimal(0));
					}

					if (collateralResponse.getInitialValue() != null) {
						eCollateral.set(Guarantees.INITIALVALUE, new BigDecimal(collateralResponse.getInitialValue()));
					} else {
						eCollateral.set(Guarantees.INITIALVALUE, new BigDecimal(0));
					}

					if (collateralResponse.getAvailable() != null) {
						eCollateral.set(Guarantees.VALUEAVAILABLE, new BigDecimal(collateralResponse.getAvailable()));
					} else {
						eCollateral.set(Guarantees.VALUEAVAILABLE, new BigDecimal(0));
					}

					if (collateralResponse.getAppraisedValueDate() != null) {
						eCollateral.set(Guarantees.APPRAISEDVALUEDATE, collateralResponse.getAppraisedValueDate());
					} else {
						eCollateral.set(Guarantees.APPRAISEDVALUEDATE, "");
					}

					if (collateralResponse.getExpiredWarranty() != null) {
						eCollateral.set(Guarantees.EXPIREDWARRANTY, collateralResponse.getExpiredWarranty());
					} else {
						eCollateral.set(Guarantees.EXPIREDWARRANTY, "");
					}

					if (collateralResponse.getState() != null) {
						eCollateral.set(Guarantees.STATUS, collateralResponse.getState());
					} else {
						eCollateral.set(Guarantees.STATUS, "");
					}

					if (collateralResponse.getUserCreates() != null) {
						eCollateral.set(Guarantees.USERCREATION, collateralResponse.getUserCreates());
					} else {
						eCollateral.set(Guarantees.USERCREATION, "");
					}

					// NTG Control de Cambios prelacion de la garantia
					eCollateral.set(Guarantees.RELATION, collateralResponse.getRelation());
					eCollateral.set(Guarantees.ISPERSONAL, collateralResponse.getIsPersonal());
					eCollateral.set(Guarantees.CUSTOMERNAME, collateralResponse.getCustomerName());

					eCollateral.set(Guarantees.ISHERITAGE, 'N');
					
					// Falta fecha vence garantia
					gauranteesList.add(eCollateral);
				}

				entities.setEntityList(Guarantees.ENTITY_NAME, gauranteesList);

			} else {
				List<Message> errorMessage = new ArrayList<Message>();
				errorMessage = serviceGauranteeResponse.getMessages();
				for (Message message : errorMessage) {
					args.getMessageManager().showErrorMsg(message.getMessage() + "\n");
				}
				if (guaranteesCriterial.get(GuaranteeSearchCriteria.EXTERNALCODENEXT) == null){
					gauranteesList.clear();	
				}			
				entities.setEntityList(Guarantees.ENTITY_NAME, gauranteesList);
				return;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GUARANTEE_EXECUTE_SEARCH, e, args, LOGGER);
		}

	}

}