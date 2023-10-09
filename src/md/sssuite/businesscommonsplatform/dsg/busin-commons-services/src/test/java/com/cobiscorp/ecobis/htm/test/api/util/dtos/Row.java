package com.cobiscorp.ecobis.htm.test.api.util.dtos;

import java.util.ArrayList;

public class Row {
	public Row(DataSet rs) {
		container=rs;
		columnValues=new ArrayList<String>();
	}
	
	public void addColumnValue(String value) {
		columnValues.add(value);
	}
	
	public ArrayList<String> getColumNames() {
		return container.getColumnNames();
	}
	
    ArrayList<String> columnValues;
    
    DataSet container;
    
    public String getColName(int columnNumber) {
    	return container.getColumnName(columnNumber);
    }
    
    public String getValue(String columnName) {
    	int colNumber=container.getColumnNumber(columnName);
    	return getValue(colNumber);
    }
    
    public String getValue(int columnNumber) {
    	return columnValues.get(columnNumber);
    }
    
    public ArrayList<String> getValues() {
    	return columnValues;
    }
    
    
}
