package com.cobiscorp.ecobis.customer.commons.bl.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.commons.dal.CatalogDAO;
import com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Catalog;
import com.cobiscorp.ecobis.customer.commons.bl.CustomerManager;
import com.cobiscorp.ecobis.customer.commons.bl.utils.MessageManager;
import com.cobiscorp.ecobis.customer.commons.bl.utils.UtilFunction;
import com.cobiscorp.ecobis.customer.commons.dal.CustomerDAO;
import com.cobiscorp.ecobis.customer.commons.dal.entities.Instance;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicActivityDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;
import com.cobiscorp.ecobis.customer.commons.dto.OfficialDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;

import javax.persistence.Query;

public class CustomerManagerImpl implements CustomerManager {

	private static ILogger logger = LogFactory.getLogger(CustomerManagerImpl.class);

	CustomerDAO customerDAO;
	CatalogDAO catalogDAO;
	GeneralParameterDAO generalParameterDAO;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getCustomerType
	 */
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
			throw new BusinessException(7300021, "An error occurred at obtain the customer type");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerType"));
		}

		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getGroupMembers
	 */
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
			throw new BusinessException(7300020, "There was an error getting group members");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupMembers"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#
	 * getQueryCustomerAddress (java.lang.Integer)
	 */
	public List<CustomerAddressDTO> getQueryCustomerAddress(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getQueryCustomerAddress"));

			return getTypeAddress(customerCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.004"), ex);
			throw new BusinessException(7300064, "An error occurred at obtain the Client Address");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getQueryCustomerAddress"));
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getGroupByName(java
	 * .lang.String)
	 */
	public List<EconomicGroupDTO> getGroupByName(String groupName) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupByName"));
			if (groupName != null && !groupName.contains("%")) {
				groupName = groupName + "%";

			}
			return customerDAO.getGroupValue(groupName);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.005", groupName), ex);
			throw new BusinessException(7300063, "An error occurred at obtaining Economic Group information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupByName"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getGroupById(java
	 * .lang.Integer, java.lang.String)
	 */
	public List<EconomicGroupDTO> getGroupById(Integer groupId, String valueGroup) {
		try {
			String group = null;

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupById"));

			if (!valueGroup.equals("%") && groupId > 0) {
				group = groupId.toString().concat("%");
			}

			if (!valueGroup.equals("%") && groupId == 0) {
				group = valueGroup;
			}

			return customerDAO.getGroupLike(group);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.006", groupId), ex);
			throw new BusinessException(7300063, "An error occurred at obtaining Economic Group information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupById"));
		}
	}

	/**
	 * Method used to get the address type of a customer.
	 * 
	 * @param idClient
	 *            , it's the customer code
	 * @return a list of customer adresses.
	 */
	private List<CustomerAddressDTO> getTypeAddress(Integer customerCode) {

		List<Catalog> loginTypeCatalog = catalogDAO.getCatalogsByName("cl_tdireccion");
		List<CustomerAddressDTO> addresses = customerDAO.getAllAddress(customerCode);

		for (CustomerAddressDTO address : addresses) {
			address.setTypeDescription(getCatalogValue(loginTypeCatalog, address.getType()));
		}

		return addresses;
	}

	private String getCatalogValue(List<Catalog> catalog, String code) {

		for (Catalog catalogValue : catalog) {
			if (catalogValue.getCode().equals(code.trim())) {
				return catalogValue.getValue();
			}
		}

		return null;
	}

	/**
	 * Method used to obtain the information officer.
	 * 
	 * @param officerCode
	 *            = Integer, it's the officer code.
	 * @return A OfficialDTO object with information of officer
	 */
	private OfficialDTO getOfficer(Integer officerCode) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getOfficer"));
			return customerDAO.getOfficer(officerCode);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.004"), ex);
			throw new BusinessException(7300019, "An error occurred at obtaining the group detail");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getOfficer"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getGroupDetail
	 */
	public EconomicGroupDTO getGroupDetail(Integer groupCode, String type) {
		EconomicGroupDTO objEconomicGroup = null;

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupDetail"));
			List<Catalog> estados = catalogDAO.getCatalogsByName("cl_estados_grupo");
			List<Catalog> tiposGrupo = catalogDAO.getCatalogsByName("cl_tipo_grupo");

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

			return objEconomicGroup;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.009"), ex);
			throw new BusinessException(7300019, "An error occurred at obtaining the group detail");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupDetail"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getCustomerScoreHis
	 * (java.lang.Integer)
	 */
	public List<CustomerScoreDTO> getCustomerScoreHis(Integer customerId) {
		try {

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomerScoreHis"));

			return customerDAO.getCustomerScore(customerId);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.007", customerId), ex);
			throw new BusinessException(7300065, "An error occurred at obtaining the Customer Score");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerScoreHis"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getQueryLegalClient
	 * (java.lang.Integer)
	 */
	public CustomerDTO getQueryLegalClient(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getQueryLegalClient"));

			return getTypes(customerCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.022"), ex);
			throw new BusinessException(7300018, "An error occurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getQueryLegalClient"));
		}

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

		return customer;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.CustomerManager#getCustomer(java
	 * .lang.Integer)
	 */
	@Override
	public CustomerDTO getCustomer(Integer customerId) {
		logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomer"));
		CustomerDTO customer = new CustomerDTO();

		try {
			String customerType = getCustomerType(customerId);

			if ("P".equals(customerType)) {
				customer = getNaturalClient(customerId);
			} else {
				customer = getQueryLegalClient(customerId);
			}

			customer.setCustomerType(customerType);
			return customer;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", customerId), ex);
			throw new BusinessException(7300018, "An error occurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomer"));
		}
	}

	@Override
	public CustomerDTO getNaturalClient(Integer customerId) {
		try {

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getNaturalClient"));

			CustomerDTO customerResponse = customerDAO.getCustomer(customerId);

			if (customerResponse.getDocumentType().equals("P") || customerResponse.getDocumentType().equals("E") || customerResponse.getDocumentType().equals("PE")
					|| customerResponse.getDocumentType().equals("N")) {
				if (customerResponse.getCityOfBirth() != null) {

					customerResponse.setCityOfBirthDescription(customerDAO.getDescriptionCountry(customerResponse.getCityOfBirth()));

				} else {
					customerResponse.setCityOfBirthDescription(null);
				}

			}

			if (customerResponse.getDocumentType().equals("P") || customerResponse.getDocumentType().equals("E") || customerResponse.getDocumentType().equals("PE")
					|| customerResponse.getDocumentType().equals("N")) {

				customerResponse.setPlaceDocDescription(customerDAO.getDescriptionCountry(customerResponse.getPlaceDoc()));
			} else {
				customerResponse.setPlaceDocDescription(customerDAO.getDescriptionCity(customerResponse.getPlaceDoc()));

			}

			if (customerResponse.getDocumentType() != null) {

				customerResponse.setDocumentTypeDescription(customerDAO.getDocumentType(customerResponse.getDocumentType()));

			}

			if (customerResponse.getLinkUpType() != null) {

				customerResponse.setLinkUpTypeDescription(catalogDAO.getValueCatalog("cl_relacion_banco", customerResponse.getLinkUpType()));

			}

			if (customerResponse.getCodeGender() != null) {

				customerResponse.setGender(catalogDAO.getValueCatalog("cl_sexo", customerResponse.getCodeGender()));

			}

			if (customerResponse.getProfession() != null) {
				customerResponse.setProfessionDescription(catalogDAO.getValueCatalog("cl_profesion", customerResponse.getProfession()));

			}

			if (customerResponse.getActivity() != null) {

				customerResponse.setActivityDescription(customerDAO.getDescriptionActivity(customerResponse.getActivity()));

			}

			if (customerResponse.getCivilStatus() != null && !customerResponse.getCivilStatus().trim().equals("")) {
				customerResponse.setCivilStatusDescription(catalogDAO.getValueCatalog("cl_ecivil", customerResponse.getCivilStatus()));

			}

			if (customerResponse.getPersonType() != null) {

				customerResponse.setPersonTypeDescription(catalogDAO.getValueCatalog("cl_ptipo", customerResponse.getPersonType()));

			}

			if (customerResponse.getStudyLevel() != null) {
				customerResponse.setStudyLevelDescription(catalogDAO.getValueCatalog("cl_nivel_estudio", customerResponse.getStudyLevel()));

			}

			if (customerResponse.getGroupOrg() != null) {
				customerResponse.setGroupDescription(customerDAO.getNameGroup(customerResponse.getGroupOrg()));

			} else {
				customerResponse.setGroupDescription(null);
			}

			if (customerResponse.getOfficial() == null || customerResponse.getOfficial() == 0) {
				customerResponse.setOfficial(null);
			} else {

				Object[] official = customerDAO.getOfficial(customerResponse.getOfficial());

				if (official[0] != null && !official[0].toString().trim().equals("")) {

					logger.logError(official[0].toString());

					String officialStr = official[0].toString();

					if (officialStr.length() > 44) {

						customerResponse.setDescriptionOfficial(official[0].toString().substring(0, 44));
					} else {
						customerResponse.setDescriptionOfficial(official[0].toString());
					}
				}
				customerResponse.setMainLogin(official[1].toString());

			}

			if (customerResponse.getCustomerSituation() != null) {

				customerResponse.setCustomerSituationDescription(catalogDAO.getValueCatalog("cl_situacion_cliente", customerResponse.getCustomerSituation()));

			}

			if (customerResponse.getBirthdate() != null) {
				customerResponse.setAge(UtilFunction.getEdad(customerResponse.getBirthdate()));
			}

			Instance instance = customerDAO.getCustomerCouple(customerId);
			if (instance != null) {
				customerResponse.setFullNameCouple(instance.getFullNameCouple());
				customerResponse.setRelationName(instance.getRelationName());
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

			return customerResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.019", customerId), ex);
			throw new BusinessException(7300018, "An error occurred at obtaining Customer information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getNaturalClient"));
		}
	}

	/**
	 * This method uses strings to define the query string that it's going to be
	 * executed by the method execGetCustomersByParameters. Here we uses the
	 * Customer SubType, the consult Type and consult Mode.
	 * 
	 * @see com.cobiscorp.ecobis.customer.commons.bl.CustomerManager#getCustomerByParameters(com.cobiscorp.ecobis.clientviewer.dto.SearchCustomerDTO)
	 * @author lcorrales
	 */
	public List<CustomerDTO> getCustomerByParameters(SearchCustomerDTO searchCustomer) {
		try {

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomerByParameters"));

			logger.logDebug("searchCustomer.getIsClient()" + searchCustomer.getIsClient());

			logger.logDebug("-->MODE--> " + searchCustomer.getMode());
			logger.logDebug("-->TYPE--> " + searchCustomer.getType());
			logger.logDebug("-->SubTYPE--> " + searchCustomer.getSubType());
			logger.logDebug("-->ColumnExist--> " + searchCustomer.getColumnExist());

			String comercialName = "";
			List<Object> parameters = new ArrayList<Object>();

			if (searchCustomer.getComercialName() != null) {
				comercialName = searchCustomer.getComercialName().trim();
			}

			StringBuffer headerQuery = new StringBuffer();
			StringBuffer tablesQuery = new StringBuffer();
			StringBuffer criteriaQuery = new StringBuffer();
			StringBuffer orderByQuery = new StringBuffer();

			if (searchCustomer.getClientName() == null) {
				searchCustomer.setClientName("");
			}

			if (searchCustomer.getClientLastName() == null) {
				searchCustomer.setClientLastName("");
			}

			searchCustomer.setClientSecondLastName("%");
			searchCustomer.setClientSecondName("%");

			if (searchCustomer.getSubType().trim().equals("P")) {

				headerQuery.append(" Select TOP ");
				headerQuery.append(searchCustomer.getSize());
				headerQuery.append(" 'No.'= en_ente,");
				headerQuery.append(" 'Primer Apellido'= case p_estado_civil");
				headerQuery.append(" when 'ME' then p_p_apellido + ' ' + '(MENOR)'");
				headerQuery.append(" else p_p_apellido end,");
				headerQuery.append(" 'Segundo Apellido' = p_s_apellido,");
				headerQuery.append(" 'Apellido de Casada' = p_c_apellido,");
				headerQuery.append(" 'Primer Nombre' = case p_estado_civil");
				headerQuery.append(" when 'ME' then en_nombre + ' ' + '(MENOR)'");
				headerQuery.append(" else en_nombre  end,");
				headerQuery.append(" 'Segundo Nombre' = p_s_nombre,");
				headerQuery.append(" 'I.D.' = en_ced_ruc,");
				headerQuery
						.append(" 'Tipo I.D.' = (SELECT valor FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla ='cl_tipo_documento') AND codigo = x.en_tipo_ced),");
				headerQuery.append(" 'Oficial' = convert(int, en_oficial),");
				headerQuery.append(" 'Nombre del Oficial'  = (select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial");
				headerQuery.append(" where x.en_oficial = oc_oficial ");
				headerQuery.append(" and oc_funcionario =  fu_funcionario),");
				headerQuery.append(" 'Bloqueado' = CASE x.en_estado WHEN 'S' THEN 'Si' ELSE 'No' END,");
				headerQuery.append(" 'Estado' = ea_estado,");
				headerQuery.append(" 'Es cliente' = en_cliente,");
				headerQuery.append(" 'Desc. de Estado' = b.valor,");
				headerQuery.append(" 'SubTipo Cliente'= en_subtipo");
				headerQuery.append(" , 'Calif Cartera' = en_calif_cartera");
				headerQuery.append(" , 'Banco Santander' = x.en_banco");
				tablesQuery.append(" from cobis..cl_ente x , cobis..cl_ente_aux z, cobis..cl_tabla a, cobis..cl_catalogo b");
				criteriaQuery.append(" where x.en_subtipo = 'P'");
				criteriaQuery.append(" and x.en_ente = z.ea_ente");
				criteriaQuery.append(" and a.tabla = 'cl_estados_ente'");
				criteriaQuery.append(" and a.codigo = b.tabla");
				criteriaQuery.append(" and z.ea_estado = b.codigo");
				logger.logDebug("searchCustomer.getLastCode() " + searchCustomer.getLastCode());
				logger.logDebug("searchCustomer.getType()" + searchCustomer.getType());
				logger.logDebug("searchCustomer.getMode()" + searchCustomer.getMode());
				switch (searchCustomer.getType()) {

				case 1:
					orderByQuery.append(" order by x.en_ente ");
					if (searchCustomer.getClientNumber() != 0  || searchCustomer.getClientNumberB() != "") {
						switch (searchCustomer.getMode()) {

						case 0:
							criteriaQuery.append(" and x.en_ente >= ?");
							parameters.add(searchCustomer.getClientNumber());

							break;
						case 2:

							criteriaQuery.append(" and x.en_ente = ?");
							parameters.add(searchCustomer.getClientNumber());
							if (!"".equals(searchCustomer.getLastCode())) {
								criteriaQuery.append(" and x.en_ente > ?");
								parameters.add(searchCustomer.getLastCode());
							}
							break;
						case 3:

							criteriaQuery.append(" and x.en_banco = ?");
							parameters.add(searchCustomer.getClientNumberB());
							if (!"".equals(searchCustomer.getLastCode())) {
								criteriaQuery.append(" and x.en_banco > ?");
								parameters.add(searchCustomer.getLastCode());
							}
							break;
						}
					}
					break;

				case 5:
					if (!"".equals(searchCustomer.getLastCode())) {
						criteriaQuery.append(" and x.p_p_apellido + ' ' + x.p_s_apellido + ' ' + x.en_nombre  + ' ' + x.p_s_nombre  > ?");
						parameters.add(searchCustomer.getLastCode());
					}
					orderByQuery.append(" order by x.p_p_apellido, x.p_s_apellido, x.en_nombre, x.p_s_nombre ");
					logger.logDebug("(searchCustomer.getClientLastName()" + searchCustomer.getClientLastName());
					logger.logDebug("searchCustomer.getClientName()" + searchCustomer.getClientName());
					searchCustomer.setClientLastName(searchCustomer.getClientLastName() != null && "".equals(searchCustomer.getClientLastName().trim()) ? "%" : searchCustomer
							.getClientLastName());
					searchCustomer.setClientName(searchCustomer.getClientName() != null && "".equals(searchCustomer.getClientName().trim()) ? "%" : searchCustomer.getClientName());

					switch (searchCustomer.getMode()) {

					case 0:

						logger.logDebug("case 0 ----->" + searchCustomer.getColumnExist());

						if (searchCustomer.getColumnExist() == 0 && !searchCustomer.getClientLastName().equals("%") && searchCustomer.getClientLastName() != null) {
							criteriaQuery.append(" and x.p_p_apellido >= ?");
							parameters.add(searchCustomer.getClientLastName());
						} else {
							criteriaQuery.append(" and x.en_nomlar like CONCAT(?,'%')");
							parameters.add(searchCustomer.getClientName());
						}

						if (searchCustomer.getColumnExist() == 0 && !searchCustomer.getClientName().equals("%") && searchCustomer.getClientName() != null) {
							logger.logDebug("ingresó 1" + searchCustomer.getClientName());
							criteriaQuery.append(" and x.en_nombre >= ?");
							parameters.add(searchCustomer.getClientName());
						}

						if (!searchCustomer.getClientSecondLastName().equals("%") && !searchCustomer.getClientSecondLastName().equals("")
								&& searchCustomer.getClientSecondLastName() != null) {
							criteriaQuery.append(" and x.p_s_apellido >= ?");
							parameters.add(searchCustomer.getClientSecondLastName());

						}

						if (!searchCustomer.getClientSecondName().equals("%") && !searchCustomer.getClientSecondName().equals("") && searchCustomer.getClientSecondName() != null) {
							criteriaQuery.append(" and x.p_s_nombre >= ?");
							parameters.add(searchCustomer.getClientSecondName());

						}

						break;
					case 2:

						logger.logDebug("case 2 ----->" + searchCustomer.getColumnExist());

						if (searchCustomer.getColumnExist() == 0 && !searchCustomer.getClientLastName().equals("%") && !searchCustomer.getClientLastName().equals("")
								&& searchCustomer.getClientLastName() != null) {
							criteriaQuery.append(" and x.p_p_apellido like CONCAT(?,'%')");
							parameters.add(searchCustomer.getClientLastName());
						} else {
							criteriaQuery.append(" and x.en_nomlar like CONCAT('%',?,'%')");
							parameters.add(searchCustomer.getClientName().trim().replace(" ", "%"));
						}

						if (searchCustomer.getColumnExist() == 0 && !searchCustomer.getClientName().equals("%") && !searchCustomer.getClientName().equals("")
								&& searchCustomer.getClientName() != null) {
							criteriaQuery.append(" and x.en_nombre like CONCAT(?,'%')");
							parameters.add(searchCustomer.getClientName());

						}

						if (!searchCustomer.getClientSecondLastName().equals("%") && !searchCustomer.getClientSecondLastName().equals("")
								&& searchCustomer.getClientSecondLastName() != null) {
							criteriaQuery.append(" and x.p_s_apellido like CONCAT(?,'%')");
							parameters.add(searchCustomer.getClientLastName());
						}

						if (!searchCustomer.getClientSecondName().equals("%") && !searchCustomer.getClientSecondName().equals("") && searchCustomer.getClientSecondName() != null) {
							criteriaQuery.append(" and x.p_s_nombre like CONCAT(?,'%')");
							parameters.add(searchCustomer.getClientName());
						}
					}
					break;
				case 8:

					logger.logDebug("case 8 ----->" + searchCustomer.getColumnExist());

					orderByQuery.append(" order by x.en_ced_ruc ");

					if (searchCustomer.getCedRuc().equals("")) {
						searchCustomer.setCedRuc("%");
					}

					if (searchCustomer.getMode() == 0) {
						criteriaQuery.append(" and x.en_ced_ruc >= ?");
						parameters.add(searchCustomer.getCedRuc());
					}
					if (searchCustomer.getMode() == 2) {
						criteriaQuery.append(" and x.en_ced_ruc like CONCAT('%',?, '%')");
						parameters.add(searchCustomer.getCedRuc());
						if (!"".equals(searchCustomer.getLastCode())) {
							criteriaQuery.append(" and x.en_ced_ruc > ?");
							parameters.add(searchCustomer.getLastCode());
						}
					}
					break;
				}

				if (searchCustomer.getIsClient().equals('N')) {
					criteriaQuery.append(" and z.ea_estado = 'P' ");
				} else if (searchCustomer.getIsClient().equals('S')) {
					criteriaQuery.append(" and z.ea_estado = 'A' ");
				}

				return execGetCustomersByParameters(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), parameters, orderByQuery.toString(), searchCustomer.getSubType());
			}

			if (searchCustomer.getSubType().trim().equals("C")) {
				headerQuery.append("Select TOP ");
				headerQuery.append(searchCustomer.getSize());
				headerQuery.append(" 'No.' = en_ente,");

				criteriaQuery.append(" where x.en_subtipo = 'C'");
				criteriaQuery.append(" and x.en_ente = z.ea_ente");
				criteriaQuery.append(" and a.tabla = 'cl_estados_ente'");
				criteriaQuery.append(" and a.codigo = b.tabla");
				criteriaQuery.append(" and z.ea_estado = b.codigo");

				if (searchCustomer.getType() == 1 || searchCustomer.getType() == 2) {
					headerQuery.append(" 'Nombre Comercial' = en_nombre,");
					headerQuery.append(" 'Razón Social' = c_razon_social,");
					headerQuery.append(" 'Apellido de Casada' = null,");
					headerQuery.append(" 'Primer Nombre' = null,");
					headerQuery.append(" 'Segundo Nombre' = null,");

					if (searchCustomer.getType() == 1) {
						orderByQuery.append(" order by x.en_ente ");

						if (searchCustomer.getClientNumber() != 0) {
							switch (searchCustomer.getMode()) {
							case 0:
								criteriaQuery.append(" and x.en_ente >= ?");
								parameters.add(searchCustomer.getClientNumber());
								break;
							case 2:
								criteriaQuery.append(" and x.en_ente = ?");
								parameters.add(searchCustomer.getClientNumber());
								break;

							}

							if (searchCustomer.getMode() == 2 && !"".equals(searchCustomer.getLastCode())) {
								criteriaQuery.append(" and x.en_ente > ?");
								parameters.add(searchCustomer.getLastCode());
							}
						}
					}
					if (searchCustomer.getType() == 2) {
						orderByQuery.append(" order by x.en_ced_ruc ");

						if (!("%").equals(searchCustomer.getCedRuc())) {
							switch (searchCustomer.getMode()) {
							case 0:
								criteriaQuery.append(" and x.en_ced_ruc >= ?");
								parameters.add(searchCustomer.getCedRuc());
								break;
							case 2:
								criteriaQuery.append(" and x.en_ced_ruc like CONCAT('%',?, '%')");
								parameters.add(searchCustomer.getCedRuc());
								if (!"".equals(searchCustomer.getLastCode())) {
									criteriaQuery.append(" and x.en_ced_ruc > ?");
									parameters.add(searchCustomer.getLastCode());
								}
								break;

							}
						}
					}
				}

				if (searchCustomer.getType() == 5) {

					if (searchCustomer.getComercialName().equals("")) {
						searchCustomer.setCedRuc("%");
					}

					headerQuery.append(" 'Nombre Comercial' = en_nombre,");
					headerQuery.append(" 'Razón Social' = c_razon_social,");
					headerQuery.append(" 'Apellido de Casada' = null,");
					headerQuery.append(" 'Primer Nombre' = null,");
					headerQuery.append(" 'Segundo Nombre' = null,");

					orderByQuery.append(" order by x.en_nombre ");

					if (!searchCustomer.getComercialName().equals("%")) {
						// Modo 0 y Modo 2 son lo mismo en el sp
						if (searchCustomer.getMode() == 0 || searchCustomer.getMode() == 2) {
							criteriaQuery.append(" and x.en_nombre like CONCAT('%',?,'%')");
							parameters.add(comercialName);
						}
					}
					if (!"".equals(searchCustomer.getLastCode())) {
						criteriaQuery.append(" and x.en_nombre > ?");
						parameters.add(searchCustomer.getLastCode());
					}

				}

				if (searchCustomer.getIsClient().equals('N')) {
					criteriaQuery.append("  and z.ea_estado = 'P' ");
				} else if (searchCustomer.getIsClient().equals('S')) {
					criteriaQuery.append("  and z.ea_estado = 'A' ");
				}

				headerQuery.append(" 'No.I.D.' = en_ced_ruc,");
				headerQuery
						.append(" 'Tipo I.D.' = (SELECT valor FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla ='cl_tipo_documento') AND codigo = x.en_tipo_ced),");
				headerQuery.append(" 'Oficial' = convert(int, en_oficial),");
				headerQuery.append(" 'Nombre del Oficial' = (select fu_nombre");
				headerQuery.append(" from cobis..cl_funcionario, cobis..cc_oficial where x.en_oficial = oc_oficial and oc_funcionario =  fu_funcionario),");
				headerQuery.append(" 'Bloqueado' = CASE x.en_estado WHEN 'S' THEN 'Si' ELSE 'No' END,");
				headerQuery.append(" 'Estado' = ea_estado,");
				headerQuery.append(" 'Es cliente'= en_cliente,");
				headerQuery.append(" 'Desc. de Estado' = b.valor,");
				headerQuery.append(" 'SubTipo Cliente' = en_subtipo");
				headerQuery.append(" , 'Calif Cartera' = en_calif_cartera");
				tablesQuery.append(" from cobis..cl_ente x, cobis..cl_ente_aux z, cobis..cl_tabla a, cobis..cl_catalogo b ");

				return execGetCustomersByParameters(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), parameters, orderByQuery.toString(), searchCustomer.getSubType());
			}

			return null;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.010"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerByParameters"));
		}
	}

	/**
	 * This method uses strings to define the query string that it's going to be
	 * executed by the method execGetCustomersByParameters. Here we uses the
	 * Customer SubType, the consult Type and consult Mode.
	 * 
	 * @see com.cobiscorp.ecobis.customer.commons.bl.CustomerManager#getCustomerByParameters(com.cobiscorp.ecobis.clientviewer.dto.SearchCustomerDTO)
	 * @author lcorrales
	 */
	public List<CustomerDTO> getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer) {
		try {

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getCustomersByAutoCompleteText"));

			logger.logDebug("getCustomersByAutoCompleteText-->searchCustomer.getIsClient()-->" + searchCustomer.getIsClient());

			List<Object> params =  new ArrayList<Object>();
			StringBuffer headerQuery = new StringBuffer();
			StringBuffer tablesQuery = new StringBuffer();
			StringBuffer criteriaQuery = new StringBuffer();
			StringBuffer orderByQuery = new StringBuffer();

			if (null != searchCustomer) {

				if (null == searchCustomer.getClientName()) {
					searchCustomer.setClientName("");
				} else {
					searchCustomer.setClientName(searchCustomer.getClientName().trim());
				}
			}

			if (searchCustomer.getSubType().trim().equals("P")) {

				// aumenta %
				String[] wClientName = searchCustomer.getClientName().split(" ");
				StringBuffer wCriteriaName = new StringBuffer();

				for (String wcn : wClientName) {
					wCriteriaName.append("%");
					wCriteriaName.append(wcn);
				}

				if (wCriteriaName.length() > 0) {
					wCriteriaName.append("%");
				}

				headerQuery.append(" Select TOP ");
				headerQuery.append(searchCustomer.getSize());
				headerQuery.append(" 'No.'= x.en_ente,");
				headerQuery.append(" 'Nombre Largo'= x.en_nomlar ");
				tablesQuery.append(" from cobis..cl_ente x, cobis..cl_ente_aux z ");
				criteriaQuery.append(" where x.en_subtipo = 'P' ");
				criteriaQuery.append(" and x.en_ente = z.ea_ente ");

				if (searchCustomer.getIsClient().equals('S')) {
					criteriaQuery.append(" and z.ea_estado = 'A' ");
				} else {
					criteriaQuery.append(" and z.ea_estado = 'P' ");
				}

				criteriaQuery.append(" and upper(x.en_nomlar) like ?");
				params.add(wCriteriaName.toString().toUpperCase());
				orderByQuery.append(" order by x.en_nomlar ");

				return execGetCustomersByAutoCompleteText(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), params, orderByQuery.toString(),
						searchCustomer.getSubType());
			}

			if (searchCustomer.getSubType().trim().equals("C")) {

				// aumenta %
				String[] wCommercialName = searchCustomer.getComercialName().split(" ");
				StringBuffer wCriteriaName = new StringBuffer();

				for (String wcn : wCommercialName) {
					wCriteriaName.append("%");
					wCriteriaName.append(wcn);
				}

				if (wCriteriaName.length() > 0) {
					wCriteriaName.append("%");
				}

				headerQuery.append("Select TOP ");
				headerQuery.append(searchCustomer.getSize());
				headerQuery.append(" 'No.' = en_ente, ");
				headerQuery.append(" 'Razón Social' = x.c_razon_social, ");
				headerQuery.append(" 'Nombre Comercial' = x.en_nombre ");
				tablesQuery.append(" from cobis..cl_ente x, cobis..cl_ente_aux z ");
				criteriaQuery.append(" where x.en_subtipo = 'C' ");
				criteriaQuery.append(" and x.en_ente = z.ea_ente ");

				if (searchCustomer.getIsClient().equals('S')) {
					criteriaQuery.append(" and z.ea_estado = 'A' ");
				} else {
					criteriaQuery.append(" and z.ea_estado = 'P' ");
				}

				criteriaQuery.append(" and upper(x.en_nombre) like ?");
				params.add(wCriteriaName.toString().toUpperCase());
				orderByQuery.append(" order by x.en_nombre ");

				return execGetCustomersByAutoCompleteText(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), params, orderByQuery.toString(),
						searchCustomer.getSubType());
			}

			if (searchCustomer.getSubType().trim().equals("GE") && searchCustomer.getIsClient().equals('S')) {

				// aumenta %
				String[] wGroupName = searchCustomer.getClientName().split(" ");
				StringBuffer wCriteriaName = new StringBuffer();

				for (String wcn : wGroupName) {
					wCriteriaName.append("%");
					wCriteriaName.append(wcn);
				}

				if (wCriteriaName.length() > 0) {
					wCriteriaName.append("%");
				}

				headerQuery.append("Select TOP ");
				headerQuery.append(searchCustomer.getSize());
				headerQuery.append(" 'Id.' = gr_grupo, ");
				headerQuery.append(" 'Nombre Grupo' = x.gr_nombre ");
				tablesQuery.append(" from cobis..cl_grupo x ");
				criteriaQuery.append(" where upper(x.gr_nombre) like ?");
				params.add(wCriteriaName.toString().toUpperCase());
				orderByQuery.append(" order by x.gr_nombre ");

				return execGetCustomersByAutoCompleteText(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), params, orderByQuery.toString(),
						searchCustomer.getSubType());
			}

			return null;

		} catch (

		Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.010"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerByParameters"));
		}
	}

	/**
	 * This method uses strings to define the query string that it's going to be
	 * executed by the method execGetCustomersByParameters. Here we uses the
	 * Customer SubType, the consult Type and consult Mode.
	 * 
	 * @see com.cobiscorp.ecobis.customer.commons.bl.CustomerManager#getCustomerByParameters(com.cobiscorp.ecobis.clientviewer.dto.SearchCustomerDTO)
	 * @author lcorrales
	 */
	public TableDTO checkColumnExist(String database, String table, String column) {
		try {

			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "checkColumnExist"));

			logger.logDebug("---> checkColumnExist ---> " + database + "-->" + table + "-->" + column);

			List<Object> params =  new ArrayList<Object>();
			StringBuffer headerQuery = new StringBuffer();
			StringBuffer tablesQuery = new StringBuffer();
			StringBuffer criteriaQuery = new StringBuffer();
			StringBuffer orderByQuery = new StringBuffer();

			database = database == null ? "" : database;
			column = column == null ? "" : column;

			headerQuery.append("Select 1 ");
			tablesQuery.append(" from ");
			tablesQuery.append(database + "..");
			tablesQuery.append("sysobjects a, ");
			tablesQuery.append(database + "..");
			tablesQuery.append("syscolumns b ");
			criteriaQuery.append(" where a.name = ?");
			params.add(table);
			criteriaQuery.append(" and b.name= ?");
			params.add(column);
			criteriaQuery.append(" and a.id = b.id ");
			orderByQuery.append("");

			return execCheckColumnExist(headerQuery.toString(), tablesQuery.toString(), criteriaQuery.toString(), params, orderByQuery.toString());

		} catch (

		Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.010"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getCustomerByParameters"));
		}
	}

	/**
	 * Method that arms the query to execute in the method
	 * getCustomerByParameters.
	 * 
	 * @param columns
	 *            It's the string with de columns for the query.
	 * @param tables
	 *            It's the string with the tables for the query
	 * @param criteria
	 *            It's the string with the criteria's search for the query
	 * @param orderBy
	 *            It's the string with the criteria's for the order by of the
	 *            query
	 * @param customerType
	 *            It's string to especify the customer Type
	 * @return a list of CustomerDTO that meets the query conditions.
	 */
	private List<CustomerDTO> execGetCustomersByParameters(String columns, String tables, String criteria, List<Object> params, String orderBy, String customerType) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "execGetCustomersByParameters"));
			StringBuffer query = new StringBuffer();
			query.append(columns);
			query.append(tables);
			query.append(criteria);
			query.append(orderBy);
			return customerDAO.getCustomerByParameters(query.toString(), params, customerType);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.011"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "execGetCustomersByParameters"));
		}
	}

	/**
	 * Method that arms the query to execute in the method
	 * getCustomerByParameters.
	 * 
	 * @param columns
	 *            It's the string with de columns for the query.
	 * @param tables
	 *            It's the string with the tables for the query
	 * @param criteria
	 *            It's the string with the criteria's search for the query
	 * @param orderBy
	 *            It's the string with the criteria's for the order by of the
	 *            query
	 * @param customerType
	 *            It's string to especify the customer Type
	 * @return a list of CustomerDTO that meets the query conditions.
	 */
	private List<CustomerDTO> execGetCustomersByAutoCompleteText(String columns, String tables, String criteria, List<Object> params, String orderBy, String customerType) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "execGetCustomersByAutoCompleteText"));
			StringBuffer query = new StringBuffer();
			query.append(columns);
			query.append(tables);
			query.append(criteria);
			query.append(orderBy);

			logger.logError("QUERY --> " + query.toString());

			return customerDAO.getCustomerByAutoCompleteText(query.toString(), params, customerType);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.011"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "execGetCustomersByAutoCompleteText"));
		}
	}

	/**
	 * Method that arms the query to execute in the method
	 * getCustomerByParameters.
	 * 
	 * @param columns
	 *            It's the string with de columns for the query.
	 * @param tables
	 *            It's the string with the tables for the query
	 * @param criteria
	 *            It's the string with the criteria's search for the query
	 * @param orderBy
	 *            It's the string with the criteria's for the order by of the
	 *            query
	 * @param customerType
	 *            It's string to especify the customer Type
	 * @return a list of CustomerDTO that meets the query conditions.
	 */
	private TableDTO execCheckColumnExist(String columns, String tables, String criteria, List<Object> params, String orderBy) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "execCheckColumnExist"));
			StringBuffer query = new StringBuffer();
			query.append(columns);
			query.append(tables);
			query.append(criteria);
			query.append(orderBy);

			logger.logError("QUERY execCheckColumnExist--> " + query.toString());

			return customerDAO.getCheckColumnExist(query.toString(), params);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.011"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "execGetCustomersByAutoCompleteText"));
		}
	}

	public CustomerDAO getCustomerDAO() {
		return customerDAO;
	}

	public void setCustomerDAO(CustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}

	public CatalogDAO getCatalogDAO() {
		return catalogDAO;
	}

	public GeneralParameterDAO getGeneralParameterDAO() {
		return generalParameterDAO;
	}

	public void setGeneralParameterDAO(GeneralParameterDAO generalParameterDAO) {
		this.generalParameterDAO = generalParameterDAO;
	}

	public void setCatalogDAO(CatalogDAO catalogDAO) {
		this.catalogDAO = catalogDAO;
	}

	@Override
	public List<EconomicGroupDTO> getGroupsByParameters(SearchGroupDTO searchGroup) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getGroupsByParameters"));
			logger.logDebug("searchCustomer.getIsClient()" + searchGroup.getIsClient());
			logger.logDebug("-->MODE--> " + searchGroup.getSearchMode());
			logger.logDebug("-->TYPE--> " + searchGroup.getType());
			logger.logDebug("-->OperationValue--> " + searchGroup.getOperationValue());
			logger.logDebug("-->SearchValue--> " + searchGroup.getSearchValue());
			logger.logDebug("-->GroupName--> " + searchGroup.getGroupName());
			logger.logDebug("-->GroupCode--> " + searchGroup.getGroupCode());
			logger.logDebug("-->CustomerCode--> " + searchGroup.getCustomerCode());
			logger.logDebug("-->LastCode--> " + searchGroup.getLastCode());
		}
		try {
			if (searchGroup.getIsClient().equals('S')) {
				if (searchGroup.getType() == 1) {
					if (searchGroup.getGroupCode() > 0) {
						return customerDAO.getGroupByCode(searchGroup.getGroupCode(), searchGroup.getGroupType());
					}
				} else if (searchGroup.getType() == 2) {
					String groupName = searchGroup.getGroupName();
					int size = searchGroup.getSize() == 0 ? 10 : searchGroup.getSize();
					if (groupName != null && !groupName.contains("%")) {
						// Se agrega un % en los espacios en blanco
						String[] wGroupName = groupName.split(" ");
						StringBuffer wCriteriaName = new StringBuffer();

						for (String wcn : wGroupName) {
							wCriteriaName.append("%");
							wCriteriaName.append(wcn);
						}

						if (wCriteriaName.length() > 0) {
							wCriteriaName.append("%");
						}
						groupName = wCriteriaName.toString();
						if (logger.isDebugEnabled()) {
							logger.logDebug("Group Name: " + groupName);
						}

					}
					if ("".equals(searchGroup.getLastCode())) {
						return customerDAO.getGroupByName(size, groupName, searchGroup.getGroupType());
					} else {
						String lastValue = searchGroup.getLastCode();
						return customerDAO.getNextGroupByName(size, groupName, lastValue, searchGroup.getGroupType());
					}
				}
			}
			return null;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.005", searchGroup), ex);
			throw new BusinessException(7300063, "An error occurred at obtaining Economic Group information");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getGroupsByParameters"));
		}

	}

}
