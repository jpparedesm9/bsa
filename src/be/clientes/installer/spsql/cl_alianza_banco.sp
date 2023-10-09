/* ***********************************************************************/
/*      Archivo:                cl_alianza_banco.sp                      */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           j.molano                                 */
/*      Fecha de escritura:     Abril-2013                               */
/* ***********************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*              PROPOSITO                                                */
/*  Permite parametrizar y consultar la parametrización de cuentas de    */
/*  bancos existentes para alianzas.                                     */
/* ***********************************************************************/
/*                 MODIFICACIONES                                        */
/*  FECHA          AUTOR            RAZON                                */
/*  May/02/2016    DFu              Migracion CEN                        */
/*************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_alianza_banco')
  drop proc sp_alianza_banco
go

create proc sp_alianza_banco
(
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @i_alianza      int = null,
  @i_operacion    char(1) = null,
  @i_ente         int = 0,
  @i_cuenta       varchar(20) = null,
  @i_estado       char(1) = null,
  @i_banco        smallint = null
)
as
  declare
    @w_tabla   smallint,
    @w_alianza int,
    @w_sp_name varchar(30)

  select
    @w_sp_name = 'sp_alianza_banco'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_tabla = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_bancos_alianza'

  if @i_operacion in ('I')
  begin
    if exists(select
                1
              from   cobis..cl_alianza_banco
              where  ab_alianza = @i_alianza
                 and ab_cuenta  = @i_cuenta
                 and ab_banco   = @i_banco)
    begin
      select
        @i_operacion = 'U'
    end
  end

  if @i_operacion = 'Q'
  begin
    select
      'COD. BANCO' = ab_banco,
      'DESCRIPCION BANCO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = @w_tabla
                                and codigo = ab_banco),
      'CUENTA' = ab_cuenta,
      'ESTADO' = ab_estado
    from   cobis..cl_alianza_banco
    where  ab_alianza = @i_alianza
    union all
    select
      'COD. BANCO' = ab_banco,
      'DESCRIPCION BANCO' = (select
                               valor
                             from   cobis..cl_catalogo
                             where  tabla  = @w_tabla
                                and codigo = ab_banco),
      'CUENTA' = ab_cuenta,
      'ESTADO' = ab_estado
    from   cobis..cl_alianza_banco_tmp
  --and   ab_estado  = 'V'
  end

  if @i_operacion = 'I'
  begin
    if @i_alianza = 0
    begin
      select
        @i_alianza = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_alianzas'

    end
    if not exists(select
                    1
                  from   cobis..cl_alianza_banco
                  where  ab_alianza = @i_alianza
                     and ab_estado  = 'V'
                     and ab_cuenta  = @i_cuenta
                     and ab_banco   = @i_banco)
    begin
      insert into cobis..cl_alianza_banco_tmp
                  (ab_alianza,ab_banco,ab_cuenta,ab_estado)
      values      ( @i_alianza,@i_banco,@i_cuenta,@i_estado)
    end
    else
    begin
      print 'ASOCIACIËN YA EXISTE'
    end
  end

  if @i_operacion = 'U'
  begin
    /* SE VALIDA QUE LA ALIANZA NO TENGA NINGUN CLIENTE ASOCIADO PARA PODERSE MODIFICAR */
    if exists (select
                 1
               from   cobis..cl_alianza_cliente
               where  ac_alianza = @i_alianza
                  and ac_estado  = 'V')
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103123
      return 103123
    end

    if exists(select
                1
              from   cobis..cl_alianza_banco
              where  ab_alianza = @i_alianza
                 and ab_estado  = 'V'
                 and ab_cuenta  = @i_cuenta
                 and ab_banco   = @i_banco)
    begin
      update cobis..cl_alianza_banco
      set    ab_estado = @i_estado
      where  ab_alianza = @i_alianza
         and ab_estado  = 'V'
         and ab_cuenta  = @i_cuenta
         and ab_banco   = @i_banco
    end
  end

  if @i_operacion = 'C'
  begin
    select
      'BANCO' = ba_banco,
      'DESCRIPCION' = ba_descripcion
    from   cob_remesas..re_banco
    where  ba_estado = 'V'
  end
  return 0

go

