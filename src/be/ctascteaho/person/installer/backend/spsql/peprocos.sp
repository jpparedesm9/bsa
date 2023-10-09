/****************************************************************************/
/*     Archivo:     peprocos.sp                                             */
/*     Stored procedure: sp_proceso_costos                                  */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por: Juan Carlos Gordillo                                   */
/*     Fecha de escritura: 16-Mar-1995                                      */
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
/*     Este programa inserta/actualiza costos bancarios.                    */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*  FECHA       AUTOR           RAZON                                       */
/*  16/03/95    J.Gordillo      Emision Inicial                             */
/*  07/Feb/96   J.Gordillo      Cursores                                    */
/*  01/Ago/96   Juan F. Cadena  Revision B. de Prestamos                    */
/*  08/Abr/05   Y. Martinez     SNR 604                                     */
/*  04/Ene/06   Carlos Leon     Actualizar costos esp en linea              */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_proceso_costos')
  drop proc sp_proceso_costos
go

create proc sp_proceso_costos
(
  @s_user         varchar(30) = null,
  @s_ssn          int = null,
  @s_ofi          smallint = null,
  @s_srv          varchar(30) = null,
  @s_date         datetime = null,
  @i_param1       datetime = null,
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name      varchar(32),
    @w_today        datetime,
    @w_return       int,
    @w_servicio_per smallint,
    @w_categoria    catalogo,
    @w_tipo_rango   tinyint,
    @w_grupo_rango  smallint,
    @w_rango        tinyint,
    @w_val_medio    float,
    @w_minimo       float,
    @w_maximo       float,
    @w_secuencial   int,
    @w_sec_costo    int,
    @w_decimal      char(1),
    @w_no_decimal   tinyint,
    @w_tipo_dato    char(1),
    @w_contador     int,
    @w_numero       int,
    @w_servicio_dis smallint,
    @w_rubro        catalogo,
    @w_cuenta       cuenta,
    @w_cliente      int,
    @w_oficina      smallint,
    @w_tipo_costo   char(1)

  select
    @w_sp_name    = 'sp_proceso_costos',
    @w_today      = @s_date,
    @w_decimal    = 'N',
    @w_no_decimal = 0
	
	--02/Ago/2016 Actualización de variables cuando la llamada al sp es por visual batch 
	if @s_date is null
    begin
	    if @i_param1 is null
		    return 1
		else
		    select @w_today = @i_param1
    end
		
	if @s_ofi is null
	begin
	    select @s_ofi = of_oficina 
		from cobis..cl_oficina
        where of_nombre like '%MATRIZ%'
		
		if @s_ofi is null
		    return 1
	end

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @s_ssn is null
    exec @s_ssn = ADMIN...rp_ssn

  /********** Depuracion de la tabla de Cambios de Costos **********/
  print ' @w_today' + cast(@w_today as varchar)

  declare depuracion cursor for
    select
      cc_servicio_per,
      cc_categoria,
      cc_tipo_rango,
      cc_grupo_rango,
      cc_rango
    from   pe_cambio_costo
    where  cc_fecha_vigencia = @w_today
       and cc_en_linea       = 'N'
  open depuracion

  fetch depuracion into @w_servicio_per,
                        @w_categoria,
                        @w_tipo_rango,
                        @w_grupo_rango,
                        @w_rango

  while (@@fetch_status = 0)
  begin
    select
      @w_secuencial = max(cc_secuencial),
      @w_numero = count(*)
    from   pe_cambio_costo
    where  cc_servicio_per   = @w_servicio_per
       and cc_categoria      = @w_categoria
       and cc_tipo_rango     = @w_tipo_rango
       and cc_grupo_rango    = @w_grupo_rango
       and cc_rango          = @w_rango
       and cc_fecha_vigencia = @w_today
       and cc_en_linea       = 'N'

    if @w_numero > 1
    begin
      update pe_cambio_costo
      set    cc_en_linea = 'S'
      where  cc_servicio_per   = @w_servicio_per
         and cc_categoria      = @w_categoria
         and cc_tipo_rango     = @w_tipo_rango
         and cc_grupo_rango    = @w_grupo_rango
         and cc_rango          = @w_rango
         and cc_fecha_vigencia = @w_today
         and cc_en_linea       = 'N'
         and cc_secuencial     < @w_secuencial
    end

    nuevo:
    fetch depuracion into @w_servicio_per,
                          @w_categoria,
                          @w_tipo_rango,
                          @w_grupo_rango,
                          @w_rango
  end

  close depuracion
  deallocate depuracion

  print '/*=========[ Actualizamos cambios realizados ]===================*/'

  declare cambio_costo cursor for
    select
      cc_servicio_per,
      cc_categoria,
      cc_tipo_rango,
      cc_grupo_rango,
      cc_rango,
      cc_val_medio,
      cc_minimo,
      cc_maximo
    from   pe_cambio_costo
    where  cc_fecha_vigencia = @w_today
       and cc_en_linea       = 'N'
       and cc_confirmado     = 'S'
    for update of cc_en_linea

  open cambio_costo

  fetch cambio_costo into @w_servicio_per,
                          @w_categoria,
                          @w_tipo_rango,
                          @w_grupo_rango,
                          @w_rango,
                          @w_val_medio,
                          @w_minimo,
                          @w_maximo

  select
    @w_contador = 0

  while (@@fetch_status = 0)
  begin
    select
      @w_contador = @w_contador + 1
    if @w_contador % 10 = 0
      print 'CONTADOR ' + cast(@w_contador as varchar)

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

    /* Encontramos el secuencial de costo */
    exec @w_return = cobis..sp_cseqnos
      @t_debug     = 'N',
      @t_file      = null,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_costo',
      @o_siguiente = @w_sec_costo out
    if @w_return != 0
    begin
      goto SIGUIENTE
    end

    print 'insert secuencial @w_sec_costo ' + cast(@w_sec_costo as varchar)

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
      goto SIGUIENTE
    end

    /* Transaccion de Servicio */

    insert into pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_cod_alterno,ts_servicio_per,ts_categoria,
                 ts_tipo_rango,
                 ts_grupo_rango,ts_rango,ts_minimo,ts_val_medio,ts_maximo,
                 ts_fecha_vigencia)
    values      (@s_ssn,4060,@s_ofi,'sa','consola',
                 'N',@w_contador,@w_servicio_per,@w_categoria,@w_tipo_rango,
                 @w_grupo_rango,@w_rango,@w_minimo,@w_val_medio,@w_maximo,
                 @w_today)

    /*Ocurrio un error en la insercion de transaccion de servicio*/
    if @@error != 0
    begin
      goto SIGUIENTE
    end

    update pe_cambio_costo
    set    cc_en_linea = 'S'
    where  current of cambio_costo

    if @@error != 0
    begin
      goto SIGUIENTE
    end

    SIGUIENTE:
    fetch cambio_costo into @w_servicio_per,
                            @w_categoria,
                            @w_tipo_rango,
                            @w_grupo_rango,
                            @w_rango,
                            @w_val_medio,
                            @w_minimo,
                            @w_maximo
  end

  close cambio_costo
  deallocate cambio_costo

  /* CLE Actualizacion de costos especiales a ponerse en linea */

  declare depuracion cursor for
    select
      ce_servicio_dis,
      ce_rubro,
      ce_tipo_rango,
      ce_grupo_rango,
      ce_rango
    from   pe_costo_especial
    where  ce_en_linea = 'N'

  open depuracion

  fetch depuracion into @w_servicio_dis,
                        @w_rubro,
                        @w_tipo_rango,
                        @w_grupo_rango,
                        @w_rango

  while (@@fetch_status = 0)
  begin
    select
      @w_numero = count(*)
    from   pe_costo_especial
    where  ce_servicio_dis = @w_servicio_dis
       and ce_rubro        = @w_rubro
       and ce_tipo_rango   = @w_tipo_rango
       and ce_grupo_rango  = @w_grupo_rango
       and ce_rango        = @w_rango
       and ce_aprobado     = 'S'

    if @w_numero > 1
    begin
      delete pe_costo_especial
      where  ce_servicio_dis = @w_servicio_dis
         and ce_rubro        = @w_rubro
         and ce_tipo_rango   = @w_tipo_rango
         and ce_grupo_rango  = @w_grupo_rango
         and ce_rango        = @w_rango
         and ce_en_linea     = 'S'
    end

    next:
    fetch depuracion into @w_servicio_dis,
                          @w_rubro,
                          @w_tipo_rango,
                          @w_grupo_rango,
                          @w_rango
  end

  close depuracion
  deallocate depuracion

  /* Actualizacion costos especiales generales a poner en linea */

  update pe_costo_especial
  set    ce_en_linea = 'S'
  where  ce_fecha_vigencia = @w_today
     and ce_en_linea       = 'N'
     and ce_aprobado       = 'S'

  if @@error != 0
  begin
    print 'Error al actualizar costos especiales generales en linea '
    return 1
  end

  --print 'TOTAL ' + cast(@w_contador as varchar)
  return 0

GO 
