package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.Query;

public class BaseDAOImpl {
	// private static ILogger logger = LogFactory.getLogger(BaseDaoImpl.class);

	protected EntityManager entityManager;

	public BaseDAOImpl() {

	}

	public <T> T getSingleResult(String namedQuery,
			Map<String, Object> parametersMap, Class<T> resultType) {
		T result = null;
		List<T> resultList = getResultList(namedQuery, parametersMap,
				resultType);
		if (resultList != null && resultList.size() == 1) {
			result = resultList.get(0);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> getResultList(String namedQuery,
			Map<String, Object> parameterMap, Class<T> resultType) {
		List<T> resultList = null;
		Query query = this.entityManager.createNamedQuery(namedQuery,
				resultType);
		if (parameterMap != null && !parameterMap.isEmpty()) {
			Set<String> keyList = parameterMap.keySet();
			for (String key : keyList) {
				query.setParameter(key, parameterMap.get(key));
			}
		}
		resultList = (List<T>) query.getResultList();
		return resultList;
	}

}