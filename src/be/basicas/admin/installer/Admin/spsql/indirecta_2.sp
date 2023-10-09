/************************************************************************/
/* Archivo:    indirec2.sp          */
/* Stored procedure: sp_indirecta_2          */
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
/*      7/Jun/1993      M. Davila       Search sin errores              */
/* 22/Abr/94   F.Espinosa  Parametros tipo "S"     */
/*             Transacciones de Servicio  */
/*  24/Jun/2016 J.Hernandez     Ajuste Vesion Falabella cambio tipo de  */
/*                              dato nodo                               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_indirecta_2')
   drop proc sp_indirecta_2
go

create proc sp_indirecta_2 (
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
select @w_sp_name = 'sp_indirecta_2'





/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 548
begin
 /* chequeo de claves foraneas */
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
     )
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
     @w_fecha_ult_mod = in_fecha_ult_mod
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

  /* borrado de ruta indirecta */
  begin tran
   Delete ad_indirecta
    where in_oficina_d = @i_oficina_d
      and in_filial_d = @i_filial_d
      and in_nodo_d = @i_nodo_d
      and in_oficina_h = @i_oficina_h
      and in_filial_h = @i_filial_h
      and in_nodo_h = @i_nodo_h
   if @@error != 0
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157037
      /*  'Error en eliminacion de ruta indirecta' */
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
           values (@s_ssn, 548, 'B', @s_date,
                   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,  
              @i_filial_d, @i_oficina_d, @i_nodo_d,
              @i_filial_h, @i_oficina_h, @i_nodo_h,
              @w_filial_p, @w_oficina_p, @w_nodo_p,
              @w_filial_a, @w_oficina_a, @w_nodo_a,
              null, null, null, null, null, null,
              @w_nombre_f_p, @w_nombre_o_p, @w_nombre_n_p,
              @w_nombre_f_a, @w_nombre_o_a, @w_nombre_n_a,
              null, @w_fecha_ult_mod)
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
If @t_trn = 15005
begin
     set rowcount 20
     if @i_modo = 0
     begin
   select   'Cod. Filial I' = in_filial_d,
      'Filial I' = substring(in_nombre_f_d, 1, 20),
      'Cod. Oficina I' = in_oficina_d,
      'Oficina I' = substring(in_nombre_o_d, 1, 20),
      'Cod. Nodo I' = in_nodo_d,
      'Nodo I' = substring(in_nombre_n_d, 1, 20),
      'Cod. Filial H' = in_filial_h,
      'Filial H' = substring(in_nombre_f_h, 1, 20),
      'Cod. Oficina H' = in_oficina_h,
      'Oficina H' = substring(in_nombre_o_h, 1, 20),
      'Cod. Nodo H' = in_nodo_h,
      'Nodo H' = substring(in_nombre_n_h, 1, 20),
      'Cod. Filial P' = in_filial_p,
      'Filial P' = substring(in_nombre_f_p, 1, 20),
      'Cod. Oficina P' = in_oficina_p,
      'Oficina P' = substring(in_nombre_o_p, 1, 20),
      'Cod. Nodo P' = in_nodo_p,
      'Nodo P' = substring(in_nombre_n_p, 1, 20),
      'Cod. Filial S' = in_filial_a,
      'Filial S' = substring(in_nombre_f_a, 1, 20),
      'Cod. Oficina S' = in_oficina_a,
      'Oficina S' = substring(in_nombre_o_a, 1, 20),
      'Cod. Nodo S' = in_nodo_a,
      'Nodo S' = substring(in_nombre_n_a, 1, 20)
    from ad_indirecta
   where in_estado = 'V'
   order by in_filial_d, in_oficina_d, in_nodo_d,
      in_filial_h, in_oficina_h, in_nodo_h,
      in_filial_p, in_oficina_p, in_nodo_p,
      in_filial_a, in_oficina_a, in_nodo_a
       set rowcount 0
     end
     if @i_modo = 1
     begin
   select   'Cod. Filial I' = in_filial_d,
      'Filial I' = substring(in_nombre_f_d, 1, 20),
      'Cod. Oficina I' = in_oficina_d,
      'Oficina I' = substring(in_nombre_o_d, 1, 20),
      'Cod. Nodo I' = in_nodo_d,
      'Nodo I' = substring(in_nombre_n_d, 1, 20),
      'Cod. Filial H' = in_filial_h,
      'Filial H' = substring(in_nombre_f_h, 1, 20),
      'Cod. Oficina H' = in_oficina_h,
      'Oficina H' = substring(in_nombre_o_h, 1, 20),
      'Cod. Nodo H' = in_nodo_h,
      'Nodo H' = substring(in_nombre_n_h, 1, 20),
      'Cod. Filial P' = in_filial_p,
      'Filial P' = substring(in_nombre_f_p, 1, 20),
      'Cod. Oficina P' = in_oficina_p,
      'Oficina P' = substring(in_nombre_o_p, 1, 20),
      'Cod. Nodo P' = in_nodo_p,
      'Nodo P' = substring(in_nombre_n_p, 1, 20),
      'Cod. Filial S' = in_filial_a,
      'Filial S' = substring(in_nombre_f_a, 1, 20),
      'Cod. Oficina S' = in_oficina_a,
      'Oficina S' = substring(in_nombre_o_a, 1, 20),
      'Cod. Nodo S' = in_nodo_a,
      'Nodo S' = substring(in_nombre_n_a, 1, 20)
    from ad_indirecta
   where in_estado = 'V'
          and  ( 
      (in_filial_d > @i_filial_d)
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d > @i_oficina_d))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d > @i_nodo_d))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h > @i_filial_h))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h > @i_oficina_h))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h >
      @i_nodo_h))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p > @i_filial_p))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p = @i_filial_p) and (in_oficina_p >
      @i_oficina_p))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p = @i_filial_p) and
      (in_oficina_p = @i_oficina_p) and (in_nodo_p > @i_nodo_p))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p = @i_filial_p) and
      (in_oficina_p = @i_oficina_p) and (in_nodo_p = @i_nodo_p)
      and (in_filial_a > @i_filial_a))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p = @i_filial_p) and
      (in_oficina_p = @i_oficina_p) and (in_nodo_p = @i_nodo_p)
      and (in_filial_a = @i_filial_a) and (in_oficina_p > @i_oficina_p))
     or  ((in_filial_d = @i_filial_d) and (in_oficina_d = @i_oficina_d)
      and (in_nodo_d = @i_nodo_d) and (in_filial_h = @i_filial_h)
      and (in_oficina_h = @i_oficina_h) and (in_nodo_h =
      @i_nodo_h) and (in_filial_p = @i_filial_p) and
      (in_oficina_p = @i_oficina_p) and (in_nodo_p = @i_nodo_p)
      and (in_filial_a = @i_filial_a) and (in_oficina_a =
      @i_oficina_a) and (in_nodo_a > @i_nodo_a))
               )
     and in_estado = 'V'
   order by in_filial_d, in_oficina_d, in_nodo_d,
      in_filial_h, in_oficina_h, in_nodo_h,
      in_filial_p, in_oficina_p, in_nodo_p,
      in_filial_a, in_oficina_a, in_nodo_a
       set rowcount 0
     end
     if @i_modo = 2
     begin
   select 'C.F.' = in_filial_h,
          'Filial' = substring(in_nombre_f_h,1,20),
          'C.O.' = in_oficina_h,
               'Oficina' = substring(in_nombre_o_h,1,20),
          'C.N.' = in_nodo_h,
          'Nodo' = substring(in_nombre_n_h,1,20)
          from ad_indirecta
         where in_filial_d = @i_filial_d
           and in_oficina_d = @i_oficina_d
           and in_nodo_d = @i_nodo_d
           and in_estado = 'V'
       set rowcount 0
     end
     if @i_modo = 3
     begin
   select 'C.F.' = in_filial_h,
          'Filial' = substring(in_nombre_f_h,1,20),
          'C.O.' = in_oficina_h,
               'Oficina' = substring(in_nombre_o_h,1,20),
          'C.N.' = in_nodo_h,
          'Nodo' = substring(in_nombre_n_h,1,20)
          from ad_indirecta
         where in_filial_d = @i_filial_d
           and in_oficina_d = @i_oficina_d
           and in_nodo_d = @i_nodo_d
           and in_estado = 'V'
      and (
      (in_filial_h > @i_filial_h)
       or ((in_filial_h = @i_filial_h) and (in_oficina_h > @i_oficina_h))
            or ((in_filial_h = @i_filial_h) and (in_oficina_h = @i_oficina_h)
                and (in_nodo_h > @i_nodo_h))
          )
       set rowcount 0
     end
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

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15006
begin
   select   @o_nombre_f_d = in_nombre_f_d,
      @o_nombre_o_d = in_nombre_o_d,
      @o_nombre_n_d = in_nombre_n_d,
      @o_nombre_f_h = in_nombre_f_h,
      @o_nombre_o_h = in_nombre_o_h,
      @o_nombre_n_h = in_nombre_n_h,
      @o_filial_p   = in_filial_p,
      @o_nombre_f_p = in_nombre_f_p,
      @o_oficina_p  = in_oficina_p,
      @o_nombre_o_p = in_nombre_o_p,
      @o_nodo_p     = in_nodo_p,
      @o_nombre_n_p = in_nombre_n_p,
      @o_filial_a   = in_filial_a,
      @o_nombre_f_a = in_nombre_f_a,
      @o_oficina_a  = in_oficina_a,
      @o_nombre_o_a = in_nombre_o_a,
      @o_nodo_a     = in_nodo_a,
      @o_nombre_n_a = in_nombre_n_a
    from ad_indirecta
   where in_estado = 'V'
     and in_filial_d = @i_filial_d
     and in_oficina_d = @i_oficina_d
     and in_nodo_d = @i_nodo_d
     and in_filial_h = @i_filial_h
     and in_oficina_h = @i_oficina_h
     and in_nodo_h = @i_nodo_h
   if @@rowcount = 0
   begin
     exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151019
      /*  'No existe ruta Indirecta' */
     return 1
   end

   select @i_filial_d, @o_nombre_f_d, @i_oficina_d, @o_nombre_o_d,
          @i_nodo_d, @o_nombre_n_d, @i_filial_h, @o_nombre_f_h,
          @i_oficina_h, @o_nombre_o_h, @i_nodo_h, @o_nombre_n_h,
          @o_filial_p, @o_nombre_f_p, @o_oficina_p, @o_nombre_o_p,
          @o_nodo_p, @o_nombre_n_p, @o_filial_a, @o_nombre_f_a,
          @o_oficina_a, @o_nombre_o_a, @o_nodo_a, @o_nombre_n_a
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

