package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.SyncStatus;

/**
 * Represent a Credit application request
 * Created by mnaunay on 22/06/2017.
 */
public abstract class CreditApp extends Synchronizable {
    private int id;
    private String applicantName;
    private int applicantId;
    private Long creationDate;
    private double amount;
    @CreditAppType
    private String type;
    private String warningMessage;
    private boolean inProcess;

    protected CreditApp(@CreditAppType String type) {
        this.type = type;
    }

    protected CreditApp(InternalBuilder builder) {
        id = builder.id;
        applicantName = builder.applicantName;
        applicantId = builder.applicantId;
        creationDate = builder.creationDate;
        amount = builder.amount;
        type = builder.type;
        status = builder.status;
        serverId = builder.serverId;
    }


    public boolean isInProcess() {
        return inProcess;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setApplicantId(int applicantId) {
        this.applicantId = applicantId;
    }

    public int getId() {
        return id;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public int getApplicantId() {
        return applicantId;
    }

    public Long getCreationDate() {
        return creationDate;
    }

    public double getAmount() {
        return amount;
    }

    public @CreditAppType String getType() {
        return type;
    }

    public String getWarningMessage() {
        return warningMessage;
    }

    public void setWarningMessage(String warningMessage) {
        this.warningMessage = warningMessage;
    }

    public void setInProcess(boolean inProcess) {
        this.inProcess = inProcess;
    }

    public static class InternalBuilder<T extends InternalBuilder> {
        private int id;
        private String applicantName;
        private int applicantId;
        private Long creationDate;
        private double amount;
        private String type;
        private int status;
        private int serverId;
        private String warningMessage;
        private boolean inProcess;

        InternalBuilder(CreditApp creditApp) {
            id = creditApp.getId();
            serverId = creditApp.serverId;
            type = creditApp.getType();
            applicantName = creditApp.getApplicantName();
            applicantId = creditApp.getApplicantId();
            creationDate = creditApp.getCreationDate();
            amount = creditApp.getAmount();
            status = creditApp.getStatus();
            warningMessage = creditApp.getWarningMessage();
            inProcess = creditApp.inProcess;
        }

        InternalBuilder(@CreditAppType String creditAppType) {
            id = -1;
            serverId = 0;
            applicantId = -1;
            type = creditAppType;
            status = SyncStatus.DRAFT;
            warningMessage = null;
            inProcess = false;
        }

        public T setId(int id) {
            this.id = id;
            return (T) this;
        }

        public T setApplicantName(String applicantName) {
            this.applicantName = applicantName;
            return (T) this;
        }

        public T setApplicantId(int applicantId) {
            this.applicantId = applicantId;
            return (T) this;
        }

        public T setCreationDate(Long creationDate) {
            this.creationDate = creationDate;
            return (T) this;
        }

        public T setServerId(int serverId) {
            this.serverId = serverId;
            return (T) this;
        }

        public T setAmount(double amount) {
            this.amount = amount;
            return (T) this;
        }

        public T setInProcess(boolean inProcess) {
            this.inProcess = inProcess;
            return (T) this;
        }

        public T setWarningMessage(String warningMessage) {
            this.warningMessage = warningMessage;
            return (T) this;
        }
    }
}
