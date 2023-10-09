/*************************************************************************/
/*  Archivo:            ahdatblq.sp                                      */
/*  Stored procedure:   sp_datos_bloq_rec                                */
/*  Base de datos:      cob_ahorros                                      */
/*  Producto:           Ahorros                                          */
/*  Fecha de escritura:                                                  */
/*************************************************************************/
/*                               IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier alteracion o agregado hecho por alguno  de sus             */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.      */
/*  Este programa esta protegido por la ley de derechos de autor         */
/*  y por las convenciones  internacionales de propiedad inte-           */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para        */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier infraccion.                    */
/*************************************************************************/
/*                               PROPOSITO                               */
/*  Ingresar informacion de los bloqueos de cuentas a las tablas de REC. */
/*************************************************************************/
/*                            MODIFICACIONES                             */
/*  FECHA         AUTOR           RAZON                                  */
/*  03/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO           */
/*************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_bloq_rec')
  drop proc sp_datos_bloq_rec
go

/****** Object:  StoredProcedure [dbo].[sp_datos_bloq_rec]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_bloq_rec
  @t_show_version bit = 0
as
  declare
    @w_error      int,
    @w_msg        descripcion,
    @w_fecha_proc datetime,
    @w_tabla      int,
    @w_sp_name    varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_datos_bloq_rec'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */
  select
    @w_fecha_proc = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 4

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR AHORROS EN COB_EXTERNOS */

  delete cob_externos..ex_bloqueo_operaciones
  where  bo_aplicativo = 4

  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg =
    'Error al eliminar registros cob_externos..ex_bloqueo_operaciones'
    goto ERROR
  end

  /********* Insercion de los regsitros de Bloqueos  **************/
  select
    bo_fecha = cb_fecha,
    bo_banco = ah_cta_banco,
    bo_aplicativo = convert(tinyint, 4),
    bo_secuencial = case cb_estado
                      when 'C' then cb_secuencial
                      when 'L' then cb_sec_asoc
                      when 'V' then cb_secuencial
                    end,
    bo_causa_bloqueo = 1,-- 'BLOQUEOS DE MOVIMIENTO'
    bo_fecha_bloqueo = cb_fecha,
    bo_fecha_desbloqueo= case cb_estado
                           when 'C' then convert(datetime, null)
                           when 'L' then (select
                                            b.cb_fecha
                                          from   cob_ahorros..ah_ctabloqueada b
                                          where  b.cb_secuencial = a.cb_sec_asoc
                                         )
                         end,
    bo_estado = case cb_estado
                  when 'C' then 'A'
                  when 'V' then 'A'
                  when 'L' then 'C'
                end
  into   #bloqueo_ope
  from   cob_ahorros..ah_ctabloqueada a,
         cob_ahorros..ah_cuenta_tmp
  where  cb_fecha  = @w_fecha_proc
     and cb_cuenta = ah_cuenta
  order  by cb_cuenta

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar tabla ah_ctabloqueada '
    goto ERROR
  end

  insert into #bloqueo_ope
              (bo_fecha,bo_banco,bo_aplicativo,bo_secuencial,bo_causa_bloqueo,
               bo_fecha_bloqueo,bo_fecha_desbloqueo,bo_estado)
    select
      hb_fecha,ah_cta_banco,ah_producto,case hb_accion
        when 'B' then hb_secuencial
        when 'L' then hb_sec_asoc
      end,case hb_causa
        when '1' then 2
        else 3
      end,-- SI la Causal es 16, es EMBARGO sino es por VALOR
      hb_fecha,case hb_accion
        when 'B' then convert(datetime, null)
        when 'L' then (select
                         isnull(b.hb_fecha_ven,
                                b.hb_fecha)
                       from   cob_ahorros..ah_his_bloqueo b
                       where  b.hb_secuencial = a.hb_sec_asoc)
      end,case hb_accion
        when 'B' then 'A'
        when 'L' then 'C'
      end
    from   cob_ahorros..ah_his_bloqueo a,
           cob_ahorros..ah_cuenta_tmp
    where  hb_fecha  = @w_fecha_proc
       and hb_cuenta = ah_cuenta

  if @@error <> 0
  begin
    select
      @w_error = 499999,
      @w_msg = 'Error al grabar tabla ah_his_bloqueo '
    goto ERROR
  end

  if exists (select
               1
             from   #bloqueo_ope)
  begin
    print ' Ex_bloqueo_operaciones..........'
    insert into cob_externos..ex_bloqueo_operaciones
                (bo_fecha,bo_banco,bo_aplicativo,bo_secuencial,bo_causa_bloqueo,
                 bo_fecha_bloqueo,bo_fecha_desbloqueo,bo_estado)
      select
        bo_fecha,bo_banco,bo_aplicativo,bo_secuencial,bo_causa_bloqueo,
        bo_fecha_bloqueo,bo_fecha_desbloqueo,bo_estado
      from   #bloqueo_ope

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar tabla ex_bloqueo_operaciones '
      goto ERROR
    end
  end
  else
    print ' No hay registros a procesar'

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_bloq_rec'

  return @w_error

go

