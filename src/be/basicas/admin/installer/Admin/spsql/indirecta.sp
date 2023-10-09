/************************************************************************/
/* Archivo:    indirect.sp          */
/* Stored procedure: sp_indirecta            */
/* Base de datos:    cobis             */
/* Producto: Administracion               */
/* Disenado por:  Mauricio Bayas/Sandra Ortiz         */
/* Fecha de escritura: 9-Dic-1992               */
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
/* Insercion de ruta indirecta               */
/* Actualizacion de ruta indirecta              */
/* Borrado de ruta indirecta              */
/* Busqueda de ruta indirecta             */
/* Query de ruta indirecta                */
/*          MODIFICACIONES          */
/* FECHA    AUTOR    RAZON          */
/* 9/Dic/1992  L. Carvajal Emision inicial         */
/* 21/Abr/94   F.Espinosa  Parametros tipo "S"     */
/*             Transacciones de Servicio  */
/*  24/Jun/2016 J.Hernandez     Ajuste Vesion Falabella cambio tipo de  */
/*                              dato nodo                               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_indirecta')
   drop proc sp_indirecta
go

create proc sp_indirecta (
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
   @i_operacion      char(1),
   @i_modo     smallint = null,
        @i_filial_d             tinyint = null,
        @i_oficina_d            smallint = null,
        @i_nodo_d               smallint = null,
        @i_filial_h             tinyint = null,
        @i_oficina_h            smallint = null,
        @i_nodo_h               smallint = null,
        @i_filial_p             tinyint = NULL,
        @i_oficina_p            smallint = NULL,
        @i_nodo_p               smallint = NULL,
        @i_filial_a             tinyint = NULL,
        @i_oficina_a            smallint = NULL,
        @i_nodo_a               smallint = NULL
)

as
declare
   @w_today    datetime,
   @w_sp_name     varchar(32),
   @w_nombre_f_d     descripcion,
   @w_nombre_o_d     descripcion,
   @w_nombre_n_d     descripcion,
   @w_nombre_f_h     descripcion,
   @w_nombre_o_h     descripcion,
   @w_nombre_n_h     descripcion,
   @w_nombre_f_p     descripcion,
   @w_nombre_o_p     descripcion,
   @w_nombre_n_p     descripcion,
   @w_nombre_f_a     descripcion,
   @w_nombre_o_a     descripcion,
   @w_nombre_n_a     descripcion,
   @w_filial_p       tinyint,
   @w_oficina_p      smallint,
   @w_nodo_p         smallint,
   @w_filial_a       tinyint,
   @w_oficina_a      smallint,
   @w_nodo_a         smallint,
   @v_filial_p       tinyint,
   @v_oficina_p      smallint,
   @v_nodo_p         smallint,
   @v_filial_a       tinyint,
   @v_oficina_a      smallint,
   @v_nodo_a         smallint,
   @v_nombre_f_p     descripcion,
   @v_nombre_o_p     descripcion,
   @v_nombre_n_p     descripcion,
   @v_nombre_f_a     descripcion,
   @v_nombre_o_a     descripcion,
   @v_nombre_n_a     descripcion,
   @o_siguiente      int,
   @o_nombre_f_d     descripcion,
   @o_nombre_o_d     descripcion,
   @o_nombre_n_d     descripcion,
   @o_nombre_f_h     descripcion,
   @o_nombre_o_h     descripcion,
   @o_nombre_n_h     descripcion,
   @o_nombre_f_p     descripcion,
   @o_nombre_o_p     descripcion,
   @o_nombre_n_p     descripcion,
   @o_nombre_f_a     descripcion,
   @o_nombre_o_a     descripcion,
   @o_nombre_n_a     descripcion,
   @o_filial_p       tinyint,
   @o_oficina_p      smallint,
   @o_nodo_p         smallint,
   @o_filial_a       tinyint,
   @o_oficina_a      smallint,
   @o_nodo_a         smallint,
   @v_fecha_ult_mod  datetime,
   @w_fecha_ult_mod  datetime,
   @w_return         int

select @w_today = @s_date
select @w_sp_name = 'sp_indirecta'



/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 546
begin
 /* chequeo de claves foraneas */
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
      OR @i_filial_p is NULL  OR @i_oficina_p is NULL OR @i_nodo_p is NULL)
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
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_d
           and nl_filial = @i_filial_d
           and nl_nodo = @i_nodo_d
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
  end

  select @w_nombre_f_d = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_d
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
  end

  select @w_nombre_o_d = of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_d
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
  end

  select @w_nombre_n_d = nl_nombre
    from ad_nodo_oficina
   where nl_nodo = @i_nodo_d
     and nl_filial = @i_filial_d
     and nl_oficina = @i_oficina_d
  if @@rowcount = 0
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
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_h
           and nl_filial = @i_filial_h
           and nl_nodo = @i_nodo_h
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
  end

  select @w_nombre_f_h = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_h
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
  end

  select @w_nombre_o_h = of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_h
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
  end

  select @w_nombre_n_h = nl_nombre
    from ad_nodo_oficina
   where nl_nodo = @i_nodo_h
     and nl_filial = @i_filial_h
     and nl_oficina = @i_oficina_h
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
   return 1
  end

  if not exists (
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_p
           and nl_filial = @i_filial_p
           and nl_nodo = @i_nodo_p
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
  end

  select @w_nombre_f_p = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_p
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
  end

  select @w_nombre_o_p = of_nombre
    from cl_oficina
   where of_oficina = @i_oficina_p
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
  end

  select @w_nombre_n_p = nl_nombre
    from ad_nodo_oficina
   where nl_nodo = @i_nodo_p
     and nl_filial = @i_filial_p
     and nl_oficina = @i_oficina_p
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado ' */
   return 1
  end

  if (@i_oficina_a is not null or @i_filial_a is not null or @i_nodo_a is not null)
  begin
   if not exists (
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_a
           and nl_filial = @i_filial_a
           and nl_nodo = @i_nodo_a
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
   end
   select @w_nombre_f_a = fi_nombre
    from cl_filial
   where fi_filial = @i_filial_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
   end

   select @w_nombre_o_a = of_nombre
     from cl_oficina
    where of_oficina = @i_oficina_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
   end

   select @w_nombre_n_a = nl_nombre
     from ad_nodo_oficina
    where nl_nodo = @i_nodo_a
      and nl_filial = @i_filial_a
      and nl_oficina = @i_oficina_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
   return 1
   end
 end
 else
 begin
       select @w_nombre_f_a = null,
         @w_nombre_o_a = null,
         @w_nombre_n_a = null
 end

 if exists ( select in_filial_d  from ad_indirecta 
              where in_filial_d = @i_filial_d  and  in_oficina_d = @i_oficina_d
                and in_nodo_d   = @i_nodo_d    and  in_filial_h  = @i_filial_h 
                and in_oficina_h = @i_oficina_h and in_nodo_h = @i_nodo_h    
                and in_subtipo   = 'I' )                                    
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151069
      /*  'Ya existe ruta indirecta' */              
        return 1
   end

  begin tran
     insert into ad_indirecta  (in_filial_d, in_oficina_d, in_nodo_d,
                                in_filial_h, in_oficina_h, in_nodo_h,
            in_subtipo,
                                in_filial_p, in_oficina_p, in_nodo_p,
            in_filial_a, in_oficina_a, in_nodo_a,
            in_nombre_f_d, in_nombre_o_d, in_nombre_n_d,
            in_nombre_f_h, in_nombre_o_h, in_nombre_n_h,
            in_nombre_f_p, in_nombre_o_p, in_nombre_n_p,
            in_nombre_f_a, in_nombre_o_a, in_nombre_n_a,
            in_estado, in_fecha_ult_mod)
                        values (@i_filial_d, @i_oficina_d, @i_nodo_d,
                                @i_filial_h, @i_oficina_h, @i_nodo_h,
            'I',
                                @i_filial_p, @i_oficina_p, @i_nodo_p,
            @i_filial_a, @i_oficina_a, @i_nodo_a,
            @w_nombre_f_d, @w_nombre_o_d, @w_nombre_n_d,
            @w_nombre_f_h, @w_nombre_o_h, @w_nombre_n_h,
            @w_nombre_f_p, @w_nombre_o_p, @w_nombre_n_p,
            @w_nombre_f_a, @w_nombre_o_a, @w_nombre_n_a,
            'V', @w_today)
     if @@error != 0
     begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 153020
      /*  'Error en insercion de ruta indirecta' */
        return 1
     end

   /* transaccion de servicio */
   insert into ts_indirecta (secuencia, tipo_transaccion, clase, fecha,
                   oficina_s, usuario, terminal_s, srv, lsrv,
              filial_d, oficina_d, nodo_d,
              filial_h, oficina_h, nodo_h,
              filial_p, oficina_p, nodo_p,
              filial_a, oficina_a, nodo_a,
              nombre_f_d, nombre_o_d, nombre_n_d,
              nombre_f_h, nombre_o_h, nombre_n_h,
              nombre_f_p, nombre_o_p, nombre_n_p,
              nombre_f_a, nombre_o_a, nombre_n_a,
              estado, fecha_ult_mod)
           values (@s_ssn, 546, 'N', @s_date,
                   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,  
              @i_filial_d, @i_oficina_d, @i_nodo_d,
              @i_filial_h, @i_oficina_h, @i_nodo_h,
              @i_filial_p, @i_oficina_p, @i_nodo_p,
              @i_filial_a, @i_oficina_a, @i_nodo_a,
              @w_nombre_f_d, @w_nombre_o_d, @w_nombre_n_d,
              @w_nombre_f_h, @w_nombre_o_h, @w_nombre_n_h,
              @w_nombre_f_p, @w_nombre_o_p, @w_nombre_n_p,
              @w_nombre_f_a, @w_nombre_o_a, @w_nombre_n_a,
              'V', @w_today)
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



/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 547
begin
 /* chequeo de claves foraneas */
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
      OR @i_filial_p is NULL  OR @i_oficina_p is NULL OR @i_nodo_p is NULL)
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151001
      /*  'No se llenaron todos los campos' */
        return 1
  end

  select  @w_nodo_p = in_nodo_p,
          @w_nodo_a = in_nodo_a,
          @w_oficina_p = in_oficina_p,
          @w_oficina_a = in_oficina_a,
          @w_filial_p = in_filial_p,
     @w_filial_a = in_filial_a,
     @w_nombre_f_p = in_nombre_f_p,
     @w_nombre_o_p = in_nombre_o_p,
     @w_nombre_n_p = in_nombre_n_p,
     @w_nombre_f_a = in_nombre_f_a,
     @w_nombre_o_a = in_nombre_o_a,
     @w_nombre_n_a = in_nombre_n_a,
     @v_fecha_ult_mod = in_fecha_ult_mod
     from ad_indirecta
    where in_oficina_d = @i_oficina_d
      and in_filial_d = @i_filial_d
      and in_nodo_d = @i_nodo_d
      and in_oficina_h = @i_oficina_h
      and in_filial_h = @i_filial_h
      and in_nodo_h = @i_nodo_h
      and in_subtipo = 'I'
      and in_estado = 'V'
  if @@rowcount = 0
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151019
      /*  'No existe ruta indirecta' */
        return 1
  end

  if not exists (
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_p
           and nl_filial = @i_filial_p
           and nl_nodo = @i_nodo_p
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
  begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
  end

  if (@i_oficina_a is not null or @i_nodo_a is not null or @i_filial_a is not null)
  begin
   if not exists (
        select nl_filial
          from ad_nodo_oficina
         where nl_oficina = @i_oficina_a
           and nl_filial = @i_filial_a
           and nl_nodo = @i_nodo_a
           and nl_fecha_habil is not NULL
           and nl_estado = 'V')
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
        return 1
   end
  end

/*** verificacion de campos a actualizar ****/
  select @v_nodo_p = @w_nodo_p,
         @v_nodo_a = @w_nodo_a,
         @v_oficina_p = @w_oficina_p,
         @v_oficina_a = @w_oficina_a,
         @v_filial_p = @w_filial_p,
    @v_filial_a = @w_filial_a

  if @w_nodo_p = @i_nodo_p
   select @w_nodo_p   = null, @v_nodo_p   = null
  else
   begin
    select @w_nodo_p = @i_nodo_p
    select @w_nombre_n_p = nl_nombre
      from ad_nodo_oficina
     where nl_nodo = @i_nodo_p
       and nl_filial = @i_filial_p
       and nl_oficina = @i_oficina_p
    if @@rowcount = 0
    begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficina habilitado' */
   return 1
    end
   end

  if @w_nodo_a = @i_nodo_a
   select @w_nodo_a   = null, @v_nodo_a   = null
  else
  begin
   select @w_nodo_a = @i_nodo_a
   select @w_nombre_n_a = nl_nombre
     from ad_nodo_oficina
    where nl_nodo = @i_nodo_a
      and nl_filial = @i_filial_a
      and nl_oficina = @i_oficina_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
      /*  'No existe nodo oficna habilitado' */
   return 1
   end
  end

  if @w_oficina_p = @i_oficina_p
   select @w_oficina_p = null, @v_oficina_p = null
  else
  begin
   select @w_oficina_p = @i_oficina_p
   select @w_nombre_o_p = of_nombre
     from cl_oficina
    where of_oficina = @i_oficina_p
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
   end
  end

  if @w_oficina_a = @i_oficina_a
   select @w_oficina_a = null, @v_oficina_a = null
  else
  begin
   select @w_oficina_a = @i_oficina_a
   select @w_nombre_o_a = of_nombre
     from cl_oficina
    where of_oficina = @i_oficina_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101016
      /*  'No existe oficina' */
   return 1
   end
  end

  if @w_filial_p = @i_filial_p
   select @w_filial_p = null, @v_filial_p = null
  else
  begin
   select @w_filial_p = @i_filial_p
   select @w_nombre_f_p = fi_nombre
     from cl_filial
    where fi_filial = @i_filial_p
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
   end
  end


  if @w_filial_a = @i_filial_a
   select @w_filial_a = null, @v_filial_a = null
  else
  begin
   select @w_filial_a = @i_filial_a
   select @w_nombre_f_a = fi_nombre
     from cl_filial
    where fi_filial = @i_filial_a
   if @@rowcount = 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 101002
      /*  'No existe filial' */
   return 1
   end
  end

  begin tran
   Update ad_indirecta
      set in_nodo_p = @i_nodo_p,
          in_nodo_a = @i_nodo_a,
          in_oficina_p = @i_oficina_p,
          in_oficina_a = @i_oficina_a,
          in_filial_p = @i_filial_p,
     in_filial_a = @i_filial_a,
     in_nombre_f_p = @w_nombre_f_p,
     in_nombre_o_p = @w_nombre_o_p,
     in_nombre_n_p = @w_nombre_n_p,
     in_nombre_f_a = @w_nombre_f_a,
     in_nombre_o_a = @w_nombre_o_a,
     in_nombre_n_a = @w_nombre_n_a,
     in_fecha_ult_mod = @w_today
    where in_oficina_d = @i_oficina_d
      and in_filial_d = @i_filial_d
      and in_nodo_d = @i_nodo_d
      and in_oficina_h = @i_oficina_h
      and in_filial_h = @i_filial_h
      and in_nodo_h = @i_nodo_h
      and in_subtipo = 'I'
   if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 155016
      /*  'Error en actualizacion de ruta indirecta' */
        return 1
   end

  /* transaccion de servicio */
   insert into ts_indirecta (secuencia, tipo_transaccion, clase, fecha,
                   oficina_s, usuario, terminal_s, srv, lsrv,
              filial_d, oficina_d, nodo_d,
              filial_h, oficina_h, nodo_h,
              filial_p, oficina_p, nodo_p,
              filial_a, oficina_a, nodo_a,
              nombre_f_d, nombre_o_d, nombre_n_d,
              nombre_f_h, nombre_o_h, nombre_n_h,
              nombre_f_p, nombre_o_p, nombre_n_p,
              nombre_f_a, nombre_o_a, nombre_n_a,
              estado, fecha_ult_mod)
           values (@s_ssn, 547, 'P', @s_date,
                   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,  
              @i_filial_d, @i_oficina_d, @i_nodo_d,
              @i_filial_h, @i_oficina_h, @i_nodo_h,
              @v_filial_p, @v_oficina_p, @v_nodo_p,
              @v_filial_a, @v_oficina_a, @v_nodo_a,
              null, null, null, null, null, null,
              @v_nombre_f_p, @v_nombre_o_p, @v_nombre_n_p,
              @v_nombre_f_a, @v_nombre_o_a, @v_nombre_n_a,
              null, @v_fecha_ult_mod)
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

   insert into ts_indirecta (secuencia, tipo_transaccion, clase, fecha,
                   oficina_s, usuario, terminal_s, srv, lsrv,
              filial_d, oficina_d, nodo_d,
              filial_h, oficina_h, nodo_h,
              filial_p, oficina_p, nodo_p,
              filial_a, oficina_a, nodo_a,
              nombre_f_d, nombre_o_d, nombre_n_d,
              nombre_f_h, nombre_o_h, nombre_n_h,
              nombre_f_p, nombre_o_p, nombre_n_p,
              nombre_f_a, nombre_o_a, nombre_n_a,
              estado, fecha_ult_mod)
           values (@s_ssn, 547, 'A', @s_date,
                   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,  
              @i_filial_d, @i_oficina_d, @i_nodo_d,
              @i_filial_h, @i_oficina_h, @i_nodo_h,
              @w_filial_p, @w_oficina_p, @w_nodo_p,
              @w_filial_a, @w_oficina_a, @w_nodo_a,
              null, null, null, null, null, null,
              @w_nombre_f_p, @w_nombre_o_p, @w_nombre_n_p,
              @w_nombre_f_a, @w_nombre_o_a, @w_nombre_n_a,
              null, @w_today)
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


if @i_operacion = 'D' or @i_operacion = 'Q' or @i_operacion = 'S'
begin
  exec @w_return = sp_indirecta_2
      @s_ssn      = @s_ssn,      
      @s_user     = @s_user,  
      @s_sesn     = @s_sesn,
      @s_term     = @s_term,  
      @s_date     = @s_date,
      @s_srv      = @s_srv,
      @s_lsrv     = @s_lsrv,  
      @s_rol      = @s_rol,
      @s_ofi      = @s_ofi,   
      @s_org_err  = @s_org_err,
      @s_error = @s_error,
      @s_sev      = @s_sev,
      @s_msg      = @s_msg,
      @s_org      = @s_org,
      @t_debug = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @t_trn      = @t_trn,   
      @i_operacion         = @i_operacion,
      @i_modo           = @i_modo,
      @i_filial_d       = @i_filial_d,
      @i_oficina_d         = @i_oficina_d,
      @i_nodo_d         = @i_nodo_d,
      @i_filial_h       = @i_filial_h,
      @i_oficina_h         = @i_oficina_h,
      @i_nodo_h         = @i_nodo_h,
      @i_filial_p       = @i_filial_p,
      @i_oficina_p         = @i_oficina_p,
      @i_nodo_p         = @i_nodo_p,
      @i_filial_a       = @i_filial_a,
      @i_oficina_a         = @i_oficina_a,
      @i_nodo_a         = @i_nodo_a
  if @w_return != 0
      return @w_return
end
go

