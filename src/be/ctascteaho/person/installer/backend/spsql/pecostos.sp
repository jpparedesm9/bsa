/****************************************************************************/
/*     Archivo:     pecostos.sp                                             */
/*     Stored procedure: sp_tr_costos                                       */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 15-Mar-1995                                      */
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
/*     Este programa inserta/elimina/actualiza/consulta de costos           */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     15/MAR/1995     J.Gordillo      Emision inicial                      */
/*     30/Sep/2003     Gloria Rueda    Retornar codigos de error            */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_costos')
  drop proc sp_tr_costos
go

create proc sp_tr_costos
(
  @s_ssn          int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint=null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name      varchar(32),
    @w_today        datetime,
    @w_return       int,
    @w_secuencial   int,
    @w_siguiente    int,
    @w_sec_costo    int,
    @w_decimal      char(1),
    @w_no_decimal   tinyint,
    @w_tipo_dato    char(1),
    @w_servicio_per smallint,
    @w_categoria    catalogo,
    @w_tipo_rango   tinyint,
    @w_grupo_rango  smallint,
    @w_rango        tinyint,
    @w_val_medio    real,
    @w_minimo       real,
    @w_maximo       real,
    @w_contador     int

  select
    @w_sp_name = 'sp_tr_costos',
    @w_decimal = 'N',
    @w_no_decimal = 0

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = @s_date

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
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn
    exec cobis..sp_end_debug
  end

  if @t_trn != 4060
  begin
    /* Error en el codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  select
    @w_siguiente = 0,
    @w_contador = 1

  while (1 = 1)
  begin
    begin tran

    set rowcount 1

    select
      @w_servicio_per = cc_servicio_per,
      @w_categoria = cc_categoria,
      @w_tipo_rango = cc_tipo_rango,
      @w_grupo_rango = cc_grupo_rango,
      @w_rango = cc_rango,
      @w_minimo = cc_minimo,
      @w_val_medio = cc_val_medio,
      @w_maximo = cc_maximo,
      @w_secuencial = cc_secuencial
    from   pe_cambio_costo
    where  cc_fecha_vigencia = @w_today
       and cc_en_linea       = 'N'
       and cc_secuencial     > @w_siguiente

    if @@rowcount = 0
    begin
      break
    end

    select
      @w_tipo_dato = vs_tipo_dato
    from   pe_var_servicio,
           pe_servicio_per
    where  sp_servicio_per = @w_servicio_per
       and vs_servicio_dis = sp_servicio_dis
       and vs_rubro        = sp_rubro

    if @w_tipo_dato = 'M'
    begin
      select
        @w_decimal = mo_decimales
      from   cobis..cl_moneda,
             pe_tipo_rango
      where  tr_tipo_rango = @w_tipo_rango
         and mo_moneda     = tr_moneda

      if @w_decimal = 'S'
      begin
        select
          @w_no_decimal = pa_tinyint
        from   cobis..cl_parametro
        where  pa_nemonico = 'DCI'
      end
    end
    else if @w_tipo_dato = 'P'
      select
        @w_no_decimal = 2

    select
      @w_val_medio = round(@w_val_medio,
                           @w_no_decimal),
      @w_minimo = round(@w_minimo,
                        @w_no_decimal),
      @w_maximo = round(@w_maximo,
                        @w_no_decimal)

    /* Encontramos el secuencial */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = 'N',
      @t_file      = null,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_sec_costo out
    if @w_return != 0
    begin
      rollback tran
      select
        @w_siguiente = @w_secuencial
      continue
    end

    insert into cob_remesas..pe_costo
                (co_secuencial,co_servicio_per,co_categoria,co_tipo_rango,
                 co_grupo_rango,
                 co_rango,co_val_medio,co_minimo,co_maximo,co_fecha_vigencia,
                 co_usuario)
    values      (@w_sec_costo,@w_servicio_per,@w_categoria,@w_tipo_rango,
                 @w_grupo_rango,
                 @w_rango,@w_val_medio,@w_minimo,@w_maximo,@w_today,
                 @s_user)

    /*Ocurrio un error en la insercion*/
    if @@error != 0
    begin
      rollback tran
      select
        @w_siguiente = @w_secuencial
      continue
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_cod_alterno,ts_servicio_per,ts_categoria,
                 ts_tipo_rango,
                 ts_grupo_rango,ts_rango,ts_minimo,ts_val_medio,ts_maximo,
                 ts_fecha_vigencia)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 'N',@w_contador,@w_servicio_per,@w_categoria,@w_tipo_rango,
                 @w_grupo_rango,@w_rango,@w_minimo,@w_val_medio,@w_maximo,
                 @w_today)

    /*Ocurrio un error en la insercion*/
    if @@error != 0
    begin
      rollback tran
      select
        @w_siguiente = @w_secuencial
      continue
    end

    update pe_cambio_costo
    set    cc_en_linea = 'S'
    where  cc_secuencial = @w_secuencial

    if @@error != 0
    begin
      rollback tran
      select
        @w_siguiente = @w_secuencial
      continue
    end

    select
      @w_siguiente = @w_secuencial,
      @w_contador = @w_contador + 1

    commit tran
    continue
  end
  return 0

GO 
