/************************************************************************/
/*  Archivo:              sp_datos_cca_clte.sp                          */
/*  Stored procedure:     sp_datos_cca_clte                             */
/*  Base de datos:        cobis                                         */
/*  Producto:             Clientes                                      */
/*  Disenado por:         Nidia Nieto                                   */
/*  Fecha de escritura:   14-Abr-2008                                   */
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
/*  Este programa busca                                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  14/Abr/08   N. Nieto        Emision Inicial                         */
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
           where  name = 'sp_datos_cca_clte')
           drop proc sp_datos_cca_clte
go

create proc sp_datos_cca_clte
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_ofi          smallint = null,
  @t_show_version bit = 0,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @i_ente         int = null,
  @o_nota         smallint = null out,
  @o_dias         int = null out,
  @o_ejecutivo    varchar(30) = null out
)
as
  declare
    @w_sp_name     varchar(32),
    @w_error       int,
    @w_operacion   int,
    @w_nota        smallint,
    @w_dias        int,
    @w_banco       varchar(24),
    @w_oficial     smallint,
    @w_funcionario varchar(30)

  select
    @w_sp_name = 'sp_datos_cca_clte'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_operacion = isnull(max(op_operacion),
                          0)
  from   cob_cartera..ca_operacion,
         cob_cartera..ca_estado
  where  op_estado  = es_codigo
     and es_procesa = 'S'
     and op_cliente = @i_ente

  if @@rowcount = 0
      or @w_operacion = 0
  begin
    select
      @w_nota = 0,
      @w_dias = 0,
      @w_funcionario = ''
  end
  else
  begin
    exec @w_error = cob_cartera..sp_cal_dias_ven
      @s_user        = @s_ssn,
      @s_term        = @s_term,
      @s_date        = @s_date,
      @s_ofi         = @s_ofi,
      @i_operacionca = @w_operacion,
      @i_operacion   = 'Q',
      @o_banco       = @w_banco out,
      @o_oficial     = @w_oficial out,
      @o_dias_venc   = @w_dias out

    if @w_error = 0
    begin
      select
        @w_nota = isnull(ci_nota,
                         0)
      from   cob_credito..cr_califica_int_mod
      where  ci_banco = @w_banco

      if @@rowcount = 0
        select
          @w_nota = 0

      select
        @w_funcionario = fu_nombre
      from   cobis..cl_funcionario,
             cobis..cc_oficial
      where  fu_funcionario = (select
                                 oc_funcionario
                               from   cc_oficial
                               where  oc_oficial = @w_oficial)
    end
    else
      select
        @w_nota = 0,
        @w_dias = 0,
        @w_funcionario = ''
  end
  select
    @o_nota = @w_nota,
    @o_dias = @w_dias,
    @o_ejecutivo = @w_funcionario

  return 0

go

