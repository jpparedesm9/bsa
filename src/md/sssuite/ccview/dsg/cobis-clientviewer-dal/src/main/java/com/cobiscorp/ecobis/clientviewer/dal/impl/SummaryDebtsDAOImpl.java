package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RequestRejectedTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;


public class SummaryDebtsDAOImpl implements SummaryDebtsDAO {

	private static ILogger logger = LogFactory.getLogger(SummaryDebtsDAOImpl.class);

	private EntityManager em;
	
	
	private static List<Map<String, String>> rolOperation = null;

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param em
	 */
	@PersistenceContext(unitName = "JpaClientViewerServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	public SummaryDebtsDAOImpl() {
	}

	private String getRolOperation(String code) {
		try {
			String value = null;
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getRolOperation"));

			if (rolOperation == null) {
				String query = "select c.codigo, c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.codigo = c.tabla and t.tabla = 'cr_cat_deudor'";
				List<Object[]> resultCatalog = em.createNativeQuery(query, Object[].class).getResultList();
				rolOperation = new ArrayList<Map<String, String>>();
				for (Object[] objects : resultCatalog) {
					if (objects.length >= 2) {
						Map<String, String> data = new HashMap<String, String>();
						data.put(((String) objects[0]).trim(), ((String) objects[1]).trim());
						rolOperation.add(data);
					}
				}
			}

			if (code != null) {
				for (Map<String, String> catalog : rolOperation) {
					if (catalog.containsKey(code.trim())) {
						value = catalog.get(code.trim());
						break;
					}
				}
			}
			return value;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.099"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la descripción de los valores del Role del titular de la cuenta.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getRolOperation"));
		}
	}

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 1. Deudas Indirectas
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#
	 * getSummaryIndirectCredit
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryIndirectCredit(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummaryIndirectCredit"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryDebts.getSummaryIndirectCredit", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Créditos Indirectos.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummaryIndirectCredit"));
		}
	}

	// 2. Deudas Sobregiros
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getSummayOverdrafts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummayOverdrafts(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummayOverdrafts"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryDebts.getSummayOverdrafts", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.004"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Sobregiros.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummayOverdrafts"));
		}
	}

	// 3. Deudas Contingente
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#
	 * getSummaryCEXContingencies
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryCEXContingencies(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummaryCEXContingencies"));

			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryDebts.getSummaryCEXContingencies", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.005"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de CEX.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummaryCEXContingencies"));
		}
	}

	// 4. Deudas Cartera
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getSummaryDebts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryDebts(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummaryDebts"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryDebts.getSummaryDebts", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.006"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Deudas de Cartera.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummaryDebts"));
		}
	}
	
	// 4. Deudas Cartera
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getSummaryDebts
		 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
		 */
		

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 4. SOBREGIROS
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getAllOverdrafts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryDebtsDTO> getAllOverdrafts(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getAllOverdrafts"));
			return em.createNamedQuery("SummaryDebts.getAllOverdrafts", SummaryDebtsDTO.class).setParameter("customer", key.getCustomer()).setParameter("user", key.getUser())
					.setParameter("sequence", key.getSequence()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.007"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Sobregiros.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getAllOverdrafts"));
		}
	}

	// 7. CEX
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getAllContingencies
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryDebtsDTO> getAllContingencies(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getAllContingencies"));
			return em.createNamedQuery("SummaryDebts.getAllContingencies", SummaryDebtsDTO.class).setParameter("customer", key.getCustomer()).setParameter("user", key.getUser())
					.setParameter("sequence", key.getSequence()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.008"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Contingentes.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getAllContingencies"));
		}
	}

	// 13. CCA
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getAllDebtsLoans
	 * (java.lang.Integer, java.lang.String)
	 */
	public List<SummaryDebtsDTO> getAllDebtsLoans(Integer spid, String debtType, String user, String sesn,Integer customer) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getAllDebtsLoans"));

			logger.logDebug("getAllDebtsLoans... " + spid);
			logger.logDebug("getAllDebtsLoans... " + sesn);

			List<SummaryDebtsDTO> debtsLoans = replaceRoleInDTO(em.createNamedQuery("SummaryDebts.getAllDebtsLoans", SummaryDebtsDTO.class).setParameter("user", user)
					.setParameter("sequence", Integer.valueOf(sesn)).setParameter("customer", customer).getResultList());
			
			for(SummaryDebtsDTO summaryDebt : debtsLoans){
				logger.logDebug("summaryDebt"+summaryDebt.getNumberOperation()+","+summaryDebt.getProduct()+","+summaryDebt.getState());
			}
			return debtsLoans;

		} catch (NoResultException nrex) {
			logger.logError("getAllDebtsLoans NoResultException",nrex);
			return new ArrayList<SummaryDebtsDTO>();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.009"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Deudas de Cartera.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getAllDebtsLoans"));
		}
	}

	public List<DebtTmpDTO> getIndirects(Integer spid, String debtType) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getAllDebtsLoans"));
			return em.createNamedQuery("DebtTmp.getAllDebtsLoans", DebtTmpDTO.class).setParameter("spid", spid).setParameter("debtType", debtType).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.009"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Deudas de Cartera.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getAllDebtsLoans"));
		}
	}

	public List<RequestRejectedTmpDTO> getRequestRejected(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getRequestRejected"));
			return em.createNamedQuery("RequestRejectedTmp.getRequestRejected", RequestRejectedTmpDTO.class).setParameter("spid", spid).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.009"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Deudas de Cartera.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getRequestRejected"));
		}

	}

	public List<DebtTmpDTO> getAllInProgresRequest(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getAllInProgresRequest"));
			return replaceRoleInDebtTmpDTO(em.createNamedQuery("DebtTmp.getAllInProgresRequest", DebtTmpDTO.class).setParameter("spid", spid).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.009"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de solicitudes en curso de Cartera.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getAllInProgresRequest"));
		}
	}

	private List<DebtTmpDTO> replaceRoleInDebtTmpDTO(List<DebtTmpDTO> dto) {
		try {

			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "replaceRoleInDebtTmpDTO"));
			for (DebtTmpDTO debtTmpDTO : dto) {
				if (debtTmpDTO.getRole() != null) {
					debtTmpDTO.setRole(getRolOperation(debtTmpDTO.getRole()));
				}
			}

			return dto;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.099"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al momento de reemplazar los valores del Role del titular de la cuenta.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "replaceRoleInDebtTmpDTO"));
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#deleteAllDebtsLoans
	 * (java.lang.Integer)
	 */
	public void deleteAllDebtsLoans(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "deleteAllDebtsLoans"));
			em.createNamedQuery("DebtTmp.delete").setParameter(1, spid).executeUpdate();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.010"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error en el borrado de tablas temporales.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "deleteAllDebtsLoans"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getPledgeAmount
	 * (java.lang.String, java.lang.Integer, java.lang.String, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public Double getPledgeAmount(String user, Integer sesn, String typeGarBack, String typeGarBack2) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getPledgeAmount"));
			List<Double> list = em.createNamedQuery("SummaryDebts.getPledgeAmount").setParameter("user", user).setParameter("sesn", sesn).setParameter("typeGarBack", typeGarBack)
					.setParameter("typeGarBack2", typeGarBack2).getResultList();

			if (list.size() > 0) {
				return list.get(0);
			}
			return null;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.011"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al sumar saldo vencido con saldo por vencer.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getPledgeAmount"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#getMaxDebtAmounts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId,
	 * java.lang.Integer, java.lang.Integer)
	 */
	public List<SummaryDebtsDTO> getMaxDebtAmounts(SummaryIdDTO key, Integer groupId, Integer processId) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getMaxDebtAmounts"));
			return em.createNamedQuery("SummaryDebts.getMaxDebtAmounts", SummaryDebtsDTO.class).setParameter("customer", key.getCustomer()).setParameter("user", key.getUser())
					.setParameter("sequence", key.getSequence()).setParameter("group", groupId).setParameter("processId", processId).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.008"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrio un problema al consultar el riesgo del cliente.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getMaxDebtAmounts"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO#
	 * getPledgeAmountOperation(java.lang.String, java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public Double getPledgeAmountOperation(String user, Integer sesn) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getPledgeAmountOperation"));
			List<Double> list = em.createNamedQuery("SummaryDebts.getPledgeAmountOperation").setParameter("user", user).setParameter("sesn", sesn).getResultList();

			if (list.size() > 0) {
				return list.get(0);
			}
			return null;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.011"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al sumar el monto pagado.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getPledgeAmountOperation"));
		}
	}

	@Override
	public List<SummaryDebtsDTO> getCustomerRisk(SummaryIdDTO key) {

		try {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.001", "getPledgeAmountOperation"));
			return em.createNamedQuery("SummaryDebts.getCustomerRisk", SummaryDebtsDTO.class).setParameter("user", key.getUser()).setParameter("sesn", key.getSequence())
					.setParameter("customer", key.getCustomer()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("INDIRECTRISK.002"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al sumar el monto pagado.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.003", "getPledgeAmountOperation"));
		}
	}

	@Override
	public List<SummaryDebtsDTO> getTotalAmountDeal(SummaryIdDTO key) {

		try {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.001", "getTotalAmountDeal"));
			return em.createNamedQuery("SummaryDebts.getTotalDealRisk", SummaryDebtsDTO.class).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence())
					.setParameter("customer", key.getCustomer()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("INDIRECTRISK.002"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener monto total tramite.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.003", "getTotalAmountDeal"));
		}

	}

	@Override
	public List<SummaryDebtsDTO> getTotalDealAditional(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.001", "getTotalAmountDeal"));
			return em.createNamedQuery("SummaryDebts.getTotalDealAditional", SummaryDebtsDTO.class).setParameter("user", key.getUser()).setParameter("sequence", key.getSequence())
					.setParameter("customer", key.getCustomer()).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("INDIRECTRISK.002"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener monto total tramite.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("INDIRECTRISK.003", "getTotalAmountDeal"));
		}
	}

	private List<SummaryDebtsDTO> replaceRoleInDTO(List<SummaryDebtsDTO> dto) {
		try {

			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "replaceRoleInDTO"));
			for (SummaryDebtsDTO summaryDebtsDTO : dto) {
				if (summaryDebtsDTO.getRole() != null) {
					summaryDebtsDTO.setRole(getRolOperation(summaryDebtsDTO.getRole()));
				}
			}

			return dto;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.099"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al momento de reemplazar los valores del Role del titular de la cuenta.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "replaceRoleInDTO"));
		}

	}

}
