package com.cobiscorp.ecobis.bpl.service.rules.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Component;
import com.cobiscorp.ecobis.bpl.dao.cobis.ComponentDao;
import com.cobiscorp.ecobis.bpl.dao.rules.TaskViewDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.IdTaskView;
import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;
import com.cobiscorp.ecobis.bpl.service.rules.TaskViewService;
import com.cobiscorp.ecobis.bpl.service.workflow.impl.HierarchyRolServiceImpl;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public class TaskViewServiceImpl implements TaskViewService {

	private TaskViewDao taskViewDao;
	private ActivityDao activityDao;
	private ComponentDao componentDao;

	static Logger log = Logger.getLogger(TaskViewServiceImpl.class);

	/**
	 * @return the taskViewDao
	 */
	public TaskViewDao getTaskViewDao() {
		return taskViewDao;
	}

	/**
	 * @param taskViewDao
	 *            the taskViewDao to set
	 */
	public void setTaskViewDao(TaskViewDao taskViewDao) {
		this.taskViewDao = taskViewDao;
	}

	public ComponentDao getComponentDao() {
		return componentDao;
	}

	public void setComponentDao(ComponentDao componentDao) {
		this.componentDao = componentDao;
	}

	public ActivityDao getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.service.rules.TaskViewService#findTaskViewByProcessVersion(java.lang.Integer, java.lang.Short, java.lang.Integer)
	 */
	public List<TaskView> findTaskViewByProcessVersion(Integer idProcess, Short versionProcess) {
		return taskViewDao.findTaskViewByProcessVersion(idProcess, versionProcess);
	}

	public ProcessVersion setTaskViewToProcessVersion(ProcessVersion processVersion, ProcessVersion newProcessVersion,
			DriverManagerDataSource dataSource) throws Exception {
		List<TaskView> newTaskViewList = new ArrayList<TaskView>();
		try {
			log.debug("TaskView--------------------------------->1");

			List<TaskView> taskViewList = processVersion.getTaskViewList();

			log.debug("TaskView--------------------------------->2");

			for (TaskView taskView : taskViewList) {

				log.debug("TaskView--------------------------------->3" + taskView.getActivity());

				if (taskView.getActivity() != null) {

					log.debug("TaskView--------------------------------->4" + taskView.getActivity());

					TaskView newTaskView = new TaskView();
					SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
					newTaskView.setIdTaskView(seqnos.execute("bpi_task_view"));
					
					Activity activity = activityDao.findAndSaveActivity(taskView.getActivity(), dataSource);

					log.debug("TaskView--------------------------------->5" + activity);
					log.debug("TaskView--------------------------------->6" + taskView.getComponent());

					newTaskView.setActivity(null);
					newTaskView.setIdActivity(activity.getIdActivity());
					if (taskView.getComponent() != null) {
						log.debug("TaskView--------------------------------->7-" + taskView.getComponent());
						log.debug("TaskView--------------------------------->8-" + taskView.getComponent().getIdComponent());
						Component component = componentDao.findAndSaveComponent(taskView.getComponent(), dataSource);
						log.debug("TaskView--------------------------------->9-" + component.getIdComponent());
						newTaskView.setComponent(component);
					}
					if (taskView.getComponentDetail() != null) {
						Component componentDetail = componentDao.findAndSaveComponent(taskView.getComponentDetail(), dataSource);
						newTaskView.setComponentDetail(componentDetail);
					}
					newTaskView.setOrder(taskView.getOrder());
					newTaskView.setIdProcess(newProcessVersion.getProcess().getIdProcess());
					newTaskView.setVersionProcess(newProcessVersion.getVersionProcess());
					newTaskView.setProcessVersion(newProcessVersion);
					newTaskViewList.add(newTaskView);

				}

			}
			newProcessVersion.setTaskViewList(newTaskViewList);
		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo setTaskViewToProcessVersion", ex);
			throw ex;
		}
		return newProcessVersion;
	}

}
