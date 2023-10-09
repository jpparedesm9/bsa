/***********************************************************************/
/*   Archivo:              sp_xml_doc_cuest_col_det.sp                  */
/*   Stored procedure:     sp_xml_doc_cuest_col_det.sp                  */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         NME                                          */
/*   Fecha de escritura:   03/09/2019                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   El programa genera XML para documentos COLECTIVOS                  */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      03/09/2019     NME              Emision Inicial                 */
/*      06/09/2019     NME              Se modifica estructura de xml   */
/*      27/09/2019     AINCA            Observaciones                   */
/************************************************************************/
use cob_credito
go
if OBJECT_ID ('dbo.sp_xml_doc_cuest_col_det') is not null
   drop procedure dbo.sp_xml_doc_cuest_col_det
go

create proc sp_xml_doc_cuest_col_det (
    @i_id_inst_proc         int,
    @i_id_inst_act          int,
    @i_secuencial           int,
    @i_observacion          VARCHAR(255),
    @t_debug                char(1)      = 'N',
    @t_file                 varchar(255) = null
)
as
declare
@w_cliente              int,
@w_tramite              int,
@w_codigo_tmp           varchar(3), 
@w_nombre_doc           varchar (50),
@w_catal_doc            varchar(1),
@w_pregunta             int,
@w_descripcion          varchar(1000),
@w_requerido            char(1),
@w_codigo_dep           int,
@w_valor_dep            varchar(255),
@w_secuencial           int,
@w_return               int,
@w_str                  nvarchar(max),
@w_cod_actividad        int,
@w_long_complete        int,
@w_caracter_buscar      char(1),
@w_name_complete        varchar(70),
@w_tipo_cargado         varchar(10),
@w_nombre_cliente       varchar(255),
@w_paso_act             int,
@w_error                int,
@w_msg                  varchar(255),
@w_fecha_ini_param      datetime,
@w_param_val_resp_min   int,
@w_num_meses_MESVCC     smallint,
@w_fecha_proceso        datetime,
@w_parametro            varchar(100),
@w_param                varchar(2000),
@w_respuesta            varchar(255),
@w_resultado            varchar(10),
@w_flag                 smallint,
@w_num_param            int,
@w_sp_name              varchar(50),
@w_accion               varchar(30),
@w_observacion          varchar(255),
@w_aa_id_asig_act       int,
@w_nombre_actividad     varchar(250),
@w_conyuge              int,
@w_pais_nac             smallint, 
@w_nacionalidad         catalogo,
@w_entidad_nac          smallint,
@w_ciudad_dom           varchar(255),
@w_referencia_dom       varchar(255),
@w_estado_civil         catalogo,
@w_nombre_cyg           varchar(65),
@w_s_nombre_cyg         varchar(65),
@w_p_apellido_cyg       varchar(65),
@w_s_apellido_cyg       varchar(65),
@w_fecha_nac_cyg        datetime,
@w_nro_hijos            tinyint,
@w_nro_firma            varchar(20),
@w_ocupacion            catalogo,
@w_persona_pep          char(1),
@w_rel_pep              catalogo,
@w_destino_credito      catalogo,
@w_recursos             catalogo,
@w_ingresos             money,
@w_otros_ingresos       money,
@w_total_ingresos       money,
@w_gastos_negocio       money,
@w_gastos_familia       money,
@w_total_gastos         money,
@w_capacidad_pago       money


select @w_sp_name = 'cob_credito..sp_xml_doc_cuest_col_det'
select @w_accion = 'INGRESAR'

--Tramite 
select 
@w_cliente            = io_campo_1, -- Obtencion del id cliente
@w_tramite            = io_campo_3 -- Obtencion del tramite
from cob_workflow..wf_inst_proceso
where io_id_inst_proc =  @i_id_inst_proc

--CUESTIONARIO COLECTIVOS
select  @w_fecha_proceso    = fp_fecha   from cobis..ba_fecha_proceso
select  @w_num_meses_MESVCC = pa_tinyint from cobis..cl_parametro where  pa_nemonico = 'MESVCC'
select  @w_fecha_ini_param  = dateadd(mm, -1*@w_num_meses_MESVCC, @w_fecha_proceso)
select  @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDGR' and pa_producto = 'CRE'

-- se obtiene el paso de la actividad
select @w_paso_act = ia_id_paso
from   cob_workflow..wf_inst_actividad
where  ia_id_inst_proc = @i_id_inst_proc

select @w_nombre_cliente = 
isnull(en_nombre, '')    + case when en_nombre is null then '' else ' ' end + 
isnull(p_s_nombre, '')   + case when p_s_nombre is null then '' else ' ' end + 
isnull(p_p_apellido, '') + case when p_p_apellido is null then '' else ' ' end + 
isnull(p_s_apellido, '')
from   cobis..cl_ente
where  en_ente = @w_cliente

select @w_str = '<collectiveDocumentSyncronizedData>'      

select @w_nombre_actividad = pa_char
from  cobis..cl_parametro
where pa_nemonico = 'ETAFCC'
and   pa_producto = 'CRE'  

if @@rowcount = 0 begin
   select @w_error = 2108065
   goto ERROR
end   


select @w_str = @w_str +
'<clientId>'          + convert(varchar(10), @w_cliente)                +   '</clientId>'       +
'<clientName>'        + convert(varchar(250),@w_nombre_cliente)         +   '</clientName>'     +
'<instanceProcess>'   + convert(varchar(10), @i_id_inst_proc)           +   '</instanceProcess>'  +
'<instanceActivity>'  + convert(varchar(10), @i_id_inst_act)            +   '</instanceActivity>'+
'<activityName>'      + convert(varchar(250),@w_nombre_actividad)       +   '</activityName>'+
'<stepActivity>'      + convert(varchar(10), @w_paso_act)               +   '</stepActivity>'+
'<applicationId>'     + convert(varchar, @w_tramite)                    + '</applicationId>'+
'<date>'              + format(@w_fecha_proceso, 'yyyy-MM-ddTHH:mm:ssZ')+ '</date>'



--DOCUMENTOS COLECTIVOS
-- Documentos Cliente
select @w_codigo_tmp = 0
while 1=1
begin

   select top 1  
   @w_codigo_tmp = codigo,
   @w_nombre_doc = valor , 
   @w_catal_doc  = 'P'
   from cobis..cl_catalogo 
   where tabla   = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind')
   and valor    in 
   ( 'IDENTIFICACION ANVERSO',
   'IDENTIFICACION REVERSO',
   'COMPROBANTE DOMICILIO',
   'AUTORIZACION BURO',
   'SOLICITUD DE CREDITO CORTA')
   and codigo   > @w_codigo_tmp
   order by codigo asc
                  
   if @@rowcount = 0   break   
   
   
   select 
   @w_tipo_cargado  = dd_cargado
   from cob_credito..cr_documento_digitalizado 
   where dd_cliente = @w_cliente 
   and dd_tipo_doc  = @w_codigo_tmp
   
   -- se verifica si existe o no
   if @@rowcount = 0 begin    
      
      --print convert(varchar(10),@w_codigo_tmp) + convert(varchar(25),@w_nombre_doc)
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(varchar(10),@w_codigo_tmp)  + '</code>'
      select @w_str = @w_str + '<name>' +  convert(varchar(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc     + '</classDoc>'
      select @w_str = @w_str + '<type>'     + @w_tipo_cargado  + '</type>'
      select @w_str = @w_str + '<download>' +'false'      + '</download>'
      select @w_str = @w_str + '<loaded>'   +'true'       + '</loaded>'
	  select @w_str = @w_str + '<owner>'    +'CUSTOMER'  + '</owner>'
      select @w_str = @w_str + '</documentList>'
                             
   end
   else
   begin
   
   --print convert(varchar(10),@w_codigo_tmp) + convert(varchar(25),@w_nombre_doc)
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(varchar(10),@w_codigo_tmp) + '</code>'
      select @w_str = @w_str + '<name>' +  convert(varchar(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc + '</classDoc>'
      select @w_str = @w_str + '<type>'     +       ''   + '</type>'
      select @w_str = @w_str + '<download>' +'false'     + '</download>'
      select @w_str = @w_str + '<loaded>'   +'false'     + '</loaded>'
	  select @w_str = @w_str + '<owner>'    +'CUSTOMER'  + '</owner>'
      select @w_str = @w_str + '</documentList>'
   end
end


--Documentos Flujo
-- se obtiene el codigo de la actividad
select @w_cod_actividad = ia_codigo_act 
from cob_workflow..wf_inst_actividad
where ia_id_inst_act = @i_id_inst_act
and ia_id_inst_proc  = @i_id_inst_proc

-- se obtiene el caracter a buscar
select @w_caracter_buscar = '.'


-- Se llena la informacion para cada uno de los docmuentos a subir
select @w_codigo_tmp = 0
while 1=1
begin
   select top 1 @w_codigo_tmp = td_codigo_tipo_doc , @w_nombre_doc = td_nombre_tipo_doc , @w_catal_doc = td_categoria_doc
   from cob_workflow..wf_tipo_documento 
   where td_nombre_tipo_doc like '%COLECTIVOS%'
   and td_codigo_tipo_doc > @w_codigo_tmp
   order by td_codigo_tipo_doc
                  
   if @@rowcount = 0   break   
   
   
   select @w_name_complete = ri_nombre_doc 
   from cob_workflow..wf_req_inst 
   where ri_id_inst_proc   = @i_id_inst_proc 
   and ri_codigo_act       = @w_cod_actividad 
   and ri_codigo_tipo_doc  = @w_codigo_tmp
   
   -- se verifica si existe o no
   if @@rowcount = 0 
   begin 
      select @w_long_complete = len(@w_name_complete)
      select @w_tipo_cargado=  substring (@w_name_complete,charindex(@w_caracter_buscar,@w_name_complete)+1,@w_long_complete)
     
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(varchar(10),@w_codigo_tmp) + '</code>'
      select @w_str = @w_str + '<name>' +  convert(varchar(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc + '</classDoc>'
      select @w_str = @w_str + '<type>'     + @w_tipo_cargado + '</type>'
      select @w_str = @w_str + '<download>' +'false'     + '</download>'
      select @w_str = @w_str + '<loaded>'   +'true'      + '</loaded>'
	  select @w_str = @w_str + '<owner>'    +'INBOX'     + '</owner>'
      select @w_str = @w_str + '</documentList>'
                             
   end
   else
   begin
   
   --print convert(varchar(10),@w_codigo_tmp) + convert(varchar(25),@w_nombre_doc)
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(varchar(10),@w_codigo_tmp) + '</code>'
      select @w_str = @w_str + '<name>' +  convert(varchar(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc + '</classDoc>'
      select @w_str = @w_str + '<type>' +       ''       + '</type>'
      select @w_str = @w_str + '<download>' +'false'     + '</download>'
      select @w_str = @w_str + '<loaded>'   +'false'     + '</loaded>'
	  select @w_str = @w_str + '<owner>'    +'INBOX'     + '</owner>'
      select @w_str = @w_str + '</documentList>'
   end
end


create table #tmp_items_xml (
sec    int,
value  varchar(200),
numero int not null
)

select
@w_pais_nac       = p_pais_emi,
@w_nacionalidad   = en_nac_aux,
@w_entidad_nac    = p_depa_nac,
@w_estado_civil   = p_estado_civil,
@w_nro_hijos      = p_num_cargas,
@w_nro_firma      = ea_num_serie_firma,
@w_ocupacion      = p_profesion,
@w_persona_pep    = en_persona_pep,
@w_rel_pep        = en_persona_pub,
@w_ingresos       = en_otros_ingresos,
@w_otros_ingresos = ea_ventas,
@w_total_ingresos = en_otros_ingresos + ea_ventas,
@w_gastos_negocio = ea_ct_operativo,
@w_gastos_familia = ea_ct_ventas,
@w_total_gastos   = ea_ct_operativo + ea_ct_ventas,
@w_capacidad_pago = (en_otros_ingresos + ea_ventas) - (ea_ct_operativo + ea_ct_ventas)
from cobis..cl_ente, cobis..cl_ente_aux
where en_ente = ea_ente
and en_ente = @w_cliente

/* DIRECCION */
select
@w_ciudad_dom     = di_poblacion,
@w_referencia_dom = di_descripcion
from cobis..cl_direccion
where di_ente = @w_cliente
and di_tipo = 'RE'

/* NEGOCIO */
select 
@w_destino_credito   = nc_destino_credito,
@w_recursos          = nc_recurso
from cobis..cl_negocio_cliente 
where nc_ente = @w_cliente

/* Datos Conyuge */
select @w_conyuge = in_ente_d 
from cobis..cl_instancia 
where in_ente_i = @w_cliente

if @w_conyuge is not null
begin
   select
   @w_nombre_cyg     = en_nombre,
   @w_s_nombre_cyg   = p_s_nombre,
   @w_p_apellido_cyg = p_p_apellido,
   @w_s_apellido_cyg = p_s_apellido,
   @w_fecha_nac_cyg  = p_fecha_nac
   from cobis..cl_ente
   where en_ente = @w_conyuge
end

select @w_resultado = ''

select @w_str = @w_str + '<collectiveCustomer>' 
   + '<birthCountry>' + isnull(convert(varchar,@w_pais_nac),'') + '</birthCountry>'
   + '<nationality>' + isnull(@w_nacionalidad,'') + '</nationality>'
   + '<birthEntity>' + isnull(convert(varchar,@w_entidad_nac),'') + '</birthEntity>'
   + '<cityOfDomicile>' + isnull(convert(varchar,@w_ciudad_dom),'') + '</cityOfDomicile>'
   + '<domicileReference>' + isnull(convert(varchar,@w_referencia_dom),'') + '</domicileReference>'
   + '<civilStatus>' + isnull(@w_estado_civil,'') + '</civilStatus>'
   + '<spouseFirstName>' + isnull(@w_nombre_cyg,'') + '</spouseFirstName>'
   + '<spouseSecondName>' + isnull(@w_s_nombre_cyg,'') + '</spouseSecondName>'
   + '<spouseSurname>' + isnull(@w_p_apellido_cyg,'') + '</spouseSurname>'
   + '<spouseSecondSurname>' + isnull(@w_s_apellido_cyg,'') + '</spouseSecondSurname>'
   + '<spouseBirthdate>' + isnull(convert(varchar(10),@w_fecha_nac_cyg, 103),'') + '</spouseBirthdate>'
   + '<numberOfChildren>' + isnull(convert(varchar,@w_nro_hijos),'') + '</numberOfChildren>'
   + '<electronicSignatureSerieNumber>' + isnull(@w_nro_firma,'') + '</electronicSignatureSerieNumber>'
   + '<ocupation>' + isnull(@w_ocupacion,'') + '</ocupation>'
   + '<isPEP>' + isnull(@w_persona_pep,'') + '</isPEP>'
   + '<spouseOrRelativeofPEP>' + isnull(@w_rel_pep,'') + '</spouseOrRelativeofPEP>'
   + '<creditDestination>' + isnull(@w_destino_credito,'') + '</creditDestination>'
   + '<paymentResources>' + isnull(@w_recursos,'') + '</paymentResources>'
   + '<income>' + isnull(convert(varchar,@w_ingresos),'') + '</income>'
   + '<otherIncome>' + isnull(convert(varchar,@w_otros_ingresos),'') + '</otherIncome>'
   + '<total>' + isnull(convert(varchar,@w_total_ingresos),'') + '</total>'
   + '<businessExpenses>' + isnull(convert(varchar,@w_gastos_negocio),'') + '</businessExpenses>'
   + '<familiarExpenses>' + isnull(convert(varchar,@w_gastos_familia),'') + '</familiarExpenses>'
   + '<totalExpenses>' + isnull(convert(varchar,@w_total_gastos),'') + '</totalExpenses>'
   + '<monthlyPaymentCapacity>' + isnull(convert(varchar,@w_capacidad_pago),'') + '</monthlyPaymentCapacity>'

select @w_str = @w_str +'</collectiveCustomer>'+'</collectiveDocumentSyncronizedData>'
-- Comentarios
select @w_accion = 'INGRESAR'

--Detalle Sincronización
insert into cob_sincroniza..si_sincroniza_det values
( @i_secuencial,        @i_id_inst_proc, @w_tramite, 
isnull(@w_cliente,0),   @w_str,          @w_accion, 
@i_observacion,         0)

if @@error <> 0
begin

   return 150000 -- ERROR EN INSERCION
end
    
return 0

ERROR: 
return @w_error

GO
