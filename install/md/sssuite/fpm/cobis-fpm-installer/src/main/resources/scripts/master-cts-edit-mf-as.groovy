import groovy.util.Node;

config = root."**".config.find { it.@name == "ExtractorManager" }
if(config==null){
	def nodeCache= new Node(null,"config",
		[ name: "ExtractorManager",
			description:"Extractors manager",
			interface:"com.cobiscorp.ecobis.fpm.extractors.administration.service.IExtractorManager",
			linked:"false",
			path:"services-as/fpm/config-extractor.xml"])
		root.append(nodeCache)
		println "config [ExtractorManager] added to config configuration file"
}

config = root."**".config.find { it.@name == "DefaultValuesManager" }
if(config==null){
	def nodeConfig= new Node(null,"config",
		[ name: "DefaultValuesManager",
			description:"Default values",
			interface:"com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager",
			linked:"false",
			path:"services-as/fpm/config-default-parameters.xml"])
		root.append(nodeConfig)
		println "config [DefaultValuesManager] added to config configuration file"
}