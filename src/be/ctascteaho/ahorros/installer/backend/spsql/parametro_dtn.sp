/************************************************************************/
/*      Archivo:                parametro_dtn.sp                        */
/*      Stored procedure:       sp_parametro_dtn                        */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  ACTUALIZACION DE CODIGO DTN                                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_parametro_dtn')
   drop proc sp_parametro_dtn
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_parametro_dtn(
 @s_ssn            int         = null,
 @s_user           varchar(30) = null,
 @s_term           varchar(10),
 @s_ofi            smallint,
 @t_trn            int,
 @t_show_version   bit = 0,
 @i_operacion      char(1),
 @i_sucursal       int,
 @i_profinal       smallint = null,
 @i_categoria      char(1)  = null,
 @i_codigo_dtn     char(2)  = null,
 @i_codigo_dtn_new char(2)  = null,
 @i_secuencial     int      = null
)
as
declare
 @w_sp_name     varchar(30),
 @w_msg         varchar(64),
 @w_error       int,
 @w_descripcion varchar(64),
 @w_fecha_proceso datetime

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_parametro_dtn'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso


/* VALIDACION DE TRANSACCION */
if (@t_trn <> 385 and @i_operacion = 'I') or
   (@t_trn <> 386 and @i_operacion = 'U') or
   (@t_trn <> 387 and @i_operacion = 'D') or
   (@t_trn <> 388 and @i_operacion = 'S') or
   (@t_trn <> 389 and @i_operacion = 'Q')
begin
   /* Transaccion no valida */
   select @w_error  = 251060,
          @w_msg    = 'TRANSACCION NO PERMITIDA'
   goto ERROR
end

/* OPERACION INSERCION */
if @i_operacion = 'I'
begin
   if exists(select 1 from cob_ahorros..ah_param_dtn
             where pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2))
   begin
      /* Registro ya existe */
      select @w_error = 251106,
             @w_msg   = 'El codigo para DTN digitado ya existe.'
      goto ERROR
   end

   if exists(select 1 from cob_ahorros..ah_param_dtn
             where pd_sucursal  = @i_sucursal
             and   pd_profinal  = @i_profinal
             and   pd_categoria = @i_categoria)
   begin
      /* Registro ya existe */
      select @w_error = 251106,
             @w_msg   = 'Ya existe codigo DTN para Producto y Categoria indicada'
      goto ERROR
   end

   begin tran

   insert into cob_ahorros..ah_param_dtn
   (pd_sucursal, pd_profinal, pd_categoria, pd_codigo_dtn, pd_estado)
   select
   @i_sucursal, @i_profinal, @i_categoria, right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2), 'V'
   if @@error <> 0
   begin
      /* Error insertando registro */
      select @w_error = 288500
      goto ERROR
   end

   insert into cob_ahorros..ah_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_cod_alterno,
    ts_usuario,    ts_terminal,         ts_oficina,       ts_filial,
    ts_producto,   ts_categoria,        ts_ofi_aut,
    ts_clase,      ts_servicio,         ts_descripcion_ec)
   select
    @s_ssn,        @t_trn,              @w_fecha_proceso, 0,
    @s_user,       @s_term,             @s_ofi,           1,
    @i_profinal,   @i_categoria,        @i_sucursal,
    @i_operacion,  right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2),       'INSERCION DE CODIGO DTN'
   if @@error <> 0
   begin
      /* Error insertando transaccion de servicio */
      select @w_error = 253004
      goto ERROR
   end

   commit tran
end

/* OPERACION ACTUALIZACION */
if @i_operacion = 'U'
begin
   if not exists(select 1 from cob_ahorros..ah_param_dtn
             where pd_sucursal  = @i_sucursal
             and   pd_profinal  = @i_profinal
             and   pd_categoria = @i_categoria
             and   pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2))
   begin
      /* Registro no existe */
      select @w_error = 251107
      goto ERROR
   end

   if exists(select 1 from cob_ahorros..ah_param_dtn
             where pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn_new)), 2))
   begin
      /* Registro ya existe */
      select @w_error = 251106,
             @w_msg   = 'El codigo para DTN digitado ya existe.'
      goto ERROR
   end

   if exists(select 1 from cob_ahorros..ah_param_dtn
             where pd_sucursal  = @i_sucursal
             and   pd_profinal  = @i_profinal
             and   pd_categoria = @i_categoria
             and   pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn_new)), 2))
   begin
      /* Registro ya existe */
      select @w_error = 251106,
             @w_msg   = 'Ya existe codigo DTN para Producto y Categoria indicada'
      goto ERROR
   end

   begin tran

   update cob_ahorros..ah_param_dtn set
   pd_codigo_dtn = @i_codigo_dtn_new
   where pd_sucursal  = @i_sucursal
   and   pd_profinal  = @i_profinal
   and   pd_categoria = @i_categoria
   and   pd_codigo_dtn = @i_codigo_dtn
   if @@error <> 0
   begin
      /* Registro actualizando registro */
      select @w_error = 288502
      goto ERROR
   end

   select @w_descripcion = 'ACTUALIZACION DE CODIGO DTN'

   insert into cob_ahorros..ah_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_cod_alterno,
    ts_usuario,    ts_terminal,         ts_oficina,       ts_filial,
    ts_producto,   ts_categoria,        ts_ofi_aut,
    ts_clase,      ts_servicio,         ts_descripcion_ec)
   select
    @s_ssn,        @t_trn,              @w_fecha_proceso, 0,
    @s_user,       @s_term,             @s_ofi,           1,
    @i_profinal,   @i_categoria,        @i_sucursal,
    @i_operacion,  @i_codigo_dtn,       @w_descripcion
   if @@error <> 0
   begin
      /* Error insertando transaccion de servicio */
      select @w_error = 253004
      goto ERROR
   end

   commit tran
end

/* OPERACION INSERCION */
if @i_operacion = 'D'
begin
   if not exists(select 1 from cob_ahorros..ah_param_dtn
                 where pd_sucursal  = @i_sucursal
                 and   pd_profinal  = @i_profinal
                 and   pd_categoria = @i_categoria
                 and   pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2))
   begin
      /* Registro no existe */
      select @w_error = 251107
      goto ERROR
   end

   if exists(select 1 from cob_remesas..re_tesoro_nacional
             where tn_grupo = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2))
   begin
      /* CODIGO PARA DTN EN USO PARA TRASLADO DE CUENTAS */
      select @w_error = 251108
      goto ERROR
   end

   begin tran

   delete from cob_ahorros..ah_param_dtn
   where pd_sucursal  = @i_sucursal
   and   pd_profinal  = @i_profinal
   and   pd_categoria = @i_categoria
   and   pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2)
   if @@error <> 0
   begin
      /* Error eliminando registro */
      select @w_error = 288501
      goto ERROR
   end

   select @w_descripcion = 'ELIMINACION DE CODIGO PARA DTN'

   insert into cob_ahorros..ah_tran_servicio
   (ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_cod_alterno,
    ts_usuario,    ts_terminal,         ts_oficina,       ts_filial,
    ts_producto,   ts_categoria,        ts_ofi_aut,
    ts_clase,      ts_servicio,         ts_descripcion_ec)
   select
    @s_ssn,        @t_trn,              @w_fecha_proceso, 0,
    @s_user,       @s_term,             @s_ofi,           1,
    @i_profinal,   @i_categoria,        @i_sucursal,
    @i_operacion,  right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2),       @w_descripcion
   if @@error <> 0
   begin
      /* Error insertando transaccion de servicio */
      select @w_error = 253004
      goto ERROR
   end

   commit tran
end
/* OPERACION SEARCH */
if @i_operacion = 'S'
begin
   create table #search
  (pd_secuencial   int identity(1,1),
   pd_codigo_dtn   char(2)     not null,
   pd_profinal     smallint    not null,
   pd_nom_profinal varchar(64) not null,
   pd_categoria    char(1)     not null,
   pd_nom_cat      varchar(64) not null,
   pd_sucursal     int         not null)

   insert into #search
   select
   pd_codigo_dtn,
   pd_profinal,
   pd_nom_profinal = (select pf_descripcion from cob_remesas..pe_pro_final where pf_pro_final = pd_profinal),
   pd_categoria,
   pd_nom_cat = (select C.valor from cobis..cl_tabla T, cobis..cl_catalogo C
                 where T.codigo = C.tabla and T.tabla = 'pe_categoria' and C.estado = 'V' and C.codigo = pd_categoria),
   pd_sucursal
   from cob_ahorros..ah_param_dtn
   where pd_sucursal = @i_sucursal
   order by pd_profinal, pd_categoria, pd_codigo_dtn

   set rowcount 20

   select
   pd_codigo_dtn,
   pd_profinal,
   pd_nom_profinal,
   pd_categoria,
   pd_nom_cat,
   pd_sucursal
   from #search
   where pd_secuencial >= isnull(@i_secuencial,0)

   set rowcount  0
end

/* OPERACION QUERY */
if @i_operacion = 'Q'
begin
   select
   pd_codigo_dtn,
   pd_profinal,
   (select pf_descripcion from cob_remesas..pe_pro_final where pf_pro_final = pd_profinal),
   pd_categoria,
   (select C.valor from cobis..cl_tabla T, cobis..cl_catalogo C
    where T.codigo = C.tabla and T.tabla = 'pe_categoria' and C.estado = 'V' and C.codigo = pd_categoria),
   pd_sucursal
   from cob_ahorros..ah_param_dtn
   where pd_sucursal   = @i_sucursal
   and   pd_profinal   = @i_profinal
   and   pd_categoria  = @i_categoria
   and   pd_codigo_dtn = right(replicate('0', 2) + rtrim(ltrim(@i_codigo_dtn)), 2)
   order by pd_sucursal, pd_profinal, pd_categoria, pd_codigo_dtn
end

return 0

ERROR:

   exec cobis..sp_cerror
         @i_num  = @w_error,
         @t_from = @w_sp_name,
         @i_msg  = @w_msg

   return @w_error

go

