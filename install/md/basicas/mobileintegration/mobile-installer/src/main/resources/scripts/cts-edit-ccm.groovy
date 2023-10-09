import groovy.util.Node;


class ModifyExtraPackage {
	void addProperty(Node root, Object prop){
		//modify extra property

		def wExtra = root."**".property.find{ it.@name == 'org.osgi.framework.system.packages.extra' }
		def ret = wExtra.@value.split(/,/).toList();
		def wContains = false
		(0..ret.size()-1).each{ i->
			if(ret.get(i).trim().equals(prop)){
				ret.set(i, prop)
				wContains = true
			}else {
				ret.set(i, ret.get(i).trim())
			}
		}
		if(!wContains){
			ret.add(prop)
		}
		def wNewValue = ""
		(0..ret.size()-1).each{ i->
			wNewValue+=ret.get(i)
			if(i != ret.size() -1 ){
				wNewValue +=","
			}

		}

		def wExtra1 = root."**".property.find{ it.@name == 'org.osgi.framework.system.packages.extra' }
		wExtra1.replaceNode{ node ->
			property(name:'org.osgi.framework.system.packages.extra', value:wNewValue){
			}
		}
		//end modify extra property
	}
	void addPropertyToBootDelegation(Node root, Object prop){
		//modify extra property

		def wExtra = root."**".property.find{ it.@name == 'org.osgi.framework.bootdelegation' }
		def ret = wExtra.@value.split(/,/).toList();
		def wContains = false
		(0..ret.size()-1).each{ i->
			if(ret.get(i).trim().contains(prop)){
				ret.set(i, prop)
				wContains = true
			}else {
				ret.set(i, ret.get(i).trim())
			}
		}
		if(!wContains){
			ret.add(prop)
		}
		def wNewValue = ""
		(0..ret.size()-1).each{ i->
			wNewValue+=ret.get(i)
			if(i != ret.size() -1 ){
				wNewValue +=","
			}

		}

		def wExtra1 = root."**".property.find{ it.@name == 'org.osgi.framework.bootdelegation' }
		wExtra1.replaceNode{ node ->
			property(name:'org.osgi.framework.bootdelegation', value:wNewValue){
			}
		}
		//end modify org.osgi.framework.bootdelegation
	}
}



def modEx = new ModifyExtraPackage()

modEx.addProperty(root, "org.apache.logging.log4j");
println "Property [org.apache.logging.log4j] added to the extraPackage"

