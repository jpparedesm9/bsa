/************************************************************************/
/*      Archivo:                bdd.sp                                  */
/*      Stored procedure:       sp_base_datos                           */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 02-Dic-1992                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de base de datos                                      */
/*      Actualizacion de base de datos                                  */
/*      Borrado de base de datos                                        */
/*      Busqueda de base de datos                                       */
/*      Query de base de datos                                          */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      02/Dic/1992     L. Carvajal     Emision inicial                 */
/*  07/Jun/1993 M. Davila   Search sin mensaje de error                 */
/*                  sp_error con @t_from                                */
/*  20/Abr/94   F.Espinosa  Parametros tipo "S"                         */
/*                  Transacciones de Servicio                           */
/*  24/Jun/2016 J.Hernandez     Ajuste Vesion Falabella cambio tipo de  */
/*                              dato nodo                               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_base_datos')
drop proc sp_base_datos
go

create proc sp_base_datos (
@s_ssn          int = NULL,
@s_user         login = NULL,
@s_sesn         int = NULL,
@s_term         varchar(32) = NULL,
@s_date         datetime = NULL,
@s_srv          varchar(30) = NULL,
@s_lsrv         varchar(30) = NULL, 
@s_rol          smallint = NULL,
@s_ofi          smallint = NULL,
@s_org_err      char(1) = NULL,
@s_error        int = NULL,
@s_sev          tinyint = NULL,
@s_msg          descripcion = NULL,
@s_org          char(1) = NULL,
@t_debug        char(1) = 'N',
@t_file         varchar(14) = null,
@t_from         varchar(32) = null,
@t_trn          smallint =NULL,
@i_operacion            char(1),
@i_modo                 smallint = null,
@i_filial               tinyint = null,
@i_oficina              smallint = null,
@i_nodo                 smallint = null,
@i_base                 char(30) = NULL,
@i_tamanio              smallint = NULL,
@i_registrador          smallint = NULL,
@i_formato_fecha        int = NULL
)
as
declare
@w_today                datetime,
@w_sp_name              varchar(32),
@w_filial               tinyint,
@w_oficina              smallint,
@w_nodo                 smallint,
@w_base                 char(30),
@w_tamanio              smallint,
@w_registrador          smallint,
@v_filial               tinyint,
@v_oficina              smallint,
@v_nodo                 smallint,
@v_base                 char(30),
@v_tamanio              smallint,
@v_registrador          smallint,
@o_siguiente            int,
@o_fecha_reg            datetime,
@o_filial               tinyint,
@o_oficina              smallint,
@o_nodo                 smallint,
@o_nombre_f             descripcion,
@o_nombre_o             descripcion,
@o_nombre_n             descripcion,
@o_base                 char(30),
@o_tamanio              smallint,
@o_registrador          smallint,
@w_fecha_reg            datetime,
@w_fecha_ult_mod        datetime,
@v_fecha_ult_mod        datetime,
@o_nombre_reg           descripcion,
@o_nombre_hab           descripcion

select @w_today = @s_date
select @w_sp_name = 'sp_base_datos'



/* ** Insert ** */
if @i_operacion = 'I' 
begin
if @t_trn = 504
begin
/* chequeo de claves foraneas */
if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
OR @i_base is NULL OR @i_registrador is NULL )
begin
/* 'No se llenaron todos los campos' */
exec sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 151001
return 1
end

if not exists (
 select nl_oficina
   from ad_nodo_oficina
  where nl_oficina = @i_oficina
    and nl_filial = @i_filial
    and nl_nodo = @i_nodo
    and nl_fecha_habil is not NULL
    and nl_estado = 'V')
begin
/*  'No existe nodo oficina habilitado' */
exec sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 151002
return 1
end

if not exists (
select fu_funcionario
  from cl_funcionario
  where fu_funcionario = @i_registrador)
begin
/*  'No existe funcionario ' */
exec sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 101036
return 1
end

if exists ( select bd_filial  from ad_base_datos
             where bd_filial      = @i_filial
           and bd_oficina     = @i_oficina
           and bd_nodo        = @i_nodo
           and bd_base        = @i_base )
begin
/*  'Ya existe base de datos' */
exec sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 151071
return 1
end

begin tran
insert into ad_base_datos (bd_filial, bd_oficina, bd_nodo,
            bd_base, bd_tamanio, bd_fecha_reg, 
            bd_registrador,
            bd_estado, bd_fecha_ult_mod)
         values    (@i_filial, @i_oficina, @i_nodo,
            @i_base, @i_tamanio, @w_today,
            @i_registrador,
            'V', @w_today)
if @@error != 0
begin
/*  'Error en insercion de base de datos' */
exec sp_cerror
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num        = 153013
return 1
end
/* transaccion de servicio - terminal */
     insert into ts_base_datos (secuencia, tipo_transaccion, clase, fecha,
                oficina_s, usuario, terminal_s, srv, lsrv,
                filial, oficina, nodo, base, tamanio,
                fecha_reg, registrador,
                estado, fecha_ult_mod)
             values    (@s_ssn, 504, 'N', @s_date,
                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_filial, @i_oficina, @i_nodo,@i_base,
                @i_tamanio, @w_today, @i_registrador,
                'V', @w_today)
     if @@error != 0
     begin
    /* 'Error en creacion de transaccion de servicio' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 153023
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


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 505
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_base is NULL OR @i_registrador is NULL)
  begin
    /* 'No se llenaron todos los campos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 151001
    return 1
   end

  select @w_registrador = bd_registrador,
     @w_tamanio = bd_tamanio,
     @w_fecha_ult_mod = bd_fecha_ult_mod
    from ad_base_datos
   where bd_oficina = @i_oficina
     and bd_filial = @i_filial
     and bd_nodo = @i_nodo
     and bd_base = @i_base
     and bd_estado = 'V'
  if @@rowcount = 0
  begin
    /*  'No existe base de datos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 151017
    return 1
  end

  if @w_registrador != @i_registrador
  begin
    /*  'Campo no puede actualizarse' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 155000
    return 1
  end
  

/*** verificacion de campos a actualizar ***/
  select @v_tamanio = @w_tamanio,
     @v_fecha_ult_mod = @w_fecha_ult_mod

  if @w_tamanio = @i_tamanio
   select @w_tamanio = null, @v_tamanio = null
  else
   select @w_tamanio = @i_tamanio


  begin tran
   Update ad_base_datos
      set bd_tamanio = @i_tamanio,
      bd_fecha_ult_mod = @w_today
    where bd_oficina = @i_oficina
      and bd_filial = @i_filial
      and bd_nodo = @i_nodo
      and bd_base = @i_base
  if @@error != 0
   begin
    /*  'Error en actualizaci"n de base de datos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 155060
    return 1
   end
  /* transaccion de servicio - terminal */
     insert into ts_base_datos (secuencia, tipo_transaccion, clase, fecha,
                oficina_s, usuario, terminal_s, srv, lsrv,
                filial, oficina, nodo, base, tamanio,
                fecha_reg, registrador,
                estado, fecha_ult_mod)
             values    (@s_ssn, 505, 'P', @s_date,
                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_filial, @i_oficina, @i_nodo, @i_base,
                @v_tamanio, null, null,
                null, @v_fecha_ult_mod)
     if @@error != 0
     begin
    /*  'Error en creacion de transaccion de servicio' */

    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 153023
    return 1
      end

     insert into ts_base_datos (secuencia, tipo_transaccion, clase, fecha,
                oficina_s, usuario, terminal_s, srv, lsrv,
                filial, oficina, nodo, base, tamanio,
                fecha_reg, registrador,
                estado, fecha_ult_mod)
             values    (@s_ssn, 505, 'A', @s_date,
                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_filial, @i_oficina, @i_nodo, @i_base,
                @w_tamanio, null, null,
                null, @w_today)
     if @@error != 0
     begin
    /*  'Error en creacion de transaccion de servicio' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 153023
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
if @t_trn = 506
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_base is NULL)
  begin
    /*  'No se llenaron todos los campos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 151001
    return 1
   end

  select @w_registrador = bd_registrador,
     @w_tamanio = bd_tamanio,
     @w_fecha_reg = bd_fecha_reg,
     @w_fecha_ult_mod = bd_fecha_ult_mod
    from ad_base_datos
   where bd_oficina = @i_oficina
     and bd_filial = @i_filial
     and bd_nodo = @i_nodo
     and bd_base = @i_base
     and bd_estado = 'V'
  if @@rowcount = 0
  begin
    /*  'No existe base de datos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 151017
    return 1
  end


  /* borrado de base de datos */
  begin tran
    Delete ad_base_datos
     where bd_oficina = @i_oficina
       and bd_filial = @i_filial
       and bd_nodo = @i_nodo
       and bd_base = @i_base
    if @@error != 0
    begin
    /*  'Error en eliminacion de base de datos' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 157028
    return 1
    end
     insert into ts_base_datos (secuencia, tipo_transaccion, clase, fecha,
                oficina_s, usuario, terminal_s, srv, lsrv,
                filial, oficina, nodo, base, tamanio,
                fecha_reg, registrador,
                estado, fecha_ult_mod)
             values    (@s_ssn, 506, 'B', @s_date,
                @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_filial, @i_oficina, @i_nodo, @i_base,
                @w_tamanio, @w_fecha_reg, @w_registrador,
                'V', @w_fecha_ult_mod)
     if @@error != 0
     begin
    /*  'Error en creacion de transaccion de servicio' */
    exec sp_cerror
       @t_debug      = @t_debug,
       @t_file       = @t_file,
       @t_from       = @w_sp_name,
       @i_num        = 153023
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
if @t_trn = 1581
begin
     set rowcount 20
     if @i_modo = 0
     begin
    select  'Base de datos' = substring(bd_base, 1, 20),
        'Tamanio' = bd_tamanio,
        'Registrador' = bd_registrador,
        'Nombre Reg' = fu_nombre
     from   ad_base_datos, 
        cl_funcionario 
    where   bd_registrador = fu_funcionario
      and   bd_filial = @i_filial
      and   bd_oficina = @i_oficina
      and   bd_nodo = @i_nodo
      and   bd_estado = 'V'
    order   by bd_filial, bd_oficina, bd_nodo, bd_base
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
    select  'Base de datos' = substring(bd_base,1,20),
        'Tamanio' = bd_tamanio,
        'Registrador' = bd_registrador,
        'Nombre Reg' = fu_nombre
     from   ad_base_datos, 
        cl_funcionario
    where   bd_registrador = fu_funcionario
      and   bd_filial = @i_filial
      and   bd_oficina = @i_oficina
      and   bd_nodo = @i_nodo
      and   bd_base > @i_base
      and   bd_estado = 'V'
    order   by bd_filial, bd_oficina, bd_nodo, bd_base
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

if @i_operacion = 'Q'
begin
if @t_trn = 1582
begin
        select @o_nombre_f = fi_nombre,
               @o_nombre_o = of_nombre,
               @o_nombre_n = nl_nombre,
               @o_tamanio = bd_tamanio,
               @o_fecha_reg = bd_fecha_reg,
               @o_registrador = bd_registrador
          from ad_base_datos, cl_filial, cl_oficina,
               ad_nodo_oficina
         where bd_filial = fi_filial
           and bd_oficina = of_oficina
           and bd_filial = nl_filial
           and bd_oficina = nl_oficina
           and bd_nodo = nl_nodo
           and bd_filial = @i_filial
           and bd_oficina = @i_oficina
           and bd_nodo = @i_nodo
           and bd_base = @i_base
        if @@rowcount = 0
        begin
        /*  'No existe Base de datos ' */
         exec sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 151017
        return 1
        end

    select @o_nombre_hab= ''

    select @o_nombre_reg = fu_nombre
      from cl_funcionario
     where fu_funcionario = @o_registrador
    if @@rowcount = 0
    begin
    /* 'No existe funcionario' */
       exec sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num   = 101036
    end

    select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o,
           @i_nodo, @o_nombre_n, @i_base, @o_tamanio,
           @o_registrador, @o_nombre_reg, 
           convert(char(10), @o_fecha_reg, @i_formato_fecha), @o_nombre_hab 

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

