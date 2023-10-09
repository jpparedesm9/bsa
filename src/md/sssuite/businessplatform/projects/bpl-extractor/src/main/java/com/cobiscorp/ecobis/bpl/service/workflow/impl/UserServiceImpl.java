package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Official;
import com.cobiscorp.ecobis.bpl.dao.workflow.OfficialDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.UserDao;
import com.cobiscorp.ecobis.bpl.service.workflow.UserService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public class UserServiceImpl implements UserService {

	private UserDao userDao;
	private OfficialDao officialDao;

	static Logger log = Logger.getLogger(RoleServiceImpl.class);

	/**
	 * @return the userDao
	 */
	public UserDao getUserDao() {
		return userDao;
	}

	/**
	 * @param userDao
	 *            the userDao to set
	 */
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public User findById(Integer idUser) {
		return userDao.findById(idUser);
	}

	/**
	 * @return the officialDao
	 */
	public OfficialDao getOfficialDao() {
		return officialDao;
	}

	/**
	 * @param officialDao
	 *            the officialDao to set
	 */
	public void setOfficialDao(OfficialDao officialDao) {
		this.officialDao = officialDao;
	}

	public User findAndSave(User user, DriverManagerDataSource dataSource) {

		// Validar que exista el funcionario
		Official official = officialDao.findByLogin(user.getLogin());

		// Si noexiste el usurio me devuelve
		if (official == null) {
			user.setSutituteUser(null);
			user.setLogin("admuser");
		}

		User userSearch = hmUser.get(user.getLogin());

		if (userSearch == null) {
			userSearch = userDao.findByLogin(user.getLogin());
			if (userSearch == null) {

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
				user.setIdUser(seqnos.execute("wf_usuario"));
				user.setSutituteUser(null);

				// Verifica si existe el usuario de la cabecera
				if (user.getSutituteUser() != null) {
					// User sutituteUser = findAndSave(user.getSutituteUser(), dataSource);
					// userSearch.setSutituteUser(sutituteUser);
				}
				userSearch = userDao.insert(user);
			}
			hmUser.put(user.getLogin(), userSearch);
		}
		return userSearch;

	}

}
