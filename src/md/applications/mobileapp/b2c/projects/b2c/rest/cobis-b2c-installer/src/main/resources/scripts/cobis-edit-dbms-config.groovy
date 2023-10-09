import groovy.util.Node;

def config = root."**".find { it.@name == "SQLCTS" }
if(config==null){
	
	def dbmsNode = new Node(null,"dbms",
		[name: "SQLCTS",
		version: "12.5"])
          
	dbmsNode.append(new Node(null, "separator",".."))
	dbmsNode.append(new Node(null, "type","Sql"))
	
	def dataSourceNode = new Node(null, "data-source")
	dataSourceNode.append(new Node(null, "jndi", "jdbc/CTS_BDD_MF"))
	dbmsNode.append(dataSourceNode)
	
	dbmsNode.append(new Node(null, "available-at-startup","true"))
	
	def connectionPoolNode = new Node(null, "connection-pool")
	connectionPoolNode.append(new Node(null, "driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver"))
	connectionPoolNode.append(new Node(null, "url", "jdbc:sqlserver://"+args[1]+":"+args[2]+";databasename=cobis"))
	connectionPoolNode.append(new Node(null, "authentication-alias", "Sql.algncon"))
	connectionPoolNode.append(new Node(null, "initial-connections", "1"))
	connectionPoolNode.append(new Node(null, "max-connections", "20"))
	dbmsNode.append(connectionPoolNode)

	root.append(dbmsNode)
	println "plugin [SYBCTS] added to dbms configuration file"
}