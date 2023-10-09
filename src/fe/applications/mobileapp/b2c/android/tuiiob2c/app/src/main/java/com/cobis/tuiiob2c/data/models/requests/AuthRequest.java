package com.cobis.tuiiob2c.data.models.requests;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class AuthRequest {

    @SerializedName("username")
    @Expose
    private String username;
    @SerializedName("password")
    @Expose
    private String password;
    @SerializedName("culture")
    @Expose
    private String culture;

    /**
     * No args constructor for use in serialization
     *
     */
    public AuthRequest() {
    }

    /**
     *
     * @param username
     * @param password
     * @param culture
     */
    public AuthRequest(String username, String password, String culture) {
        super();
        this.username = username;
        this.password = password;
        this.culture = culture;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCulture() {
        return culture;
    }

    public void setCulture(String culture) {
        this.culture = culture;
    }

}