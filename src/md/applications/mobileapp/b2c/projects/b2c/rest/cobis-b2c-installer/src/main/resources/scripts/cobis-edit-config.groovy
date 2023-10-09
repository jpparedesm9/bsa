import groovy.util.Node;

def config = root."**".find { it.@name == "cts-authorization-resources" }
if(config==null){
	def plugin= new Node(null,"plugin",
		[ name: "cts-authorization-resources",
          path: "../plugins/framework/cts/cts-authorization-resources-1.0.19.1.jar"])

	def general = root."*".find { it.name = "general" }
	general.append(plugin)
	println "plugin [cts-authorization-resources] added to config configuration file"
} else {
	config.@path="../plugins/framework/cts/cts-authorization-resources-1.0.19.1.jar"
}