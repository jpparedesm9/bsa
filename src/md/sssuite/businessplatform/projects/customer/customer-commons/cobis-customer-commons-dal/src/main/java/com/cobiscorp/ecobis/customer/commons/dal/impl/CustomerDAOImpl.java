package com.cobiscorp.ecobis.customer.commons.dal.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.commons.dal.CustomerDAO;
import com.cobiscorp.ecobis.customer.commons.dal.entities.Instance;
import com.cobiscorp.ecobis.customer.commons.dal.utils.MessageManager;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicActivityDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.OfficialDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;

public class CustomerDAOImpl implements CustomerDAO {

	private static ILogger logger = LogFactory.getLogger(CustomerDAOImpl.class);

	private EntityManager em;

	@PersistenceContext(unitName = "JpaCustomerServices")
	public void setEm(EntityManager em) {
		System.out.println(">>>>>>>>>>>>>><  Valor EM" + em);
		this.em = em;
	}

	public CustomerDAOImpl() {
		System.out.println(">>>>> CONSTRUCTOR CustomerDAOImpl");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomerType
	 */
	public CustomerDTO getCustomerType(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCustomerType"));

			List<CustomerDTO> resp = em.createNamedQuery("Customer.getCustomerType", CustomerDTO.class).setParameter("customercode", customerCode).getResultList();
			if (resp.size() > 0) {
				return resp.get(0);
			}
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.003"), ex);
			// throw new BusinessException(7300018,
			// "An error occurred at getting Customer Information");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCustomerType"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getGroupMembers
	 */
	public List<CustomerDTO> getGroupMembers(Integer groupCode) {
		List<CustomerDTO> result = new ArrayList<CustomerDTO>();
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupMembers"));
			List<CustomerDTO> customerGroups = em.createNamedQuery("CustomerGroup.getGroupMembers", CustomerDTO.class).setParameter("groupcode", groupCode).getResultList();

			List<CustomerDTO> groups = em.createNamedQuery("Group.getGroupMembers", CustomerDTO.class).setParameter("groupcode", groupCode).getResultList();
			for (CustomerDTO customerGroup : customerGroups) {
				result.add(customerGroup);
			}

			for (CustomerDTO group : groups) {
				result.add(group);
			}
			return result;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.008"), ex);
			// throw new BusinessException(7300001,
			// "There was an error getting group members");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupMembers"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getAllAddress(java.
	 * lang.Integer)
	 */
	public List<CustomerAddressDTO> getAllAddress(Integer idClient) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getAllAddress"));
			return em.createNamedQuery("CustomerAddress.getAllAddress", CustomerAddressDTO.class).setParameter("idClient", idClient).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.004"), ex);
			// throw new BusinessException(7300018,
			// "An error occurred at getting Customer Information");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getAllAddress"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getGroupValue(java.
	 * lang.String)
	 */
	public List<EconomicGroupDTO> getGroupValue(String groupName) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupValue"));

			return em.createNamedQuery("Group.getGroupValue", EconomicGroupDTO.class).setParameter("groupName", groupName).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.005", groupName), ex);
			// throw new BusinessException(7300063,
			// "An error occurred at getting the Economic Group information");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupValue"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getGroupLike(java.lang
	 * .String)
	 */
	@SuppressWarnings("unchecked")
	public List<EconomicGroupDTO> getGroupLike(String groupId) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupLike"));

			StringBuilder sql = new StringBuilder();
			sql.append("select gr_grupo, gr_nombre, gr_representante, en_nomlar, gr_oficial, substring(fu_nombre, 1, 30), gr_tipo_grupo, gr_tipo ");
			sql.append("from cl_grupo ");
			sql.append("left join cl_ente on gr_representante = en_ente ");
			sql.append("left join cc_oficial on gr_oficial = oc_oficial ");
			sql.append("left join cl_funcionario on oc_funcionario = fu_funcionario ");
			sql.append("where convert(varchar(10),gr_grupo) like ?1 ");
			sql.append("order by gr_grupo ");

			Query q = em.createNativeQuery(sql.toString(), Object[].class).setParameter(1, groupId);

			q.setMaxResults(20);

			List<Object[]> groups = q.getResultList();

			List<EconomicGroupDTO> groupList = new ArrayList<EconomicGroupDTO>();

			for (Object[] group : groups) {

				EconomicGroupDTO cus = new EconomicGroupDTO(validateDataInt(group[0]), validateData(group[1]), validateDataInt(group[2]), validateData(group[3]),
						validateDataInt(group[4]), validateData(group[5]), validateData(group[6]), validateData(group[7]));
				groupList.add(cus);

			}
			return groupList;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.006", groupId), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el grupo económico para el id seleccionado");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupLike"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getGroupDetail
	 */
	public EconomicGroupDTO getGroupDetail(Integer groupCode, String type) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupDetail"));
			Query query = null;
			if ("G".equals(type)) {
				query = em.createNamedQuery("Group.getGroupDetail", EconomicGroupDTO.class);
				query.setParameter("groupCode", groupCode);
				query.setParameter("type", type);
				return (EconomicGroupDTO) query.getSingleResult();

			} else if ("S".equals(type)) {
				query = em.createNamedQuery("Group.getSolidarityGroupDetail", EconomicGroupDTO.class);
				query.setParameter("groupCode", groupCode);
				query.setParameter("type", type);
				return (EconomicGroupDTO) query.getSingleResult();
			}
			return null;

		} catch (NonUniqueResultException nuex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.009"), nuex);
			return null;
		} catch (NoResultException nrex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.009"), nrex);
			return null;
		} catch (Exception ex) {

			logger.logError(MessageManager.getString("CUSTOMERDAO.009"), ex);
			// throw new BusinessException(7300019,
			// "An error occurred at getting Economic Group detail");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupDetail"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomerScore(java
	 * .lang.Integer)
	 */
	public List<CustomerScoreDTO> getCustomerScore(Integer customerId) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCustomerScore"));

			return em.createNamedQuery("CustomerScore.getCustomerScore", CustomerScoreDTO.class).setParameter(1, customerId).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.007", customerId), ex);
			// throw new BusinessException(7300064,
			// "An error occurred at getting Customer score");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCustomerScore"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getOfficer
	 */

	public OfficialDTO getOfficer(Integer officerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getOfficer"));
			OfficialDTO officialDTOResponse = null;

			List<OfficialDTO> officialDTO = em.createNamedQuery("Official.getOfficer", OfficialDTO.class).setParameter("officialCode", officerCode).getResultList();
			if (officialDTO.size() > 0) {
				officialDTOResponse = officialDTO.get(0);
			}

			return officialDTOResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.007", officerCode), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la informacion del official");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getOfficer"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getAllLegalClient(java
	 * .lang.Integer)
	 */
	public CustomerDTO getAllLegalClient(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getAllLegalClient"));
			return em.createNamedQuery("Customer.getAllLegalClient", CustomerDTO.class).setParameter("code", customerCode).getSingleResult();
		} catch (NoResultException nrex) {
			return new CustomerDTO();
		} catch (NonUniqueResultException nurex) {
			return new CustomerDTO();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.018"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la información legal del cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getAllLegalClient"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomer(java.lang
	 * .Integer)
	 */
	@Override
	public CustomerDTO getCustomer(Integer customerId) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCustomer"));

			return em.createNamedQuery("Customer.getCustomer", CustomerDTO.class).setParameter("code", customerId).getSingleResult();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.010", customerId), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la informacion del cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCustomer"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getDescriptionActivity(
	 * java.lang.String)
	 */
	@Override
	public String getDescriptionActivity(String activityCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getDescriptionActivity"));

			return em.createNamedQuery("Activity.findDescription", String.class).setParameter("code", activityCode).getSingleResult();

		} catch (NoResultException ex) {
			logger.logError("No se encontro información de Grupo Económico");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.011", activityCode), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la descripción de la actividad.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getDescriptionActivity"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getNameGroup(java.lang.
	 * Integer)
	 */
	@Override
	public String getNameGroup(Integer groupId) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getNameGroup"));

			return em.createNamedQuery("Group.getNameGroup", String.class).setParameter("groupId", groupId).getSingleResult();

		} catch (NoResultException ex) {
			logger.logError("No se encontro información de Grupo Económico");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.012", groupId), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el nombre del grupo.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		}

		finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getNameGroup"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.customer.dal.CustomerDAO#getOfficial(java.lang.
	 * Integer )
	 */
	@Override
	public Object[] getOfficial(Integer officialId) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getOfficial"));
			Object[] official = null;
			List<Object[]> officials = null;

			officials = em.createNamedQuery("Official.getOfficial", Object[].class).setParameter("officialId", officialId).getResultList();

			if (officials != null && officials.size() > 0) {
				official = officials.get(0);
			}
			return official;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.013", officialId), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el oficial.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getOfficial"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getNationality(java.lang
	 * .Integer)
	 */
	@Override
	public String getNationality(Integer idCountry) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getNationality"));

			return em.createNamedQuery("Country.getNationality", String.class).setParameter("idCountry", idCountry).getSingleResult();

		} catch (NoResultException ex) {
			logger.logError("No se encontro información la nacionalidad");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.014", idCountry), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la nacionalidad.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getNationality"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getDescriptionCountry(java
	 * .lang.Integer)
	 */
	@Override
	public String getDescriptionCountry(Integer idCountry) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getDescriptionCountry"));

			return em.createNamedQuery("Country.getDescription", String.class).setParameter("idCountry", idCountry).getSingleResult();

		} catch (NoResultException ex) {
			logger.logError("No se encontro información del país");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.016", idCountry), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener la descripción del país.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getDescriptionCountry"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getDocumentType(java.lang
	 * .String)
	 */
	@Override
	public String getDocumentType(String codeDocument) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getDocumentType"));

			return em.createNamedQuery("DocumentType.getDescription", String.class).setParameter("code", codeDocument).getSingleResult();

		} catch (NoResultException ex) {
			logger.logError("No se encontro información de Grupo Económico");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.015", codeDocument), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el tipo de documento.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getDocumentType"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#getDescriptionCity(java
	 * .lang.Integer)
	 */
	@Override
	public String getDescriptionCity(Integer idCity) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getDescriptionCity"));

			if (idCity != null) {
				return em.createNamedQuery("City.getCity", String.class).setParameter("idCity", idCity).getSingleResult();
			} else {
				return null;
			}

		} catch (NoResultException ex) {
			logger.logError("No se encontro información de tipo de documento");
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.017", idCity), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el tipo de documento.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getDescriptionCity"));
		}
	}

	private String validateData(Object obj) {
		return obj == null ? "" : obj.toString();

	}

	private Integer validateDataInt(Object obj) {
		return (Integer) (obj == null ? null : obj);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomerByParameters
	 * (java.lang.String, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<CustomerDTO> getCustomerByParameters(String queryWithoutParams, List<Object> params,  String type) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCustomerByParameters"));

			logger.logDebug("QUERY GVI ------------>" + queryWithoutParams);

			Query q = em.createNativeQuery(queryWithoutParams, Object[].class);
			for(int i = 1; i <= params.size(); i++){
				q.setParameter(i, params.get(i-1));
			}

			q.setMaxResults(20);

			List<Object[]> customers = q.getResultList();

			List<CustomerDTO> customerList = new ArrayList<CustomerDTO>();

			for (Object[] customer : customers) {

				CustomerDTO cus = new CustomerDTO(validateDataInt(customer[0]), validateData(customer[1]), validateData(customer[2]), validateData(customer[3]),
						validateData(customer[4]), validateData(customer[5]), validateData(customer[6]), validateData(customer[7]), validateDataInt(customer[8]),
						validateData(customer[9]), validateData(customer[10]), validateData(customer[11]), validateData(customer[12]), validateData(customer[13]), type,
						validateData(customer[14]), validateData(customer[15]), validateData(customer[16]));

				customerList.add(cus);

			}

			for (CustomerDTO customerDTO : customerList) {
				logger.logDebug("RETURN LIST-----------> " + customerDTO.toString());
			}

			return customerList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.021"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo realizar la busqueda de clientes por parámetros");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCustomerByParameters"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomerByParameters
	 * (java.lang.String, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public List<CustomerDTO> getCustomerByAutoCompleteText(String queryWithoutParams, List<Object> params, String type) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCustomerByAutoCompleteText"));

			logger.logDebug("QUERY GVI getCustomerByAutoCompleteText ------------>" + queryWithoutParams);

			Query q = em.createNativeQuery(queryWithoutParams, Object[].class);
			for(int i = 1; i <= params.size(); i++){
				q.setParameter(i, params.get(i-1));
			}

			List<Object[]> customers = q.getResultList();

			List<CustomerDTO> customerList = new ArrayList<CustomerDTO>();

			if (type.trim().equals("C")) {

				for (Object[] customer : customers) {

					CustomerDTO cus = new CustomerDTO(validateDataInt(customer[0]), validateData(customer[1]), validateData(customer[2]));

					customerList.add(cus);

				}
			}
			if (type.trim().equals("P") || type.trim().equals("GE")) {

				for (Object[] customer : customers) {

					CustomerDTO cus = new CustomerDTO(validateDataInt(customer[0]), validateData(customer[1]));

					customerList.add(cus);

				}
			}

			for (CustomerDTO customerDTO : customerList) {
				logger.logDebug("RETURN LIST getCustomerByAutoCompleteText-----------> " + customerDTO.toString());
			}

			return customerList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.021"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo realizar la busqueda de clientes por parámetros");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCustomerByAutoCompleteText"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.CustomerDAO#getCustomerByParameters
	 * (java.lang.String, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public TableDTO getCheckColumnExist(String queryWithoutParams, List<Object> params) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCheckColumnExist"));

			logger.logDebug("QUERY GVI getCheckColumnExist  ------------>" + queryWithoutParams);

			Query q = em.createNativeQuery(queryWithoutParams, Object[].class);
			for(int i = 1; i <= params.size(); i++){
				q.setParameter(i, params.get(i-1));
			}
			q.setMaxResults(20);

			List<Object[]> tableDTOs = q.getResultList();

			logger.logDebug("--> TableDTO --> " + tableDTOs.size());

			TableDTO table = null;

			for (Object[] wTable : tableDTOs) {
				logger.logDebug("wTable IN------>" + wTable[0]);
				table = new TableDTO(validateDataInt(wTable[0]));
			}

			return table;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.021"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo realizar la busqueda de clientes por parámetros");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCheckColumnExist"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#countCustomer(java.lang
	 * .Integer)
	 */
	public Long countCustomer(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "countCustomer"));

			return em.createNamedQuery("Customer.countCustomer", Long.class).setParameter("customercode", customerCode).getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo verificar si existe el cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "countCustomer"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#countEconomicGroup(java
	 * .lang.Integer)
	 */
	public Long countEconomicGroup(Integer groupCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "countEconomicGroup"));

			return em.createNamedQuery("Group.countGroup", Long.class).setParameter("groupId", groupCode).getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo verificar si existe el grupo económico");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "countEconomicGroup"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.customer.dal.CustomerDAO#
	 * getCodeGroupMembersByCustomer (java.lang.Integer)
	 */
	public List<Integer> getCodeGroupMembersByCustomer(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getCodeGroupMembersByCustomer"));

			return em.createNamedQuery("CustomerGroup.getCodeGroupMembersByCustomer", Integer.class).setParameter("customerCode", customerCode).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.019"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo extraer el codigo del grupo económico al que
			// pertenece el cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getCodeGroupMembersByCustomer"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.customer.dal.CustomerDAO#countCustomerGroup(java
	 * .lang.Integer, java.lang.Integer)
	 */
	public Long countCustomerGroup(Integer customerCode, Integer groupCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "countCustomerGroup"));

			return em.createNamedQuery("Customer.countCustomerGroup", Long.class).setParameter("customercode", customerCode).setParameter("groupcode", groupCode).getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.020"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo verificar si el cliente es parte del grupo ICE");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "countCustomerGroup"));
		}
	}

	public List<EconomicActivityDTO> getEconomicActivitiesByCustomer(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.022", "getEconomicActivitiesByCustomer"));
			return em.createNamedQuery("EconomicActivity.getEconomicActivitiesByCustomer", EconomicActivityDTO.class).setParameter("customerCode", customerCode).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.024"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el listado de actividades económicas del
			// cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.023", "getEconomicActivitiesByCustomer"));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Instance getCustomerCouple(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.022", "getCustomerCouple"));

			Query query = em.createNamedQuery("Instance.findCustomerCouple", Instance.class);
			query.setParameter("customerCode", customerCode);
			List<Instance> instanceList = query.getResultList();

			if (instanceList.isEmpty()) {
				return null;
			}

			return instanceList.get(0);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.024"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el listado de actividades económicas del
			// cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.023", "getEconomicActivitiesByCustomer"));
		}
	}

	public List<EconomicGroupDTO> getCustomerGroupsByCustomer(Integer customerCode) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.022", "getCustomerGroupsByCustomer"));
			return em.createNamedQuery("CustomerGroup.getGroupsByCustomer", EconomicGroupDTO.class).setParameter("customerCode", customerCode).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.025"), ex);
			// throw new BusinessException(7300001,
			// "No se pudo obtener el listado de grupos económicos del
			// cliente");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.023", "getCustomerGroupsByCustomer"));
		}
	}

	@Override
	public List<EconomicGroupDTO> getGroupByName(int size, String groupName, String type) {

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupByName"));
			Query query = null;
			// if ("G".equals(type)) {
			query = em.createNamedQuery("Group.getGroupByName", EconomicGroupDTO.class);
			query.setParameter("groupName", groupName);
			query.setParameter("type", type);
			query.setMaxResults(size);
			return (List<EconomicGroupDTO>) query.getResultList();
			/*
			 * }else if ("S".equals(type)) { query =
			 * em.createNamedQuery("Group.getSolidarityGroupByName",
			 * EconomicGroupDTO.class); query.setParameter("groupName",
			 * groupName); query.setParameter("type", type); return
			 * (List<EconomicGroupDTO>) query.getResultList(); } return null;
			 */
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.005", groupName), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupByName"));
		}
	}

	@Override
	public List<EconomicGroupDTO> getNextGroupByName(int size, String groupName, String lastValue, String type) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getNextGroupValue"));
			Query query = null;
			// if ("G".equals(type)) {
			query = em.createNamedQuery("Group.getNextGroupByName", EconomicGroupDTO.class);
			query.setParameter("groupName", groupName);
			query.setParameter("lastValue", lastValue);
			query.setParameter("type", type);
			query.setMaxResults(size);
			return (List<EconomicGroupDTO>) query.getResultList();
			/*
			 * } else if ("S".equals(type)) { query =
			 * em.createNamedQuery("Group.getNextSolidarityGroupByName",
			 * EconomicGroupDTO.class); query.setParameter("groupName",
			 * groupName); query.setParameter("lastValue", lastValue);
			 * query.setParameter("type", type); query.setMaxResults(size);
			 * return (List<EconomicGroupDTO>) query.getResultList(); } return
			 * null;
			 */

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.005", groupName), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getNextGroupValue"));
		}
	}

	@Override
	public List<EconomicGroupDTO> getGroupByCode(int groupCode, String type) {
		try {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.001", "getGroupByCode"));

			Query query = null;
			// if ("G".equals(type)) {
			query = em.createNamedQuery("Group.getGroupByCode", EconomicGroupDTO.class);
			query.setParameter("groupCode", groupCode);
			query.setParameter("type", type);
			return (List<EconomicGroupDTO>) query.getResultList();
			/*
			 * } else if ("S".equals(type)) { query =
			 * em.createNamedQuery("Group.getSolidarityGroupByCode",
			 * EconomicGroupDTO.class); query.setParameter("groupCode",
			 * groupCode); query.setParameter("type", type); return
			 * (List<EconomicGroupDTO>) query.getResultList(); } return null;
			 */
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERDAO.005", groupCode), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");

		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERDAO.002", "getGroupByCode"));
		}
	}

}
