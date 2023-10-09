package com.cobis.gestionasesores.data.models;

import java.io.File;

import javax.activation.DataSource;
import javax.activation.FileDataSource;

/**
 * Created by bqtdesa02 on 7/17/2017.
 */

public class Attachment {

    private String fileName;
    private DataSource dataSource;

    public Attachment(String filepath) {
        this.fileName = (new File(filepath)).getName();
        this.dataSource =  new FileDataSource(filepath);
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public DataSource getDataSource() {
        return dataSource;
    }

}
