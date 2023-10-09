package com.cobiscorp.ecobis.bpl.extractor.model;

import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

@XmlRootElement
@XmlAccessorType(value = XmlAccessType.FIELD)
public class ProcessVersionXml {
	private List<ProcessVersion> processVersionList;

	/**
	 * @return the processVersionList
	 */
	public List<ProcessVersion> getProcessVersionList() {
		return processVersionList;
	}

	/**
	 * @param processVersionList
	 *            the processVersionList to set
	 */
	public void setProcessVersionList(List<ProcessVersion> processVersionList) {
		this.processVersionList = processVersionList;
	}

}
