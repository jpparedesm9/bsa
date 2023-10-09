/************************************************************************/
/*  Archivo:            re_puntocb.sp                                   */
/*  Stored procedure:   sp_punto_red_cb                                 */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Corresponsales Bancarios                        */
/*  Disenado por:       David Salcedo M.                                */
/*  Fecha de escritura: 03-Dic-2013                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Req 381. Stored Procedure para almacenar informacion acerca de los  */
/*  puntos de atención de la red posicionada.                           */
/************************************************************************/
use cob_remesas
go
 
if exists (select 1 from sysobjects where name = 'sp_punto_red_cb')
   drop proc sp_punto_red_cb
GO
CREATE proc sp_punto_red_cb (
@s_ssn           int,
@s_user          login,
@s_date          datetime,
@s_ofi           smallint,
@s_term          varchar(10),
@t_trn           int,
@i_codigo_cb     int,
@i_codigo_punto  varchar(10)  = null,
@i_nombre        varchar(64)  = null,
@i_tipo_ced      varchar(3)   = null,
@i_ced_ruc       varchar(15)  = null,
@i_cod_depto     varchar(10)  = null,
@i_cod_ciudad    varchar(10)  = null,
@i_direccion     varchar(64)  = null,
@i_estado        char(1)      = null,
@i_operacion     char(2),
@i_modo          int          = null,
@i_tipo_p        char(1)      = null
)
as
declare
@w_mensaje   varchar(255),
@w_error     int,
@w_sp_name   varchar(50)
select @w_sp_name   = 'sp_punto_red_cb',
       @w_error     = 0
-- Validar datos requeridos
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_codigo_cb is null
   begin
      select @w_error = 2609823, @w_mensaje = 'CODIGO DEL CORRESPONSAL BANCARIO NO ENVIADO'
      goto ERROR
   end
   if @i_codigo_punto is null
   begin
      select @w_error = 2609824, @w_mensaje = 'CODIGO DEL PUNTO DE RED NO ENVIADO'
      goto ERROR
   end
   if @i_nombre is null
   begin
      select @w_error = 2609825, @w_mensaje = 'NOMBRE DEL PUNTO DE RED NO ENVIADO'
      goto ERROR
   end
   if @i_tipo_ced is null
   begin
      select @w_error = 2609826, @w_mensaje = 'TIPO DE DOCUMENTO DEL ADMINISTRADOR DEL PUNTO DE RED NO ENVIADO'
      goto ERROR
   end
   if @i_ced_ruc is null
   begin
      select @w_error = 2609827, @w_mensaje = 'NUMERO DE DOCUMENTO DEL ADMINISTRADOR DEL PUNTO DE RED NO ENVIADO'
      goto ERROR
   end
   if @i_cod_depto is null
   begin
      select @w_error = 2609828, @w_mensaje = 'CODIGO DANE DEL DEPARTAMENTO NO ENVIADO'
      goto ERROR
   end
   if @i_cod_ciudad is null
   begin
      select @w_error = 2609829, @w_mensaje = 'CODIGO DANE DE LA CIUDAD O MUNICIPIO NO ENVIADO'
      goto ERROR
   end
   if @i_direccion is null
   begin
      select @w_error = 2609830, @w_mensaje = 'DIRECCION DEL PUNTO DE RED NO ENVIADO'
      goto ERROR
   end
   if @i_estado is null
   begin
      select @w_error = 2609831, @w_mensaje = 'ESTADO DEL REGISTRO NO ENVIADO'
      goto ERROR
   end
   if exists (select 1
              from cob_remesas..re_mantenimiento_cb
              where mc_cod_cb =  @i_codigo_cb
              and   mc_estado <> 'H')
    begin
       select @w_error = 2609866, @w_mensaje = 'CORRESPONSAL BANCARIO SE ENCUENTRA DESHABILITADO'
       goto ERROR
    end
end
if @i_operacion = 'I'
begin
   -- Validar que el punto de red no se encuentra registrado
   if exists (select 1 from re_punto_red_cb where pr_codigo_cb = @i_codigo_cb and pr_codigo_punto = @i_codigo_punto)
   begin
      select @w_error = 2609832, @w_mensaje = 'PUNTO DE ATENCION YA INGRESADO'
      goto ERROR
   end
   -- Insertar el punto de red
   insert into re_punto_red_cb
   (
      pr_codigo_cb  , pr_codigo_punto , pr_nombre , pr_tipo_ced , pr_ced_ruc, pr_cod_depto,
      pr_cod_ciudad , pr_direccion    , pr_estado , pr_tipo_p
   )
   values
   (
      @i_codigo_cb  , @i_codigo_punto , @i_nombre, @i_tipo_ced, @i_ced_ruc, @i_cod_depto,
      @i_cod_ciudad , @i_direccion    , @i_estado, @i_tipo_p
   )
   if @@error <> 0
   begin
      select @w_error = 2609833, @w_mensaje = 'ERROR INSERTANDO PUNTO DE ATENCION'
      goto ERROR
   end
   -- Insertar la transaccion en la tabla re_tran_servicio
   insert into re_tran_servicio
   (
      ts_int1     , ts_varchar2     , ts_char1     , ts_varchar7 , ts_varchar3 , ts_varchar1  , ts_varchar4   ,
      ts_varchar5 , ts_descripcion1 , ts_datetime1 , ts_operador , ts_tsfecha  , ts_oficina   , ts_secuencial ,
      ts_terminal , ts_tipo_transaccion
   )
   values
   (
      @i_codigo_cb , @i_codigo_punto , @i_estado , @i_nombre , @i_cod_depto , @i_cod_ciudad , @i_tipo_ced ,
      @i_ced_ruc   , @i_direccion    , getdate() , @s_user   , @s_date      , @s_ofi        , @s_ssn      ,
      @s_term      , @t_trn
   )
   if @@error <> 0
   begin
      select @w_error = 143005, @w_mensaje = 'ERROR INSERTANDO TRANSACCION DE SERVICIO'
      goto ERROR
   end
end
if @i_operacion = 'U'
begin
   -- Validar que el punto de red se encuentra registrado
   if not exists (select 1 from re_punto_red_cb where pr_codigo_cb = @i_codigo_cb and pr_codigo_punto = @i_codigo_punto)
   begin
      select @w_error = 2609834, @w_mensaje = 'NO EXISTE REGISTRO A MODIFICAR'
      goto ERROR
   end
   -- Actualizar el punto de red
   update re_punto_red_cb set pr_nombre = @i_nombre, pr_tipo_ced = @i_tipo_ced, pr_ced_ruc = @i_ced_ruc,
                              pr_cod_depto = @i_cod_depto, pr_cod_ciudad = @i_cod_ciudad, pr_direccion = @i_direccion,
                              pr_estado = @i_estado, pr_tipo_p = @i_tipo_p
   where pr_codigo_cb    = @i_codigo_cb
   and   pr_codigo_punto = @i_codigo_punto
   if @@error <> 0
   begin
      select @w_error = 2609835, @w_mensaje = 'ERROR ACTUALIZANDO PUNTO DE ATENCION DE RED'
      goto ERROR
   end
   -- Insertar la transaccion en la tabla re_tran_servicio
   insert into re_tran_servicio
   (
      ts_int1     , ts_varchar2     , ts_char1     , ts_varchar7 , ts_varchar3 , ts_varchar1  , ts_varchar4   ,
      ts_varchar5 , ts_descripcion1 , ts_datetime1 , ts_operador , ts_tsfecha  , ts_oficina   , ts_secuencial ,
      ts_terminal , ts_tipo_transaccion
   )
   values
   (
      @i_codigo_cb , @i_codigo_punto , @i_estado , @i_nombre , @i_cod_depto , @i_cod_ciudad , @i_tipo_ced ,
      @i_ced_ruc   , @i_direccion    , getdate() , @s_user   , @s_date      , @s_ofi        , @s_ssn      ,
      @s_term      , @t_trn
   )
   if @@error <> 0
   begin
      select @w_error = 143005, @w_mensaje = 'ERROR INSERTANDO TRANSACCION DE SERVICIO'
      goto ERROR
   end
end
if @i_operacion = 'S'
begin
   if @i_modo = 0
   begin
      delete from cob_remesas..re_punto_red_cb_tmp
      where pr_usuario   = @s_user
      insert into re_punto_red_cb_tmp
      select
         ROW_NUMBER() over (order by pr_codigo_punto asc),
         @i_codigo_cb,
         pr_codigo_punto,
         pr_nombre,
         pr_tipo_ced,
         pr_ced_ruc,
         pr_cod_depto,
         (select c.pv_descripcion  from cobis..cl_provincia c
          where c.pv_provincia= pr_cod_depto),
         pr_cod_ciudad,
         (select c.ci_descripcion from cobis..cl_ciudad c
          where c.ci_ciudad  = pr_cod_ciudad),
         pr_direccion,
         (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
          where t.tabla = 're_estado_servicio'
          and   t.codigo = c.tabla
          and   c.codigo = pr_estado),
         pr_tipo_p,
         @s_user
      from cob_remesas..re_punto_red_cb
      where pr_codigo_cb = @i_codigo_cb
      order by pr_codigo_punto asc
      set rowcount 20
      select
         'COD PUNTO'      = pr_codigo_punto   ,
         'NOMBRE PUNTO'   = pr_nombre         ,
         'TIPO DOC'       = pr_tipo_ced       ,
         'NUM DOCUMENTO'  = pr_ced_ruc        ,
         'COD DEPTO'      = pr_cod_depto      ,
         'DEPARTAMENTO'   = pr_depto_desc     ,
         'COD CIUDAD'     = pr_cod_ciudad     ,
         'CIUDAD'         = pr_ciudad_desc    ,
         'DIRECCION'      = pr_direccion      ,
         'ESTADO'         = pr_estado         ,
         'TIPO PERSONA'   = pr_tipo_p         ,
         'SEC'            = pr_secuencial
      from cob_remesas..re_punto_red_cb_tmp
      where pr_codigo_cb = @i_codigo_cb
      and   pr_usuario   = @s_user
      order by pr_secuencial asc
      if @@rowcount = 0
      begin
         select @w_error = 2609836, @w_mensaje = 'NO EXISTE REGISTROS DE PUNTOS DE ATENCION DE LA RED POSICIONADA'
         goto ERROR
      end
   end
   else
   begin
      set rowcount 20
      select
         'COD PUNTO'      = pr_codigo_punto   ,
         'NOMBRE PUNTO'   = pr_nombre         ,
         'TIPO DOC'       = pr_tipo_ced       ,
         'NUM DOCUMENTO'  = pr_ced_ruc        ,
         'COD DEPTO'      = pr_cod_depto      ,
         'DEPARTAMENTO'   = pr_depto_desc     ,
         'COD CIUDAD'     = pr_cod_ciudad     ,
         'CIUDAD'         = pr_ciudad_desc    ,
         'DIRECCION'      = pr_direccion      ,
         'ESTADO'         = pr_estado         ,
         'TIPO PERSONA'   = pr_tipo_p         ,
         'SEC'            = pr_secuencial
      from cob_remesas..re_punto_red_cb_tmp
      where pr_codigo_cb  = @i_codigo_cb
      and   pr_usuario    = @s_user
      and   pr_secuencial > @i_codigo_punto
      order by pr_secuencial asc
      if @@rowcount < 20
      begin
         delete from cob_remesas..re_punto_red_cb_tmp
         where pr_usuario   = @s_user
      end
   end
end
if @i_operacion = 'S1'
begin
   if @i_modo = 0
   begin
      delete from cob_remesas..re_punto_red_cb_tmp
      where pr_usuario   = @s_user
      insert into re_punto_red_cb_tmp
      select
         ROW_NUMBER() over (order by pr_codigo_punto asc),
         @i_codigo_cb,
         pr_codigo_punto,
         pr_nombre,
         pr_tipo_ced,
         pr_ced_ruc,
         pr_cod_depto,
         (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
          where t.tabla = 'cl_provincia'
          and   t.codigo = c.tabla
          and   c.codigo = pr_cod_depto),
         pr_cod_ciudad,
         (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
          where t.tabla = 'cl_ciudad'
          and   t.codigo = c.tabla
          and   c.codigo = pr_cod_ciudad),
         pr_direccion,
         (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
          where t.tabla = 're_estado_servicio'
          and   t.codigo = c.tabla
          and   c.codigo = pr_estado),
         pr_tipo_p,
         @s_user
      from cob_remesas..re_punto_red_cb
      where pr_codigo_cb  = @i_codigo_cb
      order by pr_codigo_punto asc
      set rowcount 20
      select
         'SEC'            = pr_secuencial     ,
         'COD PUNTO'      = pr_codigo_punto   ,
         'NOMBRE PUNTO'   = pr_nombre
      from cob_remesas..re_punto_red_cb_tmp
      where pr_codigo_cb = @i_codigo_cb
      and   pr_usuario   = @s_user
      order by pr_secuencial asc
      if @@rowcount = 0
      begin
         select @w_error = 2609836, @w_mensaje = 'NO EXISTE REGISTROS DE PUNTOS DE ATENCION DE LA RED POSICIONADA'
         goto ERROR
      end
   end
   else
   begin
      set rowcount 20
      select
         'SEC'            = pr_secuencial     ,
         'COD PUNTO'      = pr_codigo_punto   ,
         'NOMBRE PUNTO'   = pr_nombre
      from cob_remesas..re_punto_red_cb_tmp
      where pr_codigo_cb  = @i_codigo_cb
      and   pr_usuario    = @s_user
      and   pr_secuencial > @i_codigo_punto
      order by pr_secuencial asc
      if @@rowcount < 20
      begin
         delete from cob_remesas..re_punto_red_cb_tmp
         where pr_usuario   = @s_user
      end
   end
end
if @i_operacion = 'H'
begin
   if @i_modo = 0
   begin
      set rowcount 20
      select
         'COD PUNTO'      = pr_codigo_punto,
         'NOMBRE PUNTO'   = pr_nombre
      from cob_remesas..re_punto_red_cb
      where pr_codigo_cb    = @i_codigo_cb
      and   pr_codigo_punto > @i_codigo_punto
      order by pr_codigo_punto asc
   end
   if @i_modo = 1
   begin
      set rowcount 20
      select
         'COD PUNTO'      = pr_codigo_punto,
         'NOMBRE PUNTO'   = pr_nombre
      from cob_remesas..re_punto_red_cb
      where pr_codigo_cb    = @i_codigo_cb
      and   pr_codigo_punto = @i_codigo_punto
      order by pr_codigo_punto asc
   end
end
if @i_operacion = 'Q'
begin
   if @i_modo = 0
   begin
      select
         'COD PUNTO'      =  pr_codigo_punto,
         'NOMBRE PUNTO'   = pr_nombre,
         'TIPO DOC'       = pr_tipo_ced,
         'NUM DOCUMENTO'  = pr_ced_ruc,
         'COD DEPTO'      = pr_cod_depto,
         'DEPARTAMENTO'   = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                             where t.tabla = 'cl_provincia'
                             and   t.codigo = c.tabla
                             and   c.codigo = pr_cod_depto),
         'COD CIUDAD'     = pr_cod_ciudad,
         'CIUDAD'         = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                             where t.tabla = 'cl_ciudad'
                             and   t.codigo = c.tabla
                             and   c.codigo = pr_cod_ciudad),
         'DIRECCION'      = pr_direccion,
         'ESTADO'         = (select c.valor from cobis..cl_tabla t, cobis..cl_catalogo c
                             where t.tabla = 're_estado_servicio'
                             and   t.codigo = c.tabla
                             and   c.codigo = pr_estado),
         'TIPO DOC'       = pr_tipo_ced,pr_tipo_p
      from cob_remesas..re_punto_red_cb
      where pr_codigo_cb    = @i_codigo_cb
      and   pr_codigo_punto = @i_codigo_punto
      order by pr_codigo_punto asc
   end
end
return 0
ERROR:
   exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error,
   @i_msg  = @w_mensaje,
   @i_sev  = 0
return @w_error
GO