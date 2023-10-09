/*****************************************************************************/
/*  ARCHIVO:         ah_dattrf.sp                                            */
/*  NOMBRE LOGICO:   sp_datos_transf_cta                                     */
/*  PRODUCTO:        Ahorros                                                 */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                            PROPOSITO                                      */
/* Ingresar informacion de los movimientos de transferencia de ctas.         */
/*****************************************************************************/
/*                          MODIFICACIONES                                   */
/*   FECHA           AUTOR               RAZON                               */
/* 07/02/2014      E.Jimenez          Historico transaferencia de ctas       */
/* 03/May/2016     J. Salazar         Migracion COBIS CLOUD MEXICO           */
/*****************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_transf_cta')
  drop proc sp_datos_transf_cta
go

/****** Object:  StoredProcedure [dbo].[sp_datos_transf_cta]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_transf_cta
  @t_show_version bit = 0
as
  declare
    @w_error         int,
    @w_msg           descripcion,
    @w_fecha         datetime,
    @w_tabla         int,
    @w_ciudad        int,
    @w_sp_name       varchar(30),
    @w_siguiente_dia datetime

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_datos_transf_cta'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* TRAER LA FECHA MAX DE TRN TRASF CTA */
  select
    @w_fecha = max(hm_fecha)
  from   cob_ahorros_his..ah_his_movimiento
  where  hm_tipo_tran in (300, 237)

  print ' comienza '

  /*** ELIMINA DATOS EN ex_carga_archivo_ctas***/
  if exists (select
               1
             from   cob_conta_super..sb_transf_ctas)
  begin
    delete cob_conta_super..sb_transf_ctas

    if @@error <> 0
    begin
      select
        @w_error = 147000,
        @w_msg = 'Error al eliminar registros cob_conta_super..sb_transf_ctas'
      goto ERROR
    end
  end

  insert into cob_conta_super..sb_transf_ctas
    select
      hm_fecha,hm_hora,hm_secuencial,hm_ssn_branch,hm_tipo_tran,
      hm_oficina,hm_usuario,hm_signo,hm_cta_banco,hm_ctadestino,
      hm_oficina_cta,hm_monto_imp,hm_cliente,hm_base_gmf,hm_valor
    from   cob_ahorros_his..ah_his_movimiento
    where  hm_fecha >= @w_fecha
       and hm_tipo_tran in (300, 237)

  if @@error <> 0
  begin
    select
      @w_error = 28010,
      @w_msg = 'ERROR INSERTANDO DATOS EN cob_conta_super..sb_transf_ctas'
    print @w_msg
    goto ERROR
  end

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'Opbatch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_transf_cta'

  return @w_error

go

