/************************************************************************/
/*  Archivo:        rper_imp.sp                                         */
/*  Stored procedure:   sp_impresion_ref_personales                     */
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
/*  Permite llevar los datos para imprimir las referencias              */
/*      personales de un cliente                                        */
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
           where  name = 'sp_impresion_ref_personales')
           drop proc sp_impresion_ref_personales
go

create proc sp_impresion_ref_personales
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
    @w_sp_name = 'sp_impresion_ref_personales'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Modo de Debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '**  Stored Procedure  **' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      t_file = @t_file,
      t_from = @t_from,
      t_trn = @t_trn,
      i_ente = @i_ente
    exec cobis..sp_end_debug
  end

  if @t_trn <> 1375
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @t_from,
      @i_num  = 101147
    return 1
  end

  /*  Extrae referencias personales de un ente  */

  select
    x.rp_referencia,
    x.rp_nombre,
    x.rp_p_apellido,
    x.rp_s_apellido,
    x.rp_direccion,
    x.rp_telefono_d,
    x.rp_telefono_e,
    x.rp_telefono_o,
    x.rp_parentesco,
    x.rp_verificacion,
    convert(varchar(10), x.rp_fecha_registro, 101),
    c1.valor
  from   cl_ref_personal x,
         cl_tabla t1,
         cl_catalogo c1
  where  rp_persona = @i_ente
     and t1.tabla   = 'cl_parentesco'
     and c1.tabla   = t1.codigo
     and c1.codigo  = x.rp_parentesco
  order  by rp_referencia

go

