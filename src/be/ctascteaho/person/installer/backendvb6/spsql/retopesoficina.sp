/****************************************************************************/
/*      Base de datos:          cob_remesas                                 */
/*      Producto:               AHORROS                                     */
/*      Disenado por:           Saira Patricia Molano                       */
/*      Fecha de escritura:     Junio 2011                                  */
/*      Procedimiento:          sp_topes_oficina                            */
/****************************************************************************/
/*                              IMPORTANTE                                  */
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
/*                              PROPOSITO                                   */
/*      Administracion de topes por oficina                                 */
/****************************************************************************/
/*                              CAMBIOS                                     */
/*      FECHA                   AUTOR         CAMBIO                        */
/*      Junio 2011              Smolano       Emision Inicial               */
/*      Junio 2014              LBernal    REQ 412- Control de Limites      */
/*                                         Transaccionales                  */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_topes_oficina')
  drop proc sp_topes_oficina
go

create proc sp_topes_oficina
(
  @s_ssn                    int,
  @t_debug                  char(1) = 'N',
  @t_file                   char(1) = null,
  @s_user                   login = null,
  @s_date                   datetime,
  @s_term                   varchar(10) = 'consola',
  @s_ofi                    smallint,
  @t_trn                    int,
  @t_show_version           bit = 0,
  @i_operacion              varchar(2) = 'S',
  @i_producto               tinyint = null,
  @i_cantidad               int = 0,
  @i_efectivo               char(1) = null,
  @i_chq_ger                char(1) = null,
  @i_valor_efe              money = null,
  @i_valor_chq              money = null,

  -- req 412
  @i_efectivo_otra          char(1) = null,
  @i_chq_ger_otra           char(1) = null,
  @i_valor_efe_otra         money = null,
  @i_valor_chq_otra         money = null,
  @i_siguiente              smallint = 0,
  @i_lr_tabla               smallint = 0,
  @i_lr_tipo_tran           char(1) = 'D',
  @i_lr_origen              char(10) = null,
  @i_lr_especie             char(10) = null,
  @i_lr_nro_transacciones   smallint = null,
  @i_lr_monto_transacciones money = null,
  @i_cr_tipo_tran           char(1) = 'D',
  @i_cr_causal              char(3) = null,
  @i_cr_origen              char(10) = null,
  @i_cr_especie             char(10) = null,
  @i_cr_id                  int = 0
-- fin req 412
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_fecha          char(10),
    @w_producto       tinyint,
    @w_cantidad       int,
    @w_efectivo       char(1),
    @w_chq_ger        char(1),
    @w_valor_efe      money,
    @w_valor_chq      money,
    @w_fecha_reg      datetime,
    @w_tabla_origen   int,--req 412
    @w_tabla_especie  int,--req 412
    @w_tabla_causal   int,--req 412
    @w_efectivo_otra  char(1),
    @w_chq_ger_otra   char(1),
    @w_valor_efe_otra money,
    @w_valor_chq_otra money

  -- Captura del nombre del Stored Procedure
  select
    @w_sp_name = 'sp_topes_oficina',
    @w_fecha = convert(char(10), getdate(), 101)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion in ('I', 'U', 'D')
     and @t_trn = 4128
  begin
    if @i_operacion = 'I'
    begin
      if exists (select
                   1
                 from   cob_remesas..pe_tope_oficina
                 where  to_tipo_prod = @i_producto)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357516
        -- Ya existe Registro
        return 357516
      end

      begin tran

      insert into pe_tope_oficina
                  (to_tipo_prod,to_cantidad,to_mar_efec,to_mar_chq,to_vlr_efec,
                   to_vlr_chq,to_login,to_fecha_reg,to_mar_efec_otra,
                   to_mar_chq_otra
                   ,
                   --req 412
                   to_vlr_efec_otra,to_vlr_chq_otra) --req 412
      values      (@i_producto,@i_cantidad,@i_efectivo,@i_chq_ger,@i_valor_efe,
                   @i_valor_chq,@s_user,getdate(),@i_efectivo_otra,
                   @i_chq_ger_otra
                   ,
                   --req 412
                   @i_valor_efe_otra,@i_valor_chq_otra) --req 412

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357517
        return 357517
      end

    /* Transaccion de Servicio */
      /***************************/

      insert into ts_tope_oficina
                  (secuencial,tipo_transaccion,fecha,usuario,terminal,
                   cantidad,operacion,efectivo,cheque_gere,efectivo_otra,
                   cheque_gere_otra,producto,valor_efe,valor_chq,valor_efe_otra,
                   valor_chq_otra)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @i_cantidad,@i_operacion,@i_efectivo,@i_chq_ger,
                   @i_efectivo_otra,
                   @i_chq_ger_otra,@i_producto,@i_valor_efe,@i_valor_chq,
                   @i_valor_efe_otra,
                   @i_valor_chq_otra)

      /*Ocurrio un error en la insercion*/
      if @@error <> 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end

      commit tran

    end

    if @i_operacion = 'U'
    begin
      select
        @w_producto = to_tipo_prod,
        @w_cantidad = to_cantidad,
        @w_efectivo = to_mar_efec,
        @w_chq_ger = to_mar_chq,
        @w_valor_efe = to_vlr_efec,
        @w_valor_chq = to_vlr_chq,
        @w_fecha_reg = to_fecha_reg,
        @w_efectivo_otra = to_mar_efec_otra,
        @w_chq_ger_otra = to_mar_chq_otra,
        @w_valor_efe_otra = to_vlr_efec_otra,
        @w_valor_chq_otra = to_vlr_chq_otra
      from   cob_remesas..pe_tope_oficina
      where  to_tipo_prod = @i_producto

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357518
        -- No existe Registro
        return 357518
      end

    /* Transaccion de Servicio Antes */
      /***************************/

      begin tran
      insert into ts_tope_oficina
                  (secuencial,tipo_transaccion,fecha,usuario,terminal,
                   cantidad,operacion,efectivo,cheque_gere,efectivo_otra,
                   cheque_gere_otra,producto,valor_efe,valor_chq,valor_efe_otra,
                   valor_chq_otra)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @w_cantidad,@i_operacion,@w_efectivo,@w_chq_ger,
                   @w_efectivo_otra,
                   @w_chq_ger_otra,@w_producto,@w_valor_efe,@w_valor_chq,
                   @w_valor_efe_otra,
                   @w_valor_chq_otra)

      if @@error <> 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end

      update cob_remesas..pe_tope_oficina
      set    to_tipo_prod = @i_producto,
             to_cantidad = @i_cantidad,
             to_mar_efec = @i_efectivo,
             to_mar_chq = @i_chq_ger,
             to_vlr_efec = isnull(@i_valor_efe,
                                  0),
             to_vlr_chq = isnull(@i_valor_chq,
                                 0),
             to_login = @s_user,
             to_fecha_reg = getdate(),
             to_mar_efec_otra = @i_efectivo_otra,-- req 412
             to_mar_chq_otra = @i_chq_ger_otra,-- req 412
             to_vlr_efec_otra = isnull(@i_valor_efe_otra,
                                       0),-- req 412
             to_vlr_chq_otra = isnull(@i_valor_chq_otra,
                                      0) -- req 412

      where  to_tipo_prod = @i_producto

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357519
        return 357519
      end

    /* Transaccion de Servicio Despues*/
      /***************************/

      insert into ts_tope_oficina
                  (secuencial,tipo_transaccion,fecha,usuario,terminal,
                   cantidad,operacion,efectivo,cheque_gere,efectivo_otra,
                   cheque_gere_otra,producto,valor_efe,valor_chq,valor_efe_otra,
                   valor_chq_otra)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @i_cantidad,@i_operacion,@i_efectivo,@i_chq_ger,
                   @i_efectivo_otra,
                   @i_chq_ger_otra,@i_producto,@i_valor_efe,@i_valor_chq,
                   @i_valor_efe_otra,
                   @i_valor_chq_otra)

      if @@error <> 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
      commit
    end

    if @i_operacion = 'D'
    begin
      if not exists (select
                       1
                     from   cob_remesas..pe_tope_oficina
                     where  to_tipo_prod = @i_producto)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357518
        -- No existe Registro
        return 357518
      end

      begin tran
      delete from cob_remesas..pe_tope_oficina
      where  to_tipo_prod = @i_producto

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 357520
        return 357520
      end

    /* Transaccion de Servicio */
      /***************************/

      insert into ts_tope_oficina
                  (secuencial,tipo_transaccion,fecha,usuario,terminal,
                   cantidad,operacion,efectivo,cheque_gere,efectivo_otra,
                   cheque_gere_otra,producto,valor_efe,valor_chq,valor_efe_otra,
                   valor_chq_otra)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @i_cantidad,@i_operacion,@i_efectivo,@i_chq_ger,
                   @i_efectivo_otra,
                   @i_chq_ger_otra,@i_producto,@i_valor_efe,@i_valor_chq,
                   @i_valor_efe_otra,
                   @i_valor_chq_otra)

      if @@error <> 0
      begin
        /*Error en la insercion de transaccion de servicio*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
      commit
    end

    select
      '1703' = to_secuencia,                              --SECUENCIAL
      '1653' = case to_tipo_prod 
                     when 3 then 'CORRIENTES'
                     else 'AHORROS'
                   end,                                   --PRODUCTO
      '1046' = to_cantidad,                               --CANTIDAD
      '1469' = isnull(to_mar_efec, 
                             'N'),                        --MARCA EFEC.
      '1467' = isnull(to_mar_chq,  
                            'N'),                         --MARCA CHQ.
      '1835' = isnull(to_vlr_efec,
                           '0.00'),                       --VLR EFEC.
      '1833' = isnull(to_vlr_chq,
                          '0.00'),                        --VLR CHQ.
      '1796' = to_login,                                  --USUARIO
      '1361' = convert(varchar, to_fecha_reg, 103),       --FECHA MOD
      '1470' = isnull(to_mar_efec_otra,
                                  'N'),                   --MARCA EFEC. OTRA
      '1468' = isnull(to_mar_chq_otra,
                                 'N'),                    --MARCA CHQ. OTRA
      '1836' = isnull(to_vlr_efec_otra,
                                '0.00'),                  --VLR EFEC. OTRA
      '1834' = isnull(to_vlr_chq_otra,
                               '0.00')                    --VLR CHQ. OTRA
    from   pe_tope_oficina
    where  to_tipo_prod = @i_producto

    -- Creacion de Transaccion de Servicio
    if @i_producto = 4 -- CTAS DE AHORROS
    begin
      insert into cob_ahorros..ah_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                   ts_terminal,
                   ts_oficina,ts_hora,ts_estado,ts_producto,ts_fecha,
                   ts_accion,ts_cheque,ts_valor,ts_monto,ts_saldo,
                   ts_interes,ts_origen)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @s_ofi,getdate(),@w_efectivo,@i_producto,@w_fecha_reg,
                   @w_chq_ger,@i_cantidad,isnull(@w_valor_efe,
                          0),isnull(@w_valor_chq,
                          0),isnull(@i_valor_efe,
                          0),
                   isnull(@i_valor_chq,
                          0),@i_operacion)

      -- Error en creacion de transaccion de servicio
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
    end
    else
    begin -- Transaccion de servicios en Cuentas corrientes
      insert into cob_cuentas..cc_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                   ts_terminal,
                   ts_oficina,ts_hora,ts_estado,ts_producto,ts_fecha,
                   ts_negociada,ts_cheque,ts_valor,ts_monto,ts_saldo,
                   ts_contratado,ts_origen)
      values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                   @s_ofi,getdate(),@w_efectivo,@i_producto,@w_fecha_reg,
                   @w_chq_ger,@i_cantidad,isnull(@w_valor_efe,
                          0),isnull(@w_valor_chq,
                          0),isnull(@i_valor_efe,
                          0),
                   isnull(@i_valor_chq,
                          0),@i_operacion)

      -- Error en creacion de transaccion de servicio
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
    end
  end

  -- Consulta Topes Oficina
  if @i_operacion = 'Q'
  begin
    select
      '1703' = to_secuencia,                                --SECUENCIAL
      '1653' = case to_tipo_prod                            
                  when 3 then 'CORRIENTES'                  
                  else 'AHORROS'                            
                end,                                        --PRODUCTO
      '1046' = to_cantidad,                                 --CANTIDAD
      '1469' = isnull(to_mar_efec,                          
                          'N'),                             --MARCA EFEC.
      '1467' = isnull(to_mar_chq,                           
                         'N'),                              --MARCA CHQ.
      '1835' = isnull(to_vlr_efec,                          
                        '0.00'),                            --VLR EFEC.
      '1833' = isnull(to_vlr_chq,                           
                       '0.00'),                             --VLR CHQ.
      '1796' = to_login,                                    --USUARIO
      '1361' = convert(varchar, to_fecha_reg, 103),         --FECHA MOD
      '1470' = isnull(to_mar_efec_otra,                     
                               'N'),                        --MARCA EFEC. OTRA
      '1468' = isnull(to_mar_chq_otra,                      
                              'N'),                         --MARCA CHQ. OTRA
      '1836' = isnull(to_vlr_efec_otra,                     
                             '0.00'),                       --VLR EFEC. OTRA
      '1834' = isnull(to_vlr_chq_otra,                      
                               '0.00')                      --VLR CHQ. OTRA
    from   pe_tope_oficina
    where  to_tipo_prod = @i_producto

    if (@@rowcount = 0)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357518
      return 357518
    end
  end

  --req 412
  if @i_operacion = 'SO'
  begin
    select
      @w_tabla_origen = codigo
    from   cobis..cl_tabla
    where  tabla = 'pe_lt_origen'

    select
      @w_tabla_especie = codigo
    from   cobis..cl_tabla
    where  tabla = 'pe_lt_especie'

    --B+SQUEDA GENERAL
    if @i_lr_origen is null
       and @i_lr_especie is null
    begin
      select
        "1092" = lr_origen,  --Cod. Origen
        "1616" = (select
                      valor
                    from   cobis..cl_catalogo
                    where  tabla  = @w_tabla_origen
                       and codigo = lr_origen),  --Origen
        "1090" = lr_especie, --Cod. Especie
        "1328" = (select
                       valor
                     from   cobis..cl_catalogo
                     where  tabla  = @w_tabla_especie
                        and codigo = lr_especie),  --Especie
        "1521" = lr_nro_transacciones,  --Nro Trans
        "1487" = lr_monto_transacciones, --Monto Trans
        "1405" = lr_id,  --ID
        "1096" = lr_tabla, --Config
        "1740" = lr_tipo_tran --T.Tran
      from   cob_remesas..pe_limites_restrictivos
      where  lr_tabla     = @i_lr_tabla
         and lr_tipo_tran = @i_lr_tipo_tran
         and lr_id        > @i_siguiente
      order  by lr_id
    end
    --B+SQUEDA POR ESPECIE
    if @i_lr_origen is null
       and @i_lr_especie is not null
    begin
      select
        "1092" = lr_origen, --Cod. Origen
        "1616" = (select
                      valor
                    from   cobis..cl_catalogo
                    where  tabla  = @w_tabla_origen
                       and codigo = lr_origen), --Origen
        "1090" = lr_especie, --Cod. Especie
        "1328" = (select
                       valor
                     from   cobis..cl_catalogo
                     where  tabla  = @w_tabla_especie
                        and codigo = lr_especie),  --Especie
        "1521" = lr_nro_transacciones,  --Nro Trans
        "1487" = lr_monto_transacciones,  --Monto Trans
        "1405" = lr_id,  --ID
        "1096" = lr_tabla, --Config
        "1740" = lr_tipo_tran  --T.Tran
      from   cob_remesas..pe_limites_restrictivos
      where  lr_tabla     = @i_lr_tabla
         and lr_tipo_tran = @i_lr_tipo_tran
         and lr_especie   = @i_lr_especie
         and lr_id        > @i_siguiente
      order  by lr_id
    end
    --BUSQUEDA POR ORIGEN
    if @i_lr_origen is not null
       and @i_lr_especie is null
    begin
      select
        "1092" = lr_origen, --Cod. Origen
        "1616" = (select
                      valor
                    from   cobis..cl_catalogo
                    where  tabla  = @w_tabla_origen
                       and codigo = lr_origen), --Origen
        "1090" = lr_especie,   --Cod. Especie
        "1328" = (select
                       valor
                     from   cobis..cl_catalogo
                     where  tabla  = @w_tabla_especie
                        and codigo = lr_especie),   --Especie
        "1521" = lr_nro_transacciones,  --Nro Trans
        "1487" = lr_monto_transacciones, --Monto Trans
        "1405" = lr_id,  --ID
        "1096" = lr_tabla, --Config
        "1740" = lr_tipo_tran   --T.Tran
      from   cob_remesas..pe_limites_restrictivos
      where  lr_tabla     = @i_lr_tabla
         and lr_tipo_tran = @i_lr_tipo_tran
         and lr_origen    = @i_lr_origen
         and lr_id        > @i_siguiente
      order  by lr_id
    end
    --B+SQUEDA POR ORIGEN Y ESPECIE
    if @i_lr_origen is not null
       and @i_lr_especie is not null
    begin
      select
        "1092" = lr_origen, --Cod. Origen
        "1616" = (select
                      valor
                    from   cobis..cl_catalogo
                    where  tabla  = @w_tabla_origen
                       and codigo = lr_origen), --Origen
        "1090" = lr_especie, --Cod. Especie
        "1328" = (select
                       valor
                     from   cobis..cl_catalogo
                     where  tabla  = @w_tabla_especie
                        and codigo = lr_especie), --Especie
        "1521" = lr_nro_transacciones, --Nro Trans
        "1487" = lr_monto_transacciones, --Monto Trans
        "1405" = lr_id, --ID
        "1096" = lr_tabla, --Config
        "1740" = lr_tipo_tran --T.Tran
      from   cob_remesas..pe_limites_restrictivos
      where  lr_tabla     = @i_lr_tabla
         and lr_tipo_tran = @i_lr_tipo_tran
         and lr_origen    = @i_lr_origen
         and lr_especie   = @i_lr_especie
      order  by lr_id
    end

    return 0
  end

  if @i_operacion = 'IO'
     and @t_trn = 4156
  begin
    if exists (select
                 1
               from   cob_remesas..pe_limites_restrictivos
               where  lr_origen    = @i_lr_origen
                  and lr_especie   = @i_lr_especie
                  and lr_tabla     = @i_lr_tabla
                  and lr_tipo_tran = @i_lr_tipo_tran)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357516
      -- Ya existe Registro
      return 357516
    end

    begin tran
    insert into cob_remesas..pe_limites_restrictivos
                (lr_tabla,lr_tipo_tran,lr_origen,lr_especie,lr_nro_transacciones
                 ,
                 lr_monto_transacciones)
    values      (@i_lr_tabla,@i_lr_tipo_tran,@i_lr_origen,@i_lr_especie,
                 @i_lr_nro_transacciones,
                 @i_lr_monto_transacciones)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357517
      return 357517
    end

  /* Transaccion de Servicio */
    /***************************/

    insert into ts_limites_restrictivos
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 lr_tipo_tran,operacion,lr_origen,lr_especie,lr_tabla,
                 lr_nro_transacciones,lr_monto_transacciones)
    values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                 @i_lr_tipo_tran,@i_operacion,@i_lr_origen,@i_lr_especie,
                 @i_lr_tabla
                 ,
                 @i_lr_nro_transacciones,@i_lr_monto_transacciones)

    if @@error <> 0
    begin
      /*Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      return 353515
    end

    commit
    return 0
  end

  if @i_operacion = 'DO'
     and @t_trn = 4156
  begin
    if not exists (select
                     1
                   from   cob_remesas..pe_limites_restrictivos
                   where  lr_origen    = @i_lr_origen
                      and lr_especie   = @i_lr_especie
                      and lr_tabla     = @i_lr_tabla
                      and lr_tipo_tran = @i_lr_tipo_tran)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357518
      -- No existe Registro
      return 357518
    end
    begin tran
    delete from cob_remesas..pe_limites_restrictivos
    where  lr_origen    = @i_lr_origen
       and lr_especie   = @i_lr_especie
       and lr_tabla     = @i_lr_tabla
       and lr_tipo_tran = @i_lr_tipo_tran

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357520
      return 357520
    end

  /* Transaccion de Servicio */
    /***************************/

    insert into ts_limites_restrictivos
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 lr_tipo_tran,operacion,lr_origen,lr_especie,lr_tabla,
                 lr_nro_transacciones,lr_monto_transacciones)
    values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                 @i_lr_tipo_tran,@i_operacion,@i_lr_origen,@i_lr_especie,
                 @i_lr_tabla ,  @i_lr_nro_transacciones,@i_lr_monto_transacciones)

    if @@error <> 0
    begin
      /*Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      return 353515
    end
    commit
    return 0
  end

  if @i_operacion = 'SE'
  begin
    select
      @w_tabla_causal = codigo
    from   cobis..cl_tabla
    where  tabla = 'ah_causa_nd'

    select
      @w_tabla_origen = codigo
    from   cobis..cl_tabla
    where  tabla = 'pe_lt_origen'

    select
      @w_tabla_especie = codigo
    from   cobis..cl_tabla
    where  tabla = 'pe_lt_especie'

    select
      '1089' = cr_causal, --COD. CAUSAL
      '1073' = (select
                    valor
                  from   cobis..cl_catalogo
                  where  tabla  = @w_tabla_causal
                     and codigo = cr_causal), --CAUSAL
      '1092' = cr_origen, --COD. ORIGEN
      '1616' = (select
                    valor
                  from   cobis..cl_catalogo
                  where  tabla  = @w_tabla_origen
                     and codigo = cr_origen), --ORIGEN
      '1090' = cr_especie, --COD. ESPECIE
      '1328' = (select
                    valor
                  from   cobis..cl_catalogo
                  where  tabla  = @w_tabla_especie
                     and codigo = cr_especie) --ESPECIE
    from   cob_remesas..pe_causales_restringidas
    where  cr_tipo_tran = @i_cr_tipo_tran
       and cr_origen    = @i_cr_origen
       and cr_especie   = @i_cr_especie

    return 0
  end

  if @i_operacion = 'IE'
     and @t_trn = 4157
  begin
    if exists (select
                 1
               from   cob_remesas..pe_causales_restringidas
               where  cr_causal    = @i_cr_causal
                  and cr_tipo_tran = @i_cr_tipo_tran)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357516
      -- Ya existe Registro
      return 357516
    end

    begin tran
    insert into cob_remesas..pe_causales_restringidas
                (cr_tipo_tran,cr_causal,cr_origen,cr_especie)
    values      (@i_cr_tipo_tran,@i_cr_causal,@i_cr_origen,@i_cr_especie)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357517
      return 357517
    end

  /* Transaccion de Servicio */
    /***************************/

    insert into ts_causales_restringidas
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 operacion,tipo_tran,cr_causal,cr_origen,cr_especie)
    values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                 @i_operacion,@i_cr_tipo_tran,@i_cr_causal,@i_cr_origen,
                 @i_cr_especie)

    if @@error <> 0
    begin
      /*Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      return 353515
    end
    commit
    return 0
  end

  if @i_operacion = 'DE'
     and @t_trn = 4157
  begin
    if not exists (select
                     1
                   from   cob_remesas..pe_causales_restringidas
                   where  cr_causal    = @i_cr_causal
                      and cr_tipo_tran = @i_cr_tipo_tran)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357518
      -- No existe Registro
      return 357518
    end

    begin tran
    delete from cob_remesas..pe_causales_restringidas
    where  cr_causal    = @i_cr_causal
       and cr_tipo_tran = @i_cr_tipo_tran

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 357520
      return 357520
    end

  /* Transaccion de Servicio */
    /***************************/

    insert into ts_causales_restringidas
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 operacion,tipo_tran,cr_causal,cr_origen,cr_especie)
    values      (@s_ssn,@t_trn,@s_date,@s_user,@s_term,
                 @i_operacion,@i_cr_tipo_tran,@i_cr_causal,@i_cr_origen,
                 @i_cr_especie)

    if @@error <> 0
    begin
      /*Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 353515
      return 353515
    end
    commit
    return 0
  end
  -- fin req 412
  set rowcount 0
  return 0

GO 
