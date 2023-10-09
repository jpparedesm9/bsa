package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProratedRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProratedResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewDataResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.collateral.dto.CustomerCollateralRequest;
import cobiscorp.ecobis.collateral.dto.PolicyAllInformation;
import cobiscorp.ecobis.collateral.dto.PolicyData;
import cobiscorp.ecobis.collateral.dto.SharedEntityRequest;
import cobiscorp.ecobis.collateral.dto.UpdateCollateralRequest;
import cobiscorp.ecobis.collateral.dto.UpdateCollateralResponse1;
import cobiscorp.ecobis.collateral.dto.UpdateCollateralResponse2;
import cobiscorp.ecobis.comext.dto.BankGuaranteeRequest;
import cobiscorp.ecobis.comext.dto.BankGuaranteeResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanrequest.general.dto.CommonParams;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.CustomerSearch;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.OtherWarranty;
import com.cobiscorp.cobis.busin.model.PersonalGuarantor;
import com.cobiscorp.cobis.busin.model.SharedEntityWarranty;
import com.cobiscorp.cobis.busin.model.WarrantyDescription;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.busin.model.WarrantyLocation;
import com.cobiscorp.cobis.busin.model.WarrantySituation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GuaranteeManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(GuaranteeManagement.class);
	private boolean hasErrorIfExists = false;
	private RenewLoanResponse[] readCustomerOperation;
	private final Integer FILIAL = 1;

	public GuaranteeManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean getHasErrorIfExists() {
		return hasErrorIfExists;
	}

	public void setHasErrorIfExists(boolean hasErrorIfExists) {
		this.hasErrorIfExists = hasErrorIfExists;
	}

	public RenewLoanResponse[] getReadCustomerOperation() {
		return readCustomerOperation;
	}

	// EJECUCIÓN GENERAR LOS DATOS REQUERIDOS DESDE ORIGINADOR. (VNR, prorrateo
	// y relación garantía)
	// ESTE DEBERIA EJECUTARSE AL MOMENTO DE TENER TODAS LAS GARANTÍAS ESCOGIDAS
	// Y SE DEBERÍA VALIDAR QUE LA SUMATORIA DEL PRORRATEO DEN EL 100%
	public ProratedResponse[] calculateProrratea(Integer requestID, Double amountRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("Ingreso al servicio calculateProrratea tramit: " + requestID);
		ProratedRequest proratedRequest = new ProratedRequest();
		proratedRequest.setRequestId(requestID);
		proratedRequest.setAmount(amountRequest);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INPRORATEDREQUEST, proratedRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEVALIDATIONGUARANTEEPRORATED, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO DE calculateProrratea - requestID: " + proratedRequest.getRequestId());
			ServiceResponseTO serviceItemResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ProratedResponse[]) serviceItemResponseTO.getValue(ReturnName.RETURNPRORATEDRESPONSE);
		} else {
			logger.logDebug("problema con servicio calculateProrratea " + requestID);
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public static void searchCollateral(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntityList collateralLoadEntity1 = new DataEntityList();
		DataEntityList collateralLoadEntity2 = new DataEntityList();
		int idRequest = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		CollateralManagement collateralMngmt = new CollateralManagement(serviceIntegration);
		CollateralApplicationResponse[] collateralsResponse = collateralMngmt.searchCollateral(idRequest, arg1, new BehaviorOption(true));

		if (collateralsResponse != null) {

			GuaranteeManagement guaranteeManagement = new GuaranteeManagement(serviceIntegration);
			TransactionManagement transactionManagement = new TransactionManagement(serviceIntegration);
			ApplicationResponse applicationResponse = transactionManagement.getApplication(idRequest, arg1, new BehaviorOption(false));

			// Se cambio de getAmount a getAmountRequested()
			// porque en el ingreso de garantias el tr_monto es 0.0

			// IMPORTANTE SE COMENTA EL PRORRATEO PARA QUE NO REALICE VERIFICAR
			// ESTE TEMA
			// ProratedResponse proratedResponses[] = null;
			// proratedResponses =
			// guaranteeManagement.calculateProrratea(idRequest,
			// applicationResponse.getAmountRequested(), arg1, new
			// BehaviorOption(false));
			// double totalProrrateo = 0.0;

			for (CollateralApplicationResponse collateralResponse : collateralsResponse) {
				DataEntity collateral = new DataEntity();
				if (String.valueOf(Mnemonic.CHAR_S).equals(collateralResponse.getIsPersonal())) {

					// collateral.set(PersonalGuarantor.ISHERITAGE, 'S');
					collateral.set(PersonalGuarantor.CODEWARRANTY, collateralResponse.getCollateralCode());
					collateral.set(PersonalGuarantor.TYPE, collateralResponse.getType());// getStatus()
					collateral.set(PersonalGuarantor.DESCRIPTION, collateralResponse.getCollateralDescription());
					collateral.set(PersonalGuarantor.GUARANTORPRIMARYSECONDARY, collateralResponse.getGuarantor());
					collateral.set(PersonalGuarantor.CLASSOPEN, collateralResponse.getClassOpen());
					collateral.set(PersonalGuarantor.IDCUSTOMER, collateralResponse.getIdentification());
					collateral.set(PersonalGuarantor.STATE, collateralResponse.getStatus());
					collateral.set(PersonalGuarantor.RELATION, collateralResponse.getRelation());// NTG
																									// prelacion
																									// de
																									// garantia
					collateral.set(PersonalGuarantor.DATECIC, collateralResponse.getDateCIC() != null ? collateralResponse.getDateCIC().getTime() : null);
					collateral.set(PersonalGuarantor.CURRENTVALUE, collateralResponse.getCurrentValue());
					collateral.set(PersonalGuarantor.CURRENCY, collateralResponse.getCurrency());
					collateralLoadEntity1.add(collateral);

				} else {

					// collateral.set(OtherWarranty.CODEWARRANTY,
					// collateralResponse.getCollateralCode());
					// collateral.set(OtherWarranty.VALUEAPPORTIONMENT,
					// collateralResponse.getProductValue());
					// collateral.set(PersonalGuarantor.ISHERITAGE, 'S');
					collateral.set(OtherWarranty.TYPE, collateralResponse.getType());// //getStatus()
					collateral.set(OtherWarranty.DESCRIPTION, collateralResponse.getCollateralDescription());
					collateral.set(OtherWarranty.INITIALVALUE, collateralResponse.getInitialValue());
					collateral.set(OtherWarranty.DATEAPPRAISEDVALUE,
							collateralResponse.getDateLastAppraisal() == null ? "" : Convert.CCalendar.toString(collateralResponse.getDateLastAppraisal()));
					collateral.set(OtherWarranty.CLASSOPEN, collateralResponse.getClassOpen());
					collateral.set(OtherWarranty.VALUEAVAILABLE, collateralResponse.getValueUSD());
					collateral.set(OtherWarranty.IDCUSTOMER, collateralResponse.getIdentification());
					collateral.set(OtherWarranty.NAMEGAR, collateralResponse.getGuarantor());
					collateral.set(OtherWarranty.STATE, collateralResponse.getStatusId()); // getStatus()
																							// se
																							// cambia
																							// para
																							// mostrar
																							// palabra
																							// completa
																							// en
																							// frontEnd
					collateral.set(OtherWarranty.CODEWARRANTY, collateralResponse.getCollateralCode());
					collateral.set(PersonalGuarantor.RELATION, collateralResponse.getRelation());// NTG
																									// prelacion
																									// de
																									// garantia

					// Se comenta es para validacion del prorrateo
					// double[] valor = getProrrateo(proratedResponses,
					// collateralResponse.getCollateralCode());
					collateral.set(OtherWarranty.VALUEAPPORTIONMENT, new BigDecimal(0));
					collateral.set(OtherWarranty.VALUEVNR, new BigDecimal(0));
					collateral.set(OtherWarranty.RELATIONSHIPGUARANTEES, new Double(0));
					// totalProrrateo = totalProrrateo + valor[0];

					collateralLoadEntity2.add(collateral);
				}
			}
			// Se comenta es para validacion del prorrateo
			// if (totalProrrateo < 1.0) {
			// // Las Garantías no han Cubierto
			// if (logger.isDebugEnabled())
			// logger.logDebug("GuaranteeManagement -> Las Garantías no han Cubierto, el valor de prorrateo es: ("
			// + totalProrrateo + ")");
			// MessageManagement.show(arg1, new
			// MessageOption("BUSIN.DLB_BUSIN_AANTHANUI_09242",
			// MessageLevel.INFO, true));
			// } else {
			// // Las Garantías han Cubierto
			// MessageManagement.show(arg1, new
			// MessageOption("BUSIN.DLB_BUSIN_LGRATHNBT_41720",
			// MessageLevel.INFO, true));
			// }
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("GuaranteeManagement -> SIN GARANTIAS PARA idRequest = (" + idRequest + ")");
		}
		entities.setEntityList(PersonalGuarantor.ENTITY_NAME, collateralLoadEntity1);
		entities.setEntityList(OtherWarranty.ENTITY_NAME, collateralLoadEntity2);
	}

	public static double[] getProrrateo(ProratedResponse proratedResponses[], String WaranteeCod) {
		double[] retorno = new double[3];
		retorno[0] = 0.0;
		retorno[1] = 0.0;
		retorno[2] = 0.0;
		if (proratedResponses != null) {
			if (proratedResponses.length > 0) {
				for (ProratedResponse proratedResponse : proratedResponses) {
					if (proratedResponse.getGuaranteeCod().equals(WaranteeCod)) {
						retorno[0] = proratedResponse.getProrated();
						retorno[1] = proratedResponse.getValueVNR();
						retorno[2] = proratedResponse.getValueRelGar();
						return retorno;
					}
				}
			}
		}
		return retorno;
	}

	public void isWarrantiesHeritageLine(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {

		logger.logDebug("Declaracion de Variables");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntityList otherWarranties = entities.getEntityList(OtherWarranty.ENTITY_NAME);
		DataEntityList personalWarranties = entities.getEntityList(PersonalGuarantor.ENTITY_NAME);

		int idRequestWarrantie = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		logger.logDebug("Declaracion de Servicios");
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		CreditLineManagement lineManagment = new CreditLineManagement(super.getServiceIntegration());
		CollateralManagement collateralMngmt = new CollateralManagement(serviceIntegration);

		logger.logDebug("Recuperacion de Tramite y busqueda de lineas de credito");
		ApplicationResponse applicationResponseDTO = transactionManagement.getApplication(idRequestWarrantie, arg1, new BehaviorOption(true));
		LineCreditData lineResponse = null;

		if (applicationResponseDTO.getLineComext() != null && !applicationResponseDTO.getLineComext().trim().isEmpty()) {
			lineResponse = lineManagment.getByBank(applicationResponseDTO.getLineComext(), arg1, new BehaviorOption(true));
		}
		if (applicationResponseDTO.getCreditLineNumBank() != null && !applicationResponseDTO.getCreditLineNumBank().trim().isEmpty()) {
			lineResponse = lineManagment.getByBank(applicationResponseDTO.getCreditLineNumBank(), arg1, new BehaviorOption(true));
		}

		logger.logDebug("Recuperacion de Garantias");
		CollateralApplicationResponse[] collateralsLineResponse = null;
		if (lineResponse != null) {
			int idRequestLine = lineResponse.getCreditCode();
			collateralsLineResponse = collateralMngmt.searchCollateral(idRequestLine, arg1, new BehaviorOption(true));
		}

		if (collateralsLineResponse != null) {
			for (DataEntity otherWarrts : otherWarranties) {

				logger.logDebug("EN FOR GANRANTIA:");
				for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
					if (otherWarrts.get(OtherWarranty.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
						otherWarrts.set(OtherWarranty.ISHERITAGE, 'S');
						break;
					} else {
						otherWarrts.set(OtherWarranty.ISHERITAGE, 'N');
					}
				}
			}

			for (DataEntity personWarrts : personalWarranties) {
				logger.logDebug("EN FOR GANRANTIA:");
				for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
					if (personWarrts.get(PersonalGuarantor.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
						personWarrts.set(PersonalGuarantor.ISHERITAGE, 'S');
						break;
					} else {
						personWarrts.set(PersonalGuarantor.ISHERITAGE, 'N');
					}
				}
			}
		}

		logger.logDebug("Seteo a nueva lista de data entities list");
		DataEntityList personalWarrantiesNew = new DataEntityList();
		DataEntityList otherWarrantiesNew = new DataEntityList();

		personalWarrantiesNew.addAll(personalWarranties);
		otherWarrantiesNew.addAll(otherWarranties);

		entities.setEntityList(PersonalGuarantor.ENTITY_NAME, personalWarrantiesNew);
		entities.setEntityList(OtherWarranty.ENTITY_NAME, otherWarrantiesNew);

	}

	public void isWarrantiesHeritage(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntityList otherWarranties = entities.getEntityList(OtherWarranty.ENTITY_NAME);
		DataEntityList personalWarranties = entities.getEntityList(PersonalGuarantor.ENTITY_NAME);
		// DataEntity headerGuaranteeSticket =
		// entities.getEntity(HeaderGuaranteesTicket.ENTITY_NAME);
		CollateralManagement collateralMngmt = new CollateralManagement(serviceIntegration);
		BankGuaranteeResponse bankGuaranteeResponse = null;
		int tramiteAnterior = 0;

		if (originalHeader.get(OriginalHeader.APPLICATIONNUMBER) != null) {
			bankGuaranteeResponse = QueryBankGuarantee(originalHeader.get(OriginalHeader.APPLICATIONNUMBER), null, "N", arg1, new BehaviorOption(true));
		}
		if (bankGuaranteeResponse != null) {
			bankGuaranteeResponse = QueryBankGuarantee(null, bankGuaranteeResponse.getReference(), bankGuaranteeResponse.getRenewal(), arg1, new BehaviorOption(true));
			tramiteAnterior = bankGuaranteeResponse.getApprovalNumber();
		}

		CollateralApplicationResponse[] collateralsLineResponse = collateralMngmt.searchCollateral(tramiteAnterior, arg1, new BehaviorOption(true));
		if (collateralsLineResponse != null) {
			logger.logDebug("CON DATOS" + otherWarranties.size());
			for (DataEntity otherWarrts : otherWarranties) {
				logger.logDebug("EN FOR GANRANTIA:");
				for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
					logger.logDebug("GANRANTIA:" + otherWarrts.get(OtherWarranty.CODEWARRANTY) + "---->>" + collateralsRequestResp.getCollateralCode());
					if (otherWarrts.get(OtherWarranty.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
						otherWarrts.set(OtherWarranty.ISHERITAGE, 'S');
						break;
					} else {
						otherWarrts.set(OtherWarranty.ISHERITAGE, 'N');
					}
				}
			}
			logger.logDebug("CON DATOS DEPUES" + otherWarranties.size());
			entities.setEntityList(OtherWarranty.ENTITY_NAME, otherWarranties);
			logger.logDebug("CON DATOS PERSONAL" + personalWarranties.size());
			for (DataEntity personWarrts : personalWarranties) {
				for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
					if (personWarrts.get(PersonalGuarantor.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
						personWarrts.set(PersonalGuarantor.ISHERITAGE, 'S');
						break;
					} else {
						personWarrts.set(PersonalGuarantor.ISHERITAGE, 'N');
					}
				}
			}
			entities.setEntityList(PersonalGuarantor.ENTITY_NAME, personalWarranties);
		}
	}

	public void isWarrantiesHeritageOtherRequest(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntityList otherWarranties = entities.getEntityList(OtherWarranty.ENTITY_NAME);
		DataEntityList personalWarranties = entities.getEntityList(PersonalGuarantor.ENTITY_NAME);
		CollateralManagement collateralMngmt = new CollateralManagement(serviceIntegration);
		int tramiteAnterior = 0;

		int idRequestWarrantie = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		// RECUPERAR OPERACIONES
		RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		renewDataRequest.setNumRequest(idRequestWarrantie);
		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		renewDataRequest.setCustomerId(-1); // MANDO ESTE VALOR PORQUE EL SP
											// VALIDA QUE NO SE null
		RenewLoanResponse[] readOperations = this.searchCustomerOperations(renewDataRequest, arg1, new BehaviorOption(true));
		if (readOperations != null) {
			for (RenewLoanResponse renewDataResponse : readOperations) {
				tramiteAnterior = renewDataResponse.getNumRequest();
				CollateralApplicationResponse[] collateralsLineResponse = collateralMngmt.searchCollateral(tramiteAnterior, arg1, new BehaviorOption(true));

				if (collateralsLineResponse != null) {
					logger.logDebug("CON DATOS" + otherWarranties.size());
					for (DataEntity otherWarrts : otherWarranties) {
						logger.logDebug("EN FOR GANRANTIA:");
						for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
							logger.logDebug("GANRANTIA:" + otherWarrts.get(OtherWarranty.CODEWARRANTY) + "---->>" + collateralsRequestResp.getCollateralCode());

							if (otherWarrts.get(OtherWarranty.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
								otherWarrts.set(OtherWarranty.ISHERITAGE, 'S');
								break;
							} else {
								otherWarrts.set(OtherWarranty.ISHERITAGE, 'N');
							}
						}
					}
					logger.logDebug("CON DATOS DEPUES" + otherWarranties.size());
					entities.setEntityList(OtherWarranty.ENTITY_NAME, otherWarranties);
					logger.logDebug("CON DATOS PERSONAL" + personalWarranties.size());
					for (DataEntity personWarrts : personalWarranties) {
						for (CollateralApplicationResponse collateralsRequestResp : collateralsLineResponse) {
							if (personWarrts.get(PersonalGuarantor.CODEWARRANTY).equals(collateralsRequestResp.getCollateralCode())) {
								personWarrts.set(PersonalGuarantor.ISHERITAGE, 'S');
								break;
							} else {
								personWarrts.set(PersonalGuarantor.ISHERITAGE, 'N');
							}
						}
					}
					entities.setEntityList(PersonalGuarantor.ENTITY_NAME, personalWarranties);
				}

			}
		}

	}

	public boolean saveCollateral(DynamicRequest entities, Integer idRequest, ICommonEventArgs arg1) {
		boolean saveisOk = true;

		DataEntityList collaterals = entities.getEntityList(PersonalGuarantor.ENTITY_NAME);
		DataEntityList collateralg = entities.getEntityList(OtherWarranty.ENTITY_NAME);
		DataEntity entityClient = entities.getEntity("EntityClient");

		logger.logDebug("Datos del cliente" + entities.getEntity("EntityClient").getData());
		// Recuperacion de la entidad temporal del cliente para recuérar el id
		// del cliente
		String clientId = entityClient.get(new Property<String>("clientId", String.class, false));

		CollateralManagement collateralMngmt = new CollateralManagement(super.getServiceIntegration());
		CollateralApplicationRequest collateralApplicationRequest;

		// 1.- GARANTIA PERSONAL
		for (DataEntity dataEntity : collaterals) {
			collateralApplicationRequest = new CollateralApplicationRequest();
			collateralApplicationRequest.setIdrequested(idRequest);
			collateralApplicationRequest.setWarranty(dataEntity.get(PersonalGuarantor.CODEWARRANTY));
			collateralApplicationRequest.setDebtorId(Integer.valueOf(clientId));
			collateralApplicationRequest.setClassOpen(dataEntity.get(PersonalGuarantor.CLASSOPEN));
			collateralApplicationRequest.setState(dataEntity.get(PersonalGuarantor.STATE));
			collateralApplicationRequest.setPercentageCover(0.0);
			collateralApplicationRequest.setValueCover(0.0);
			if (dataEntity.get(PersonalGuarantor.DATECIC) != null) {
				collateralApplicationRequest.setDateCIC(Convert.CDate.toCalendarRaw(dataEntity.get(PersonalGuarantor.DATECIC)));
			}

			boolean respTmp = collateralMngmt.createCollateralApplication(collateralApplicationRequest, arg1, new BehaviorOption(false), true);
			if (!respTmp && !collateralMngmt.getHasErrorIfExists()) {
				saveisOk = false;
			}
		}// fin for

		// 2.- OTROS TIPOS DE GARANTIA
		for (DataEntity dataEntity : collateralg) {
			collateralApplicationRequest = new CollateralApplicationRequest();
			collateralApplicationRequest.setIdrequested(idRequest);
			collateralApplicationRequest.setWarranty(dataEntity.get(OtherWarranty.CODEWARRANTY));
			collateralApplicationRequest.setDebtorId(Integer.valueOf(clientId));
			collateralApplicationRequest.setClassOpen(dataEntity.get(OtherWarranty.CLASSOPEN));
			collateralApplicationRequest.setState(dataEntity.get(OtherWarranty.STATE));
			// collateralApplicationRequesta.setState(dataEntity.get(OtherWarranty.INITIALVALUE));
			collateralApplicationRequest.setPercentageCover(0.0);
			collateralApplicationRequest.setValueCover(0.0);

			boolean respTmp = collateralMngmt.createCollateralApplication(collateralApplicationRequest, arg1, new BehaviorOption(false), true);
			if (!respTmp && !collateralMngmt.getHasErrorIfExists()) {
				saveisOk = false;
			}
		}// fin de for
		return saveisOk;
	}

	public boolean saveWarranty(DynamicRequest entities, ICommonEventArgs arg1) {
		boolean saveisOk = true;
		UpdateCollateralResponse1 response1 = null;
		UpdateCollateralResponse2 response2 = null;
		int indexEnd = -1;
		String guarantor = "";
		int guarantorId = 0;

		DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
		DataEntity warrantySituation = entities.getEntity(WarrantySituation.ENTITY_NAME);
		DataEntity warrantyLocation = entities.getEntity(WarrantyLocation.ENTITY_NAME);
		DataEntity warrantyDescription = entities.getEntity(WarrantyDescription.ENTITY_NAME);
		DataEntityList sharedEntityWarranty = entities.getEntityList(SharedEntityWarranty.ENTITY_NAME);
				
		// Tipo de garantía
		String warrantyType = warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE);

		if (logger.isDebugEnabled())
			logger.logDebug("Inicio saveWarranty -> warrantyType: " + warrantyType + " Code: " + warrantyGeneral.get(WarrantyGeneral.CODE));

		// LoanRequest.Guarantee.InsertCustody
		UpdateCollateralRequest collateralRequest = new UpdateCollateralRequest();

		if (warrantyGeneral.get(WarrantyGeneral.CODE) == null) {
			// Datos para crear la Garantía
			collateralRequest.setFilial(FILIAL);
			collateralRequest.setBranchOffice(1);
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, 3);
			Date sytemDate = cal.getTime();
			collateralRequest.setAdmissionDate(Convert.CDate.toCalendar(sytemDate));
		} else {
			// Datos para actualizar la Garantía
			collateralRequest.setFilial(warrantyGeneral.get(WarrantyGeneral.FILIAL));
			collateralRequest.setBranchOffice(warrantyGeneral.get(WarrantyGeneral.BRANCHOFFICE));
			collateralRequest.setCustody(warrantyGeneral.get(WarrantyGeneral.CODE));
			collateralRequest.setStatus(warrantyGeneral.get(WarrantyGeneral.STATUS));
			collateralRequest.setPart(1); // Para mantenimiento de datos de la
											// garantía
			// collateralRequest.setPart(2); //Cuando se actualiza datos de la
			// sección Póliza
			collateralRequest.setRemoveClient('S'); // Funcionalidad para
													// correcto desempeño
													// sp_cliente_garantia
		}

		if (warrantyType != null && !"".equals(warrantyType)) {
			// Datos Generales
			collateralRequest.setType(warrantyType);
			collateralRequest.setCurrentValue(warrantyGeneral.get(WarrantyGeneral.CURRENTVALUE));
			if (warrantyGeneral.get(WarrantyGeneral.FIXEDTERM) != null && !"".equals(warrantyGeneral.get(WarrantyGeneral.FIXEDTERM))) {
				collateralRequest.setFixedTerm(warrantyGeneral.get(WarrantyGeneral.DOCUMENTNUMBER));
				collateralRequest.setFixedTermAmount(warrantyGeneral.get(WarrantyGeneral.FIXEDTERMAMOUNT));
			}
			if (warrantyGeneral.get(WarrantyGeneral.ACCOUNTAHO) != null && !"".equals(warrantyGeneral.get(WarrantyGeneral.ACCOUNTAHO))) {
				collateralRequest.setAccountAho(warrantyGeneral.get(WarrantyGeneral.DOCUMENTNUMBER));
				collateralRequest.setBalanceAvailable(warrantyGeneral.get(WarrantyGeneral.BALANCEAVAILABLE));
			}
			collateralRequest.setStatus(warrantyGeneral.get(WarrantyGeneral.STATUS));
			collateralRequest.setOffice(warrantyGeneral.get(WarrantyGeneral.OFFICE));
			// caso rdmn 68399: se aumenta el seteo de este campo para la
			// insercion y actualizacion, para llenar el campo
			// i_oficina_contabiliza, se acuerda que debe ser el mismo que
			// oficina
			collateralRequest.setAccountingOffice(warrantyGeneral.get(WarrantyGeneral.OFFICE));
			collateralRequest.setDocumentNumber(warrantyGeneral.get(WarrantyGeneral.DOCUMENTNUMBER));
			if (warrantyGeneral.get(WarrantyGeneral.CONSTITUTIONDATE) != null)
				collateralRequest.setConstitutionDate(Convert.CDate.toCalendar(warrantyGeneral.get(WarrantyGeneral.CONSTITUTIONDATE)));
			collateralRequest.setCurrency(warrantyGeneral.get(WarrantyGeneral.CURRENCY));
			collateralRequest.setSourceValue(warrantyGeneral.get(WarrantyGeneral.VALUESOURCE));
			
			if (warrantySituation.get(WarrantySituation.DEPLETIVE) != null){
				collateralRequest.setDepletive(!(warrantySituation.get(WarrantySituation.DEPLETIVE).equals('N')) ? 'S' : 'N');
			}
				
			if (warrantySituation.get(WarrantySituation.DEPLETIVE).equals('S')){
				collateralRequest.setInitialValue(warrantyGeneral.get(WarrantyGeneral.CURRENTVALUE));	
			}else{
				collateralRequest.setInitialValue(warrantyGeneral.get(WarrantyGeneral.APPRAISALVALUE));
			}
			
			collateralRequest.setAppraisalValue(warrantyGeneral.get(WarrantyGeneral.APPRAISALVALUE));
			if (warrantySituation.get(WarrantySituation.LASTVALUATION) != null)
				collateralRequest.setAppraisalDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.LASTVALUATION)));
				//collateralRequest.setAppraisalDate(Convert.CDate.toCalendar(warrantyGeneral.get(WarrantyGeneral.APPRAISALDATE)));
			collateralRequest.setMnemonicCob(warrantyGeneral.get(WarrantyGeneral.COVERAGE));
			collateralRequest.setPercentageCob(warrantyGeneral.get(WarrantyGeneral.PERCENTAGECOVERAGE));
			collateralRequest.setGuaranteeType(warrantyGeneral.get(WarrantyGeneral.GUARANTORTYPE));
			collateralRequest.setSuitability(warrantyGeneral.get(WarrantyGeneral.SUITABILITY));

			guarantor = warrantyGeneral.get(WarrantyGeneral.GUARANTOR);
			if (guarantor == null) {
				collateralRequest.setGuarantor(null);
			} else {
				indexEnd = guarantor.indexOf("-");
				if (indexEnd > 0) {
					guarantorId = Integer.parseInt(guarantor.substring(0, indexEnd).trim());
					collateralRequest.setGuarantor(guarantorId);
				}
				;
			}

			collateralRequest.setDescription(warrantyGeneral.get(WarrantyGeneral.DESCRIPTION));
			collateralRequest.setInstruction(warrantyGeneral.get(WarrantyGeneral.INSTRUCTION));
			collateralRequest.setOwner(warrantyGeneral.get(WarrantyGeneral.OWNER));

			// Datos de Situación
			if (warrantySituation.get(WarrantySituation.RETIREMENTDATE) != null)
				collateralRequest.setRetirementDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.RETIREMENTDATE)));
			if (warrantySituation.get(WarrantySituation.RETURNDATE) != null)
				collateralRequest.setReturnDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.RETURNDATE)));
			collateralRequest.setSharedValue(warrantySituation.get(WarrantySituation.TOTALINITIALVALUE));
			if (warrantySituation.get(WarrantySituation.CLASSWARRANTY) != null)
				collateralRequest.setOpenClosed("".equals(warrantySituation.get(WarrantySituation.CLASSWARRANTY).trim()) ? '\0' : warrantySituation
						.get(WarrantySituation.CLASSWARRANTY).trim().charAt(0));
			if (warrantySituation.get(WarrantySituation.LEGALSUFFICIENCY) != null)
				collateralRequest.setLegalSufficiency("".equals(warrantySituation.get(WarrantySituation.LEGALSUFFICIENCY).trim()) ? '\0' : warrantySituation
						.get(WarrantySituation.LEGALSUFFICIENCY).trim().charAt(0));
			if (warrantySituation.get(WarrantySituation.SUITABLE) != null)
				collateralRequest.setSuitable("".equals(warrantySituation.get(WarrantySituation.SUITABLE).trim()) ? '\0' : warrantySituation.get(WarrantySituation.SUITABLE).trim()
						.charAt(0));
			if (warrantySituation.get(WarrantySituation.SHAREDTYPE) != null)
				collateralRequest.setShared(warrantySituation.get(WarrantySituation.SHAREDTYPE) ? 'S' : 'N');
			if (warrantySituation.get(WarrantySituation.JUDICIALCOLLECTIONTYPE) != null)
				collateralRequest.setJudicialCollection(warrantySituation.get(WarrantySituation.JUDICIALCOLLECTIONTYPE) ? 'S' : 'N');
			//if (warrantySituation.get(WarrantySituation.INSPECTTYPE) != null)
				//collateralRequest.setInspect(warrantySituation.get(WarrantySituation.INSPECTTYPE) ? 'S' : 'N');
			if (warrantySituation.get(WarrantySituation.GUARANTEEFUND) != null)
				collateralRequest.setGuaranteeFund(warrantySituation.get(WarrantySituation.GUARANTEEFUND) ? "S" : "N");
			if (warrantyDescription.get(WarrantyDescription.PERIODICITY) != null)
				collateralRequest.setPeriodicity(warrantyDescription.get(WarrantyDescription.PERIODICITY));

			//Datos Adicionales de Situacion
			if (warrantySituation.get(WarrantySituation.ADMISSIBILITY) != null)
				collateralRequest.setAdmissibility(warrantySituation.get(WarrantySituation.ADMISSIBILITY));
			if (warrantySituation.get(WarrantySituation.CONSTITUTION) != null)
				collateralRequest.setConstitutionDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.CONSTITUTION)));
			if (warrantySituation.get(WarrantySituation.LASTVALUATION) != null)
				collateralRequest.setLastValuationDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.LASTVALUATION)));
			if (warrantySituation.get(WarrantySituation.EXPIRATION) != null)
				collateralRequest.setExpirationDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.EXPIRATION)));
			if (warrantySituation.get(WarrantySituation.LEGALSTATUS) != null)
				collateralRequest.setLegalStatusDate(Convert.CDate.toCalendar(warrantySituation.get(WarrantySituation.LEGALSTATUS)));
			collateralRequest.setInstruction(warrantySituation.get(WarrantySituation.INSTRUCTION));
			if (warrantySituation.get(WarrantySituation.AMOUNT) != null)
				collateralRequest.setAmount(warrantySituation.get(WarrantySituation.AMOUNT));
			if (warrantySituation.get(WarrantySituation.PENALTY) != null)
				collateralRequest.setPenalty(!(warrantySituation.get(WarrantySituation.PENALTY).equals('N')) ? 'S' : 'N');
				//collateralRequest.setPenalty(!(warrantySituation.get(WarrantySituation.PENALTY).equals('\0')) ? 'S' : 'N');
			
			
			if (warrantySituation.get(WarrantySituation.EXPIRATIONCONTROL) != null){
				if ((warrantySituation.get(WarrantySituation.EXPIRATIONCONTROL).equals('1'))){
					collateralRequest.setProposal(1);	
				}else{
					collateralRequest.setProposal(0);
				}
			}
				
			if (warrantySituation.get(WarrantySituation.COMMERCIALORINDUSTRY) != null)
				collateralRequest.setCommercialOrIndustry(!(warrantySituation.get(WarrantySituation.COMMERCIALORINDUSTRY).equals('N')) ? 'S' : 'N');
				//collateralRequest.setCommercialOrIndustry(!(warrantySituation.get(WarrantySituation.COMMERCIALORINDUSTRY).equals('\0')) ? 'S' : 'N');
			if (warrantySituation.get(WarrantySituation.SINISTER) != null)
				collateralRequest.setSinister(!(warrantySituation.get(WarrantySituation.SINISTER).equals('N')) ? 'S' : 'N');
				//collateralRequest.setSinister(!(warrantySituation.get(WarrantySituation.SINISTER).equals('\0')) ? 'S' : 'N');

			// Datos de Localización
			collateralRequest.setCollateralPhone(warrantyLocation.get(WarrantyLocation.PHONE));
			if (warrantyLocation.get(WarrantyLocation.CITY) != null)
				collateralRequest.setCollateralCity(warrantyLocation.get(WarrantyLocation.CITY).toString());
			collateralRequest.setStoreKeeper(warrantyLocation.get(WarrantyLocation.STOREKEEPER));
			collateralRequest.setCollateralAddress(warrantyLocation.get(WarrantyLocation.ADDRESS));
			collateralRequest.setDepositary(warrantyLocation.get(WarrantyLocation.REPOSITORY));
			collateralRequest.setParish(warrantyLocation.get(WarrantyLocation.PARISH));
			
			//Datos Adicionales Localizacion
			if (warrantyLocation.get(WarrantyLocation.DOCUMENTLOCATION) != null)
				collateralRequest.setDocumentLocation(warrantyLocation.get(WarrantyLocation.DOCUMENTLOCATION));
			if (warrantyLocation.get(WarrantyLocation.DOCUMENTCITY) != null)
				collateralRequest.setDocumentCity(warrantyLocation.get(WarrantyLocation.DOCUMENTCITY));			
			if (warrantyLocation.get(WarrantyLocation.WARRANTYCITY) != null)
				collateralRequest.setWarrantyCity(warrantyLocation.get(WarrantyLocation.WARRANTYCITY).toString());
			if (warrantyLocation.get(WarrantyLocation.ACCOUNTINGOFFICE) != null)
				collateralRequest.setAccountingOffice(new Integer(warrantyLocation.get(WarrantyLocation.ACCOUNTINGOFFICE)));			
			if (warrantyLocation.get(WarrantyLocation.LICENSENUMBER) != null)
				collateralRequest.setLicenseNumber(warrantyLocation.get(WarrantyLocation.LICENSENUMBER));
			
			if (logger.isDebugEnabled()) {
				logger.logDebug(":>:>LICENSEDATEEXPIRATION:>:>" + warrantyLocation.get(WarrantyLocation.LICENSEDATEEXPIRATION));
			}
			if (warrantyLocation.get(WarrantyLocation.LICENSEDATEEXPIRATION) != null)
				collateralRequest.setLicenseDateExpiration(Convert.CDate.toCalendar(warrantyLocation.get(WarrantyLocation.LICENSEDATEEXPIRATION)));
			
			// Datos de Descripcion
			if (warrantyDescription.get(WarrantyDescription.REASON) != null)
				collateralRequest.setNotInspectReason(warrantyDescription.get(WarrantyDescription.REASON));
			if (warrantyDescription.get(WarrantyDescription.CONTROLVISIT) != null)
				collateralRequest.setInspect(warrantyDescription.get(WarrantyDescription.CONTROLVISIT).equals('S') ? 'S' : 'N');
			if (warrantyDescription.get(WarrantyDescription.DESCRIPTION) != null)
				collateralRequest.setWarrantyDescription(warrantyDescription.get(WarrantyDescription.DESCRIPTION));
			if (warrantyDescription.get(WarrantyDescription.PERIODICITY) != null)
				collateralRequest.setWarrantyPeriodicity(warrantyDescription.get(WarrantyDescription.PERIODICITY));
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(":>:>WarrantyGeneral:>:>" + entities.getEntity(WarrantyGeneral.ENTITY_NAME).getData());
			logger.logDebug(":>:>WarrantySituation:>:>" + entities.getEntity(WarrantySituation.ENTITY_NAME).getData());
			logger.logDebug(":>:>WarrantyDescription:>:>" + entities.getEntity(WarrantyDescription.ENTITY_NAME).getData());
		}

		ServiceResponse serviceResponse = updateCollateral(collateralRequest, arg1, new BehaviorOption(true));
		if (serviceResponse != null && serviceResponse.isResult()) {
			if (warrantyGeneral.get(WarrantyGeneral.CODE) == null) {
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
				response1 = (UpdateCollateralResponse1) serviceItemsResponseTO.getValue(ReturnName.RETURNUPDATECOLLATERALRESPONSE1);
				response2 = (UpdateCollateralResponse2) serviceItemsResponseTO.getValue(ReturnName.RETURNUPDATECOLLATERALRESPONSE2);
				if (logger.isDebugEnabled()) {
					logger.logDebug("CREACIÓN EXITOSA COLLATERAL ID: " + response1.getCustody());
					logger.logDebug("SUCURSAL: " + response2.getBranchOffice());
				}
				if (response1.getCustody() != null && response2.getBranchOffice() != null) {
					warrantyGeneral.set(WarrantyGeneral.CODE, response1.getCustody());
					warrantyGeneral.set(WarrantyGeneral.BRANCHOFFICE, response2.getBranchOffice());
					warrantyGeneral.set(WarrantyGeneral.FILIAL, FILIAL);
					// setCustodyExternalCode(entities,
					// response2.getBranchOffice().toString());

					Map<String, String> externalCode = (Map<String, String>) serviceItemsResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
					String ExtCode = String.valueOf(0);

					if (externalCode.get("@o_codigo_externo") != null) {
						ExtCode = externalCode.get("@o_codigo_externo");
					}
					warrantyGeneral.set(WarrantyGeneral.EXTERNALCODE, ExtCode);					
				}
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug("ACTUALIZACIÓN EXITOSA COLLATERAL ID: " + warrantyGeneral.get(WarrantyGeneral.CODE));

			}

		} else {
			return false;
		}
		
		for (int i = 0; i <sharedEntityWarranty.size();i++){
			SharedEntityRequest  sharedEntitiy = new SharedEntityRequest ();
			if (FILIAL != null){
				sharedEntitiy.setFilial(FILIAL);							
			}else{
				sharedEntitiy.setFilial(warrantyGeneral.get(WarrantyGeneral.FILIAL));					
			}
			if (response2!= null && response2.getBranchOffice() !=null){
				sharedEntitiy.setBranchOffice(response2.getBranchOffice());						
			}else{
				sharedEntitiy.setBranchOffice(warrantyGeneral.get(WarrantyGeneral.BRANCHOFFICE));
			}
			sharedEntitiy.setCustodyType(warrantyType);
			
				
			if (response1 != null && response1.getCustody() != null) {							
				sharedEntitiy.setCustody(response1.getCustody());	
			}else{
				sharedEntitiy.setCustody(warrantyGeneral.get(WarrantyGeneral.CODE));
			}
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.ENTITY) != null)						
				sharedEntitiy.setEntity(Integer.parseInt(sharedEntityWarranty.get(i).get(SharedEntityWarranty.ENTITY)));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.VALUE) != null)						
				sharedEntitiy.setSharedValue(sharedEntityWarranty.get(i).get(SharedEntityWarranty.VALUE));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.DATE) != null)						
				sharedEntitiy.setSharedDate(Convert.CDate.toCalendar(sharedEntityWarranty.get(i).get(SharedEntityWarranty.DATE)));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.VALUE) != null)						
				sharedEntitiy.setSharedValue(sharedEntityWarranty.get(i).get(SharedEntityWarranty.VALUE));
			
			if(warrantyGeneral.get(WarrantyGeneral.SUITABILITY) != null)
				sharedEntitiy.setSharedGrade(warrantyGeneral.get(WarrantyGeneral.SUITABILITY));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.SHAREDPERCENTAGE) != null)						
				sharedEntitiy.setSharedPercentage(sharedEntityWarranty.get(i).get(SharedEntityWarranty.SHAREDPERCENTAGE));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.BOOKVALUE) != null)						
				sharedEntitiy.setAccountantValue(sharedEntityWarranty.get(i).get(SharedEntityWarranty.BOOKVALUE));
			
			if (sharedEntityWarranty.get(i).get(SharedEntityWarranty.CORPORATION) != null)						
				sharedEntitiy.setBankPercentage(sharedEntityWarranty.get(i).get(SharedEntityWarranty.CORPORATION));
			
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue(RequestName.INSHAREDREQUEST, sharedEntitiy);
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESHAREDENTITYWARRANTY, serviceRequest);
			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("COMPARTIDA CREADA CORRECTAMENTE ");
			}else{
				if (logger.isDebugEnabled())
					logger.logDebug("COMPARTIDA NO CREADA CORRECTAMENTE: ");
				
				return false;
			}
		}

		return saveisOk;
	}

	public void setCustodyExternalCode(DynamicRequest entities, String branchOffice) {
		DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
		String externalCode = "";
		String custody = warrantyGeneral.get(WarrantyGeneral.CODE).toString();
		if (branchOffice.length() == 1) {
			externalCode = externalCode + "0" + branchOffice + warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE);
		} else {
			externalCode = externalCode + branchOffice + warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE);
		}
		custody = StringUtils.leftPad(custody, 10, "0");
		externalCode = externalCode + custody;
		warrantyGeneral.set(WarrantyGeneral.EXTERNALCODE, externalCode);
		if (logger.isDebugEnabled())
			logger.logDebug("CODIGO EXTERNO: " + externalCode);
	}

	public BankGuaranteeResponse QueryBankGuarantee(Integer idProcess, String numberBankOperation, String isRenovation, ICommonEventArgs arg1, BehaviorOption options) {

		BankGuaranteeRequest bankGuaranteeRequest = new BankGuaranteeRequest();
		bankGuaranteeRequest.setInstProcess(idProcess);
		bankGuaranteeRequest.setNumberBankOperation(numberBankOperation);
		bankGuaranteeRequest.setFormateDate(SessionContext.getFormatDate());
		bankGuaranteeRequest.setRenewal(isRenovation);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INBANKGUARANTEEREQUEST, bankGuaranteeRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYBANKGUARANTEE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			logger.logDebug(" -- BG -- RESULTADO DE QueryBankGuarantee para proceso : " + idProcess);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (BankGuaranteeResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNBANKGUARANTEERESPONSE);
		} else {
			logger.logDebug(" -- BG -- ERROR DE QueryBankGuarantee para proceso : " + idProcess);
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public RenewLoanResponse[] searchCustomerOperations(RenewLoanRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.readCustomerOperation = null;
		logger.logDebug("ENTRO A searchCustomerOperations");
		RenewDataResponseList renewDataResponseList = new RenewDataResponseList();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INRENEWLOANREQUEST, renewDataRequest);
		serviceRequestTO.addValue(ReturnName.OUTRETURNRENEWLOANRESPONSE, renewDataResponseList);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHRENEWOPERDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RenewDataResponse para ID: " + renewDataRequest.getNumBanc() + ", ServiceId:" + ServiceId.SERVICEREADOPERATION);
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			this.readCustomerOperation = (RenewLoanResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWLOANRESPONSE);
			return this.readCustomerOperation;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchCustomerOperations");
		}
		return null;
	}

	public static void searchCollateralFechaCIC(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntityList collateralLoadEntity1 = new DataEntityList();
		int idRequest = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		CollateralManagement collateralMngmt = new CollateralManagement(serviceIntegration);
		CollateralApplicationResponse[] collateralsResponse = collateralMngmt.searchCollateral(idRequest, arg1, new BehaviorOption(true));

		if (collateralsResponse != null) {
			for (CollateralApplicationResponse collateralResponse : collateralsResponse) {
				DataEntity collateral = new DataEntity();
				if (String.valueOf(Mnemonic.CHAR_S).equals(collateralResponse.getIsPersonal())) {
					if (logger.isDebugEnabled())
						logger.logDebug("GuaranteeManagement -> GARANTIA PERSONAL TIPO = (" + collateralResponse.getType() + ")");
					collateral.set(PersonalGuarantor.CODEWARRANTY, collateralResponse.getCollateralCode());
					collateral.set(PersonalGuarantor.TYPE, collateralResponse.getType());// getStatus()
					collateral.set(PersonalGuarantor.DESCRIPTION, collateralResponse.getCollateralDescription());
					collateral.set(PersonalGuarantor.GUARANTORPRIMARYSECONDARY, collateralResponse.getGuarantor());
					collateral.set(PersonalGuarantor.CLASSOPEN, collateralResponse.getClassOpen());
					collateral.set(PersonalGuarantor.IDCUSTOMER, collateralResponse.getIdentification());
					collateral.set(PersonalGuarantor.STATE, collateralResponse.getStatus());
					collateral.set(PersonalGuarantor.RELATION, collateralResponse.getRelation());// NTG
																									// prelacion
																									// de
																									// garantia
					collateral.set(PersonalGuarantor.DATECIC, collateralResponse.getDateCIC() != null ? collateralResponse.getDateCIC().getTime() : null);
					collateralLoadEntity1.add(collateral);
				}
			}

			entities.setEntityList(PersonalGuarantor.ENTITY_NAME, collateralLoadEntity1);
		}
	}

	public ServiceResponse updateCollateral(UpdateCollateralRequest updateCollateralRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.setHasErrorIfExists(false);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		serviceRequestTO.getData().put(RequestName.INUPDATECOLLATERALREQUEST, updateCollateralRequest);
		if (updateCollateralRequest.getCustody() == null) {
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEINSERTCOLLATERAL, serviceRequestTO);
		} else {
			serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATECOLLATERAL, serviceRequestTO);
		}
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("GARANTIA GUARDADA EXITOSAMENTE: " + updateCollateralRequest.getCustody());
			return serviceResponse;
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("ERROR AL GUARDAR LA GARANTIA: " + updateCollateralRequest.getCustody());
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ServiceResponse saveCustomerCollateral(DataEntity wCustomer, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options, int contador) {
		this.setHasErrorIfExists(false);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
		CustomerCollateralRequest customerCollateralRequest = new CustomerCollateralRequest();

		customerCollateralRequest.setCustody(warrantyGeneral.get(WarrantyGeneral.CODE));
		customerCollateralRequest.setFilial(warrantyGeneral.get(WarrantyGeneral.FILIAL));
		customerCollateralRequest.setBranchOffice(warrantyGeneral.get(WarrantyGeneral.BRANCHOFFICE));
		customerCollateralRequest.setCustodyType(warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE));
		customerCollateralRequest.setEnte(wCustomer.get(CustomerSearch.CUSTOMERID));
		customerCollateralRequest.setName(wCustomer.get(CustomerSearch.CUSTOMER));	
		customerCollateralRequest.setOfficial(wCustomer.get(CustomerSearch.OFFICERID));
		//customerCollateralRequest.setGuarantortype(warrantyGeneral.get(WarrantyGeneral.GUARANTORTYPE));
		customerCollateralRequest.setGuarantortype(wCustomer.get(CustomerSearch.WARRANTYTYPE));

		/*if (wCustomer.get(CustomerSearch.PRINCIPAL) != null) {
			customerCollateralRequest.setPrincipal(wCustomer.get(CustomerSearch.PRINCIPAL) ? 'S' : 'N');
		} else {
			customerCollateralRequest.setPrincipal('S');
		}*/
		
		if ((contador == 1) || (wCustomer.get(CustomerSearch.WARRANTYTYPE) != null && wCustomer.get(CustomerSearch.WARRANTYTYPE).equals("A"))){
			customerCollateralRequest.setPrincipal('D');
		}else{
			customerCollateralRequest.setPrincipal('C');
		}

		serviceRequestTO.getData().put(RequestName.INCUSTOMERCOLLATERALREQUEST, customerCollateralRequest);
		serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEINSERTCUSTOMERCOLLATERAL, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("CLIENTE DE LA GARANTIA GUARDADO EXITOSAMENTE: " + wCustomer.get(CustomerSearch.CUSTOMERID));
			return serviceResponse;
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("ERROR AL ASOCIAR A LA GARANTIA EL CLIENTE: " + wCustomer.get(CustomerSearch.CUSTOMERID));
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	/* Retornar polizas de una garantia */

	@SuppressWarnings("unchecked")
	public PolicyData[] getPoliciesByGuarantee(Integer branchOffice, String typeCustody, Integer custody, ICommonEventArgs arg1, BehaviorOption options) {

		if (logger.isDebugEnabled())
			logger.logDebug("------------>>>>>>> ENTRO A getPoliciesByGuarantee ");

		PolicyAllInformation policyInformation = new PolicyAllInformation();
		policyInformation.setBranchOffice(branchOffice);
		policyInformation.setTypeCustody(typeCustody); // tipo de garantia
		policyInformation.setCustody(custody); // id de la garantia

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPOLICYINFORMATION, policyInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICE_SEARCH_ALL_POLICIES, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("------------>>>>>>> ENTRO A SERVICE RESPONSE , TIENE RESPUESTAS EL SERVICIO ");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();

			if (logger.isDebugEnabled())
				logger.logDebug("------------>>>>>>> convirtio a  serviceItemsResponseTO");
			return (PolicyData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNPOLICYDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	/* Retornar UNA polizas */

	@SuppressWarnings("unchecked")
	public PolicyData getPolicyData(int branchOffice, String insurance, String policy, String typeCustody, Integer custody, IDataEventArgs arg1, BehaviorOption options) {

		if (logger.isDebugEnabled())
			logger.logDebug("------------>>>>>>> ENTRO A getPolicyData ");

		PolicyAllInformation policyInformation = new PolicyAllInformation();
		policyInformation.setBranchOffice(branchOffice);
		policyInformation.setInsurance(insurance);
		policyInformation.setPolicy(policy);
		policyInformation.setTypeCustody(typeCustody); // tipo de garantia
		policyInformation.setCustody(custody); // id de la garantia

		CommonParams commonsParams = new CommonParams();
		commonsParams.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPOLICYINFORMATION, policyInformation);
		serviceRequestTO.getData().put(RequestName.INCCOMMONPARAMS, commonsParams);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADPOLICY, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("------------>>>>>>> ENTRO A SERVICE RESPONSE , TIENE RESPUESTAS EL SERVICIO ");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();

			if (logger.isDebugEnabled())
				logger.logDebug("------------>>>>>>> convirtio a  serviceItemsResponseTO");
			return (PolicyData) serviceItemsResponseTO.getValue(ReturnName.RETURNPOLICYDATA);
		}
		return null;
	}

	
}
