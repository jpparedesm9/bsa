package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyDao;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyRolService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.RoleUser;

public class HierarchyServiceImpl implements HierarchyService {

	private HierarchyDao hierarchyDao;
	private HierarchyRolService hierarchyRolService;
	static Logger log = Logger.getLogger(HierarchyServiceImpl.class);

	/**
	 * @return the hierarchyDao
	 */
	public HierarchyDao getHierarchyDao() {
		return hierarchyDao;
	}

	/**
	 * @param hierarchyDao
	 *            the hierarchyDao to set
	 */
	public void setHierarchyDao(HierarchyDao hierarchyDao) {
		this.hierarchyDao = hierarchyDao;
	}

	public HierarchyRolService getHierarchyRolService() {
		return hierarchyRolService;
	}

	public void setHierarchyRolService(HierarchyRolService hierarchyRolService) {
		this.hierarchyRolService = hierarchyRolService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.service.workflow.HierarchyService#findHierarchyByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	public List<Hierarchy> findHierarchyByProcessVersion(Integer idProcess, Short version) {

		log.debug("findHierarchyByProcessVersion----------------------------->1");
		List<Hierarchy> hierarchyList = hierarchyDao.findHierarchyByProcessVersion(idProcess, version);
		log.debug("findHierarchyByProcessVersion----------------------------->2");
		for (Hierarchy hierarchy : hierarchyList) {
			for (HierarchyRol hierarchyRol : hierarchy.getHierarchyRolList()) {

				hierarchyRol.setHierarchy(null);

				if (hierarchyRol.getRole() != null) {
					for (RoleUser roleUser : hierarchyRol.getRole().getRoleUserList()) {
						roleUser.setRole(null);
					}
					for (RoleType roleType : hierarchyRol.getRole().getRoleTypeList()) {
						roleType.setRole(null);
					}
				}
			}

			for (LinkRole linkRole : hierarchy.getLinkRoleList()) {
				linkRole.setHierarchy(null);
			}
		}
		return hierarchyList;
	}

	public Hierarchy findById(Integer idHierarchy) {
		return hierarchyDao.findById(idHierarchy);
	}

	public ProcessVersion setHierarchyToProcessVersion(ProcessVersion processVersion, ProcessVersion newProcessVersion,
			DriverManagerDataSource dataSource) throws Exception {
		try {
			List<Hierarchy> hierarchyList = processVersion.getHierarchyList();
			log.debug("1setHierarchyToProcessVersion---------------------------------------->");
			newProcessVersion.setHierarchyList(new ArrayList<Hierarchy>());
			for (Hierarchy hierarchy : hierarchyList) {
				log.debug("2setHierarchyToProcessVersion---------------------------------------->");
				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
				Hierarchy newHierarchy = new Hierarchy();
				newHierarchy.setIdHierarchy(seqnos.execute("wf_jerarquia"));
				newHierarchy.setHierarchyRolList(new ArrayList<HierarchyRol>());
				newHierarchy.setIdProcess(newProcessVersion.getProcess().getIdProcess());
				newHierarchy.setLinkRoleList(new ArrayList<LinkRole>());
				newHierarchy.setName(hierarchy.getName());
				newHierarchy.setProcessVersion(newProcessVersion);
				newHierarchy.setVersion(newProcessVersion.getVersionProcess());
				newHierarchy = hierarchyRolService.setHierachyRolToHierarchy(hierarchy, newHierarchy, dataSource);
				newProcessVersion.getHierarchyList().add(newHierarchy);
				log.debug("3setHierarchyToProcessVersion---------------------------------------->");

			}

		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo setHierarchyToProcessVersion", ex);
			ex.printStackTrace();
			throw ex;
		}
		return newProcessVersion;
	}

	public Hierarchy findHierarchyByProcessVersionAndName(Integer idProcess, Short version, String hierarchyName) throws Exception {
		return hierarchyDao.findHierarchyByProcessVersionAndName(idProcess, version, hierarchyName);
	}

}
