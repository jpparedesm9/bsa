package com.cobiscorp.cobis.busin.customevents.utils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.collateral.dto.AccountResponse;
import cobiscorp.ecobis.collateral.dto.CustodyAdditionalData;
import cobiscorp.ecobis.collateral.dto.CustodyAllData;
import cobiscorp.ecobis.collateral.dto.FixedTermData;
import cobiscorp.ecobis.collateral.dto.PolicyData;
import cobiscorp.ecobis.collateral.dto.SharedEntityResponse;
import cobiscorp.ecobis.collateral.dto.WarrantyLocationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanrequest.general.dto.CustomerData;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CollateralManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.GuaranteeManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.model.CustomerSearch;
import com.cobiscorp.cobis.busin.model.SharedEntityWarranty;
import com.cobiscorp.cobis.busin.model.SharedWarrantyInfo;
import com.cobiscorp.cobis.busin.model.WarrantyDescription;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.busin.model.WarrantyLocation;
import com.cobiscorp.cobis.busin.model.WarrantyPoliciy;
import com.cobiscorp.cobis.busin.model.WarrantySituation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class MapWarranty {
	private static final ILogger LOGGER = LogFactory.getLogger(MapWarranty.class);

	public void getWarranty(DynamicRequest entities, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration, String codeWarranty, String typeWarranty, int office)
			throws BusinessException {

		DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
		DataEntity warrantySituation = entities.getEntity(WarrantySituation.ENTITY_NAME);
		DataEntity warrantyLocation = entities.getEntity(WarrantyLocation.ENTITY_NAME);
		DataEntity warrantyDescription = entities.getEntity(WarrantyDescription.ENTITY_NAME);
		DataEntity sharedWarrantyInfo = entities.getEntity(SharedWarrantyInfo.ENTITY_NAME);

		CustodyAllData custodyResponse = null;
		boolean sharedType = false, legalType = false, guaranteeFound = false, inspectType = false;
		String guarantorWarranty = "";
		int custodyCode = 0;
		Integer storeKeeper = 0;
		int firstCharacter = 0;
		int typeLength = 0;

		List<Object> positionChar = new ArrayList<Object>();
		char[] toCharArray = codeWarranty.toCharArray();
		for (int i = 0; i < codeWarranty.length(); i++) {
			char caracter = toCharArray[i];
			if (Character.isLetter(caracter)) {
				positionChar.add(i);
			}
		}
		firstCharacter = (Integer) positionChar.get(0);
		typeLength = typeWarranty.length();

		custodyCode = Integer.parseInt(codeWarranty.substring(firstCharacter + typeLength + 1));
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("-->Custody code: " + custodyCode + " - Type:  " + typeWarranty);
		try {
			CollateralManagement collateralManager = new CollateralManagement(serviceIntegration);
			CustomerData[] customerDataDTO = null;
			WarrantyLocationResponse warrantyLocationResponse = null;
			CustodyAdditionalData custodyAdditionalData = null;
			Map<String, Object> result = collateralManager.getQueryGuaranteeData(custodyCode, typeWarranty, office, arg1, new BehaviorOption(true));
			if (result != null) {
				custodyResponse = result.get("CustodyAllData") == null ? null : (CustodyAllData) result.get("CustodyAllData");
				customerDataDTO = result.get("CustomerData") == null ? null : (CustomerData[]) result.get("CustomerData");
				warrantyLocationResponse = result.get("WarrantyLocationResponse") == null ? null : (WarrantyLocationResponse) result.get("WarrantyLocationResponse");
				custodyAdditionalData = result.get("CustodyAdditionalData") == null ? null : (CustodyAdditionalData) result.get("CustodyAdditionalData");

				if (custodyResponse != null) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("-->Empieza mapeo Garantía registrada");

					sharedType = custodyResponse.getShared() != null && ("S").equals(custodyResponse.getShared()) ? true : false;
					legalType = custodyResponse.getLegalCollection() !=null && "S".equals(custodyResponse.getLegalCollection()) ? true : false;

					guaranteeFound = custodyResponse.getGuaranteeFound() != null && "S".equals(custodyResponse.getGuaranteeFound()) ? true : false;
					inspectType = custodyResponse.getInspect() !=null && "S".equals(custodyResponse.getInspect()) ? true : false;

					/* Mapeo WarrantyGeneral */
					warrantyGeneral.set(WarrantyGeneral.FILIAL, Mnemonic.FILIAL);
					warrantyGeneral.set(WarrantyGeneral.BRANCHOFFICE, office);
					warrantyGeneral.set(WarrantyGeneral.CODE, custodyCode);
					warrantyGeneral.set(WarrantyGeneral.EXTERNALCODE, codeWarranty);
					warrantyGeneral.set(WarrantyGeneral.WARRANTYTYPE, typeWarranty);
					warrantyGeneral.set(WarrantyGeneral.STATUS, custodyResponse.getStatus());
					warrantyGeneral.set(WarrantyGeneral.INITIALVALUE, custodyResponse.getInitialValue());
					warrantyGeneral.set(WarrantyGeneral.CURRENTVALUE, custodyResponse.getCurrentValue());
					warrantyGeneral.set(WarrantyGeneral.APPRAISALVALUE, custodyResponse.getAppraisalValue());
					warrantyGeneral.set(WarrantyGeneral.DOCUMENTNUMBER, custodyResponse.getDocumentNumer());
					warrantyGeneral.set(WarrantyGeneral.INSTRUCTION, custodyResponse.getInstruction());
					warrantyGeneral.set(WarrantyGeneral.DESCRIPTION, custodyResponse.getDescription());
					warrantyGeneral.set(WarrantyGeneral.CURRENCY, Integer.parseInt(custodyResponse.getCurrency()));
					warrantyGeneral.set(WarrantyGeneral.COVERAGE, custodyResponse.getCobNemonic());

					// Pestaña Descripción
					warrantyDescription.set(WarrantyDescription.DESCRIPTION, custodyResponse.getDescription());
					warrantyDescription.set(WarrantyDescription.PERIODICITY, custodyResponse.getPeriodicity());

					if ("S".equals(custodyResponse.getInspect())) {
						warrantyDescription.set(WarrantyDescription.CONTROLVISIT, 'S');
					} else {
						warrantyDescription.set(WarrantyDescription.CONTROLVISIT, 'N');
					}
					// Pestaña Compartida

					if (custodyResponse.getConstitutionDate() != null) {
						warrantyGeneral.set(WarrantyGeneral.CONSTITUTIONDATE, Convert.CString.toDate(custodyResponse.getConstitutionDate()));
					}
					if (custodyResponse.getAppraisalDate() != null) {
						warrantyGeneral.set(WarrantyGeneral.APPRAISALDATE, Convert.CString.toDate(custodyResponse.getAppraisalDate()));
					}
					if (custodyResponse.getFixedTerm() != null) {
						warrantyGeneral.set(WarrantyGeneral.FIXEDTERM, getFixedTermDetail(custodyResponse.getFixedTerm(), arg1, serviceIntegration));
					} else {
						warrantyGeneral.set(WarrantyGeneral.FIXEDTERM, custodyResponse.getFixedTerm());
					}

					if (custodyResponse.getAccountNumber() != null) {
						warrantyGeneral.set(
								WarrantyGeneral.ACCOUNTAHO,
								getAccountDetail(custodyResponse.getAccountNumber(), Integer.parseInt(custodyResponse.getCurrency()), custodyResponse.getCustomerDescription(),
										arg1, serviceIntegration));
					} else {
						warrantyGeneral.set(WarrantyGeneral.ACCOUNTAHO, custodyResponse.getAccountNumber());
					}

					guarantorWarranty = String.valueOf(custodyResponse.getGuarantee()) + "-" + custodyResponse.getGuaranteeDescription();
					warrantyGeneral.set(WarrantyGeneral.GUARANTOR, guarantorWarranty);
					warrantyGeneral.set(WarrantyGeneral.VALUESOURCE, custodyResponse.getSourceValue());
					warrantyGeneral.set(WarrantyGeneral.FIXEDTERMAMOUNT, custodyResponse.getFixedAmount());
					warrantyGeneral.set(WarrantyGeneral.BALANCEAVAILABLE, custodyResponse.getAvailableBalance());
					warrantyGeneral.set(WarrantyGeneral.SUITABILITY, custodyResponse.getCobDescription());

					/* Mapeo WarrantySituation */
					warrantySituation.set(WarrantySituation.CLASSWARRANTY, custodyResponse.getOpenClose().toString());
					warrantySituation.set(WarrantySituation.LEGALSUFFICIENCY, custodyResponse.getLegal());
					warrantySituation.set(WarrantySituation.SUITABLE, custodyResponse.getAppropriate() == null ? null : custodyResponse.getAppropriate().toString());
					warrantySituation.set(WarrantySituation.SHAREDTYPE, sharedType);
					warrantySituation.set(WarrantySituation.TOTALINITIALVALUE, custodyResponse.getSharedValue());
					warrantySituation.set(WarrantySituation.JUDICIALCOLLECTIONTYPE, legalType);
					warrantySituation.set(WarrantySituation.GUARANTEEFUND, guaranteeFound);
					warrantySituation.set(WarrantySituation.INSPECTTYPE, inspectType);
					warrantySituation.set(WarrantySituation.INSPECTREASON, custodyResponse.getNoInspectionReason());
					warrantyDescription.set(WarrantyDescription.REASON, custodyResponse.getNoInspectionReason());
					warrantySituation.set(WarrantySituation.PERIODICITY, custodyResponse.getPeriodicity());
					warrantySituation.set(WarrantySituation.INSTRUCTION, custodyResponse.getInstruction());
					warrantySituation.set(WarrantySituation.CONSTITUTION,
							custodyResponse.getConstitutionDate() == null ? null : Convert.CString.toDate(custodyResponse.getConstitutionDate()));
					warrantySituation.set(WarrantySituation.LASTVALUATION,
							custodyResponse.getAppraisalDate() == null ? null : Convert.CString.toDate(custodyResponse.getAppraisalDate()));
					if (custodyResponse.getRetirementDate() != null) {
						warrantySituation.set(WarrantySituation.RETIREMENTDATE, Convert.CString.toDate(custodyResponse.getRetirementDate()));
					}
					if (custodyResponse.getReturnDate() != null) {
						warrantySituation.set(WarrantySituation.RETURNDATE,
								custodyResponse.getReturnDate() == null ? null : Convert.CString.toDate(custodyResponse.getReturnDate()));
					}

					/* Mapeo WarrantyLocation */
					String provinceWarranty = "";
					if (custodyResponse.getGarmentCity() != null) {
						if (custodyResponse.getGarmentCity().indexOf(";") >= 0) {

							String[] cityArray = custodyResponse.getGarmentCity().split(";");
							provinceWarranty = cityArray[0];
							warrantyLocation.set(WarrantyLocation.CITY, Integer.parseInt(cityArray[1]));
							warrantyLocation.set(WarrantyLocation.PROVINCE, Integer.parseInt(provinceWarranty));
						}
						warrantyLocation.set(WarrantyLocation.PARISH, custodyResponse.getParish());
					}
					warrantyLocation.set(WarrantyLocation.PHONE, custodyResponse.getGarmentPhone());
					if (custodyResponse.getAlmacenera() == null || "".equals(custodyResponse.getAlmacenera()) || " ".equals(custodyResponse.getAlmacenera())) {
						storeKeeper = null;
					} else {
						storeKeeper = Integer.parseInt(custodyResponse.getAlmacenera());
					}
					warrantyLocation.set(WarrantyLocation.STOREKEEPER, storeKeeper);

					if (custodyResponse.getGarmentCity() != null) {
						String documentCity = custodyResponse.getGarmentCity().substring(custodyResponse.getGarmentCity().indexOf(';') + 1);
						warrantyLocation.set(WarrantyLocation.DOCUMENTCITY, documentCity);
					}
					// SRO. Localización
					warrantyLocation.set(WarrantyLocation.ACCOUNTINGOFFICE, String.valueOf(custodyResponse.getOfficeWarranty()));
					warrantyLocation.set(WarrantyLocation.ADDRESS, custodyResponse.getGarmentAaddress());
					warrantyLocation.set(WarrantyLocation.REPOSITORY, custodyResponse.getDepositary());
					warrantyLocation.set(WarrantyLocation.LICENSENUMBER, custodyResponse.getDepositary());
					if (warrantyLocationResponse != null) {
						warrantyLocation.set(WarrantyLocation.WARRANTYCITY,
								warrantyLocationResponse.getWarrantyCity() == null ? "" : String.valueOf(warrantyLocationResponse.getWarrantyCity()));
					}

					if (custodyAdditionalData != null) {
						// SRO. Situación/Clase
						warrantySituation.set(WarrantySituation.PENALTY, custodyAdditionalData.getPenalty() == null ? '\0' : custodyAdditionalData.getPenalty());
						warrantySituation.set(WarrantySituation.DEPLETIVE, custodyAdditionalData.getDepletive() == null ? '\0' : custodyAdditionalData.getDepletive());
						warrantySituation.set(WarrantySituation.SINISTER, custodyAdditionalData.getSinister() == null ? '\0' : custodyAdditionalData.getSinister());

						if (custodyAdditionalData.getCuantia() != null) {
							warrantySituation.set(WarrantySituation.AMOUNT, custodyAdditionalData.getCuantia().toString());
						}

						warrantyGeneral.set(WarrantyGeneral.APPRAISALVALUE, new BigDecimal(custodyAdditionalData.getAmount()));
						warrantySituation.set(WarrantySituation.ADMISSIBILITY, custodyAdditionalData.getAdmissibility());
						warrantySituation.set(WarrantySituation.EXPIRATIONCONTROL,
								custodyAdditionalData.getExpirationControl() == null ? '\0' : custodyAdditionalData.getExpirationControl());

						if (custodyAdditionalData.getCommertialOrIndustrial() != null)
							warrantySituation.set(WarrantySituation.COMMERCIALORINDUSTRY, custodyAdditionalData.getCommertialOrIndustrial());

						warrantySituation.set(WarrantySituation.LEGALSTATUS,
								custodyAdditionalData.getLegalStatusDate() == null ? null : Convert.CString.toDate(custodyAdditionalData.getLegalStatusDate()));
						warrantySituation.set(WarrantySituation.EXPIRATION,
								custodyAdditionalData.getExpirationDate() == null ? null : Convert.CString.toDate(custodyAdditionalData.getExpirationDate()));

						// SRO. Localización
						warrantyLocation.set(WarrantyLocation.DOCUMENTLOCATION, custodyAdditionalData.getDocumentLocation());
						warrantyLocation.set(WarrantyLocation.LICENSENUMBER, custodyAdditionalData.getLicense());

						if (custodyAdditionalData.getLicenseExpirationDate() != null) {
							warrantyLocation.set(WarrantyLocation.LICENSEDATEEXPIRATION, Convert.CString.toDate(custodyAdditionalData.getLicenseExpirationDate()));
						}
					}
				}

				/* Mapeo clientes de la garatia */

				// customerDataDTO =
				// collateralManager.getQueryGuaranteeCustomer(custodyCode,
				// typeWarranty, arg1, new BehaviorOption(true));
				DataEntityList customerEntityList = new DataEntityList();
				if (customerDataDTO != null) {
					for (CustomerData customerData : customerDataDTO) {
						DataEntity dataEntityWarrantyCustomer = new DataEntity();
						dataEntityWarrantyCustomer.set(CustomerSearch.CUSTOMERID, customerData.getCustomerCode());
						dataEntityWarrantyCustomer.set(CustomerSearch.CUSTOMER, customerData.getCustomerName());
						dataEntityWarrantyCustomer.set(CustomerSearch.OFFICERID, customerData.getOfficialCode());
						dataEntityWarrantyCustomer.set(CustomerSearch.OFFICER, customerData.getOfficialName());
						dataEntityWarrantyCustomer.set(CustomerSearch.PRINCIPAL, true);
						dataEntityWarrantyCustomer.set(CustomerSearch.IDENTIFICATIONTYPE, customerData.getIdentificationType());
						dataEntityWarrantyCustomer.set(CustomerSearch.IDENTIFICATION, customerData.getIdentification());
						dataEntityWarrantyCustomer.set(CustomerSearch.WARRANTYTYPE, customerData.getSubtype());
						customerEntityList.add(dataEntityWarrantyCustomer);
						// warrantyGeneral.set(WarrantyGeneral.GUARANTORTYPE,
						// customerData.getSubtype());

					}
					entities.setEntityList(CustomerSearch.ENTITY_NAME, customerEntityList);
				}

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("--------------------->>>>>>>>>>>>>>> Llego hasta antes de POLIZA");
				/* Conseguir polizas de una garantia */
				GuaranteeManagement warrantyManagement = new GuaranteeManagement(serviceIntegration);
				PolicyData[] policyDataDTO = null;
				policyDataDTO = warrantyManagement.getPoliciesByGuarantee(1, typeWarranty, custodyCode, arg1, new BehaviorOption(true));
				DataEntityList custodyEntity = new DataEntityList();
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("--------------------->>>>>>>>>>>>>>> OBTIENE DTO POLICY DATA ");

				if (policyDataDTO != null) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("--------------------->>>>>>>>>>>>>>> POLICY DATA ES DIFERENTE DE NULO");
					for (PolicyData policyData : policyDataDTO) {

						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("--------------------->>>>>>>>>>>>>>> POLICY DATA : policyData.getDescriptionInsurance() " + policyData.getDescriptionInsurance());
						DataEntity dataEntityPolicy = new DataEntity();

						dataEntityPolicy.set(WarrantyPoliciy.INSURANCE, policyData.getInsurance());
						dataEntityPolicy.set(WarrantyPoliciy.INSURANCEDESCRIPTION, policyData.getDescriptionInsurance());
						dataEntityPolicy.set(WarrantyPoliciy.NUMBERPOLICY, policyData.getPolicy());

						custodyEntity.add(dataEntityPolicy);
						if (LOGGER.isDebugEnabled())
							LOGGER.logDebug("-->custodyEntity");
					}
					entities.setEntityList(WarrantyPoliciy.ENTITY_NAME, custodyEntity);
				}

				LOGGER.logDebug("custodyCode  ---->" + custodyCode);
				// Obtener entidades compartidas
				SharedEntityResponse[] sharedEntitiesResponse = collateralManager.getEntities(typeWarranty, custodyCode, office, arg1);
				LOGGER.logDebug("sharedEntitiesResponse--->" + sharedEntitiesResponse);
				if (sharedEntitiesResponse != null && sharedEntitiesResponse.length > 0 && sharedEntitiesResponse[0] != null && sharedEntitiesResponse[0].getEntityCode() != null) {
					if(custodyResponse != null){
						sharedWarrantyInfo.set(SharedWarrantyInfo.SHARED, custodyResponse.getShared() == null ? '\0' : custodyResponse.getShared().charAt(0));
						DataEntityList sharedEntities = new DataEntityList();
						for (SharedEntityResponse sharedEntityResponse : sharedEntitiesResponse) {
							LOGGER.logDebug("sharedEntityResponse.getEntityName())--->" + sharedEntityResponse.getEntityName());
							LOGGER.logDebug("sharedEntityResponse.getEntityCode())--->" + sharedEntityResponse.getEntityCode());
							DataEntity sharedEntity = new DataEntity();
							sharedEntity.set(SharedEntityWarranty.ENTITY, String.valueOf(sharedEntityResponse.getEntityCode()));
							sharedEntity.set(SharedEntityWarranty.NAMEENTITY, sharedEntityResponse.getEntityName() == null ? " " : sharedEntityResponse.getEntityName());
							sharedEntity.set(SharedEntityWarranty.BOOKVALUE, new BigDecimal(sharedEntityResponse.getBookValue()));
							sharedEntity.set(SharedEntityWarranty.SHAREDPERCENTAGE, sharedEntityResponse.getPercentage());
							sharedEntity.set(SharedEntityWarranty.VALUE, new BigDecimal(sharedEntityResponse.getSharedValue()));
							sharedEntity.set(SharedEntityWarranty.CORPORATION, sharedEntityResponse.getBankPercentage());
							sharedEntity.set(SharedEntityWarranty.DATE, sharedEntityResponse.getDate() == null ? null : Convert.CString.toDate(sharedEntityResponse.getDate()));
							sharedEntities.add(sharedEntity);

						}
						entities.setEntityList(SharedEntityWarranty.ENTITY_NAME, sharedEntities);
					}
					
				} else {
					// Si viene en S y no tiene entidades compartidas por
					// defecto se mapea N
					LOGGER.logDebug("SRO 0--->" + sharedEntitiesResponse);
					sharedWarrantyInfo.set(SharedWarrantyInfo.SHARED, 'N');
				}
			}
		} catch (BusinessException bex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_LOAD_MAP, bex, arg1, LOGGER);
			throw bex;
		}
	}

	private String getFixedTermDetail(String fixedTerm, ICommonEventArgs args, ICTSServiceIntegration serviceIntegration) {
		String fixedTermDetail = null;
		CollateralManagement collateralManagement = new CollateralManagement(serviceIntegration);
		try {
			FixedTermData fixedTermDetailResponse = collateralManagement.queryFixedTermDetail(0, fixedTerm, args, new BehaviorOption(true));
			BigDecimal montoInicial, montoBloqueado, montoGarantia, montoDisponible, montoResta;
			if (fixedTermDetailResponse != null) {
				/* mapeo de datos */
				montoInicial = fixedTermDetailResponse.getAmount();
				montoGarantia = fixedTermDetailResponse.getGuaranteeAmount();
				montoBloqueado = fixedTermDetailResponse.getBlockedAmount();
				/* calculo del monto disponible y seteo */
				montoResta = montoGarantia.subtract(montoBloqueado);
				montoDisponible = montoInicial.subtract(montoResta);
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("GetFixedTermDetail --> Monto Disponible: " + montoDisponible.toString());

				fixedTermDetail = fixedTerm + " - " + fixedTermDetailResponse.getCustomerName() + " - " + montoDisponible.toString();
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("GetFixedTermDetail --> fixedTermDetail: " + fixedTermDetail);

			}
		} catch (Exception e) {
			LOGGER.logError("GetFixedTermDetail Error --> ", e);
			throw new BusinessException(7300087, "Ocurrió un error al obtener los datos del DPF " + fixedTerm + ".  Verifique si existe y se encuentra activo.");
		}
		return fixedTermDetail;

	}

	private String getAccountDetail(String account, int currencyCode, String customerName, ICommonEventArgs args, ICTSServiceIntegration serviceIntegration) {
		String accountDetail = null;
		CollateralManagement collateralManagement = new CollateralManagement(serviceIntegration);
		try {
			AccountResponse accountDetailResponse = collateralManagement.queryAccountDetail(0, currencyCode, account, args, new BehaviorOption(true));
			BigDecimal saldoDisponible;
			if (accountDetailResponse != null) {
				/* mapeo de datos */
				saldoDisponible = accountDetailResponse.getAvailbale();
				/* seteo de datos a la entidad */
				LOGGER.logDebug("getAccountDetail --> Saldo Disponible: " + saldoDisponible.toString());

				accountDetail = account + " - " + customerName + " - " + saldoDisponible.toString();
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("getAccountDetail --> accountDetail: " + accountDetail);
			}

		} catch (Exception e) {
			LOGGER.logError("getAccountDetail Error --> ", e);
			throw new BusinessException(7300087, "Ocurrió un error al obtener los datos de la Cuenta " + accountDetail + ".  Verifique si existe y se encuentra activo.");
		}
		return accountDetail;

	}
}
