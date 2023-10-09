/****************************************************************************/
/*     Archivo:             pe_costot.sp                                    */
/*     Stored procedure:    sp_costos_total                                 */
/*     Base de datos:       cob_remesas                                     */
/*     Producto:            Sub-Modulo de Personalizacion                   */
/*     Disenado por:        Javier Bucheli Vaca                             */
/*     Fecha de escritura:  13 de Enero de 1997                             */
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
/*     Programa para realizar la actualizacion de costos para una o varias  */
/*     sucursales, creando el servicio personzalizable si no existe         */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/Ene/1997      J. Bucheli      Emision Inicial para                */
/*                                      Banco de Prestamos                  */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_costos_total')
  drop proc sp_costos_total
go
create proc sp_costos_total
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
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
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_prod_cobis   tinyint,
  @i_prod_banc    smallint,
  @i_sector       varchar(10),
  @i_mon          tinyint,
  @i_filial       tinyint,
  @i_num_suc      tinyint,
  @i_suc1         smallint = null,
  @i_suc2         smallint = null,
  @i_suc3         smallint = null,
  @i_suc4         smallint = null,
  @i_suc5         smallint = null,
  @i_suc6         smallint = null,
  @i_suc7         smallint = null,
  @i_suc8         smallint = null,
  @i_suc9         smallint = null,
  @i_suc10        smallint = null,
  @i_suc11        smallint = null,
  @i_suc12        smallint = null,
  @i_suc13        smallint = null,
  @i_suc14        smallint = null,
  @i_suc15        smallint = null,
  @i_suc16        smallint = null,
  @i_suc17        smallint = null,
  @i_suc18        smallint = null,
  @i_suc19        smallint = null,
  @i_suc20        smallint = null,
  @i_suc21        smallint = null,
  @i_suc22        smallint = null,
  @i_suc23        smallint = null,
  @i_suc24        smallint = null,
  @i_suc25        smallint = null,
  @i_suc26        smallint = null,
  @i_suc27        smallint = null,
  @i_suc28        smallint = null,
  @i_suc29        smallint = null,
  @i_suc30        smallint = null,
  @i_suc31        smallint = null,
  @i_suc32        smallint = null,
  @i_suc33        smallint = null,
  @i_suc34        smallint = null,
  @i_suc35        smallint = null,
  @i_suc36        smallint = null,
  @i_suc37        smallint = null,
  @i_suc38        smallint = null,
  @i_suc39        smallint = null,
  @i_suc40        smallint = null,
  @i_serv_dis     smallint,
  @i_rubro        varchar(10),
  @i_tipo_rango   tinyint,
  @i_grupo_rango  smallint,
  @i_categoria    varchar(10),
  @i_rango        tinyint,
  @i_val_med      real,
  @i_val_min      real,
  @i_val_max      real,
  @i_fecha_vigen  datetime
)
as
  declare
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_tipo_rango   tinyint,
    @w_grupo_rango  smallint,
    @w_cont         tinyint,
    @w_suc_proceso  smallint,
    @w_pro_final    smallint,
    @w_mercado      smallint,
    @w_servicio_per smallint,
    @w_sec_costo    int,
    @w_mensaje      varchar(255),
    @w_aux          varchar(64),
    @w_cod_alterno  int

  -- Captura del nombre de Stored Procedure

  select
    @w_sp_name = 'sp_costos_total',
    @w_cod_alterno = 0

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Inicializacion del contador de sucursales procesadas

  select
    @w_cont = 1

  --Determinacion del codigo de mercado

  select
    @w_mercado = me_mercado
  from   cob_remesas..pe_mercado
  where  me_pro_bancario = @i_prod_banc
     and me_tipo_ente    = @i_sector
     and me_estado       = 'V'

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351511
    return 351511
  end

  -- Lazo para validar los datos ingresados

  while @w_cont <= @i_num_suc
  begin -- Lazo para la validacion de datos ingresados
    -- Determinar la sucursal en proceso

    if @w_cont = 1
      select
        @w_suc_proceso = @i_suc1
    else if @w_cont = 2
      select
        @w_suc_proceso = @i_suc2
    else if @w_cont = 3
      select
        @w_suc_proceso = @i_suc3
    else if @w_cont = 4
      select
        @w_suc_proceso = @i_suc4
    else if @w_cont = 5
      select
        @w_suc_proceso = @i_suc5
    else if @w_cont = 6
      select
        @w_suc_proceso = @i_suc6
    else if @w_cont = 7
      select
        @w_suc_proceso = @i_suc7
    else if @w_cont = 8
      select
        @w_suc_proceso = @i_suc8
    else if @w_cont = 9
      select
        @w_suc_proceso = @i_suc9
    else if @w_cont = 10
      select
        @w_suc_proceso = @i_suc10
    else if @w_cont = 11
      select
        @w_suc_proceso = @i_suc11
    else if @w_cont = 12
      select
        @w_suc_proceso = @i_suc12
    else if @w_cont = 13
      select
        @w_suc_proceso = @i_suc13
    else if @w_cont = 14
      select
        @w_suc_proceso = @i_suc14
    else if @w_cont = 15
      select
        @w_suc_proceso = @i_suc15
    else if @w_cont = 16
      select
        @w_suc_proceso = @i_suc16
    else if @w_cont = 17
      select
        @w_suc_proceso = @i_suc17
    else if @w_cont = 18
      select
        @w_suc_proceso = @i_suc18
    else if @w_cont = 19
      select
        @w_suc_proceso = @i_suc19
    else if @w_cont = 20
      select
        @w_suc_proceso = @i_suc20
    else if @w_cont = 21
      select
        @w_suc_proceso = @i_suc21
    else if @w_cont = 22
      select
        @w_suc_proceso = @i_suc22
    else if @w_cont = 23
      select
        @w_suc_proceso = @i_suc23
    else if @w_cont = 24
      select
        @w_suc_proceso = @i_suc24
    else if @w_cont = 25
      select
        @w_suc_proceso = @i_suc25
    else if @w_cont = 26
      select
        @w_suc_proceso = @i_suc26
    else if @w_cont = 27
      select
        @w_suc_proceso = @i_suc27
    else if @w_cont = 28
      select
        @w_suc_proceso = @i_suc28
    else if @w_cont = 29
      select
        @w_suc_proceso = @i_suc29
    else if @w_cont = 30
      select
        @w_suc_proceso = @i_suc30
    else if @w_cont = 31
      select
        @w_suc_proceso = @i_suc31
    else if @w_cont = 32
      select
        @w_suc_proceso = @i_suc32
    else if @w_cont = 33
      select
        @w_suc_proceso = @i_suc33
    else if @w_cont = 34
      select
        @w_suc_proceso = @i_suc34
    else if @w_cont = 35
      select
        @w_suc_proceso = @i_suc35
    else if @w_cont = 36
      select
        @w_suc_proceso = @i_suc36
    else if @w_cont = 37
      select
        @w_suc_proceso = @i_suc37
    else if @w_cont = 38
      select
        @w_suc_proceso = @i_suc38
    else if @w_cont = 39
      select
        @w_suc_proceso = @i_suc39
    else if @w_cont = 40
      select
        @w_suc_proceso = @i_suc40

    -- Determinar la existencia del produto final

    select
      @w_pro_final = pf_pro_final
    from   cob_remesas..pe_pro_final
    where  pf_filial   = @i_filial
       and pf_sucursal = @w_suc_proceso
       and pf_mercado  = @w_mercado
       and pf_producto = @i_prod_cobis
       and pf_moneda   = @i_mon
       and pf_tipo     = 'R'

    if @@rowcount = 0
    begin -- Error en la determinacion del producto final
      if @i_sector = 'C'
        select
          @w_aux = ' PARA EL SECTOR CORPORATIVO'
      else
        select
          @w_aux = ' PARA EL SECTOR PERSONAL'

      select
        @w_mensaje = 'NO HAY PROD FINAL: SUC. No. ' + convert(varchar,
                     @w_suc_proceso)
                     +
                     ' PROD. COBIS No. '
                     + convert(varchar, @i_prod_cobis) + @w_aux

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_mensaje,
        @i_sev   = 1,
        @i_num   = 351888
      return 351888

    end -- Error en la determinacion del producto final

    -- Verificar el servicio personalizable

    select
      @w_servicio_per = sp_servicio_per,
      @w_tipo_rango = sp_tipo_rango,
      @w_grupo_rango = sp_grupo_rango
    from   cob_remesas..pe_servicio_per
    where  sp_pro_final    = @w_pro_final
       and sp_servicio_dis = @i_serv_dis
       and sp_rubro        = @i_rubro
       and sp_tipo_rango   = @i_tipo_rango

    --if @@rowcount > 0
    --  begin -- Validacion de grupo y tipo de rango

    if @w_grupo_rango <> @i_grupo_rango
    begin -- Grupo de rango errado
      select
        @w_mensaje = 'PARA LA SUCURSAL No. ' + convert(varchar, @w_suc_proceso)
                     + ' EL GRUPO DE RANGO ESPECIFICADO ' +
                            ' NO COINCIDE CON EL DEL SERVICIO '
                     + ' PERSONALIZABLE EXISTENTE ' + cast(@w_grupo_rango as
                     varchar
                     )

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_mensaje,
        @i_sev   = 0,
        @i_num   = 351511
      return 351511

    end -- Grupo de rango errado

    if @w_tipo_rango <> @i_tipo_rango
    begin -- Tipo de rango errado
      select
        @w_mensaje = 'PARA LA SUCURSAL No. ' + convert(varchar, @w_suc_proceso)
                     + ' EL TIPO DE RANGO ESPECIFICADO ' +
                            ' NO COINCIDE CON EL DEL SERVICIO '
                     + ' PERSONALIZABLE EXISTENTE'

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_mensaje,
        @i_sev   = 0,
        @i_num   = 351511
      return 351511

    end -- Tipo de rango errado

    -- end -- Validacion de grupo y tipo de rango

    -- Actualizar del contador

    select
      @w_cont = @w_cont + 1

  end -- Lazo para la validacion de datos ingresados

  -- Actulizador del contador

  select
    @w_cont = 1

  -- Lazo para actualizar los costos de todas las sucursales

  while @w_cont <= @i_num_suc
  begin -- while principal de actualizacion de costos
    -- Determinar la sucursal en proceso

    if @w_cont = 1
      select
        @w_suc_proceso = @i_suc1
    else if @w_cont = 2
      select
        @w_suc_proceso = @i_suc2
    else if @w_cont = 3
      select
        @w_suc_proceso = @i_suc3
    else if @w_cont = 4
      select
        @w_suc_proceso = @i_suc4
    else if @w_cont = 5
      select
        @w_suc_proceso = @i_suc5
    else if @w_cont = 6
      select
        @w_suc_proceso = @i_suc6
    else if @w_cont = 7
      select
        @w_suc_proceso = @i_suc7
    else if @w_cont = 8
      select
        @w_suc_proceso = @i_suc8
    else if @w_cont = 9
      select
        @w_suc_proceso = @i_suc9
    else if @w_cont = 10
      select
        @w_suc_proceso = @i_suc10
    else if @w_cont = 11
      select
        @w_suc_proceso = @i_suc11
    else if @w_cont = 12
      select
        @w_suc_proceso = @i_suc12
    else if @w_cont = 13
      select
        @w_suc_proceso = @i_suc13
    else if @w_cont = 14
      select
        @w_suc_proceso = @i_suc14
    else if @w_cont = 15
      select
        @w_suc_proceso = @i_suc15
    else if @w_cont = 16
      select
        @w_suc_proceso = @i_suc16
    else if @w_cont = 17
      select
        @w_suc_proceso = @i_suc17
    else if @w_cont = 18
      select
        @w_suc_proceso = @i_suc18
    else if @w_cont = 19
      select
        @w_suc_proceso = @i_suc19
    else if @w_cont = 20
      select
        @w_suc_proceso = @i_suc20
    else if @w_cont = 21
      select
        @w_suc_proceso = @i_suc21
    else if @w_cont = 22
      select
        @w_suc_proceso = @i_suc22
    else if @w_cont = 23
      select
        @w_suc_proceso = @i_suc23
    else if @w_cont = 24
      select
        @w_suc_proceso = @i_suc24
    else if @w_cont = 25
      select
        @w_suc_proceso = @i_suc25
    else if @w_cont = 26
      select
        @w_suc_proceso = @i_suc26
    else if @w_cont = 27
      select
        @w_suc_proceso = @i_suc27
    else if @w_cont = 28
      select
        @w_suc_proceso = @i_suc28
    else if @w_cont = 29
      select
        @w_suc_proceso = @i_suc29
    else if @w_cont = 30
      select
        @w_suc_proceso = @i_suc30
    else if @w_cont = 31
      select
        @w_suc_proceso = @i_suc31
    else if @w_cont = 32
      select
        @w_suc_proceso = @i_suc32
    else if @w_cont = 33
      select
        @w_suc_proceso = @i_suc33
    else if @w_cont = 34
      select
        @w_suc_proceso = @i_suc34
    else if @w_cont = 35
      select
        @w_suc_proceso = @i_suc35
    else if @w_cont = 36
      select
        @w_suc_proceso = @i_suc36
    else if @w_cont = 37
      select
        @w_suc_proceso = @i_suc37
    else if @w_cont = 38
      select
        @w_suc_proceso = @i_suc38
    else if @w_cont = 39
      select
        @w_suc_proceso = @i_suc39
    else if @w_cont = 40
      select
        @w_suc_proceso = @i_suc40

    begin tran

    -- Determinar el producto final

    select
      @w_pro_final = pf_pro_final
    from   cob_remesas..pe_pro_final
    where  pf_filial   = @i_filial
       and pf_sucursal = @w_suc_proceso
       and pf_mercado  = @w_mercado
       and pf_producto = @i_prod_cobis
       and pf_moneda   = @i_mon
       and pf_tipo     = 'R'

    -- Determinar la existencia del servicio personalizable para
    -- el producto final en proceso

    select
      @w_servicio_per = sp_servicio_per
    from   cob_remesas..pe_servicio_per
    where  sp_pro_final    = @w_pro_final
       and sp_servicio_dis = @i_serv_dis
       and sp_rubro        = @i_rubro

    if @@rowcount = 0
    begin -- No existe servicio personalizable
      -- CREACION DEL SERVICIO PERSONALIZABLE PARA EL PRODUCTO FINAL
      -- Y LA SUCURSAL EN PROCESO

      -- Determinar el secuencial del servicio personalizable

      exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @i_tabla     = 'pe_servicio_per',
        @o_siguiente = @w_servicio_per out

      -- Insertar el Servicio Pewrsonalizable

      insert into cob_remesas..pe_servicio_per
                  (sp_servicio_per,sp_pro_final,sp_servicio_dis,sp_rubro,
                   sp_tipo_rango,
                   sp_grupo_rango)
      values      (@w_servicio_per,@w_pro_final,@i_serv_dis,@i_rubro,
                   @i_tipo_rango
                   ,
                   @i_grupo_rango)

    end -- No existe servicio personalizable

    -- CREACION O ACTUALIZACION DEL COSTO PARA EL SERVICIO PERSONALIZABLE

    -- Determinar el secuencial para el costo

    exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pe_cambio_costo',
      @o_siguiente = @w_sec_costo out

    -- Insertat el nuevo costo al servicio personalizable

    insert into cob_remesas..pe_cambio_costo
                (cc_secuencial,cc_servicio_per,cc_categoria,cc_tipo_rango,
                 cc_grupo_rango,
                 cc_rango,cc_operacion,cc_tipo,cc_val_medio,cc_minimo,
                 cc_maximo,cc_fecha_cambio,cc_fecha_vigencia,cc_en_linea)
    values      (@w_sec_costo,@w_servicio_per,@i_categoria,@i_tipo_rango,
                 @i_grupo_rango,
                 @i_rango,'I','I',@i_val_med,@i_val_min,
                 @i_val_max,@s_date,@i_fecha_vigen,'N')

    -- CREACION DE LA TRANSACCION DE SERVICIO

    insert into cob_remesas..pe_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
                 ts_terminal,
                 ts_reentry,ts_cod_alterno,ts_servicio_per,ts_categoria,
                 ts_tipo_rango,
                 ts_grupo_rango,ts_rango,ts_operacion,ts_tipo,ts_minimo,
                 ts_val_medio,ts_maximo,ts_fecha_cambio,ts_fecha_vigencia)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 'N',@w_cod_alterno,@w_servicio_per,@i_categoria,@i_tipo_rango,
                 @i_grupo_rango,@i_rango,'I','I',@i_val_min,
                 @i_val_med,@i_val_max,@s_date,@i_fecha_vigen)

    /* OJO COMENTARIO TEMPORAL
    
    if @@error <> 0
      begin -- Error en la grabacion de la transaccion de servicio
    
      end -- Error en la grabacion de la transacion de servicio
    
    OJO COMENTARIO TEMPORAL */

    commit tran

    -- Actualizar el contador

    select
      @w_cont = @w_cont + 1,
      @w_cod_alterno = @w_cod_alterno + 1

  end -- while princiopal para la actualizacion de costos

  return 0

GO 
