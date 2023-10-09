/*ajusopera.sp*************************************************************/
/*   Stored procedure:     sp_ajuste_oper_conta_aho                       */
/*   Base de datos:        cob_conta                                      */
/**************************************************************************/
/*                                  IMPORTANTE                            */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*   de COBISCorp.                                                        */
/*   Su uso no autorizado queda expresamente prohibido asi como           */
/*   cualquier alteracion o agregado  hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.      */
/*   Este programa esta protegido por la ley de derechos de autor         */
/*   y por las convenciones  internacionales   de  propiedad inte-        */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para     */
/*   obtener ordenes  de secuestro o retencion y para  perseguir          */
/*   penalmente a los autores de cualquier infraccion.                    */
/**************************************************************************/
/*                              PROPOSITO                                 */
/*   Consolida información para posterior paso a repositorio              */
/**************************************************************************/
/*                               MODIFICACIONES                           */
/*  FECHA              AUTOR          CAMBIO                              */
/*  ENE/2015         LIANA COTO  EMISION INICIAL                          */
/*                               REQ486-PASO A REPOSITOSIO TARJETA DEBITO */
/*  02/May/2016      J. Calderon Migración a CEN                          */
/**************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ajuste_oper_conta_aho')
  drop proc sp_ajuste_oper_conta_aho
go

create procedure sp_ajuste_oper_conta_aho
(
  @t_show_version bit = 0,
  @i_param1       varchar(10),--producto
  @i_param2       varchar(10),--fecha
  @i_param3       varchar(10) = null --cliente
)
as
  declare
    @w_producto    smallint,
    @w_fecha       datetime,
    @w_cliente     int,
    @w_oficina     smallint,
    @w_error       int,
    @w_msg         varchar(100),
    @w_comprobante int,
    @w_asientos    int,
    @w_tot_debito  money,
    @w_tot_credito money,
    @w_sp_name     varchar(30)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ajuste_oper_conta_aho'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_producto = convert(smallint, @i_param1)
  select
    @w_fecha = convert(datetime, @i_param2)
  select
    @w_cliente = convert(int, @i_param3)

  delete cob_conta_tercero..ct_sasiento_tmp
  where  sa_producto = 4

  delete cob_conta_tercero..ct_scomprobante_tmp
  where  sc_producto = 4

  select
    *
  into   #boc
  from   cob_conta..cb_boc
  where  bo_producto   = @w_producto
     and bo_cliente    = isnull(@w_cliente,
                                bo_cliente)
     and bo_diferencia <> 0

  select
    cliente = bo_cliente,
    diferencia = sum(bo_diferencia)
  into   #clientes_descuadrados
  from   #boc
  group  by bo_cliente
  having sum(bo_diferencia) <> 0

  delete #boc
  from   #clientes_descuadrados
  where  bo_cliente = cliente

  select distinct
    bo_oficina
  into   #oficinas
  from   #boc

  while 1 = 1
  begin
    select top 1
      @w_oficina = bo_oficina
    from   #oficinas
    if @@rowcount = 0
      break

    delete #oficinas
    where  bo_oficina = @w_oficina

    begin tran

    /* OBTENER EL NUMERO DE COMPROBANTE */
    exec @w_error = cob_conta..sp_cseqcomp
      @i_tabla     = 'cb_scomprobante',
      @i_empresa   = 1,
      @i_fecha     = @w_fecha,
      @i_modulo    = @w_producto,
      @i_modo      = 0,-- Numera por EMPRESA-FECHA-PRODUCTO
      @o_siguiente = @w_comprobante out
    if @w_error <> 0
    begin
      select
        @w_msg = ' ERROR AL GENERAR NUMERO COMPROBANTE '
      goto final
    end

    insert into cob_conta_tercero..ct_sasiento_tmp with (rowlock)
                (sa_producto,sa_fecha_tran,sa_comprobante,sa_empresa,sa_asiento,
                 sa_cuenta,sa_oficina_dest,sa_area_dest,sa_debito,sa_concepto,
                 sa_credito_me,sa_credito,sa_debito_me,sa_cotizacion,sa_tipo_doc
                 ,
                 sa_tipo_tran,sa_moneda,sa_opcion,sa_ente,
                 sa_con_rete,
                 sa_base,sa_valret,sa_con_iva,sa_valor_iva,sa_iva_retenido,
                 sa_con_ica,sa_valor_ica,sa_con_timbre,sa_valor_timbre,
                 sa_con_iva_reten,
                 sa_con_ivapagado,sa_valor_ivapagado,sa_documento,sa_mayorizado,
                 sa_con_dptales,
                 sa_valor_dptales,sa_posicion,sa_oper_banco,sa_debcred,sa_cheque
                 ,
                 sa_doc_banco,sa_fecha_est,sa_detalle,sa_error
    )
      select
        @w_producto,@w_fecha,@w_comprobante,1,row_number()
          over(
            order by bo_cliente),
        bo_cuenta,bo_oficina,31,case
          when bo_diferencia > 0 then abs(bo_diferencia)
          else 0
        end,'RECLASIFICACION BOC AHORROS ' + convert(varchar(10), @w_fecha, 103)
        ,
        0,case
          when bo_diferencia < 0 then abs(bo_diferencia)
          else 0
        end,0,1,'N',
        'A',0,0,bo_cliente,null,
        0,null,'N',0.00,null,
        null,null,null,null,null,
        null,null,'','N',null,
        null,'S',null,case
          when bo_diferencia > 0 then '1'
          else '2'
        end,null,
        null,null,null,'N'
      from   #boc
      where  bo_oficina = @w_oficina
      order  by bo_cliente
    if @@error <> 0
    begin
      print 'Error al insertar asiento'
      rollback tran
      goto final
    end

    select
      @w_asientos = count(1),
      @w_tot_debito = round(sum(sa_debito),
                            2),
      @w_tot_credito = round(sum(sa_credito),
                             2)
    from   cob_conta_tercero..ct_sasiento_tmp
    where  sa_oficina_dest = @w_oficina

    if @w_tot_debito <> @w_tot_credito
    begin
      print 'OFICINA: ' + convert(varchar, @w_oficina) + ' DESCUADRADA'
      rollback tran
      goto siguiente
    end

    insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock)
                (sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
                 sc_oficina_orig,
                 sc_area_orig,sc_digitador,sc_descripcion,sc_fecha_gra,sc_perfil
                 ,
                 sc_detalles,sc_tot_debito,sc_tot_credito,
                 sc_tot_debito_me,
                 sc_tot_credito_me,
                 sc_automatico,sc_reversado,sc_estado,sc_mayorizado,
                 sc_observaciones
                 ,
                 sc_comp_definit,sc_usuario_modulo,sc_tran_modulo,
                 sc_error)
    values      ( @w_producto,@w_comprobante,1,@w_fecha,@w_oficina,
                  31,'contabatch','RECLASIFICACION BOC AHORROS ' + convert(
                  varchar
                  ( 10), @w_fecha, 103),convert(char(10), getdate(), 101),
                  'AJUS_AHO'
                  ,
                  @w_asientos,@w_tot_debito,@w_tot_credito,0.00,0.00,
                  @w_producto,'N','I','N',null,
                  null,'contabatch',0,'N')
    if @@error <> 0
    begin
      print 'Error al insertar asiento'
      rollback tran
      goto final
    end

    if @@trancount > 0
    begin
      commit tran
    end
    siguiente:
  end

  final:
  return 0

go

