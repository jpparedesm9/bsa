USE cobis
go
SET ANSI_NULLS ON
go
SET QUOTED_IDENTIFIER ON
go
/************************************************************/ 
/*   ARCHIVO:         bv_despacho_cons.sp                   */ 
/*   NOMBRE LOGICO:   sp_despacho_cons                      */ 
/*   PRODUCTO:        ADMINBV                               */ 
/************************************************************/ 
/*                     IMPORTANTE                           */ 
/*   Esta aplicacion es parte de los  paquetes bancarios    */ 
/*   propiedad de MACOSA S.A.                               */ 
/*   Su uso no autorizado queda  expresamente  prohibido    */ 
/*   asi como cualquier alteracion o agregado hecho  por    */ 
/*   alguno de sus usuarios sin el debido consentimiento    */ 
/*   por escrito de MACOSA.                                 */ 
/*   Este programa esta protegido por la ley de derechos    */ 
/*   de autor y por las convenciones  internacionales de    */ 
/*   propiedad intelectual.  Su uso  no  autorizado dara    */ 
/*   derecho a MACOSA para obtener ordenes  de secuestro    */ 
/*   o  retencion  y  para  perseguir  penalmente a  los    */ 
/*   autores de cualquier infraccion.                       */ 
/************************************************************/ 
/*                     PROPOSITO                            */ 
/*   Consulta de mensajes a despachar                       */ 
/************************************************************/ 
/*                     MODIFICACIONES                       */ 
/*   FECHA        AUTOR           RAZON                     */ 
/*   26/May/99    Juan Arthos     Emision Inicial           */ 
/*   16/Ago/2017  Wladimir Báez   Homologación BCA          */
/*   08/Sep/2017  Raul Dueñas     Soporte Activo-Activo BCA */
/************************************************************/ 
if object_id('ns_mutex') is not null
				drop table ns_mutex
go
Create table ns_mutex (data int)
go
insert ns_mutex values(1)
go 
create Procedure sp_despacho_cons( 
@s_ssn                int = null, 
@s_user               login = null, 
@s_sesn               int = null, 
@s_term               varchar(30) = null, 
@s_date               datetime = null, 
@s_srv                varchar(30) = null,   
@s_lsrv               varchar(30) = null,   
@s_ofi                smallint = null, 
 
@t_trn                int = null, 
@t_debug              char(1)  = 'N', 
@t_file               varchar(14) = null, 
@t_from               varchar(30) = null,
@t_show_version       tinyint     = 0, 
 
@i_servicio           tinyint = null, 
@i_tipo               varchar(10) = 'MAIL', -- 'SMS'
@i_prioridad          tinyint = null, 
@i_estado             char(1)     = 'P',  -- Pendientes, Cancelados, Finalizados
@i_num_filas          tinyint     = 20,
@i_mode               char(1)     = 'C'   -- N Nuevo o C compatibilidad 
) 
 
As   
 
declare   
  @w_sp_name           varchar(64),
  @w_fecha_envio       datetime  
 
select @w_sp_name = 'sp_despacho_cons',
       @w_fecha_envio = convert (varchar(10),dateadd (dd, -1, getdate()), 101)

 
select @w_sp_name = 'sp_despacho_cons'
--------------------------------------------------------------------------------
--                Mostrar la version del programa
--------------------------------------------------------------------------------
if @t_show_version = 1
begin
  declare @w_message varchar(255)
  select @w_message = 'Stored Procedure: ' + @w_sp_name + ' Version:     ' + '4.0.0.5'
  print @w_message
  return 0
end


 set rowcount @i_num_filas 
--------------------------------------------------------------------------------
--                   MODO DE COMPATIBILIDAD
--------------------------------------------------------------------------------
if @i_mode = 'C'                                                                                                                                                                                                                                                           
begin     
    select 'ID' = nd_id,                                                                                                                                                                                                                     
           'SERVICIO' = nd_servicio,                                                                                                                                                                                             
           'TIPO' = nd_tipo,                                                                                                                                                                                                             
           'TIPOMENSAJE' = nd_tipo_mensaje,                                                         
           'PRIORIDAD' = nd_prioridad,                                                                                                                                                          
           'NUMDIR' = nd_num_dir,                                                                                                                                                                                                 
           'VAR1'   = nd_var1,                                                                                                                                                                                                         
           'VAR2'   = nd_var2,                                                                                                                                                                                                         
           'VAR3'   = nd_var3,                                                                                                                                                                                                         
           'VAR4'   = nd_var4,                                                                                                                                                                                                         
           'VAR5'   = nd_var5,                                                                                                                                                                                                         
           'VAR6'   = nd_var6
    into #tempreq
    from ns_notificaciones_despacho                                                                                                                                                                                               
    where (nd_servicio = @i_servicio or @i_servicio is null)                                                                                                                                                                             
      and nd_tipo = @i_tipo                                                                                                                                                                                                               
      and (nd_prioridad = @i_prioridad or @i_prioridad is null)                                                                                                                                                                      
      and nd_estado = @i_estado  
      and nd_fecha_reg >= @w_fecha_envio                                                                                                                                                                                                     
    order by nd_prioridad
    
    update ns_notificaciones_despacho                                                                                                                                                                                           
    set nd_estado = 'F'
    where nd_id in (select ID from #tempreq)
    
    select 'ID' = ID,                                                                                                                                                                                                                     
           'SERVICIO' = SERVICIO,                                                                                                                                                                                             
           'TIPO' = TIPO,                                                                                                                                                                                                             
           'TIPOMENSAJE' = TIPOMENSAJE,                           
           'PRIORIDAD' = PRIORIDAD,                                                                                                                                                                                         
           'NUMDIR' = NUMDIR,                                                                                                                                                                                                 
           'VAR1'   = VAR1,                                                                                                                                                                                                         
           'VAR2'   = VAR2,                                                                                                                                                                                                         
           'VAR3'   = VAR3,                                                                                                                                                                                                         
           'VAR4'   = VAR4,                                                                                                                                                                                                         
           'VAR5'   = VAR5,                                                                                                                                                                                                         
           'VAR6'   = VAR6
    from #tempreq
end 

if @i_mode = 'N'
begin
   declare @tmp_ns_notificaciones_despacho table
   (nd_id               int                 primary key not null,
    nd_te_id             smallint             null,
    nd_servicio          tinyint              not null,
    nd_ente              int                  not null,
    nd_tipo              varchar(10)          not null,
    nd_tipo_mensaje      char(1)              not null,
    nd_prioridad         tinyint               null,
    nd_num_dir           varchar(64)          not null,
    nd_estado            char(1)              not null,
    nd_num_err           int                  not null,
    nd_txt_err           varchar(64)          not null,
    nd_ret_status        int                  not null,
    nd_fecha_reg         datetime             not null,
    nd_fecha_mod         datetime             not null,
    nd_fecha_auto        datetime             not null,
    nd_var1              varchar(64)          null,
    nd_var2              varchar(64)          null,
    nd_var3              varchar(64)          null,
    nd_var4              varchar(255)         null,
    nd_var5              varchar(255)         null,
    nd_var6              varchar(255)         null,
    nd_var7              varchar(255)         null,
    nd_producto          smallint             null,
    nd_subproducto  varchar(255)         null,
    nd_from              varchar(255)         null,
    nd_to                varchar(255)         null,
    nd_cc                varchar(255)         null,
    nd_bcc               varchar(255)         null,
    nd_subject           nvarchar(255)        null,
    nd_body              ntext                null,
    nd_content_manager   varchar(255)         null,
    nd_retry             char(1)              null,
    nd_max_tries         smallint             null,
    nd_tries             smallint             null,
    nd_fecha_envio       datetime             null,
    nd_hora_ini          datetime             null,
    nd_hora_fin          datetime             null
   )

   declare @tmp_ns_notificaciones_despacho_upd table
   (nd_id               int                 primary key not null)

--   create unique nonclustered index PK_BV_NOTIFICACIONES_DESPACHO on @tmp_ns_notificaciones_despacho(nd_id)

begin tran
   update ns_mutex set data=0

   --------------------------------------------------------------------------------
   --                          MODO NUEVO
   --------------------------------------------------------------------------------
   -- Busca notificaciones x horario
   insert into @tmp_ns_notificaciones_despacho
   select
   nd_id,               nd_te_id,            nd_servicio,
   nd_ente,             nd_tipo,             nd_tipo_mensaje,
   nd_prioridad,        nd_num_dir,          nd_estado,
   nd_num_err,          nd_txt_err,          nd_ret_status,
   nd_fecha_reg,        nd_fecha_mod,        nd_fecha_auto,
   nd_var1,             nd_var2,             nd_var3,
   nd_var4,             nd_var5,             nd_var6,
   nd_var7,             nd_producto,         nd_subproducto,
   nd_from,             nd_to,               nd_cc,
   nd_bcc,              nd_subject,          nd_body,
   nd_content_manager,  nd_retry,            nd_max_tries,
   nd_tries,            nd_fecha_envio,      nd_hora_ini,
   nd_hora_fin
   from ns_notificaciones_despacho
   where nd_estado = 'P'
     and nd_fecha_envio = convert(varchar(10),getdate(),101)
     and datediff(ss, nd_hora_ini, getdate()) > 0
     and datediff(ss, getdate(), nd_hora_fin) > 0
     AND nd_tipo = @i_tipo

   -- Busca notificaciones sin horario
   insert into @tmp_ns_notificaciones_despacho
   select
   nd_id,               nd_te_id,            nd_servicio,
   nd_ente,             nd_tipo,             nd_tipo_mensaje,
   nd_prioridad,        nd_num_dir,          nd_estado,
   nd_num_err,          nd_txt_err,          nd_ret_status,
   nd_fecha_reg,        nd_fecha_mod,        nd_fecha_auto,
   nd_var1,             nd_var2,             nd_var3,
   nd_var4,             nd_var5,             nd_var6,
   nd_var7,             nd_producto,         nd_subproducto,
   nd_from,             nd_to,               nd_cc,
   nd_bcc,              nd_subject,          nd_body,
   nd_content_manager,  nd_retry,            nd_max_tries,
   nd_tries,            nd_fecha_envio,      nd_hora_ini,
   nd_hora_fin
   from ns_notificaciones_despacho
   where nd_estado = 'P'
     and nd_fecha_envio is null
     and nd_hora_ini is null
     and nd_hora_fin is NULL
     AND nd_tipo = @i_tipo
   
   --Busca notificaciones con errores
   insert into @tmp_ns_notificaciones_despacho
   select
   nd_id,               nd_te_id,            nd_servicio,
   nd_ente,             nd_tipo,             nd_tipo_mensaje,
   nd_prioridad,        nd_num_dir,          nd_estado,
   nd_num_err,          nd_txt_err,          nd_ret_status,
   nd_fecha_reg,        nd_fecha_mod,        nd_fecha_auto,
   nd_var1,             nd_var2,             nd_var3,
   nd_var4,             nd_var5,             nd_var6,
   nd_var7,             nd_producto,         nd_subproducto,
   nd_from,             nd_to,               nd_cc,
   nd_bcc,              nd_subject,          nd_body,
   nd_content_manager,  nd_retry,            nd_max_tries,
   nd_tries,            nd_fecha_envio,      nd_hora_ini,
   nd_hora_fin
   from ns_notificaciones_despacho
   where nd_estado = 'C'
      and nd_retry = 'S'
      and nd_tries <  nd_max_tries
      AND nd_tipo = @i_tipo

   insert into @tmp_ns_notificaciones_despacho_upd 
   select nd_id from @tmp_ns_notificaciones_despacho
   WHERE (nd_servicio = @i_servicio or @i_servicio is null)
     and (nd_prioridad = @i_prioridad or @i_prioridad is null)
   order by nd_prioridad

   select 'ID'           = a.nd_id,
          'SERVICIO'     = nd_servicio,
          'TIPO'         = nd_tipo,
          'TIPO MENSAJE' = nd_tipo_mensaje,
          'PRIORIDAD'    = nd_prioridad,
          'NUM-DIR'      = nd_num_dir,
          'VAR1'         = nd_var1,
          'VAR2'         = nd_var2,
          'VAR3'         = nd_var3,
          'VAR4'         = nd_var4,
          'VAR5'         = nd_var5,
          'VAR6'         = nd_var6,
          'VAR7'         = nd_var7,
          'FROM'         = nd_from,
          'TO'           = nd_to,
          'CC'           = nd_cc,
          'BCC'          = nd_bcc,
          'SUBJECT'      = nd_subject,
          'BODY'         = nd_body,
          'CM'           = nd_content_manager,
          'TEMPLATE'     = te_nombre
   from @tmp_ns_notificaciones_despacho a LEFT JOIN ns_template
        ON nd_te_id = te_id,
        @tmp_ns_notificaciones_despacho_upd b
   WHERE a.nd_id=b.nd_id
   order by nd_prioridad
   
   update ns_notificaciones_despacho 
   set nd_estado = 'X'
   where nd_id in (select nd_id from @tmp_ns_notificaciones_despacho_upd)
   
   update ns_mutex set data=1
commit tran   
end

set rowcount 0  
return 0
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
