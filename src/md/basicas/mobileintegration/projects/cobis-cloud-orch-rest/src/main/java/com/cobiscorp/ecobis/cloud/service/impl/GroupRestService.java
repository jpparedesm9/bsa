package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.map;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createEmptyServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.GroupService;
import com.cobiscorp.ecobis.cloud.service.dto.client.Relation;
import com.cobiscorp.ecobis.cloud.service.dto.client.RelationData;
import com.cobiscorp.ecobis.cloud.service.dto.group.Group;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupData;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupRequestData;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupResponse;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupResult;
import com.cobiscorp.ecobis.cloud.service.dto.group.Member;
import com.cobiscorp.ecobis.cloud.service.dto.group.MemberData;
import com.cobiscorp.ecobis.cloud.service.dto.group.MemberDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.group.MemberDataResponse;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.GroupIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.Function;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

/**
 * @author Cesar Loachamin
 */
@Path("/cobis-cloud/mobile/group")
@Component
@Service({ GroupService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class GroupRestService implements GroupService {

	private final ILogger logger = LogFactory.getLogger(GroupRestService.class);
	private GroupIntegrationService integrationService;
	private CustomerIntegrationService customerService;
	private OfficerIntegrationService officerService;

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
	private ICobisParameter parameterService;

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}

	@Path("/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readGroup(@PathParam("id") int groupId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/readGroup groupId>>" + groupId);
			Group group = Group.fromResponse(integrationService.searchGroup(groupId));
			Member[] members = map(integrationService.searchMembers(groupId), Member.class, new Function<MemberResponse, Member>() {
				@Override
				public Member call(MemberResponse obj) {
					return Member.fromResponse(obj);
				}
			});
			return successResponse(new GroupData(group, members), "/cobis-cloud/mobile/group/readGroup");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/readGroup Error al recuperar información del grupo ", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/readGroup Error al recuperar información del grupo ", e);
			return errorResponse("/cobis-cloud/mobile/group/readGroup Error al recuperar información del grupo ");
		}
	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createGroup(GroupRequestData data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/createGroup Request>>" + objectToJson(data));
			GroupResponse response = new GroupResponse();
			/* Consulta RENAPO */
			if (data.getMembers() != null) {
				try {
					integrationService.setParameterService(parameterService);
					response.setMembers(integrationService.queryRenapo(data.getMembers()));
				} catch (IntegrationException ie) {
					response.setGroup(ie.getResponse());
				}
			}

			if (data.getGroup() != null && data.getGroup().getGroupId() == 0) {
				try {
					GroupRequest groupRequest = fillGroupOfficer(data);
					GroupResult result = integrationService.createGroup(groupRequest);
					response.setGroup(createServiceResponse(result));
				} catch (IntegrationException ie) {
					response.setGroup(ie.getResponse());
				}
			}
			return successResponse(response, "/cobis-cloud/mobile/group/createGroup");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/createGroup Error al crear grupo", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/createGroup Error al crear grupo", e);
			return errorResponse("/cobis-cloud/mobile/group/readGroup Error al crear grupo");
		}
	}

	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateGroup(GroupRequestData data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/updateGroup groupId>>" + objectToJson(data));
			GroupResponse response = new GroupResponse();
			/* Consulta RENAPO */
			if (data.getMembers() != null) {
				try {
					integrationService.setParameterService(parameterService);
					response.setMembers(integrationService.queryRenapo(data.getMembers()));
				} catch (IntegrationException ie) {
					response.setGroup(ie.getResponse());
				}
			}

			if (data.getGroup() != null && data.getGroup().getGroupId() != 0) {
				try {
					GroupRequest groupRequest = fillGroupOfficer(data);
					integrationService.updateGroup(groupRequest);
					response.setGroup(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setGroup(ie.getResponse());
				}
			}
			return successResponse(response, "/cobis-cloud/mobile/group/updateGroup");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/updateGroup Error al actualizar grupo", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/updateGroup Error al actualizar grupo", e);
			return errorResponse("/cobis-cloud/mobile/group/updateGroup Error al actualizar grupo");
		}
	}

	@Path("/{id}/member/{memberId}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response readMember(@PathParam("id") int groupId, @PathParam("memberId") int memberId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/readMember groupId>>" + groupId + " memberId" + memberId);
			Member member = Member.fromResponse(integrationService.searchMember(groupId, memberId));
			if (member == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			CustomerResponse[] relationResponse = integrationService.searchMemberRelation(memberId, groupId);
			member.setRelations(Relation.fromResponse(memberId, relationResponse));
			return successResponse(new MemberData(member), "/cobis-cloud/mobile/group/readMember");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/readMember Error al consultar miembro", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/readMember Error al consultar miembro", e);
			return errorResponse("/cobis-cloud/mobile/group/readMember Error al consultar miembro");
		}
	}

	@Path("/{id}/member")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createMember(@PathParam("id") int groupId, MemberDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/createMember groupId>>" + groupId + " Request>>" + objectToJson(data));

			MemberDataResponse response = new MemberDataResponse();
			ServiceResponse serviceResponse = null;
			if (data.getMember() != null && data.getMember().getCustomerId() != 0) {
				try {
					integrationService.createMember(data.getMember().toRequest(groupId));
					response.setMember(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setMember(ie.getResponse());
				}
			}
			logger.logDebug("data.getRelations" + data.getMember().getRelations());

			if (data.getMember().getRelations() != null) {
				try {

					/*
					 * for (Relation relation : data.getMember().getRelations()) {
					 * 
					 * if (relation.getCustomerId() == 0 && data.getMember() != null) {
					 * relation.setCustomerId(data.getMember().getCustomerId()); } if
					 * (relation.getRelation() != 0) {
					 * serviceResponse=customerService.checkRelationship( relation. toRequest()); }
					 * }
					 */

					if (data.getMember().getCustomerId() != 0) {
						RelationRequest relationMember = new RelationRequest();
						relationMember.setLeft(data.getMember().getCustomerId());
						serviceResponse = customerService.removeAllRelation(relationMember);
					}

					for (RelationData relationData : data.getMember().getRelations()) {
						Relation relation = relationData.toRelation();
						if (relation.getCustomerId() == 0 && data.getMember() != null) {
							relation.setCustomerId(data.getMember().getCustomerId());
						}
						if (relation.getRelation() != 0) {
							serviceResponse = customerService.createRelation(relation.toRequest());
						}
					}

					response.setRelation(serviceResponse);
				} catch (IntegrationException ie) {
					response.setRelation(ie.getResponse());
				}
			}
			return successResponse(response, "/cobis-cloud/mobile/group/createMember");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/createMember Error al crear miembro", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/createMember Error al crear miembro", e);
			return errorResponse("/cobis-cloud/mobile/group/createMember Error al crear miembro");
		}
	}

	@Path("/{id}/member")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateMember(@PathParam("id") int groupId, MemberDataRequest data) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/updateMember groupId>>" + groupId + " Request>>" + objectToJson(data));

			MemberDataResponse response = new MemberDataResponse();
			ServiceResponse serviceResponse = null;
			if (data.getMember() != null && data.getMember().getCustomerId() != 0) {
				try {
					integrationService.updateMember(data.getMember().toRequest(groupId));
					response.setMember(createEmptyServiceResponse());
				} catch (IntegrationException ie) {
					response.setMember(ie.getResponse());
				}
				if (data.getMember().getRelations() != null) {
					try {

						/*
						 * for (Relation relation : data.getMember().getRelations()) {
						 * 
						 * if (relation.getCustomerId() == 0 && data.getMember() != null) {
						 * relation.setCustomerId(data.getMember().getCustomerId ()); } if
						 * (relation.getRelation() != 0) {
						 * serviceResponse=customerService.checkRelationship( relation.toRequest()); } }
						 */

						if (data.getMember().getCustomerId() != 0) {
							RelationRequest relationMember = new RelationRequest();
							relationMember.setLeft(data.getMember().getCustomerId());
							customerService.removeAllRelation(relationMember);
						}
						for (RelationData relationData : data.getMember().getRelations()) {
							Relation relation = relationData.toRelation();
							if (relation.getCustomerId() == 0 && data.getMember() != null) {
								relation.setCustomerId(data.getMember().getCustomerId());
							}
							if (relation.getRelation() != 0) {
								serviceResponse = customerService.createRelation(relation.toRequest());
							}
						}
						response.setRelation(serviceResponse);
					} catch (IntegrationException ie) {
						response.setRelation(ie.getResponse());
					}
				}
			}
			return successResponse(response, "/cobis-cloud/mobile/group/updateMember");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/updateMember Error al actualizar miembro", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/updateMember Error al actualizar miembro", e);
			return errorResponse("/cobis-cloud/mobile/group/updateMember Error al actualizar miembro");
		}
	}

	@Path("/{id}/member/{memberId}")
	@DELETE
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response deleteMember(@PathParam("id") int groupId, @PathParam("memberId") int memberId) {
		try {
			logger.logInfo("/cobis-cloud/mobile/group/deleteMember groupId>>" + groupId + " memberId>>" + memberId);

			integrationService.deleteMember(groupId, memberId);
			return successResponse(createEmptyServiceResponse(), "/cobis-cloud/mobile/group/deleteMember");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/deleteMember Error al eliminar miembro", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/deleteMember Error al eliminar miembro", e);
			return errorResponse("/cobis-cloud/mobile/group/deleteMember Error al eliminar miembro");
		}
	}

	private GroupRequest fillGroupOfficer(GroupRequestData data) {
		GroupRequest groupRequest = data.getGroup().toRequest();
		int officeId = officerService.getOfficeId(SessionUtil.getUser());
		groupRequest.setOfficer(officeId);
		groupRequest.setGroupOffice(officeId);
		return groupRequest;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new GroupIntegrationService(serviceIntegration);
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.officerService = new OfficerIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new GroupIntegrationService(serviceIntegration);
		this.customerService = new CustomerIntegrationService(serviceIntegration);
		this.officerService = new OfficerIntegrationService(serviceIntegration);
	}
}
