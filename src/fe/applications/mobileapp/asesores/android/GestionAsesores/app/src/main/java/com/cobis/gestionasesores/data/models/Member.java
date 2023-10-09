package com.cobis.gestionasesores.data.models;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.enums.PositionGroup;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public class Member extends Synchronizable implements Comparable<Member> {
    private int localSpouseId;
    private String rfc;
    private String name;
    private String position;
    private int cycleInGroup;
    private String customerNumber;
    private String voluntarySaving;
    private String riskLevel;
    private String meetingLocation;
    private List<MemberRelation> relationships;
    private boolean syncedToServer;

    private Member(Builder builder) {
        localSpouseId = builder.localSpouseId;
        rfc = builder.rfc;
        name = builder.name;
        position = builder.position;
        cycleInGroup = builder.cycleInGroup;
        customerNumber = builder.customerNumber;
        voluntarySaving = builder.voluntarySaving;
        riskLevel = builder.riskLevel;
        meetingLocation = builder.meetingLocation;
        syncedToServer = builder.syncedToServer;
        relationships = builder.relationships;
        setServerId(builder.serverId);
    }

    public List<MemberRelation> getRelationships() {
        return relationships;
    }

    public String getRfc() {
        return rfc;
    }

    public String getName() {
        return name;
    }

    public void updateRfc(String rfc) {
        this.rfc = rfc;
    }

    public void updateName(String name) {
        this.name = name;
    }

    @PositionGroup
    public String getPosition() {
        return position;
    }

    @Override
    public int compareTo(@NonNull Member o) {
        return this.getName().compareTo(o.getName());
    }

    public void setMeetingLocation(String meetingLocation) {
        this.meetingLocation = meetingLocation;
    }

    public int getCycleInGroup() {
        return cycleInGroup;
    }

    public String getCustomerNumber() {
        return customerNumber;
    }

    public String getVoluntarySaving() {
        return voluntarySaving;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public String getMeetingLocation() {
        return meetingLocation;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public boolean isSyncedToServer() {
        return syncedToServer;
    }

    public void setSyncedToServer(boolean syncedToServer) {
        this.syncedToServer = syncedToServer;
    }

    public void setLocalSpouseId(int localSpouseId) {
        this.localSpouseId = localSpouseId;
    }

    public int getLocalSpouseId() {
        return localSpouseId;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public void setCycleInGroup(int cycleInGroup) {
        this.cycleInGroup = cycleInGroup;
    }

    public void setCustomerNumber(String customerNumber) {
        this.customerNumber = customerNumber;
    }

    @Override
    public String toString() {
        return name;
    }

    public void addMemberRelation(MemberRelation relation) {
        if (relationships == null) {
            relationships = new ArrayList<>();
            relationships.add(relation);
        } else {
            boolean isFound = false;
            for (int i = 0; i < relationships.size(); i++) {
                if (relationships.get(i).getCustomerId() == relation.getCustomerId()) {
                    relationships.set(i, relation);
                    isFound = true;
                    break;
                }
            }
            if(!isFound){
                relationships.add(relation);
            }
        }
    }

    public void removeMemberRelation(int relationId){
        if(relationships != null){
            for (Iterator<MemberRelation> iterator = relationships.iterator(); iterator.hasNext(); ) {
                MemberRelation memberRelation = iterator.next();
                if (relationId == memberRelation.getCustomerId()) {
                    iterator.remove();
                }
            }
        }
    }

    public void merge(Member otherMember){
        rfc = otherMember.rfc;
        name = otherMember.name;
        position = otherMember.position;
        cycleInGroup = otherMember.cycleInGroup;
        customerNumber = otherMember.customerNumber;
        voluntarySaving = otherMember.voluntarySaving;
        riskLevel = otherMember.riskLevel;
        meetingLocation = otherMember.meetingLocation;

        List<MemberRelation> newRelations = new ArrayList<>();
        if (otherMember.relationships != null) {
            newRelations.addAll(otherMember.relationships);
        }

        relationships = newRelations;
    }

    public static class Builder {
        private int serverId;
        private int localSpouseId;
        private String rfc;
        private String name;
        private String position;
        private int cycleInGroup;
        private String customerNumber;
        private String voluntarySaving;
        private String riskLevel;
        private String meetingLocation;
        private List<MemberRelation> relationships;
        private boolean syncedToServer;

        public Builder addServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }

        public Builder addSyncedToServer(boolean syncedToServer) {
            this.syncedToServer = syncedToServer;
            return this;
        }

        public Builder addRfc(String rfc) {
            this.rfc = rfc;
            return this;
        }

        public Builder addName(String name) {
            this.name = name;
            return this;
        }

        public Builder addPosition(String position) {
            this.position = position;
            return this;
        }

        public Builder addCycleInGroup(int cycleInGroup) {
            this.cycleInGroup = cycleInGroup;
            return this;
        }

        public Builder addCustomerNumber(String customerNumber) {
            this.customerNumber = customerNumber;
            return this;
        }

        public Builder addVoluntarySaving(String voluntarySaving) {
            this.voluntarySaving = voluntarySaving;
            return this;
        }

        public Builder addRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Builder addMeetingLocation(String meetingLocation) {
            this.meetingLocation = meetingLocation;
            return this;
        }

        public Builder addRelationships(List<MemberRelation> relationships) {
            this.relationships = relationships;
            return this;
        }

        public Builder addLocalSpouseId(int localSpouseId) {
            this.localSpouseId = localSpouseId;
            return this;
        }

        public Member build() {
            return new Member(this);
        }
    }
}