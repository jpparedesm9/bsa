/*
 * Archivo: T_FLCRE_09_ERFAN09.java
 * Fecha: 2016-03-23T23:14:55Z
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */
package com.cobiscorp.cobis.busin.services;

import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.References;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.designer.transaction.dto.QueryExecByEntitiesRequest;
import cobiscorp.ecobis.designer.transaction.dto.QueryExecByQueryIdRequest;
import cobiscorp.ecobis.designer.transaction.dto.QueryExecResponse;
import cobiscorp.ecobis.designer.transaction.dto.TransactionRequest;
import cobiscorp.ecobis.designer.transaction.dto.TransactionResponse;

import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.DynamicResponse;
import com.cobiscorp.designer.api.builder.FormEventBuilder;
import com.cobiscorp.designer.api.builder.QueryEventBuilder;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
import com.cobiscorp.designer.api.customization.ILoadCatalogCobis;
import com.cobiscorp.designer.api.infrastructure.IAutocrudService;
import com.cobiscorp.designer.api.customization.ITemporarySaveEvent;
import com.cobiscorp.designer.api.customization.ITemporaryReadEvent;
import com.cobiscorp.designer.api.customization.ITemporaryDeleteEvent;
import com.cobiscorp.designer.api.managers.EventManager;

/**
 * Servicio REST que recibe todas las peticiones de los formularios que confirman la tarea: 
 * T_FLCRE_09_ERFAN09 - CustomerDataVerification 
 *
 * @autor designer
 */
@Path("/BUSIN/FLCRE/T_FLCRE_09_ERFAN09")
@Component
@Service({T_FLCRE_09_ERFAN09.class})
@References({
@Reference(name="formEventBuilder",
	referenceInterface = FormEventBuilder.class,
	bind = "addFormEventBuilder", 
	unbind = "removeFormEventBuilder", 
	cardinality = ReferenceCardinality.OPTIONAL_UNARY, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(task.module=BUSIN)(task.submodule=FLCRE)(task.id=T_FLCRE_09_ERFAN09)(task.version=1.0.0))")
,@Reference(name="VW_ORIAHEADER86", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_ORIAHEADER86)(view.version=1.0.0))")
,@Reference(name="VW_OFICANSSEW26", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_OFICANSSEW26)(view.version=1.0.0))")
,@Reference(name="VW_BORRWRVIEW27", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_BORRWRVIEW27)(view.version=1.0.0))")
,@Reference (name="QV_BOREG0798_55",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_BOREG0798_55)")
,@Reference(name="VW_USTMRENCVW39", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_USTMRENCVW39)(view.version=1.0.0))")
,@Reference (name="QV_QURRF6164_42",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_QURRF6164_42)")
,@Reference(name="Q_QURRFRNE_6164",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_QURRFRNE_6164)(query.version=1.0.0))")
,@Reference(name="Q_BOREGEEL_0798",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_BOREGEEL_0798)(query.version=1.0.0))")
,@Reference(name="LoadCatalogCobis",
	referenceInterface=ILoadCatalogCobis.class, 
	bind = "addLoadCatalogCobis", 
	unbind = "removeLoadCatalogCobis",
	cardinality = ReferenceCardinality.OPTIONAL_UNARY, 
	policy=ReferencePolicy.DYNAMIC)
,@Reference (name="AutocrudService",
	referenceInterface=IAutocrudService.class,
	bind="addAutocrudService",
	unbind="removeAutocrudService",
	cardinality = ReferenceCardinality.OPTIONAL_UNARY, 
	policy=ReferencePolicy.DYNAMIC)
})
public class T_FLCRE_09_ERFAN09 {

	/**
	 * Se encarga de ejecutar todos los eventos
	 **/
	private EventManager eventManager;
	/**
	* Servicio autocrud
	**/
	private IAutocrudService autocrudService;

	/**
	 * Constructor por defecto
	 **/
	public T_FLCRE_09_ERFAN09() {
		super();
		this.eventManager = new EventManager();
	}

	/**
	 * Todas las peticiones se reciben por POST 
	 * 
	 * @param request contiene el nombre del evento (event), el id del componente que genero el evento (source), 
	 * 				  los datos que representan el modelo de la pantalla (data), etc.
	 * @return el modelo de la pantalla modificado luego de ejecutar el evento.
	 **/
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	public DynamicResponse execute(DynamicRequest request) {
		return this.eventManager.processEvent(request.getEvent(), request.getSource(), request, request.getArgs());
	}
	/**
	 * Servicio rest para el servicio de AutoCrud 
	 * 
	 * @param TransactionRequest contiene la informacion necesaria para realizar el autocrud
	 * @return TransactionResponse
	 **/
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Path("/crud")
	public TransactionResponse  executeAutocrud(TransactionRequest transactionRequest){
		return autocrudService.persist(transactionRequest);
	}
	

	/**
	 * Servicio rest para el servicio de AutoCrud Query
	 * 
	 * @param TransactionRequest contiene la informacion necesaria para realizar el autocrud
	 * @return TransactionResponse
	 **/
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Path("/crudQueryEntities")
	public QueryExecResponse executeAutocrudQueryWithEntities(QueryExecByEntitiesRequest queryRequest){
		return autocrudService.queryEntitiesWithEntities(queryRequest);
	}	
	
	/**
	 * Servicio rest para el servicio de AutoCrud Query por queryId
	 * 
	 * @param TransactionRequest contiene la informacion necesaria para realizar el autocrud
	 * @return TransactionResponse
	 **/
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Path("/crudQueryId")
	public QueryExecResponse executeAutocrudQueryWithQueryId(QueryExecByQueryIdRequest queryRequest){
		return autocrudService.queryEntitiesWithQueryId(queryRequest);
	}
	/**
	 * Se ejecuta este método al detectar que eventos de formulario han sido registrados
	 *
	 * @param formEventBuilder contiene todos los eventos de formulario registrados 
	 **/
	public void addFormEventBuilder(FormEventBuilder formEventBuilder, Map<String, ?> properties) {
		this.eventManager.addEventBuilder(formEventBuilder, properties);
	}
	
	/**
	 * Se ejecuta este método al detectar que eventos de formulario han sido eliminados
	 *
	 * @param formEventBuilder contiene todos los eventos de formulario eliminados 
	 **/
	public void removeFormEventBuilder(FormEventBuilder formEventBuilder, Map<String, ?> properties) {
		this.eventManager.removeEventBuilder(formEventBuilder, properties);
	}
	
	/**
	 * Se ejecuta este método al detectar que eventos de vista han sido registrados
	 *
	 * @param viewEventBuilder contiene todos los eventos de vista registrados 
	 **/
	public void addViewEventBuilder(ViewEventBuilder viewEventBuilder, Map<String, ?> properties) {
		this.eventManager.addEventBuilder(viewEventBuilder, properties);
	}
	
	/**
	 * Se ejecuta este método al detectar que eventos de vista han sido eliminados
	 *
	 *  @param viewEventBuilder contiene todos los eventos de vista eliminados 
	 **/
	public void removeViewEventBuilder(ViewEventBuilder viewEventBuilder, Map<String, ?> properties) {
		this.eventManager.removeEventBuilder(viewEventBuilder, properties);
	}
	
	/**
	 * Se ejecuta este método para registar el servicio para cargar catalogos cobis
	 *
	 *  @param loadCatalogCobis contiene el servicio para cargar catalogos cobis 
	 **/
	public void addLoadCatalogCobis(ILoadCatalogCobis loadCatalogCobis, Map<String,?> properties){
		this.eventManager.addLoadCatalogCobis(loadCatalogCobis, properties);
	}
	
	/**
	 * Se ejecuta este método para desvincular el servicio para cargar catalogos cobis
	 *
	 *  @param loadCatalogCobis contiene el servicio para cargar catalogos cobis 
	 **/
	public void removeLoadCatalogCobis(ILoadCatalogCobis loadCatalogCobis, Map<String,?> properties){
		this.eventManager.removeLoadCatalogCobis();
	}
    
    /**
	 * Se ejecuta este método al detectar que eventos de consulta han sido registrados
	 *
	 * @param eventBuilder contiene todos los eventos de ejecucion de consultas registrados 
	 **/
    public void addQueryEventBuilder(QueryEventBuilder eventBuilder, Map<String, ?> properties) {
		this.eventManager.addEventBuilder(eventBuilder, properties);
	}

    /**
	 * Se ejecuta este método al detectar que eventos de consulta han sido eliminados
	 *
	 *  @param eventBuilder contiene todos los eventos de consulta eliminados 
	 **/
	public void removeQueryEventBuilder(QueryEventBuilder eventBuilder, Map<String, ?> properties) {
		this.eventManager.removeEventBuilder(eventBuilder, properties);
	}
	/**
	 * Se ejecuta este método al detectar que el servicio de autocrud ha sido registrado
	 *
	 *  @param autocrudService servicio de autocrud
	 **/
	public void addAutocrudService(IAutocrudService autocrudService){
		this.autocrudService = autocrudService;
	}
	
	/**
	 * Se ejecuta este método al detectar que el servicio de autocrud ha sido eliminado
	 *
	 *  @param autocrudService servicio de autocrud
	 **/
	public void removeAutocrudService(IAutocrudService autocrudService){
		this.autocrudService = null;
		
	}

	/**
	 * Se ejecuta este método al detectar que eventos de grilla han sido registrados
	 *
	 * @param queryViewEventBuilder contiene todos los eventos de grilla registrados 
	 **/
	public void addQueyViewEventBuilder(QueryViewEventBuilder queryViewEventBuilder, Map<String, ?> properties) {
		this.eventManager.addEventBuilder(queryViewEventBuilder, properties);
	}
	
	/**
	 * Se ejecuta este método al detectar que eventos de grilla han sido eliminados
	 *
	 * @param queryViewEventBuilder contiene todos los grilla de formulario eliminados 
	 **/
	public void removeQueyViewEventBuilder(QueryViewEventBuilder queryViewEventBuilder, Map<String, ?> properties) {
		this.eventManager.removeEventBuilder(queryViewEventBuilder, properties);
	}
}