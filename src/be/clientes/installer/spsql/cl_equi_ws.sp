/************************************************************************/
/*      Archivo:                cl_equi_ws.sp                           */
/*      Stored procedure:       sp_equivalencia_ws                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Sandra M. Lievano R.                    */
/*      Fecha de escritura:     14/Junio/2007                           */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa realiza la equivalencia para el tipo de documento   */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    14/Junio/2007   S. Lievano       Emisión Inicial                  */
/*    15/Junio/2007   E. Laguna        Agrego retorno nuevas equivalenci*/
/*    02/Mayo/2016    DFu              Migracion CEN                    */
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
           where  name = 'sp_equivalencia_ws')
  drop proc sp_equivalencia_ws
go

create proc sp_equivalencia_ws
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_sesn         int = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_central      varchar(10),
  @i_tipodoc      varchar(10) = null,
  @i_operacion    char(1),
  @i_tipo_id      varchar(10) = null,
  @i_sexo         varchar(10) = null,
  @i_pais         varchar(10) = null,
  @i_ciudad       varchar(10) = null,
  @i_dpto         varchar(10) = null,
  @i_error        varchar(10) = null,
  @o_tipo_id      varchar(10) = null out,
  @o_sexo         varchar(10) = null out,
  @o_pais         varchar(10) = null out,
  @o_ciudad       varchar(10) = null out,
  @o_dpto         varchar(10) = null out,
  @o_error        varchar(10) = null out,
  @o_descrip      varchar(10) = null out
)
as
  declare
    @w_sp_name    varchar (32),
    @w_return     int,
    @w_eq_tipodoc varchar(2),
    @w_tipo_id    varchar(10),
    @w_sexo       varchar(10),
    @w_pais       varchar(10),
    @w_ciudad     varchar(10),
    @w_dpto       varchar(10),
    @w_error      varchar(10),
    @w_descrip    varchar(40)

  select
    @w_sp_name = 'sp_equivalencia_ws'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1015
  begin
    if @i_operacion = 'Q'
    begin
      select
        @w_eq_tipodoc = eq_codigo
      from   cobis..cl_equivalencia_ws
      where  eq_central      = @i_central
         and eq_equivalencia = @i_tipodoc

      select
        @w_eq_tipodoc
    end

    if @i_operacion = 'H'
    begin
      select
        @w_tipo_id = '',
        @w_sexo = '',
        @w_pais = '',
        @w_ciudad = '',
        @w_dpto = '',
        @w_error = ''

      -- calcular equivalencia del tipo identificacion   
      select
        @w_tipo_id = eq_equivalencia
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_tipo_id
         and eq_tabla   = 'Tipo id'

      -- calcular equivalencia del sexo
      select
        @w_sexo = eq_equivalencia
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_sexo
         and eq_tabla   = 'Genero'

      -- calcular equivalencia del Pais
      select
        @w_pais = eq_equivalencia
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_pais
         and eq_tabla   = 'Nacionalidad'

      -- calcular equivalencia de la ciudad
      select
        @w_ciudad = eq_equivalencia
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_ciudad
         and eq_tabla   = 'Ciudad'

      -- calcular equivalencia de la departamento
      select
        @w_dpto = eq_equivalencia
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_dpto
         and eq_tabla   = 'Departamento'

      -- calcular equivalencia de codigo error (estado documento)
      select
        @w_error = eq_equivalencia,
        @w_descrip = eq_codigo1
      from   cobis..cl_equivalencia_ws
      where  eq_central = @i_central
         and eq_codigo  = @i_error
         and eq_tabla   = 'EstadoId'

      select
        @o_tipo_id = @w_tipo_id
      select
        @o_sexo = @w_sexo
      select
        @o_pais = @w_pais
      select
        @o_ciudad = @w_ciudad
      select
        @o_dpto = @w_dpto
      select
        @o_error = @w_error
      select
        @o_descrip = @w_descrip

      select
        @o_tipo_id
      select
        @o_sexo
      select
        @o_pais
      select
        @o_ciudad
      select
        @o_dpto
      select
        @o_error
      select
        @o_descrip

    end --operacion H

  end

  return 0

go

