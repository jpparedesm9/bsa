package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by mnaunay on 09/06/2017.
 */
public class Reference extends Synchronizable {
    private String id;
    private String name;
    private String lastName;
    private String phone;
    private String email;
    private String timeToMeet;

    public Reference() {
    }

    public Reference(Builder builder) {
        id = builder.id;
        serverId = builder.serverId;
        name = builder.name;
        lastName = builder.lastName;
        phone = builder.phone;
        email = builder.email;
        timeToMeet = builder.timeToMeet;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTimeToMeet() {
        return timeToMeet;
    }

    public void setTimeToMeet(String timeToMeet) {
        this.timeToMeet = timeToMeet;
    }

    @Override
    public String toString() {
        return name + " " + lastName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Reference reference = (Reference) o;

        return name.equals(reference.name) && (serverId == reference.getServerId());

    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

    public void mergeIdentifiers(Reference old) {
        if (old != null) {
            id = old.getId();
            serverId = old.getServerId();
        }
    }

    public boolean isComplete(){
        boolean isComplete = true;

        if (StringUtils.isEmpty(name)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(lastName)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(phone)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(timeToMeet)) {
            isComplete = false;
        }
        return isComplete;
    }

    public static class Builder {
        private String id;
        private int serverId;
        private String name;
        private String lastName;
        private String phone;
        private String email;
        private String timeToMeet;

        public Builder setServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setLastName(String lastName) {
            this.lastName = lastName;
            return this;
        }

        public Builder setPhone(String phone) {
            this.phone = phone;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setTimeToMeet(String timeToMeet) {
            this.timeToMeet = timeToMeet;
            return this;
        }

        public Builder setId(String id) {
            this.id = id;
            return this;
        }

        public Reference build() {
            return new Reference(this);
        }
    }
}
