/************************************************************************/
/*  Archivo:            dir_imp.sp                                      */
/*  Stored procedure:   sp_impresion_direcciones                        */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Jaime Loyo                                      */
/*  Fecha de escritura: 08-Jul-1998                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Permite llevar los datos para imprimir las direcciones y            */
/*  telefonos de  un cliente                                            */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA       AUTOR       RAZON                                       */
/*  08-Jul-1998 J. Loyo     Emision inicial                             */
/*  14-Abr-2009 A. Correa   Ajuste descripcion de barrio                */
/*  04-May-2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_impresion_direcciones')
           drop proc sp_impresion_direcciones
go

create proc sp_impresion_direcciones
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
    @w_sp_name = 'sp_impresion_direcciones'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1372
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @i_num = 101147
    return 1
  end

  /*  Extrae direcciones y Telefonos de un ente */
  select
    di_direccion,
    di_descripcion,
    di_ciudad,
    ci_descripcion,
    di_parroquia,
    di_tipo,
    c1.valor,
    di_sector,
    pv_descripcion,
    di_zona,
    c2.valor,
    convert(char(10), di_fecha_registro, 101),
    convert(char(10), di_fecha_modificacion, 101),
    di_verificado,
    case di_rural_urb
      when 'R' then di_barrio
      else (select
              pq_descripcion
            from   cobis..cl_parroquia
            where  pq_parroquia = d.di_parroquia)
    end,
    di_provincia
  from   cl_ciudad,
         cl_provincia,
         cl_catalogo c1,
         cl_tabla t1,
         cl_direccion d
         left outer join cl_tabla t2
                      on t2.tabla = 'cl_zona'
         left outer join cl_catalogo c2
                      on di_zona = c2.codigo
                         and t2.codigo = c2.tabla
  where  di_ente      = @i_ente
     and ci_ciudad    = di_ciudad
     and pv_provincia = di_provincia
     --and   t2.tabla     = 'cl_zona'
     --and   c2.tabla     = * t2.codigo
     --and   c2.codigo     = * di_zona
     and t1.tabla     = 'cl_tdireccion'
     and c1.tabla     = t1.codigo
     and c1.codigo    = di_tipo

  /*  Telefonos  */
  select
    te_direccion,
    te_secuencial,
    te_valor,
    te_tipo_telefono,
    cl_catalogo.valor,
    te_prefijo
  from   cl_telefono x,
         cl_tabla,
         cl_catalogo
  where  te_ente            = @i_ente
     and cl_tabla.tabla     = 'cl_ttelefono'
     and cl_catalogo.tabla  = cl_tabla.codigo
     and cl_catalogo.codigo = x.te_tipo_telefono
  return 0

go

