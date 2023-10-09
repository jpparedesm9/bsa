package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.AddresseeDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.HierarchyDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityService;
import com.cobiscorp.ecobis.bpl.service.workflow.AddresseeService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyTypeTplService;
import com.cobiscorp.ecobis.bpl.service.workflow.LoadBalanceService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProgramService;
import com.cobiscorp.ecobis.bpl.service.workflow.RoleService;
import com.cobiscorp.ecobis.bpl.service.workflow.UserService;
import com.cobiscorp.ecobis.bpl.util.RuleQueryManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.HierarchyTypeTpl;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdAddressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LoadBalance;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Role;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.User;

public class AddresseeServiceImpl implements AddresseeService {

	private AddresseeDao addresseeDao;
	private ActivityService activityService;
	private RoleService roleService;
	private LoadBalanceService loadBalanceService;
	private ProcessVariableService processVariableService;
	private UserService userService;
	private HierarchyTypeTplService hierarchyTypeTplService;
	private HierarchyDao hierarchyDao;
	private ProgramService programService;

	static Logger log = Logger.getLogger(AddresseeServiceImpl.class);

	/**
	 * @return the addresseeDao
	 */
	public AddresseeDao getAddresseeDao() {
		return addresseeDao;
	}

	/**
	 * @return the activityService
	 */
	public ActivityService getActivityService() {
		return activityService;
	}

	/**
	 * @param activityService
	 *            the activityService to set
	 */
	public void setActivityService(ActivityService activityService) {
		this.activityService = activityService;
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
	 * @return the loadBalanceService
	 */
	public LoadBalanceService getLoadBalanceService() {
		return loadBalanceService;
	}

	/**
	 * @param loadBalanceService
	 *            the loadBalanceService to set
	 */
	public void setLoadBalanceService(LoadBalanceService loadBalanceService) {
		this.loadBalanceService = loadBalanceService;
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
	 * @param addresseeDao
	 *            the addresseeDao to set
	 */
	public void setAddresseeDao(AddresseeDao addresseeDao) {
		this.addresseeDao = addresseeDao;
	}

	/**
	 * @return the hierarchyTypeTplService
	 */
	public HierarchyTypeTplService getHierarchyTypeTplService() {
		return hierarchyTypeTplService;
	}

	/**
	 * @param hierarchyTypeTplService
	 *            the hierarchyTypeTplService to set
	 */
	public void setHierarchyTypeTplService(HierarchyTypeTplService hierarchyTypeTplService) {
		this.hierarchyTypeTplService = hierarchyTypeTplService;
	}

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

	/**
	 * @return the programService
	 */
	public ProgramService getProgramService() {
		return programService;
	}

	/**
	 * @param programService
	 *            the programService to set
	 */
	public void setProgramService(ProgramService programService) {
		this.programService = programService;
	}

	public List<Addressee> findAddresseeByProcessVersion(Integer idProcess, Short versionProcess) {
		return addresseeDao.findAddresseeByProcessVersion(idProcess, versionProcess);
	}

	public void buildAdressee(ProcessVersion processVersionOrigin, ProcessVersion processVersioDestination, DriverManagerDataSource dataSource,
			ApplicationContext context) throws Exception {

		try {

			for (Addressee addressee : processVersionOrigin.getAddresseeList()) {

				log.debug("Type--------------------------------->" + addressee.getType() + "Name: ");

				Addressee addresseeNew = new Addressee();
				addresseeNew.setIdRoleAddressee(addressee.getIdRoleAddressee());
				addresseeNew.setRequirementLogUser(addressee.getRequirementLogUser());
				addresseeNew.setType(addressee.getType());
				addresseeNew.setLoadBalanceType(addressee.getLoadBalanceType());
				addresseeNew.setLoadBalanceOfficeType(addressee.getLoadBalanceOfficeType());
				addresseeNew.setThreadVersion(addressee.getThreadVersion());
				addresseeNew.setIdProcess(processVersioDestination.getProcess().getIdProcess());
				addresseeNew.setVersionProcess(processVersioDestination.getVersionProcess());
				addresseeNew.setProcessVersion(processVersioDestination);
				addresseeNew.setIdAddressees(0);

				log.debug("Addressee--------------------------------->1");
				Activity activity = activityService.findAndSave(addressee.getActivity(), dataSource);
				log.debug("Addressee--------------------------------->2");
				addresseeNew.setActivity(null);
				addresseeNew.setIdActivity(activity.getIdActivity());
				log.debug("Addressee--------------------------------->3");
				if (addressee.getRoleWF() != null) {
					log.debug("Addressee--------------------------------->4" + addressee.getRoleWF().getName());
					Role role = roleService.findAndSave(addressee.getRoleWF(), dataSource);
					log.debug("Addressee--------------------------------->5");
					addresseeNew.setRoleWF(role);
					log.debug("Addressee--------------------------------->6");
				}
				log.debug("Addressee--------------------------------->7");
				if (addressee.getLoadBalance() != null) {
					log.debug("Addressee--------------------------------->8" + addressee.getLoadBalance().getName());
					LoadBalance loadBalance = loadBalanceService.findAndSave(addressee.getLoadBalance(), dataSource);
					addresseeNew.setLoadBalance(null);
					addresseeNew.setIdLoadBalance(loadBalance.getIdLoadBalance());
					log.debug("Addressee--------------------------------->9");
				}
				log.debug("Addressee--------------------------------->10");
				addresseeNew.setIdAddressee(new IdAddressee(processVersioDestination.getProcess().getIdProcess(), processVersioDestination
						.getVersionProcess(), activity.getIdActivity()));
				log.debug("Addressee--------------------------------->11");

				if (addresseeNew.getType().equals("PRO")) {
					log.debug("Addressee--------------------------------->12" + addressee.getPrograma().getNombrePrograma());
					Programa programa = programService.findAndSaveProgram(addressee.getPrograma(), dataSource);
					addresseeNew.setIdAddressees(programa.getIdPrograma());
					log.debug("Addressee--------------------------------->13");

				} else if (addresseeNew.getType().equals("ROL")) {
					log.debug("Addressee--------------------------------->14" + addressee.getRole().getName());
					Role r = roleService.findAndSave(addressee.getRole(), dataSource);
					addresseeNew.setIdAddressees(r.getIdRole());
					log.debug("Addressee--------------------------------->15");

				} else if (addresseeNew.getType().equals("JEU")) {
					log.debug("Addressee--------------------------------->16");
					if (addressee.getHierarchyTypeTpl() != null) {
						HierarchyTypeTpl hierarchyTypeTpl = hierarchyTypeTplService.findAndSave(addressee.getHierarchyTypeTpl(), dataSource);
						addresseeNew.setIdAddressees(hierarchyTypeTpl.getIdHierarchyTypeTpl());
					}
					log.debug("Addressee--------------------------------->17");
				} else if (addresseeNew.getType().equals("USR")) {
					log.debug("Addressee--------------------------------->18" + addressee.getUser().getLogin());
					User user = userService.findAndSave(addressee.getUser(), dataSource);
					addresseeNew.setIdAddressees(user.getIdUser());
					log.debug("Addressee--------------------------------->19");

				} else if (addresseeNew.getType().equals("JER")) {
					// Se actualiza al ultimo
					log.debug("Addressee--------------------------------->20");
				} else if (addresseeNew.getType().equals("COM")) {
					log.debug("Addressee--------------------------------->21" + addressee.getRole().getName());
					Role r = roleService.findAndSave(addressee.getRole(), dataSource);
					addresseeNew.setIdAddressees(r.getIdRole());
					log.debug("Addressee--------------------------------->21");

				} else if (addresseeNew.getType().equals("POL")) {
					log.debug("----------------------------------------------->23");
					if (addressee.getIdAddressees() != 0) {
						log.debug("----------------------------------------------->24" + addressee.getRule().getName());
						Rule rule = RuleQueryManager.saveRuleBdd(addressee.getRule(), context, dataSource);
						log.debug("----------------------------------------------->25");
						addresseeNew.setIdAddressees(rule.getId());
						log.debug("----------------------------------------------->26");
					}

				}
				log.debug("----------------------------------------------->27");
				processVersioDestination.getAddresseeList().add(addresseeNew);

			}

		} catch (Exception e) {
			log.error("Error al ejecutar el metodo buildAdressee", e);
			throw new Exception(e);
		}

	}

	public void updateAddress(Process process, ProcessVersion processVersion, ProcessVersion searchedProcessVersion) throws Exception {

		for (Addressee addressee : processVersion.getAddresseeList()) {
			if (addressee.getType().equals("JER")) {
				Addressee addresseeSearch = addresseeDao.findAddresseeByProcessVersionActivity(process.getIdProcess(),
						searchedProcessVersion.getVersionProcess(), addressee.getActivity().getName());
				Hierarchy hierarchy = hierarchyDao.findHierarchyByProcessVersionAndName(process.getIdProcess(),
						searchedProcessVersion.getVersionProcess(), addressee.getHierarchy().getName());
				if (addresseeSearch != null && hierarchy != null) {
					log.debug("Entro a actualizar----------------------------------------------------->1");
					addresseeSearch.setIdAddressees(hierarchy.getIdHierarchy());
					log.debug("Entro a actualizar----------------------------------------------------->2");
					addresseeDao.update(addresseeSearch);
					log.debug("Entro a actualizar----------------------------------------------------->3");
				}

			}
		}

	}
}
