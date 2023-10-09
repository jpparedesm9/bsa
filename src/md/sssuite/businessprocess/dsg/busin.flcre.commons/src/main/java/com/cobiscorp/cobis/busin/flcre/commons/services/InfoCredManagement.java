package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.Date;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ContextRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.Infocred;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.InfocredItemResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.InfocredLoanResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.InfocredRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProcessRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.InfocredHeader;
import com.cobiscorp.cobis.busin.model.InfocredItem;
import com.cobiscorp.cobis.busin.model.QueryCentral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class InfoCredManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(InfoCredManagement.class);
	private String xmlResponse;
	private boolean hasSeveralAssociatedCustomers;

	public InfoCredManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public String getXmlResponse() {
		return xmlResponse;
	}

	public boolean getHasSeveralAssociatedCustomers() {
		return hasSeveralAssociatedCustomers;
	}

	public boolean getInfoCred(Infocred infocredDTO, ICommonEventArgs args, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.ININFOCRED, infocredDTO);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.VALIDATEINFOCRED, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("VALIDACION REGISTRO INFOCRED OK");
		} else {
			MessageManagement.show(serviceResponse, args, options);
			args.setSuccess(false);
		}
		return serviceResponse.isResult();
	}

	public boolean getSaveInfoCred(Infocred infocredDTO, ICommonEventArgs args, BehaviorOption option) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.ININFOCRED, infocredDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.CREATEINFOCRED, serviceRequestTO);

		if (serviceResponse.isResult()) {
			args.getMessageManager().showMessage(MessageLevel.SUCCESS, 0, "Reporte guardado correctamente");
		} else {
			if (serviceResponse.getMessages().size() > 0) {
				MessageManagement.show(serviceResponse, args, option);
			} else {
				args.getMessageManager().showMessage(MessageLevel.ERROR, 0, "Error al consultar el reporte INFOCRED");
			}
		}
		return serviceResponse.isResult();
	}

	public void searchRecordInfocredAndFill(int customerCode, DynamicRequest entities, ICommonEventArgs args, BehaviorOption option) {
		DataEntityList infocredItemEntityList = new DataEntityList();
		InfocredItemResponse[] infocredItemDTOList = this.searchRecordInfocred(customerCode, args, new BehaviorOption(true));
		if (infocredItemDTOList != null && infocredItemDTOList.length > 0) {
			for (InfocredItemResponse infocredItemDTO : infocredItemDTOList) {
				DataEntity eItem = new DataEntity();
				eItem.set(InfocredItem.CODE, infocredItemDTO.getCode());
				eItem.set(InfocredItem.DATE, infocredItemDTO.getDate());
				eItem.set(InfocredItem.OFFICIAL, infocredItemDTO.getOfficialName());
				eItem.set(InfocredItem.EXPIRATIONDATE, infocredItemDTO.getExpirationDate());
				eItem.set(InfocredItem.LOANORREQUEST, infocredItemDTO.getLoanOrRequestDetail());
				eItem.set(InfocredItem.WORKSTATION, infocredItemDTO.getWorkstation());
				eItem.set(InfocredItem.ROLE, infocredItemDTO.getRoleDetail());
				infocredItemEntityList.add(eItem);
			}
			if (option.showMessage()) {
				args.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_MSGPROCOK_00033");
			}
		} else {
			if (option.showMessage()) {
				args.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_NENRITSIP_70093");
			}
		}
		entities.setEntityList(InfocredItem.ENTITY_NAME, infocredItemEntityList);
	}

	public InfocredItemResponse[] searchRecordInfocred(int customerCode, ICommonEventArgs args, BehaviorOption option) {
		InfocredRequest infocredDTO = new InfocredRequest();
		infocredDTO.setCustomerCode(customerCode);
		infocredDTO.setOption(1);
		infocredDTO.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INFOCREDREQUEST, infocredDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHRECORDINFOCRED, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (InfocredItemResponse[]) serviceItemsResponseTO.getValue(ReturnName.INFOCREDITEMRESPONSE);

		} else {
			MessageManagement.show(serviceResponse, args, option);
		}
		return null;
	}

	public InfocredLoanResponse[] searchLoansInfocred(int customerCode, ICommonEventArgs args, BehaviorOption option) {
		InfocredRequest infocredDTO = new InfocredRequest();
		infocredDTO.setCustomerCode(customerCode);
		infocredDTO.setOption(2);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INFOCREDREQUEST, infocredDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHLOANSINFOCRED, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (InfocredLoanResponse[]) serviceItemsResponseTO.getValue(ReturnName.INFOCREDLOANRESPONSE);

		} else {
			MessageManagement.show(serviceResponse, args, option);
		}
		return null;
	}

	public boolean registerInfocred(DataEntity infocredHeader, ICommonEventArgs args, BehaviorOption option) {
		infocredHeader.set(InfocredHeader.OUT_HASMANYSIMILAR, false);
		infocredHeader.set(InfocredHeader.OUT_SIMILARLIST, null);

		InfocredRequest inInfocredDTO = new InfocredRequest();
		inInfocredDTO.setReview(Mnemonic.STRING_N);
		inInfocredDTO.setCustomerCode(infocredHeader.get(InfocredHeader.CUSTOMERID));
		inInfocredDTO.setRequestIdLoanId(infocredHeader.get(InfocredHeader.NEWREQUESTID));
		inInfocredDTO.setSource(Mnemonic.CHAR_T);
		inInfocredDTO.setRole(infocredHeader.get(InfocredHeader.ROLE));

		boolean registerOk = this.registerInfocred(inInfocredDTO, false, args, option);
		if (!registerOk) {
			args.setSuccess(false);
			if (this.getHasSeveralAssociatedCustomers()) { // SI EL CLIENTE TIENE VARIOS HOMONIMOS CON LA MISMA CEDULA
				infocredHeader.set(InfocredHeader.OUT_SIMILARLIST, this.getXmlResponse());
				infocredHeader.set(InfocredHeader.OUT_HASMANYSIMILAR, true);
			}
		}
		return registerOk;
	}

	public boolean registerInfocred(int customerCode, int requestIdLoanId, char source, char role, ICommonEventArgs args, BehaviorOption option) {
		InfocredRequest inInfocredDTO = new InfocredRequest();
		inInfocredDTO.setReview(Mnemonic.STRING_N);
		inInfocredDTO.setCustomerCode(customerCode);
		inInfocredDTO.setRequestIdLoanId(requestIdLoanId);
		inInfocredDTO.setSource(source);
		inInfocredDTO.setRole(role);

		return this.registerInfocred(inInfocredDTO, false, args, option);
	}

	public boolean registerInfocred(int customerCode, int requestIdLoanId, char source, char role, String documentType, String fullName, ICommonEventArgs args, BehaviorOption option) {
		InfocredRequest inInfocredDTO = new InfocredRequest();
		inInfocredDTO.setReview(Mnemonic.STRING_S);
		inInfocredDTO.setCustomerCode(customerCode);
		inInfocredDTO.setRequestIdLoanId(requestIdLoanId);
		inInfocredDTO.setSource(source);
		inInfocredDTO.setRole(role);
		inInfocredDTO.setDocumentType(documentType);
		inInfocredDTO.setFullName(fullName);

		return this.registerInfocred(inInfocredDTO, true, args, option);
	}

	public boolean registerInfocred(InfocredRequest inInfocredDTO, boolean reentry, ICommonEventArgs args, BehaviorOption option) {
		this.hasSeveralAssociatedCustomers = false;
		this.xmlResponse = "";

		inInfocredDTO.setReportType(Format.REPORT_GET_INDIVIDUALREPORT3);
		inInfocredDTO.setWorkstation(SessionUtil.getTerminal());
		inInfocredDTO.setDateValidation(Mnemonic.CHAR_S);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INFOCREDREQUEST, inInfocredDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.REGISTERINFOCRED, serviceRequestTO);

		if (serviceResponse.isResult()) {
			args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_ERDRITSEN_70029");
		} else {
			args.setSuccess(false);
			if (serviceResponse.getMessages().size() > 0) {
				for (Message message : serviceResponse.getMessages()) {
					if (message.getCode().equals("2101112")) {
						// Titular inexistente, no se encontro el reporte INFOCRED del cliente con la información proporcionada
						args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_TOSFELMON_63266");
						serviceResponse.getMessages().remove(message);
					} else if (message.getCode().equals("2101113")) {
						// Existen varios titulares que coinciden con la misma identificación, debe seleccionar solo uno de ellos
						args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_OODTENRSO_32928");
						if (!reentry) {
							// SI TIENE VARIOS TITULARES, LOS GUARDA EN UN xml PARA DESPUES PODER SELECCIONAR UNO SOLO DE ELLOS
							this.xmlResponse = message.getMessage();
							this.hasSeveralAssociatedCustomers = true;
						}
						serviceResponse.getMessages().remove(message);
					}
				}
				MessageManagement.show(serviceResponse, args, option);
			} else {
				args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_EELECUSTD_31654");
			}
		}
		return serviceResponse.isResult();
	}

	public boolean validateReport(DataEntity infocredHeader, ICommonEventArgs args, BehaviorOption options) {
		return validateReport(infocredHeader.get(InfocredHeader.CUSTOMERID), args, options);
	}

	public boolean validateReport(Integer customerCode, ICommonEventArgs args, BehaviorOption options) {
		Infocred infocredDTO = new Infocred();
		infocredDTO.setCustomerCode(customerCode);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.ININFOCRED, infocredDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.VALIDATEINFOCRED, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("VALIDACION REGISTRO INFOCRED OK PARA CLIENTE: " + infocredDTO.getCustomerCode());
		} else {
			MessageManagement.show(serviceResponse, args, options);
			args.setSuccess(false);
		}
		return serviceResponse.isResult();
	}

	public boolean validateDateCICAndInfocredForTemporal(Integer requestId, int ssn, ICommonEventArgs args, BehaviorOption options) {
		ContextRequest contextRequestDTO = new ContextRequest();
		contextRequestDTO.setRequestId(requestId);
		contextRequestDTO.setSsn(ssn);
		contextRequestDTO.setOperation(Mnemonic.CHAR_T);
		return validateDateCICAndInfocred(contextRequestDTO, args, options);
	}

	public boolean validateDateCICAndInfocredForFinal(Integer requestId, ICommonEventArgs args, BehaviorOption options) {
		ContextRequest contextRequestDTO = new ContextRequest();
		contextRequestDTO.setRequestId(requestId);
		contextRequestDTO.setOperation(Mnemonic.CHAR_D);
		return validateDateCICAndInfocred(contextRequestDTO, args, options);
	}

	public boolean validateDateCICAndInfocred(ContextRequest contextRequestDTO, ICommonEventArgs args, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONTEXTREQUEST, contextRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.VALIDATEDATECICANDINFOCRED, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("EXITO EN VALIDACION FECHAS CIC e INFOCRED PARA TRAMITE: " + contextRequestDTO.getRequestId());
		} else {
			MessageManagement.show(serviceResponse, args, options);
			args.setSuccess(false);
		}
		return serviceResponse.isResult();
	}

	public boolean mappingQueryCentralInformation(DynamicRequest entities, ApplicationResponse applicationResponse, ICommonEventArgs arg1, BehaviorOption options) {
		boolean hasCIC = false;
		String yearCic = null;
		DataEntity queryCentral = entities.getEntity(QueryCentral.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		if (queryCentral == null) {
			return false;
		}
		// BUSCA EL NUMERO DE VECES QUE PASO POR ESA TAREA
		if (context != null) {
			context.set(Context.TASKCOUNTLAP, 0);
			if (Validate.Integers.isNotNullAndGreaterThanZero(context.get(Context.APPLICATION)) && Validate.Strings.isNotNullOrEmptyOrWhiteSpace(context.get(Context.TASKSUBJECT))) {
				ProcessRequest processRequest = new ProcessRequest();
				processRequest.setInstanceId(context.get(Context.APPLICATION));
				processRequest.setActivityName(context.get(Context.TASKSUBJECT));
				WorkflowManagement workflowMngmnt = new WorkflowManagement(getServiceIntegration());
				cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProcessResponse processResponse = workflowMngmnt.getProcessLap(processRequest, arg1, options);
				if (processResponse != null) {
					context.set(Context.TASKCOUNTLAP, processResponse.getActivityCountLap());
				}
			}
		}

		// NIVEL DE ENDEUDAMIENTO
		if ((applicationResponse != null) && (applicationResponse.getLevelIndebtedness() != null)) {
			queryCentral.set(QueryCentral.LEVELINDEBTEDNESS, applicationResponse.getLevelIndebtedness());
		}else{
			queryCentral.set(QueryCentral.LEVELINDEBTEDNESS, Mnemonic.CHAR_N);
		}
		CatalogManagement catalogMngnt = new CatalogManagement(getServiceIntegration());
		// AÑO CIC
		ParameterResponse parameterDto = catalogMngnt.getParameter("ACIC", "CRE", arg1, options);
		if (parameterDto != null) {
			yearCic = parameterDto.getParameterValue();
		}
		// MES CIC
		parameterDto = catalogMngnt.getParameter("MCIC", "CRE", arg1, options);
		if (parameterDto != null && yearCic != null) {
			queryCentral.set(QueryCentral.REPORTMONTHCIC, yearCic + "/" + parameterDto.getParameterValue());
			hasCIC = true;
		}
		// FECHA INFOCRED
		parameterDto = catalogMngnt.getParameter("FVINFC", "CRE", arg1, options);
		if (parameterDto != null) {
			Date dateInfocred = Convert.CString.toDate(SessionContext.DATE100, parameterDto.getParameterValue());
			queryCentral.set(QueryCentral.REPORTMONTHINFOCRED, Convert.CDate.toString(dateInfocred));
			return hasCIC && true;
		}
		return false;
	}

	public static void setQueryCentralInformation(DynamicRequest entities, ApplicationRequest applicationResponse) {
		// ACTUALIZA FECHA CIC
		applicationResponse.setAssignDateCIC(Mnemonic.CHAR_S);

		// ACTUALIZA NIVEL DE ENDEUDAMIENTO
		DataEntity queryCentral = entities.getEntity(QueryCentral.ENTITY_NAME);
		if ((queryCentral != null) && (queryCentral.get(QueryCentral.LEVELINDEBTEDNESS) != null)) {
			if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(queryCentral.get(QueryCentral.LEVELINDEBTEDNESS).toString())) {
				applicationResponse.setLevelIndebtedness(queryCentral.get(QueryCentral.LEVELINDEBTEDNESS));
			}
		}
	}

}
