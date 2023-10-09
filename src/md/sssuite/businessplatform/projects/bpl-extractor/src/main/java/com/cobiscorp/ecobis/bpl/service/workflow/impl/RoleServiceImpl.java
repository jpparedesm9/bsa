package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.RoleDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.RoleUserDao;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleService;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleTypeService;
import com.cobiscorp.ecobis.bpl.service.workflow.UserService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdRoleType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdRoleUser;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

/**
 * @author acarrillo
 * 
 */
public class RoleServiceImpl implements RoleService {

	private RoleDao roleDao;
	private RoleTypeService roleTypeService;
	private UserService userService;
	private RoleUserDao roleUserDao;

	static Logger log = Logger.getLogger(RoleServiceImpl.class);

	/**
	 * @return the roleDao
	 */
	public RoleDao getRoleDao() {
		return roleDao;
	}

	/**
	 * @param roleDao
	 *            the roleDao to set
	 */
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public Role findById(Integer idRole) {
		Role role = roleDao.findById(idRole);

		if (role != null) {
			for (RoleType roleType : role.getRoleTypeList()) {
				roleType.setRole(null);
			}
			for (RoleUser roleUser : role.getRoleUserList()) {
				roleUser.setRole(null);
			}
		}
		return role;
	}

	/**
	 * @return the userService
	 */
	public UserService getUserService() {
		return userService;
	}

	/**
	 * @param userService
	 *            the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * @return the roleUserDao
	 */
	public RoleUserDao getRoleUserDao() {
		return roleUserDao;
	}

	/**
	 * @param roleUserDao
	 *            the roleUserDao to set
	 */
	public void setRoleUserDao(RoleUserDao roleUserDao) {
		this.roleUserDao = roleUserDao;
	}

	/**
	 * @return the roleTypeService
	 */
	public RoleTypeService getRoleTypeService() {
		return roleTypeService;
	}

	/**
	 * @param roleTypeService
	 *            the roleTypeService to set
	 */
	public void setRoleTypeService(RoleTypeService roleTypeService) {
		this.roleTypeService = roleTypeService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.service.workflow.RoleService#findAndSave(com.cobiscorp.ecobis.bpl.workflow.engine.model.Role,
	 * org.springframework.jdbc.datasource.DriverManagerDataSource)
	 */
	public Role findAndSave(Role role, DriverManagerDataSource dataSource) {

		// Busco el rol en base al nombre en el mapa
		log.debug("XXXXXXXXXX-------------------------------------------------------------->1 " + hmRole);
		log.debug("XXXXXXXXXX-------------------------------------------------------------->2 " + role);
		log.debug("XXXXXXXXXX-------------------------------------------------------------->3 " + role.getName());
		Role roleFound = hmRole.get(role.getName());

		log.debug("Role-------------------------------------------------------------->1 " + role.getName());

		if (roleFound == null) {

			log.debug("Role-------------------------------------------------------------->2 " + role.getName());
			roleFound = roleDao.findByName(role.getName());

			log.debug("Role-------------------------------------------------------------->3 " + role.getName());
			if (roleFound == null) {
				log.debug("Role-------------------------------------------------------------->4 " + role.getName());

				// Declaro la clase para ejecutar el seqnos
				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

				// Crea el objeto
				roleFound = new Role();
				roleFound.setIdRole(seqnos.execute("wf_rol"));
				roleFound.setComite(role.getComite());
				roleFound.setIdCompany(role.getIdCompany());
				roleFound.setIntervenes(role.getIntervenes());
				roleFound.setName(role.getName());
				roleFound.setOrder(role.getOrder());

				log.debug("Role-------------------------------------------------------------->5");

				// Verifica si existe el usuario de la cabecera
				if (role.getUser() != null) {
					log.debug("Role-------------------------------------------------------------->6");
					User userHeader = userService.findAndSave(role.getUser(), dataSource);
					roleFound.setUser(userHeader);
				}

				log.debug("Role-------------------------------------------------------------->7");
				// Inserta el objeto y lo pone en el mapa
				for (RoleType roleType : role.getRoleTypeList()) {
					log.debug("Role-------------------------------------------------------------->8");
					roleType.setIdRoleType(new IdRoleType(roleFound.getIdRole(), roleType.getType()));
					roleType.setRole(roleFound);
					roleType.setType(roleType.getType());
					roleFound.getRoleTypeList().add(roleType);
				}

				HashMap<String, RoleUser> hmRoleUser = new HashMap<String, RoleUser>();
				// Verifico que no existan RoleUser duplicados y si no existelo inserta
				for (RoleUser roleUser : role.getRoleUserList()) {

					User user = userService.findAndSave(roleUser.getUser(), dataSource);

					log.debug("Role-------------------------------------------------------------->9");

					if (!hmRoleUser.containsKey(user.getIdUser() + "-" + roleFound.getIdRole())) {

						log.debug("Role-------------------------------------------------------------->10");

						RoleUser roleUserNew = new RoleUser();
						roleUserNew.setUser(null);
						roleUserNew.setRole(null);
						roleUserNew.setIdRoleUser(new IdRoleUser(user.getIdUser(), roleFound.getIdRole()));
						roleUserNew.setStatus(roleUser.getStatus());

						log.debug("getIdRole-------------------------------------------------------------->"
								+ roleUserNew.getIdRoleUser().getIdRole());
						log.debug("getIdUser-------------------------------------------------------------->"
								+ roleUserNew.getIdRoleUser().getIdUser());

						// Verifica si existe los usuarios en del detalle del Role
						if (roleUser.getUserSutitute() != null) {
							User userSutitute = userService.findAndSave(roleUser.getUserSutitute(), dataSource);
							roleUserNew.setUserSutitute(userSutitute);
						}

						roleFound.getRoleUserList().add(roleUserNew);
						hmRoleUser.put(user.getIdUser() + "-" + roleFound.getIdRole(), roleUserNew);
					}

					// roleUserDao.insert(roleUserNew);

					log.debug("Role-------------------------------------------------------------->11");
				}
				log.debug("Role-------------------------------------------------------------->12");
				roleDao.insert(roleFound);
				log.debug("Role-------------------------------------------------------------->13 " + role.hashCode());
			}
			log.debug("Role-------------------------------------------------------------->14");
			hmRole.put(roleFound.getName(), roleFound);
			log.debug("Role-------------------------------------------------------------->15");
		}
		return roleFound;
	}
}
