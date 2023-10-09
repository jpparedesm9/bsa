package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyRolDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyRolService;
import com.cobiscorp.ecobis.bpl.service.workflow.ResultService;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyRol;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdHierarchyRol;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkRole;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Result;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;

public class HierarchyRolServiceImpl implements HierarchyRolService {

	private HierarchyRolDao hierarchyRolDao;
	private RoleService roleService;
	private VariableService variableService;
	private ResultService resultService;

	static Logger log = Logger.getLogger(HierarchyRolServiceImpl.class);

	public HierarchyRolDao getHierarchyRolDao() {
		return hierarchyRolDao;
	}

	public void setHierarchyRolDao(HierarchyRolDao hierarchyRolDao) {
		this.hierarchyRolDao = hierarchyRolDao;
	}

	/**
	 * @return the roleService
	 */
	public RoleService getRoleService() {
		return roleService;
	}

	/**
	 * @param roleService
	 *            the roleService to set
	 */
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	/**
	 * @return the variableService
	 */
	public VariableService getVariableService() {
		return variableService;
	}

	/**
	 * @param variableService
	 *            the variableService to set
	 */
	public void setVariableService(VariableService variableService) {
		this.variableService = variableService;
	}

	/**
	 * @return the resultService
	 */
	public ResultService getResultService() {
		return resultService;
	}

	/**
	 * @param resultService
	 *            the resultService to set
	 */
	public void setResultService(ResultService resultService) {
		this.resultService = resultService;
	}

	public Hierarchy setHierachyRolToHierarchy(Hierarchy hierarchy, Hierarchy newHierarchy, DriverManagerDataSource dataSource) throws Exception {
		try {

			log.debug("1LinkRole---------------------------------------->");

			for (HierarchyRol hierarchyRol : hierarchy.getHierarchyRolList()) {
				log.debug("2LinkRole---------------------------------------->");
				HierarchyRol newHierarchyRol = new HierarchyRol();
				newHierarchyRol.setHierarchy(newHierarchy);
				newHierarchyRol.setIdProcess(newHierarchy.getProcessVersion().getProcess().getIdProcess());
				newHierarchyRol.setManualAssigned(hierarchyRol.getManualAssigned());
				newHierarchyRol.setPositionX(hierarchyRol.getPositionX());
				newHierarchyRol.setPositionY(hierarchyRol.getPositionY());
				newHierarchyRol.setVersionProcess(newHierarchy.getVersion());

				if (hierarchyRol.getIdHierarchyRol().getIdRole() == 0) {
					log.debug("LinkRole---------------------------------------->3");
					newHierarchyRol.setRole(null);
					newHierarchyRol.setIdHierarchyRol(new IdHierarchyRol(newHierarchy.getIdHierarchy(), 0));
					log.debug("LinkRole---------------------------------------->4");
				} else {
					log.debug("LinkRole---------------------------------------->5");
					Role role = roleService.findAndSave(hierarchyRol.getRole(), dataSource);
					log.debug("LinkRole---------------------------------------->6 ");
					newHierarchyRol.setRole(role);
					log.debug("LinkRole---------------------------------------->6.1 " + newHierarchyRol.getRole().getName() + "-"
							+ newHierarchyRol.getRole().getIdRole());
					newHierarchyRol.setIdHierarchyRol(new IdHierarchyRol(newHierarchy.getIdHierarchy(), role.getIdRole()));
					log.debug("LinkRole---------------------------------------->7");
				}
				log.debug("LinkRole---------------------------------------->8");
				newHierarchy.getHierarchyRolList().add(newHierarchyRol);
				log.debug("LinkRole---------------------------------------->9");
			}

			List<LinkRole> linkRoleList = hierarchy.getLinkRoleList();
			for (LinkRole linkRole : linkRoleList) {

				log.debug("LinkRole---------------------------------------->10");
				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
				LinkRole newLinkRole = new LinkRole();
				newLinkRole.setIdLinkRole(seqnos.execute("wf_enlace_roles"));
				newLinkRole.setCondition(replaceExpression(linkRole.getCondition()));
				newLinkRole.setIdProcess(newHierarchy.getProcessVersion().getProcess().getIdProcess());
				newLinkRole.setInstException(linkRole.getInstException());
				newLinkRole.setLinkPoints(linkRole.getLinkPoints());
				newLinkRole.setName(linkRole.getName());
				newLinkRole.setPriority(linkRole.getPriority());
				newLinkRole.setVersionProcess(newHierarchy.getProcessVersion().getVersionProcess());
				newLinkRole.setHierarchy(newHierarchy);
				log.debug("LinkRole---------------------------------------->11");

				if (linkRole.getIdFinalRol() == 0) {
					log.debug("LinkRole---------------------------------------->12");
					newLinkRole.setIdFinalRol(linkRole.getIdFinalRol());
					newLinkRole.setFinalRol(null);
				} else {
					log.debug("XXXXXXXXXX---------------------------------->"+ linkRole.getFinalRol());
					Role finalRole = roleService.findAndSave(linkRole.getFinalRol(), dataSource);
					log.debug("---------------------------------->ROLE_2" + finalRole.getName());
					newLinkRole.setFinalRol(null);
					log.debug("---------------------------------->ROLE_3");
					newLinkRole.setIdFinalRol(finalRole.getIdRole());
					log.debug("---------------------------------->ROLE_4");
				}

				if (linkRole.getIdInitialRol() == 0) {
					newLinkRole.setIdInitialRol(linkRole.getIdInitialRol());
					newLinkRole.setFinalRol(null);
				} else {
					log.debug("---------------------------------->ROLE_5 ");
					Role initialRole = roleService.findAndSave(linkRole.getInitialRol(), dataSource);
					log.debug("---------------------------------->ROLE_6");
					newLinkRole.setInitialRol(null);
					log.debug("---------------------------------->ROLE_7");
					newLinkRole.setIdInitialRol(initialRole.getIdRole());
					log.debug("---------------------------------->ROLE_8");
				}

				log.debug("2LinkRole---------------------------------------->");
				newHierarchy.getLinkRoleList().add(newLinkRole);

			}
		} catch (Exception ex) {
			throw ex;
		}
		return newHierarchy;
	}

	public HierarchyRol insert(HierarchyRol hierarchyRol) throws Exception {
		return hierarchyRolDao.insert(hierarchyRol);
	}

	@SuppressWarnings("unused")
	private String replaceExpression(String expression) throws Exception {

		log.debug("Expression a ser modificada----->" + expression);

		// Declaro variables a utilizar
		String expressionModified = "";
		String expressionTemp = "";
		String expressionEvaluated = new String(expression);
		String beforeValue = "";

		for (int i = 0; i < expressionEvaluated.length(); i++) {
			String valueExpression = "";
			String caracter = String.valueOf(expressionEvaluated.charAt(i)).trim();

			if (caracter.equals("#")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("#"));
				i = expressionTemp.indexOf("#") + i + 1;

				log.debug("valueExpression----->" + valueExpression);

				Variable variable = variableService.findByAbreviaturaVariable(valueExpression);
				if (variable != null) {
					expressionModified = expressionModified + "#" + variable.getCodigoVariable() + "#";
				}

			} else if (caracter.equals("%")) {

				expressionTemp = expressionEvaluated.substring(i + 1, expressionEvaluated.length());
				valueExpression = expressionTemp.substring(0, expressionTemp.indexOf("%"));
				i = expressionTemp.indexOf("%") + i + 1;

				log.debug("valueExpression----->" + valueExpression);
				Result result = resultService.findResultByName(valueExpression);
				if (result != null) {
					expressionModified = expressionModified + "%" + result.getIdResult() + "%";
				}

			} else {
				expressionModified = expressionModified + caracter;
				log.debug("expressionModified---------------->" + expressionModified);
			}
			beforeValue = caracter;
		}

		return expressionModified;
	}

}
