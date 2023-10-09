package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadVerificationIndividual;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created by farid on 8/3/2017.
 */
@XmlRootElement(name = "verificationSynchronizedData")
public class VerificationSynchronizationData {

	private int processInstance;
	
	private List<DownloadVerificationIndividual> verification;

	public List<DownloadVerificationIndividual> getVerification() {
		return verification;
	}

	public void setVerification(List<DownloadVerificationIndividual> verification) {
		this.verification = verification;
	}

	public int getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(int processInstance) {
		this.processInstance = processInstance;
	}


}
