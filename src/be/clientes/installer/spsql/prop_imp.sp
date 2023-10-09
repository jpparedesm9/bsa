/************************************************************************/
/*  Archivo:        prop_imp.sp                                         */
/*  Stored procedure:   sp_impresion_propiedades                        */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Jaime Loyo                                      */
/*  Fecha de escritura:     08-Jul-19948                                */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Permite llevar los datos para imprimir las propiedades de           */
/*  un cliente                                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  08-Jul-1998 J. Loyo     Emision inicial                             */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_impresion_propiedades')
    drop proc sp_impresion_propiedades
go

create proc sp_impresion_propiedades
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_ente         int
)
as
  declare @w_sp_name varchar (30)

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_impresion_propiedades'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1374
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @t_from,
      @i_num  = 101147
    return 1
  end

  /*  Extrae propiedades de un ente  */
  select
    pr_propiedad,
    pr_descripcion,
    pr_valor,
    pr_moneda,
    mo_descripcion,
    pr_tbien,
    c1.valor,
    pr_gravada,
    pr_gravamen_afavor,
    pr_ciudad,
    ci_descripcion,
    pr_matricula,
    pr_escritura,
    pr_vigencia,
    pr_verificado,
    convert(char(10), pr_fecha_registro, 101),
    convert(char(10), pr_fecha_modificacion, 101)
  from   cl_moneda,
         cl_tabla t1,
         cl_catalogo c1,
         cl_propiedad x
         left outer join cl_ciudad
                      on pr_ciudad = ci_ciudad
  where  pr_persona = @i_ente
     and mo_moneda  = pr_moneda
     --and  pr_ciudad *= ci_ciudad
     and t1.tabla   = 'cl_tbien'
     and c1.tabla   = t1.codigo
     and c1.codigo  = x.pr_tbien
  order  by pr_tbien,
            pr_propiedad

go

