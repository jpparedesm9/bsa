/*******************************************************************/
/*  Archivo:          constrnrep.sp                                */
/*  Stored procedure: sp_cons_trns                                 */
/*  Base de datos:    con_conta_super                              */
/*  Producto:         Regulatorios                                 */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Realiza consultas a las transacciones reportadas                */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          I. Yupa        Emision Inicial             */
/*******************************************************************/

use cob_conta_super
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_cons_trns')
   drop proc sp_cons_trns
go

create proc sp_cons_trns 
(
    @p_lssn             int            = null,
    @s_ssn              int            = null,
    @s_ssn_branch       int            = null, 
    @s_srv              varchar(30)    = null,
    @s_lsrv             varchar(30)    = null,
    @s_user             varchar(30)    = null,
    @s_sesn             int            = null,
    @s_term             varchar(32)    = null,
    @s_date             datetime       = null,
    @s_ofi              smallint       = null,
    @s_rol              smallint       = 1,
    @s_org_err          char(1)        = null,
    @s_error            int            = null,
    @s_sev              tinyint        = null,
    @s_msg              varchar(255)   = null,  
    @s_org              char(1)        = null,       
    @t_debug            char(1)        = 'N',
    @t_file             varchar(14)    = null,
    @t_from             varchar(32)    = null,
    @t_rty              char(1)        = 'N',
    @t_show_version     bit            = 0,   
    @t_trn              int            = null,      
    @t_ssn_corr         int            = null,        
    @i_operacion        char(1)        = null,
    @i_fecha_desde      datetime       = null,
    @i_fecha_hasta      datetime       = null,
    @i_formato_fecha    int            = null,
    @i_causal           char(5)        = null,
    @i_estado           char(1)        = null,
    @i_modo             int            = null,
    @i_codigo           int            = null,
	@i_funcionario      varchar(64)    =null ,
	@i_descripcion       varchar(255)  =null
)
as
declare
    @w_return           int,
    @w_sp_name          varchar(30),
	@w_registro         int,
	@w_fecha_proc      datetime
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_cons_trns'

if @t_show_version = 1
   begin
      print 'Stored procedure sp_cons_trns, Version 4.0.0.1'
      return 0
   end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug 
	   @t_file=@t_file
    select '/** Store Procedure **/' = @w_sp_name,
       s_ssn          = @s_ssn,
       s_srv          = @s_srv,
       s_lsrv         = @s_lsrv,
       s_user         = @s_user,
       s_sesn         = @s_sesn,
       s_term         = @s_term,
       s_date         = @s_date,
       s_ofi          = @s_ofi,
       s_rol          = @s_rol,
       s_org_err      = @s_org_err,
       s_error        = @s_error,
       s_sev          = @s_sev,
       s_msg          = @s_msg,
       s_org          = @s_org,   
       t_from         = @t_from,
       t_file         = @t_file, 
       t_rty          = @t_rty,
       t_trn          = @t_trn,
       i_operacion    = @i_operacion,       
       i_fecha_desde  = @i_fecha_desde,     
       i_fecha_hasta  = @i_fecha_hasta,     
       i_formato_fecha= @i_formato_fecha,   
       i_causal       = @i_causal,          
       i_estado       = @i_estado,          
       i_modo         = @i_modo,            
       i_codigo       = @i_codigo
      	   
           
    exec cobis..sp_end_debug
end

if @t_trn <> 36002
begin
  exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 3600000,     
   @i_sev    = 0   
   return 3600000    
end

 if @i_causal = '' 
   select @i_causal = null

 if @i_estado = '' 
     select @i_estado = null

select @w_fecha_proc  = fp_fecha 
FROM cobis..ba_fecha_proceso

if @i_operacion = 'A'
begin
    update cob_conta_super..sb_consulta_transacciones
    set ct_24h = 'S',
        ct_usuario = @s_user
        --ct_estado = 'R'
    where ct_secuencial = @i_codigo
    if @@error <> 0
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 3600001,     
        @i_sev    = 0   
        return 3600001  
    end
end

if @i_operacion = 'B'
begin
    if @i_modo = 0
    begin
        set rowcount 20
        SELECT  '50001' = ct_ente,
                '50002' =isnull(ct_nombre,'') + ' ' + isnull(ct_apellido,'') + ' ' + isnull(ct_funcionario,''),
                '50003' = ct_cuenta,
                '50004' = ct_saldo,
                '50005' = isnull((select valor 
                             from cobis..cl_catalogo 
                             where tabla in (select codigo 
                                         from cobis..cl_tabla 
                                         where tabla = 'sb_causa_reportado')
                            and codigo = ct_causa),''),
                '50006' = ct_monto_transaccion,
                '50007' = isnull((select valor 
                             from cobis..cl_catalogo 
                              where tabla in (select codigo 
                                                from cobis..cl_tabla 
                                                where tabla = 'cl_estados_reportado')
                             and codigo = ct_estado),''),
                '50008' = ct_24h,               
                '50009' = ct_estado,                
                '50000' = ct_secuencial,
                '50010' = isnull((SELECT valor 
                            FROM cobis..cl_catalogo 
                            WHERE tabla in (SELECT codigo 
                                            FROM cobis..cl_tabla 
                                            WHERE tabla = 'cl_refinh')
                            AND codigo = ct_origen),''),
                '50011' = isnull((SELECT pd_descripcion 
                            FROM cobis..cl_producto 
                            WHERE pd_producto = ct_aplicativo),''),
                '50012' = ct_causa
        FROM cob_conta_super..sb_consulta_transacciones
        WHERE ((ct_fecha = @i_fecha_desde) OR
               (ct_fecha BETWEEN @i_fecha_desde AND @i_fecha_hasta))
        AND ct_causa = isnull(@i_causal,ct_causa)
        AND ct_estado = isnull(@i_estado,ct_estado)
        ORDER BY ct_secuencial
    if @@ROWCOUNT < > 1
        return 1
    end

    if @i_modo = 1
    begin
        set rowcount 20
        SELECT  '50001' = ct_ente,
                '50002' =isnull(ct_nombre,'') + ' ' + isnull(ct_apellido,'') + ' ' + isnull(ct_funcionario,''),
                '50003' = ct_cuenta,
                '50004' = ct_saldo,
                '50005' = isnull((select valor 
                             from cobis..cl_catalogo 
                             where tabla in (select codigo 
                                         from cobis..cl_tabla 
                                         where tabla = 'sb_causa_reportado')
                            and codigo = ct_causa),''),
                '50006' = ct_monto_transaccion,
                '50007' = isnull((select valor 
                             from cobis..cl_catalogo 
                              where tabla in (select codigo 
                                                from cobis..cl_tabla 
                                                where tabla = 'cl_estados_reportado')
                             and codigo = ct_estado),''),
                '50008' = ct_24h,               
                '50009' = ct_estado,                
                '50000' = ct_secuencial,
                '50010' = isnull((SELECT valor 
                            FROM cobis..cl_catalogo 
                            WHERE tabla in (SELECT codigo 
                                            FROM cobis..cl_tabla 
                                            WHERE tabla = 'cl_refinh')
                            AND codigo = ct_origen),''),
                '50011' = isnull((SELECT pd_descripcion 
                            FROM cobis..cl_producto 
                            WHERE pd_producto = ct_aplicativo),''),
                '50012' = ct_causa
        FROM cob_conta_super..sb_consulta_transacciones
        WHERE ((ct_fecha = @i_fecha_desde) OR
               (ct_fecha BETWEEN @i_fecha_desde AND @i_fecha_hasta))
        AND ct_causa = isnull(@i_causal,ct_causa)
        AND ct_estado = isnull(@i_estado,ct_estado)
        AND ct_secuencial > @i_codigo
        ORDER BY ct_secuencial
        if @@ROWCOUNT <> 1
        return 1
    end

end
---reportes de operaciones
if @i_operacion = 'C'
begin
select @w_registro = isnull(max(ct_secuencial) + 1,1)  from sb_consulta_transacciones
insert into sb_consulta_transacciones (ct_secuencial, ct_fecha,  ct_causa,ct_estado  , ct_funcionario, ct_descripcion,ct_24h)
values                                 (@w_registro,  @w_fecha_proc,'OPPR', 'G',@i_funcionario,@i_descripcion,'N')
                                           
 if @@error != 0 
    begin
     /* error al insertar el reporte de la operación */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 3600001
      return 3600001
    end
end

  return 0

go
