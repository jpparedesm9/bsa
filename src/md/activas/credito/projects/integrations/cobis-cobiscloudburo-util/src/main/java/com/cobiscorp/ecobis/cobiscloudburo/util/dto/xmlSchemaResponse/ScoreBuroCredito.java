package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 14/07/2017.
 */
public class ScoreBuroCredito {
    //private ScoreBC scoreBC;
	private List<ScoreBC> scoreBCList;

   
	 public List<ScoreBC> getScoreBCList() {
	        return scoreBCList;
    }

    @XmlElement(name = "ScoreBuroCredito")
    public void setScoreBCList(List<ScoreBC> scoreBCList) {
        this.scoreBCList = scoreBCList;
    }
  
    

    @Override
    public String toString() {
        return "ScoreBuroCredito{" +
                "scoreBCList=" + scoreBCList +
                '}';
    }
    
}
