package com.cobiscorp.ecobis.business.commons.platform.services.utils;

public class ExceptionMessage {

	
	public static class BussinessPlatform{
		public static final String CREATE_RELATION = "Error al crear relación del Cliente";
		public static final String CREATE_SPOUSE = "Error en la creación de datos del Conyugue";
		public static final String CREATE_ADDRESS = "Error al crear dirección del Cliente";
		public static final String CREATE_ADDRESS_PAISDIR = "El país seleccionado no es el correcto";
		public static final String CREATE_ADDRESS_PAISGEO = "La dirección no se encuentra dentro del país México";
		public static final String CREATE_ADDRESS_OFFICE = "No existe geolocalización de la oficina";
		public static final String CREATE_ADDRESS_GEODIS = "La ubicación es menor a la distancia permitida con respecto a la oficina";
		public static final String CREATE_ADDRESS_GEORAD = "La ubicación es mayor a la distancia permitida con respecto a la oficina";
		public static final String CREATE_BUSSINESS = "Error al crear Negocios";
		public static final String CREATE_UPDATE_ECONOMIC_ACTIVITY = "Error al Crear o Actualizar la información de Actividades Económicas";
		public static final String SAVE_CUSTOMER = "Error al guardar Cliente";
		public static final String CREATE_REFERENCES = "Error al crear referencias del Cliente";
				
		public static final String SEARCH_ZIP_CODE = "Error al buscar Código Postal" ;
		public static final String LOAD_STATE = "Error al recuperar Código Postal" ;		
		public static final String SEARCH_ADDRESS = "Error al consultar la dirección del Cliente" ;
		public static final String SEARCH_TELEPHONES = "Error al buscar Teléfonos";
		public static final String READ_CUSTOMER = "Error al recuperar información del Cliente";
		public static final String READ_PARAMETERS = "Error al recuperar información de Parámetros";
		public static final String READ_SYNC_MOBILE = "Error al Sincronizar con el dispositivo móvil los datos del Cliente";		
		public static final String READ_ECONOMIC_ACTIVITY = "Error al actualizar los datos de la Actividad Económica";
		public static final String SEARCH_DOCUMENTS = "Error al buscar los documentos del Cliente";
		
		public static final String CLOSE_ALFRESCO = "Error al cerrar el archivo";
		public static final String UPDATE_ALFRESCO = "Error al actualizar el archivo";
		public static final String UPDATE_DOCUMENTS = "Error al actualizar los datos del documento";
		public static final String UPDATE_CUSTOMER = "Error al actualizar los datos del Cliente";
		public static final String UPDATE_ECONOMIC_ACTIVITY = "Error al actualizar los datos de la Actividad Económica";
		
		public static final String LOADCATALOG_BUSSINESS_NAME = "Error al cargar catálogo del Negocio";
		public static final String LOADCATALOG_CITIES = "Error al cargar catálogo de Ciudad";
		public static final String LOADCATALOG_COUNTRIES = "Error al cargar catálogo de País";
		public static final String LOADCATALOG_DEPARMENTS = "Error al cargar catálogo de Estados";
		public static final String LOADCATALOG_PROVINCES = "Error al cargar catálogo de Municipios";
		public static final String LOADCATALOG_NEIGBORHOODS = "Error al cargar catálogo de Barrio";
		public static final String LOADCATALOG_PARISHES = "Error al cargar catálogo de Colonia";
		public static final String LOADCATALOG_PHYSICAL_ADDRESS = "Error al cargar catálogo de Dirección Física";
		public static final String LOADCATALOG_BUSSINESS_OFFICER = "Error al cargar catálogo de Oficial del Negocio";
		public static final String LOADCATALOG_COUNTRY_OF_BIRTH = "Error al cargar catálogo de Ciudad Nacimiento";
		public static final String LOADCATALOG_DOCUMENT_TYPE = "Error al cargar catálogo de Tipo de Documento";
		public static final String LOADCATALOG_NATIONALITY = "Error al cargar catálogo de Nacionalidad";
		public static final String LOADCATALOG_SECTOR = "Error al cargar catálogo de Sector";
		public static final String LOADCATALOG_ACTIVITY = "Error al cargar catálogo de Actividad";
		public static final String LOADCATALOG_SUBSECTOR = "Error al cargar catálogo de Subsector";
		
		public static final String INIT_DATA_BUSSINESS = "Error al cargar información de Negocios";
		public static final String INIT_DATA_CUSTOMER = "Error al cargar información del Cliente";
		public static final String INITDATA_ECONOMIC_ACTIVITY = "Error al cargar información de la Actividad Económica";
		public static final String INITDATA_ADDRESS = "Error al cargar información de Direcciones del Cliente";
		public static final String INITDATA_REFERENCES = "Error al cargar información de Referencias del Cliente";
		public static final String INITDATA_SCANNED = "Error al cargar información de Documentos Scaneados del Cliente";
		
		public static final String DELETE_ECONOMIC_ACTIVITY = "Error al eliminar Actividad Económica";
		public static final String DELETE_VIRTUAL_ADDRESS = "Error al eliminar Dirección Virtual";
		public static final String CLOSEMODAL_ECONOMIC_ACTIVITY = "Error al recuperar información de Actividad Económica";
		
		public static final String VALIDATE_DOCUMENT_NUMBER = "Error al validar número de documento";
		public static final String LOAD_BURO = "Error al consultar interface buró";
		
		public static final String SEARCH_TRANSFER = "Error al consultar traspasos";
		public static final String SEARCH_TRANSFER_DETAIL = "Error al consultar detalle de traspasos";
		public static final String SEARCH_CUSTOMERBYOFICIAL = "Error al consultar el Cliente por el Oficial";
		public static final String AUT_TRANSFER = "Error al Autorizar";
		public static final String REF_TRANSFER = "Error al Rechazar";
		public static final String SEARCH_OFFICE = "Error al consultar Oficina";
		public static final String SEARCH_OFFICER = "Error al consultar Oficial";
		
		public static final String CREATE_ALERT = "Error al crear la Operacion inusual o relevante";
		public static final String SEARCH_ALERT = "Error al buscar la Operacion inusual o relevante";
		public static final String SEARCH_RISK =  "Error al buscar alertas de Riesgo";
		public static final String UPDATE_RISK =  "Error al actualizar alertas de Riesgo";
		public static final String UPDATE_ALERT =  "Error al actualizar la alerta ";
		public static final String DELETE_ALERT =  "Error al eliminar la alerta ";
		
		public static final String CREATE_PHONE =  "Error al crear el teléfono.";
		public static final String UPATE_PHONE =  "Error al actualizar el teléfono.";
		public static final String DELETE_PHONE =  "Error al eliminar el teléfono.";
		
		public static final String UPDATE_ALTAIR =  "Error al guardar la cuenta nueva.";
		public static final String ALTAIR_SESSION =  "La cuenta es inválida.";
		
	}
	public static class BussinessProcess{
		public static final String CHANGE_ITEM = "Error cambiando la categoría del elemento" ;
		public static final String CHANGE_READJUSTMENT = "Error al cambiar la referencia del valor de reajuste";
		public static final String CHANGE_REFERENCE = "Error al cambiar valor de referencia";
		public static final String CREATE_ITEM = "Error en Insertar/Actualizar Rubros";
		public static final String SEARCH_ITEM = "Error al consultar Rubros";
		public static final String UPDATE_ITEM = "Error al actualizar Rubros";
		public static final String COMPUTE = "Error al Calcular el resultado del cuestionario";
		public static final String INITDATA_QUESTIONS = "Error al cargar la información del cuestionario";
		public static final String INITDATA_COMPOUND = "Error al cargar la información de detalles del cuestionario";
		public static final String SAVE_QUESTIONS = "Error al guardar el cuestionario";
		public static final String SYNCHRONIZE_QUESTIONS = "Error al guardar el cuestionario";
		public static final String CATALOG_ENTITIES = "Error al cargar las entidades";
		public static final String EXECUTE_WARRANTY = "Error al ejecutar garantía";
		public static final String INITDATA_WARRANTY = "Error al cargar garantía";
		public static final String DELETE_WARRANTY_81 = "Error al eliminar";
		public static final String DELETE_WARRANTY_66 = "Error al eliminar";
		public static final String DELETE_GENERIC_55 = "Error al eliminar";
		public static final String DELETE_GENERIC_63 = "Error al eliminar";
		public static final String CHANGE_BAKING_PRODUCT = "Error al cargar el producto bancario";
		public static final String CHANGE_OFFICE = "Error al cargar oficina";
		public static final String CHANGE_PAYMENT_FREQUENCY ="Error al cargar frecuencia de pago";
		public static final String CHANGE_SEGMENT ="Error al cargar segmento";
		public static final String CHANGE_TERM ="Error al cargar condiciones";
		public static final String GENERICAP_GUARDAR = "Error al guardar";
		public static final String GENERICAP_GUARDAR_SECCION = "Error al guardar sección";
		public static final String GENERICAP_SEARCH_CLIENT = "Error al recuperar cliente";
		public static final String GENERICAP_BUREAU_AVAL = "Error al ejecutar Buró";
		public static final String GENERICAP_INITDATA = "Error al cargar la información de la solicitud";
		public static final String GENERICAP_SYNC = "Error, Falló la sincronización";
		public static final String GENERICAP_CHANGE_OPERATION = "Error al cambiar el tipo de operación";
		public static final String GENERICAP_CHANGE_250 = "Error al cambiar el tipo de operación";
		public static final String GENERICAP_CHANGE_MONEDA_595 = "Error al cargar la moneda solicitada";
		public static final String GENERICAP_CHANGE_MONTO_134 = "Error al cargar el monto solicitado";
		public static final String GENERICAP_CHANGE_LEGAL_250 = "Error al cargar el monto solicitado";
		public static final String GENERICAP_CHANGE_ACTIVITY_957 = "Error al cargar actividad económica";
		public static final String GENERICAP_CATALOG_CITY = "Error al cargar las ciudades";
		public static final String GENERICAP_CATALOG_COMPANY = "Error al cargar compañía";
		public static final String GENERICAP_CATALOG_CREDITLINE = "Error al cargar línea de crédito;";
		public static final String GENERICAP_CATALOG_OFFICIAL = "Error al cargar oficiales";
		public static final String GENERICAP_CATALOG_ACTIVITY = "Error al cargar las actividades de destino";
		public static final String GENERICAP_CATALOG_BAKING_PRODUCT = "Error al cargar el producto bancario";
		public static final String GENERICAP_CATALOG_CURRENCY_PRODUCT = "Error al cargar la moneda";
		public static final String GENERICAP_CATALOG_EXECUTIVE = "Error al cargar los ejecitovos";
		public static final String GENERICAP_CATALOG_DESTIONATION = "Error al cargar destino Financiero";
		public static final String GENERICAP_CATALOG_LOCATION = "Error al cargar la localización";
		public static final String GENERICAP_CATALOG_DESTIONATION_OTHER = "Error al cargar destino Financiero";
		public static final String GENERICAP_CATALOG_PARROQUIA = "Error al cargar las parroquias";
		public static final String GENERICAP_CATALOG_PAYMENT = "Error al cargar la frecuencia de pago";
		public static final String GENERICAP_CATALOG_PROVINCE = "Error al cargar provincias";
		public static final String GENERICAP_CATALOG_SECTOR = "Error al cargar sector";
		public static final String GENERICAP_CATALOG_TERM = "Error al cargar condiciones";
		public static final String GUARANTEE_EXECUTE_GARANTEE = "Error al cargar moneda de la garantía";
		public static final String GUARANTEE_EXECUTE_SEARCH = "Error al cargar la garantía";
		public static final String GUARANTEE_CATALOG_OFFICIAL = "Error al cargar oficiales";
		public static final String GUARANTEE_CATALOG_TYPE = "Error al cargar el tipo de garatía";
		public static final String PLAZO_CHANGE_FIXED_TERM = "Error al cambiar término fijo";
		public static final String PLAZO_EXECUTE_SELECT = "Error al cargar término fijo";
		public static final String PRINTACTIVITY_EXECUTE_PRINT = "Error al ejecutar impresión";
		public static final String PRINTACTIVITY_INITDATA_PRINT = "Error al cargar información para la impresión";
		public static final String REJECTED_EXECUTE_SAVEAPP = "Error al rechazar solicitud";
		public static final String REJECTED_INITDATA_APP = "Error al cargar la solicitud";
		public static final String REPRINT_EXECUTE_PRINT = "Error al ejecutar la impresión";
		public static final String REPRINT_EXECUTE_SEARCH = "Error al cargar solicitud para la impresión";
		public static final String REPRINT_INITDATA_REPRINT = "Error al cargar pantalla de re-impresión";
		public static final String REPRINT_CATALOG_FLOW = "Error al cargar el tipo de flujo";
		public static final String REPRINT_ROW_SELECTING = "Error al cargar información de la fila seleccionada";
		public static final String DISBURSEMENTCONSULT_INITDATA = "Error al cargar la consulta de desembolso";
		public static final String DISBURSEMENT_INITDATA = "Error al cargar la información de desembolso";
		public static final String DISBURSEMENT_ROW_DELETING = "Error al eliminar fila de desembolso";
		public static final String DISBURSEMENTINCOME_CHANGE_CURRENCY = "Error al cambiar moneda de desembolso";
		public static final String DISBURSEMENTINCOME_CHANGE_VALUE = "Error al cambiar el valor de desembolso";
		public static final String DISBURSEMENTINCOME_EXECUTE_SAVE = "Error al guardar desembolso";
		public static final String DISBURSEMENTINCOME_CATALOG_CURRENCY = "Error al cargar la moneda de desembolso";
		public static final String DISBURSEMENTINCOME_EXECUTE_MEMBER = "Error al cargar miembros";
		public static final String DISBURSEMENTINCOME_EXECUTE_MEMBERCHECK = "Error al recuperar miembros del grupo";
		public static final String DISBURSEMENTINCOME_UPDATE_BANK = "Error al actualizar";
		public static final String PAYMENTPLAN_BLI_ITEMS = "Error al cargar rubros";
		public static final String PAYMENTPLAN_BLI_OPERATION = "Error al cargar la operación";
		public static final String PAYMENTPLAN_CHANGE_FRECUENCYAMORTIZATION = "Error al cargar la frecuencia de pago en la tabla de amortización";
		public static final String PAYMENTPLAN_CHANGE_FRECUENCY = "Error al cargar la frecuencia de pago";
		public static final String PAYMENTPLAN_CHANGE_REBATE = "Error al cargar reembolso";
		public static final String PAYMENTPLAN_CHANGE_TERM = "Error al cargar las condiciones";
		public static final String PAYMENTPLAN_CHANGE_696 = "Error al cargar información";
		public static final String PAYMENTPLAN_CHANGE_AMOUNT = "Error al cambiar primer monto";
		public static final String PAYMENTPLAN_CHANGE_APROVED = "Error al cambiar primer monto";
		public static final String PAYMENTPLAN_CHANGE_REN = "Error al cambiar primer monto";
		public static final String PAYMENTPLAN_INITDATA = "Error al cargar la información";
		public static final String PAYMENTPLAN_ROW_DELETE = "Error al eliminar";
		public static final String PAYMENTPLAN_CARGA_GRUOUP = "Error al recuperar los datos de cuenta";
		public static final String PAYMENTPLAN_EXECUTE_FUENTE = "Error al actualizar la fuente de financiamiento";
		public static final String PAYMENTPLAN_EXECUTE_AMORTIZATION = "Error en sección de Tabla de Amortización";
		public static final String PAYMENTPLAN_EXECUTE_SAVESESSION = "Error al guardar la sesió del plan de pagos";
		public static final String PAYMENTPLAN_EXECUTE_INSERTUPDATE = "Error al insertar o actualizar";
		public static final String PAYMENTPLAN_EXECUTE_PARAMETERS = "Error al actualizar parametros generales";
		public static final String PAYMENTPLAN_CATALOG_OPERATIONS = "Error al modificar operaciones";
		public static final String PAYMENTPLAN_CATALOG_ACCOUNTS = "Error al cargar cuentas";
		public static final String PAYMENTPLAN_CATALOG_CURRENCY = "Error al cargar la moneda del producto";
		public static final String PAYMENTPLAN_CATALOG_FREQUENCY = "Error al cargar la frecuencia de pago";
		public static final String PAYMENTPLAN_CATALOG_WAYS = "Error al cargar formas de pago";
		public static final String PAYMENTPLAN_CATALOG_REBATE = "Error al cargar formas de pago";
		public static final String PAYMENTPLAN_CATALOG_SOURCE = "Error al cargar fuente de financiación";
		public static final String PAYMENTPLAN_CATALOG_TERMS = "Error al cargar condiciones del producto";
		public static final String WARRANTIES_LOAD_MAP = "Error al cargar garantía";
		public static final String WARRANTIES_EXECUTE_SAVE = "Error al guardar garantía";
		public static final String WARRANTIES_EXECUTE_UPDATE = "Error al actualizar garantía";
		public static final String WARRANTIES_ROW_DELETING = "Error al eliminar";
		public static final String WARRANTIES_CATALOG_CITIES = "Error al cargar ciudades";
		public static final String WARRANTIES_CATALOG_CITY = "Error al cargar ciudad";
		public static final String WARRANTIES_CATALOG_COVARAGE = "Error al cargar cobertura";
		public static final String WARRANTIES_CATALOG_OFFICE = "Error al cargar oficinas";
		public static final String WARRANTIES_CATALOG_PARROQUIA = "Error al cargar parroquias";
		public static final String WARRANTIES_CATALOG_PERIODICITY = "Error al cargar periodicidad";
		public static final String WARRANTIES_CATALOG_PROVINCE = "Error al cargar provincias";
		public static final String WARRANTIES_CATALOG_STOREKEEPER = "Error al cargar StoreKeeper";
		public static final String WARRANTIES_MODAL_FINDING = "Error al buscar la garantía";
		public static final String WARRANTIES_INITDATA_WARRANTY = "Error al cargar información inicial de la garantía";
		
	}
	public static class Clients{
		public static final String CREATE_AMOUNT = "Error al crear montos" ;
		public static final String CREATE_GROUP = "Error al crear el grupo" ;
		public static final String CREATE_MEMBER = "Error al guardar miembros" ;
		public static final String LOAD_BUSSINES_OFFICER = "Error al cargar Ejecutivos" ;
		public static final String DESASOCIAR_MIENBROS = "Error al desasociar miembros" ;
		public static final String SEARCH_AMOUNT = "Error al buscar datos de montos" ;
		public static final String SEARCH_GROUP = "Error al buscar los datos del grupo" ;
		public static final String SEARCH_BURO = "Error en consulta Buró" ;
		public static final String SEARCH_MEMBER = "Error el buscar los datos del Integrante" ;
		public static final String SEARCH_CALIFICATION_MEMBER = "Error al buscar la calificación del miembro" ;
		public static final String SYNCRONIZATION_MOVIL_GROUP = "Error, Falló la sincronización grupal" ;
		public static final String UPDATE_AMOUNT = "Error al actualizar montos" ;
		public static final String INIT_DATA_GROUP_COMPOSITE = "Error al cargar la información del grupo";
		public static final String INIT_DATA_MEMBER_POP_UP = "Error al cargar la información del miembro";
		public static final String REPORT_GROUP_ACCOUNT_STATEMENT = "Error al obtener el informe de la cuenta grupal";
		public static final String REPORT_GROUP_ACCOUNT_CREDIT_SUMMARY = "Error al obtener el informe del resumen del crédito";
		public static final String REPORT_GROUP_ACCOUNT_PLAYMENT_PLAN = "Error al obtener el informe del plan de pago";
		public static final String REPORT_CLEARANCESHEET_HEAD = "Error al obtener el encabezado de la hoja de liquidación";
		public static final String REPORT_CLEARANCESHEET_DETAIL = "Error al obtener el detalle de la hoja de liquidación";
		public static final String INIT_DATA_COMPOSITE = "Error al cargar la información de los documentos digitalizados";
		public static final String UPLOAD_DOCUMENTS = "Error al buscar los datos del documento";
		public static final String VALIDATE_DOCUMENTS = "Error al validar subida de documentos";
	}
	
	public static class MovileIntegration{
		
		public static final String INIT_DATA_MOVILES = "Error al iniciar datos móviles";
		public static final String SEARCH_DATA_MOVILES = "Error al buscar datos móviles";
		public static final String SEARCH_MOBILES_BY_FILTER = "Error al buscar los móviles por filtro";
		public static final String SYN_DATA_BY_OFICIAL = "Error al sincronizar datos móviles por oficial";
		public static final String CREATE_MOVILE = "Error al crear el registro del móvil";
		public static final String DELETE_MOVILE = "Error al eliminar registro del móvil";
		public static final String SEARCH_ALL_DEVICES = "Error al Buscar los dispositivos moviles";
		public static final String LOAD_CATALOG_BY_OFFICER = "Error al cargar catálogo del oficial";
		public static final String LOAD_OFFICERS = "Error al cargar catologo de oficiales";
		
	}
	
	public static class Assets{
		public static final String MAIL_PRECANCELATION = "Error al enviar correo electrónico" ;
		public static final String SEARCH_PRECANCELATION = "Error al cargar información de cliente" ;
	}
	
}
