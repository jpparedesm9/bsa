/*
 * Archivo: T_CUSTOMERCOETP_680.java
 * Fecha: 2023-06-23T20:01:26Z
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
package com.cobiscorp.cobis.cstmr.services;

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

import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.DynamicResponse;
import com.cobiscorp.designer.api.builder.FormEventBuilder;
import com.cobiscorp.designer.api.builder.QueryEventBuilder;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
import com.cobiscorp.designer.api.customization.ILoadCatalogCobis;
import com.cobiscorp.designer.api.managers.EventManager;

/**
 * Servicio REST que recibe todas las peticiones de los formularios que confirman la tarea: 
 * T_CUSTOMERCOETP_680 - CustomerComposite 
 *
 * @autor designer
 */
@Path("/CSTMR/CSTMR/T_CUSTOMERCOETP_680")
@Component
@Service({T_CUSTOMERCOETP_680.class})
@References({
@Reference(name="formEventBuilder",
	referenceInterface = FormEventBuilder.class,
	bind = "addFormEventBuilder", 
	unbind = "removeFormEventBuilder", 
	cardinality = ReferenceCardinality.OPTIONAL_UNARY, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(task.module=CSTMR)(task.submodule=CSTMR)(task.id=T_CUSTOMERCOETP_680)(task.version=1.0.0))")
,@Reference(name="VW_LEGALPERRS_688", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_LEGALPERRS_688)(view.version=1.0.0))")
,@Reference(name="VW_CUSTOMERIF_213", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_CUSTOMERIF_213)(view.version=1.0.0))")
,@Reference(name="VW_DEMOGRAPHI_794", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_DEMOGRAPHI_794)(view.version=1.0.0))")
,@Reference(name="VW_CUSTOMERSO_425", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_CUSTOMERSO_425)(view.version=1.0.0))")
,@Reference(name="VW_SCANNEDDOS_611", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_SCANNEDDOS_611)(view.version=1.0.0))")
,@Reference (name="QV_7463_28553",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_7463_28553)")
,@Reference(name="VW_ECONOMICNI_168", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_ECONOMICNI_168)(view.version=1.0.0))")
,@Reference(name="VW_ADDRESSOTU_566", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_ADDRESSOTU_566)(view.version=1.0.0))")
,@Reference (name="QV_4851_97960",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_4851_97960)")
,@Reference (name="QV_9303_67123",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_9303_67123)")
,@Reference(name="VW_BUSINESSPU_304", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_BUSINESSPU_304)(view.version=1.0.0))")
,@Reference (name="QV_6359_40398",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_6359_40398)")
,@Reference(name="VW_RELATIONAN_954", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_RELATIONAN_954)(view.version=1.0.0))")
,@Reference (name="QV_6114_93961",
	referenceInterface=QueryViewEventBuilder.class,
	bind="addQueyViewEventBuilder",
	unbind="removeQueyViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(queryView.id=QV_6114_93961)")
,@Reference(name="VW_COMPLEMEQS_642", 
	referenceInterface=ViewEventBuilder.class, 
	bind = "addViewEventBuilder", 
	unbind = "removeViewEventBuilder",
	cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
	policy=ReferencePolicy.DYNAMIC,
	target="(&(view.id=VW_COMPLEMEQS_642)(view.version=1.0.0))")
,@Reference(name="Q_SCANNELD_7463",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_SCANNELD_7463)(query.version=1.0.0))")
,@Reference(name="Q_RELATION_6114",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_RELATION_6114)(query.version=1.0.0))")
,@Reference(name="Q_BUSINESS_6359",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_BUSINESS_6359)(query.version=1.0.0))")
,@Reference(name="Q_VIRTUALD_9303",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_VIRTUALD_9303)(query.version=1.0.0))")
,@Reference(name="Q_PHYSICDS_4851",
    referenceInterface = QueryEventBuilder.class,
    bind = "addQueryEventBuilder", 
    unbind = "removeQueryEventBuilder", 
    cardinality = ReferenceCardinality.OPTIONAL_MULTIPLE, 
    policy=ReferencePolicy.DYNAMIC,
    target="(&(query.id=Q_PHYSICDS_4851)(query.version=1.0.0))")
,@Reference(name="LoadCatalogCobis",
	referenceInterface=ILoadCatalogCobis.class, 
	bind = "addLoadCatalogCobis", 
	unbind = "removeLoadCatalogCobis",
	cardinality = ReferenceCardinality.OPTIONAL_UNARY, 
	policy=ReferencePolicy.DYNAMIC)
})
public class T_CUSTOMERCOETP_680 {

	/**
	 * Se encarga de ejecutar todos los eventos
	 **/
	private EventManager eventManager;

	/**
	 * Constructor por defecto
	 **/
	public T_CUSTOMERCOETP_680() {
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