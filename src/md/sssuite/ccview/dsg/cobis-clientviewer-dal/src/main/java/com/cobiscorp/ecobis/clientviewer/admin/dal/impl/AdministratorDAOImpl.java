package com.cobiscorp.ecobis.clientviewer.admin.dal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.DefaultProductAdministrator;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.Dtos;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ManagementContentSection;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ManagementContentSectionRole;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ProductAdministrator;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ProductAdministratorId;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.Properties;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.cobis.commons.model.Seqno;
import com.cobiscorp.ecobis.cobis.commons.services.ISeqnosQuery;

/**
 * Class created to implement the methods the AdministratorDAO interface,
 * allowing access to administrator database of consolidated view
 * 
 * @author dcumbal
 */
public class AdministratorDAOImpl implements AdministratorDAO {
	/** Logger Administrator */
	private static ILogger logger = LogFactory.getLogger(AdministratorDAOImpl.class);

	/** Persistence context */
	private EntityManager em;

	/** seqnos query */
	private ISeqnosQuery seqnosQuery;

	@PersistenceContext(unitName = "JpaClientViewerServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	public AdministratorDAOImpl() {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * getAllProductAdministratorDefault
	 */
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefault() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllProductAdministratorDefault"));
			return em.createNamedQuery("DefaultProductAdministrator.getAllProductAdministratorDefault", DefaultProductAdministratorDTO.class).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllProductAdministratorDefault"));
		}
	}

	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamic() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllProductAdministratorDefaultDinamic"));
			List<DefaultProductAdministratorDTO> defaultAdminDTO = new ArrayList<DefaultProductAdministratorDTO>();

			List<DefaultProductAdministrator> defaultAdministratorList = em.createNamedQuery("DefaultProductAdministrator.getAllProductAdministratorDefaultDinamic",
					DefaultProductAdministrator.class).getResultList();
			defaultAdminDTO = SetDTO(defaultAdministratorList);
			return defaultAdminDTO;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllProductAdministratorDefaultDinamic"));
		}
	}

	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamicByType(String typeClient, String typeClientParent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllProductAdministratorDefaultDinamicByType"));
			if (typeClient != null && !typeClient.trim().isEmpty()) {

				logger.logDebug("EntrotypeClient------------------------------------------------------------>1" + typeClient);
				logger.logDebug("EntrotypeClientParent------------------------------------------------------>1" + typeClientParent);
				return em.createNamedQuery("DefaultProductAdministrator.getAllProductAdministratorDefaultDinamicByType", DefaultProductAdministratorDTO.class)
						.setParameter("typeClient", typeClient).setParameter("typeClientParent", typeClientParent).setParameter("parent", -1).getResultList();
			} else {
				logger.logDebug("EntrotypeClient------------------------------------------------------------>2" + typeClient);
				logger.logDebug("EntrotypeClientParent------------------------------------------------------>2" + typeClientParent);
				return em.createNamedQuery("DefaultProductAdministrator.getAllProductAdministratorDefaultDinamicByNullType", DefaultProductAdministratorDTO.class)
						.setParameter("typeClientParent", typeClientParent).setParameter("parent", -1).getResultList();
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllProductAdministratorDefaultDinamicByType"));
		}
	}

	private List<DefaultProductAdministratorDTO> SetDTO(List<DefaultProductAdministrator> entities) {
		ArrayList<DefaultProductAdministratorDTO> returnList = new ArrayList<DefaultProductAdministratorDTO>();

		for (int i = 0; i < entities.size() - 1; i++) {
			for (int j = 0; j < entities.size() - 1; j++) {

				if (entities.get(j).getOrder() != null && entities.get(j + 1).getOrder() != null && entities.get(j + 1).getOrder() < entities.get(j).getOrder()) {
					DefaultProductAdministrator defaultProductAdministratorTmp = entities.get(j);
					entities.set(j, entities.get(j + 1));
					entities.set(j + 1, defaultProductAdministratorTmp);
				}
			}
		}

		for (DefaultProductAdministrator defaultProductAdministrator : entities) {
			logger.logDebug("defaultProductAdministrator ----->" + defaultProductAdministrator.getMnemonic() + "-" + defaultProductAdministrator.getDescription() + "-"
					+ defaultProductAdministrator.getOrder());

			DtosDTO dtosProduct = new DtosDTO();
			PropertiesDTO properties = new PropertiesDTO();
			List<PropertiesDTO> propertiesList = new ArrayList<PropertiesDTO>();
			if (defaultProductAdministrator.getDtosProductManager() != null) {
				List<Properties> propertiesEnt = defaultProductAdministrator.getDtosProductManager().getProperties();
				if (propertiesEnt != null && propertiesEnt.size() > 0) {
					logger.logDebug("propertiesEnt--->" + propertiesEnt.size());
					for (Properties propert : propertiesEnt) {
						logger.logDebug("propert.getName()--->" + propert.getName());
						properties = new PropertiesDTO(propert.getPropertieId(), propert.getName(), propert.getText(), propert.getGrouping(), propert.getVisibleSumaryDetail(),
								propert.getVisibleSumaryGroup(), propert.getFilterInProcess(), propert.getPrimaryKey(), propert.getWidth(), propert.getFormat(),
								propert.getDetailSection(), propert.getType(), propert.getOrder(), propert.getStyle());
						propertiesList.add(properties);
						logger.logDebug("propertiesList--->" + propertiesList.toString());
					}
				}
				dtosProduct = new DtosDTO(defaultProductAdministrator.getDtosProductManager().getDtoId(), defaultProductAdministrator.getDtosProductManager().getDtoName(),
						defaultProductAdministrator.getDtosProductManager().getDtoText(), defaultProductAdministrator.getDtosProductManager().getDtoDescription(), propertiesList,
						defaultProductAdministrator.getDtosProductManager().getServiceId(), defaultProductAdministrator.getDtosProductManager().getMnemonic(),
						defaultProductAdministrator.getDtosProductManager().getIsList(), defaultProductAdministrator.getDtosProductManager().getOrder());
				// Asignación de hijos en de la tabla vcc_dtos
				dtosProduct.setDtoList(setParentDTO(defaultProductAdministrator.getDtosProductManager(), defaultProductAdministrator.getDtosProductManager().getDtosSons()));
			}

			DefaultProductAdministratorDTO defaultAdmin = new DefaultProductAdministratorDTO(defaultProductAdministrator.getIdProduct(), defaultProductAdministrator.getIdDtoFk(),
					defaultProductAdministrator.getMnemonic(), defaultProductAdministrator.getName(), defaultProductAdministrator.getDescription(),
					defaultProductAdministrator.getParent(), dtosProduct, defaultProductAdministrator.getTypeClient(), defaultProductAdministrator.getOrder());

			if (defaultProductAdministrator.getConditionDefaultProductSons() != null && defaultProductAdministrator.getConditionDefaultProductSons().size() > 0) {
				defaultAdmin.setConditionDefaultProductSons(SetDTO(defaultProductAdministrator.getConditionDefaultProductSons()));
			}
			// defaultAdminDTO.add(defaultAdmin);
			returnList.add(defaultAdmin);
		}

		return returnList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * getProductAdministratorByRole
	 */
	public List<ProductAdministratorDTO> getProductAdministratorByRole(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getProductAdministratorByRole"));
			return em.createNamedQuery("ProductAdministrator.getProductAdministratorByRole", ProductAdministratorDTO.class).setParameter("rolCode", roleCode).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.004"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getProductAdministratorByRole"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * getAllRolesProductAdministrator
	 */
	public List<ProductAdministratorDTO> getAllRolesProductAdministrator() {

		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllRolesProductAdministrator"));
			List<ProductAdministratorDTO> listProductAdministratorDTO = new ArrayList<ProductAdministratorDTO>();

			List<Object[]> listProductAdministrator = em.createNamedQuery("ProductAdministrator.getAllRolesProductAdministrator", Object[].class).getResultList();

			for (Object[] productAdministrator : listProductAdministrator) {

				ProductAdministratorDTO objProductAdministratorDTO = new ProductAdministratorDTO(Integer.parseInt(productAdministrator[0].toString()),
						productAdministrator[1].toString());
				listProductAdministratorDTO.add(objProductAdministratorDTO);

			}

			return listProductAdministratorDTO;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.005") + ex.getMessage(), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllRolesProductAdministrator"));
		}
	}

	/**
	 * Method deleteProductAdministrator, remove all registers of configuration
	 * consolidated view that are sent in the object ProductAdministratorDTO
	 * list
	 * 
	 * @param listProductAdministrator
	 *            = List ProductAdministratorDTO
	 * @author dcumbal
	 */
	private void deleteProductAdministrator(List<ProductAdministratorDTO> listProductAdministrator) {

		Iterator<ProductAdministratorDTO> itr = listProductAdministrator.iterator();

		while (itr.hasNext()) {
			ProductAdministratorDTO objProductAdministrator = itr.next();
			ProductAdministratorId objKey = new ProductAdministratorId();

			if (objProductAdministrator != null) {
				objKey.setIdProduct(objProductAdministrator.getIdProduct());
				objKey.setIdRole(objProductAdministrator.getIdRole());
				ProductAdministrator existItem = em.find(ProductAdministrator.class, objKey);
				if (existItem != null) {
					em.remove(existItem);
					em.flush();
				}
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * deleteProductAdministrator
	 */
	public void deleteProductAdministrator(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteProductAdministador"));

			List<ProductAdministratorDTO> listProductAdministrator = this.getProductAdministratorByRole(roleCode);

			deleteProductAdministrator(listProductAdministrator);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.007"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteProductAdministador"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * updateProductAdministrator
	 */
	public void updateProductAdministrator(ProductAdministratorDTO objProductManager) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "updateProductAdministrator"));

			ProductAdministratorId objKey = new ProductAdministratorId();
			objKey.setIdProduct(objProductManager.getIdProduct());
			objKey.setIdRole(objProductManager.getIdRole());
			ProductAdministrator existItem = em.find(ProductAdministrator.class, objKey);
			if (existItem != null) {
				existItem.setEncrypted(objProductManager.getEncrypted());
				existItem.setVisible(objProductManager.getVisible());
				em.flush();
			} else {
				throw new BusinessException(7300026, "Operation failure. Contact Administrator");
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.006"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updateProductAdministrator"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO#
	 * insertProductAdministador
	 */
	public void insertProductAdministador(Integer idRole, String nameRole) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "insertProductAdministador"));
			Byte visible = 1;
			Byte encrypted = 0;

			List<DefaultProductAdministratorDTO> listProductAdministratorDefault = getAllProductAdministratorDefault();

			if (listProductAdministratorDefault != null) {
				Iterator<DefaultProductAdministratorDTO> itr = listProductAdministratorDefault.iterator();
				while (itr.hasNext()) {

					DefaultProductAdministratorDTO objDefaultProductAdministrator = itr.next();

					if (objDefaultProductAdministrator != null) {

						ProductAdministratorId objKey = new ProductAdministratorId();
						objKey.setIdProduct(objDefaultProductAdministrator.getIdProduct());
						objKey.setIdRole(idRole);
						ProductAdministrator existItem = em.find(ProductAdministrator.class, objKey);
						if (existItem == null) {

							ProductAdministrator newtItem = new ProductAdministrator();
							newtItem.setIdProduct(objDefaultProductAdministrator.getIdProduct());
							newtItem.setIdRole(idRole);
							newtItem.setIdProduct(objDefaultProductAdministrator.getIdProduct());
							newtItem.setVisible(visible);
							newtItem.setEncrypted(encrypted);
							newtItem.setRoleName(nameRole);
							em.persist(newtItem);
							em.flush();

						} else {
							throw new BusinessException(7300026, "Operation failure. Contact Administrator" + objDefaultProductAdministrator.getIdProduct().toString() + " Rol: "
									+ idRole.toString());
						}
					}
				}
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.008"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "insertProductAdministador"));
		}
	}

	@Override
	public Map<Integer, List<PropertiesDTO>> getServicesProductAdministrator() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getServicesProductAdministrator"));
			Map<Integer, List<PropertiesDTO>> dtosProperties = new HashMap<Integer, List<PropertiesDTO>>();
			logger.logDebug("--------->Ingresa a ver el query");
			List<Properties> servicesList = em.createNamedQuery("Properties.getPropertiesByDtoId", Properties.class).getResultList();

			for (Properties wProperty : servicesList) {
				List<PropertiesDTO> propertiesList = dtosProperties.get(wProperty.getDtoId());
				if (propertiesList == null) {
					propertiesList = new ArrayList<PropertiesDTO>();
					logger.logDebug("--------->" + propertiesList.size());
					dtosProperties.put(wProperty.getDtoId(), propertiesList);
				}
				PropertiesDTO propertiesDto = new PropertiesDTO(wProperty.getPropertieId(), wProperty.getName(), wProperty.getText(), wProperty.getGrouping(),
						wProperty.getVisibleSumaryDetail(), wProperty.getVisibleSumaryGroup(), wProperty.getFilterInProcess(), wProperty.getPrimaryKey(), wProperty.getWidth(),
						wProperty.getFormat(), wProperty.getDetailSection(), wProperty.getType(), wProperty.getOrder(), wProperty.getStyle());
				propertiesList.add(propertiesDto);

				logger.logDebug("propertiesDto--------->" + propertiesDto.toString());
				logger.logDebug("propertiesList--------->" + propertiesList.size());

			}
			logger.logDebug("Map--------->" + dtosProperties.toString());
			return dtosProperties;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.008"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getServicesProductAdministrator"));
		}
	}

	@Override
	public List<DtosDTO> getAllDtos() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllDtos"));
			List<DtosDTO> dtosList = em.createNamedQuery("Dtos.getAllDtos", DtosDTO.class).getResultList();
			return dtosList;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllProductAdministratorDefaultDinamic"));
		}
	}

	// Asignación de hijos en el dto
	private List<DtosDTO> setParentDTO(Dtos dtoParent, List<Dtos> dtoList) {
		ArrayList<DtosDTO> returnList = new ArrayList<DtosDTO>();
		if (dtoParent != null) {
			if (dtoList != null) {
				for (Dtos dtos : dtoList) {
					PropertiesDTO properties = new PropertiesDTO();
					List<PropertiesDTO> propertiesList = new ArrayList<PropertiesDTO>();
					logger.logDebug("dtoParent.getDtoId()" + dtoParent.getDtoId());
					logger.logDebug("dtos.getParent()" + dtos.getParent());
					if (dtos.getParent() != null && dtoParent.getDtoId().equals(dtos.getParent())) {
						logger.logDebug("dtos con hijos--->" + dtos.getParent());
						if (dtos.getProperties() != null && dtos.getProperties().size() > 0) {
							logger.logDebug("dtos.getProperties()--->" + dtos.getProperties().size());
							for (Properties propert : dtos.getProperties()) {
								logger.logDebug("propert.getName()--->" + propert.getName());
								properties = new PropertiesDTO(propert.getPropertieId(), propert.getName(), propert.getText(), propert.getGrouping(),
										propert.getVisibleSumaryDetail(), propert.getVisibleSumaryGroup(), propert.getFilterInProcess(), propert.getPrimaryKey(),
										propert.getWidth(), propert.getFormat(), propert.getDetailSection(), propert.getType(), propert.getOrder(), propert.getStyle());
								propertiesList.add(properties);

							}
						}
						DtosDTO dtosAll = new DtosDTO(dtos.getDtoId(), dtos.getDtoName(), dtos.getDtoText(), dtos.getDtoDescription(), propertiesList, dtos.getServiceId(),
								dtos.getMnemonic(), dtos.getIsList(), dtos.getOrder());
						if (dtos.getDtosSons() != null && dtos.getDtosSons().size() > 0) {
							dtosAll.setDtoList(setParentDTO(dtos, dtos.getDtosSons()));
							logger.logDebug("dtosAll..." + dtosAll.toString());
						}
						returnList.add(dtosAll);
					}

				}
				return returnList;
			} else {
				return returnList;
			}
		} else {
			return returnList;
		}
	}

	public List<ManagementContentSectionDTO> getAllManagementContentSection() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllManagementContentSection"));
			List<ManagementContentSectionDTO> lstManagementContentSection = em.createNamedQuery("ManagementContentSection.getAllManagementContentSection",
					ManagementContentSectionDTO.class).getResultList();
			return lstManagementContentSection;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllManagementContentSection"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getAllManagementContentSectionRole() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllManagementContentSection"));
			List<ManagementContentSectionRoleDTO> lstManagementContentSectionRole = em.createNamedQuery("ManagementContentSectionRole.getAllManagementContentSectionRole",
					ManagementContentSectionRoleDTO.class).getResultList();
			return lstManagementContentSectionRole;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllManagementContentSection"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleByRole(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getManagementContentSectionRoleByRole"));
			return em.createNamedQuery("ManagementContentSectionByRole.getManagementContentSectionRoleByRole", ManagementContentSectionRoleDTO.class)
					.setParameter("idRole", roleCode).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.004"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getManagementContentSectionRoleByRole"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleBySection(Integer manConSec) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getManagementContentSectionRoleBySection"));
			return em.createNamedQuery("ManagementContentSectionByRole.getManagementContentSectionRoleBySection", ManagementContentSectionRoleDTO.class)
					.setParameter("idManConSec", manConSec).getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.004"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getManagementContentSectionRoleBySection"));
		}
	}

	// delete
	public Integer deleteManagementContentSectionById(Integer code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteManagementContentSectionById"));

			em.remove(em.merge(em.find(ManagementContentSection.class, code)));

			return code;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllManagementContentSection"));
		}

	}

	@Override
	public Integer deleteManagementContentSectionRole(Integer code, Integer section) {
		try {

			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteManagementContentSectionRole"));

			ManagementContentSectionRole mcs = em.createNamedQuery("ManagementContentSectionRole.queryManagementContentSectionRole", ManagementContentSectionRole.class)
					.setParameter("idManConSec", section).setParameter("idRole", code).getSingleResult();

			em.remove(em.merge(mcs));

			return mcs.getIdManConSec();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteManagementContentSectionRole"));
		}
	}

	// /NO SE USA POR
	// AHORA////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public Integer deleteManagementContentSectionRoleBySection(Integer code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteManagementContentSectionRolBySection"));
			return em.createNamedQuery("ManagementContentSectionRole.deleteManagementContentSectionRoleBySection", Integer.class).setParameter("idManConSec", code)
					.getSingleResult();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteManagementContentSectionRolBySection"));
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// update
	public Integer updateManagementContentSectionById(ManagementContentSectionDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "updateManagementContentSectionById"));

			ManagementContentSection mc = em.find(ManagementContentSection.class, entity.getCode());
			mc.setDescription(entity.getDescription());
			mc.setName(entity.getName());
			mc.setUrlTemplate(entity.getUrlTemplate());

			em.merge(mc);

			return mc.getCode();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updateManagementContentSectionById"));
		}
	}

	// insert
	public Integer insertManagementContentSection(ManagementContentSectionDTO entity) {
		try {

			Seqno seqno = new Seqno();
			seqno.setTabla("vcc_section_management_content");
			seqno.setBdatos("cob_pac");

			ManagementContentSection mcs = new ManagementContentSection();
			mcs.setCode(seqnosQuery.querySeqnos(seqno).getSiguiente());
			mcs.setDescription(entity.getDescription());
			mcs.setName(entity.getName());
			mcs.setUrlTemplate(entity.getUrlTemplate());

			em.persist(mcs);
			em.flush();

			return mcs.getCode();

		} catch (PersistenceException ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(708151, ex.getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(708151, ex.getMessage());
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "insertManagementContentSection"));
		}

	}

	@Override
	public Integer insertManagementContentSectionRole(ManagementContentSectionRoleDTO entity) {
		try {

			ManagementContentSectionRole mcs = new ManagementContentSectionRole();
			mcs.setIdManConSec(entity.getIdManConSec());
			mcs.setIdRole(entity.getIdRole());

			em.persist(mcs);

			return mcs.getIdManConSec();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updateManagementContentSectionById"));
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Dtos> getByDefaultProductAdministrator(String mnemonic) {

		List<Dtos> resultDtos = new ArrayList<Dtos>();
		try {
			List<Integer> dtoIds = em.createNamedQuery("DefaultProductAdministrator.getByParent").setParameter("mnemonic", mnemonic).getResultList();

			for (Integer id : dtoIds) {
				logger.logDebug("Id Dto:" + id);
				try {
					Dtos dto = (Dtos) em.createNamedQuery("Dtos.getById").setParameter("dtoId", id).getSingleResult();
					resultDtos.add(dto);
					logger.logDebug("Dto" + dto.getDtoName());
				} catch (NonUniqueResultException nurex) {
					logger.logDebug("NonUniqueResultException:" + nurex);
				}
			}

			return resultDtos;
		} catch (NoResultException nrex) {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.003", nrex));
			return new ArrayList<Dtos>();
		} catch (Exception ex) {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.003", ex));
			// throw new BusinessException(7300001,
			// "No se pudo encontrar Dtos para la sección " + mnemonic);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getByDefaultProductAdministrator"));
		}
	}

	public ISeqnosQuery getSeqnosQuery() {
		return seqnosQuery;
	}

	public void setSeqnosQuery(ISeqnosQuery seqnosQuery) {
		this.seqnosQuery = seqnosQuery;
	}

	public Double insertDefaultProductAdministrator(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "insertDefaultProductAdministrator"));
			Seqno seqno = new Seqno();
			seqno.setTabla("vcc_pro_admin_default");
			seqno.setBdatos("cob_pac");
			DefaultProductAdministrator dpa = new DefaultProductAdministrator();
			dpa.setIdProduct(new Double(seqnosQuery.querySeqnos(seqno).getSiguiente()));
			dpa.setDescription(entity.getDescription());
			dpa.setName(entity.getName());
			dpa.setMnemonic(entity.getMnemonic());
			dpa.setParent(entity.getParent());
			dpa.setTypeClient(entity.getTypeClient());
			dpa.setOrder(entity.getOrder());
			dpa.setIdDtoFk(entity.getIdDtoFk());
			em.persist(dpa);
			return dpa.getIdProduct();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "insertDefaultProductAdministrator"));
		}
	}

	/**
	 * Method to delete DefaultProductAdministrator by id
	 * 
	 * @param code
	 *            = Integer
	 * @return number of deleted records
	 * @author ecarrion
	 */
	public Double deleteDefaultProductAdministratorById(Double code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteDefaultProductAdministratorById"));

			Query query = em.createNamedQuery("ProductAdministrator.getProductAdministratorByDTOid", ProductAdministratorDTO.class).setParameter("idProduct", code);

			if (query != null && query.getResultList().size() > 0) {
				throw new BusinessException(7300026, MessageManager.getString("PRODUCTADMINISTRATOR.009"));
			} else {
			em.remove(em.merge(em.find(DefaultProductAdministrator.class, code)));
			}

			return code;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, MessageManager.getString("PRODUCTADMINISTRATOR.009"));
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteDefaultProductAdministratorById"));
		}

	}

	/**
	 * Method to update DefaultProductAdministrator by id
	 * 
	 * @param entity
	 *            = DefaultProductAdministratorDTO
	 * @return number of updated record
	 * @author ecarrion
	 */
	public Double updateDefaultProductAdministratorById(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "updateDefaultProductAdministratorById"));

			DefaultProductAdministrator mc = em.find(DefaultProductAdministrator.class, entity.getIdProduct());
			mc.setDescription(entity.getDescription());
			mc.setName(entity.getName());
			mc.setMnemonic(entity.getMnemonic());
			mc.setParent(entity.getParent());
			mc.setTypeClient(entity.getTypeClient());
			mc.setOrder(entity.getOrder());
			mc.setIdDtoFk(entity.getIdDtoFk());
			em.merge(mc);
			return mc.getIdProduct();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updateDefaultProductAdministratorById"));
		}
	}

	/**
	 * Method to get DefaultProductAdministrator by parent
	 * 
	 * @return entity = DefaultProductAdministratorDTO
	 * @param number
	 *            parent
	 * @author ecarrion
	 */
	public List<DefaultProductAdministratorDTO> getProductAdministratorDefaultDinamicByParent(Double parent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getProductAdministratorDefaultDinamicByParent"));
			return em.createNamedQuery("DefaultProductAdministrator.getProductAdministratorDefaultDinamicByParent", DefaultProductAdministratorDTO.class)
					.setParameter("parent", parent).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getProductAdministratorDefaultDinamicByParent"));
		}
	}

	@Override
	public List<DtosDTO> getAllDtosByParent(Integer parent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getAllDtosByParent"));
			return em.createNamedQuery("Dtos.getAllDtosByParent", DtosDTO.class).setParameter("parent", parent).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getAllDtosByParent"));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public DefaultProductAdministratorDTO getProductAdministratorDefaultByIdProduct(Double idProduct) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getProductAdministratorDefaultByIdProduct"));

			Query query = em.createNamedQuery("DefaultProductAdministrator.getProductAdministratorDefaultByIdProduct", DefaultProductAdministratorDTO.class);
			query.setParameter("idProduct", idProduct);

			List<DefaultProductAdministratorDTO> defaultProductAdministratorDTOList = query.getResultList();
			if (defaultProductAdministratorDTOList.isEmpty()) {
				return null;
			} else {
				return defaultProductAdministratorDTOList.get(0);
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getProductAdministratorDefaultByIdProduct"));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public DtosDTO getDtoSectionById(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getDtoSectionById"));

			Query query = em.createNamedQuery("Dtos.getDtoSectionById", DtosDTO.class);
			query.setParameter("idDto", idDto);
			List<DtosDTO> dtosDTOList = query.getResultList();

			if (dtosDTOList.isEmpty()) {
				return null;
			} else {
				return dtosDTOList.get(0);
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getDtoSectionById"));
		}
	}

	@Override
	public Integer insertDtoSection(DtosDTO dtosDTO) {
		try {

			Seqno seqno = new Seqno();
			seqno.setTabla("vcc_dtos");
			seqno.setBdatos("cob_pac");

			Dtos dtos = new Dtos();
			dtos.setDtoId(seqnosQuery.querySeqnos(seqno).getSiguiente());
			dtos.setDtoName(dtosDTO.getDtoName());
			dtos.setDtoDescription(dtosDTO.getDtoDescription());
			dtos.setDtoText(dtosDTO.getDtoText());
			dtos.setParent(dtosDTO.getDtoParent());
			dtos.setServiceId(dtosDTO.getServiceId());
			dtos.setIsList(dtosDTO.getIsList());
			dtos.setMnemonic(dtosDTO.getMnemonic());
			dtos.setOrder(dtosDTO.getDtoOrder());

			em.persist(dtos);

			return dtos.getDtoId();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "DtosDTO"));
		}
	}

	@Override
	public Integer updateDtoSection(DtosDTO dtosDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "updateDtoSection"));

			Dtos dtos = em.find(Dtos.class, dtosDTO.getDtoId());

			dtos.setDtoName(dtosDTO.getDtoName());
			dtos.setDtoDescription(dtosDTO.getDtoDescription());
			dtos.setDtoText(dtosDTO.getDtoText());
			dtos.setParent(dtosDTO.getDtoParent());
			dtos.setServiceId(dtosDTO.getServiceId());
			dtos.setIsList(dtosDTO.getIsList());
			dtos.setMnemonic(dtosDTO.getMnemonic());
			dtos.setOrder(dtosDTO.getDtoOrder());

			em.merge(dtos);

			return dtos.getDtoId();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updateDtoSection"));
		}
	}

	@Override
	public Integer deleteDtoSection(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteDtoSection"));

			em.remove(em.merge(em.find(Dtos.class, idDto)));

			return idDto;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteDtoSection"));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PropertiesDTO> getPropertiesByDto(Integer idDto) {

		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getPropertiesByDto"));

			Query query = em.createNamedQuery("Properties.getPropertiesByDto", PropertiesDTO.class);
			query.setParameter("dtoId", idDto);

			return query.getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getPropertiesByDto"));
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public PropertiesDTO getPropertiesById(Integer propertieId) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "getPropertiesById"));

			Query query = em.createNamedQuery("Properties.getPropertiesById", PropertiesDTO.class);
			query.setParameter("propertieId", propertieId);
			List<PropertiesDTO> propertiesDTOList = query.getResultList();

			if (propertiesDTOList.isEmpty()) {
				return null;
			} else {
				return propertiesDTOList.get(0);
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "getPropertiesById"));
		}
	}

	@Override
	public Integer insertPropertiesSection(PropertiesDTO propertiesDTO) {
		try {

			Seqno seqno = new Seqno();
			seqno.setTabla("vcc_properties");
			seqno.setBdatos("cob_pac");

			Properties properties = new Properties();
			properties.setPropertieId(seqnosQuery.querySeqnos(seqno).getSiguiente());
			properties.setName(propertiesDTO.getName());
			properties.setText(propertiesDTO.getText());
			properties.setGrouping(propertiesDTO.getGrouping());
			properties.setVisibleSumaryDetail(propertiesDTO.getVisibleSumaryDetail());
			properties.setVisibleSumaryGroup(propertiesDTO.getVisibleSumaryGroup());
			properties.setFilterInProcess(propertiesDTO.getFilterInProcess());
			properties.setPrimaryKey(propertiesDTO.getPrimaryKey());
			properties.setWidth(propertiesDTO.getWidth());
			properties.setFormat(propertiesDTO.getFormat());
			properties.setDetailSection(propertiesDTO.getDetailSection());
			properties.setType(propertiesDTO.getType());
			properties.setDtoId(propertiesDTO.getDtoId());
			properties.setOrder(propertiesDTO.getOrder());
			properties.setStyle(propertiesDTO.getStyle());

			em.persist(properties);

			return properties.getPropertieId();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "Properties"));
		}
	}

	@Override
	public Integer updatePropertiesSection(PropertiesDTO propertiesDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "updatePropertiesSection"));

			Properties properties = em.find(Properties.class, propertiesDTO.getPropertieId());

			properties.setName(propertiesDTO.getName());
			properties.setText(propertiesDTO.getText());
			properties.setGrouping(propertiesDTO.getGrouping());
			properties.setVisibleSumaryDetail(propertiesDTO.getVisibleSumaryDetail());
			properties.setVisibleSumaryGroup(propertiesDTO.getVisibleSumaryGroup());
			properties.setFilterInProcess(propertiesDTO.getFilterInProcess());
			properties.setPrimaryKey(propertiesDTO.getPrimaryKey());
			properties.setWidth(propertiesDTO.getWidth());
			properties.setFormat(propertiesDTO.getFormat());
			properties.setDetailSection(propertiesDTO.getDetailSection());
			properties.setType(propertiesDTO.getType());
			properties.setDtoId(propertiesDTO.getDtoId());
			properties.setOrder(propertiesDTO.getOrder());
			properties.setStyle(propertiesDTO.getStyle());

			em.merge(properties);

			return properties.getPropertieId();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "updatePropertiesSection"));
		}
	}

	@Override
	public Integer deletePropertiesSection(Integer propertieId) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.001", "deleteDtoSection"));

			em.remove(em.merge(em.find(Properties.class, propertieId)));

			return propertieId;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATOR.003"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATOR.002", "deleteDtoSection"));
		}
	}

}
