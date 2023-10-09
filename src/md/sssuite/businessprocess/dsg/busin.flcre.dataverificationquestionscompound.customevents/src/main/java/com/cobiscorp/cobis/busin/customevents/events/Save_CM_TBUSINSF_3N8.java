package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.MemberManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class Save_CM_TBUSINSF_3N8 extends BaseEvent implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory.getLogger(Save_CM_TBUSINSF_3N8.class);

	public Save_CM_TBUSINSF_3N8(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			LOGGER.logDebug("---->Entra al Save_CM_TBUSINSF_3N8");

			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

			MemberManagement memberManagement = new MemberManagement(getServiceIntegration());
			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());

			int codigoTramite = 0;
			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER) == null ? 0 : originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
			String productType = originalHeader.get(OriginalHeader.PRODUCTTYPE);

			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, args, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			codigoTramite = processedNumber.getTramite();

			int groupCode = context.get(Context.CUSTOMERID);

			LOGGER.logDebug("----> EL TRAMITE: " + codigoTramite);
			LOGGER.logDebug("----> EL CUSTOMER: " + groupCode);

			MemberRequest memberRequest = new MemberRequest();
			// memberRequest.setGroupId(groupCode);
			memberRequest.setApplicationCode(codigoTramite);
			// MemberResponse[] memberResponse = memberManagement.searchMember(memberRequest, args, new BehaviorOption(false, false));// CustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));
			MemberResponse[] memberResponse = null;
			LOGGER.logDebug("---->El Tipo de Producto es: " + productType);

			if (productType.equals("GRUPAL")) {
				memberRequest.setGroupId(groupCode);
				memberRequest.setMode(3);
				memberResponse = memberManagement.searchMember(memberRequest, args, new BehaviorOption(false, false));// CustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));
			} else if (productType.equals("INDIVIDUAL")) {
				memberRequest.setCustomerId(groupCode);
				memberRequest.setMode(2);
				memberResponse = memberManagement.searchDebtor(memberRequest, args, new BehaviorOption(false, false));// CustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));
			}

			LOGGER.logDebug("---->Entra al Save_CM_TBUSINSF_3N8 Busqueda de Integrantes - memberResponse: " + memberResponse);
			Boolean ok = false;
			if (memberResponse != null) {
				Integer resultadoParam = catalogMngmnt.getValueQuestionnaireResponse(productType, args);
				LOGGER.logDebug("---->Entra al Save_CM_TBUSINSF_3N8 Busqueda de Integrantes - resultadoParam " + resultadoParam);

				if (resultadoParam != null) {
					for (MemberResponse member : memberResponse) {
						if (member.getResult() < resultadoParam && productType.equals("GRUPAL")) {
							args.getMessageManager().showErrorMsg("El cliente: " + member.getCustomerId() + " - " + member.getCustomer() + " Tiene calificación menor a " + resultadoParam);
							ok = false;
							break;
						} else if (member.getResult() < resultadoParam && productType.equals("INDIVIDUAL")) {
							args.getMessageManager().showErrorMsg("El cliente: " + member.getCustomerId() + " - " + member.getCustomer() + " Tiene calificación menor a " + resultadoParam);
							ok = false;
							break;
						} else {
							ok = true;
						}
					}
				} else {
					args.getMessageManager().showErrorMsg("No existe parámetro para comparar el resultado");
				}
			}

			LOGGER.logDebug("---->Entra al Save_CM_TBUSINSF_3N8 - Valor del ok: " + ok);
			if (ok) {
				args.setSuccess(true);
			} else {
				args.setSuccess(false);
			}

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.SAVE_QUESTIONS, ex, args, LOGGER);
		}
	}
}
