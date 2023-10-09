/*************************************************************************/
/*  Extracción tablas Personalización                                    */
/*                                                                       */
/*************************************************************************/

use cob_remesas
go

declare @w_servicio_dis int

if exists (SELECT 1 FROM sysobjects WHERE name = 'pe_servicio_dis' and SELECT 1 FROM sysobjects WHERE name = 'pe_var_servicio' )
begin
    DELETE FROM pe_servicio_dis 
    DELETE FROM pe_var_servicio 

    select @w_servicio_dis = isnull(min(sd_servicio_dis), 0) + 1 from pe_servicio_dis
	-- 'Servicio Diponible -----> PINT '
    print 'Servicio Diponible -----> PINT ' convert(varchar,@w_servicio_dis)
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'PA DE INTERESES', 'PINT', 'V', 0, 3, 'N')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '18', 'PA INT. SOBRE EL DISPONIBLE', 'V', '+', 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '2', 'RETENCION DE IMP SOBRE INTERESES PAGADOS', 'V', NULL, 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '23', 'PA INT SALDO PROMEDIO DISP', 'V', '+', 'M')
   
    --'Servicio Diponible -----> SCHQ '
    print 'Servicio Diponible -----> SCHQ ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1    
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'SOLICITUD DE CHEQUERA', 'SCHQ', 'V', 0, 1, 'N')
        
        
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '2', 'IMPUESTO TIMBRE CHEQUERA', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> CPEX '
    print 'Servicio Diponible -----> CPEX ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CHEQUES PAGADOS EXTRAS', 'CPEX', 'V', 0, 1, 'N')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '10', 'MULTA POR CHQ ADICIONAL PAGADO', 'V', '+', 'M')
    
	--'Servicio Diponible -----> CDEV '
    print 'Servicio Diponible -----> CDEV ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CHEQUES DEVUELTOS', 'CDEV', 'V', 0, 1, NULL)
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '11', 'COMISION POR CHQ DEVUELTO', 'V', '+', 'M')
    
	--'Servicio Diponible -----> SECU '
    print 'Servicio Diponible -----> SECU ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'SOLICITUD DE ESTADO DE CUENTA', 'SECU', 'V', 0, 1, 'N')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '15', 'COSTO POR SOLCITUD DE EST.CTA.', 'V', '+', 'M')
    
	--'Servicio Diponible -----> EECT '
    print 'Servicio Diponible -----> EECT ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'ENVIO DE ESTADO DE CUENTA', 'EECT', 'V', 0, 2, NULL)
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '21', 'COSTO POR ENVIO DE ESTADO DE CTA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '29', 'COSTO POR EMISION DE ESTADO DE CUENTA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> CCTA '
    print 'Servicio Diponible -----> CCTA ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CIERRE DE CUENTAS', 'CCTA', 'V', 0, 3, 'N')
        
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '22', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'DEDUCCION DE INTERES CIERRE ANTICIPADO', 'V', NULL, 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '41', 'MULTA CIERRE ANTES DE TIEMPO', 'V', '+', 'M')
    
	--'Servicio Diponible -----> MCTA '
    print 'Servicio Diponible -----> MCTA ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'MANTENIMIENTO DE CUENTAS', 'MCTA', 'V', 0, 1, 'N')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '24', 'COSTO POR MANT. DE CUENTA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> CREM '
    print 'Servicio Diponible -----> CREM ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION ENVIO AL COBRO DE CHEQUE REMESA', 'CREM', 'V', 0, 6, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '34', 'COMISION CHEQUE REMESAS-VIA INTERNA', 'V', NULL, 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '38', 'PORTES SOBRE REMESAS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '43', 'COMISION CHEQUE REMESAS.CORRESPONSAL', 'V', NULL, 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '44', 'COMISION CHEQUE REMESAS-BCO AGRARIO', 'V', NULL, 'P')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '45', 'PORTES DEVOLUCION CHEQUE REMESA', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '48', 'PORTES CHEQUES REMESAS', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> MMAP '
    print 'Servicio Diponible -----> MMAP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'MONTO MINIMO APERTURA', 'MMAP', 'V', 0, 1, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '39', 'MONTO MINIMO APERTURA CUENTA DE AHORROS', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> RIMN '
    print 'Servicio Diponible -----> RIMN ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'REIMPRESION DE NOTAS', 'RIMN', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION REIMPRESION DE NOTAS', 'V', '+', 'M')
    
	--'Servicio Diponible -----> TRNA '
    print 'Servicio Diponible -----> TRNA ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'TRANSACCION NACIONAL', 'TRNA', 'V', 0, 8, 'S')
        
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '310', 'COM TRNA RETIRO CHQ GERENCIA', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '311', 'COM TRNA CONSULTA SALDO CAJA', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '312', 'COM TRNA DEPOSITO CTA AHORROS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '313', 'COM TRNA RETIRO CTA AHORROS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '314', 'COM TRNA CRE TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '315', 'COM TRNA TRANSFERENCIA ENTRE CUENTAS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '316', 'COM TRNA NOTA CR AHORROS', 'V', NULL, 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '317', 'COM TRNA NOTA DB AHORROS', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> SMC '
    print 'Servicio Diponible -----> SMC ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'SALDO MINIMO', 'SMC ', 'V', 0, 2, 'S')
                
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'SMA', 'SERVICIO SALDO MAXIMO DE LA CUENTA', 'V', '', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'SMI', 'SERVICIO SALDO MINIMO DE LA CUENTA', 'V', '', 'M')

	--'Servicio Diponible -----> CCE '
    print 'Servicio Diponible -----> CCE ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION  CENTRO  DE EFECTIVO', 'CCE ', 'V', 0, 1, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION  CENTRO  DE EFECTIVO', 'V', '', 'M')
    
	--'Servicio Diponible -----> CSLM '
    print 'Servicio Diponible -----> CSLM ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'SALDO MINIMO', 'CSLM', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION POR SALDO MINIMO', 'V', '+', 'M')
    
	--'Servicio Diponible -----> INAC '
    print 'Servicio Diponible -----> INAC ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'INACTIVIDAD', 'INAC', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION POR INACTIVIDAD DE CUENTA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> LIRE '
    print 'Servicio Diponible -----> LIRE ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'LIBERACION DE CANJE', 'LIRE', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '46', 'COMISION POR LIBERACION DE CANJE', 'V', '', 'M')
    
	--'Servicio Diponible -----> COCO '
    print 'Servicio Diponible -----> COCO ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION EN OFICINA', 'COCO', 'V', 0, 31, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COBRO DE COMISION TRANSACCIONES EN OFICINA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C230', 'COMIS. TIPO C CONSULTA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C237', 'COMIS. TIPO D TRANSFERENCIA AA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C239', 'COMIS. TIPO D TRANSFERENCIA AC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C2519', 'COMIS. TIPO D TRANSFERENCIA CC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C252', 'COMIS. TIPO C DEPOSITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C2520', 'COMIS. TIPO D TRANSFERENCIA CA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C253', 'COMIS. TIPO C N. CREDITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C2626', 'COMIS. TIPO C TRANSFERENCIA CC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C2627', 'COMIS. TIPO C TRANSFERENCIA AC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C263', 'COMIS. TIPO C RETIRO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C264', 'COMIS. TIPO C N. DEBITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C294', 'COMIS. TIPO C TRANSFERENCIA CA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C300', 'COMIS. TIPO C TRANSFERENCIA AA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'C380', 'COMIS. TIPO C RET. CHQ. GERENCIA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'M', 'COMISION TIPO COBRO MENSUAL', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'T', 'COMISION TIPO COBRO CONTADOR GENERAL', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W230', 'COMIS. TIPO W CONSULTA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W237', 'COMIS. TIPO W TRANSFERENCIA DEB AA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W239', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W2519', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W252', 'COMIS. TIPO W DEPOSITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W2520', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W253', 'COMIS. TIPO W N. CREDITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W2626', 'COMIS. TIPO W TRANSFERENCIA CC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W2627', 'COMIS. TIPO W TRANSFERENCIA AC', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W263', 'COMIS. TIPO W RETIRO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W264', 'COMIS. TIPO W N. DEBITO', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W294', 'COMIS. TIPO W TRANSFERENCIA CA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W300', 'COMIS. TIPO W TRANSFERENCIA CRE AA', 'V', '+', 'M')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'W380', 'COMIS. TIPO W RET. CHQ. GERENCIA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> REVE '
    print 'Servicio Diponible -----> REVE ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'RETIRO POR VENTANILLA', 'REVE', 'V', 0, 1, 'S')
        
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'RETIRO POR VENTANILLA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> CCER '
    print 'Servicio Diponible -----> CCER ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CERTIFICACIONES Y REFERENCIAS', 'CCER', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION POR CERTIFICACIONES Y REFERENCIAS', 'V', '+', 'M')
    
	--'Servicio Diponible -----> CHQG '
    print 'Servicio Diponible -----> CHQG ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'RETIRO CHEQUE GERENCIA', 'CHQG', 'V', 0, 1, 'N')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'RETIRO CHEQUE GERENCIA', 'V', '+', 'M')
    
	--'Servicio Diponible -----> TRAL '
    print 'Servicio Diponible -----> TRAL ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION POR TRANSFERENCIA DE ALIANZA CO', 'TRAL', 'V', 0, 1, 'N')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, 'CMTR', 'MONTO COMISION POR TRANSFERENCIA ALIANZA', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> RTCB '
    print 'Servicio Diponible -----> RTCB ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'RETIRO CORRESPONSAL BANCARIO', 'RTCB', 'V', 0, 1, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION RETIRO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> CNCB '
    print 'Servicio Diponible -----> CNCB ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CONSULTA CORRESPONSAL BANCARIO', 'CNCB', 'V', 0, 1, 'S')
    
        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION CONSULTA CORRESPONSAL BANCARIO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> DPCB '
    print 'Servicio Diponible -----> DPCB ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'DEPOSITO CORRESPONSAL BANCARIO', 'DPCB', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION DEPOSITO CORRESPONSAL BANCARIO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> W264141 '
    print 'Servicio Diponible -----> W264141 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION TRANSACCION ATM NACIONAL', 'W264141', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION TRANSACCION ATM NACIONAL', 'V', NULL, 'P')
    
	--'Servicio Diponible -----> W264142 '
    print 'Servicio Diponible -----> W264142 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION TRANSACCION ATM INTERNACIONAL', 'W264142', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION TRANSACCION ATM  INTERNACIONAL', 'V', NULL, 'P')
    
	--'Servicio Diponible -----> W264233 '
    print 'Servicio Diponible -----> W264233 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION CONSULTA ATM NACIONAL', 'W264233', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION CONSULTA ATM NACIONAL', 'V', NULL, 'P')
    
	--'Servicio Diponible -----> W264234 '
    print 'Servicio Diponible -----> W264234 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION CONSULTA ATM INTERNACIONAL', 'W264234', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION CONSULTA ATM INTERNACIONAL', 'V', NULL, 'P')
    
	--'Servicio Diponible -----> W264238 '
    print 'Servicio Diponible -----> W264238 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION CUOTA DE MANEJO', 'W264238', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION CUOTA DE MANEJO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> W264156 '
    print 'Servicio Diponible -----> W264156 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION POR PIN INVALIDO', 'W264156', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (70, '3', 'COMISION POR PIN INVALIDO', 'V', NULL, 'M')
    

	--'Servicio Diponible -----> W264159 '
    print 'Servicio Diponible -----> W264159 ' convert(varchar,@w_servicio_dis)
	    
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'W264159', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (71, '3', 'COMISION PERDIDA DETERIORO TARJE DEBITO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> W264161 '
    print 'Servicio Diponible -----> W264161 ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION FONDOS INSUFICIENTES', 'W264161', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION FONDOS INSUFICIENTES', 'V', NULL, 'P')
    
	--'Servicio Diponible -----> CNTD '
    print 'Servicio Diponible -----> CNTD ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION RETIRO OF TARJETA DEBITO', 'CNTD', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION RETIRO OF TARJETA DEBITO', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> CNCBP '
    print 'Servicio Diponible -----> CNCBP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CONSULTA CB POSICIONADO', 'CNCBP', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'Consulta de Saldo CB Posicionado', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> CCCBP '
    print 'Servicio Diponible -----> CCCBP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'CONSULTA COSTO CB POSICIONADO', 'CCCBP', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'Consulta Costo CB Posicionado', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> PACBP '
    print 'Servicio Diponible -----> PACBP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'PAGO CB POSICIONADO', 'PACBP', 'V', 0, 0, 'S')
    
	--'Servicio Diponible -----> RTCBP '
    print 'Servicio Diponible -----> RTCBP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'RETIRO CB POSICIONADO', 'RTCBP', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'Retiro CB Posicionado', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> DPCBP '
    print 'Servicio Diponible -----> DPCBP ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'DEPOSITO CB POSICIONADO', 'DPCBP', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'Deposito CB Posicionado', 'V', NULL, 'M')
    
	--'Servicio Diponible -----> CSTD '
    print 'Servicio Diponible -----> CSTD ' convert(varchar,@w_servicio_dis)
	
    select @w_servicio_dis = @w_servicio_dis + 1
    INSERT INTO pe_servicio_dis (sd_servicio_dis, sd_descripcion, sd_nemonico, sd_estado, sd_costo_interno, sd_num_rubro, sd_historico)
    VALUES (@w_servicio_dis, 'COMISION CONSULTA SALDO OFICINA CTA TD', 'CSTD', 'V', 0, 1, 'S')

        INSERT INTO pe_var_servicio (vs_servicio_dis, vs_rubro, vs_descripcion, vs_estado, vs_signo, vs_tipo_dato)
        VALUES (@w_servicio_dis, '3', 'COMISION CONSULTA SALDO OFICINA CTA AH T', 'V', NULL, 'M')
    
    SELECT @w_servicio_dis = max(sd_servicio_dis) 
        FROM pe_servicio_dis

    update cobis..cl_seqnos 
            set siguiente = @w_servicio_dis
        WHERE tabla='pe_servicio_dis'
end
go

declare    @w_tipo_rango    int,
        @w_grupo_rango    int,
        @w_rango        int,
        @w_descripcion    varchar(100),
        @w_moneda        int

SELECT     @w_descripcion = 'RANGO SOBRE SALDO DISPONIBLE', @w_rango = 1
select     @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'

IF not exists(SELECT 1 FROM cob_remesas..pe_tipo_rango 
              WHERE tr_descripcion = @w_descripcion)    
BEGIN
    exec     @w_return     = cobis..sp_cseqnos
            @i_tabla    = 'pe_tipo_rango',
            @o_siguiente= @w_tipo_rango out
    
    IF @w_return != 0 or @w_tipo_rango is null
    BEGIN
        PRINT 'Error en la obtencion de secuencial pe_tipo_rango'
    END
    
    INSERT INTO cob_remesas..pe_tipo_rango 
            (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
        VALUES 
            (@w_tipo_rango, @w_descripcion, 'A', @w_moneda, 'V')    
    
    IF @@error != 0 or @@rowcount != 1
    BEGIN
        PRINT 'Error en la inserccion de registro en pe_tipo_rango'
    END
END
ELSE
begin
    SELECT     @w_tipo_rango = tr_tipo_rango
        FROM cob_remesas..pe_tipo_rango 
        WHERE tr_descripcion = @w_descripcion
end

IF not exists(SELECT 1 FROM cob_remesas..pe_rango 
                WHERE ra_tipo_rango = @w_tipo_rango
                AND ra_desde = 0 
                AND ra_hasta = 99999999999999)
BEGIN
    SELECT     @w_grupo_rango = isnull(max(ra_grupo_rango), 0) + 1
        FROM cob_remesas..pe_rango 
        where ra_tipo_rango = @w_tipo_rango

    INSERT INTO cob_remesas..pe_rango 
        (ra_tipo_rango, ra_grupo_rango, ra_rango, ra_desde, ra_hasta, ra_estado)
    VALUES 
        (@w_tipo_rango, @w_grupo_rango , @w_rango, 0, 99999999999999, 'V')

    IF @@error != 0 or @@rowcount != 1
    BEGIN
        PRINT 'Error en la inserccion de registro en pe_rango'
    END
END
go

--data inicial rango edades
IF exists (SELECT 1 FROM sysobjects WHERE name = 'pe_pro_rango_edad' )
begin
    DELETE FROM cob_remesas..pe_pro_rango_edad

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (1, 'MENOR DE EDAD', 0, 17, 'V')

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (2, 'MAYOR DE EDAD', 18, 100, 'V')

    INSERT INTO cob_remesas..pe_pro_rango_edad (re_codigo, re_descripcion, re_rango_ini, re_rango_fin, re_estado)
    VALUES (3, 'TODOS', 0, 100, 'V')
end
go
