package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.PointReductionApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.PointReductionApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsDetailResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.CategoryReadjustment;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class ItemsManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ItemsManagement.class);

	public ItemsManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public static DataEntity getItem(DynamicRequest entities, String concept) {
		DataEntityList itemList = entities.getEntityList(Category.ENTITY_NAME);
		for (DataEntity itemTmp : itemList) {
			logger.logDebug("RESULTADO CONCEPTO" + itemTmp.get(Category.CONCEPT) + " - " + concept);
			if (itemTmp.get(Category.CONCEPT).equals(concept)) {
				return itemTmp;
			}
		}
		return null;
	}

	public ReadLoanItemsDetailResponse[] getItemsDetail(ReadLoanItemsRequest itemRequest, ICommonEventArgs arg1, BehaviorOption options) {
		int codigoTramite=0;
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		
		
		codigoTramite= Integer.parseInt(itemRequest.getBank());
		//logger.logDebug("tramite >>: "+codigoTramite);
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
		
		
		itemRequest.setBank(creditApplication.getOperationNumberBank());
		serviceRequestItemsTO.getData().put(RequestName.INITEMSREQUEST, itemRequest);
		//logger.logDebug("request >>> " + serviceRequestItemsTO.getData());
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETITEMSDETAIL_BUSIN, serviceRequestItemsTO);		
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())				
				logger.logDebug("ItemsResponseDetail recuperados para - " + creditApplication.getOperationNumberBank());						
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadLoanItemsDetailResponse[]) serviceResponseItemsTO.getValue(ReturnName.RETURNITEMSDETAIL);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public static DataEntity readItemsDetail(DynamicRequest entities, ICommonEventArgs arg1, String iConcept, ICTSServiceIntegration iServiceIntegration, DataEntity selectedItem,
			DataEntity selectedItemReadjustment) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso readItems DynamicRequest entities");

		String numeroOperacion;
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);

		if (originalHeader != null && originalHeader.get(OriginalHeader.OPNUMBERBANK) != null)
			numeroOperacion = originalHeader.get(OriginalHeader.OPNUMBERBANK).trim();
		else
			numeroOperacion = String.valueOf(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)).trim();

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso readItemsDetail String bank--->" + numeroOperacion);
			logger.logDebug("Ingreso readItemsDetail String bank, String productType--->" + paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED).toString());
		}
		// paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED).toString(),
		// originalHeader.get(OriginalHeader.OPNUMBERBANK);
		return readItemsDetail(numeroOperacion, paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE), arg1, iConcept, iServiceIntegration, selectedItem, selectedItemReadjustment);
	}

	public static DataEntity readItemsDetail(String bank, String productType, ICommonEventArgs arg1, String iConcept, ICTSServiceIntegration iServiceIntegration,
			DataEntity selectedItem, DataEntity selectedItemReadjustment) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso readItemsDetail String bank -->" + bank);
		}
		try {
			ReadLoanItemsRequest itemsRequest = new ReadLoanItemsRequest();

			itemsRequest.setOperation(Format.OPERATION_ITEMS_DETAIL_SHOW);
			itemsRequest.setBank(bank);

			if (iConcept == null) {
				logger.logDebug("itemsRequest.setConcept," + selectedItem.get(Category.CONCEPT).trim());
				itemsRequest.setConcept(selectedItem.get(Category.CONCEPT).trim());
			} else {

				itemsRequest.setConcept("INT");
			}

			if (logger.isDebugEnabled())
				logger.logDebug("itemsRequest.getConcept {" + itemsRequest.getConcept().trim() + "}");
			itemsRequest.setOperationType(productType);
			itemsRequest.setBank(bank);

			ItemsManagement itemManager = new ItemsManagement(iServiceIntegration);
			ReadLoanItemsDetailResponse[] listItemsResponse = itemManager.getItemsDetail(itemsRequest, arg1, new BehaviorOption(true));

			if (listItemsResponse != null && listItemsResponse.length != 0) {
				if (logger.isDebugEnabled())
					logger.logDebug("listItemsResponse has data");
				selectedItem.set(Category.CONCEPT, listItemsResponse[0].getIConcepto() == null ? null : listItemsResponse[0].getIConcepto().trim());
				selectedItem.set(Category.ITEMDESC, listItemsResponse[0].getIDescripcion());
				selectedItem.set(Category.AMOUNTOAPPLY, listItemsResponse[0].getITipoValor() == null ? null : listItemsResponse[0].getITipoValor().trim());
				selectedItem.set(Category.AMOUNTTOAPPLYDESC, listItemsResponse[0].getIDescTipo() == null ? null : listItemsResponse[0].getIDescTipo().trim());
				selectedItem.set(Category.REFERENCE, listItemsResponse[0].getIReferencial() == null ? null : listItemsResponse[0].getIReferencial().trim());
				selectedItem.set(Category.REFERENCEDESCRIPTION, listItemsResponse[0].getIDescReferencial() == null ? null : listItemsResponse[0].getIDescReferencial().trim());
				selectedItem.set(Category.REFERENCEAMOUNT, listItemsResponse[0].getIValorReferencial());

				if (listItemsResponse[0].getISignoDefault() == null) {
					listItemsResponse[0].setISignoDefault(' ');
					selectedItem.set(Category.SIGN, listItemsResponse[0].getISignoDefault().toString());
				} else {
					selectedItem.set(Category.SIGN, listItemsResponse[0].getISignoDefault().toString());
				}
				// sro
				selectedItem.set(Category.SPREAD, listItemsResponse[0].getIValorDefault());

				selectedItem.set(Category.VALUE, listItemsResponse[0].getITotalDefault());
				selectedItem.set(Category.MINIMUM, listItemsResponse[0].getITotalMinimo());
				selectedItem.set(Category.MAXIMUN, listItemsResponse[0].getITotalMaximo());

				selectedItem.set(Category.PRIORITY, listItemsResponse[0].getIPrioridad());
				selectedItem.set(Category.PAYMENTARREARS, listItemsResponse[0].getIPagaMora());
				selectedItem.set(Category.PROVISIONED, listItemsResponse[0].getIProvisiona() == null ? "" : String.valueOf(listItemsResponse[0].getIProvisiona()));
				selectedItem.set(Category.READJUSTMENTSIGN, listItemsResponse[0].getISignoReaj());
				selectedItem.set(Category.REFERENTIALREADJUSTMENT, listItemsResponse[0].getIReferencialReaj());
				selectedItem.set(Category.GRACE, listItemsResponse[0].getIGracia());

				selectedItem.set(Category.CONCEPTASOC, listItemsResponse[0].getIConceptoAsoc());
				selectedItem.set(Category.PERCENTAGEDAY, listItemsResponse[0].getIPorcentajeDia());
				selectedItem.set(Category.AFFECTATION, listItemsResponse[0].getIAfectacion());
				selectedItem.set(Category.DIFFER, listItemsResponse[0].getIDiferir());
				selectedItem.set(Category.DIFFERDAYS, listItemsResponse[0].getIDiasDiferir());
				selectedItem.set(Category.DISCOUNTFORM, listItemsResponse[0].getIFDescuento());

				selectedItem.set(Category.FORMTHIRDPAYMENT, listItemsResponse[0].getIFPagoTercero());
				selectedItem.set(Category.ACCOUNTPAYMENT, listItemsResponse[0].getICuentaPago());
				selectedItem.set(Category.ROTMINIMUNRATE, listItemsResponse[0].getIRotTasaMinima());
				selectedItem.set(Category.MAXRATE, listItemsResponse[0].getIValorMax());
				selectedItem.set(Category.FUNDED, listItemsResponse[0].getIFinanciado() == null ? null : String.valueOf(listItemsResponse[0].getIFinanciado()));
				if (logger.isDebugEnabled())
					logger.logDebug("listItemsResponse[0].getITipoRubro()" + listItemsResponse[0].getITipoRubro());
				selectedItem.set(Category.ITEMTYPE, listItemsResponse[0].getITipoRubro() == null ? null : String.valueOf(listItemsResponse[0].getITipoRubro()));

				// Reajuste
				selectedItemReadjustment.set(CategoryReadjustment.CONCEPT, selectedItem.get(Category.CONCEPT));
				selectedItemReadjustment.set(CategoryReadjustment.AMOUNTTOAPPLY, listItemsResponse[0].getIReajuste() == null ? null : listItemsResponse[0].getIReajuste().trim());
				selectedItemReadjustment.set(CategoryReadjustment.REFERENCE, listItemsResponse[0].getIReferencialReaj() == null ? null : listItemsResponse[0].getIReferencialReaj()
						.trim());
				selectedItemReadjustment.set(CategoryReadjustment.REFERENCEDESCRIPTION, listItemsResponse[0].getIDescReferencialReaj());
				selectedItemReadjustment.set(CategoryReadjustment.REFERENCEAMOUNT, listItemsResponse[0].getIValorReferencialReaj());
				selectedItemReadjustment.set(CategoryReadjustment.SIGN, listItemsResponse[0].getISignoReaj() == null ? null : String.valueOf(listItemsResponse[0].getISignoReaj()));
				selectedItemReadjustment.set(CategoryReadjustment.SPREAD, listItemsResponse[0].getIValorReaj());
				if (logger.isDebugEnabled())
					logger.logDebug("listItemsResponse[0].getIValorTotalReaj()" + listItemsResponse[0].getIValorTotalReaj());
				selectedItemReadjustment.set(CategoryReadjustment.VALUE, listItemsResponse[0].getIValorTotalReaj());
				selectedItemReadjustment.set(CategoryReadjustment.MAXIMUN, listItemsResponse[0].getITotalMaximoReaj());
				selectedItemReadjustment.set(CategoryReadjustment.MINIMUM, listItemsResponse[0].getITotalMinimoReaj());

				if (logger.isDebugEnabled()) {
					logger.logDebug("Rubro Edición: [" + selectedItem.get(Category.CONCEPT) + ", " + selectedItem.get(Category.ITEMDESC) + ", "
							+ selectedItem.get(Category.AMOUNTOAPPLY) + ", " + selectedItem.get(Category.AMOUNTTOAPPLYDESC) + ", "
							+ selectedItem.get(Category.REFERENCEDESCRIPTION) + ", " + selectedItem.get(Category.REFERENCE) + ", " + selectedItem.get(Category.REFERENCEAMOUNT)
							+ ", " + selectedItem.get(Category.SIGN) + ", " + selectedItem.get(Category.SPREAD) + ", " + selectedItem.get(Category.VALUE) + ", "
							+ selectedItem.get(Category.MINIMUM) + ", " + selectedItem.get(Category.MAXIMUN) + ", " + selectedItem.get(Category.PRIORITY) + ", "
							+ selectedItem.get(Category.PAYMENTARREARS) + ", " + selectedItem.get(Category.PROVISIONED) + ", " + selectedItem.get(Category.READJUSTMENTSIGN) + ", "
							+ selectedItem.get(Category.REFERENTIALREADJUSTMENT) + ", " + selectedItem.get(Category.REFERENTIALREADJUSTMENT) + ", "
							+ selectedItem.get(Category.GRACE) + ", " + selectedItem.get(Category.CONCEPTASOC) + ", " + selectedItem.get(Category.CONCEPTASOC) + ", "
							+ selectedItem.get(Category.PERCENTAGEDAY) + ", " + selectedItem.get(Category.AFFECTATION) + ", " + selectedItem.get(Category.DIFFER) + ", "
							+ selectedItem.get(Category.DIFFERDAYS) + ", " + selectedItem.get(Category.DISCOUNTFORM) + ", " + selectedItem.get(Category.FORMTHIRDPAYMENT) + ", "
							+ selectedItem.get(Category.ACCOUNTPAYMENT) + ", " + selectedItem.get(Category.ROTMINIMUNRATE) + ", " + selectedItem.get(Category.MAXRATE) + ", "
							+ selectedItem.get(Category.FUNDED) + ", " + selectedItem.get(Category.ITEMTYPE) + "]");
					logger.logDebug("Rubro Reajuste Edición: [" + selectedItem.get(Category.CONCEPT) + ", " + listItemsResponse[0].getIReajuste() + ", "
							+ listItemsResponse[0].getIReferencialReaj() + ", " + listItemsResponse[0].getIDescReferencialReaj() + ", "
							+ listItemsResponse[0].getIValorReferencialReaj() + ", " + listItemsResponse[0].getISignoReaj() + ", " + listItemsResponse[0].getIValorTotalReaj()
							+ ", " + listItemsResponse[0].getITotalMaximoReaj() + ", " + listItemsResponse[0].getITotalMinimoReaj() + "]");
				}
				return selectedItem;
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("ERROR EN TRAER RUBROS:-->", e);
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
			arg1.setSuccess(false);
		}
		return new DataEntity();
	}

	public void saveItem(DynamicRequest entities, IExecuteCommandEventArgs arg1, String iConcept, Double iPercentage, DataEntity category) {
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		saveItem(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED).toString(), arg1, iConcept, iPercentage, category);
	}

	public void saveItem(String bank, IExecuteCommandEventArgs arg1, String iConcept, Double iPercentage, DataEntity category) {
		// DataEntity item = entities.getEntity(Category.ENTITY_NAME);
		if (logger.isDebugEnabled())
			logger.logDebug("Entro a Save Items Concepto" + iConcept);
		// DataEntity paymentPlanHeader =
		// entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
		ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();

		if (category != null) {
			/* Parametros de entrada para el request del servicio UpdateItems */
			// loanItemsRequest.setOperationNumber(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));

			logger.logDebug("Entro a Save Items " + loanItemsRequest.getConcept());
			/* Seteo de variables para enviar a actualizar el rubro */
			loanItemsRequest.setItemType(category.get(Category.CONCEPTTYPE) == null ? '\0' : category.get(Category.CONCEPTTYPE).charAt(0));
			loanItemsRequest.setMethodPayment(category.get(Category.METHODOFPAYMENT) == null ? '\0' : category.get(Category.METHODOFPAYMENT).charAt(0));
			// loanItemsRequest.setProvisioned(category.get(Category.PROVISIONED));
			loanItemsRequest.setSign(category.get(Category.SIGN).charAt(0));
			logger.logDebug("Signo de Mora " + category.get(Category.SIGN).charAt(0) + " <<>> " + loanItemsRequest.getSign());
			loanItemsRequest.setFactor(category.get(Category.SPREAD));
			loanItemsRequest.setReferential(category.get(Category.REFERENCE));
			loanItemsRequest.setReadjustmentFactor(category.get(Category.READJUSTMENTFACTOR));
			loanItemsRequest.setReadjustmentReferential(category.get(Category.REFERENTIALREADJUSTMENT));
			loanItemsRequest.setValue(category.get(Category.VALUE));
			if (BigDecimal.valueOf(iPercentage).compareTo(BigDecimal.ZERO) == 0)
				loanItemsRequest.setPercentage(category.get(Category.PERCENTAGE));
			else
				loanItemsRequest.setPercentage(iPercentage);
			loanItemsRequest.setGrace(category.get(Category.GRACE));
			loanItemsRequest.setMaxValue(category.get(Category.MAXIMUN));
			loanItemsRequest.setMinValue(category.get(Category.MINIMUM));
			loanItemsRequest.setCalculatedBase(category.get(Category.CALCULATEDBASE));
			loanItemsRequest.setOperationType(category.get(Category.PRODUCTTYPE));
			loanItemsRequest.setAsocConcept(category.get(Category.CONCEPTASOC));
			loanItemsRequest.setOperationType(category.get(Category.PRODUCTTYPE));
			loanItemsRequest.setDayPercentage(category.get(Category.PERCENTAGEDAY));
			loanItemsRequest.setOperationType(category.get(Category.PRODUCTTYPE));
			loanItemsRequest.setDiscountForm(category.get(Category.DISCOUNTFORM));
			loanItemsRequest.setThirdPaymentForm(category.get(Category.FORMTHIRDPAYMENT));
			loanItemsRequest.setPaymentAccount(category.get(Category.ACCOUNTPAYMENT));
			loanItemsRequest.setRotMinimumRate(category.get(Category.ROTMINIMUNRATE));
			loanItemsRequest.setMinimumRate(category.get(Category.MINRATE));

			loanItemsRequest.setBank(bank);

			if (iConcept == null)
				loanItemsRequest.setConcept(category.get(Category.CONCEPT));
			else
				loanItemsRequest.setConcept(iConcept);

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put("inReadLoanItemsRequest", loanItemsRequest);
			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "Loan.SearchLoanItems.UpdateLoanItems", serviceRequestTO);
			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("Se actualizo el rubro para IDREQUEST: " + bank);
				arg1.getMessageManager().showSuccessMsg("SE ACTUALIZO EL RUBRO");
			} else {
				MessageManagement.show(serviceResponse, arg1, new BehaviorOption(true));
			}
		}
	}

	public ReadLoanItemsResponse[] searchItemsData(ReadLoanItemsRequest itemsRequest, IDataEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put(RequestName.INITEMSREQUEST, itemsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHITEMSDETAIL, serviceRequestItemsTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO EXITOSO ITEMS PARA BANCO: " + itemsRequest.getBank());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadLoanItemsResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNITEMSREPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public PointReductionApplicationResponse[] readPointApplication(int idRequested, IDataEventArgs arg1, BehaviorOption options) {
		PointReductionApplicationRequest pointReductionApplicationRequest = new PointReductionApplicationRequest();
		pointReductionApplicationRequest.setRequestId(idRequested);

		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put(RequestName.INPOINTREDUCTIONAPPLICATIONREQUEST, pointReductionApplicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SUGGESTEDQUERYPOINTS, serviceRequestItemsTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO OK APPLICATION POINTS PARA TRAMITE: " + idRequested);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (PointReductionApplicationResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNPOINTREDUCTIONAPPLICATIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ReadLoanItemsResponse[] readItem(DynamicRequest entities, ICommonEventArgs args, ReadLoanItemsRequest loanItemsRequest) throws Exception {

		try {

			ServiceRequestTO serviceRequestItemRequest = new ServiceRequestTO();
			serviceRequestItemRequest.getData().put("inReadLoanItemsRequest", loanItemsRequest);

			ServiceResponse serviceResponseItem = execute(getServiceIntegration(), logger, "Loan.SearchLoanItems.InsertItem", serviceRequestItemRequest);
			logger.logDebug("readItem: " + serviceResponseItem + ", result:" + serviceResponseItem.isResult());
			if (serviceResponseItem.isResult()) {
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponseItem.getData();
				logger.logDebug("return readItem" + (ReadLoanItemsResponse[]) serviceItemsResponseTO.getValue("returnReadLoanItemsResponse"));
				return (ReadLoanItemsResponse[]) serviceItemsResponseTO.getValue("returnReadLoanItemsResponse");
			}

		} catch (Exception ex) {
			throw ex;
		}

		return null;
	}

	public ReadLoanItemsResponse[] searchValuereference(String amountToApply, ICommonEventArgs args) throws Exception {

		try {

			ReadLoanItemsRequest loanItemsRequest = new ReadLoanItemsRequest();
			loanItemsRequest.setType(amountToApply == null ? null : amountToApply.trim());
			loanItemsRequest.setOfic(2); // opcion 2
			ServiceRequestTO serviceRequestItemRequest = new ServiceRequestTO();
			serviceRequestItemRequest.getData().put("inReadLoanItemsRequest", loanItemsRequest);

			ServiceResponse serviceResponseItem = execute(getServiceIntegration(), logger, "Loan.SearchLoanItems.SearchValueReferenceByValueApply", serviceRequestItemRequest);
			if (serviceResponseItem.isResult()) {
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponseItem.getData();
				ReadLoanItemsResponse[] itemResponse = (ReadLoanItemsResponse[]) serviceItemsResponseTO.getValue("returnReadLoanItemsResponse");
				return itemResponse;
			}
		} catch (Exception ex) {
			args.setSuccess(false);
			throw ex;
		}
		return null;
	}

	public void saveUpdateItem(ReadLoanItemsRequest loanItemsRequest, ICommonEventArgs args, boolean isNew) throws Exception {
		logger.logDebug("Start saveUpdateItem in ItemsManagement class");
		ServiceResponse serviceResponse = null;
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		try {
			//loanItemsRequest.setBank("100010001946"); pendiente revisar 
			serviceRequestTO.getData().put("inReadLoanItemsRequest", loanItemsRequest);

			String errorMessage = "";
			if (isNew) {
				logger.logDebug("---------> Guardar rubro");
				errorMessage = "BUSIN.DLB_BUSIN_CECONITOA_03569";
				serviceResponse = execute(getServiceIntegration(), logger, "Loan.SearchLoanItems.CreateLoanItems", serviceRequestTO);

			} else {
				logger.logDebug("---------> Actualizar rubro");
				errorMessage = "BUSIN.DLB_BUSIN_ACZAONEXT_35476";
				serviceResponse = execute(getServiceIntegration(), logger, "Loan.SearchLoanItems.UpdateLoanItems", serviceRequestTO);

			}

			if (serviceResponse.isResult()) {
				args.getMessageManager().showSuccessMsg(errorMessage);
				args.setSuccess(true);
			} else {
				MessageManagement.show(serviceResponse, args, new BehaviorOption(true));
				args.setSuccess(false);
			}
		} catch (Exception ex) {
			logger.logError("Error at saveUpdateItem in ItemsManagement class: " + ex);
			args.setSuccess(false);
			throw ex;

		} finally {
			logger.logDebug("Finish saveUpdateItem in ItemsManagement class");

		}

	}

}
