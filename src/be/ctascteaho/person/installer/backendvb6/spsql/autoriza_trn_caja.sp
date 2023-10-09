/****************************************************************************/
/*     Archivo:     autoriza_trn_caja.sp                                    */
/*     Stored procedure: sp_autoriza_trn_caja                               */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_autoriza_trn_caja')
  drop proc sp_autoriza_trn_caja
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
CREATE procedure sp_autoriza_trn_caja 
( @s_ssn          int         = null,
  @s_user         login       = null,
  @s_sesn         int         = null,
  @s_term         varchar(30) = null,
  @s_date         datetime    = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null, 
  @s_rol          smallint    = null,
  @s_ofi          smallint    = null,
  @s_org_err      char(1)     = null,   
  @s_error        int         = null,
  @s_sev          tinyint     = null,
  @s_msg          descripcion = null,
  @s_org          char(1)     = null,
  @t_debug        char(1)     = 'N',
  @t_file         varchar(14) = null,
  @t_trn          int,     
  
  @i_operacion    char(1),
  @i_modulo       char(3)  = null,
  @i_tran         int      = null, --Nemonico de transaccion en caja
  @i_producto     tinyint  = null,
  @i_sucursal     smallint   = null,
  @i_categoria    varchar(2) = null,
  @i_autorizada   char(1)  = null, --S/N
  @i_estado       char(1)  = null,
  @i_modo         tinyint  = 0,
  @o_autorizada   char(1)  = 'S' output
) 
As 
declare 
  @w_sp_name       varchar(30),
  @w_msg           varchar(255),
  @w_fecha_proceso datetime,
  @w_tran          varchar(10),
  @w_trn           int   
  
 
select @w_sp_name = 'sp_autoriza_trn_caja'

/* FECHA PROCESO */
select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso 
 
/* VALIDACION DE TRANSACCION */ 
if (@t_trn <> 728 and @i_operacion = 'I') or
   (@t_trn <> 729 and @i_operacion = 'U') or
   (@t_trn <> 730 and (@i_operacion = 'S' or @i_operacion = 'V')) or
   (@t_trn <> 731 and @i_operacion = 'N')
begin 
   /* Transaccion no valida */ 
   exec cobis..sp_cerror   
         @i_num  = 351516, 
         @t_from = @w_sp_name 
   return 351516 
end
 
/* ** INSERT ** */ 
if @i_operacion = 'I' 
begin 
   
   /* COMPROBAR EXISTENCIA DE CODIgo DE TRN */
   if not exists(select 1 from cobis..cl_catalogo
             where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_trn_central_local')
             and   codigo = @i_tran)
   begin 
      /* 'Codigo de transaccion no homologado'*/ 
      exec cobis..sp_cerror 
        @t_from    = @w_sp_name, 
        @i_num    = 351572 --cod error
      return 351572 
   end
   
   /* COMPROBAR REGISTROS DUPLICADOS */ 
   if exists ( select 1 from re_aut_tran_caja 
               where at_modulo   = @i_modulo
               and   at_tran     = @i_tran
               and   at_producto = @i_producto
               and   at_categoria = @i_categoria
               and   at_sucursal = @i_sucursal) 
   begin 
      /* 'Parametro duplicado'*/ 
      exec cobis..sp_cerror 
        @t_from    = @w_sp_name, 
        @i_num    = 351047 --cod error
      return 351047 
   end
   
   begin tran    
   
   /* INSERCION DE TRANSACCION */ 
   insert into re_aut_tran_caja  
          (at_modulo,     at_tran,  at_producto,  at_categoria, 
           at_autorizada, at_fecha_crea, at_fecha_upd, at_sucursal,
           at_estado) 
   values (@i_modulo,     @i_tran,  @i_producto,  @i_categoria,
           @i_autorizada, @w_fecha_proceso, null, @i_sucursal,
           'V')
   
   /* Si no se puede insertar error */ 
   if @@error <> 0 
   begin 
      /* 'Error en creacion de parametro '*/ 
      exec cobis..sp_cerror 
        @t_from    = @w_sp_name, 
        @i_num    = 351573 
      
      return 351573 
   end
   
   /* INSERTAR TRANSACCION DE SERVICIO */
   insert into pe_tran_servicio 
   (ts_secuencial, ts_tipo_transaccion, ts_oficina,   ts_usuario,
    ts_terminal,   ts_reentry,          ts_operacion, ts_producto,
    ts_categoria,  ts_fecha_cambio,     ts_servicio_per)
   values 
   (@s_ssn,        @t_trn,              @s_ofi,       @s_user,
    @s_term,       'N',                 @i_operacion, @i_producto,
    @i_categoria,  @w_fecha_proceso,    @i_tran)
    
    if @@error <> 0
    begin
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 353515
       /* 'Error en creacion de transaccion de servicios'*/
       return 353515
    end
    
    commit tran
    return 0  
   
end    --FIN INSERT
 
/* ** UPDATE ** */ 
if @i_operacion = 'U' 
begin 
 
   /* EXISTENCIA DE DATOS */
   if not exists (select 1                    
                  from re_aut_tran_caja 
                  where at_modulo    = @i_modulo
                  and   at_tran      = @i_tran
                  and   at_sucursal  = @i_sucursal
                  and   at_producto  = @i_producto
                  and   at_categoria = @i_categoria)      
   begin 
        /* No existe parametro */ 
      exec cobis..sp_cerror
        @t_from    = @w_sp_name, 
        @i_num    = 351049 
      return 351049 
   end   
   
   begin tran
   
   update re_aut_tran_caja set
   at_estado      = @i_estado,     
   at_autorizada  = @i_autorizada,
   at_fecha_upd   = getdate() --@w_fecha_proceso 
   where at_modulo    = @i_modulo
   and   at_tran      = @i_tran
   and   at_sucursal  = @i_sucursal
   and   at_producto  = @i_producto
   and   at_categoria = @i_categoria
   
   if @@error <> 0 
   begin 
      /* 'Error en actualizacion '*/ 
      exec cobis..sp_cerror
        @t_from    = @w_sp_name, 
        @i_num    = 351574 
        
      return 351574 
   end    
   
   /* INSERTAR TRANSACCION DE SERVICIO */
   insert into pe_tran_servicio 
   (ts_secuencial, ts_tipo_transaccion, ts_oficina,   ts_usuario,
    ts_terminal,   ts_reentry,          ts_operacion, ts_producto,
    ts_categoria,  ts_fecha_cambio,     ts_servicio_per)
   values 
   (@s_ssn,        @t_trn,              @s_ofi,       @s_user,
    @s_term,       'N',                 @i_operacion, @i_producto,
    @i_categoria,  @w_fecha_proceso,    @i_tran) 
    
    if @@error <> 0
    begin
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 353515
       /* 'Error en creacion de transaccion de servicios'*/
       return 353515
    end
          
    commit tran
    return 0

end    --FIN UPDATE


/*** SEARCH ***/
if @i_operacion = 'S' 
begin 
   
   select 
   '1480' = at_modulo,     
   '1789' = at_tran,
   '1736' = at_sucursal,  
   '1653' = at_producto, 
   '1063' = at_categoria, 
   '1024' = at_autorizada, 
   '1356' = convert(varchar,at_fecha_crea,101), 
   '1362' = convert(varchar,at_fecha_upd,101),
   '1333' = at_estado
   from re_aut_tran_caja
   where (at_modulo   = @i_modulo or @i_modulo is null)
   and   (at_producto = @i_producto or @i_producto is null)
   and   (at_tran     = @i_tran   or @i_tran is null)   
   and   (at_categoria = @i_categoria or @i_categoria is null)
   and   (at_sucursal = @i_sucursal or @i_sucursal is null)
   
   if @@rowcount = 0
   begin
      print 'No existen registros'
      return 0
   end
      
end --FIN SEARCH
 
/*** Transaccion Autorizada ***/
if @i_operacion = 'V' 
begin
   
   select @w_trn = convert(int,ltrim(rtrim(codigo))) from cobis..cl_catalogo
   where tabla = (select codigo from cobis..cl_tabla 
                  where tabla = 'cl_trn_central_local')
   and   valor = convert(varchar,@i_tran)
   
   if @w_trn is null
   begin
      select @w_msg = 'No existe codigo de transaccion central asociada al nemonico ' + convert(varchar,@i_tran)
      exec cobis..sp_cerror 
          @t_from = @w_sp_name,
          @i_msg  = @w_msg,
          @i_num  = 351576,
          @i_sev  = 0
      return 1
   end
      
   select @o_autorizada = at_autorizada  
   from re_aut_tran_caja
   where at_modulo    = @i_modulo
   and   at_sucursal  = @i_sucursal
   and   at_producto  = @i_producto
   and   at_categoria = @i_categoria 
   and   at_tran      = @w_trn
   and   at_estado    = 'V'
      
      
   /* SI NO ESTA PARAMETRIZADA, SE ASUME QUE ESTA AUTORIZADA */
   if @o_autorizada is null
      select @o_autorizada = 'S'   
      
end --Fin Value

/* CATALOgo TRANSACCIONES BRANCH */
if @i_operacion = 'N'
begin

   if @i_modo = 0
   begin
      select NEMONICO = ltrim(rtrim(fn_nemonico)), DESCRIPCION = upper(ef_etiqueta)
      into   #tmp_nemonico
      from   cobis..aw_funcionalidad, cobis..aw_etiqueta_funcionalidad, cobis..aw_func_rol
      where  fn_func      = ef_func
      and    fr_func      = ef_func
      and    fn_tipo      = 'F'
      and    fn_padre     like 'TRN%'
      and    (ltrim(rtrim(fn_nemonico))  > convert(varchar,@i_tran) or @i_tran is null)
      and    fn_visible   = 'S'
      order by fn_nemonico
      
      set rowcount 0
      
      select distinct NEMONICO, DESCRIPCION
      from   #tmp_nemonico
      
      set rowcount 0
      return 0
   end
   
   if @i_modo = 1
   begin
      select @w_tran = convert(varchar,@i_tran)

      select ltrim(rtrim(fn_nemonico)), upper(ef_etiqueta)
      from   cobis..aw_funcionalidad, cobis..aw_etiqueta_funcionalidad, cobis..aw_func_rol
      where  fn_func      = ef_func
      and    fr_func      = ef_func
      and    fn_tipo      = 'F'
      and    fn_padre     like 'TRN%'
      and    ltrim(rtrim(fn_nemonico)) = @w_tran
      and    fn_visible   = 'S'
      order by fn_nemonico
   end
end
 
return 0


go
