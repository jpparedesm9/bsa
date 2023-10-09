package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.CustomerManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.UtilFunction;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dto.MaxDebtDTO;
import com.cobiscorp.ecobis.commons.dal.CatalogDAO;
import com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Catalog;
import com.cobiscorp.ecobis.customer.commons.dal.CustomerDAO;
import com.cobiscorp.ecobis.customer.commons.dal.entities.Instance;
import com.cobiscorp.ecobis.customer.commons.dto.ClientAcademicDataDTO;
import com.cobiscorp.ecobis.customer.commons.dto.ClientAdditionalDataDTO;
import com.cobiscorp.ecobis.customer.commons.dto.ClientCompanyDataDTO;
import com.cobiscorp.ecobis.customer.commons.dto.ClientGeneralDataDTO;
import com.cobiscorp.ecobis.customer.commons.dto.ClientOtherInformationDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerInformationDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicActivityDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.GroupOtherInformationDTO;
import com.cobiscorp.ecobis.customer.commons.dto.OfficialDTO;
import com.cobiscorp.ecobis.customer.commons.dto.OtherInformationCompanyDTO;
import com.cobiscorp.ecobis.customer.services.AddressTxService;
import com.cobiscorp.ecobis.customer.services.ContactTxService;
import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public class CustomerManagerImpl implements CustomerManager {
	private static ILogger logger = LogFactory.getLogger(CustomerManagerImpl.class);

	CustomerDAO customerDAO;
	CatalogDAO catalogDAO;
	GeneralParameterDAO generalParameterDAO;
	MaxDebtManagerImpl maxDebtManagerImpl;
	AddressTxService addressTxService;
	ContactTxService contactTxService;

	@Override
	public CustomerInformationDTO getCustomer(Integer customerId) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomer"));
		CustomerDTO customer = new CustomerDTO();
		CustomerInformationDTO customerInformation = new CustomerInformationDTO();
		customerInformation.setClientInformation(new HashMap<String, Object>());
		try {
			String customerType = getCustomerType(customerId);
			logger.logDebug("customerType-->" + customerType);
			if ("P".equals(customerType)) {
				logger.logDebug("customer id-->" + customerId);
				customer = getNaturalClient(customerId);
				customer.setCode(customerId);
				customerInformation = mapNaturalClient(customerInformation, customer);

			} else {
				customer = getQueryLegalClient(customerId);
				customer.setCode(customerId);
				customerInformation = mapLegalClient(customerInformation, customer);

			}
			// Deudas
			MaxDebtDTO maxDebtRequest = maxDebtManagerImpl.getMaxDebt(customerId, 0);
			if (maxDebtRequest != null) {
				maxDebtRequest.setAvailable(maxDebtRequest.getLimitDebt() - maxDebtRequest.getDebtAmount());
			}
			customerInformation.getClientInformation().put("maxDebtRequest", maxDebtRequest);

			// Direcciones
			CustomerDataRequest customerDataRequest = new CustomerDataRequest();
			customerDataRequest.setCustomerId(customerId);
			List<AddressDataResponse> addressResponse = addressTxService.getAddressesbyCustomer(customerDataRequest);
			List<AddressDataResponse> seriesDirections = new ArrayList<AddressDataResponse>();
			List<AddressDataResponse> seriesEmails = new ArrayList<AddressDataResponse>();

			if (addressResponse != null && addressResponse.size() > 0) {
				for (AddressDataResponse addressDataResponse : addressResponse) {
					if (!"CE".equals(addressDataResponse.getTypeCode())) {
						seriesDirections.add(addressDataResponse);
					} else {
						seriesEmails.add(addressDataResponse);
					}
				}
			}
			customerInformation.getClientInformation().put("seriesDirections", seriesDirections);
			customerInformation.getClientInformation().put("seriesEmails", seriesEmails);

			// Contacts
			logger.logDebug("customerId--->" + customerId);
			List<ContactDataResponse> seriesContact = contactTxService.getContactsbyCustomer(customerDataRequest);
			customerInformation.getClientInformation().put("seriesContact", seriesContact);
			customer.setCustomerType(customerType);
			customerInformation.getClientInformation().put("customer", customer);
			logger.logDebug("seriesContact--->" + seriesContact);

			return customerInformation;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", customerId), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomer"));
		}
	}

	public CustomerInformationDTO getGroupDetail(Integer groupCode, String type) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupDetail"));
		EconomicGroupDTO objEconomicGroup = null;
		CustomerInformationDTO customerInformation = new CustomerInformationDTO();
		customerInformation.setClientInformation(new HashMap<String, Object>());
		try {

			List<Catalog> estados = catalogDAO.getCatalogsByName("cl_estados_grupo");
			List<Catalog> tiposGrupo = catalogDAO.getCatalogsByName("cl_tipo_grupo");
			logger.logDebug("getGroupDetail type: " + type);
			objEconomicGroup = customerDAO.getGroupDetail(groupCode, type);

			for (Catalog estado : estados) {

				if (estado.getCode().equals(objEconomicGroup.getState().trim())) {
					objEconomicGroup.setState(estado.getValue());
				}
			}

			for (Catalog tipoGrupo : tiposGrupo) {

				if (tipoGrupo.getCode().equals(objEconomicGroup.getGroupType().trim())) {
					objEconomicGroup.setGroupType(tipoGrupo.getValue());
				}
			}

			if (objEconomicGroup != null && objEconomicGroup.getGroupOfficial() != null) {
				OfficialDTO objOfficial = getOfficer(objEconomicGroup.getGroupOfficial());
				if (objOfficial != null && objOfficial.getOfficerName() != null) {
					objEconomicGroup.setFunctionaryName(objOfficial.getOfficerName());
				}

			}

			if (objEconomicGroup != null && objEconomicGroup.getSubstitute() != null) {
				OfficialDTO objOfficialSustitute = getOfficer(objEconomicGroup.getSubstitute());
				if (objOfficialSustitute != null && objOfficialSustitute.getOfficerName() != null) {
					objEconomicGroup.setFunctionaryNameSubstitute(objOfficialSustitute.getOfficerName());
				}
			}
			customerInformation.getClientInformation().put("economicGroup", objEconomicGroup);
			customerInformation = mapEconomicGroup(customerInformation, objEconomicGroup, groupCode);

			List<CustomerDTO> groupCustomers = getGroupMembers(groupCode);

			for (CustomerDTO customerMember : groupCustomers) {
				logger.logDebug("Link up type member" + customerMember.getLinkUpType());
				if (customerMember.getLinkUpType() != null) {

					customerMember.setLinkUpTypeDescription(catalogDAO.getValueCatalog("cl_relacion_banco", customerMember.getLinkUpType()));
				}
			}
			customerInformation.getClientInformation().put("dataSourceGroup", groupCustomers);

			// Deudas
			MaxDebtDTO maxDebtRequest = maxDebtManagerImpl.getMaxDebt(groupCode, objEconomicGroup.getGroupId());
			if (maxDebtRequest != null) {
				maxDebtRequest.setAvailable(maxDebtRequest.getLimitDebt() - maxDebtRequest.getDebtAmount());
			}
			customerInformation.getClientInformation().put("maxDebtRequest", maxDebtRequest);

			// Direcciones para el Miembro Principal del Grupo
			List<AddressDataResponse> seriesDirectionsMain = new ArrayList<AddressDataResponse>();
			if (objEconomicGroup.getGroupRepresentative() != null) {
				logger.logDebug("objEconomicGroup.getGroupRepresentative: " + objEconomicGroup.getGroupRepresentative());
				CustomerDataRequest customerDataRequest = new CustomerDataRequest();
				customerDataRequest.setCustomerId(objEconomicGroup.getGroupRepresentative());
				logger.logDebug("customerDataRequest.getCustomerId(): " + customerDataRequest.getCustomerId());
				List<AddressDataResponse> addressResponse = addressTxService.getAddressesbyCustomer(customerDataRequest);

				if (addressResponse != null && addressResponse.size() > 0) {
					for (AddressDataResponse addressDataResponse : addressResponse) {
						if (!"CE".equals(addressDataResponse.getTypeCode())) {
							seriesDirectionsMain.add(addressDataResponse);
						}
					}
				}

			}
			customerInformation.getClientInformation().put("seriesDirectionsMain", seriesDirectionsMain);
			return customerInformation;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.009"), ex);
			throw new BusinessException(7300019, "An error occurred at obtaining Economic Group detail");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupDetail"));
		}
	}

	public List<CustomerDTO> getGroupMembers(Integer groupCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupMembers"));
			List<CustomerDTO> groupMembers = customerDAO.getGroupMembers(groupCode);
			if (groupMembers != null) {
				for (CustomerDTO member : groupMembers) {
					if (member.getRole() != null && !"".equals(member.getRole().trim())) {
						member.setRoleDescription(catalogDAO.getValueCatalog("cl_rol_grupo", member.getRole()));
					}
				}
			}
			return groupMembers;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.008"), ex);
			throw new BusinessException(7300020, "An error occurred at getting the Economic Group members");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupMembers"));
		}
	}

	public CustomerDTO getNaturalClient(Integer customerId) {
		try {

			logger.logDebug("Start getNaturalClient");

			CustomerDTO customerResponse = customerDAO.getCustomer(customerId);

			if (customerResponse.getDocumentType().equals("P") || customerResponse.getDocumentType().equals("E") || customerResponse.getDocumentType().equals("PE")
					|| customerResponse.getDocumentType().equals("N")) {
				if (customerResponse.getCityOfBirth() != null) {

					customerResponse.setCityOfBirthDescription(customerDAO.getDescriptionCountry(customerResponse.getCityOfBirth()));

				} else {
					customerResponse.setCityOfBirthDescription(null);
				}

			}

			logger.logDebug("City of birth" + customerResponse.getCityOfBirthDescription());
			if (customerResponse.getDocumentType().equals("P") || customerResponse.getDocumentType().equals("E") || customerResponse.getDocumentType().equals("PE")
					|| customerResponse.getDocumentType().equals("N")) {

				customerResponse.setPlaceDocDescription(customerDAO.getDescriptionCountry(customerResponse.getPlaceDoc()));
			} else {
				customerResponse.setPlaceDocDescription(customerDAO.getDescriptionCity(customerResponse.getPlaceDoc()));

			}

			logger.logDebug("Place doc descr" + customerResponse.getPlaceDocDescription());
			if (customerResponse.getDocumentType() != null) {

				customerResponse.setDocumentTypeDescription(customerDAO.getDocumentType(customerResponse.getDocumentType()));

			}
			logger.logDebug("Doc Type" + customerResponse.getDocumentTypeDescription());

			if (customerResponse.getLinkUpType() != null) {

				customerResponse.setLinkUpTypeDescription(catalogDAO.getValueCatalog("cl_relacion_banco", customerResponse.getLinkUpType()));

			}

			logger.logDebug("Link up type" + customerResponse.getLinkUpTypeDescription());
			if (customerResponse.getCodeGender() != null) {

				customerResponse.setGender(catalogDAO.getValueCatalog("cl_sexo", customerResponse.getCodeGender()));

			}
			logger.logDebug("Gender" + customerResponse.getGender());

			if (customerResponse.getProfession() != null) {
				customerResponse.setProfessionDescription(catalogDAO.getValueCatalog("cl_profesion", customerResponse.getProfession()));

			}
			logger.logDebug("Profession Desc" + customerResponse.getProfessionDescription());

			if (customerResponse.getActivity() != null) {

				customerResponse.setActivityDescription(customerDAO.getDescriptionActivity(customerResponse.getActivity()));

			}
			logger.logDebug("Activity Desc" + customerResponse.getActivityDescription());

			if (customerResponse.getCivilStatus() != null && !customerResponse.getCivilStatus().trim().equals("")) {
				customerResponse.setCivilStatusDescription(catalogDAO.getValueCatalog("cl_ecivil", customerResponse.getCivilStatus()));

			}
			logger.logDebug("Civil Status Desc" + customerResponse.getCivilStatusDescription());
			if (customerResponse.getPersonType() != null) {

				customerResponse.setPersonTypeDescription(catalogDAO.getValueCatalog("cl_ptipo", customerResponse.getPersonType()));

			}
			logger.logDebug("Person Type Desc" + customerResponse.getPersonTypeDescription());

			if (customerResponse.getStudyLevel() != null) {
				customerResponse.setStudyLevelDescription(catalogDAO.getValueCatalog("cl_nivel_estudio", customerResponse.getStudyLevel()));

			}
			logger.logDebug("Study Level Desc" + customerResponse.getStudyLevelDescription());
			if (customerResponse.getGroupOrg() != null) {
				customerResponse.setGroupDescription(customerDAO.getNameGroup(customerResponse.getGroupOrg()));

			} else {
				customerResponse.setGroupDescription(null);
			}
			logger.logDebug("Group Desc" + customerResponse.getGroupDescription());
			if (customerResponse.getOfficial() == null || customerResponse.getOfficial() == 0) {
				customerResponse.setOfficial(null);
			} else {

				Object[] official = customerDAO.getOfficial(customerResponse.getOfficial());

				if (official != null && official[0] != null && !official[0].toString().trim().equals("")) {

					logger.logError(official[0].toString());

					String officialStr = official[0].toString();

					if (officialStr.length() > 44) {

						customerResponse.setDescriptionOfficial(official[0].toString().substring(0, 44));
					} else {
						customerResponse.setDescriptionOfficial(official[0].toString());
					}
				}

				if (official != null && official[1] != null) {
					customerResponse.setMainLogin(official[1].toString());
				}

			}

			logger.logDebug("Main Login" + customerResponse.getMainLogin());

			if (customerResponse.getCustomerSituation() != null) {

				customerResponse.setCustomerSituationDescription(catalogDAO.getValueCatalog("cl_situacion_cliente", customerResponse.getCustomerSituation()));

			}
			logger.logDebug("Customer Situation Desc" + customerResponse.getCustomerSituationDescription());

			if (customerResponse.getBirthdate() != null) {
				customerResponse.setAge(UtilFunction.getEdad(customerResponse.getBirthdate()));
			}
			logger.logDebug("Age" + customerResponse.getAge());

			Instance instance = customerDAO.getCustomerCouple(customerId);
			if (instance != null) {
				customerResponse.setFullNameCouple(instance.getFullNameCouple());
				customerResponse.setRelationName(instance.getRelationName());
			}
			logger.logDebug("Full Name Couple" + customerResponse.getFullNameCouple());
			logger.logDebug("Relation Name" + customerResponse.getRelationName());

			if (customerResponse.getBlocked() != null) {
				customerResponse.setDescState(getCatalogValue(catalogDAO.getCatalogsByName("cl_estados_ente"), customerResponse.getBlocked()));
			}
			List<EconomicActivityDTO> economicActivityDTOList = customerDAO.getEconomicActivitiesByCustomer(customerId);
			customerResponse.setEconomicActivity(economicActivityDTOList);

			if (customerResponse.getGroupName() == null || customerResponse.getGroupName().isEmpty()) {
				List<EconomicGroupDTO> lstEconomicGroupDTO = customerDAO.getCustomerGroupsByCustomer(customerId);
				if (lstEconomicGroupDTO != null) {
					customerResponse.setGroupName("");
					for (EconomicGroupDTO eg : lstEconomicGroupDTO) {
						customerResponse.setGroupName(customerResponse.getGroupName() + "," + eg.getGroupName());
					}
				}
			}
			logger.logDebug("economicActivityDTOList" + customerResponse.getEconomicActivity().size());

			return customerResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", customerId), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getNaturalClient"));
			// logger.logDebug("Finish getNaturalClient");
		}
	}

	public CustomerInformationDTO mapEconomicGroup(CustomerInformationDTO customerInformation, EconomicGroupDTO objEconomicGroup, Integer groupCode) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "mapEconomicGroup"));
		// logger.logDebug("Start mapEconomicGroup");
		try {
			ClientGeneralDataDTO clientGeneralData = new ClientGeneralDataDTO();
			clientGeneralData.setCode(groupCode == null ? 0 : groupCode);
			clientGeneralData.setDocumentId(objEconomicGroup.getRepresentativeGroupDocumentId());
			clientGeneralData.setTutorNumberId(objEconomicGroup.getGroupRepresentative() == null ? 0 : objEconomicGroup.getGroupRepresentative());
			StringBuffer representativeName = new StringBuffer();
			representativeName.append(objEconomicGroup.getRepresentativeName() == null ? "" : objEconomicGroup.getRepresentativeName());
			representativeName.append(" ");
			representativeName.append(objEconomicGroup.getFirstSurnameRepresentative() == null ? "" : objEconomicGroup.getFirstSurnameRepresentative());
			representativeName.append(" ");
			representativeName.append(objEconomicGroup.getSecondSurnameRepresentative() == null ? "" : objEconomicGroup.getSecondSurnameRepresentative());
			clientGeneralData.setTutorName(representativeName.toString());
			clientGeneralData.setJoinDate(objEconomicGroup.getRegistrationDate());
			clientGeneralData.setDescriptionOfficial(objEconomicGroup.getFunctionaryName());
			clientGeneralData.setName(objEconomicGroup.getGroupName());
			clientGeneralData.setGroupType(objEconomicGroup.getGroupType());
			clientGeneralData.setState(objEconomicGroup.getState());
			clientGeneralData.setType(objEconomicGroup.getType());
			clientGeneralData.setCycleNumber(objEconomicGroup.getCycleNumber());
			customerInformation.getClientInformation().put("clientGeneralData", clientGeneralData);

			// Sección Información del Grupo Solidario
			if ("S".equals(objEconomicGroup.getType())) {
				GroupOtherInformationDTO groupOtherInformation = new GroupOtherInformationDTO();

				groupOtherInformation.setState(objEconomicGroup.getState());
				groupOtherInformation.setMeetingAddress(objEconomicGroup.getMeetingAddress());

				if (objEconomicGroup.getMeetingHour() != null) {
					groupOtherInformation.setMeetingDay(new SimpleDateFormat("dd/MM/yyyy").format(objEconomicGroup.getMeetingHour()));
					groupOtherInformation.setMeetingHour(new SimpleDateFormat("HH:mm:ss").format(objEconomicGroup.getMeetingHour()));
				}
				groupOtherInformation.setBranchOffice(objEconomicGroup.getBranchOffice());
				groupOtherInformation.setCycleNumber(objEconomicGroup.getCycleNumber());
				groupOtherInformation.setScore(objEconomicGroup.getScore());
				if (objEconomicGroup.getBranchOffice() != null) {
					groupOtherInformation.setBranchOfficeDescription(catalogDAO.getValueCatalog("cl_oficina", objEconomicGroup.getBranchOffice()));
				}
				customerInformation.getClientInformation().put("groupOtherInfromation", groupOtherInformation);
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", "mapEconomicGroup"), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "mapEconomicGroup"));
			// logger.logDebug("Finish mapEconomicGroup");
		}

		return customerInformation;
	}

	public CustomerInformationDTO mapNaturalClient(CustomerInformationDTO customerInformation, CustomerDTO customer) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "mapNaturalClient"));
		try {
			ClientGeneralDataDTO clientGeneralData = new ClientGeneralDataDTO();
			clientGeneralData.setCode(customer.getCode() == null ? 0 : customer.getCode());
			StringBuffer name = new StringBuffer();
			name.append(customer.getName() == null ? "" : customer.getName());
			name.append(" ");
			name.append(customer.getSecondName() == null ? "" : customer.getSecondName());
			name.append(" ");
			name.append(customer.getFirstSurname() == null ? "" : customer.getFirstSurname());
			name.append(" ");
			name.append(customer.getSecondSurname() == null ? "" : customer.getSecondSurname());
			clientGeneralData.setName(name.toString());
			StringBuffer documentId = new StringBuffer();
			documentId.append(customer.getDocumentId() == null ? "" : customer.getDocumentId());
			documentId.append("-");
			documentId.append(customer.getDocumentTypeDescription() == null ? "" : customer.getDocumentTypeDescription());
			clientGeneralData.setDocumentId(documentId.toString());
			clientGeneralData.setDocumentTypeDescription(customer.getDocumentTypeDescription());
			clientGeneralData.setJoinDate(customer.getJoinDate());
			clientGeneralData.setDescriptionOfficial(customer.getDescriptionOfficial());
			clientGeneralData.setOnlyDocumentId(customer.getDocumentId());
			clientGeneralData.setClientSituationDescription(customer.getCustomerSituationDescription());
			clientGeneralData.setExpirationDate(customer.getExpirationDate());
			clientGeneralData.setBirthDate(customer.getBirthdate());
			clientGeneralData.setGender(customer.getGender());
			clientGeneralData.setAge(customer.getAge() == null ? 0 : customer.getAge());
			clientGeneralData.setFullNameCouple(customer.getFullNameCouple());
			clientGeneralData.setType("P");
			clientGeneralData.setCivilStatusDescription(customer.getCivilStatusDescription());
			customerInformation.getClientInformation().put("clientGeneralData", clientGeneralData);

			ClientAdditionalDataDTO clientAdditionalData = new ClientAdditionalDataDTO();
			clientAdditionalData.setNationality(customer.getNationality());
			clientAdditionalData.setClientType(customer.getPersonTypeDescription());
			clientAdditionalData.setLinkUpType(customer.getLinkUpTypeDescription());
			clientAdditionalData.setMaritalStatus(customer.getCivilStatusDescription());
			clientAdditionalData.setCategory("");
			clientAdditionalData.setPreferredClient(customer.getPreferredClient());
			clientAdditionalData.setBusinessLine("");
			clientAdditionalData.setBusinessSegment("");
			clientAdditionalData.setVinculating("");
			clientAdditionalData.setStatus(customer.getStatus());
			clientAdditionalData.setRelationName(customer.getRelationName());
			clientAdditionalData.setEconomicActivity(customer.getEconomicActivity());
			customerInformation.getClientInformation().put("clientAdditionalData", clientAdditionalData);
			customerInformation.getClientInformation().put("economicActivityDataSource", customer.getEconomicActivity());

			ClientOtherInformationDTO clientOtherInformation = new ClientOtherInformationDTO();
			clientOtherInformation.setActivity(customer.getActivity());
			clientOtherInformation.setReportSBS(customer.getSuperBancariaReported());
			clientOtherInformation.setEconomicGroup(customer.getGroupDescription());
			clientOtherInformation.setMaxIDeb(customer.getMaxDebtQuota());
			clientOtherInformation.setNit(customer.getNit());
			clientOtherInformation.setOfficeName(customer.getOfficeName());
			customerInformation.getClientInformation().put("clientOtherInformation", clientOtherInformation);

			ClientAcademicDataDTO clientAcademicData = new ClientAcademicDataDTO();
			clientAcademicData.setStudyLevel(customer.getStudyLevelDescription());
			clientAcademicData.setProfesion(customer.getProfessionDescription());
			customerInformation.getClientInformation().put("clientAcademicData", clientAcademicData);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", "mapNaturalClient"), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "mapNaturalClient"));
			// logger.logDebug("Finish mapNaturalClient");
		}
		return customerInformation;
	}

	public CustomerDTO getQueryLegalClient(Integer customerCode) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getQueryLegalClient"));

		try {
			return getTypes(customerCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.022"), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getQueryLegalClient"));
		}
	}

	public CustomerInformationDTO mapLegalClient(CustomerInformationDTO customerInformation, CustomerDTO customer) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "mapLegalClient"));
		try {
			ClientGeneralDataDTO clientGeneralData = new ClientGeneralDataDTO();
			clientGeneralData.setCode(customer.getCode());
			clientGeneralData.setName(customer.getFullName());
			clientGeneralData.setJoinDate(customer.getJoinDate());
			clientGeneralData.setDescriptionOfficial(customer.getDescriptionOfficial());
			clientGeneralData.setType("C");
			clientGeneralData.setClientSituationDescription(customer.getCustomerSituationDescription());
			clientGeneralData.setCivilStatusDescription(customer.getCivilStatusDescription());

			StringBuilder documentId = new StringBuilder();
			documentId.append(customer.getDocumentId() == null ? "" : customer.getDocumentId());
			documentId.append("-");
			documentId.append(customer.getDescriptionDocument() == null ? "" : customer.getDescriptionDocument());
			clientGeneralData.setDocumentId(documentId.toString());
			clientGeneralData.setDocumentTypeDescription(customer.getDescriptionDocument());
			customerInformation.getClientInformation().put("clientGeneralData", clientGeneralData);

			ClientCompanyDataDTO clientCompanyData = new ClientCompanyDataDTO();
			clientCompanyData.setCompanyType(customer.getTypeCompany());
			clientCompanyData.setLinkUpTypeDescription(customer.getLinkUpTypeDescription());
			clientCompanyData.setNumberEmployees(customer.getNumberEmployees());
			clientCompanyData.setGroupName(customer.getGroupName());
			clientCompanyData.setDescriptionSegment(customer.getDescriptionSegment());
			clientCompanyData.setDescState(customer.getDescState());
			clientCompanyData.setEntailment(customer.getEntailment());
			clientCompanyData.setLegalRepresentative(customer.getLegalRepresentative());
			if (customer.getEconomicActivity() != null && customer.getEconomicActivity().size() > 0) {
				clientCompanyData.setActivity(customer.getEconomicActivity().get(0).getActivity());
				clientCompanyData.setSector(customer.getEconomicActivity().get(0).getSector());
				clientCompanyData.setMain(customer.getEconomicActivity().get(0).getMain());
			}
			customerInformation.getClientInformation().put("clientCompanyData", clientCompanyData);

			ClientAdditionalDataDTO clientAdditionalData = new ClientAdditionalDataDTO();
			clientAdditionalData.setCompanyType(customer.getTypeCompany());
			clientAdditionalData.setBusinessLine("");
			clientAdditionalData.setSuperBancariaReported(customer.getSuperBancariaReported());
			clientAdditionalData.setBusinessSegment("");
			clientAdditionalData.setVinculating("");
			clientAdditionalData.setPreferredClient(customer.getPreferredClient());
			clientAdditionalData.setMaximunTotalDebts("");
			clientAdditionalData.setDescriptionActivity(customer.getActivityDescription());
			clientAdditionalData.setStatus(customer.getStatus());
			clientAdditionalData.setDescriptionSegment(customer.getDescriptionSegment());
			clientAdditionalData.setDescState(customer.getDescState());
			clientAdditionalData.setEntailment(customer.getEntailment());
			clientAdditionalData.setLegalRepresentative(customer.getLegalRepresentative());
			clientAdditionalData.setEconomicActivity(customer.getEconomicActivity());
			clientAdditionalData.setNationality(customer.getNationality());
			clientAdditionalData.setDescriptionCoverage(customer.getDescriptionCoverage());
			clientAdditionalData.setNationality(customer.getNationality());
			clientAdditionalData.setTotalAssets(customer.getTotalAssets());
			clientAdditionalData.setOffice(customer.getOffice());
			clientAdditionalData.setDescriptionCoverage(customer.getDescriptionCoverage());
			clientAdditionalData.setDateHeritage(customer.getDateHeritage());
			clientAdditionalData.setHeritage(customer.getHeritage());

			customerInformation.getClientInformation().put("clientAdditionalData", clientAdditionalData);
			customerInformation.getClientInformation().put("economicActivityDataSource", customer.getEconomicActivity());

			OtherInformationCompanyDTO otherInformationCompany = new OtherInformationCompanyDTO();
			otherInformationCompany.setDescriptionCoverage(customer.getDescriptionCoverage());
			otherInformationCompany.setNationality(customer.getNationality());
			otherInformationCompany.setTotalAssets(customer.getTotalAssets());
			otherInformationCompany.setOffice(customer.getOffice());
			customerInformation.getClientInformation().put("otherInformationCompany", otherInformationCompany);

			ClientOtherInformationDTO clientOtherInformation = new ClientOtherInformationDTO();
			clientOtherInformation.setHeritage(customer.getHeritage());
			customerInformation.getClientInformation().put("clientOtherInformation", clientOtherInformation);
		} catch (Exception ex) {
			// logger.logError(ex);
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019"), ex);
			throw new BusinessException(7300018, "An error ocurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "mapLegalClient"));
		}
		return customerInformation;
	}

	public String getCustomerType(Integer customerCode) {
		CustomerDTO objCustomer;
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomerType"));
			objCustomer = customerDAO.getCustomerType(customerCode);

			if (objCustomer != null) {
				return objCustomer.getSubtype();
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.003"), ex);
			throw new BusinessException(7300021, "An error occurred at getting Customer type");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerType"));
		}

		return null;
	}

	private CustomerDTO getTypes(Integer customerCode) {

		List<Catalog> companyTypeCatalog = catalogDAO.getCatalogsByName("cl_tipn_jur");
		List<Catalog> LinkUpTypeCatalog = catalogDAO.getCatalogsByName("cl_relacion_banco");
		List<Catalog> segmentCatalog = catalogDAO.getCatalogsByName("cl_tip_resd");
		List<Catalog> coverageCatalog = catalogDAO.getCatalogsByName("cl_cobertura");
		List<Catalog> customerState = catalogDAO.getCatalogsByName("cl_estados_ente");
		List<EconomicActivityDTO> economicActivity = customerDAO.getEconomicActivitiesByCustomer(customerCode);
		CustomerDTO customer = customerDAO.getAllLegalClient(customerCode);

		if (customer.getTypeCompanyId() != null) {
			customer.setTypeCompany(getCatalogValue(companyTypeCatalog, customer.getTypeCompanyId()));
		}

		if (customer.getBlocked() != null) {
			customer.setDescState(getCatalogValue(customerState, customer.getBlocked()));
		}

		if (customer.getLinkUpType() != null) {
			customer.setLinkUpTypeDescription(getCatalogValue(LinkUpTypeCatalog, customer.getLinkUpType()));
		}

		if (customer.getSegmentId() != null) {
			customer.setDescriptionSegment(getCatalogValue(segmentCatalog, customer.getSegmentId()));
		}

		if (customer.getCoverageId() != null) {
			customer.setDescriptionCoverage(getCatalogValue(coverageCatalog, customer.getCoverageId()));
		}

		OfficialDTO objOfficial = getOfficer(customer.getOfficial());
		if (objOfficial != null) {
			customer.setFunctionaryName(objOfficial.getOfficerName());
		}

		if (economicActivity != null) {
			customer.setEconomicActivity(economicActivity);
		}

		if (customer.getGroupName() == null || customer.getGroupName().isEmpty()) {
			List<EconomicGroupDTO> lstEconomicGroupDTO = customerDAO.getCustomerGroupsByCustomer(customerCode);
			if (lstEconomicGroupDTO != null) {
				customer.setGroupName("");
				for (EconomicGroupDTO eg : lstEconomicGroupDTO) {
					customer.setGroupName(customer.getGroupName() + "," + eg.getGroupName());
				}
			}
		}
		if (customer.getCustomerSituation() != null) {

			customer.setCustomerSituationDescription(catalogDAO.getValueCatalog("cl_situacion_cliente", customer.getCustomerSituation()));

		}

		if (customer.getOfficial() == null || customer.getOfficial() == 0) {
			customer.setOfficial(null);
		} else {

			Object[] official = customerDAO.getOfficial(customer.getOfficial());

			if (official[0] != null && !official[0].toString().trim().equals("")) {

				logger.logError(official[0].toString());

				String officialStr = official[0].toString();

				if (officialStr.length() > 44) {

					customer.setDescriptionOfficial(official[0].toString().substring(0, 44));
				} else {
					customer.setDescriptionOfficial(official[0].toString());
				}
			}
			customer.setMainLogin(official[1].toString());

		}

		return customer;
	}

	private String getCatalogValue(List<Catalog> catalog, String code) {

		for (Catalog catalogValue : catalog) {
			if (catalogValue.getCode().equals(code.trim())) {
				return catalogValue.getValue();
			}
		}

		return null;
	}

	private OfficialDTO getOfficer(Integer officerCode) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getOfficer"));
			return customerDAO.getOfficer(officerCode);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.004"), ex);
			throw new BusinessException(7300023, "An error ocurred at getting the Loan Officer related to Customer");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getOfficer"));
		}
	}

	/* Getters & Setters */

	public CustomerDAO getCustomerDAO() {
		return customerDAO;
	}

	public void setCustomerDAO(CustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}

	public CatalogDAO getCatalogDAO() {
		return catalogDAO;
	}

	public void setCatalogDAO(CatalogDAO catalogDAO) {
		this.catalogDAO = catalogDAO;
	}

	public GeneralParameterDAO getGeneralParameterDAO() {
		return generalParameterDAO;
	}

	public void setGeneralParameterDAO(GeneralParameterDAO generalParameterDAO) {
		this.generalParameterDAO = generalParameterDAO;
	}

	public MaxDebtManagerImpl getMaxDebtManagerImpl() {
		return maxDebtManagerImpl;
	}

	public void setMaxDebtManagerImpl(MaxDebtManagerImpl maxDebtManagerImpl) {
		this.maxDebtManagerImpl = maxDebtManagerImpl;
	}

	public AddressTxService getAddressTxService() {
		return addressTxService;
	}

	public void setAddressTxService(AddressTxService addressTxService) {
		this.addressTxService = addressTxService;
	}

	public ContactTxService getContactTxService() {
		return contactTxService;
	}

	public void setContactTxService(ContactTxService contactTxService) {
		this.contactTxService = contactTxService;
	}

}