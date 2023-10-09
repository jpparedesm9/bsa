package com.cobis.gestionasesores.data.models;

import java.util.HashMap;

/**
 * Created by MNAUNAY on 21/07/2016.
 */
public class TraceReport {
        private String[] mTo;
        private String mFrom;
        private String[] mBcc;
        private String mSubject;
        private HashMap<String, Object> mData;
        private String mAccount;
        private String mAccountPassword;


    public String[] getTo() {
        return mTo;
    }

    public void setTo(String[] to) {
        this.mTo = to;
    }

    public String getFrom() {
        return mFrom;
    }

    public void setFrom(String from) {
        this.mFrom = from;
    }

    public String[] getBcc() {
        return mBcc;
    }

    public void setBcc(String[] bcc) {
        this.mBcc = bcc;
    }

    public String getSubject() {
        return mSubject;
    }

    public void setSubject(String subject) {
        this.mSubject = subject;
    }

    public HashMap<String, Object> getData() {
        return mData;
    }

    public void setData(HashMap<String, Object> data) {
        this.mData = data;
    }

    public void addItemData(String key, Object value) {
        if (mData == null) {
            mData = new HashMap<>();
        }
        mData.put(key, value);
    }

    public String getAccount() {
        return mAccount;
    }

    public void setAccount(String account) {
        mAccount = account;
    }

    public String getAccountPassword() {
        return mAccountPassword;
    }

    public void setAccountPassword(String accountPassword) {
        mAccountPassword = accountPassword;
    }

    public final class TraceData {
        public static final String COMMENT = "#comment";
        public static final String DEVICE_MODEL = "#device_model";
        public static final String DEVICE_OS = "#device_os";
        public static final String APP_VERSION = "#app_version";
        private TraceData() {
        }
    }
}
