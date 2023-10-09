/************************************************************************/
/*      Archivo:                coficiales.sp                           */
/*      Stored procedure:       sp_cons_oficiales                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Clotilde Vargas                         */
/*      Fecha de documentacion: 14/Sep/05                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado realiza las consultas             */
/*      de oficiales para oficial principa y oficial secundario         */
/*                                                                      */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_oficiales')
   drop proc sp_cons_oficiales
go

create proc sp_cons_oficiales (
@s_ssn          int         = null,
@s_srv          varchar(30) = null,
@s_lsrv         varchar(30) = null,
@s_user         varchar(30) = null,
@s_sesn         int         = null,
@s_term         varchar(10) = null,
@s_date         datetime    = null,
@s_ofi          smallint    = null,
@s_rol          smallint    = 1,
@s_org_err      char(1)     = null,
@s_error        int         = null,
@s_sev          tinyint     = null,
@s_msg          mensaje     = null,
@s_org          char(1)     = null,
@t_rty          char(1)     = 'N',
@t_from         char(1)     = null,
@t_debug	    char(1)     = 'N',
@t_file		    char(1)     =  null,
@t_trn		    smallint,
@i_oficial 	    smallint    = 0,
@i_super        smallint    = 0,
@i_nivel	    varchar(3)  = '%',
@i_flag         char(1)     = 'N',
@i_tipo         char(1),
@i_login        login       = null,
@i_func		    varchar(30) = null,
@i_sig		    varchar(30) = '%',
@i_modo         int         = 0)
with encryption
as
declare
@w_sp_name      descripcion

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_cons_oficiales'

/*  Activacion del Modo de debug  */


/* Esta transaccion permite consultar los oficiales de un determinado nivel */
/* y dado su oficial de credito superior                                    */
/* Para el tipo ALL                                                         */

if @t_trn <> 14468
begin
  exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 141112
  return 1
end

if @i_tipo = 'A' 
  begin
    if @i_modo = 0
    begin
    set rowcount 20
    select  'OFICIAL' = oc_oficial,
            'NOMBRE'  = fu_nombre,
            'NIVEL'   = valor,
	    'CODIGO'  =codigo,
            'LOGIN'   = fu_login
      from  cobis..cc_oficial,
            cobis..cl_funcionario,
            cobis..cl_catalogo 
     where  oc_oficial       > @i_oficial
       and  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, @i_nivel)
       and  (oc_ofi_nsuperior = @i_super
        or  (oc_ofi_nsuperior < @i_super and @i_flag = 'S'))
       and  oc_funcionario   = fu_funcionario
       and  codigo           = oc_tipo_oficial
       and  tabla = (select codigo
                       from cobis..cl_tabla
                      where tabla = 'cc_tipo_oficial')
    set rowcount 0
    end

    if @i_modo = 1
    begin
       set rowcount 20
       select  'OFICIAL' = oc_oficial,
               'NOMBRE'  = fu_nombre,
               'NIVEL'   = valor,
               'CODIGO'  =codigo,
               'LOGIN'   = fu_login
       from  cobis..cc_oficial,
             cobis..cl_funcionario,
             cobis..cl_catalogo 
       where  oc_oficial       >= @i_oficial
         and  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, @i_nivel)
         and  (oc_ofi_nsuperior = @i_super
          or  (oc_ofi_nsuperior < @i_super and @i_flag = 'S'))
         and  oc_funcionario   = fu_funcionario
         and  codigo           = oc_tipo_oficial
         and  tabla = (select codigo
                       from cobis..cl_tabla
                      where tabla = 'cc_tipo_oficial')
       set rowcount 0
    end
    if @i_modo = 2				--LIM 15/DIC/2005
    begin
       set rowcount 20
       select  'OFICIAL' = oc_oficial,
               'NOMBRE'  = fu_nombre,
               'NIVEL'   = valor,
               'CODIGO'  =codigo,
               'LOGIN'   = fu_login
      from  cobis..cc_oficial,
            cobis..cl_funcionario,
            cobis..cl_catalogo 
     where  oc_oficial       > @i_oficial
       and  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, @i_nivel)
       and  (oc_ofi_nsuperior = @i_super
        or  (oc_ofi_nsuperior < @i_super and @i_flag = 'S'))
       and  oc_funcionario   = fu_funcionario
       and  codigo           = oc_tipo_oficial
       and  tabla = (select codigo
                       from cobis..cl_tabla
                      where tabla = 'cc_tipo_oficial')
	and fu_nombre like @i_func
	and fu_nombre > @i_sig
	order by fu_nombre
      set rowcount 0
    end

    return 0
  end


if @i_tipo = 'H'
  begin
    set rowcount 20
    select  'OFICIAL' = oc_oficial,
            'NOMBRE'  = fu_nombre,
            'NIVEL'   = valor,
            'CODIGO'  =codigo,
            'LOGIN'   = fu_login
      from  cobis..cc_oficial,
            cobis..cl_funcionario,
            cobis..cl_catalogo 
     where  oc_oficial       > @i_oficial
       and  convert(tinyint, oc_tipo_oficial) >= convert(tinyint, @i_nivel)
       and  (oc_ofi_nsuperior = @i_super
        or  (oc_ofi_nsuperior < @i_super and @i_flag = 'S'))
       and  oc_funcionario   = fu_funcionario
       and  codigo           = oc_tipo_oficial
       and  tabla = (select codigo
                       from cobis..cl_tabla
                      where tabla = 'cc_tipo_oficial')
	and fu_nombre like @i_func
	and fu_nombre > @i_sig
	order by fu_nombre
    set rowcount 0
    return 0
  end



if @i_tipo = 'V'
  /* Tipo Value dado el codigo del oficial retornar el nombre */
  begin

    select  'NOMBRE'  = fu_nombre
      from  cobis..cc_oficial,
            cobis..cl_funcionario
     where  oc_oficial       = @i_oficial
       and  oc_funcionario   = fu_funcionario

    if @@rowcount = 0
        begin
          /* No existe oficial */
          exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201121 
          return 1
        end
    return 0
  end

if @i_tipo = 'L'
  /* Del login regresa el codigo y el nombre del oficial */
  begin

    select  'CODIGO'  = oc_oficial,
            'NOMBRE'  = fu_nombre
      from  cobis..cc_oficial,
            cobis..cl_funcionario
     where  fu_login         = @i_login   
       and  fu_funcionario   = oc_funcionario

    if @@rowcount = 0
        begin
          /* No existe oficial */
          exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201121 
          return 1
        end
    return 0
  end

if @i_tipo = 'O'
  /* Del codigo de oficial regresa el codigo y el nombre del oficial */
  begin

    select  'CODIGO'  = oc_oficial,
            'NOMBRE'  = fu_nombre
      from  cobis..cc_oficial,
            cobis..cl_funcionario
     where  oc_oficial       = @i_oficial
       and  fu_funcionario   = oc_funcionario

    if @@rowcount = 0
        begin
          /* No existe oficial */
          exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 151075
          return 1
    end
end



return 0
go
                                                                                                                                                       
