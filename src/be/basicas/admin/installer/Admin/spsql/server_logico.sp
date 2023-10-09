/************************************************************************/
/* Archivo:    server_l.sp          */
/* Stored procedure: sp_server_logico        */
/* Base de datos:    cobis             */
/* Producto: Administracion               */
/* Disenado por:  Mauricio Bayas/Sandra Ortiz         */
/* Fecha de escritura: 02-Dic-1992              */
/************************************************************************/
/*          IMPORTANTE           */
/* Este programa es parte de los paquetes bancarios propiedad de  */
/* "MACOSA", representantes exclusivos para el Ecuador de la   */
/* "NCR CORPORATION".                  */
/* Su uso no autorizado queda expresamente prohibido asi como  */
/* cualquier alteracion o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de la  */
/* Presidencia Ejecutiva de MACOSA o su representante.      */
/*          PROPOSITO            */
/* Este programa procesa las transacciones de:        */
/* Insercion de server logico             */
/* Borrado de server logico               */
/* Busqueda de server logico              */
/* Query de server logico                 */
/*          MODIFICACIONES          */
/* FECHA    AUTOR    RAZON          */
/* 02/Dic/1992 L. Carvajal Emision inicial         */
/* 07/Jun/1993 M. Davila   Search sin errores           */
/*    08/Mar/1994 F. Espinosa Search Servidores por Producto  */
/*             modo 4 y 5        */
/* 22/Abr/94   F.Espinosa  Parametros tipo "S"     */
/*             Transacciones de Servicio  */
/* 09/May/95   S. Vinces       Admin Distribuido         */
/* 24/Jun/2016 J.Hernandez     Ajuste Vesion Falabella cambio tipo de   */
/*                              dato nodo                               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_server_logico')
   drop proc sp_server_logico



go
create proc sp_server_logico (
   @s_ssn         int = NULL,
   @s_user        login = NULL,
   @s_sesn        int = NULL,
   @s_term        varchar(32) = NULL,
   @s_date        datetime = NULL,
   @s_srv         varchar(30) = NULL,
   @s_lsrv        varchar(30) = NULL, 
   @s_rol         smallint = NULL,
   @s_ofi         smallint = NULL,
   @s_org_err     char(1) = NULL,
   @s_error    int = NULL,
   @s_sev         tinyint = NULL,
   @s_msg         descripcion = NULL,
   @s_org         char(1) = NULL,
   @t_debug    char(1) = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(32) = null,
   @t_trn         smallint =NULL,
   @i_operacion      varchar(1),
   @i_modo     smallint = null,
   @i_filial_i    tinyint = null,
   @i_oficina_i      smallint = null,
   @i_nodo_i         smallint = null,
   @i_filial_p       tinyint = null,
   @i_oficina_p      smallint = null,
   @i_producto       tinyint = NULL,
   @i_tipo           char(1) = NULL,
   @i_moneda         tinyint = NULL,
   @i_registrador    smallint = NULL,
   @i_central_transmit  varchar(1) = null,
        @i_formato_fecha        int = null
)
as
declare
   @w_today    datetime,
   @w_return      int,
   @w_sp_name     varchar(32),
   @w_registrador    int,
   @w_fecha_reg      datetime,
   @o_siguiente      int,
   @o_fecha_reg      datetime,
   @o_nombre_f_i     descripcion,
   @o_nombre_f_p     descripcion,
   @o_nombre_o_i     descripcion,
   @o_nombre_o_p     descripcion,
   @o_nombre_n_i     descripcion,
   @o_nombre_p    descripcion,
   @o_nombre_m    descripcion,
   @o_registrador    smallint,
   @w_fecha_ult_mod  datetime,
   @v_fecha_ult_mod  datetime,
   @o_nombre_reg     descripcion,
   @w_nt_nombre         varchar(32),
   @w_num_nodos         smallint,    
   @w_contador             smallint,    
   @w_cmdtransrv     varchar(64),
   @w_clave    int

select @w_today = @s_date
select @w_sp_name = 'sp_server_logico'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 549
begin
 /* chequeo de claves foraneas */
  if (@i_filial_i is NULL    OR @i_oficina_i is NULL OR @i_nodo_i is NULL
      OR @i_filial_p is NULL OR  @i_oficina_p is NULL
      OR @i_producto is NULL OR  @i_moneda is NULL
      OR @i_tipo is NULL     OR @i_registrador is NULL)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151001
      /*  'No se llenaron todos los campos' */
   return 1
   end

  if not exists (
   select nl_oficina
     from ad_nodo_oficina
     where nl_oficina = @i_oficina_i
       and nl_filial = @i_filial_i
       and  nl_nodo = @i_nodo_i
       and nl_fecha_habil is not NULL
       and nl_estado = 'V')
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitada' */
   return 1
  end


  if not exists (
   select pl_filial
     from cl_pro_oficina
     where pl_filial = @i_filial_p
       and pl_oficina = @i_oficina_p
       and pl_producto = @i_producto
       and pl_moneda = @i_moneda
       and pl_tipo = @i_tipo)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101033
      /*  'No existe producto oficina' */
   return 1
  end

  if not exists (
    select fi_nombre
    from cl_filial
   where fi_filial = @i_filial_p)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial'*/
   return 1
  end

  if not exists (
    select of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_p)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
  end

  if not exists (
   select fu_funcionario
     from cl_funcionario
     where fu_funcionario = @i_registrador)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101036
      /*  'No existe funcionario ' */
   return 1
  end

  if exists (  select sg_filial_i  from ad_server_logico
           where sg_filial_i  = @i_filial_i        
             and sg_oficina_i = @i_oficina_i       
             and sg_nodo_i    = @i_nodo_i          
             and sg_filial_p  = @i_filial_p        
             and sg_oficina_p = @i_oficina_p       
             and sg_producto  = @i_producto        
             and sg_tipo      = @i_tipo           
             and sg_moneda    = @i_moneda  )         
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151074
      
      /*  'Ya existe servidor logico ' */
   return 1
  end
 
  begin tran
  insert into ad_server_logico (sg_filial_i, sg_oficina_i, sg_nodo_i,
               sg_filial_p, sg_oficina_p, sg_producto,
            sg_moneda, sg_tipo, sg_fecha_reg, 
            sg_registrador, sg_estado, sg_fecha_ult_mod)
           values    (@i_filial_i, @i_oficina_i, @i_nodo_i,
               @i_filial_p, @i_oficina_p, @i_producto,
            @i_moneda, @i_tipo, @w_today,
            @i_registrador, 'V', @w_today)
  if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 153012
      /*  'Error en insercion de server logico' */
   return 1
   end

   /* transaccion de servicio */
   insert into ts_server_logico (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
             filial_i, oficina_i, nodo_i,
             filial_p, oficina_p, producto,
             moneda, tipo, fecha_reg,
             registrador, estado, fecha_ult_mod)
           values (@s_ssn, 549, 'N', @s_date,
                       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
             @i_filial_i, @i_oficina_i, @i_nodo_i,
             @i_filial_p, @i_oficina_p, @i_producto,
             @i_moneda, @i_tipo, @w_today,
             @i_registrador,  'V', @w_today)
   if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 153023
      /*  'Error en creacion de transaccion de servicio' */
        return 1
   end
  commit tran

   return 0
end
else
begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151051
      /*  'No corresponde codigo de transaccion' */
   return 1
end
end

/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 551
begin
 /* chequeo de claves foraneas */
  if (@i_filial_i is NULL    OR @i_oficina_i is NULL OR @i_nodo_i is NULL
      OR @i_filial_p is NULL OR  @i_oficina_p is NULL
      OR @i_producto is NULL OR  @i_moneda is NULL
      OR @i_tipo is NULL)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151001
      /*  'No se llenaron todos los campos' */
   return 1
   end

   select @w_fecha_ult_mod = sg_fecha_ult_mod,
          @w_registrador = sg_registrador,
          @w_fecha_reg = @w_fecha_reg
     from ad_server_logico
     where sg_oficina_i = @i_oficina_i
       and sg_filial_i = @i_filial_i
       and  sg_nodo_i = @i_nodo_i
       and sg_oficina_p = @i_oficina_p
       and sg_filial_p = @i_filial_p
       and sg_producto = @i_producto
       and sg_tipo = @i_tipo
       and sg_moneda = @i_moneda
       and sg_estado = 'V'
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151025
      /*  'No existe server logico' */
   return 1
  end

  /* borrado de server logico */
  begin tran
   Delete ad_server_logico
    where sg_oficina_i = @i_oficina_i
      and sg_filial_i = @i_filial_i
      and sg_nodo_i = @i_nodo_i
      and sg_oficina_p = @i_oficina_p
      and sg_filial_p = @i_filial_p
      and sg_producto = @i_producto
      and sg_tipo = @i_tipo
      and sg_moneda = @i_moneda
   if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157027
      /*  'Error en eliminacion de server logico' */
   return 1
   end

  /* transaccion de servicio */
   insert into ts_server_logico (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
             filial_i, oficina_i, nodo_i,
             filial_p, oficina_p, producto,
             moneda, tipo, fecha_reg,
             registrador, estado, fecha_ult_mod)
           values (@s_ssn, 551, 'B', @s_date,
                       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
             @i_filial_i, @i_oficina_i, @i_nodo_i,
             @i_filial_p, @i_oficina_p, @i_producto,
             @i_moneda, @i_tipo, @w_fecha_reg,
             @w_registrador, 'V', @w_fecha_ult_mod)
   if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 153023
      /*  'Error en creacion de transaccion de servicio' */
        return 1
   end
  commit tran

   return 0
end
else
begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151051
      /*  'No corresponde codigo de transaccion' */
   return 1
end
end

/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15048
begin
     set rowcount 20
     if @i_modo = 0
     begin
   select   'Cod. Filial I' = sg_filial_i,
      'Filial I' = X.fi_abreviatura, /*sg_nombre_f_i,*/
      'Cod. Oficina I' = sg_oficina_i,
      'Oficina I' = substring(P.of_nombre, 1, 20),
      'Cod. Nodo I' = sg_nodo_i,
      'Nodo I' = substring(Q.nl_nombre, 1, 20),
      'Cod. Filial P' = sg_filial_p,
      'Filial P' = Y.fi_abreviatura, /*sg_nombre_f_p,*/
      'Cod. Oficina P' = sg_oficina_p,
      'Oficina P' = substring(R.of_nombre, 1, 20),
      'Cod. Producto' = sg_producto,
      'Tipo' = sg_tipo,
      'Cod. Moneda' = sg_moneda,
      'Descripcion' = substring(pm_descripcion,1,30),
      'Registrador' = sg_registrador
    from ad_server_logico, cl_pro_moneda, cl_filial X,
      cl_filial Y, cl_oficina P, cl_oficina R,
      ad_nodo_oficina Q
   where sg_producto = pm_producto
     and sg_moneda = pm_moneda
     and sg_tipo = pm_tipo
     and sg_filial_i = X.fi_filial
     and sg_filial_p = Y.fi_filial
     and sg_nodo_i = Q.nl_nodo
     and sg_filial_i = Q.nl_filial
     and sg_oficina_i = Q.nl_oficina
     and sg_oficina_i = P.of_oficina
     and sg_oficina_p = R.of_oficina
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i,
      sg_filial_p, sg_oficina_p, sg_producto, sg_tipo, sg_moneda
       set rowcount 0
       return 0
     end
    if @i_modo = 1
    begin
     set rowcount 20
   select   'Cod. Filial I' = sg_filial_i,
      'Filial I' = X.fi_abreviatura, /*sg_nombre_f_i,*/
      'Cod. Oficina I' = sg_oficina_i,
      'Oficina I' = substring(P.of_nombre, 1, 20),
      'Cod. Nodo I' = sg_nodo_i,
      'Nodo I' = substring(Q.nl_nombre, 1, 20),
      'Cod. Filial P' = sg_filial_p,
      'Filial P' = Y.fi_abreviatura, /*sg_nombre_f_p,*/
      'Cod. Oficina P' = sg_oficina_p,
      'Oficina P' = substring(R.of_nombre, 1, 20),
      'Cod. Producto' = sg_producto,
      'Tipo' = sg_tipo,
      'Cod. Moneda' = sg_moneda,
      'Descripcion' = substring(pm_descripcion,1,30),
      'Registrador' = sg_registrador
    from ad_server_logico, cl_pro_moneda, cl_filial X,
      cl_filial Y, cl_oficina P, cl_oficina R,
      ad_nodo_oficina Q
   where sg_producto = pm_producto
     and sg_moneda = pm_moneda
     and sg_tipo = pm_tipo
     and sg_filial_i = X.fi_filial
     and sg_filial_p = Y.fi_filial
     and sg_nodo_i = Q.nl_nodo
     and sg_filial_i = Q.nl_filial
     and sg_oficina_i = Q.nl_oficina
     and sg_oficina_i = P.of_oficina
     and sg_oficina_p = R.of_oficina
     and  (
      (sg_filial_i > @i_filial_i)
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i > @i_oficina_i))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i > @i_nodo_i))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i = @i_nodo_i) and (sg_filial_p > @i_filial_p))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i = @i_nodo_i) and (sg_filial_p = @i_filial_p)
      and (sg_oficina_p > @i_oficina_p))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i = @i_nodo_i) and (sg_filial_p = @i_filial_p)
      and (sg_oficina_p = @i_oficina_p) and (sg_producto >
      @i_producto))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i = @i_nodo_i) and (sg_filial_p = @i_filial_p)
      and (sg_oficina_p = @i_oficina_p) and (sg_producto =
      @i_producto) and (sg_tipo > @i_tipo))
     or  ((sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i = @i_nodo_i) and (sg_filial_p = @i_filial_p)
      and (sg_oficina_p = @i_oficina_p) and (sg_producto =
      @i_producto) and (sg_tipo = @i_tipo) and (sg_moneda >
      @i_moneda))
               )
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i,
      sg_filial_p, sg_oficina_p, sg_producto, sg_tipo, sg_moneda
   set rowcount 0
   return 0
     end
     if @i_modo = 2
     begin
   select  'C.F.' = sg_filial_p, 
      'Filial ' = Y.fi_abreviatura,
      'C.O.' = sg_oficina_p,
      'Oficina ' = substring(R.of_nombre, 1, 20),
      'Cod. Producto' = sg_producto,
      'Tipo' = sg_tipo,
      'Cod. Moneda' = sg_moneda,
      'Descripcion' = substring(pm_descripcion, 1, 30)
    from ad_server_logico, cl_pro_moneda, cl_filial Y, cl_oficina R
   where sg_producto = pm_producto
     and sg_moneda = pm_moneda
     and sg_tipo = pm_tipo
     and sg_oficina_p = R.of_oficina
     and sg_filial_p = Y.fi_filial
     and sg_filial_i = @i_filial_i
     and sg_nodo_i = @i_nodo_i
     and sg_oficina_i = @i_oficina_i
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i,
      sg_filial_p, sg_oficina_p, sg_producto, sg_tipo, sg_moneda
       set rowcount 0
       return 0
     end
     if @i_modo = 3
     begin
   select  'C.F.' = sg_filial_p, 
      'Filial ' = Y.fi_abreviatura,
      'C.O.' = sg_oficina_p,
      'Oficina ' = substring(R.of_nombre, 1, 20),
      'Cod. Producto' = sg_producto,
      'Tipo' = sg_tipo,
      'Cod. Moneda' = sg_moneda,
      'Descripcion' = substring(pm_descripcion, 1, 30)
    from ad_server_logico, cl_pro_moneda, cl_filial Y, cl_oficina R
   where sg_producto = pm_producto
     and sg_moneda = pm_moneda
     and sg_tipo = pm_tipo
     and sg_oficina_p = R.of_oficina
     and sg_filial_p = Y.fi_filial
     and sg_filial_i = @i_filial_i
     and sg_nodo_i = @i_nodo_i
     and sg_oficina_i = @i_oficina_i
     and  (
      ((sg_filial_p > @i_filial_p))
     or  ((sg_filial_p = @i_filial_p) and (sg_oficina_p > @i_oficina_p))
     or  ((sg_filial_p = @i_filial_p) and (sg_oficina_p = @i_oficina_p)
      and (sg_producto > @i_producto))
     or  ((sg_filial_p = @i_filial_p) and (sg_oficina_p = @i_oficina_p)
      and (sg_producto = @i_producto) and (sg_tipo > @i_tipo))
     or  ((sg_filial_p = @i_filial_p) and (sg_oficina_p = @i_oficina_p)
      and (sg_producto = @i_producto) and (sg_tipo = @i_tipo)
      and (sg_moneda > @i_moneda))
          )
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i,
      sg_filial_p, sg_oficina_p, sg_producto, sg_tipo, sg_moneda
       set rowcount 0
       return 0
     end

    /*  Search Servidores por Producto */
     if @i_modo = 4
     begin
   select   'Cod. Filial' = sg_filial_i,
      'Filial' = fi_abreviatura,
      'Cod. Oficina' = sg_oficina_i,
      'Oficina' = substring(of_nombre, 1, 20),
      'Cod. Nodo' = sg_nodo_i,
      'Nodo' = substring(nl_nombre, 1, 20)
    from ad_server_logico, cl_filial ,
      cl_oficina , ad_nodo_oficina 
   where sg_filial_i = fi_filial
     and   sg_filial_i = of_filial
     and   sg_oficina_i = of_oficina
     and   sg_filial_i = nl_filial
     and   sg_oficina_i = nl_oficina
     and sg_nodo_i = nl_nodo
     and sg_filial_p = @i_filial_p
     and sg_oficina_p = @i_oficina_p
     and   sg_producto  = @i_producto
     and   sg_moneda    = @i_moneda
     and   sg_tipo      = @i_tipo
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i 
       set rowcount 0
       return 0
     end

    if @i_modo = 5
    begin
     set rowcount 20
   select   'Cod. Filial' = sg_filial_i,
      'Filial' = fi_abreviatura, /*sg_nombre_f_i,*/
      'Cod. Oficina' = sg_oficina_i,
      'Oficina' = substring(of_nombre, 1, 20),
      'Cod. Nodo' = sg_nodo_i,
      'Nodo' = substring(nl_nombre, 1, 20)
    from ad_server_logico, cl_filial ,
      cl_oficina , ad_nodo_oficina 
   where sg_filial_i = fi_filial
     and   sg_filial_i = of_filial
     and   sg_oficina_i = of_oficina
     and   sg_filial_i = nl_filial
     and   sg_oficina_i = nl_oficina
     and sg_nodo_i = nl_nodo
     and sg_filial_p = @i_filial_p
     and sg_oficina_p = @i_oficina_p
     and   sg_producto  = @i_producto
     and   sg_tipo        = @i_tipo
     and   sg_moneda    = @i_moneda
          and ( (sg_filial_i > @i_filial_i)
     or    (sg_filial_i = @i_filial_i) and (sg_oficina_i > @i_oficina_i)
     or  (sg_filial_i = @i_filial_i) and (sg_oficina_i = @i_oficina_i)
      and (sg_nodo_i > @i_nodo_i)
         )
     and sg_estado = 'V'
   order by sg_filial_i, sg_oficina_i, sg_nodo_i 
   set rowcount 0
   return 0
     end
end
else
begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151051
      /*  'No corresponde codigo de transaccion' */
   return 1
end
end

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15049
begin
   select   @o_nombre_m = pm_descripcion,
      @o_registrador = sg_registrador,
      @o_nombre_reg = fu_nombre,
      @o_fecha_reg = sg_fecha_reg
    from ad_server_logico, cl_pro_moneda, cl_funcionario
   where sg_registrador = fu_funcionario
     and sg_producto = pm_producto   and  sg_producto = @i_producto
     and sg_moneda = pm_moneda       and  sg_moneda = @i_moneda
     and sg_tipo = pm_tipo
     and sg_tipo = @i_tipo
     and sg_estado = 'V'
   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,

      @t_from   = @w_sp_name,
      @i_num    = 151025
      /*  'No existe Server logico'*/

    return 1
       end

   select   @o_nombre_f_i = X.fi_nombre,
      @o_nombre_o_i = P.of_nombre,
      @o_nombre_n_i = Q.nl_nombre,
      @o_nombre_f_p = Y.fi_nombre,
      @o_nombre_o_p = R.of_nombre
   from  cl_filial X, cl_filial Y, cl_oficina P,
      cl_oficina R, ad_nodo_oficina Q
   where @i_filial_i = X.fi_filial
     and @i_filial_p = Y.fi_filial
     and @i_nodo_i = Q.nl_nodo
     and @i_filial_i = Q.nl_filial
     and @i_oficina_i = Q.nl_oficina
     and @i_oficina_i = P.of_oficina
     and @i_oficina_p = R.of_oficina
   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151025
      /*  'No existe Server l"gico'*/
    return 1
       end

       select @i_filial_i, @o_nombre_f_i, @i_oficina_i, @o_nombre_o_i,
         @i_nodo_i, @o_nombre_n_i, @i_filial_p, @o_nombre_f_p,
         @i_oficina_p, @o_nombre_o_p, @i_producto,
         @i_tipo, @i_moneda, @o_nombre_m, @o_registrador, @o_nombre_reg,
         convert(char(10), @o_fecha_reg, @i_formato_fecha)
 return 0
end
else
begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151051
      /*  'No corresponde codigo de transaccion' */
   return 1
end
end

go


