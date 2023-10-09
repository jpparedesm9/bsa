/*******************************************************************************/
/*  Archivo:             carga_archivo.sp                                      */
/*  Store Procedure:     sp_ah_carga_archivo                                   */
/*  Base de Datos:       cob_remesas                                           */
/*  Producto:            Ahorros                                               */
/*  Diseñado por:        Jorge Baque H                                         */
/*  Fecha de Escritura:  24/AGO/2016                                           */
/*******************************************************************************/
/*                    IMPORTANTE                                               */
/*  Este programa es parte de los paquetes bancarios propiedad de "MACOSA",    */
/*  representantes exclusivos para el Ecuador de la "NCR CORPORATION".         */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/*  alteracion o agregado hecho por alguno de sus usuarios sin el debido       */
/*  consentimiento por escrito de la Presidencia Ejecutiva de MACOSA o su      */
/*  representante.                                                             */
/*******************************************************************************/
/*                     PROPOSITO                                               */
/*      Carga de archivo de depositos, retiros, NC, ND                         */
/*******************************************************************************/
/*                         MODIFICACIONES                                      */
/*    FECHA                    AUTOR                      RAZON                */
/* 24/AGO/2016             Jorge Baque H.        Emision Inicial               */
/*******************************************************************************/

use cob_ahorros
go


if exists (select * from sysobjects where name = 'sp_carga_archivo_mas_tran')
   drop proc sp_carga_archivo_mas_tran
go

create proc sp_carga_archivo_mas_tran (    
    @t_show_version             bit                 = 0,
    @i_archivo_transacciones    varchar(100)         = null,
    @i_archivo_detalle_cheqs    varchar(100)         = null,
    @i_ruta                     varchar(300)         = null
    ) as
    declare @w_sp_name          varchar(64),
            @w_s_app            varchar(64),
            @w_comando          varchar(4000),
            @w_path             varchar(350),
            @w_archivo_tran     varchar(100),
            @w_archivo_det_chq  varchar(100),
            @w_error            int,
            @w_mensaje          varchar(150),
            @w_contador         int,
            @w_indice           int,
            @w_contador2        int,
            @w_indice2          int,
            @w_num_eje_tran     int,
            @w_num_eje_chq      int
    /* TABLA DE ERRORES DE BCP*/
    declare     @resultadobcp       table (linea varchar(max))

    --Captura nombre de Stored Procedure.---------------
    select @w_sp_name   =  'sp_ah_carga_archivo'

    ---- VERSIONAMIENTO DEL PROGRAMA -------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure=%1! Version=%2!' + @w_sp_name +  '4.0.0.0'
        return 0
    end
    
    /***PARAMETRO S_APP***/
    select @w_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
    and pa_nemonico = 'S_APP'

    /***RUTA DEL ARCHIVO***/
    select @w_path = @i_ruta
    
    select @w_archivo_tran = @i_archivo_transacciones
    select @w_archivo_det_chq = @i_archivo_detalle_cheqs
    
    set nocount on
    begin
	
	    --TRANSACCIONES
        truncate table ah_transacciones_cm_tmp
        truncate table ah_det_cheq_cm_tmp
    
        select
        @w_comando = @w_s_app + 's_app' + ' bcp -auto -login cob_ahorros..ah_transacciones_cm_tmp in '
                 + @w_path + @w_archivo_tran +  ' -c -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
         /* EJECUTAR CON CMDSHELL */
        delete from @resultadobcp
        insert into @resultadobcp
        exec xp_cmdshell
            @w_comando
		
		select @w_mensaje = null
		
		--SELECCIONA MENSAJE DE ERROR
		select top 1 @w_mensaje = upper(@w_archivo_tran) + ' ' + linea 
		from @resultadobcp 
		where linea LIKE 'Error%' 
		
		--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
		if @w_mensaje is null
		    select top 1 @w_mensaje = upper(@w_archivo_tran) + ' ' + linea 
		    from @resultadobcp 
		    where linea LIKE '%Error%' 
			
		if @w_mensaje is not null
		begin
		    select @w_error = 357023
            goto ERROR
		end
		
        select @w_contador = isnull(count(*),0) from cob_ahorros..ah_transacciones_cm_tmp
        if @w_contador = 0
        begin
            select
              @w_mensaje = 'NO HAY REGISTROS EN LA ah_transacciones_cm_tmp ',
              @w_error = 4000003      
             goto ERROR
        end

		
		--DETALLE DE CHEQUES
		
        select
        @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_ahorros..ah_det_cheq_cm_tmp in '
                 + @w_path
                 + @w_archivo_det_chq +  ' -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'
         /* EJECUTAR CON CMDSHELL */
        delete from @resultadobcp
        insert into @resultadobcp
        exec xp_cmdshell
            @w_comando
        		
		select @w_mensaje = null
		
		--SELECCIONA MENSAJE DE ERROR
		select top 1 @w_mensaje = upper(@w_archivo_det_chq) + ' ' + linea 
		from @resultadobcp 
		where linea LIKE 'Error%' 
		
		--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
		if @w_mensaje is null
		    select top 1 @w_mensaje = upper(@w_archivo_det_chq) + ' ' + linea 
		    from @resultadobcp 
		    where linea LIKE '%Error%' 
			
		if @w_mensaje is not null
		begin
		    select @w_error = 357023
            goto ERROR
		end
		        
        select @w_num_eje_tran = isnull(max(tr_num_ejecucion),0) + 1
        from ah_transacciones_cm
        where tr_nom_archivo = @i_archivo_transacciones

        select @w_num_eje_chq = isnull(max(dc_num_ejecucion),0) + 1
        from ah_det_cheq_cm
        where dc_nom_archivo = @i_archivo_detalle_cheqs
  
        if exists(select 1 from ah_transacciones_cm where tr_nom_archivo = @w_archivo_tran and tr_estado = 'E')
        begin
            update ah_transacciones_cm
            set tr_secuencial  = tc_secuencial, 
                tr_transaccion = upper(tc_transaccion), 
                tr_cta_cobis   = tc_cta_cobis, 
                tr_cta_mig     = tc_cta_mig, 
                tr_monto_efe   = tc_monto_efe, 
                tr_monto_chq   = tc_monto_chq,
                tr_fecha_carga = tc_fecha_carga, 
                tr_causa       = tc_causa, 
				tr_remesas     = upper(tc_remesas),
                tr_estado      = 'I',
                tr_num_ejecucion    = @w_num_eje_tran
            from ah_transacciones_cm_tmp
            where tr_nom_archivo = @w_archivo_tran
            and tr_estado = 'E'
            and tr_secuencial = tc_secuencial
        end
        
        if not exists(select 1 from ah_transacciones_cm where tr_nom_archivo = @w_archivo_tran)
        begin 
        
            insert into ah_transacciones_cm (tr_secuencial, tr_transaccion,tr_cta_cobis,tr_cta_mig, 
			                                 tr_monto_efe, tr_monto_chq,tr_fecha_carga, tr_causa,
											 tr_remesas, tr_estado, tr_nom_archivo,tr_num_ejecucion)
            select tc_secuencial, upper(tc_transaccion),tc_cta_cobis,tc_cta_mig,
                   tc_monto_efe,tc_monto_chq,tc_fecha_carga, tc_causa,
				   upper(tc_remesas),'I', @w_archivo_tran,@w_num_eje_tran
            from ah_transacciones_cm_tmp
        end

        /*********************************** VALIDACION DE ARCHIVO DETALLE CHQ ****************************************/
        if exists(select 1 from ah_det_cheq_cm where dc_nom_archivo = @w_archivo_det_chq and dc_estado = 'E')
        begin
            --Elimina los registros que presentaron error
			
            delete ah_det_cheq_cm where dc_nom_archivo = @w_archivo_det_chq and dc_estado = 'E'
        end
        
        --Se insertan los registros que no se encuentran procesados
        insert into ah_det_cheq_cm 
        (dc_nom_archivo, dc_sec_dep, dc_sec_chq, dc_sec_chq_aux, dc_cod_ban, 
         dc_cuenta_chq, dc_num_chq, dc_monto,   dc_fecha_emi,   dc_fecha_carga, 
         dc_estado, dc_num_ejecucion)             
        select @w_archivo_det_chq, y.dc_sec_dep, y.dc_sec_chq, y.dc_sec_chq, y.dc_cod_ban,
               y.dc_cuenta_chq, y.dc_num_chq, y.dc_monto, y.dc_fecha_emi, y.dc_fecha_carga, 
               'I', @w_num_eje_chq
        from ah_det_cheq_cm_tmp y
        where not exists (select 1 from ah_det_cheq_cm x 
                          where x.dc_sec_dep     = y.dc_sec_dep 
                            and x.dc_sec_chq     = y.dc_sec_chq 
                            and x.dc_nom_archivo = @w_archivo_det_chq)

        /***************************** Actualizo secuencial de detalle de deposito **************************/

        select  dc_sec_chq = row_number() over (partition by dc_sec_dep order by dc_secuencial),
                dc_nom_archivo, dc_secuencial                
        into #aux
        from ah_det_cheq_cm
        where dc_nom_archivo = @w_archivo_det_chq
        
        update ah_det_cheq_cm
        set dc_sec_chq_aux = #aux.dc_sec_chq
        from #aux
        where #aux.dc_nom_archivo = @w_archivo_det_chq
        and ah_det_cheq_cm.dc_secuencial = #aux.dc_secuencial 
        return 0
   end

   

   ERROR:
   exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = @w_error,
        @i_msg  = @w_mensaje
        return @w_error
 
go
