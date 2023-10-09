package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;


import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification.DownloadVerification;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "verificationGroupSynchronizedData")
public class VerificationGroupSynchronizationData {
    private int groupId;
    private String name;
    private int processInstance;
    private List<DownloadVerification> verification;

    public List<DownloadVerification> getVerification() {
        return verification;
    }

    public void setVerification(List<DownloadVerification> verification) {
        this.verification = verification;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
    }
}
