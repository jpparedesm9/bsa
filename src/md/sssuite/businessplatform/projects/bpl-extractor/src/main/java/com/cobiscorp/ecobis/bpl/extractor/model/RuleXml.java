package com.cobiscorp.ecobis.bpl.extractor.model;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

@XmlRootElement
public class RuleXml {
	private  List<Rule> rules;

	public List<Rule> getRules() {
		return rules;
	}

	public void setRules(List<Rule> rules) {
		this.rules = rules;
	}
}
