/************************************************************************/
/*   Archivo:             ah_cont_trn.sp                                */
/*   Stored procedure:    sp_act_cont_trn                               */
/*   Base de datos:       cob_ahorros                                   */
/*   Producto:            Ahorros                                       */
/*   Disenado por:        Luis Carlos Moreno C.                         */
/*   Fecha de escritura:  Abril/2012                                    */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                           PROPOSITO                                  */
/*  V=Retorna el valor por comision de acuerdo a la trn consultada      */
/*  I=Incrementa contador de trn mensuales por tipo de transaccion      */
/*  D=Incrementa contador de trn mensuales por tipo de transaccion      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA      AUTOR             RAZON                                  */
/*  12-04-12   L.Moreno          Emisión Inicial - REQ 203              */
/*  02-05-16   Ignacio Yupa      Migración a CEN                        */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_act_cont_trn')
  drop proc sp_act_cont_trn
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_act_cont_trn
(
  @s_ssn          int = null,
  @s_ssn_branch   int = null,
  @s_date         datetime = null, 
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_cta          cuenta = null,
  @i_trn_accion   int = null,
  @o_comision     money = null out
)
as
  declare
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_numtrn_max       int,
    @w_categoria        char(1),
    @w_tipocta          char(1),
    @w_rolente          char(1),
    @w_tipo_def         char(1),
    @w_prod_banc        smallint,
    @w_producto         tinyint,
    @w_moneda           tinyint,
    @w_tipo             char(1),
    @w_default          int,
    @w_disponible       money,
    @w_saldo_contable   money,
    @w_saldo_para_girar money,
    @w_promedio1        money,
    @w_prom_disponible  money,
    @w_personalizada    char(1),
    @w_filial           tinyint,
    @w_oficina          smallint,
    @w_return           int,
    @w_error            int,
    @w_rol_ente         char(1),
    @w_ano              char(4),
    @w_mes              char(2),
    @w_trn_acum         int

  select
    @w_sp_name = 'sp_act_cont_trn'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Obtiene mes y dia de la fecha */
  select
    @w_mes = substring(convert(varchar(10), @s_date, 103),
                       4,
                       2)
  select
    @w_ano = substring(convert(varchar(10), @s_date, 103),
                       7,
                       4)

  if @i_operacion = 'I'
  begin
    if exists(select
                1
              from   ah_tran_mensual with (nolock)
              where  tm_ano     = @w_ano
                 and tm_mes     = @w_mes
                 and tm_cuenta  = @i_cta
                 and tm_cod_trn = @i_trn_accion)
    begin
      update ah_tran_mensual with (rowlock)
      set    tm_cantidad = tm_cantidad + 1
      where  tm_ano     = @w_ano
         and tm_mes     = @w_mes
         and tm_cuenta  = @i_cta
         and tm_cod_trn = @i_trn_accion

      if @@error <> 0
      begin
        select
          @w_error = 251105
        goto ERROR
      end
    end
    else
    begin
      insert ah_tran_mensual
      values( @w_ano,@w_mes,@i_cta,@i_trn_accion,1)
      if @@error <> 0
      begin
        select
          @w_error = 251105
        goto ERROR
      end
    end

  end

  if @i_operacion = 'D'
  begin
    if exists(select
                1
              from   ah_tran_mensual with (nolock)
              where  tm_ano      = @w_ano
                 and tm_mes      = @w_mes
                 and tm_cuenta   = @i_cta
                 and tm_cod_trn  = @i_trn_accion
                 and tm_cantidad > 0)
    begin
      update ah_tran_mensual with (rowlock)
      set    tm_cantidad = tm_cantidad - 1
      where  tm_ano     = @w_ano
         and tm_mes     = @w_mes
         and tm_cuenta  = @i_cta
         and tm_cod_trn = @i_trn_accion

      if @@error <> 0
      begin
        select
          @w_error = 251105
        goto ERROR
      end
    end
  end

  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error
  return 1

go

