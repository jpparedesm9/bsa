package com.cobiscorp.ecobis.clientviewer.admin.bl.impl;

import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager;
import com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;

/**
 * Implements the methods of AdministratorManager interface , allows access to
 * DAL layer for consolidated view administrator
 * 
 * @author dcumbal
 */
public class AdministratorManagerImpl implements AdministratorManager {
	/** Logger Administrator */
	private static ILogger logger = LogFactory.getLogger(AdministratorManagerImpl.class);

	/** Administrator data access object */
	private AdministratorDAO administratorDAO;

	public AdministratorDAO getAdministratorDAO() {
		return administratorDAO;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * getAllProductAdministratorDefault
	 */
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefault() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllProductAdministratorDefault"));
			return administratorDAO.getAllProductAdministratorDefault();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllProductAdministratorDefault"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllProductAdministratorDefault"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * getProductAdministratorByRole
	 */
	public List<ProductAdministratorDTO> getProductAdministratorByRole(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getProductAdministratorByRole"));
			return administratorDAO.getProductAdministratorByRole(roleCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getProductAdministratorByRole"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getProductAdministratorByRole"));
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * getAllRolesProductAdministrator
	 */
	public List<ProductAdministratorDTO> getAllRolesProductAdministrator() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllRolesProductAdministrator"));
			return administratorDAO.getAllRolesProductAdministrator();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllRolesProductAdministrator"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllRolesProductAdministrator"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * deleteProductAdministrator
	 */
	public void deleteProductAdministrator(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteProductAdministrator"));
			administratorDAO.deleteProductAdministrator(roleCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteProductAdministrator"), ex);
			throw new BusinessException(7300045, "Ocurrió un error al eliminar la sección dinámica de Productos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteProductAdministrator"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * updateProductAdministrator
	 */
	public void updateProductAdministrator(ProductAdministratorDTO objProductAdministrator) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "updateProductAdministrator"));
			administratorDAO.updateProductAdministrator(objProductAdministrator);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "updateProductAdministrator"), ex);
			throw new BusinessException(7300046, "Ocurrió un error al actualizar la sección dinámica de Productos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "updateProductAdministrator"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager#
	 * insertProductAdministrator
	 */
	public void insertProductAdministrator(Integer idRole, String nameRole) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertProductAdministrator"));
			administratorDAO.insertProductAdministador(idRole, nameRole);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertProductAdministrator"), ex);
			throw new BusinessException(7300047, "Ocurrió un error al insertar la sección dinámica de Productos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertProductAdministrator"));
		}

	}

	public Map<Integer, List<PropertiesDTO>> getServicesProductAdministrator() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getServicesProductAdministrator"));

			return administratorDAO.getServicesProductAdministrator();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getServicesProductAdministrator"), ex);
			throw new BusinessException(7300048, "Ocurrió un error al obtener las propiedades dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getServicesProductAdministrator"));
		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamic() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllProductAdministratorDefaultDinamic"));

			return administratorDAO.getAllProductAdministratorDefaultDinamic();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllProductAdministratorDefaultDinamic"), ex);
			throw new BusinessException(7300049, "Ocurrió un error al obtener las secciones dinámicas de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllProductAdministratorDefaultDinamic"));
		}
	}

	public List<ManagementContentSectionDTO> getAllManagementContentSection() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllManagementContentSection"));
			return administratorDAO.getAllManagementContentSection();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllManagementContentSection"), ex);
			throw new BusinessException(7300049, "Ocurrió un error al obtener las secciones dinámicas de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllProductAdministratorDefaultDinamic"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getAllManagementContentSectionRole() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllManagementContentSectionRole"));
			return administratorDAO.getAllManagementContentSectionRole();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllManagementContentSectionRole"), ex);
			throw new BusinessException(7300049, "Ocurrió un error al obtener las secciones dinámicas de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllManagementContentSectionRole"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleByRole(Integer roleCode) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getManagementContentSectionRoleByRole"));
			return administratorDAO.getManagementContentSectionRoleByRole(roleCode);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getManagementContentSectionRoleByRole"), ex);
			throw new BusinessException(7300049, "Ocurrió un error al obtener las secciones dinámicas de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getManagementContentSectionRoleByRole"));
		}
	}

	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleBySection(Integer manConSec) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getManagementContentSectionRoleBySection"));
			return administratorDAO.getManagementContentSectionRoleBySection(manConSec);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getManagementContentSectionRoleBySection"), ex);
			throw new BusinessException(7300049, "Ocurrió un error al obtener las secciones dinámicas de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getManagementContentSectionRoleBySection"));
		}
	}

	@Override
	public Integer deleteManagementContentSectionById(Integer code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteManagementContentSectionById"));
			return administratorDAO.deleteManagementContentSectionById(code);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteManagementContentSectionById"), ex);
			throw new BusinessException(7300050, "Ocurrió un error al eliminar la sección dinámica de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteManagementContentSectionById"));
		}
	}

	@Override
	public Integer deleteManagementContentSectionRole(Integer code, Integer section) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteManagementContentSectionRole"));
			return administratorDAO.deleteManagementContentSectionRole(code, section);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteManagementContentSectionRole"), ex);
			throw new BusinessException(7300050, "Ocurrió un error al eliminar la sección dinámica de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteManagementContentSectionRole"));
		}
	}

	@Override
	public Integer deleteManagementContentSectionRoleBySection(Integer code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteManagementContentSectionRoleBySection"));
			return administratorDAO.deleteManagementContentSectionRoleBySection(code);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteManagementContentSectionRoleBySection"), ex);
			throw new BusinessException(7300050, "Ocurrió un error al eliminar la sección dinámica de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteManagementContentSectionRoleBySection"));
		}
	}

	@Override
	public Integer updateManagementContentSectionById(ManagementContentSectionDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "updateManagementContentSectionById"));
			return administratorDAO.updateManagementContentSectionById(entity);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "updateManagementContentSectionById"), ex);
			throw new BusinessException(7300051, "Ocurrió un error al actualizar la sección dinámica de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "updateManagementContentSectionById"));

		}
	}

	@Override
	public Integer insertManagementContentSectionRole(ManagementContentSectionRoleDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertManagementContentSectionRole"));
			return administratorDAO.insertManagementContentSectionRole(entity);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertManagementContentSectionRole"), ex);
			throw new BusinessException(7300052, "Ocurrió un error al insertar la sección dinámica de Otra Información de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertManagementContentSectionRole"));

		}
	}

	@Override
	public Integer insertManagementContentSection(ManagementContentSectionDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertManagementContentSection"));
			return administratorDAO.insertManagementContentSection(entity);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertManagementContentSection"), ex);
			throw new BusinessException(708151, ex.getMessage());
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertManagementContentSection"));

		}
	}

	@Override
	public Double deleteDefaultProductAdministratorById(Double code) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteDefaultProductAdministratorById"));
			return administratorDAO.deleteDefaultProductAdministratorById(code);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteDefaultProductAdministratorById"), ex);
			throw new BusinessException(7300026, ex.getMessage());
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteDefaultProductAdministratorById"));
		}
	}

	@Override
	public Double updateDefaultProductAdministratorById(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "updateDefaultProductAdministratorById"));
			return administratorDAO.updateDefaultProductAdministratorById(entity);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "updateDefaultProductAdministratorById"), ex);
			throw new BusinessException(7300046, "Ocurrió un error al actualizar la sección dinámica de Productos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "updateDefaultProductAdministratorById"));

		}
	}

	@Override
	public Double insertDefaultProductAdministrator(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertDefaultProductAdministrator"));
			return administratorDAO.insertDefaultProductAdministrator(entity);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertDefaultProductAdministrator"), ex);
			throw new BusinessException(7300047, "Ocurrió un error al insertar la sección dinámica de Productos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertDefaultProductAdministrator"));

		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamicByType(String typeClient, String typeClientParent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllProductAdministratorDefaultDinamicByType"));
			return administratorDAO.getAllProductAdministratorDefaultDinamicByType(typeClient, typeClientParent);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllProductAdministratorDefaultDinamicByType"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllProductAdministratorDefaultDinamicByType"));
		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getProductAdministratorDefaultDinamicByParent(Double parent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getProductAdministratorDefaultDinamicByParent"));
			return administratorDAO.getProductAdministratorDefaultDinamicByParent(parent);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getProductAdministratorDefaultDinamicByParent"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getProductAdministratorDefaultDinamicByParent"));
		}
	}

	@Override
	public List<DtosDTO> getAllDtosByParent(Integer parent) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllDtosByParent"));
			return administratorDAO.getAllDtosByParent(parent);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllDtosByParent"), ex);
			throw new BusinessException(7300054, "Ocurrió un error obtener los DTOs");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllDtosByParent"));
		}
	}

	@Override
	public DefaultProductAdministratorDTO getProductAdministratorDefaultByIdProduct(Double idProduct) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getProductAdministratorDefaultByIdProduct"));
			return administratorDAO.getProductAdministratorDefaultByIdProduct(idProduct);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getProductAdministratorDefaultByIdProduct"), ex);
			throw new BusinessException(7300044, "Ocurrió un error al obtener las secciones dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getProductAdministratorDefaultByIdProduct"));
		}
	}

	@Override
	public DtosDTO getDtoSectionById(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getDtoSectionById"));
			return administratorDAO.getDtoSectionById(idDto);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getDtoSectionById"), ex);
			throw new BusinessException(7300055, "Ocurrió un error obtener el DTO dinámico de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getDtoSectionById"));
		}
	}

	@Override
	public Integer insertDtoSection(DtosDTO dtosDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertDtoSection"));
			return administratorDAO.insertDtoSection(dtosDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertDtoSection"), ex);
			throw new BusinessException(7300056, "Ocurrió un error al insertar el DTO dinámico de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertDtoSection"));
		}
	}

	@Override
	public Integer updateDtoSection(DtosDTO dtosDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "updateDtoSection"));
			return administratorDAO.updateDtoSection(dtosDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "updateDtoSection"), ex);
			throw new BusinessException(7300057, "Ocurrió un error al actualizar el DTO dinámico de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "updateDtoSection"));
		}
	}

	@Override
	public Integer deleteDtoSection(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deleteDtoSection"));
			return administratorDAO.deleteDtoSection(idDto);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteDtoSection"), ex);
			throw new BusinessException(7300058, "Ocurrió un error al eliminar el DTO dinámico de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deleteDtoSection"));
		}
	}

	@Override
	public List<PropertiesDTO> getPropertiesByDto(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getPropertiesByDto"));
			return administratorDAO.getPropertiesByDto(idDto);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getPropertiesByDto"), ex);
			throw new BusinessException(7300059, "Ocurrió un error al obtener las propiedades dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getPropertiesByDto"));
		}
	}

	@Override
	public PropertiesDTO getPropertiesById(Integer propertieId) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getPropertiesById"));
			return administratorDAO.getPropertiesById(propertieId);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getPropertiesById"), ex);
			throw new BusinessException(7300059, "Ocurrió un error al obtener las propiedades dinámicas de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getPropertiesById"));
		}
	}

	@Override
	public Integer insertPropertiesSection(PropertiesDTO propertiesDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "insertPropertiesSection"));
			return administratorDAO.insertPropertiesSection(propertiesDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "insertPropertiesSection"), ex);
			throw new BusinessException(7300060, "Ocurrió un error al insertar la propiedad dinámica de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "insertPropertiesSection"));
		}
	}

	@Override
	public Integer updatePropertiesSection(PropertiesDTO propertiesDTO) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "updatePropertiesSection"));
			return administratorDAO.updatePropertiesSection(propertiesDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "updatePropertiesSection"), ex);
			throw new BusinessException(7300061, "Ocurrió un error al actualizar las propiedad dinámica de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "updatePropertiesSection"));
		}
	}

	@Override
	public Integer deletePropertiesSection(Integer propertieId) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "deletePropertiesSection"));
			return administratorDAO.deletePropertiesSection(propertieId);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deletePropertiesSection"), ex);
			throw new BusinessException(7300062, "Ocurrió un error al eliminar las propiedad dinámica de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "deletePropertiesSection"));
		}
	}

	@Override
	public List<DtosDTO> getAllDtos() {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getAllDtos"));
			return administratorDAO.getAllDtos();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "getAllDtos"), ex);
			throw new BusinessException(7300054, "Ocurrió un error obtener los DTOs dinámicos de la Vista Consolidada");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getAllDtos"));
		}
	}

}
