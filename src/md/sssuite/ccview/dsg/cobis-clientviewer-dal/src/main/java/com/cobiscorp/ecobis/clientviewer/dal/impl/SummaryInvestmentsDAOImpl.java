package com.cobiscorp.ecobis.clientviewer.dal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO;

public class SummaryInvestmentsDAOImpl implements SummaryInvestmentsDAO {
	private static ILogger logger = LogFactory.getLogger(SummaryInvestmentsDAOImpl.class);

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

	public SummaryInvestmentsDAOImpl() {

	}

	private String getRolOperation(String code) {
		try {
			String value = null;
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getRolOperation"));

			if (rolOperation == null) {
				String query = "select c.codigo, c.valor from cobis..cl_tabla t, cobis..cl_catalogo c where t.codigo = c.tabla and t.tabla = 'cl_rol'";
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

	/* CONSOLIDATED POSITION */
	// 5. Pasivas - PFI
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO#
	 * getSummaryFixedTerms
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryFixedTerms(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.001", "getSummaryFixedTerms"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryInvestments.getSummaryFixedTerms", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYINVESTMENTSDAO.003"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Plazos Fijo.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.002", "getSummaryFixedTerms"));
		}
	}

	// 6. Pasivas - Cuentas (Ahorros-Corrientes)
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO#
	 * getSummaryAccounts
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<ConsolidatePositionDTO> getSummaryAccounts(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.001", "getSummaryAccounts"));
			return Utils.toConsolidatePositionDTO(em.createNamedQuery("SummaryInvestments.getSummayAccounts", Object[].class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYINVESTMENTSDAO.004"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Cuentas.");

			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.002", "getSummaryAccounts"));
		}
	}

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 1. Pasivas - Cuentas Corrientes
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO#
	 * getAllCurrentsAccount
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryInvestmentsDTO> getAllCurrentsAccount(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.001", "getAllCurrentsAccount"));

			return replaceRoleInDTO(em.createNamedQuery("SummaryInvestments.getAllCurrentsAccount", SummaryInvestmentsDTO.class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYINVESTMENTSDAO.005"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Cuentas Corrientes." +
			// ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.002", "getAllCurrentsAccount"));
		}
	}

	// 2. Pasivas - Cuentas de Ahorro
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO#
	 * getAllSavingsAccount
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryInvestmentsDTO> getAllSavingsAccount(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.001", "getAllSavingsAccount"));

			return replaceRoleInDTO(em.createNamedQuery("SummaryInvestments.getAllSavingsAccount", SummaryInvestmentsDTO.class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYINVESTMENTSDAO.006"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Cuentas de Ahorro.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.002", "getAllSavingsAccount"));
		}
	}

	// 3. Pasivas - Plazo Fijo
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO#getAllFixedTerms
	 * (com.cobiscorp.ecobis.clientviewer.dal.entities.SummaryId)
	 */
	public List<SummaryInvestmentsDTO> getAllFixedTerms(SummaryIdDTO key) {
		try {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.001", "getAllFixedTerms"));

			return replaceRoleInDTO(em.createNamedQuery("SummaryInvestments.getAllFixedTerms", SummaryInvestmentsDTO.class).setParameter("customer", key.getCustomer())
					.setParameter("user", key.getUser()).setParameter("sequence", key.getSequence()).getResultList());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYINVESTMENTSDAO.007"), ex);
			// throw new BusinessException(7300001,
			// "Ocurrió un error al obtener la lista de Plazos Fijo.");
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");

		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYINVESTMENTSDAO.002", "getAllFixedTerms"));
		}
	}

	private List<SummaryInvestmentsDTO> replaceRoleInDTO(List<SummaryInvestmentsDTO> dto) {
		try {

			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "replaceRoleInDTO"));
			for (SummaryInvestmentsDTO summaryInvestmentsDTO : dto) {
				if (summaryInvestmentsDTO.getRol() != null) {
					summaryInvestmentsDTO.setRol(getRolOperation(summaryInvestmentsDTO.getRol()));
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
