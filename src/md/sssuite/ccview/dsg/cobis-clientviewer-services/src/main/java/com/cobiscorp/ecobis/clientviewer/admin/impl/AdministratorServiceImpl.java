package com.cobiscorp.ecobis.clientviewer.admin.impl;

import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.admin.AdministratorService;
import com.cobiscorp.ecobis.clientviewer.admin.bl.AdministratorManager;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;

public class AdministratorServiceImpl implements AdministratorService {

	/** Administrator access to business layer */
	private AdministratorManager administratorManager;

	/** Logger Administrator */
	private static ILogger logger = LogFactory.getLogger(AdministratorServiceImpl.class);

	public AdministratorManager getAdministratorManager() {
		return administratorManager;
	}

	public void setAdministratorManager(AdministratorManager administratorManager) {
		this.administratorManager = administratorManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * getAllProductAdministratorDefault
	 */
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefault() {
		try {
			logger.logDebug("Inicia getAllProductAdministratorDefault");
			return administratorManager.getAllProductAdministratorDefault();
		} finally {
			logger.logDebug("Finaliza getAllProductAdministratorDefault");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * getProductAdministratorByRole
	 */
	public List<ProductAdministratorDTO> getProductAdministratorByRole(Integer roleCode) {
		try {
			logger.logDebug("Inicia getProductAdministratorByRole");
			return administratorManager.getProductAdministratorByRole(roleCode);
		} finally {
			logger.logDebug("Finaliza getProductAdministratorByRole");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * getAllRolesProductAdministrator
	 */
	public List<ProductAdministratorDTO> getAllRolesProductAdministrator() {
		try {
			logger.logDebug("Inicia getAllRolesProductAdministrator");
			return administratorManager.getAllRolesProductAdministrator();
		} finally {
			logger.logDebug("Finaliza getAllRolesProductAdministrator");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * deleteProductAdministrator
	 */
	public void deleteProductAdministrator(Integer roleCode) {
		try {
			logger.logDebug("Inicia deleteProductAdministrator");
			administratorManager.deleteProductAdministrator(roleCode);
		} finally {
			logger.logDebug("Finaliza deleteProductAdministrator");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * updateProductAdministrator
	 */
	public void updateProductAdministrator(ProductAdministratorDTO objProductAdministrator) {
		try {
			logger.logDebug("Inicia updateProductAdministrator");
			administratorManager.updateProductAdministrator(objProductAdministrator);
		} finally {
			logger.logDebug("Finaliza updateProductAdministrator");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.admin.AdministratorService#
	 * insertProductAdministrator
	 */
	public void insertProductAdministrator(Integer idRole, String nameRole) {
		try {
			logger.logDebug("Inicia insertProductAdministrator");
			administratorManager.insertProductAdministrator(idRole, nameRole);
		} finally {
			logger.logDebug("Finaliza insertProductAdministrator");
		}
	}

	public Map<Integer, List<PropertiesDTO>> getServicesProductAdministrator() {
		try {
			logger.logDebug("Inicia getServicesProductAdministrator");
			return administratorManager.getServicesProductAdministrator();
		} finally {
			logger.logDebug("Finaliza getServicesProductAdministrator");
		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamic() {
		try {
			logger.logDebug("Inicia getAllProductAdministratorDefaultDinamic");
			return administratorManager.getAllProductAdministratorDefaultDinamic();
		} finally {
			logger.logDebug("Finaliza getAllProductAdministratorDefaultDinamic");
		}
	}

	@Override
	public List<ManagementContentSectionDTO> getAllManagementContentSection() {
		try {
			logger.logDebug("Inicia getAllManagementContentSection");
			return administratorManager.getAllManagementContentSection();
		} finally {
			logger.logDebug("Finaliza getAllManagementContentSection");
		}
	}

	@Override
	public List<ManagementContentSectionRoleDTO> getAllManagementContentSectionRole() {
		try {
			logger.logDebug("Inicia getAllManagementContentSection");
			return administratorManager.getAllManagementContentSectionRole();
		} finally {
			logger.logDebug("Finaliza getAllManagementContentSection");
		}
	}

	@Override
	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleByRole() {
		try {
			Context context = ContextManager.getContext();
			CobisSession session = (CobisSession) context.getSession();

			logger.logDebug("Inicia getManagementContentSectionRoleByRole" + Integer.parseInt(session.getRole()));
			return administratorManager.getManagementContentSectionRoleByRole(Integer.parseInt(session.getRole()));
		} finally {
			logger.logDebug("Finaliza getManagementContentSectionRoleByRole");
		}
	}

	@Override
	public List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleBySection(Integer manConSec) {
		try {
			logger.logDebug("Inicia getManagementContentSectionRoleBySection");
			return administratorManager.getManagementContentSectionRoleBySection(manConSec);
		} finally {
			logger.logDebug("Finaliza getManagementContentSectionRoleBySection");
		}
	}

	@Override
	public Integer deleteManagementContentSectionById(Integer code) {
		try {
			logger.logDebug("Inicia deleteManagementContentSectionById");
			return administratorManager.deleteManagementContentSectionById(code);
		} finally {
			logger.logDebug("Finaliza deleteManagementContentSectionById");
		}
	}

	@Override
	public Integer deleteManagementContentSectionRole(Integer code, Integer section) {
		try {
			logger.logDebug("Inicia deleteManagementContentSectionRole");
			return administratorManager.deleteManagementContentSectionRole(code, section);
		} finally {
			logger.logDebug("Finaliza deleteManagementContentSectionRole");
		}
	}

	@Override
	public Integer deleteManagementContentSectionRoleBySection(Integer code) {
		try {
			logger.logDebug("Inicia deleteManagementContentSectionRoleBySection");
			return administratorManager.deleteManagementContentSectionRoleBySection(code);
		} finally {
			logger.logDebug("Finaliza deleteManagementContentSectionRoleBySection");
		}
	}

	@Override
	public Integer updateManagementContentSectionById(ManagementContentSectionDTO entity) {
		try {
			logger.logDebug("Inicia updateManagementContentSectionById");
			return administratorManager.updateManagementContentSectionById(entity);
		} finally {
			logger.logDebug("Finaliza updateManagementContentSectionById");
		}
	}

	@Override
	public Integer insertManagementContentSectionRole(ManagementContentSectionRoleDTO entity) {
		try {
			logger.logDebug("Inicia insertManagementContentSectionRole");
			return administratorManager.insertManagementContentSectionRole(entity);
		} finally {
			logger.logDebug("Finaliza insertManagementContentSectionRole");
		}
	}

	@Override
	public Integer insertManagementContentSection(ManagementContentSectionDTO entity) {
		try {
			logger.logDebug("Inicia insertManagementContentSection");
			return administratorManager.insertManagementContentSection(entity);
		} finally {
			logger.logDebug("Finaliza insertManagementContentSection");
		}
	}

	@Override
	public Double insertDefaultProductAdministrator(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug("Inicia insertDefaultProductAdministrator");
			return administratorManager.insertDefaultProductAdministrator(entity);
		} finally {
			logger.logDebug("Finaliza insertDefaultProductAdministrator");
		}
	}

	@Override
	public Double updateDefaultProductAdministratorById(DefaultProductAdministratorDTO entity) {
		try {
			logger.logDebug("Inicia updateDefaultProductAdministratorById");
			return administratorManager.updateDefaultProductAdministratorById(entity);
		} finally {
			logger.logDebug("Finaliza updateDefaultProductAdministratorById");
		}
	}

	@Override
	public Double deleteDefaultProductAdministratorById(Double code) {
		try {
			logger.logDebug("Inicia deleteDefaultProductAdministratorById");
			return administratorManager.deleteDefaultProductAdministratorById(code);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.009", "deleteDefaultProductAdministratorById"), ex);
			throw new BusinessException(7300026, ex.getMessage());
		} finally {
			logger.logDebug("Finaliza deleteDefaultProductAdministratorById");
		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamicByType(String typeClient, String typeClientParent) {
		try {
			logger.logDebug("Inicia getAllProductAdministratorDefaultDinamicByType");
			return administratorManager.getAllProductAdministratorDefaultDinamicByType(typeClient, typeClientParent);
		} finally {
			logger.logDebug("Finaliza getAllProductAdministratorDefaultDinamicByType");
		}
	}

	@Override
	public List<DefaultProductAdministratorDTO> getProductAdministratorDefaultDinamicByParent(Double parent) {
		try {
			logger.logDebug("Inicia getProductAdministratorDefaultDinamicByParent");
			return administratorManager.getProductAdministratorDefaultDinamicByParent(parent);
		} finally {
			logger.logDebug("Finaliza getProductAdministratorDefaultDinamicByParent");
		}
	}

	@Override
	public List<DtosDTO> getAllDtosByParent(Integer parent) {
		try {
			logger.logDebug("Inicia getAllDtosByParent");
			return administratorManager.getAllDtosByParent(parent);
		} finally {
			logger.logDebug("Finaliza getAllDtosByParent");
		}
	}

	@Override
	public DefaultProductAdministratorDTO getProductAdministratorDefaultByIdProduct(Double idProduct) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getProductAdministratorDefaultByIdProduct"));
			return administratorManager.getProductAdministratorDefaultByIdProduct(idProduct);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.008"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getProductAdministratorDefaultByIdProduct"));
		}
	}

	@Override
	public DtosDTO getDtoSectionById(Integer idDto) {
		try {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.001", "getDtoSectionById"));
			return administratorManager.getDtoSectionById(idDto);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.008"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("PRODUCTADMINISTRATORMANAGER.002", "getDtoSectionById"));
		}
	}

	@Override
	public Integer insertDtoSection(DtosDTO dtosDTO) {
		try {
			logger.logDebug("Inicia insertDtoSection");
			return administratorManager.insertDtoSection(dtosDTO);
		} finally {
			logger.logDebug("Finaliza insertDtoSection");
		}
	}

	@Override
	public Integer updateDtoSection(DtosDTO dtosDTO) {
		try {
			logger.logDebug("Inicia updateDtoSection");
			return administratorManager.updateDtoSection(dtosDTO);
		} finally {
			logger.logDebug("Finaliza updateDtoSection");
		}
	}

	@Override
	public Integer deleteDtoSection(Integer idDto) {
		try {
			logger.logDebug("Inicia deleteDtoSection");
			return administratorManager.deleteDtoSection(idDto);
		} finally {
			logger.logDebug("Finaliza deleteDtoSection");
		}
	}

	@Override
	public List<PropertiesDTO> getPropertiesByDto(Integer idDto) {
		try {
			logger.logDebug("Inicia getPropertiesByDto");
			return administratorManager.getPropertiesByDto(idDto);
		} finally {
			logger.logDebug("Finaliza getPropertiesByDto");
		}
	}

	@Override
	public PropertiesDTO getPropertiesById(Integer propertieId) {
		try {
			logger.logDebug("Inicia getPropertiesById");
			return administratorManager.getPropertiesById(propertieId);
		} finally {
			logger.logDebug("Finaliza getPropertiesById");
		}
	}

	@Override
	public Integer insertPropertiesSection(PropertiesDTO propertiesDTO) {
		try {
			logger.logDebug("Inicia insertPropertiesSection");
			return administratorManager.insertPropertiesSection(propertiesDTO);
		} finally {
			logger.logDebug("Finaliza insertPropertiesSection");
		}
	}

	@Override
	public Integer updatePropertiesSection(PropertiesDTO propertiesDTO) {
		try {
			logger.logDebug("Inicia updatePropertiesSection");
			return administratorManager.updatePropertiesSection(propertiesDTO);
		} finally {
			logger.logDebug("Finaliza updatePropertiesSection");
		}
	}

	@Override
	public Integer deletePropertiesSection(Integer propertieId) {
		try {
			logger.logDebug("Inicia deletePropertiesSection");
			return administratorManager.deletePropertiesSection(propertieId);
		} finally {
			logger.logDebug("Finaliza deletePropertiesSection");
		}
	}

	@Override
	public List<DtosDTO> getAllDtos() {
		try {
			logger.logDebug("Inicia getAllDtos");
			return administratorManager.getAllDtos();
		} finally {
			logger.logDebug("Finaliza getAllDtos");
		}
	}

}
