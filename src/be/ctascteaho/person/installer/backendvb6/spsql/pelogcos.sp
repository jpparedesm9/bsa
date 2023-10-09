/****************************************************************************/
/*     Archivo:     pelogcos.sp                                             */
/*     Stored procedure: sp_reg_cambios_costos                               */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta las transacciones a realizar sobre la tabla    */
/*     pe_costos.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    15/DIC/94       G.Calderon    Emision Inicial                         */
/*    30/Sep/2003     Gloria Rueda  Retornar c¢digos de error               */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_reg_cambios_costos')
  drop proc sp_reg_cambios_costos
go

create proc sp_reg_cambios_costos
(
  @s_ssn            int = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_user           varchar(30) = null,
  @s_sesn           int,
  @s_term           varchar(10),
  @s_date           datetime,
  @s_org            char(1),
  @s_ofi            smallint,
  @s_rol            smallint,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            mensaje = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(14) = null,
  @t_from           varchar(32) = null,
  @t_rty            char(1) = 'N',
  @t_trn            smallint= null,
  @t_show_version   bit = 0,
  @i_operacion      char(1)= null,
  @i_tipo           char(1)= 'I',
  @i_servicio_per   smallint= null,
  @i_categoria      char(1)= null,
  @i_tipo_rango     tinyint= null,
  @i_rango          tinyint= null,
  @i_medio          float = null,
  @i_minimo         float = null,
  @i_maximo         float = null,
  @i_fecha_vigencia char(10)
)
as
  declare
    @w_sp_name        varchar(32),
    @w_today          datetime,
    @w_secuencial     int,
    @w_return         int,
    @w_fecha_vigencia smalldatetime,
    @w_grupo_rango    smallint

  select
    @w_sp_name = 'sp_reg_cambios_costos',
    @w_today = @s_date,
    @w_fecha_vigencia = @i_fecha_vigencia

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      i_operacion = @i_operacion,
      i_servicio_per = @i_servicio_per,
      i_categoria = @i_categoria,
      i_tipo_rango = @i_tipo_rango,
      i_rango = @i_rango,
      i_medio = @i_medio
    exec cobis..sp_end_debug
  end

  if @t_trn not in (4049, 4050, 4051)
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @i_operacion not in ('I', 'U', 'D')
  begin
    /*Error en codigo de operacion*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351534
    return 351534
  end

  if @t_trn != 4049
     and @i_operacion = 'I'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @t_trn != 4050
     and @i_operacion = 'U'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @t_trn != 4051
     and @i_operacion = 'D'
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  if @i_tipo not in ('I', 'A')
  begin
    /*Error en tipo de consulta*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351535
    return 351535
  end

  if @i_tipo = 'I'
  begin
    if not exists (select
                     *
                   from   cobis..cl_catalogo a,
                          cobis..cl_tabla b
                   where  a.codigo = @i_categoria
                      and a.tabla  = b.codigo
                      and b.tabla  = 'pe_categoria')
    begin
      /*Categoria no definida  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351529
      return 351529
    end

    if not exists (select
                     *
                   from   cob_remesas..pe_rango
                   where  ra_rango      = @i_rango
                      and ra_tipo_rango = @i_tipo_rango)
    begin
      /* Rango no definido  */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351530
      return 351530
    end
  end

  if exists (select
               *
             from   pe_cambio_costo
             where  cc_servicio_per   = @i_servicio_per
                and cc_categoria      = @i_categoria
                and cc_tipo_rango     = @i_tipo_rango
                and cc_rango          = @i_rango
                and cc_minimo         = @i_minimo
                and cc_val_medio      = @i_medio
                and cc_maximo         = @i_maximo
                and cc_fecha_vigencia = @w_fecha_vigencia)
    return 0

  begin tran

  /*Encontrar el secuencial*/
  exec @w_return = cobis..sp_cseqnos
    @t_debug     = 'N',
    @t_file      = null,
    @t_from      = @w_sp_name,
    @i_tabla     = 'pe_cambio_costo',
    @o_siguiente = @w_secuencial out
  if @w_return != 0
  begin
    rollback tran
    return @w_return
  end

  /******[ Insertar un nuevo registro de cambio de costo]*********/

  select
    @w_grupo_rango = sp_grupo_rango
  from   pe_servicio_per
  where  sp_servicio_per = @i_servicio_per

  insert into cob_remesas..pe_cambio_costo
              (cc_servicio_per,cc_categoria,cc_tipo_rango,cc_grupo_rango,
               cc_rango,
               cc_val_medio,cc_minimo,cc_maximo,cc_fecha_cambio,cc_operacion,
               cc_tipo,cc_secuencial,cc_fecha_vigencia,cc_en_linea)
  values      (@i_servicio_per,@i_categoria,@i_tipo_rango,@w_grupo_rango,
               @i_rango,
               @i_medio,@i_minimo,@i_maximo,@w_today,@i_operacion,
               @i_tipo,@w_secuencial,@w_fecha_vigencia,'N')

  /*Ocurrio un error en la insercion*/
  if @@error != 0
  begin
    /*Error en la insercion de cambio costos*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 353512
    rollback tran
    return 353512
  end

  /* Transaccion de Servicio */

  insert into pe_tran_servicio
              (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
               ts_terminal,
               ts_reentry,ts_cod_alterno,ts_servicio_per,ts_categoria,
               ts_tipo_rango,
               ts_grupo_rango,ts_rango,ts_operacion,ts_tipo,ts_minimo,
               ts_val_medio,ts_maximo,ts_fecha_cambio,ts_fecha_vigencia)
  values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
               'N',0,@i_servicio_per,@i_categoria,@i_tipo_rango,
               @w_grupo_rango,@i_rango,@i_operacion,@i_tipo,@i_minimo,
               @i_medio,@i_maximo,@w_today,@w_fecha_vigencia)

  /*Ocurrio un error en la insercion*/
  if @@error != 0
  begin
    /*Error en la insercion de transaccion de servicio*/
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 353515
    rollback tran
    return 353515
  end
  commit tran
  return 0

GO 
