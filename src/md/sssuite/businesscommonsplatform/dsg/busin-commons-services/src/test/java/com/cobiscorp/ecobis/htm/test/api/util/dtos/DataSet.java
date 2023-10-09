package com.cobiscorp.ecobis.htm.test.api.util.dtos;

import java.util.ArrayList;

public class DataSet {
	ArrayList<String> columnNames;
	ArrayList<Row> rows;
	
	public DataSet() {
		this.columnNames=new ArrayList<String>();
	}
	
	public String getColumnName(int colNumber) {
		return columnNames.get(colNumber);
	}
	
	public void addColumnName(String name) {
		columnNames.add(name);
	}
	
	public ArrayList<String> getColumnNames() {
		return columnNames;
	}
	
	public int getColumnNumber(String colName) {
		for (int i=0; i< columnNames.size(); i++) if (colName.equals(columnNames.get(i))) return i; 
		return -1;
	}
	
	public void setRows(ArrayList<Row> rows){
	    this.rows=rows;	
	}
		
	public ArrayList<Row> getRows() {
		return rows;
	}

	public String getData(int rowNumber, String colName) {
		int colNumber=getColumnNumber(colName);
		return getData(rowNumber,colNumber);
	}

	
	public String getData(int rowNumber, int colNumber) {
		if (colNumber> columnNames.size()) return null;
		if (rowNumber> rows.size()) return null;
		
		return rows.get(rowNumber).getValue(colNumber);
	}
}
