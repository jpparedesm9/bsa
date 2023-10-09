package com.cobiscorp.ecobis.clientviewer.admin.dal;

import java.util.List;
import java.util.Map;

import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.Dtos;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO;

/**
 * 
 * Exposes the methods of DAL layer of administrator consolidated view
 * 
 * @author dcumbal
 */
public interface AdministratorDAO {

	/**
	 * Method getAllProductAdministratorDefault, returns the parameterization
	 * default of consolidated view
	 * 
	 * @return DefaultProductAdministratorDTO object list
	 * @author dcumbal
	 */
	List<DefaultProductAdministratorDTO> getAllProductAdministratorDefault();

	/**
	 * Method getProductAdministratorByRole, gets a list of all products with
	 * which is associated a role through the role code sent as parameter
	 * 
	 * @param roleCode
	 *            = Integer
	 * @return ProductAdministratorDTO object list
	 * @author dcumbal
	 */
	List<ProductAdministratorDTO> getProductAdministratorByRole(Integer roleCode);

	/**
	 * Method getAllRolesProductAdministrator, gets a list of all roles
	 * configured in administrator of consolidated view
	 * 
	 * @return ProductAdministratorDTO object list
	 * @author dcumbal
	 */
	List<ProductAdministratorDTO> getAllRolesProductAdministrator();

	/**
	 * Method deleteProductAdministrator, remove the consolidated view
	 * configuration associated with a role. receives as parameters the role
	 * code.
	 * 
	 * @param roleCode
	 *            = Integer
	 * @author dcumbal
	 */
	void deleteProductAdministrator(Integer roleCode);

	/**
	 * Method updateProductAdministrator, updates the configuration of
	 * administrator consolidated view receives as parameters a
	 * ProductAdministratorDTO object.
	 * 
	 * @param objProductManager
	 *            = ProductAdministratorDTO
	 * @author dcumbal
	 */
	void updateProductAdministrator(
			ProductAdministratorDTO objProductAdministador);

	/**
	 * Method insertProductAdministador, insert configuration of administrator
	 * consolidated view receives as parameter the role code and role name .
	 * 
	 * @author dcumbal
	 * @param idRole
	 *            = Integer
	 * @param nameRole
	 *            = String
	 */
	void insertProductAdministador(Integer idRole, String roleName);

	/**
	 * Method to get services, dtos and properties of VCC
	 */
	Map<Integer, List<PropertiesDTO>> getServicesProductAdministrator();

	/**
	 * Method to get configuration dinamic for VCC
	 * 
	 * @return
	 */
	List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamic();

	/**
	 * Method to get dtos for configuration dinamic
	 * 
	 * @return
	 */
	List<DtosDTO> getAllDtos();

	/**
	 * Method to get ManagementContentSection for dinamic sections
	 * 
	 * @return ManagementContentSectionDTO object list
	 * @author ecarrion
	 */
	List<ManagementContentSectionDTO> getAllManagementContentSection();

	/**
	 * Method to get ManagementContentSection for dinamic sections
	 * 
	 * @return ManagementContentSectionDTO object list
	 * @author ecarrion
	 */
	List<ManagementContentSectionRoleDTO> getAllManagementContentSectionRole();

	/**
	 * Method to get ManagementContentSectionRole by role into dinamic sections
	 * 
	 * @param roleCode
	 *            = Integer
	 * @return ManagementContentSectionRoleDTO object list
	 * @author ecarrion
	 */
	List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleByRole(
			Integer roleCode);

	/**
	 * Method to get ManagementContentSectionRole by section into dinamic
	 * sections
	 * 
	 * @param manConSec
	 *            = Integer
	 * @return ManagementContentSectionRoleDTO object list
	 * @author ecarrion
	 */
	List<ManagementContentSectionRoleDTO> getManagementContentSectionRoleBySection(
			Integer manConSec);

	/**
	 * Method to delete ManagementContentSection by id sections
	 * 
	 * @param code
	 *            = Integer
	 * @return number of deleted records
	 * @author gvillamagua
	 */
	Integer deleteManagementContentSectionById(Integer code);

	/**
	 * Method to delete ManagementContentSectionRol by id
	 * 
	 * @param code
	 *            = Integer, section = integer
	 * @return number of deleted records
	 * @author gvillamagua
	 */
	Integer deleteManagementContentSectionRole(Integer code, Integer section);

	/**
	 * Method to delete ManagementContentSectionRol by id sections
	 * 
	 * @param code
	 *            = Integer
	 * @return number of deleted records
	 * @author gvillamagua
	 */
	Integer deleteManagementContentSectionRoleBySection(Integer code);

	/**
	 * Method to update ManagementContentSection by id sections
	 * 
	 * @param entity
	 *            = ManagementContentSectionDTO
	 * @return number of updated record
	 * @author gvillamagua
	 */
	Integer updateManagementContentSectionById(
			ManagementContentSectionDTO entity);

	/**
	 * Method to insert ManagementContentSection
	 * 
	 * @param entity
	 *            = ManagementContentSectionDTO
	 * @return integer 1
	 * @author gvillamagua
	 */
	Integer insertManagementContentSection(ManagementContentSectionDTO entity);

	/**
	 * Method to insert ManagementContentSectionRole
	 * 
	 * @param entity
	 *            = ManagementContentSectionRoleDTO
	 * @return integer 1
	 * @author gvillamagua
	 */
	Integer insertManagementContentSectionRole(
			ManagementContentSectionRoleDTO entity);

	List<Dtos> getByDefaultProductAdministrator(String mnemonic);

	/**
	 * Method to insert DefaultProductAdministrator
	 * 
	 * @param entity
	 *            = DefaultProductAdministratorDTO
	 * @return Double 1
	 * @author ecarrion
	 */
	Double insertDefaultProductAdministrator(
			DefaultProductAdministratorDTO entity);

	/**
	 * Method to delete DefaultProductAdministrator by id
	 * 
	 * @param code
	 *            = Double
	 * @return number of deleted records
	 * @author ecarrion
	 */
	Double deleteDefaultProductAdministratorById(Double code);

	/**
	 * Method to update DefaultProductAdministrator by id
	 * 
	 * @param entity
	 *            = DefaultProductAdministratorDTO
	 * @return number of updated record
	 * @author ecarrion
	 */
	Double updateDefaultProductAdministratorById(
			DefaultProductAdministratorDTO entity);

	/**
	 * Method to get configuration dinamic for VCC by typeClient
	 * 
	 * @return List<DefaultProductAdministratorDTO>
	 * @author ecarrion
	 */
	List<DefaultProductAdministratorDTO> getAllProductAdministratorDefaultDinamicByType(
			String typeClient, String typeClientParent);

	/**
	 * Method to get configuration dinamic for VCC by parent
	 * 
	 * @return List<DefaultProductAdministratorDTO>
	 * @author ecarrion
	 */
	List<DefaultProductAdministratorDTO> getProductAdministratorDefaultDinamicByParent(
			Double parent);
	
	/**
	 * Method to get DefaultProductAdministrator by idProduct
	 * 
	 * @return List<DefaultProductAdministratorDTO>
	 * @author ecarrion
	 */
	DefaultProductAdministratorDTO getProductAdministratorDefaultByIdProduct(Double idProduct);

	/**
	 * Method to get DTOs for VCC by parent
	 * 
	 * @return List<DtosDTO>
	 * @author ecarrion
	 */
	List<DtosDTO> getAllDtosByParent(Integer parent);
	
	/**
	 * Method to get DTOs by Id
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	DtosDTO getDtoSectionById(Integer idDto);
	
	/**
	 * Method insert DTO
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer insertDtoSection(DtosDTO dtosDTO);
	
	/**
	 * Method insert DTO
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer updateDtoSection(DtosDTO dtosDTO);
	
	/**
	 * Method insert DTO
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer deleteDtoSection(Integer idDto);
	
	/**
	 * Method to get Properties by Dtos
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	List<PropertiesDTO> getPropertiesByDto(Integer idDto);
	
	/**
	 * Method to get Properties by Id
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	PropertiesDTO getPropertiesById(Integer propertieId);
	
	/**
	 * Method insert PropertiesDTO
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer insertPropertiesSection(PropertiesDTO propertiesDTO);
	
	/**
	 * Method insert DTO
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer updatePropertiesSection(PropertiesDTO propertiesDTO);
	
	/**
	 * Method insert Properties
	 * 
	 * @return List<DtosDTO>
	 * @author acarrillo
	 */
	Integer deletePropertiesSection(Integer propertieId);
	
	
	

}
