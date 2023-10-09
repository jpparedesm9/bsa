package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import javax.xml.bind.annotation.XmlRootElement;

import com.cobiscorp.ecobis.cloud.service.dto.group.GroupData;

/**
 * Created by farid on 7/24/2017.
 */
@XmlRootElement(name = "groupSynchronizedData")
public class GroupSynchronizationData {
    private GroupData group;

    public GroupSynchronizationData() {
    }

    public GroupData getGroup() {
        return group;
    }

    public void setGroup(GroupData group) {
        this.group = group;
    }
}
