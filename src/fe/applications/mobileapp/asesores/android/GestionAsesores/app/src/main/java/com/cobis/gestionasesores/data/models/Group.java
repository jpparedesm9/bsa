package com.cobis.gestionasesores.data.models;

import android.support.annotation.NonNull;
import android.util.SparseArray;

import com.cobis.gestionasesores.data.enums.SyncStatus;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by mnaunay on 15/06/2017.
 */

public class Group extends Synchronizable {
    private int id;
    private int number;
    private String name;
    private int cycle;
    private String adviser;
    private String branchOffice;
    private String dayMeeting;
    private Long timeMeeting;
    private List<Member> members;
    private boolean canEditMembers;

    private Group(Builder builder) {
        id = builder.id;
        number = builder.number;
        name = builder.name;
        cycle = builder.cycle;
        adviser = builder.adviser;
        branchOffice = builder.branchOffice;
        dayMeeting = builder.dayMeeting;
        timeMeeting = builder.timeMeeting;
        members = builder.members;
        status = builder.status;
        canEditMembers = builder.canEditMembers;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public int getNumber() {
        return number;
    }

    public String getName() {
        return name;
    }

    public int getCycle() {
        return cycle;
    }

    public String getAdviser() {
        return adviser;
    }

    public String getBranchOffice() {
        return branchOffice;
    }

    public String getDayMeeting() {
        return dayMeeting;
    }

    public Long getTimeMeeting() {
        return timeMeeting;
    }

    public List<Member> getMembers() {
        return members;
    }

    public boolean canEditMembers() {
        return canEditMembers;
    }

    public void setMembers(List<Member> members) {
        this.members = members;
    }

    public void setCanEditMembers(boolean canEditMembers) {
        this.canEditMembers = canEditMembers;
    }

    public boolean isPersonMember(@NonNull Person person) {
        if (members == null) return false;
        boolean contains = false;
        for (Member m : members) {
            if (m.getServerId() == person.getServerId()) {
                contains = true;
                break;
            }
        }
        return contains;
    }

    public boolean containsMember(@NonNull Member member) {
        if (members == null) return false;
        boolean contains = false;
        for (Member m : members) {
            if (m.getServerId() == member.getServerId()) {
                contains = true;
                break;
            }
        }
        return contains;
    }

    public void removeMember(Member member) {
        if (members != null) {
            for (Iterator<Member> iterator = members.iterator(); iterator.hasNext(); ) {
                Member m = iterator.next();
                if (m.getServerId() == member.getServerId()) {
                    iterator.remove();
                }
            }
        }
    }

    public void merge(Group otherGroup) {
        number = otherGroup.number;
        name = otherGroup.name;
        cycle = otherGroup.cycle;
        adviser = otherGroup.adviser;
        branchOffice = otherGroup.branchOffice;
        dayMeeting = otherGroup.dayMeeting;
        timeMeeting = otherGroup.timeMeeting;
        canEditMembers = otherGroup.canEditMembers;

        //We cant take remote members since the service that obtains group doesnt bring all member information
        /*SparseArray<Member> currentMembers = new SparseArray<>();
        if (members != null) {
            for (Member member : members) {
                currentMembers.put(member.getServerId(), member);
            }
        }

        List<Member> newMembers = new ArrayList<>();
        if (otherGroup.members != null) {
            newMembers.addAll(otherGroup.members);
        }

        for (int i = 0; i < newMembers.size(); i++) {
            if (currentMembers.get(newMembers.get(i).getServerId()) != null) {
                newMembers.set(i, currentMembers.get(newMembers.get(i).getServerId()));
            }
        }

        members = newMembers;*/
        members = otherGroup.members;
    }

    public static class Builder {
        private int id = -1;
        private int number;
        private String name;
        private int cycle;
        private String adviser;
        private String branchOffice;
        private String dayMeeting;
        private Long timeMeeting;
        private List<Member> members;
        @SyncStatus
        private int status = SyncStatus.DRAFT;
        private boolean canEditMembers = true;

        public Builder setId(int id) {
            this.id = id;
            return this;
        }

        public Builder setNumber(int number) {
            this.number = number;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setCycle(int cycle) {
            this.cycle = cycle;
            return this;
        }

        public Builder setAdviser(String adviser) {
            this.adviser = adviser;
            return this;
        }

        public Builder setBranchOffice(String branchOffice) {
            this.branchOffice = branchOffice;
            return this;
        }

        public Builder setDayMeeting(String dayMeeting) {
            this.dayMeeting = dayMeeting;
            return this;
        }

        public Builder setTimeMeeting(Long timeMeeting) {
            this.timeMeeting = timeMeeting;
            return this;
        }

        public Builder setMembers(List<Member> members) {
            this.members = members;
            return this;
        }

        public Builder setStatus(int status) {
            this.status = status;
            return this;
        }

        public Builder setCanEditMembers(boolean canEditMembers) {
            this.canEditMembers = canEditMembers;
            return this;
        }

        public Group build() {
            return new Group(this);
        }
    }
}
