/************************************************************************/
/*   Stored procedure:     sp_trs_pyg                               */
/*   Base de datos:        cob_conta                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_trs_pyg')
   drop proc sp_trs_pyg
go
 
CREATE PROCEDURE sp_trs_pyg (
   @s_user         login       = NULL,
   @s_date         DATETIME    = NULL,
   @s_term         VARCHAR(30) = NULL,
   @i_fec_ultdia   DATETIME,                               --ultimo dia habil del ano
   @i_empresa      TINYINT,
   @i_periodo      INT,
   @i_corte        INT
)
AS

DECLARE @w_proceso              INTEGER,
        --------------------------------
        @w_hi_oficina           SMALLINT,
        @w_hi_area              SMALLINT,
        @w_hi_saldo             MONEY,
        @w_asiento              INTEGER,
        @w_return               INTEGER,
        @w_fecha                DATETIME,
        @w_comprobante          INTEGER,
        @w_credito              MONEY, 
        @w_credito_me           MONEY,
        @w_debito               MONEY,
        @w_debito_me            MONEY,
        --------------------------------
        @w_notercero_ofi        SMALLINT,
        @w_notercero_cuenta     cuenta,
        @w_notercero_area       SMALLINT,
        @w_notercero_saldo      MONEY,
        @w_notercero_saldo_me   MONEY,
        @w_notercero_ctaasoc    cuenta,
        --------------------------------
        @w_tipo_doc            CHAR(1),
        --------------------------------
        @w_total_ofi           SMALLINT,
        @w_total_area          SMALLINT,
        @w_pyg_ofi             SMALLINT,
        @w_pyg_area            SMALLINT,
        @w_total_cta           cuenta,
        @w_total_saldo         MONEY,
        @w_total_saldo_me      MONEY,
        --------------------------------
        @w_gral_cant           INTEGER,
        @w_gral_debito         MONEY,
        @w_gral_credito        MONEY,
        @w_gral_debito_me      MONEY,
        @w_gral_credito_me     MONEY

select @w_pyg_ofi = 4069,
       @w_pyg_area = 34


    ------------INICIALIZACIONES--------------
    SELECT @w_fecha   = getdate(),
           @w_proceso = 6057
     
    IF EXISTS (SELECT * FROM cob_conta..sysobjects WHERE name = 'cb_tcomprobante')
        DELETE cob_conta..cb_tcomprobante
    IF EXISTS (SELECT * FROM cob_conta..sysobjects WHERE name = 'cb_tasiento')
        DELETE cob_conta..cb_tasiento
    IF EXISTS (SELECT * FROM cob_conta..sysobjects WHERE name = 'cb_errores')
        TRUNCATE TABLE cob_conta..cb_errores
    IF EXISTS (SELECT * FROM sysobjects WHERE name = 'TMP_totales')
       DROP table TMP_totales 
    ------------CURSOR DE OFICINAS------------
    DECLARE OFICINAS CURSOR
    FOR SELECT DISTINCT hi_oficina,hi_area
          FROM cob_conta_his..cb_hist_saldo,
               cob_conta..cb_cuenta,
               cob_conta..cb_cuenta_asociada
         WHERE hi_corte      = @i_corte
           AND hi_periodo    = @i_periodo
           AND hi_oficina    >= 0
           AND hi_area       >= 0
           AND hi_cuenta     > ' '
           AND hi_empresa    = @i_empresa
           AND cu_empresa    = @i_empresa
           AND cu_cuenta     > ' '
           AND cu_movimiento = 'S'  
           AND ca_empresa    = 1
           AND ca_proceso    = @w_proceso
           AND ca_cuenta     > ' '
           AND ca_oficina    >= 0
           AND ca_area       >= 0
           AND ca_secuencial >= 0
           AND hi_oficina    in (SELECT of_oficina FROM cob_conta..cb_oficina 
                                  WHERE of_empresa    = 1
                                    AND of_oficina    > 0
                                    AND of_movimiento = 'S'                   
                                    AND of_estado     = 'V')
           AND hi_empresa    = ca_empresa
           AND hi_cuenta     = cu_cuenta
           AND hi_empresa    = cu_empresa
           AND hi_empresa    = ca_empresa
           AND ca_empresa    = cu_empresa
           AND cu_empresa    = ca_empresa
           AND cu_cuenta     = ca_cuenta
    OPEN OFICINAS
    FETCH OFICINAS INTO @w_hi_oficina, @w_hi_area

    
    IF @@fetch_status = -2
    BEGIN
         CLOSE OFICINAS
         DEALLOCATE OFICINAS
         return 351037  ---ERROR EN EL CURSOR 
    END
    
    WHILE @@fetch_status = 0
    BEGIN
             IF EXISTS (SELECT * FROM sysobjects WHERE name = 'TMP_no_tercero')
                  DROP TABLE TMP_no_tercero
             
             IF EXISTS (SELECT * FROM sysobjects WHERE name = 'TMP_tercero')
                  DROP TABLE TMP_tercero
                  
             IF EXISTS (SELECT * from sysobjects WHERE name = 'TMP_totales')
                  DROP TABLE TMP_totales             
             
             IF NOT EXISTS (SELECT 1 FROM cob_conta..cb_oficina 
                            WHERE of_empresa    = @i_empresa               
                              AND of_movimiento = 'S'                   
                              AND of_estado     = 'V'
                              AND of_oficina    = @w_hi_oficina) 
             BEGIN
                INSERT INTO cob_conta..cb_errores
                VALUES('sp_finpe_2','CREANDO CURSOR DE OFICINAS','OFICINA',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
                GOTO SIGUIENTE
             END
         
             SELECT @w_asiento = 1
             EXECUTE @w_return = cob_conta..sp_comprobt
                     @t_trn          = 6111,
                     @i_automatico   = @w_proceso,
                     @i_operacion    = 'I',
                     @i_modo         = 0,
                     @i_empresa      = @i_empresa,
                     @i_oficina_orig = @w_hi_oficina,                --OFICINA DEL CURSOR PRINCIPAL
                     @i_area_orig    = @w_hi_area,                   --31,
                     @i_fecha_tran   = @i_fec_ultdia,                --FECHA DEL ULTIMO DIA HABIL LABORAL DEL ANO
                     @i_fecha_dig    = @w_fecha,                     --FECHA DEL SISTEMA. GETDATE()
                     @i_fecha_mod    = @w_fecha,                     --FECHA DEL SISTEMA. GETDATE()
                     @i_digitador    = @s_user,
                     @i_descripcion  = 'CIERRE DE CUENTAS DEL ESTADO DE RESULTADOS',
                     @i_mayorizado   = 'N',
                     @i_mayoriza     = 'N',
                     @i_autorizado   = 'S',
                     @i_autorizante  = @s_user,
                     @i_reversado    = 'N',
                     @o_tcomprobante  = @w_comprobante out
             IF @w_return <> 0 
             BEGIN
                INSERT INTO cob_conta..cb_errores
                VALUES('sp_comprobt','CREANDO PRIMER COMPROBANTE','comprobante',CONVERT(VARCHAR(50),@w_comprobante),@w_fecha)
                GOTO SIGUIENTE
             END

             /***********************************************************************************************/
             ------------INSERCION DE CUENTAS SIN TERCERO ASOCIADO------------
             SELECT hi_oficina,   hi_area,
                    hi_saldo,     hi_saldo_me,
                    cu_moneda,    hi_cuenta,
                    ca_cuenta,    ca_cta_asoc
               INTO TMP_no_tercero
               FROM cob_conta_his..cb_hist_saldo,
                    cob_conta..cb_cuenta C,
                    cob_conta..cb_cuenta_asociada
              WHERE hi_corte      = @i_corte  
                AND hi_periodo    = @i_periodo
                AND hi_oficina    = @w_hi_oficina
                AND hi_area       = @w_hi_area
                AND hi_cuenta     > ' '
                AND hi_empresa    = @i_empresa
                AND cu_empresa    = @i_empresa
                AND cu_cuenta     > ' '
                AND cu_movimiento = 'S'  
                AND ca_empresa    = @i_empresa
                AND ca_proceso    = @w_proceso
                AND ca_cuenta     > ' '
                --NO EXISTE-- AND ca_area       = @w_hi_area
                AND ca_secuencial >= 0
                AND hi_empresa    = ca_empresa
                AND hi_cuenta     = cu_cuenta
                AND hi_empresa    = cu_empresa
                AND hi_empresa    = ca_empresa
                AND ca_empresa    = cu_empresa
                AND cu_empresa    = ca_empresa
                AND cu_cuenta     = ca_cuenta
                AND hi_saldo <> 0  
                AND cu_cuenta not in (SELECT cp_cuenta FROM cob_conta..cb_cuenta_proceso
                                       WHERE cp_empresa = @i_empresa AND cp_proceso in (6003,6095))
             ORDER BY hi_oficina, hi_area, hi_cuenta
             
             ------------CURSOR DE NO_TERCERO------------
             DECLARE NO_TERCERO CURSOR
             FOR SELECT hi_oficina,   hi_cuenta,
                        hi_saldo,     hi_saldo_me,
                        hi_area      
                   FROM TMP_no_tercero
             OPEN NO_TERCERO 
             FETCH NO_TERCERO 
             INTO @w_notercero_ofi,     @w_notercero_cuenta,
                  @w_notercero_saldo,   @w_notercero_saldo_me,
                  @w_notercero_area
                 
             -----VERIFICACION DEL ESTADO DEL CURSOR---     
             IF @@fetch_status = -2
             BEGIN
                  CLOSE NO_TERCERO
                  DEALLOCATE NO_TERCERO
                  INSERT INTO cob_conta..cb_errores
                  VALUES('sp_finpe','ERROR EN CURSOR DE NO_TERCERO(st:1)','OFICINA',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
             END
                  ELSE
                  BEGIN
                        WHILE @@fetch_status = 0
                        BEGIN
                            ---VALIDACION DE SALDOS---
                            IF @w_notercero_saldo > 0
                            BEGIN
                                SELECT @w_credito    = @w_notercero_saldo,
                                       @w_credito_me = @w_notercero_saldo_me,
                                       @w_debito     = 0,
                                       @w_debito_me  = 0
                            END
                            ELSE
                            BEGIN
                                SELECT @w_debito     = @w_notercero_saldo * -1,
                                       @w_debito_me  = @w_notercero_saldo_me * -1,
                                       @w_credito    = 0,
                                       @w_credito_me = 0
                            END
                            ---VALIDACION DEL TIPO DE DOCUMENTO---
                            IF @w_debito_me <> 0        
                               SELECT @w_tipo_doc = 'C'
                            ELSE
                            BEGIN
                               IF @w_credito_me <> 0
                                  SELECT @w_tipo_doc = 'V'
                               ELSE
                                  SELECT @w_tipo_doc = 'N'
                            END
                            ---EJECUCION DEL ASIENTO CONTABLE---
                            EXECUTE @w_return = cob_conta..sp_asientot
                                    @t_trn          = 6341,
                                    @i_operacion    = 'I',
                                    @i_modo         = 0,
                                    @i_empresa      = @i_empresa,
                                    @i_fecha_tran   = @i_fec_ultdia,
                                    @i_comprobante  = @w_comprobante,
                                    @i_asiento      = @w_asiento,
                                    @i_cuenta       = @w_notercero_cuenta,    
                                    @i_oficina_dest = @w_hi_oficina,
                                    @i_area_dest    = @w_notercero_area,
                                    @i_credito      = @w_credito,
                                    @i_debito       = @w_debito,
                                    @i_concepto     = 'CIERRE DE CUENTAS DEL ESTADO DE RESULTADOS',
                                    @i_credito_me   = @w_credito_me,
                                    @i_debito_me    = @w_debito_me,
                                    @i_cotizacion   = 0,
                                    @i_tipo_doc     = @w_tipo_doc,
                                    @i_mayorizado   = 'N',
                                    @i_tipo_tran    = 'N',
--                                    @i_consolidado  = 'N',
--                                    @i_autorizante  = @s_user,
--                                    @i_autorizado   = 'S',
                                    @i_oficina_orig = @w_notercero_ofi
                            IF @w_return <> 0
                            BEGIN
                                INSERT INTO cob_conta..cb_errores
                                VALUES('sp_asientot','CREANDO ASIENTO(NO_TERCERO)','oficina',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
                                CLOSE NO_TERCERO
                                DEALLOCATE NO_TERCERO
                                GOTO SIGUIENTE
                            END
                            
                            SELECT @w_asiento = @w_asiento + 1
                              
                            FETCH NO_TERCERO
                            INTO @w_notercero_ofi,     @w_notercero_cuenta,    
                                 @w_notercero_saldo,   @w_notercero_saldo_me,
                                 @w_notercero_area    
                        END 
                        CLOSE NO_TERCERO
                        DEALLOCATE NO_TERCERO    
                  END
        ------------CALCULO DE LA CONTABILIZACION DE TOTALES-------------                               
      
        SELECT hi_oficina,
               hi_area,
               ca_cta_asoc,
               'hi_saldo'    = sum(hi_saldo),
               'hi_saldo_me' = sum(hi_saldo_me)
          INTO TMP_totales
          FROM TMP_no_tercero
         GROUP BY hi_oficina,hi_area,ca_cta_asoc

        ------------CURSOR DE TERCERO------------
        DECLARE TOTALES CURSOR
        FOR SELECT hi_oficina,
                   hi_area, 
                   ca_cta_asoc,
                   hi_saldo,
                   hi_saldo_me
              FROM TMP_totales
        OPEN TOTALES
        FETCH TOTALES
        INTO @w_total_ofi,     @w_total_area,
             @w_total_cta,     @w_total_saldo,
             @w_total_saldo_me   
             
        ----VERIFICACION DEL ESTADO DEL CURSOR-----
        IF @@fetch_status = -2
        BEGIN
             CLOSE TOTALES
             DEALLOCATE TOTALES
             INSERT INTO cob_conta..cb_errores
             VALUES('sp_asientot','CURSOR DE TERCERO(st:1)','oficina',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
        END
            ELSE
            BEGIN
                  WHILE @@fetch_status = 0
                  BEGIN
                      ---VALIDACION DE SALDOS---
                      IF @w_total_saldo <> 0
                      BEGIN
                         IF @w_total_saldo > 0
                         BEGIN
                            SELECT @w_debito     = @w_total_saldo,
                                   @w_debito_me  = @w_total_saldo_me,
                                   @w_credito    = 0,
                                   @w_credito_me = 0
                         END
                         ELSE
                         BEGIN
                             SELECT @w_credito    = @w_total_saldo * -1,
                                    @w_credito_me = @w_total_saldo_me * -1,
                                    @w_debito     = 0,
                                    @w_debito_me  = 0
                         END
                      END
        
                      IF @w_debito_me <> 0
                         SELECT @w_tipo_doc = 'C'
                      ELSE
                      BEGIN
                         IF @w_credito_me <> 0
                            SELECT @w_tipo_doc = 'V'
                         ELSE
                            SELECT @w_tipo_doc = 'N'
                      END
             
                      ---EJECUCION DEL ASIENTO CONTABLE---
                      EXECUTE @w_return = cob_conta..sp_asientot
                              @t_trn          = 6341,
                              @i_operacion    = 'I',
                              @i_modo         = 0,
                              @i_empresa      = @i_empresa,
                              @i_fecha_tran   = @i_fec_ultdia,
                              @i_comprobante  = @w_comprobante,
                              @i_asiento      = @w_asiento,
                              @i_cuenta       = @w_total_cta,    --CUENTA ASOCIADA NO TERCERO
                              @i_oficina_dest = @w_pyg_ofi,
                              @i_area_dest    = @w_pyg_area,
                              @i_credito      = @w_credito,
                              @i_debito       = @w_debito,
                              @i_concepto     = 'CIERRE DE CUENTAS DEL ESTADO DE RESULTADOS',
                              @i_credito_me   = @w_credito_me,
                              @i_debito_me    = @w_debito_me,
                              @i_cotizacion   = 0,
                              @i_tipo_doc     = @w_tipo_doc,
                              @i_mayorizado   = 'N',
                              @i_tipo_tran    = 'N',
--                              @i_consolidado  = 'N',
--                              @i_autorizante  = @s_user,
--                              @i_autorizado   = 'S',
                              @i_oficina_orig = @w_total_ofi
                      IF @w_return <> 0 
                      BEGIN
                              INSERT INTO cob_conta..cb_errores
                              VALUES('sp_asientot','CREANDO ASIENTO(VALIDACION SALDOS)','oficina',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
                              CLOSE TOTALES
                              DEALLOCATE TOTALES
                              GOTO SIGUIENTE  
                      END
                    
                      SELECT @w_asiento = @w_asiento + 1 
                       
                      FETCH TOTALES
                      INTO @w_total_ofi,     @w_total_area,
                           @w_total_cta,     @w_total_saldo,
                           @w_total_saldo_me    
                  END  
                  CLOSE TOTALES
                  DEALLOCATE TOTALES
            END
        /************************************************************************************************/
        
        ------------CALCULO DE LA CONTABILIZACION DE TOTALES-------------
         
        IF (SELECT COUNT(1) FROM cob_conta..cb_tasiento
                   WHERE ta_empresa     = @i_empresa
                     AND ta_fecha_tran  = @i_fec_ultdia
                     AND ta_comprobante = @w_comprobante) > 0
        BEGIN
            SELECT @w_gral_cant       = count(1),
                   @w_gral_debito     = sum(ta_debito),
                   @w_gral_credito    = sum(ta_credito),
                   @w_gral_debito_me  = sum(ta_debito_me),
                   @w_gral_credito_me = sum(ta_credito_me)
              FROM cob_conta..cb_tasiento
             WHERE ta_empresa     = @i_empresa
               AND ta_fecha_tran  = @i_fec_ultdia
               AND ta_comprobante = @w_comprobante
            
            PRINT 'GRABANDO COMPROBANTE: ' + cast(@w_comprobante as varchar)
            
            EXECUTE @w_return = cob_conta..sp_comprobante
                @t_trn            = 6342,
                @i_operacion      = 'I',
                @i_empresa        = @i_empresa,
                @i_fecha_tran     = @i_fec_ultdia,
                @i_comprobante    = @w_comprobante,
                @i_detalles       = @w_gral_cant,
                @i_tot_debito     = @w_gral_debito,
                @i_tot_credito    = @w_gral_credito,
                @i_tot_debito_me  = @w_gral_debito_me,
                @i_tot_credito_me = @w_gral_credito_me,
                @i_oficina_orig   = @w_hi_oficina,
                @s_ofi            = 4069,
                @s_term           = 'operador',
                @s_user           = 'sa'

           IF @w_return <> 0 
            BEGIN
                INSERT INTO cob_conta..cb_errores
                VALUES('sp_comprobante','CREANDO COMPROBANTES(VALIDACION TOTALES)','oficina',CONVERT(VARCHAR(50),@w_hi_oficina),@w_fecha)
                GOTO SIGUIENTE
            END
        END
        ELSE
        BEGIN
            INSERT INTO cob_conta..cb_errores
            VALUES('sp_comprobante','CALCULO DE LA CONTABILIZACION DE TOTALES','@w_comprobante',CONVERT(VARCHAR(50),@w_comprobante),@w_fecha)
            GOTO SIGUIENTE
        END
        SIGUIENTE:
        FETCH OFICINAS INTO @w_hi_oficina, @w_hi_area
    END
    CLOSE OFICINAS
    DEALLOCATE OFICINAS
     
    IF EXISTS (SELECT * FROM sysobjects WHERE name = 'TMP_totales')
       DROP table TMP_totales   
       
    --IF EXISTS (SELECT * FROM cob_conta..sysobjects WHERE name = 'cb_tcomprobante')
    --   DELETE cob_conta..cb_tcomprobante
    --IF EXISTS (SELECT * FROM cob_conta..sysobjects WHERE name = 'cb_tasiento')
    --   DELETE cob_conta..cb_tasiento 

RETURN 0       
 
go

