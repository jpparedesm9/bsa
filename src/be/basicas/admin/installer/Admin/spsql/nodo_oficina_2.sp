/************************************************************************/
/* Archivo:    nodo_lo2.sp          */
/* Stored procedure: sp_nodo_oficina_2       */
/* Base de datos:    cobis             */
/* Producto: Administracion               */
/* Disenado por:  Mauricio Bayas/Sandra Ortiz         */
/* Fecha de escritura: 24-Nov-1992              */
/************************************************************************/
/*          IMPORTANTE           */
/* Este programa es parte de los paquetes bancarios propiedad de  */
/* 'MACOSA', representantes exclusivos para el Ecuador de la   */
/* 'NCR CORPORATION'.                  */
/* Su uso no autorizado queda expresamente prohibido asi como  */
/* cualquier alteracion o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de la  */
/* Presidencia Ejecutiva de MACOSA o su representante.      */
/*          PROPOSITO            */
/* Este programa procesa las transacciones de:        */
/* Borrado del nodo - oficina             */
/* Busqueda del nodo - oficina               */
/* Query del nodo - oficina               */
/* Ayuda del nodo - oficina               */
/*          MODIFICACIONES          */
/* FECHA    AUTOR    RAZON          */
/* 24/Nov/1992 L. Carvajal Emision inicial         */
/*  07/Jun/1993 M. Davila   Search sin errores              */
/*  11-04-2016  BBO         Migracion Sybase-Sqlserver FAL        */
/* 24/Jun/2016  J.Hdez      Ajuste Vesion Falabella cambio tipo de      */
/*                          dato nodo                                   */
/************************************************************************/

use cobis
go

if exists ( select * from sysobjects where name = 'sp_nodo_oficina_2')
   drop proc sp_nodo_oficina_2
go

create proc sp_nodo_oficina_2 (
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
   @i_tipo           char(1) = null,
   @i_modo           smallint = null,
   @i_filial         tinyint = null,
   @i_oficina        smallint = null,
   @i_nodo           smallint = null,
   @i_sis_operativo  tinyint = NULL,
   @i_nombre         descripcion = NULL,
   @i_registrador    smallint = NULL,
   @i_habilitante    smallint = NULL,
   @i_fecha_habil    datetime = null,
   @i_x              smallint = null,
   @i_y              smallint = null,
   @i_formato_fecha  int = null
)
as
declare
   @w_today    datetime,
   @w_return      int,
   @w_sp_name     varchar(32),
   @w_fecha_habil          datetime,
   @w_filial               tinyint,
   @w_oficina              smallint,
   @w_nodo                 smallint,
   @w_sis_operativo        tinyint,
   @w_nombre               descripcion,
   @w_registrador          smallint,
   @w_habilitante          smallint,
   @v_filial               tinyint,
   @v_oficina              smallint,
   @v_nodo                 smallint,
   @v_sis_operativo        tinyint,
   @v_nombre      descripcion,
        @v_registrador          smallint,
        @v_fecha_habil          datetime,
        @v_habilitante          smallint,
   @o_siguiente      int,
   @o_sis_operativo  tinyint,
   @o_nombre      descripcion,
   @o_nombre_n    descripcion,
   @o_nombre_o    descripcion,
   @o_nombre_f    descripcion,
   @o_nombre_so      descripcion,
   @o_registrador    smallint,
   @o_habilitante    smallint,
   @o_fecha_reg      datetime,
   @o_fecha_habil    datetime,
   @w_fecha_ult_mod  datetime,
   @v_fecha_ult_mod  datetime,
   @w_fecha_reg      datetime,
   @w_secuencial     int,
   @w_terminal    int,
   @w_detecta_cambio char(1),
   @o_nombre_reg     descripcion,
   @o_nombre_hab     descripcion

select @w_today = @s_date
select @w_sp_name = 'sp_nodo_oficina_2'




/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 524
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL)
      
  begin
/*  'No se llenaron todos los campos' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151001
   return 1
  end

  select  @w_registrador = nl_registrador,
     @w_nombre = nl_nombre,
          @w_fecha_habil = nl_fecha_habil,
          @w_habilitante = nl_habilitante,
     @w_sis_operativo = nl_sis_operativo,
     @w_terminal = nl_terminal,
     @w_secuencial = nl_secuencial,
     @w_fecha_ult_mod = nl_fecha_ult_mod
  from ad_nodo_oficina
  where nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_nodo = @i_nodo
     and nl_estado = 'V'        
  if @@rowcount = 0
  begin
/*  'No existe nodo oficina' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
       return 1
  end

 /* deteccion de referencias */
   if exists (
   select di_nodo_d
     from ad_directa
       where di_filial_d = @i_filial
      and di_oficina_d = @i_oficina
           and di_nodo_d = @i_nodo
      and di_estado =  'V')
   begin
/*  'Existe referencia en ruta directa' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157003
   return 1
   end
   
   if exists (
   select di_nodo_h
     from ad_directa
       where di_filial_h = @i_filial
      and di_oficina_h = @i_oficina
           and di_nodo_h = @i_nodo
      and di_estado =  'V')
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157003
   return 1
   end

   if exists (
   select in_nodo_d
     from ad_indirecta
       where in_filial_d = @i_filial
      and in_oficina_d = @i_oficina
           and in_nodo_d = @i_nodo
      and in_estado =  'V')
   begin
/*  'Existe referencia en ruta indirecta' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157004
   return 1
   end

   if exists (
   select in_nodo_h
     from ad_indirecta
       where in_filial_h = @i_filial
      and in_oficina_h = @i_oficina
           and in_nodo_h = @i_nodo
      and in_estado =  'V')
   begin
/*  'Existe referencia en ruta indirecta'*/
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157004
   return 1
   end

   if exists (
   select in_nodo_p
     from ad_indirecta
       where in_filial_p = @i_filial
      and in_oficina_p = @i_oficina
           and in_nodo_p = @i_nodo
      and in_estado =  'V')
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157004
   return 1
   end

   if exists (
   select in_nodo_a
     from ad_indirecta
       where in_filial_a = @i_filial
      and in_oficina_a = @i_oficina
           and in_nodo_a = @i_nodo
      and in_estado =  'V')
   begin
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157004
   return 1
   end

   if exists (
   select bd_filial
          from ad_base_datos
       where bd_filial = @i_filial
      and bd_oficina = @i_oficina
           and bd_nodo = @i_nodo
      and bd_estado =  'V')
   begin
/*  'Existe referencia en Base de Datos' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157005
   return 1
   end

   if exists (
   select li_filial
          from ad_link
       where li_filial = @i_filial
      and li_oficina = @i_oficina
           and li_nodo = @i_nodo
      and li_estado =  'V')
   begin
/*  'Existe referencia en link'*/
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157006
   return 1
   end

   if exists (
   select us_filial
          from ad_usuario
       where us_filial = @i_filial
      and us_oficina = @i_oficina
           and us_nodo = @i_nodo
      and us_estado =  'V')
   begin
/*  'Existe referencia en Usuario' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157007
   return 1
   end

   if exists (
   select te_filial
          from ad_terminal
       where te_filial = @i_filial
      and te_oficina = @i_oficina
           and te_nodo = @i_nodo
      and te_estado =  'V')
   begin
/*  'Existe referencia en Terminal'*/
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157008
   return 1
   end

   if exists (
   select sg_filial_i
     from ad_server_logico
       where sg_filial_i = @i_filial
      and sg_oficina_i = @i_oficina
           and sg_nodo_i = @i_nodo
      and sg_estado =  'V')
   begin
/*  'Existe referencia en server logico' */
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157009
   return 1
   end


 /* borrado de nodo oficina */
 Begin Tran
  Delete ad_nodo_oficina
   where nl_filial = @i_filial
    and  nl_oficina = @i_oficina
    and  nl_nodo = @i_nodo
  if @@error != 0
  begin
/*  'Error en eliminacion de nodo oficina'*/
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 157010
   return 1
  end

/* transaccion de servicio */
   insert into ts_nodo_oficina (secuencia, tipo_transaccion, clase, fecha,
                  oficina_s, usuario, terminal_s, srv, lsrv,
            filial, oficina, nodo,sis_operativo, nombre,
            fecha_reg, registrador, fecha_habil,
            habilitante, terminal, secuencial, estado,
            fecha_ult_mod)
           values    (@s_ssn, 524, 'B', @s_date,
                  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
            @i_filial, @i_oficina, @i_nodo,
            @w_sis_operativo, @w_nombre, @w_fecha_reg,
            @w_registrador, @w_fecha_habil,
            @w_habilitante, @w_terminal, @w_secuencial,
            'V', @w_fecha_ult_mod)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio'*/
   exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 153023
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
If @t_trn = 15013
begin
     set rowcount 20
     if @i_modo = 0
     begin
   select  'Codigo filial' = nl_filial,
            'Filial' = fi_abreviatura,
            'Codigo Oficina' = nl_oficina,
            'Oficina' = substring(of_nombre, 1, 20),
            'Codigo nodo' = nl_nodo,
            'Nodo' = substring(no_marca + '  ' + no_modelo, 1, 30),
            'Cod. S.O' = nl_sis_operativo,
            'Sistema operativo' = substring(so_descripcion, 1, 20),
            'Nombre del servidor' = substring(nl_nombre, 1, 20),
            'Registrador' = nl_registrador,
            'Nombre Reg' = X.fu_nombre,
            'Habilitante' = nl_habilitante,
            'Nombre_hab' = Y.fu_nombre,
            'Fecha habil' = nl_fecha_habil
       from ad_nodo_oficina                                                         --inicio mig syb-sql 18042016
            inner join ad_nodo on nl_nodo = no_nodo
            inner join cl_filial on nl_filial = fi_filial
            inner join cl_oficina on nl_oficina = of_oficina
            inner join ad_sis_operativo on nl_sis_operativo = so_sis_operativo
            inner join cl_funcionario X on nl_registrador = X.fu_funcionario
            left outer join cl_funcionario Y on nl_habilitante = Y.fu_funcionario
      where nl_estado = 'V'
      order by nl_filial, nl_oficina, nl_nodo                                        --fin mig syb-sql 18042016

        /****** MIGRACION SYB-SQL 
         from  ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
            ad_sis_operativo, cl_funcionario X, cl_funcionario Y
        where  nl_registrador = X.fu_funcionario
          --and isnull(nl_habilitante,0) = Y.fu_funcionario
          and  nl_habilitante *= Y.fu_funcionario
          and  nl_filial = fi_filial
          and  nl_oficina = of_oficina
          and  nl_nodo = no_nodo
          and  nl_sis_operativo = so_sis_operativo
          and  nl_estado = 'V'
        order   by nl_filial, nl_oficina, nl_nodo
        *****/
       set rowcount 0
     end
     if @i_modo = 1
     begin
   select  'Codigo filial' = nl_filial,
            'filial' = fi_abreviatura,
            'Codigo Oficina' = nl_oficina,
            'Oficina' = substring(of_nombre, 1, 20),
            'Codigo nodo' = nl_nodo,
            'Nodo' = substring(no_marca + '  ' + no_modelo, 1, 30),
            'Cod. S.O' = nl_sis_operativo,
            'Sistema operativo' = substring(so_descripcion, 1, 20),
            'Nombre del servidor' = substring(nl_nombre, 1, 20),
            'Registrador' = nl_registrador,
            'Nombre Reg' = X.fu_nombre,
            'Habilitante' = nl_habilitante,
            'Nombre_hab' = Y.fu_nombre,
            'Fecha habil' = nl_fecha_habil
       from ad_nodo_oficina                                                         --inicio mig syb-sql 18042016
            inner join ad_nodo on nl_nodo = no_nodo
            inner join cl_filial on nl_filial = fi_filial
            inner join cl_oficina on nl_oficina = of_oficina
            inner join ad_sis_operativo on nl_sis_operativo = so_sis_operativo
            inner join cl_funcionario X on nl_registrador = X.fu_funcionario
            left outer join cl_funcionario Y on nl_habilitante = Y.fu_funcionario
      where nl_estado = 'V'
        and (( nl_filial > @i_filial)
         or ((nl_filial = @i_filial) and (nl_oficina > @i_oficina))
         or ((nl_filial = @i_filial) and (nl_oficina = @i_oficina) and (nl_nodo > @i_nodo)))
      order by nl_filial, nl_oficina, nl_nodo                                        --fin mig syb-sql 18042016

        /****** MIGRACION SYB-SQL             
         from  ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
            ad_sis_operativo, cl_funcionario X, cl_funcionario Y
        where  nl_registrador = X.fu_funcionario
          --and   isnull(nl_habilitante,0) = Y.fu_funcionario
          and  nl_habilitante *= Y.fu_funcionario
          and  nl_filial = fi_filial
          and  nl_oficina = of_oficina
          and  nl_nodo    = no_nodo
          and  nl_sis_operativo = so_sis_operativo
          and  ( 
                (nl_filial > @i_filial)
          or   ((nl_filial = @i_filial) and (nl_oficina > @i_oficina))
          or   ((nl_filial = @i_filial) and (nl_oficina = @i_oficina)
         and (nl_nodo > @i_nodo))
               )
         and   nl_estado = 'V'
        order   by nl_filial, nl_oficina, nl_nodo
        ********/
        
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
If @t_trn = 15014
begin
    select @o_nombre_f = fi_nombre,
      @o_nombre_o = of_nombre,
      @o_nombre_n = no_marca + ' ' + no_modelo,
      @o_sis_operativo = nl_sis_operativo,
      @o_nombre_so = substring(so_descripcion, 1, 20),
      @o_nombre = substring(nl_nombre, 1, 20),
      @o_registrador = nl_registrador,
      @o_habilitante = nl_habilitante,
      @o_fecha_reg = nl_fecha_reg,
      @o_fecha_habil = nl_fecha_habil
    from ad_nodo_oficina, ad_nodo, cl_filial, cl_oficina,
      ad_sis_operativo
        where   nl_filial  = fi_filial    
     and nl_oficina = of_oficina
     and nl_nodo    = no_nodo
     and nl_sis_operativo = so_sis_operativo
     and nl_filial = @i_filial
     and nl_oficina = @i_oficina
     and nl_nodo = @i_nodo
     and nl_estado = 'V'
   if @@rowcount = 0
   begin
/*  'No existe nodo oficina'*/
    exec sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 151002
    return 1
   end

   select @o_nombre_hab= ''
   if @o_habilitante is not null
   begin
   select @o_nombre_hab = fu_nombre
     from cl_funcionario
    where fu_funcionario = @o_habilitante
    if @@rowcount = 0
    begin
/*'No existe funcionario'*/
      exec sp_cerror
        @t_debug    = @t_debug,
        @t_file      = @t_file,
        @t_from     = @w_sp_name,
        @i_num   = 101036
    end
   end
   else
      select @o_habilitante = null

   select @o_nombre_reg = fu_nombre
     from cl_funcionario
    where fu_funcionario = @o_registrador
   if @@rowcount = 0
   begin
/*'No existe funcionario'*/
      exec sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num   = 101036
   end

   select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o, @i_nodo,
          @o_nombre_n, @o_sis_operativo, @o_nombre_so, @o_nombre,
          @o_registrador, @o_nombre_reg, convert(char(10), @o_fecha_reg, @i_formato_fecha),
          @o_habilitante, @o_nombre_hab, convert(char(10), @o_fecha_habil, @i_formato_fecha)
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


/* ** help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15015
begin
 if @i_tipo = 'A'
 begin
    select   'Codigo' = nl_nodo, 
                  'Nodo'   = nl_nombre
      from    ad_nodo_oficina
     where   nl_estado  = 'V'
       and   nl_filial  = @i_filial
       and   nl_oficina = @i_oficina
      order  by nl_nodo
 end
 if @i_tipo = 'V'
 begin
    select nl_nombre
      from  ad_nodo_oficina
     where nl_filial = @i_filial
       and nl_oficina  = @i_oficina
       and nl_nodo = @i_nodo
       and nl_estado = 'V'
    if @@rowcount = 0
/*  'No existe nodo oficina' */
    begin
       exec sp_cerror
          @t_debug      = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 151002
       return 1
    end
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

if @i_operacion = 'G'
begin
if @t_trn = 15098
begin
  select nl_nodo,nl_filial, nl_oficina,
    substring(fi_nombre,1,20),
    substring(of_nombre,1,20)
    from ad_nodo_oficina, cl_filial, cl_oficina
   where nl_nombre = @i_nombre
   and    nl_filial = fi_filial
   and    nl_oficina = of_oficina

  if @@rowcount = 0
/*  'No existe nodo oficina' */
    begin
       exec sp_cerror
          @t_debug      = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 151002
       return 1
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

/** Search para administrador de red **/
If @i_operacion = 'N'
begin
   select nl_nombre, nl_x, nl_y
     from ad_nodo_oficina
   return 0
end

/** Actualizacion de coordenadas */
If @i_operacion = 'C'
begin
   begin tran
   update ad_nodo_oficina
      set nl_x = @i_x,
          nl_y = @i_y
    where nl_nombre = @i_nombre
   if @@error != 0
   begin
      rollback tran
      return 1
   end
   commit tran
   return 0
end
go
