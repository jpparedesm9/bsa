/***********************************************************************/
/*  Archivo:                        pro_mas_tra.sp                     */
/*  Stored procedure:               sp_pro_mas_tran                    */
/*  Base de Datos:                  cob_ahorros                        */
/*  Producto:                       Ahorros                            */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Este programa es parte de los paquetes bancarios propiedad de      */
/*  "COBISCORP SA",representantes exclusivos para el Ecuador de la     */
/*  AT&T                                                               */
/*  Su uso no autorizado queda expresamente prohibido asi como         */
/*  cualquier autorizacion o agregado hecho por alguno de sus          */
/*  usuario sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante           */
/***********************************************************************/
/*                      PROPOSITO                                      */
/*  Realiza el proceso masivo de carga, validacion y procesamiento de  */
/*  transacciones                                                      */
/***********************************************************************/
/*  FECHA       AUTOR                   RAZON                          */
/* 29/08/2016   T. Baidal          Emision inicial                     */
/* 30/08/2016   J. BAQUE           Se agrega operaciones de NC/ND      */
/***********************************************************************/


use cob_ahorros
go

if exists(select * from sysobjects where name = 'sp_pro_mas_tran')
   drop proc sp_pro_mas_tran
go

create proc sp_pro_mas_tran
(
    @t_show_version bit = 0,
    @i_param1       int,         --@i_filial
    @i_param2       datetime,    --@i_fecha_proceso
    @i_param3       varchar(250),--Ruta de los archivos 
    @i_param4       varchar(50), --Nombre Archivo Transaccion
    @i_param5       varchar(50) = null  --Nombre Archivo Detalle

)
as
declare
    @w_cont_transacciones  int,
    @w_indice          int,
    @w_cuenta_cobis    cuenta,
    @w_monto_efe       money,
    @w_monto_chq       money,
    @w_total           money,
    @w_return          int,
    @w_servidor        varchar(50),
    @w_sp_name         varchar(30),
    @w_mensaje         varchar(50),
    @w_cod_error       int,
    @i_ruta            varchar(300),
    @i_archivo_tran    varchar(50),
    @i_archivo_det_chq varchar(50),
    @i_fecha           datetime,
    @i_filial          int,
    @w_ssn             int,
    @w_ssn_branch      int,
    @w_tr_secuencial   int,
    @w_transaccion     varchar(3),
    @w_detalle_cheque  smallint,
    @w_indice_cheque   smallint,
    @w_cod_banco       smallint,
    @w_cta_chq         varchar(64),
    @w_num_chq         int,
    @w_sec_chq         int,
    @w_ofi_matriz      int,
    @w_rol             tinyint,
    @w_moneda_local    tinyint,
    @w_nombre_bco      varchar(64),
    @w_fecha_emi       datetime,
    @w_causa           char(3),
    @w_ejecucion_tran  int,
    @w_ejecucion_dchq  int,
	@w_suma_chqs       money,
	@w_s_app           varchar(64),
	@w_comando         varchar(1000),
	@w_path            varchar(350),
	@w_monto           money,
	@w_remesas         char(1)

select @w_sp_name         = 'sp_val_trn_cm' 

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
  return 0
end

select  @i_filial          = @i_param1,
        @i_fecha           = @i_param2,
        @i_ruta            = @i_param3,
        @i_archivo_tran    = @i_param4,
        @i_archivo_det_chq = @i_param5


		
--SE OBTIENE EL PARAMETRO DEL SERVIDOR
select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
  and pa_nemonico = 'SRVR'

if @w_servidor is null
begin   
    select  @w_mensaje= 'NO EXISTE PARAMETRO DE SERVIDOR',
            @w_cod_error=499999
    goto ERROR
end

select @w_ofi_matriz = pa_smallint
from   cobis..cl_parametro
where  pa_producto = 'AHO'
   and pa_nemonico = 'OMAT'

if @w_ofi_matriz is null
begin
    
    select top 1 
           @w_ofi_matriz = of_oficina 
    from cobis..cl_oficina
    where of_nombre like '%MATRIZ%'
    
    if @w_ofi_matriz is null
    begin
        select  @w_mensaje= 'NO EXISTE OFICINA MATRIZ',
            @w_cod_error=499999
        goto ERROR
    end
end

select @w_rol = ro_rol 
from cobis..ad_rol
where UPPER(ro_descripcion) like '%OPERADOR%BATCH%'

if @w_rol is null
begin   
    select  @w_mensaje= 'NO EXISTE ROL DEL OPERADOR DE BATCH',
            @w_cod_error=499999
    goto ERROR
end


select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
   and pa_nemonico = 'CMNAC'

--SE OBTIENE EL SECUENCIAL DE EJECUCION
select @w_ejecucion_tran = isnull(max(tr_num_ejecucion),0) + 1
from ah_transacciones_cm
where tr_nom_archivo = @i_archivo_tran

select @w_ejecucion_dchq = isnull(max(dc_num_ejecucion),0) + 1
from ah_det_cheq_cm
where dc_nom_archivo = @i_archivo_det_chq

--CARGA MASIVA DE TRANSACCIONES 
exec @w_return=cob_ahorros..sp_carga_archivo_mas_tran
     @i_ruta                  = @i_ruta,
     @i_archivo_transacciones = @i_archivo_tran,
     @i_archivo_detalle_cheqs = @i_archivo_det_chq
     
if @w_return <> 0
begin
    select @w_mensaje = mensaje
                  from   cobis..cl_errores
                  where  numero = @w_return
    select @w_cod_error=@w_return
    goto ERROR
end

--VALIDACION DE TRANSACCIONES CARGADAS
exec @w_return = sp_val_trn_cm 
     @i_archivo_tran    = @i_archivo_tran, 
     @i_archivo_det_chq = @i_archivo_det_chq,
     @i_fecha           = @i_fecha

if @w_return <> 0
begin   
    select @w_mensaje = mensaje
                  from   cobis..cl_errores
                  where  numero = @w_return
    select @w_cod_error=@w_return
    goto ERROR
end


--SE OBTIENE EL NUMERO DE TRANSACCIONES DE DEPOSITO
select @w_cont_transacciones = count(1) from ah_transacciones_cm
     where tr_nom_archivo = @i_archivo_tran 
            and tr_estado = 'V'
     --and tr_transaccion = 'DE'

--SE RECORREN LAS TRANSACCIONES QUE TIENEN ESTADO VALIDO(V)  
select @w_indice = 0

while (@w_indice < @w_cont_transacciones)
begin
    select @w_indice_cheque = 0, @w_ssn = 0, @w_ssn_branch = 0
         
    select top 1 
           @w_tr_secuencial= tr_secuencial,
           @w_cuenta_cobis = tr_cta_cobis,
           @w_monto_efe    = isnull(tr_monto_efe,0),
           @w_monto_chq    = isnull(tr_monto_chq,0),
           @w_transaccion  = tr_transaccion,
           @w_causa        = tr_causa,
		   @w_remesas      = tr_remesas
    from ah_transacciones_cm
    where tr_nom_archivo = @i_archivo_tran 
      and tr_estado ='V'
     
    --and tr_transaccion = 'DE'
    exec @w_ssn = ADMIN...rp_ssn
    exec @w_ssn_branch = ADMIN...rp_ssn 
    	
	begin tran
	
    if(@w_transaccion = 'DE')
    begin
        --SE VALIDA QUE TENGA DETALLE DE CHEQUES
        
        select @w_detalle_cheque = count(*),
               @w_suma_chqs     = sum(dc_monto)	
        from ah_det_cheq_cm 
        where dc_nom_archivo = @i_archivo_det_chq
              and dc_sec_dep = @w_tr_secuencial
              and dc_estado  ='V'
	          
        if(@w_monto_chq > 0 and @w_detalle_cheque <= 0)
        begin
		   select  @w_return  = 499999,
                    @w_mensaje = 'NO EXISTEN CHEQUES VALIDOS PARA EL DEPOSITO'
            goto ERROR_TRAN
        end
        --SE REGISTRA EL DETALLE DE CHEQUES
        while (@w_indice_cheque < @w_detalle_cheque)
        begin
			
            select top 1
               @w_sec_chq   =   dc_sec_chq,
               @w_monto     =   dc_monto,
               @w_cod_banco =   dc_cod_ban,
               @w_cta_chq   =   dc_cuenta_chq,
               @w_num_chq   =   dc_num_chq,
               @w_fecha_emi =   dc_fecha_emi                      
            from ah_det_cheq_cm 
            where dc_nom_archivo = @i_archivo_det_chq
              and dc_sec_dep     = @w_tr_secuencial
              and dc_estado      = 'V'   
                    
            --SE OBTIENE NOMBRE DEL BANCO
            select @w_nombre_bco = ba_descripcion
            from cob_remesas..re_banco
			where ba_banco = @w_cod_banco
            
            if @w_nombre_bco is null
            begin
                select   @w_return     = 357037,
                         @w_mensaje    = 'EL CODIGO DEL BANCO DEL CHEQUE NO ES VALIDO'
                goto ERROR_TRAN
            end
			
			exec @w_return = cob_remesas..sp_detallecheque
                --agregar parametros
                   @s_ssn            = @w_ssn,
                   @s_ssn_branch     = @w_ssn_branch,
                   @s_user           = 'operador',
                   @s_term           = 'consola',
                   @s_date           = @i_fecha,
                   @s_ofi            = @w_ofi_matriz,
                   @s_rol            = @w_rol,
                   @s_org            = 'U',
                   @s_srv            = @w_servidor,
                   @t_trn            = 639,
                   @i_operacion      = 'O',
                   @i_ssn_dep        = @w_ssn,
                   @i_ssn_branch_dep = @w_ssn_branch,
                   @i_filial         = @i_filial,
                   @i_cta_banco      = @w_cuenta_cobis,
                   @i_producto       = 4,
                   @i_sec            = @w_sec_chq,
                   @i_tipo           = '1',
                   @i_co_banco       = @w_cod_banco,
                   @i_no_banco       = @w_nombre_bco,
                   @i_cta_cheque     = @w_cta_chq,
                   @i_num_cheque     = @w_num_chq,
                   @i_valor          = @w_monto,
                   @i_mon            = @w_moneda_local,
                   @i_fechaemision   = @w_fecha_emi,
                   @i_estado         = 'I'
            			
            if(@w_return <> 0)
            begin
                goto ERROR_TRAN
            end			

            update ah_det_cheq_cm 
                set dc_estado = 'P'
                where dc_nom_archivo   = @i_archivo_det_chq
                        and dc_sec_dep = @w_tr_secuencial
						and dc_sec_chq = @w_sec_chq
                        and dc_estado  = 'V'
			
            select @w_indice_cheque = @w_indice_cheque + 1
        end
		
        --TOTAL = EFECTIVO + CHEQUES
        select @w_total = isnull(@w_monto_efe, 0) + isnull(@w_monto_chq, 0)

        exec @w_return = sp_ah_depositosl 
                 @s_ssn        = @w_ssn, --Admin..rp_ssn
                 @s_ssn_branch = @w_ssn_branch, --Admin..rp_ssn
                 @s_lsrv       = @w_servidor,
                 @s_user       = 'operador', 
                 @s_term       = 'consola',
                 @s_date       = @i_fecha,
                 @s_ofi        = @w_ofi_matriz,
                 @s_rol        = @w_rol,
                 @s_org        = 'U',
                 @s_srv        = @w_servidor,
                 @t_trn        = 252,--252 transaccion de deposito
                 @i_cta        = @w_cuenta_cobis,
                 @i_mon        = @w_moneda_local,
                 @i_val        = @w_monto_efe,
                 @i_total      = @w_total,
                 @i_loc        = @w_monto_chq,
                 @i_ActTot     = 'N',--igual que en front end
                 @i_canal      = 0, --igual que en front end
				 @i_remesas    = @w_remesas,
				 @i_batch      = 'S'
    end
	
    --TRANSACCIONA RETIRO
    if(@w_transaccion = 'RE')
    begin
        exec @w_return     = sp_ah_retirosl 
             @s_ssn        = @w_ssn,
             @s_ssn_branch = @w_ssn_branch,
             @s_lsrv       = @w_servidor,--serv. central
             @s_user       = 'operador', 
             @s_term       = 'consola',
             @s_date       = @i_fecha,--fecha_proceso
             @s_ofi        = @w_ofi_matriz,--oficna matriz, no se envia
             @s_rol        = @w_rol, --buscar en procesos batchs o rol de operador
             @s_org        = 'U',
             @s_srv        = @w_servidor,--serv.central
             @t_trn        = 263,--Transaccion de retiro
             @i_cta        = @w_cuenta_cobis,
             @i_mon        = @w_moneda_local, --la buscar parametro moneda local
             @i_val        = @w_monto_efe,
             --@i_total = 500,
             @i_ActTot     = 'S',--igual
             @i_canal      = 0, --igual
			 @i_batch      = 'S'
    end
    
    
    --TRANSACCIONA NOTA DE CREDITO
    if(@w_transaccion = 'NC')
    begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
              @s_srv        = @w_servidor,
              @s_ofi        = @w_ofi_matriz, --MATRIZ
              @s_ssn        = @w_ssn,--123,
              @s_ssn_branch = @w_ssn_branch,
              @s_user       = 'operador',
              @s_org        = 'U',
              @t_trn        = 253, --CODIGO DE TRANSACCION
              @t_corr       = 'N',
              @t_ssn_corr   = null,
              @i_cta        = @w_cuenta_cobis,
              @i_val        = @w_monto_efe,
              @i_cau        = @w_causa,
              @i_mon        = @w_moneda_local,
              --@i_alt        = 1,
              @i_fecha      = @i_fecha,
              @i_cobiva     = 'N',
              @i_canal      = 4,
			  @i_is_batch   = 'S'
    end
    --TRANSACCIONA NOTA DE DEBITO
    if(@w_transaccion = 'ND')
    begin
        exec @w_return = cob_ahorros..sp_ahndc_automatica
              @s_srv        = @w_servidor,
              @s_ofi        = @w_ofi_matriz, --MATRIZ
              @s_ssn        = @w_ssn,--123,
              @s_ssn_branch = @w_ssn_branch,
              @s_user       = 'operador',
              @s_org        = 'U',
              @t_trn        = 264, --CODIGO DE TRANSACCION
              @t_corr       = 'N',
              @t_ssn_corr   = null,
              @i_cta        = @w_cuenta_cobis,
              @i_val        = @w_monto_efe,
              @i_cau        = @w_causa,
              @i_mon        = @w_moneda_local,
              --@i_alt        = 1,
              @i_fecha      = @i_fecha,
              @i_cobiva     = 'N',
              @i_canal      = 4,
			  @i_is_batch   = 'S'
    end
    
    
    if(@w_return=0)
    begin
	    commit tran
        --SE ACTUALIZA EL REGISTRO A PROCESADO
        update ah_transacciones_cm
        set tr_estado = 'P'
        where tr_nom_archivo = @i_archivo_tran
          and tr_estado      = 'V'
          and tr_transaccion = @w_transaccion
          and tr_secuencial  = @w_tr_secuencial
				
		--REGISTRO LOG DE TRANSACCIONES
		insert into ah_log_cm_tran (lc_nom_archivo , lc_ejecucion, lc_sec_tran,lc_ssn,lc_num_error, lc_mensaje_error ,lc_fecha)
        values (@i_archivo_tran,@w_ejecucion_tran,@w_tr_secuencial,@w_ssn,@w_return,'TRANSACCION PROCESADA',@i_fecha)               
        
        if @@error <> 0
        begin   
            select  @w_mensaje= 'ERROR AL INSERTAR EN LOG DE ERRORES',
                    @w_cod_error=499999
            goto ERROR
        end
		
		
		insert into ah_log_cm_tran (lc_nom_archivo , lc_ejecucion, lc_sec_tran, lc_sec_chq, lc_ssn,lc_num_error, lc_mensaje_error ,lc_fecha)
        select @i_archivo_det_chq,@w_ejecucion_dchq,@w_tr_secuencial,dc_sec_chq,@w_ssn,@w_return,'TRANSACCION PROCESADA',@i_fecha                     
        from ah_det_cheq_cm 
        where dc_nom_archivo = @i_archivo_det_chq
          and dc_sec_dep     = @w_tr_secuencial
          and dc_estado      = 'P'               

         if @@error <> 0
         begin
            select  @w_mensaje   = 'ERROR AL INSERTAR EN LOG DE ERRORES',
                    @w_cod_error =499999
               goto ERROR
         end
		
		
    end
    else if @w_return <> 0
    begin
	    rollback tran	

        ERROR_TRAN:
        --SE ACTUALIZA EL REGISTRO CON ERROR
        update ah_transacciones_cm
        set tr_estado='E'
        where tr_nom_archivo = @i_archivo_tran 
        and tr_estado      = 'V'
        and tr_transaccion = @w_transaccion
        and tr_secuencial  = @w_tr_secuencial
		
		--BUSCA DESCRIPCION DEL ERROR
        select @w_mensaje = mensaje
        from cobis..cl_errores
        where numero = @w_return

        if @w_mensaje is null
            select @w_mensaje = 'ERROR AL PROCESAR TRANSACCION'
        
        --INSERTO EN LOG		
        insert into ah_log_cm_tran (lc_nom_archivo,lc_ejecucion,lc_sec_tran,lc_ssn,lc_num_error,lc_mensaje_error,lc_fecha)
        values (@i_archivo_tran,@w_ejecucion_tran,@w_tr_secuencial,@w_ssn,@w_return,@w_mensaje,@i_fecha)               
        
        if @@error <> 0
        begin
            select  @w_mensaje= 'ERROR AL INSERTAR EN LOG DE ERRORES',
                    @w_cod_error=499999
            goto ERROR
        end
		
		
		--SE ACTUALIZA LOS REGISTROS DEL DETALLE
		if @w_detalle_cheque > 0
		begin
			--ACTUALIZACION DEL ESTADO DE CHEQUES A --> ERROR
		    update ah_det_cheq_cm 
               set dc_estado='E'
               where dc_nom_archivo   = @i_archivo_det_chq
                       and dc_sec_dep = @w_tr_secuencial
                       and dc_estado  in ('V', 'P')
					   
		                 
            --INSERTO EN LOG
            			
			insert into ah_log_cm_tran (lc_nom_archivo , lc_ejecucion, lc_sec_tran, lc_sec_chq, lc_ssn, lc_num_error, lc_mensaje_error ,lc_fecha)
            select @i_archivo_det_chq,@w_ejecucion_dchq,@w_tr_secuencial,dc_sec_chq,@w_ssn,@w_return,@w_mensaje,@i_fecha                     
            from ah_det_cheq_cm 
            where dc_nom_archivo = @i_archivo_det_chq
              and dc_sec_dep     = @w_tr_secuencial
              and dc_estado      = 'E'  
			
            if @@error <> 0
            begin
               select  @w_mensaje   = 'ERROR AL INSERTAR EN LOG DE ERRORES',
                       @w_cod_error =499999
			   --rollback tran
               goto ERROR
            end
		end
		
    end
    select @w_indice = @w_indice + 1    
end

----
--Obtener bcp del log de errores

--PARAMETRO S_APP
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and pa_nemonico = 'S_APP'

--RUTA DEL ARCHIVO
select @w_path = @i_ruta 

if exists(select 1
            from   sysobjects
            where  name = 'tmp_ah_log_cm')
    drop table tmp_ah_log_cm

create table tmp_ah_log_cm(
    tlc_nom_archivo   varchar(100) not null,   
	tlc_ejecucion     int not null,
    tlc_sec_tran      int not null,
	tlc_sec_chq       int null,
	tlc_ssn           int null,
    tlc_num_error     int not null,
    tlc_mensaje_error varchar(100) not null,
	tlc_fecha         datetime
)

insert into tmp_ah_log_cm
select lc_nom_archivo, lc_ejecucion, lc_sec_tran, lc_sec_chq, lc_ssn, lc_num_error, lc_mensaje_error, lc_fecha 
from ah_log_cm_tran
where (lc_nom_archivo = @i_archivo_tran    and lc_ejecucion = @w_ejecucion_tran)
  or  (lc_nom_archivo = @i_archivo_det_chq and lc_ejecucion = @w_ejecucion_dchq)
order by lc_sec_tran

select @w_return = 0

select @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_ahorros..tmp_ah_log_cm out '
                 + @w_path
                 + @i_archivo_tran + '_'+convert(varchar(10),@w_ejecucion_tran)+ '.log -c -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'
		
if @w_comando is null
begin
	select 	@w_cod_error 	= 357025,
			@w_mensaje		= NULL
	goto ERROR 
end

exec @w_return = master..xp_cmdshell @w_comando,no_output

if @w_return > 0
begin
	select 	@w_cod_error 	= 357023,
			@w_mensaje		= 'ERROR AL EJECUTAR BCP DE LA TABLA (ah_log_cm_tran)'
	goto ERROR
end

drop table tmp_ah_log_cm

return 0

ERROR:
  exec sp_errorlog
       @i_fecha       = @i_fecha,
       @i_error       = @w_cod_error,
       @i_usuario     = 'batch',
       @i_tran        = 0,
       @i_descripcion = @w_mensaje,
       @i_programa    = @w_sp_name
  
  return @w_cod_error

go

