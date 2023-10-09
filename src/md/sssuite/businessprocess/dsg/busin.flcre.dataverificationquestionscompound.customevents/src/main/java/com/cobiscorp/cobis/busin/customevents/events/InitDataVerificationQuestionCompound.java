package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ApplicationType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.MemberManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.GeneralData;
import com.cobiscorp.cobis.busin.model.MemberQuestion;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class InitDataVerificationQuestionCompound extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataVerificationQuestionCompound.class);

	public InitDataVerificationQuestionCompound(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Integrantes");

		try {
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity(GeneralData.ENTITY_NAME);
			String productType = originalHeader.get(OriginalHeader.PRODUCTTYPE);
			MemberManagement memberManagement = new MemberManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			CustomerRequest customerRequest = new CustomerRequest();

			int codigoTramite = 0;
			int idCustomer = context.get(Context.CUSTOMERID);
			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER) == null ? 0 : originalHeader.get(OriginalHeader.APPLICATIONNUMBER);

			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			codigoTramite = processedNumber.getTramite();

			String fieldSeven = "";
			if (processedNumber.getFieldSeven() != null) {
				fieldSeven = processedNumber.getFieldSeven().trim();
			}

			ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
			if (creditApplication != null) {
				context.set(Context.OFFICENAME, creditApplication.getOfficeDescriptionTr());
				originalHeader.set(OriginalHeader.IDREQUESTED, String.valueOf(codigoTramite));

				originalHeader.set(OriginalHeader.AMOUNTAPROBED, creditApplication.getApprovedAmount());
				// Se requiere que se vea la suma de los montos de la tr_tramite_grupal solo cuando es grupal
				if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
					if (creditApplication.getSumRequestedAmountGroup() != null && creditApplication.getSumAmountGroup() != null) {
						if (BigDecimal.ZERO.equals(BigDecimal.valueOf(creditApplication.getSumRequestedAmountGroup().doubleValue())) && BigDecimal.ZERO.equals(BigDecimal.valueOf(creditApplication.getSumAmountGroup().doubleValue()))) {
							originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
						} else {
							originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getSumRequestedAmountGroup());
						}
					} else {
						originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
					}
				} else {
					originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
				}

				generalData.set(GeneralData.SYMBOLCURRENCY, creditApplication.getSymbolCurrency().trim());

				originalHeader.set(OriginalHeader.TERM, String.valueOf(creditApplication.getTerm()));

				// Frecuencia
				LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
					originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
				}

				// Descripcion Frecuencia
				generalData.set(GeneralData.PAYMENTFRECUENCYNAME, creditApplication.getTermTypeDescrip());

				// Typos
				LOGGER.logDebug("---->Recupero los parametros de tipo");
				generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
					originalHeader.set(OriginalHeader.TYPE, generalParametersValuesHistory.getDescription());
				}

				String clienteVinculado = creditApplication.getLinkedClient() + "";
				if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
					generalData.set(GeneralData.VINCULADO, Mnemonic.String_Si);
				else
					generalData.set(GeneralData.VINCULADO, Mnemonic.String_No);

				// Recupero el parámetro Sector
				List<GeneralParametersValuesHistory> generalParameterCatalogS = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");// No

				// Asocio el valor del sector
				for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalogS) {
					generalData.set(GeneralData.SECTORNEG, sectorNeg.getDescription());
				}

				LOGGER.logDebug("---->Recupero los parametros de categoria");
				List<GeneralParametersValuesHistory> generalParameterCatalogC = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalogC) {
					originalHeader.set(OriginalHeader.CATEGORY, generalParametersValuesHistory.getDescription());
				}

				// Ciclo
				if (productType.equals(Mnemonic.PRESTAMO_GRUPAL)) {
					String cycle = "";
					cycle = creditApplication.getCycleNumber();
					context.set(Context.CYCLENUMBER, cycle);
				} else if (productType.equals(Mnemonic.PRESTAMO_INDIVIDUAL)) {
					customerRequest.setCustomerId(idCustomer);
					customerRequest.setModo(0);
					CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, arg1, new BehaviorOption(true));
					context.set(Context.CYCLENUMBER, String.valueOf(customerResponse.getCicleNumberEn()));
				}

			}

			// Pisa algunos datos
			LOGGER.logDebug("ProductoTipo: " + originalHeader.get(OriginalHeader.PRODUCTTYPE));
			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != "") {

				LOGGER.logDebug("---->Recupera el nombre del producto que se esta atendiendo");
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);
				// entidadInfo.set(EntidadInfo.TIPOPRODUCTO, originalHeader.get(OriginalHeader.PRODUCTTYPE).trim());
				if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {

					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Plazo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.TERM, generalParametersValuesHistory.getValue());
					}

					LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
					generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
					LOGGER.logDebug("generalParameterCatalog" + generalParameterCatalog.size());
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						LOGGER.logDebug("Valor --->" + generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
					}
				}
				try {
					LOGGER.logDebug("---->Recupero los parametros de categoria");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.CATEGORY, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de tipo");
					generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.TYPE, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de subtipo");
					generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Subtipo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.SUBTYPE, generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.SUBTYPEID, generalParametersValuesHistory.getValue());
					}
				} catch (BusinessException e) {
					LOGGER.logError("Error---> " , e);
				}

			}

			int groupCode = context.get(Context.CUSTOMERID);

			MemberRequest memberRequest = new MemberRequest();
			memberRequest.setApplicationCode(codigoTramite);

			LOGGER.logDebug("Imprimo Tipo de Producto: " + originalHeader.get(OriginalHeader.PRODUCTTYPE));
			MemberResponse[] memberResponse = null;
			if (productType.equals("GRUPAL")) {
				memberRequest.setGroupId(groupCode);
				memberRequest.setMode(3);
				memberResponse = memberManagement.searchMember(memberRequest, arg1, new BehaviorOption(false, false));// CustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));
			} else if (productType.equals("INDIVIDUAL")) {
				memberRequest.setCustomerId(groupCode);
				memberRequest.setMode(2);
				memberResponse = memberManagement.searchDebtor(memberRequest, arg1, new BehaviorOption(false, false));// CustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));
			}

			LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - Integrantes");
			if (memberResponse != null) {
				DataEntityList memberEntity = new DataEntityList();
				for (MemberResponse member : memberResponse) {
					DataEntity eMember = new DataEntity();
					eMember.set(MemberQuestion.CODEMEMBER, member.getCustomerId());
					eMember.set(MemberQuestion.NAMEMEMBER, member.getCustomer());
					eMember.set(MemberQuestion.ANSWER, member.getResult());
					LOGGER.logDebug("------>> Inicio InitDataVerificationQuestion - +member.getResult():" + member.getResult());
					memberEntity.add(eMember);
				}
				LOGGER.logDebug(":>:>getMembersEntityList -> memberEntity:>:>" + memberEntity.getDataList());
				entities.setEntityList(MemberQuestion.ENTITY_NAME, memberEntity);
			}

			// Sincronización consulta
			//String nameActivity = context.get(Context.APPLICATIONSUBJECT);
			//SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
			//SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
			//synchronizationRequest.setApplicationNumber(codigoTramite);
			//synchronizationRequest.setNameActivity(nameActivity);

			LOGGER.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Valor del tramite:" + codigoTramite);
			//logger.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Valor de la actividad:" + nameActivity);

			//SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, arg1, new BehaviorOption(true));

			context.set(Context.ENABLE, "N");
			context.set(Context.SYNCHRONIZE, "N");// se habilita el botón de sincronizar

			//logger.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - synchronizationResponse:" + synchronizationResponse);

			// Se comenta porque ya no se ejecuta esta sección
			// if (synchronizationResponse == null) {
			// logger.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Registro de sincronizacion");
			// if (synchronizationManagement.createSynchronizationActivity(synchronizationRequest, arg1, new BehaviorOption(true))) {
			// context.set(Context.ENABLE, "S");
			// arg1.setSuccess(true);
			// } else {
			// arg1.setSuccess(false);
			// }
			// } else {
			//logger.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Valor del sincronizacion.getSynchronization:" + synchronizationResponse.getSynchronization());
			//if (synchronizationResponse.getSynchronization() != null) {
				// Si la marca está en N, se deshabilita la pantalla y no se permite continuar el proceso,
				// si la marca está en S, podemos continuar el proceso.
				// Si la marca está en Null, es porque la información no se sincronizó al aplicativo móvil
				// y podemos trabajar desde el flujo normalmente.
				//context.set(Context.SYNCHRONIZE, "N");
				//if (synchronizationResponse.getSynchronization().trim().equals("N")) {
				//	context.set(Context.ENABLE, "N");
				//} else if (synchronizationResponse.getSynchronization().trim().equals("S")) {
				//	context.set(Context.ENABLE, "S");
				//	context.set(Context.SYNCHRONIZE, "S");
				//}
			//} else if (synchronizationResponse.getSynchronization() == null) {
			//	logger.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Ingreso al valor de null de la sincronizacion");
			//	context.set(Context.ENABLE, "S");
			//}
			// }
			LOGGER.logDebug("---->Ingresa al InitDataVerificationQuestionCompound - Valor del enable:" + context.get(Context.ENABLE));
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.INITDATA_COMPOUND, e, arg1, LOGGER);
		}
	}
}
