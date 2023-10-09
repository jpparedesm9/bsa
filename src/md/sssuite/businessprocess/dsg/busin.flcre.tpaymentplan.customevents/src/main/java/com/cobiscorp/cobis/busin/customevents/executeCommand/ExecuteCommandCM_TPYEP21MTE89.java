package com.cobiscorp.cobis.busin.customevents.executeCommand;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.bli.OperationBLI;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.AmortizationTableManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
//import javax.ejb.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.CreditOtherData;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.cobis.busin.customevents.bli.ItemsBLI;

public class ExecuteCommandCM_TPYEP21MTE89 extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandCM_TPYEP21MTE89.class);

	public ExecuteCommandCM_TPYEP21MTE89(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso -> ExecuteCommand -> ExecuteCommandCM_TPYEP21MTE89");
			args.setSuccess(false);

			// DECLARAR VARIABLES
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			boolean executeSuccessfully = true;
			int numeroTramite, customerCode;
			String numeroOperacion;

			ApplicationRequest creditApplicationRequest = new ApplicationRequest();
			// EJECUTAR VALIDACIONES
			if (paymentPlanHeader.get(PaymentPlanHeader.AMOUNT).doubleValue() > paymentPlanHeader
					.get(PaymentPlanHeader.APPROVEDAMOUNT).doubleValue()) {
				args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_MOAALDRON_83113");
				return;
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Customer Code ----->" + paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERCODE));

			// INICIALIZAR VARIABLES

			// entities.PaymentPlanHeader.customerCode

			numeroTramite = paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED);
			customerCode = paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERCODE);
			if (originalHeader.get(OriginalHeader.OPNUMBERBANK) != null)
				numeroOperacion = originalHeader.get(OriginalHeader.OPNUMBERBANK);
			else
				numeroOperacion = String.valueOf(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));

			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			cobiscorp.ecobis.loan.dto.LoanResponse loanResponseDTO = tranManager.getLoanTmp(numeroOperacion, args,
					new BehaviorOption(true));

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("------>loanResponseDTO.getProductType() Inicial " + loanResponseDTO.getProductType());

			// para validar que la suma del reclaculo no sea mayor o igual al
			// monto
			// primer desembolso y al monto propuesto

			String numeroTramiteOG = originalHeader.get(OriginalHeader.IDREQUESTED);
			ApplicationResponse applicationResponseDTO = tranManager.getApplication(Integer.parseInt(numeroTramiteOG),
					args, new BehaviorOption(true));

			String expromision = originalHeader.get(OriginalHeader.EXPROMISSION);

			// Se valida que El Monto no puede ser menor a la suma del Saldo de
			// las
			// Operaciones solo para Refinanciento
			if (IsRefinancing(applicationResponseDTO) && (expromision == null)) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("---->Log 1");
				BigDecimal changedAmountReBigDecimalAomunt = paymentPlanHeader.get(PaymentPlanHeader.AMOUNT);
				BigDecimal changedAmountReBigDecimalApprovedAmount = paymentPlanHeader
						.get(PaymentPlanHeader.APPROVEDAMOUNT);
				BigDecimal suma1 = sumRefinancingAmount(entities, args, super.getServiceIntegration());
				paymentPlanHeader.set(PaymentPlanHeader.SUMAMOUNT, suma1);
				// Se compara si el monto es menor igual que la suma de las
				// operaciones
				if (changedAmountReBigDecimalAomunt.floatValue() < suma1.floatValue()
						&& (changedAmountReBigDecimalApprovedAmount.floatValue() < suma1.floatValue())) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("---->Log 2");
					MessageManagement.show(args,
							new MessageOption("BUSIN.DLB_BUSIN_AMUNLLPTS_86896", MessageLevel.ERROR, true));
					return;
				} else {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("---->Log 3");
					if (paymentPlanHeader.get(PaymentPlanHeader.OPERATIONCODE) > 0) { // &&
																						// paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE).equals(loanResponseDTO.getProductType())
						// &&
						// paymentPlanHeader.get(PaymentPlanHeader.CURRENCY).equals(loanResponseDTO.getCurrency()))
						// {
						// OPERACION YA EXISTE, LA MODIFICA
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 4");
						if (OperationBLI.UpdateLoanTmp(entities, args, super.getServiceIntegration(),
								loanResponseDTO.getCode())) {
							// SI SE MODIFICA OK -> RECUPERA NUEVOS DATOS
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 5");
							fillData(numeroTramite, numeroOperacion, entities, args, "BUSIN.DLB_BUSIN_IEJTAITMT_92625");
						} else {
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 6");
							// ERROR AL MODIFICAR
							args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UJERDOEAN_89022");
							return;
						}
					} else {// NO HAY OPERACION, LA CREA
						if (paymentPlanHeader.get(PaymentPlanHeader.OPERATIONCODE) > 0) {
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 7");
							// 2.- Borra Operacion de tablas temporales
							if (!tranManager.deleteTmpTables(numeroOperacion, args, new BehaviorOption(true))) {
								if (LOGGER.isDebugEnabled())
									LOGGER.logDebug("---->Log 8");
								args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_RLRMATEPL_28992");
								return;
							}
						}
						if (OperationBLI.CreateLoanTmp(entities, args, super.getServiceIntegration())) {
							// SI SE CREA OK -> RECUPERA NUEVOS DATOS
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 9");
							fillData(numeroTramite, numeroOperacion, entities, args, "BUSIN.DLB_BUSIN_OPINCSATE_87941");
						} else {
							// ERROR AL CREAR
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 10");
							args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UEORLRORN_22012");
							return;
						}
					}

				}

			} else {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("---->Log 11");
				if (paymentPlanHeader.get(PaymentPlanHeader.OPERATIONCODE) > 0) { // &&
																					// paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE).equals(loanResponseDTO.getProductType())
					// &&
					// paymentPlanHeader.get(PaymentPlanHeader.CURRENCY).equals(loanResponseDTO.getCurrency()))
					// {
					// OPERACION YA EXISTE, LA MODIFICA
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("---->Log 12");
						LOGGER.logDebug("---->UpdateLoanTmp i_toperacion: "
								+ paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE));
					}
					if (OperationBLI.UpdateLoanTmp(entities, args, super.getServiceIntegration(),
							loanResponseDTO.getCode())) {
						// SI SE MODIFICA OK -> RECUPERA NUEVOS DATOS
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 13");
						fillData(numeroTramite, numeroOperacion, entities, args, "BUSIN.DLB_BUSIN_IEJTAITMT_92625");
					} else {
						// ERROR AL MODIFICAR
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 14");
						args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UJERDOEAN_89022");
						return;
					}
				} else {// NO HAY OPERACION, LA CREA
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("---->Log 15");
					if (paymentPlanHeader.get(PaymentPlanHeader.OPERATIONCODE) > 0) {
						// 2.- Borra Operacion de tablas temporales
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 16");
						if (!tranManager.deleteTmpTables(numeroOperacion, args, new BehaviorOption(true))) {
							if (LOGGER.isDebugEnabled())
								LOGGER.logDebug("---->Log 17");
							args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_RLRMATEPL_28992");
							return;
						}
					}
					if (OperationBLI.CreateLoanTmp(entities, args, super.getServiceIntegration())) {
						// SI SE CREA OK -> RECUPERA NUEVOS DATOS
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 18");
						fillData(numeroTramite, numeroOperacion, entities, args, "BUSIN.DLB_BUSIN_OPINCSATE_87941");
					} else {
						// ERROR AL CREAR
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Log 19");
						args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UEORLRORN_22012");
						return;
					}
				}

				// nombre de la frecuencia de pago
				if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {
					CatalogDto frecuencyCatalogDto = OperationBLI.getFrecuencyCatalog(
							originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim(), args, getServiceIntegration());
					if (frecuencyCatalogDto != null) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false),
								frecuencyCatalogDto.getName());
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("---->Frecuencia de Pago: " + frecuencyCatalogDto.getName());
					}
				}

				DataEntity creditOtherData = entities.getEntity(CreditOtherData.ENTITY_NAME);
				creditApplicationRequest.setIdrequested(numeroTramite);
				creditApplicationRequest.setType(originalHeader.get(OriginalHeader.TYPEREQUEST));
				creditApplicationRequest.setActivity(creditOtherData.get(CreditOtherData.ACTIVITYDESTINATIONCREDIT));
				creditApplicationRequest.setObjectCredit(creditOtherData.get(CreditOtherData.CREDITPORPUSE));
				creditApplicationRequest.setDestination(creditOtherData.get(CreditOtherData.CREDITDESTINATION));
				creditApplicationRequest.setFoundsSource(creditOtherData.get(CreditOtherData.SOURCEOFFUNDING));
				creditApplicationRequest
						.setOfficerDescription(creditOtherData.get(CreditOtherData.DESCRIPTIONDESTINATIONREQUESTED));
				/*
				 * JCA if (Compare.ForString(originalHeader.get(OriginalHeader.
				 * STATUSREQUESTED), Mnemonic.STRING_A)) { if (logger.isDebugEnabled())
				 * logger.logDebug("---->Log 20");
				 * creditApplicationRequest.setStatusValidate(Mnemonic.CHAR_N); } Jca
				 */
				// CPN se elimina porque no requiere actualizar datos del
				// tramite
				// if (tranManager.updateApplication(creditApplicationRequest,
				// new
				// DebtorRequest(), args, new BehaviorOption(true))) {
				// logger.logDebug("---->Log 21");
				// args.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
				// args.setSuccess(true);
				// }
				// **************************************fin de valor de la
				// cuota
			}

			// Valida si es Crédito con Convenio.
			if (OperationBLI.validateRequestWithAgreement(entities)) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("---->Log 22");
				args.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_CETDOVENI_82322");
			}

			String paymentFrequency = paymentPlan.get(PaymentPlan.TERMTYPE) == null ? ""
					: paymentPlan.get(PaymentPlan.TERMTYPE);
			Integer plazo = paymentPlan.get(PaymentPlan.TERM) == null ? 0 : paymentPlan.get(PaymentPlan.TERM);
			AmortizationTableManagement amortizationTableManagement = new AmortizationTableManagement(
					super.getServiceIntegration());

			executeSuccessfully = amortizationTableManagement.validateTermAndPaymentFrecuency(paymentFrequency, plazo,
					paymentPlanHeader.get(PaymentPlanHeader.PRODUCTTYPE), entities, args);

			if (executeSuccessfully) {
				args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_OPINCSATE_87941");
			}
			args.setSuccess(executeSuccessfully);
		} catch (BusinessException be) {
			LOGGER.logDebug("be.getMessage()>>" + be.getMessage() + " getCause()>>" + be.getCause()
					+ "be.getClientErrorMessage()>>" + be.getClientErrorMessage());
			ExceptionUtils.showError(be.getMessage(), be, args, LOGGER);
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_EXECUTE_AMORTIZATION, ex, args,
					LOGGER);
		}
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida -> ExecuteCommand -> ExecuteCommandCM_TPYEP21MTE89");
	}

	public void fillData(int numeroTramite, String numeroOperacion, DynamicRequest entities,
			IExecuteCommandEventArgs args, String messadeResource) throws Exception {
		try {
			// 1.- ACTUALIZA MONTOS DEL TRAMITE
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("---->Log filldata 1");
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			/*
			 * jca DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			 * 
			 * ApplicationRequest applicationRequest = new ApplicationRequest();
			 * applicationRequest.setIdrequested(numeroTramite);// @i_tramite
			 * applicationRequest.setType(Mnemonic.STRING_O);// @i_tipo applicationRequest
			 * .setMoney(paymentPlanHeader.get(PaymentPlanHeader.CURRENCY));
			 * applicationRequest .setAmount(paymentPlanHeader.get(PaymentPlanHeader
			 * .APPROVEDAMOUNT).doubleValue()); // @i_monto
			 * applicationRequest.setDisbursementAmount
			 * (paymentPlanHeader.get(PaymentPlanHeader
			 * .AMOUNT).doubleValue());// @i_monto_desembolso
			 * applicationRequest.setProduct(Mnemonic.MODULECCA); // @i_producto
			 * applicationRequest .setEffect(paymentPlanHeader.get(PaymentPlanHeader
			 * .DEBIT).toString()); // @i_efecto Calendar initalDate =
			 * Calendar.getInstance();
			 * initalDate.setTime(paymentPlanHeader.get(PaymentPlanHeader .INITIALDATE));
			 * applicationRequest.setStartDate(initalDate); //
			 * 
			 * @i_fecha_inicio applicationRequest.setOpertationType(originalHeader
			 * .get(OriginalHeader.PRODUCTTYPE)); // @i_toperacion applicationRequest
			 * .setClient(paymentPlanHeader.get(PaymentPlanHeader .CUSTOMERCODE));
			 * // @i_cliente if (logger.isDebugEnabled())
			 * logger.logDebug("---->Log filldata fecha inicio: " + initalDate.getTime());
			 * if (Compare.ForString(originalHeader.get(OriginalHeader .STATUSREQUESTED),
			 * Mnemonic.STRING_A)) { if (logger.isDebugEnabled())
			 * logger.logDebug("---->Log filldata 2");
			 * applicationRequest.setStatusValidate(Mnemonic.CHAR_N); } if
			 * (Compare.ForString(context.get(Context.REQUESTSTAGE),
			 * Mnemonic.STAGE_PAYMENT_PLAN)) { if (logger.isDebugEnabled())
			 * logger.logDebug("---->Log filldata 3"); if
			 * ((originalHeader.get(OriginalHeader.SCORETYPE) != null) &&
			 * originalHeader.get(OriginalHeader.SCORETYPE).equals(Mnemonic.
			 * SCORETYPE_BUSINESSMANUAL)) { if (logger.isDebugEnabled())
			 * logger.logDebug("---->Log filldata 4"); applicationRequest.setScore
			 * (Convert.CString.toDBNullAsString(originalHeader
			 * .get(OriginalHeader.SCORE))); } else { if (logger.isDebugEnabled())
			 * logger.logDebug("---->Log filldata 5");
			 * applicationRequest.setScore(Format.DB_NULL); } applicationRequest.
			 * setIsWarrantyDestination(Convert.CCharacter.toDBNullAsString
			 * (originalHeader.get(OriginalHeader.ISWARRANTYDESTINATION))); } DebtorRequest
			 * debtorRequest = new DebtorRequest(); debtorRequest.setDebtorCode
			 * (paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERCODE)); //
			 * 
			 * @i_cliente_cca // CPN se elimina porque no se requiere efectuar la
			 * actualización // del // trámite TransactionManagement transactionManagement =
			 * new TransactionManagement(super.getServiceIntegration());
			 * transactionManagement.updateApplication(applicationRequest, debtorRequest,
			 * args, new BehaviorOption(true));
			 * 
			 * // 2.- BUSCA DATOS DE LA OPERACION if
			 * (!OperationBLI.getAndMapping(numeroOperacion, entities, args,
			 * super.getServiceIntegration())) { args.getMessageManager().showErrorMsg
			 * ("BUSIN.DLB_BUSIN_SUOCRPECI_30419"); return; }
			 */
			// 3.- BUSCA TABLA DE AMORTIZACION
			AmortizationTableManagement amortizationTableManagement = new AmortizationTableManagement(
					super.getServiceIntegration());
			amortizationTableManagement.getAndMapAmortizationTableTmp(numeroOperacion, entities, args,
					new BehaviorOption(true));

			// 4.- RECUPERA RUBROS
			ItemsBLI.read(entities, args, numeroOperacion, super.getServiceIntegration());
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("---->Log filldata 8");

		} catch (BusinessException bex) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Business Exception:" + bex);
			throw bex;
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Error en el método fillData " + ex.getMessage());
			throw ex;
		}
	}

	private static boolean IsRefinancing(ApplicationResponse applicationResponseDTO) {
		return (applicationResponseDTO.getType().equals(Mnemonic.REFINANCINGREQUEST));
	}

	private static boolean IsRefinancing(String type) {
		return (type.equals(Mnemonic.REFINANCINGREQUEST));
	}

	public static BigDecimal sumRefinancingAmount(DynamicRequest entities, IExecuteCommandEventArgs arg1,
			ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		int currencyDestination = Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED));
		int numeroTramite = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));
		BigDecimal amountRequested = new BigDecimal(0);
		if (IsRefinancing(originalHeader.get(OriginalHeader.TYPEREQUEST))) { // SOLO
																				// CUANDO
																				// ES
																				// UNA
																				// Refinanciamiento
			OperationManagement operationManagement = new OperationManagement(serviceIntegration);
			amountRequested = operationManagement.calculateAmountInAnyCurrency(currencyDestination, numeroTramite,
					arg1);
			if (amountRequested == null) {
				amountRequested = new BigDecimal(0);
			}
		}
		return amountRequested;
	}

}
