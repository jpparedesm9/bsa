package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyRolDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.LinkRoleDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.RoleDao;
import com.cobiscorp.ecobis.bpl.service.workflow.LinkRolService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;

public class LinkRolServiceImpl implements LinkRolService {

	private LinkRoleDao linkRoleDao;
	private HierarchyDao hierarchyDao;
	private HierarchyRolDao hierarchyRolDao;
	private RoleDao roleDao;

	public LinkRoleDao getLinkRoleDao() {
		return linkRoleDao;
	}

	public void setLinkRoleDao(LinkRoleDao linkRoleDao) {
		this.linkRoleDao = linkRoleDao;
	}

	public HierarchyDao getHierarchyDao() {
		return hierarchyDao;
	}

	public void setHierarchyDao(HierarchyDao hierarchyDao) {
		this.hierarchyDao = hierarchyDao;
	}

	public HierarchyRolDao getHierarchyRolDao() {
		return hierarchyRolDao;
	}

	public void setHierarchyRolDao(HierarchyRolDao hierarchyRolDao) {
		this.hierarchyRolDao = hierarchyRolDao;
	}

	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

//	public void saveLinkRole(Process process, ProcessVersion processVersion, DriverManagerDataSource dataSource) throws Exception {
//		try {
//
//			List<Hierarchy> hierarchies = processVersion.getHierarchyList();
//
//			for (Hierarchy hierarchy : hierarchies) {
//				Hierarchy searchedHierarchy = hierarchyDao.findHierarchyByProcessVersionAndName(process.getIdProcess(),
//						processVersion.getVersionProcess(), hierarchy.getName());
//
//				List<LinkRole> linkRoleList = hierarchy.getLinkRoleList();
//				for (LinkRole linkRole : linkRoleList) {
//					SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
//					LinkRole newLinkRole = new LinkRole();
//					newLinkRole.setCondition(linkRole.getCondition());
//					newLinkRole.setIdProcess(process.getIdProcess());
//					newLinkRole.setInstException(linkRole.getInstException());
//					newLinkRole.setLinkPoints(linkRole.getLinkPoints());
//					newLinkRole.setName(linkRole.getName());
//					newLinkRole.setPriority(linkRole.getPriority());
//					newLinkRole.setVersionProcess(processVersion.getVersionProcess());
//					newLinkRole.setHierarchy(searchedHierarchy);
//
//					Role finRole = roleDao.findByName(linkRole.getFinalHierarchyRol().getRole().getName());
//					HierarchyRol finalHierarchyRol = hierarchyRolDao.findByProcessVersionHierarchyAndRole(process.getIdProcess(),
//							processVersion.getVersionProcess(), searchedHierarchy.getIdHierarchy(), finRole.getIdRole());
//					newLinkRole.setFinalHierarchyRol(finalHierarchyRol);
//					
//					if(finalHierarchyRol==null){
//						newLinkRole.setIdFinalHierachyRol(0);
//					}else{
//						newLinkRole.setIdFinalHierachyRol(finalHierarchyRol.getIdHierarchyRol().getIdRole());
//					}
//
//					Role initRole = roleDao.findByName(linkRole.getInitialHierarchyRol().getRole().getName());
//					HierarchyRol initialHierarchyRol = hierarchyRolDao.findByProcessVersionHierarchyAndRole(process.getIdProcess(),
//							processVersion.getVersionProcess(), searchedHierarchy.getIdHierarchy(), initRole.getIdRole());
//					
//					newLinkRole.setInitialHierarchyRol(initialHierarchyRol);
//					newLinkRole.setIdLinkRole(seqnos.execute("wf_enlace_roles"));
//					linkRoleDao.save(newLinkRole);
//				}
//			}
//		} catch (Exception ex) {
//		}
//
//	}

	public LinkRole saveLinkRole(LinkRole linkRole) throws Exception {
		return linkRoleDao.save(linkRole);
	}

}
