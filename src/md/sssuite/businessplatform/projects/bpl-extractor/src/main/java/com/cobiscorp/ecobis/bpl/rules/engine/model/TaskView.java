package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Component;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Entity
@Table(name = "bpi_task_view", schema = "cob_pac")
public class TaskView implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "tv_id")
	private Integer idTaskView;

	@Column(name = "tv_process_id")
	private Integer idProcess;

	@Column(name = "tv_version_id")
	private Short versionProcess;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "tv_component_id")
	private Component component;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "tv_component_detail_id")
	private Component componentDetail;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "tv_task_id", referencedColumnName = "ac_codigo_actividad", insertable = false, updatable = false)
	private Activity activity;

	@Column(name = "tv_task_id")
	private Integer idActivity;

	@Column(name = "tv_order")
	private Integer order;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "tv_process_id", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "tv_version_id", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	public TaskView() {

	}

	/**
	 * @return the idTaskView
	 */
	public Integer getIdTaskView() {
		return idTaskView;
	}

	/**
	 * @param idTaskView
	 *            the idTaskView to set
	 */
	public void setIdTaskView(Integer idTaskView) {
		this.idTaskView = idTaskView;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the versionProcess
	 */
	public Short getVersionProcess() {
		return versionProcess;
	}

	/**
	 * @param versionProcess
	 *            the versionProcess to set
	 */
	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the component
	 */
	public Component getComponent() {
		return component;
	}

	/**
	 * @param component
	 *            the component to set
	 */
	public void setComponent(Component component) {
		this.component = component;
	}

	/**
	 * @return the componentDetail
	 */
	public Component getComponentDetail() {
		return componentDetail;
	}

	/**
	 * @param componentDetail
	 *            the componentDetail to set
	 */
	public void setComponentDetail(Component componentDetail) {
		this.componentDetail = componentDetail;
	}

	/**
	 * @return the activity
	 */
	public Activity getActivity() {
		return activity;
	}

	/**
	 * @param activity
	 *            the activity to set
	 */
	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	public ProcessVersion getProcessVersion() {
		return processVersion;
	}

	public void setProcessVersion(ProcessVersion processVersion) {
		this.processVersion = processVersion;
	}

	public Integer getIdActivity() {
		return idActivity;
	}

	public void setIdActivity(Integer idActivity) {
		this.idActivity = idActivity;
	}

	/**
	 * @return the order
	 */
	public Integer getOrder() {
		return order;
	}

	/**
	 * @param order
	 *            the order to set
	 */
	public void setOrder(Integer order) {
		this.order = order;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idTaskView == null) ? 0 : idTaskView.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TaskView other = (TaskView) obj;
		if (idTaskView == null) {
			if (other.idTaskView != null)
				return false;
		} else if (!idTaskView.equals(other.idTaskView))
			return false;
		return true;
	}

}