package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.RoleTypeDao;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleTypeService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;

public class RoleTypeServiceImpl implements RoleTypeService {

	private RoleTypeDao roleTypeDao;

	/**
	 * @return the roleTypeDao
	 */
	public RoleTypeDao getRoleTypeDao() {
		return roleTypeDao;
	}

	/**
	 * @param roleTypeDao
	 *            the roleTypeDao to set
	 */
	public void setRoleTypeDao(RoleTypeDao roleTypeDao) {
		this.roleTypeDao = roleTypeDao;
	}

	public List<RoleType> findByRole(Integer idRole) {
		return roleTypeDao.findByRole(idRole);
	}

	public RoleType save(RoleType roleType) {
		return roleTypeDao.insert(roleType);
	}

}
