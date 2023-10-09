/*************************************************************************/
/*   Archivo             :    cl_spgen.sp                                */
/*   Stored procedure    :    sp_generico_batch                          */
/*   Base de datos       :    cobis                                      */
/*   Producto            :    Clientes                                   */
/*   Fecha de escritura  :    03-May-2009                                */
/*************************************************************************/
/*                       IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*        Generacion de estados del cliente.                             */
/*************************************************************************/
/*                        MODIFICACIONES                                 */
/*        FECHA          AUTOR          RAZON                            */
/*    02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/*************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  id = object_id('sp_generico_batch'))
  drop proc sp_generico_batch
go

create proc sp_generico_batch
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name varchar(32),
    @w_sp      varchar(50),
    @w_cuenta  varchar(14),
    @w_corte   smallint

  select
    @w_cuenta = '',
    @w_corte = 0

  select
    @w_sp_name = 'sp_generico_batch'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp = ltrim(rtrim(pa_char))
  from   cobis..cl_parametro
  where  pa_nemonico = 'SPGENE'
     and pa_producto = 'MIS'

  if @w_sp is null
  begin
    print
'Error el Stored Procedure no esta parametrizado con el nemonico SPGENE, producto MIS'
  return 1
end

  exec (@w_sp)

  if @@error <> 0
  begin
    print 'Error el ejecutar el SP: ' + @w_sp
    return 1
  end

  select distinct
    se_cuenta = st_cuenta
  into   #cuenta_sep
  from   cob_conta_tercero..ct_saldo_tercero with (index = ct_saldo_tercero_Key
         nolock)
  where  st_periodo = 2014
     and st_corte   = 243

  select
    @w_corte = max(st_corte)
  from   cob_conta_tercero..ct_saldo_tercero with (index = ct_saldo_tercero_Key
         nolock)
  where  st_periodo = 2014

  set rowcount 0

  while 2 = 2
  begin
    set rowcount 1

    select
      @w_cuenta = se_cuenta
    from   #cuenta_sep
    order  by se_cuenta

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    set rowcount 0

    delete #cuenta_sep
    where  se_cuenta = @w_cuenta

    select
      st_cuenta,
      st_oficina,
      st_area,
      st_ente,
      st_saldo,
      st_saldo_me,
      st_mov_debito,
      st_mov_credito,
      st_mov_debito_me,
      st_mov_credito_me
    into   #saldo_terceros
    from   cob_conta_tercero..ct_saldo_tercero (nolock)
    where  st_periodo = 2014
       and st_corte   = 243
       and st_cuenta  = @w_cuenta
    if @@error <> 0
    begin
      print 'Error al insertar en temporal 1'
      rollback tran
      goto final
    end

    /* SACA TODOS LOS MOVIMIENTOS DE SEPTIEMBRE */
    insert into #saldo_terceros
      select
        sa_cuenta,sa_oficina_dest,sa_area_dest,sa_ente,sa_saldo = sum(
                                                       sa_debito - sa_credito),
        sa_saldo_me = sum(sa_debito_me - sa_credito_me),sum(sa_debito),sum(
        sa_credito)
        ,sum(sa_debito_me),sum(sa_credito_me)
      from   cob_conta_tercero..ct_sasiento (nolock),
             cob_conta_tercero..ct_scomprobante (nolock)
      where  sc_fecha_tran  >= '09/01/2014'
         and sc_fecha_tran  <= '09/30/2014'
         and sa_mayorizado  = 'S'
         and sa_comprobante = sc_comprobante
         and sa_fecha_tran  = sc_fecha_tran
         and sa_producto    = sc_producto
         and sc_estado      = 'P'
         and sa_cuenta in
             (select
                cp_cuenta
              from   cob_conta..cb_cuenta_proceso
              where  cp_proceso in (6003, 6095))
         and sa_cuenta      = @w_cuenta
      group  by sa_cuenta,
                sa_oficina_dest,
                sa_area_dest,
                sa_ente
    if @@error <> 0
    begin
      print 'Error al insertar en temporal 1'
      rollback tran
      goto final
    end

    create index idx1
      on #saldo_terceros (st_cuenta)

    begin tran

    insert cob_conta_tercero..ct_saldo_tercero
      select
        1,2014,273,st_cuenta,st_oficina,
        st_area,st_ente,sum(st_saldo),sum(st_saldo_me),sum(st_mov_debito),
        sum(st_mov_credito),sum(st_mov_debito_me),sum(st_mov_credito_me)
      from   #saldo_terceros
      where  st_cuenta = @w_cuenta
      group  by st_cuenta,
                st_oficina,
                st_area,
                st_ente
    if @@error <> 0
    begin
      print 'Error al insertar en temporal 1'
      rollback tran
      goto final
    end

    print 'cuenta: ' + @w_cuenta

    commit tran

    drop table #saldo_terceros
  end
  return 0

  final:
  return 1

go

