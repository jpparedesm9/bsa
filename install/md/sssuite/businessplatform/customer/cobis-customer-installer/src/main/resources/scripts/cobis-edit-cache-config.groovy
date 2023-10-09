import groovy.util.Node;

def config = root."**".find { it.@name == "BalanceCatalogs" }
if(config==null){
	def nodeCache= new Node(null,"cache",
		[ name: "BalanceCatalogs",
          maxElementsInMemory: "3000",
          maxElementsOnDisk: "4000",
          eternal: "false",
          timeToIdleSeconds: "7200",
          timeToLiveSeconds: "7200",
          overflowToDisk:"false",
          diskSpoolBufferSizeMB: "30",
          diskPersistent: "false",
          diskExpiryThreadIntervalSeconds: "900",
          memoryStoreEvictionPolicy:"LRU"])
    nodeCache.append( new Node(null, "cacheEventListenerFactory",
                               [ class:"com.cobiscorp.cobis.cache.impl.COBISCacheEventListenerFactory"]))
		root.append(nodeCache)
		println "config [BalanceCatalogs] added to config configuration file"
}
