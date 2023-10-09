/* ********************************************************************* */
/*      Archivo:                consdocdig.sp                            */
/*      Stored procedure:       sp_consultar_doc_digitalizados           */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     28-Enero-2019                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Consultar documentos digitalizados por filtros: Grupo, Cliente,  */
/*      Préstamo y Trámite                                               */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*     28/01/2019       SROJAS               Version Inicial             */
/* ***********************************************************************/

use cob_credito
go

IF OBJECT_ID ('dbo.sp_consultar_doc_digitalizados') IS NOT NULL
	DROP PROCEDURE dbo.sp_consultar_doc_digitalizados
GO


create proc sp_consultar_doc_digitalizados(
@s_ssn                     int           = null,
@s_ofi                     smallint,
@s_user                    login,
@s_date                    datetime,
@s_srv                     varchar(30)   = null,
@s_term                    descripcion   = null,
@s_rol                     smallint      = null,
@s_lsrv                    varchar(30)   = null,
@s_sesn                    int           = null,
@s_org                     char(1)       = null,
@s_org_err                 int           = null,
@s_error                   int           = null,
@s_sev                     tinyint       = null,
@s_msg                     descripcion   = null,
@t_rty                     char(1)       = null,
@t_trn                     int           = null,
@t_debug                   char(1)       = 'N',
@t_file                    varchar(14)   = null,
@t_from                    varchar(30)   = null,
@i_cliente                 int           = null,
@i_tipo_cliente            char(1)       = null,
@i_banco                   varchar(24)   = null,
@i_tramite                 int           = null,
@i_tipo_documento          char(10)      = null,
@i_modulo                  varchar(30)   = null,
@o_msg                     varchar(255)  = null out
)
as
declare 
@w_msg                     varchar(255),
@w_mensaje                 varchar(255),
@w_error                   int,
@w_tramite                 int,
@w_id_inst_proceso         int


create table #tmp_doc_digitalizados(
   tipo_documento          varchar(255),
   cod_tipo_documento      char(10),
   nombre_cliente          varchar(255),
   cod_cliente             int,
   tipo_cliente            char(2),
   fecha_ingreso           datetime,
   numero_prestamo         varchar(24) null,
   tramite                 int         null,
   instancia_proceso       int         null,
   extension               varchar(10),
   carpeta                 varchar(30),
   nombre_documento        varchar(255),
   grupo                   int         null,
   modulo                  varchar(30) null
)


--Solo Filtro Cliente
if @i_cliente is not null and @i_tipo_cliente is not null begin

   if @i_tipo_cliente = 'S' begin --Grupo Solidario

      insert into #tmp_doc_digitalizados
      select 
      td_nombre_tipo_doc, 
      convert(char(10),td_codigo_tipo_doc),
      convert(varchar(255),''),
      @i_cliente,
      @i_tipo_cliente,
      ri_fecha_registro,
      convert(varchar(24),''),
      io_campo_3,
      io_id_inst_proc,
      substring(ri_nombre_doc, charindex('.',ri_nombre_doc) + 1, len(ri_nombre_doc)),
      'Inbox',
      substring(ri_nombre_doc, 1, charindex('.',ri_nombre_doc) -1),
	  null,
	  'WORKFLOW'
      from cob_workflow..wf_req_inst,
           cob_workflow..wf_inst_proceso,
           cob_workflow..wf_tipo_documento		
      where ri_id_inst_proc    = io_id_inst_proc
      and   td_codigo_tipo_doc = ri_codigo_tipo_doc
      and   io_campo_1         = @i_cliente
      and   io_campo_7         = @i_tipo_cliente  
      
      if @@rowcount = 0 begin
         select 
       @w_error   = 710022,
       @w_mensaje = 'No existen documentos digitalizados para el cliente ingresado'  
      end 
	  
      update #tmp_doc_digitalizados
      set numero_prestamo = op_banco
      from cob_cartera..ca_operacion
      where op_tramite = tramite
      
      update #tmp_doc_digitalizados set 
      nombre_cliente = gr_nombre
      from cobis..cl_grupo
      where gr_grupo = @i_cliente
      
      goto CONSULTA
   end
   else if @i_tipo_cliente = 'P' begin --Cliente 

      insert into #tmp_doc_digitalizados
      select 
      (select valor  
       from   cobis..cl_catalogo c, 
	          cobis..cl_tabla t
       where t.tabla = 'cr_doc_digitalizado_ind'
       and c.tabla  = t.codigo
       and c.codigo = d.dd_tipo_doc),--1
	  dd_tipo_doc,
      convert(varchar(255),''),
	  @i_cliente,
	  @i_tipo_cliente,
      dd_fecha,
      null,
      null,
      null,
	  dd_extension,
	  'Customer',
	  dd_tipo_doc,
	  null,
	  'PERSONA'
      from cr_documento_digitalizado d
      where dd_cliente       = @i_cliente
      and   (dd_grupo        = 0 or dd_grupo is null)
      and   (dd_inst_proceso = 0 or dd_inst_proceso is null)
	  	  
      if @@rowcount = 0 begin
         select 
         @w_error   = 710022,
         @w_mensaje = 'No existen documentos digitalizados para el grupo ingresado'  
      end 
	   
      update #tmp_doc_digitalizados set 
      nombre_cliente = isnull(en_nombre,'') + ' '+ isnull(p_p_apellido,'')+' '+ isnull(p_s_apellido,'')
      from cobis..cl_ente
      where en_ente = @i_cliente   
	  
	  goto CONSULTA
   end

end
--Solo Filtro Préstamo o Trámite
else if @i_banco is not null or @i_tramite is not null begin

   select @w_tramite = op_tramite
   from cob_cartera..ca_operacion
   where op_banco = @i_banco
   
   select @w_tramite = isnull(@w_tramite,@i_tramite)

   if exists (select 1 from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite) begin
     
	  select @w_id_inst_proceso = io_id_inst_proc
	  from cob_workflow..wf_inst_proceso
	  where io_campo_3 = @w_tramite
	  and   io_campo_7 = 'S'
	  
      insert into #tmp_doc_digitalizados
      select 
      (select valor  
       from   cobis..cl_catalogo c, 
	          cobis..cl_tabla t
       where t.tabla = 'cr_doc_digitalizado'
       and c.tabla  = t.codigo
       and c.codigo = d.dd_tipo_doc),
	  dd_tipo_doc,
      convert(varchar(255),''),
	  dd_cliente,
	  '',
      dd_fecha,
      null,
      @w_tramite,
      dd_inst_proceso,
	  dd_extension,
	  'Customer',
	  dd_tipo_doc, 
	  dd_grupo,
	  'GRUPO'
      from cr_documento_digitalizado d
      where dd_inst_proceso = @w_id_inst_proceso	  
	  
	  update  #tmp_doc_digitalizados set
	  numero_prestamo = op_banco
	  from cob_cartera..ca_operacion
	  where op_tramite = @w_tramite
	  
	  update #tmp_doc_digitalizados set
	  nombre_cliente = isnull(en_nombre,'') + ' '+ isnull(p_p_apellido,'')+' '+ isnull(p_s_apellido,'')
      from cobis..cl_ente
      where en_ente = cod_cliente   
	  
	  goto CONSULTA
   end
   else begin
    	  
	  insert into #tmp_doc_digitalizados
      select 
      td_nombre_tipo_doc, 
      convert(char(10),td_codigo_tipo_doc),
      convert(varchar(255),''),
      io_campo_1,    
      io_campo_7,
      ri_fecha_registro,
      @i_banco,
      @w_tramite,
      io_id_inst_proc,
      substring(ri_nombre_doc, charindex('.',ri_nombre_doc) + 1, len(ri_nombre_doc)),
      'Inbox',
      substring(ri_nombre_doc, 1, charindex('.',ri_nombre_doc) -1),
	  null,
	  'WORKFLOW'
      from cob_workflow..wf_req_inst,
           cob_workflow..wf_inst_proceso,
           cob_workflow..wf_tipo_documento		
      where ri_id_inst_proc    = io_id_inst_proc
      and   td_codigo_tipo_doc = ri_codigo_tipo_doc
      and   io_campo_3         = @w_tramite
	  and   io_campo_7         <> 'S'
	  
	  update  #tmp_doc_digitalizados set
	  numero_prestamo = op_banco
	  from cob_cartera..ca_operacion
	  where op_tramite = @w_tramite
	  
	  update #tmp_doc_digitalizados set
	  nombre_cliente = isnull(en_nombre,'') + ' '+ isnull(p_p_apellido,'')+' '+ isnull(p_s_apellido,'')
      from cobis..cl_ente
      where en_ente = cod_cliente  
	  
	  goto CONSULTA
   end        
end
--Solo Filtro Tipo de Documento
else if @i_tipo_documento is not null and @i_modulo is not null begin

   if @i_modulo = 'WORKFLOW' begin
      insert into #tmp_doc_digitalizados
      select 
      td_nombre_tipo_doc, 
      convert(char(10),td_codigo_tipo_doc),
      convert(varchar(255),''),
      io_campo_1,    
      io_campo_7,
      ri_fecha_registro,
      '',
      io_campo_3,
      io_id_inst_proc,
      substring(ri_nombre_doc, charindex('.',ri_nombre_doc) + 1, len(ri_nombre_doc)),
      'Inbox',
      substring(ri_nombre_doc, 1, charindex('.',ri_nombre_doc) -1),
	  null,
	  'WORKFLOW'
      from cob_workflow..wf_req_inst,
           cob_workflow..wf_inst_proceso,
           cob_workflow..wf_tipo_documento		
      where ri_id_inst_proc    = io_id_inst_proc
      and   td_codigo_tipo_doc = ri_codigo_tipo_doc
      and   td_codigo_tipo_doc = @i_tipo_documento
	  
	  update #tmp_doc_digitalizados
	  set nombre_cliente = gr_nombre
	  from cobis..cl_grupo
	  where tipo_cliente = 'S'
	  and   cod_cliente  = gr_grupo
	
	  
	  update #tmp_doc_digitalizados
	  set nombre_cliente = isnull(en_nombre,'') +' '+ isnull(p_p_apellido, '') + ' '+ isnull(p_s_apellido, '')
	  from cobis..cl_ente
	  where tipo_cliente = 'P'
	  and   cod_cliente  = en_ente
	  
	  update #tmp_doc_digitalizados
	  set numero_prestamo = op_banco
	  from cob_cartera..ca_operacion
	  where op_tramite = tramite
	  
	  goto CONSULTA
   
   end
   else if @i_modulo = 'PERSONA' begin

      insert into #tmp_doc_digitalizados
      select 
      (select valor  
       from   cobis..cl_catalogo c, 
	          cobis..cl_tabla t
       where t.tabla = 'cr_doc_digitalizado_ind'
       and c.tabla  = t.codigo
       and c.codigo = d.dd_tipo_doc),
	  dd_tipo_doc,
      convert(varchar(255),''),
	  dd_cliente,
	  '',
      dd_fecha,
      null,
      null,
      null,
	  dd_extension,
	  'Customer',
	  dd_tipo_doc, 
	  null,
	  'PERSONA'
      from cr_documento_digitalizado d
      where dd_tipo_doc     = @i_tipo_documento
      and   dd_grupo        = 0
      and   dd_inst_proceso = 0
	  
	  update #tmp_doc_digitalizados set 
	  tipo_cliente = en_subtipo,
	  nombre_cliente = isnull(en_nombre,'') +' '+ isnull(p_p_apellido, '') + ' '+ isnull(p_s_apellido, '')
	  from cobis..cl_ente
	  where cod_cliente = en_ente	  
	  
	  goto CONSULTA
   
   end
   else if @i_modulo = 'GRUPO' begin

      insert into #tmp_doc_digitalizados
      select 
      (select valor  
       from   cobis..cl_catalogo c, 
	          cobis..cl_tabla t
       where t.tabla = 'cr_doc_digitalizado'
       and c.tabla  = t.codigo
       and c.codigo = d.dd_tipo_doc),
	  dd_tipo_doc,
      convert(varchar(255),''),
	  dd_cliente,
	  '',
      dd_fecha,
      null,
      null,
      null,
	  dd_extension,
	  'Customer',
	  dd_tipo_doc,
	  dd_inst_proceso,
	  'GRUPO'
      from cr_documento_digitalizado d
      where dd_tipo_doc     = @i_tipo_documento
      and   dd_grupo        <> 0
      and   dd_inst_proceso <> 0
	  
	  update #tmp_doc_digitalizados set 
	  tipo_cliente = en_subtipo,
	  nombre_cliente = isnull(en_nombre,'') +' '+ isnull(p_p_apellido, '') + ' '+ isnull(p_s_apellido, '')
	  from cobis..cl_ente
	  where cod_cliente = en_ente	
	  
	  goto CONSULTA
   
   end

end
return 0

CONSULTA:    

select 
tipo_documento,
cod_tipo_documento,   
nombre_cliente, 
cod_cliente,  
tipo_cliente,     
fecha_ingreso,    
numero_prestamo,  
tramite,
instancia_proceso,
extension,
carpeta,
nombre_documento,
grupo
from #tmp_doc_digitalizados
where (@i_tipo_documento is null or cod_tipo_documento = @i_tipo_documento)
and   (@i_modulo         is null or modulo             = @i_modulo)
and   (@i_tipo_cliente   is null or tipo_cliente       = @i_tipo_cliente)
and   (@i_cliente        is null or cod_cliente        = @i_cliente)
and   (@i_banco          is null or numero_prestamo    = @i_banco)
and   (@i_tramite        is null or tramite            = @i_tramite)

return 0

ERROR:
select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_mensaje)
	  
select @o_msg = ltrim(rtrim(@w_msg))
return @w_error
