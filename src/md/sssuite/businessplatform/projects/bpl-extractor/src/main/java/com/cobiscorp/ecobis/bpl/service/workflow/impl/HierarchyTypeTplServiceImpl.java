package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyItemTplDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyLevelTplDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyTypeTplDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyUserTplDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyTypeTplService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService;
import com.cobiscorp.ecobis.bpl.service.workflow.UserService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyItemTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyLevelTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyUserTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public class HierarchyTypeTplServiceImpl implements HierarchyTypeTplService {

	private HierarchyTypeTplDao hierarchyTypeTplDao;
	private HierarchyItemTplDao hierarchyItemTplDao;
	private HierarchyUserTplDao hierarchyUserTplDao;
	private HierarchyLevelTplDao hierarchyLevelTplDao;
	private UserService userService;
	private ProcessVariableService processVariableService;
	private VariableService variableService;

	static Logger log = Logger.getLogger(HierarchyTypeTplService.class);

	/**
	 * @return the hierarchyTypeTplDao
	 */
	public HierarchyTypeTplDao getHierarchyTypeTplDao() {
		return hierarchyTypeTplDao;
	}

	/**
	 * @param hierarchyTypeTplDao
	 *            the hierarchyTypeTplDao to set
	 */
	public void setHierarchyTypeTplDao(HierarchyTypeTplDao hierarchyTypeTplDao) {
		this.hierarchyTypeTplDao = hierarchyTypeTplDao;
	}

	/**
	 * @return the hierarchyItemTplDao
	 */
	public HierarchyItemTplDao getHierarchyItemTplDao() {
		return hierarchyItemTplDao;
	}

	/**
	 * @param hierarchyItemTplDao
	 *            the hierarchyItemTplDao to set
	 */
	public void setHierarchyItemTplDao(HierarchyItemTplDao hierarchyItemTplDao) {
		this.hierarchyItemTplDao = hierarchyItemTplDao;
	}

	/**
	 * @return the hierarchyUserTplDao
	 */
	public HierarchyUserTplDao getHierarchyUserTplDao() {
		return hierarchyUserTplDao;
	}

	/**
	 * @param hierarchyUserTplDao
	 *            the hierarchyUserTplDao to set
	 */
	public void setHierarchyUserTplDao(HierarchyUserTplDao hierarchyUserTplDao) {
		this.hierarchyUserTplDao = hierarchyUserTplDao;
	}

	/**
	 * @return the processVariableService
	 */
	public ProcessVariableService getProcessVariableService() {
		return processVariableService;
	}

	/**
	 * @param processVariableService
	 *            the processVariableService to set
	 */
	public void setProcessVariableService(ProcessVariableService processVariableService) {
		this.processVariableService = processVariableService;
	}

	/**
	 * @return the hierarchyLevelTplDao
	 */
	public HierarchyLevelTplDao getHierarchyLevelTplDao() {
		return hierarchyLevelTplDao;
	}

	/**
	 * @param hierarchyLevelTplDao
	 *            the hierarchyLevelTplDao to set
	 */
	public void setHierarchyLevelTplDao(HierarchyLevelTplDao hierarchyLevelTplDao) {
		this.hierarchyLevelTplDao = hierarchyLevelTplDao;
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

	public HierarchyTypeTpl findById(Integer idHierarchy) {

		HierarchyTypeTpl hierarchyTypeTpl = hierarchyTypeTplDao.findById(idHierarchy);
		HierarchyTypeTpl hierarchyTypeTplNew = null;

		if (hierarchyTypeTpl != null) {

			hierarchyTypeTplNew = new HierarchyTypeTpl();
			hierarchyTypeTplNew.setDescription(hierarchyTypeTpl.getDescription());
			hierarchyTypeTplNew.setHierarchyItemTplList(new ArrayList<HierarchyItemTpl>());
			hierarchyTypeTplNew.setHierarchyLevelTplList(new ArrayList<HierarchyLevelTpl>());
			hierarchyTypeTplNew.setIdHierarchyTypeTpl(hierarchyTypeTpl.getIdHierarchyTypeTpl());
			hierarchyTypeTplNew.setInbox(hierarchyTypeTpl.getInbox());
			hierarchyTypeTplNew.setName(hierarchyTypeTpl.getName());

			for (HierarchyItemTpl hierarchyItemTpl : hierarchyItemTplDao.findByHierarchyTypeTpl(hierarchyTypeTpl.getIdHierarchyTypeTpl())) {

				HierarchyItemTpl hierarchyItemTplNew = new HierarchyItemTpl();
				hierarchyItemTplNew.setCatalog(hierarchyItemTpl.getCatalog());
				hierarchyItemTplNew.setDescription(hierarchyItemTpl.getDescription());
				hierarchyItemTplNew.setHierarchyItemTplList(new ArrayList<HierarchyItemTpl>());
				hierarchyItemTplNew.setHierarchyLevelTpl(hierarchyItemTpl.getHierarchyLevelTpl());
				hierarchyItemTplNew.setHierarchyUserTplList(new ArrayList<HierarchyUserTpl>());
				hierarchyItemTplNew.setHierarchyTypeTpl(null);
				hierarchyItemTplNew.setIdHierarchyItemTpl(hierarchyItemTpl.getIdHierarchyItemTpl());
				hierarchyItemTplNew.setLevelValue(hierarchyItemTpl.getLevelValue());
				hierarchyItemTplNew.setHierarchyItemTplParent(hierarchyItemTpl.getHierarchyItemTplParent());

				for (HierarchyUserTpl hierarchyUserTpl : hierarchyUserTplDao.findByHierarchyItemTpl(hierarchyItemTpl.getIdHierarchyItemTpl())) {
					HierarchyUserTpl hierarchyUserTplNew = new HierarchyUserTpl();
					hierarchyUserTplNew.setHierarchyItemTpl(null);
					hierarchyUserTplNew.setIdHierarchyUserTpl(hierarchyUserTpl.getIdHierarchyUserTpl());
					hierarchyUserTplNew.setUser(hierarchyUserTpl.getUser());
					hierarchyUserTplNew.setUserParent(hierarchyUserTpl.getUserParent());
					hierarchyItemTplNew.getHierarchyUserTplList().add(hierarchyUserTplNew);
				}

				hierarchyTypeTplNew.getHierarchyItemTplList().add(hierarchyItemTplNew);

			}

			for (HierarchyLevelTpl hierarchyLevelTpl : hierarchyTypeTpl.getHierarchyLevelTplList()) {
				hierarchyLevelTpl.setHierarchyTypeTpl(null);
				hierarchyTypeTplNew.getHierarchyLevelTplList().add(hierarchyLevelTpl);
			}

		}
		return hierarchyTypeTplNew;
	}

	public HierarchyTypeTpl findAndSave(HierarchyTypeTpl hierarchyTypeTpl, DriverManagerDataSource dataSource) {

		HierarchyTypeTpl hierarchyTypeTplSearch = hmHierarchyTypeTpl.get(hierarchyTypeTpl.getName());
		log.debug("1-------------------------------------->" + hierarchyTypeTplSearch);
		if (hierarchyTypeTplSearch == null) {

			log.debug("2-------------------------------------->" + hierarchyTypeTplSearch);

			hierarchyTypeTplSearch = hierarchyTypeTplDao.findByName(hierarchyTypeTpl.getName());

			log.debug("3-------------------------------------->" + hierarchyTypeTplSearch);
			if (hierarchyTypeTplSearch == null) {

				log.debug("4-------------------------------------->" + hierarchyTypeTplSearch);

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
				HashMap<String, HierarchyLevelTpl> hmHierarchyLevelTpl = new HashMap<String, HierarchyLevelTpl>();
				HashMap<String, HierarchyItemTpl> hmHierarchyItemTpl = new HashMap<String, HierarchyItemTpl>();

				// Creo el HierarchyTypeTpl y lo inserto
				hierarchyTypeTplSearch = new HierarchyTypeTpl();
				hierarchyTypeTplSearch.setIdHierarchyTypeTpl(seqnos.execute("wf_tipo_jerarquia_tpl"));
				hierarchyTypeTplSearch.setInbox(hierarchyTypeTpl.getInbox());
				hierarchyTypeTplSearch.setName(hierarchyTypeTpl.getName());
				hierarchyTypeTplSearch.setDescription(hierarchyTypeTpl.getDescription());
				hierarchyTypeTplSearch.setHierarchyItemTplList(new ArrayList<HierarchyItemTpl>());
				hierarchyTypeTplSearch.setHierarchyLevelTplList(new ArrayList<HierarchyLevelTpl>());

				hierarchyTypeTplSearch = hierarchyTypeTplDao.insert(hierarchyTypeTplSearch);

				for (HierarchyLevelTpl hierarchyLevelTpl : hierarchyTypeTpl.getHierarchyLevelTplList()) {

					// Creo el HierarchyLevelTpl y lo inserto en el mapa para recuperarlo posteriormente
					HierarchyLevelTpl hierarchyLevelTplNew = new HierarchyLevelTpl();
					hierarchyLevelTplNew.setIdHierarchyLevelTpl(seqnos.execute("wf_nivel_jerarquia_tpl"));
					hierarchyLevelTplNew.setDescription(hierarchyLevelTpl.getDescription());
					hierarchyLevelTplNew.setOrder(hierarchyLevelTpl.getOrder());
					Variable variable = variableService.findAndSaveVariable(hierarchyLevelTpl.getVariable(), dataSource);
					hierarchyLevelTplNew.setVariable(null);
					hierarchyLevelTplNew.setIdVariable(variable.getCodigoVariable());
					hierarchyLevelTplNew.setHierarchyTypeTpl(hierarchyTypeTplSearch);

					hierarchyLevelTplDao.insert(hierarchyLevelTplNew);
					hmHierarchyLevelTpl.put(hierarchyLevelTplNew.getDescription(), hierarchyLevelTplNew);

				}

				// Ordeno la lista de HierarchyItemTpl por el id para insertar los nodos de forma recursiva
				Comparator<HierarchyItemTpl> comparator = new Comparator<HierarchyItemTpl>() {
					public int compare(HierarchyItemTpl o1, HierarchyItemTpl o2) {
						return o1.getIdHierarchyItemTpl().compareTo(o2.getIdHierarchyItemTpl());
					}
				};

				Collections.sort(hierarchyTypeTpl.getHierarchyItemTplList(), comparator);

				// Creo el HierarchyItemTpl y lo inserto
				for (HierarchyItemTpl hierarchyItemTpl : hierarchyTypeTpl.getHierarchyItemTplList()) {

					HierarchyItemTpl hierarchyItemTplNew = new HierarchyItemTpl();
					hierarchyItemTplNew.setIdHierarchyItemTpl(seqnos.execute("wf_item_jerarquia_tpl"));
					hierarchyItemTplNew.setCatalog(hierarchyItemTpl.getCatalog());
					hierarchyItemTplNew.setHierarchyTypeTpl(hierarchyTypeTplSearch);
					hierarchyItemTplNew.setDescription(hierarchyItemTpl.getDescription());
					hierarchyItemTplNew.setLevelValue(hierarchyItemTpl.getLevelValue());
					hierarchyItemTplNew.setHierarchyItemTplList(new ArrayList<HierarchyItemTpl>());
					hierarchyItemTplNew.setHierarchyLevelTpl(hmHierarchyLevelTpl.get(hierarchyItemTpl.getHierarchyLevelTpl().getDescription()));
					hierarchyItemTplNew.setHierarchyUserTplList(new ArrayList<HierarchyUserTpl>());
					hierarchyItemTplNew.setHierarchyItemTplParent(null);
					// Recupero en el mapa los HierarchyItemTpl para sabe cual es el padre
					if (hierarchyItemTpl.getHierarchyItemTplParent() != null) {
						hierarchyItemTplNew.setHierarchyItemTplParent(hmHierarchyItemTpl.get(hierarchyItemTpl.getHierarchyItemTplParent()
								.getDescription()));
					}
					hierarchyItemTplDao.insert(hierarchyItemTplNew);
					hmHierarchyItemTpl.put(hierarchyItemTplNew.getDescription(), hierarchyItemTplNew);

					// Creo el HierarchyUserTpl y lo inserto
					for (HierarchyUserTpl hierarchyUserTpl : hierarchyItemTpl.getHierarchyUserTplList()) {

						User user = userService.findAndSave(hierarchyUserTpl.getUser(), dataSource);
						if (user != null) {
							HierarchyUserTpl hierarchyUserTplNew = new HierarchyUserTpl();
							hierarchyUserTplNew.setIdHierarchyUserTpl(seqnos.execute("wf_usuario_jerarquia_tpl"));
							hierarchyUserTplNew.setHierarchyItemTpl(hierarchyItemTplNew);
							hierarchyUserTplNew.setUser(user);
							User userParent = userService.findAndSave(hierarchyUserTpl.getUser(), dataSource);
							hierarchyUserTplNew.setUserParent(userParent);
							hierarchyUserTplDao.insert(hierarchyUserTplNew);
						}

					}

				}

				hmHierarchyTypeTpl.put(hierarchyTypeTplSearch.getName(), hierarchyTypeTplSearch);

			}

		}
		return hierarchyTypeTplSearch;
	}
}
