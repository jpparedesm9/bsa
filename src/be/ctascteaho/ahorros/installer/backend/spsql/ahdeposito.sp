/*******************************************************************/
/*  Archivo:          ahdeposito.sp                                */
/*  Stored procedure: sp_ahdeposito                                */
/*  Base de datos:    cob_interface                                */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Realiza los depositos en una cuenta de ahorros                  */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 08/Jul/2016          I. Yupa        Emision Inicial             */
/*******************************************************************/

use cob_interfase
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_ahdeposito')
   drop proc sp_ahdeposito
go

create proc sp_ahdeposito 
(
    @p_lssn                int            = null,
    @s_ssn                 int            = null,
    @s_ssn_branch          int            = null, 
    @s_srv                 varchar(30)    = null,
    @s_lsrv                varchar(30)    = null,
    @s_user                varchar(30)    = null,
    @s_sesn                int            = null,
    @s_term                varchar(32)    = null,
    @s_date                datetime       = null,
    @s_ofi                 smallint       = null,
    @s_rol                 smallint       = 1,
    @s_org_err             char(1)        = null,
    @s_error               int            = null,
    @s_sev                 tinyint        = null,
    @s_msg                 varchar(255)   = null,  
    @s_org                 char(1)        = 'U',       
    @t_debug               char(1)        = 'N',
    @t_file                varchar(14)    = null,
    @t_from                varchar(32)    = null,
    @t_rty                 char(1)        = 'N',
    @t_show_version        bit            = 0,   
    @t_trn                 smallint       = 4170,    
    @t_ssn_corr            int            = null,    
    @i_ssn_deposito        int            = null,
	@i_ssn_branch_deposito int            = null,
    @i_canal               tinyint        = 0,
	@i_filial              int            = 1,
	@o_ssn                 int            = null out
)
as
declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_cuenta      cuenta,
	@w_cont_cheques int,
	@w_suma_chqs    money,
	@w_sec_chq      int,
    @w_valor        money,
    @w_cod_banco    int,
    @w_cta_chq      varchar(64),
    @w_num_chq      int,
    @w_fecha_emi    datetime,
	@w_mensaje      varchar(50),
	@w_indice_chq   tinyint,
	@w_nombre_bco   varchar(64),
	
	
	@w_s_ssn        int,   
    @w_s_ssn_branch int,
    @w_s_srv        varchar(30),
    @w_s_user       varchar(30) ,          
    --@w_s_sesn         = @s_sesn,           
    @w_s_term       varchar(32),        
    @w_s_date       datetime,
    @w_s_ofi        smallint,
    @w_s_rol        smallint,
    @w_s_org        char(1),
    @w_t_ssn_corr   int,
	@w_cta_cobis    cuenta,
    @w_cta_mig      varchar(64),
    @w_mon          int,
    @w_val          money,
    @w_loc          money,
    @w_prop         money,
    @w_plaz         money,
    @w_total        money,
    @w_ActTot       char(1),         
    @w_canal        int,  
    @w_remesas      char(1) --Origen del efectivo (L = Local, E = Exterior)   
	
   
/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_ahdeposito', @w_cont_cheques = 0, @w_indice_chq = 0

if @t_show_version = 1
   begin
      print 'Stored procedure sp_ahdeposito, Version 4.0.0.1'
      return 0
   end

/* CONTROL DE TRANSACCION */
if @t_trn <> 4170 
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 201048,     
   @i_sev    = 0
   
   return 201048
end

/*  Activacion del Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug 
	   @t_file=@t_file
    select '/** Store Procedure **/' = @w_sp_name,
       s_ssn          = @s_ssn,
       s_srv          = @s_srv,
       s_lsrv         = @s_lsrv,
       s_user         = @s_user,
       s_sesn         = @s_sesn,
       s_term         = @s_term,
       s_date         = @s_date,
       s_ofi          = @s_ofi,
       s_rol          = @s_rol,
       s_org_err      = @s_org_err,
       s_error        = @s_error,
       s_sev          = @s_sev,
       s_msg          = @s_msg,
       s_org          = @s_org,   
       t_from         = @t_from,
       t_file         = @t_file, 
       t_rty          = @t_rty,
       t_trn          = @t_trn,
       i_canal        = @i_canal,       
       o_ssn          = @o_ssn         
    exec cobis..sp_end_debug
end

select 
    @w_s_ssn          = tr_secuencial,            
    @w_s_ssn_branch   = tr_ssn_branch,     
    @w_s_srv          = tr_srv,         
    @w_s_user         = tr_user,           
    --@w_s_sesn         = @s_sesn,           
    @w_s_term         = tr_term,           
    @w_s_date         = tr_date,           
    @w_s_ofi          = tr_ofi,           
    @w_s_rol          = tr_rol,            
    @w_s_org          = tr_org,         
    @w_t_ssn_corr     = tr_ssn_corr,  
    @w_cta_cobis      = tr_cta_cobis,
	@w_cta_mig        = tr_cta_mig,
    @w_mon            = tr_moneda,
    @w_val            = tr_monto_efe,            
    @w_loc            = tr_monto_chq,            
    @w_prop           = 0,           
    @w_plaz           = 0,           
    @w_total          = tr_total,          
    @w_ActTot         = 'N',         
    @w_canal          = 4,  
    @w_remesas        = tr_remesas --Origen del efectivo (L = Local, E = Exterior)      
from cob_ahorros..ah_transacciones_cm
where tr_servicio    = 'S'
  and tr_secuencial  = @i_ssn_deposito
  and tr_ssn_branch  = @i_ssn_branch_deposito

if @@rowcount = 0
begin
    exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357054,     
        @i_sev    = 0
		
        return 357054
end


if isnull(@w_loc,0) <> 0
begin
    --VALIDA QUE SE ENVÍE UN SECUENCIAL DE DEPOSITO
	if @i_ssn_deposito is null or @i_ssn_branch_deposito is null
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357047,     
        @i_sev    = 0
        return 35704
    end
    
    --OBTIENE NUMERO DE CHEQUES
    select @w_cont_cheques = count(*),
           @w_suma_chqs    = sum(dc_monto)
    from cob_ahorros..ah_det_cheq_cm 
    where dc_servicio    = 'S'
	      and dc_sec_dep = @i_ssn_deposito
          and dc_estado  ='V'
		  
    if @w_cont_cheques <= 0
    begin
	    --NO EXISTEN CHEQUES VALIDOS PARA ESTA TRANSACCION
		exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357048,     
        @i_sev    = 0
		
        return 357048
		
    end
	
	if isnull(@w_suma_chqs,0) <> isnull(@w_loc,0)
	begin
	    --VALOR DEL DEPOSITO EN CHEQUES NO COINCIDE CON SUMA TOTAL DE CHEQUES VALIDOS
        
		exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357032,     
        @i_sev    = 0
		
        return 357032
		
	end
end
else
begin 
    --OBTIENE NUMERO DE CHEQUES
    select @w_cont_cheques = count(*)	
    from cob_ahorros..ah_det_cheq_cm 
    where dc_servicio        = 'S'
	      and dc_sec_dep     = @i_ssn_deposito --41214
          and dc_estado      = 'V'
		  
    if @w_cont_cheques > 0
    begin
	    --VALOR DE CHEQUES NO COINCIDE CON LA SUMA DEL DETALLE DE CHEQUES
		exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357032,     
        @i_sev    = 0
		
        return 357032
		
    end
end

if @w_mon is null
begin
    select @w_mon = pa_tinyint 
    from cobis..cl_parametro 
    where  pa_producto = 'ADM'
    and pa_nemonico = 'CMNAC' 
    if @@rowcount = 0
    begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101254
        return 101254
    end
end
   
   
if @w_cta_cobis is null and @w_cta_mig is null
begin 
   exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 101127
   return 101127
end

if @w_cta_cobis is null
begin
    select @w_cuenta = ca_cta_banco 
    from cob_ahorros..ah_cuenta_aux 
    where ca_cta_banco_mig =@w_cta_mig
     if @@rowcount =0
      begin
          exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 101127
           return 10112
     end
end
else
    select @w_cuenta = @w_cta_cobis
        
		
--SI DEPOSITO TIENE VALOR EN CHEQUES


if @w_cont_cheques > 0
begin
	--SE REGISTRA EL DETALLE DE CHEQUES
    while (@w_indice_chq < @w_cont_cheques)
    begin
        select top 1
           @w_sec_chq   = dc_sec_chq,
           @w_valor     = dc_monto,
           @w_cod_banco = dc_cod_ban,
           @w_cta_chq   = dc_cuenta_chq,
           @w_num_chq   = dc_num_chq,
           @w_fecha_emi = dc_fecha_emi                      
        from cob_ahorros..ah_det_cheq_cm 
        where dc_servicio    = 'S'
          and dc_sec_dep     = @i_ssn_deposito
          and dc_estado      = 'V'
		
    	--SE OBTIENE NOMBRE DEL BANCO
        select @w_nombre_bco = ba_descripcion
        from cob_remesas..re_banco
		where ba_banco = @w_cod_banco
        
        if @w_nombre_bco is null
        begin
            --EL CODIGO DEL BANCO DEL CHEQUE NO ES VALIDO
            exec cobis..sp_cerror
            @t_from   = @w_sp_name,
            @i_num    = 357037,     
            @i_sev    = 0
		    
            return 357037
        end
    	
    	exec @w_return = cob_remesas..sp_detallecheque
               --agregar parametros
               @s_ssn            = @s_ssn,
               @s_ssn_branch     = @s_ssn_branch,
               @s_user           = 'operador',
               @s_term           = 'consola',
               @s_date           = @s_date,
               @s_ofi            = @s_ofi,
               @s_rol            = @s_rol,
               @s_org            = 'U',
               @s_srv            = @s_srv,
               @t_trn            = 639,
               @i_operacion      = 'O',
               @i_ssn_dep        = @s_ssn,
               @i_ssn_branch_dep = @s_ssn_branch,
               @i_filial         = @i_filial,
               @i_cta_banco      = @w_cuenta,
               @i_producto       = 4,
               @i_sec            = @w_sec_chq,
               @i_tipo           = '1',
               @i_co_banco       = @w_cod_banco,
               @i_no_banco       = @w_nombre_bco,
               @i_cta_cheque     = @w_cta_chq,
               @i_num_cheque     = @w_num_chq,
               @i_valor          = @w_valor,
               @i_mon            = @w_mon,
               @i_fechaemision   = @w_fecha_emi,
               @i_estado         = 'I'
        			
        if(@w_return <> 0)
        begin
			exec cobis..sp_cerror
            @t_from   = @w_sp_name,
            @i_num    = 353007,     
            @i_sev    = 1
			
		    goto ERROR_CHQ		
        end			
    
        update cob_ahorros..ah_det_cheq_cm 
            set dc_estado = 'P'
            where dc_servicio = 'S'
                    and dc_sec_dep = @i_ssn_deposito
    				and dc_sec_chq = @w_sec_chq
                    and dc_estado  = 'V'
    	
        select @w_indice_chq = @w_indice_chq + 1		
    end--fin while
end

exec @w_return = cob_ahorros..sp_ah_depositosl
    @p_lssn           = @p_lssn,
    @s_ssn            = @s_ssn,            
    @s_ssn_branch     = @s_ssn_branch,     
    @s_srv            = @s_srv,            
    @s_lsrv           = @s_lsrv,           
    @s_user           = @s_user,           
    @s_sesn           = @s_sesn,           
    @s_term           = @s_term,           
    @s_date           = @s_date,           
    @s_ofi            = @s_ofi,           
    @s_rol            = @s_rol,            
    @s_org_err        = @s_org_err,        
    @s_error          = @s_error,          
    @s_sev            = @s_sev,            
    @s_msg            = @s_msg,            
    @s_org            = @s_org,            
    @t_debug          = @t_debug,          
    @t_file           = @t_file,           
    @t_from           = @t_from,           
    @t_rty            = @t_rty,            
    @t_show_version   = @t_show_version,   
    @t_trn            = 252,            
    @t_ssn_corr       = @t_ssn_corr,       
    @i_cta            = @w_cuenta,            
    @i_mon            = @w_mon,            
    @i_val            = @w_val,            
    @i_loc            = @w_loc,            
    @i_prop           = @w_prop,           
    @i_plaz           = @w_plaz,           
    @i_total          = @w_total,          
    @i_ActTot         = @w_ActTot,         
    @i_canal          = @w_canal,  
    @i_remesas        = @w_remesas, --Origen del efectivo (L = Local, E = Exterior)      
    @o_ssn            = @o_ssn            
   
if @w_return <> 0
begin
    ERROR_CHQ:
    if @w_cont_cheques > 0
    begin
	    --ROLLBACK DEL DETALLE DE CHEQUE
		delete from cob_remesas..re_detalle_cheque
		where dc_ssn        = @i_ssn_deposito
		  and dc_ssn_branch = @i_ssn_branch_deposito
		
		--ACTUALIZACION DEL ESTADO DE CHEQUES A --> ERROR
		update cob_ahorros..ah_det_cheq_cm 
        set dc_estado = 'E'
        where dc_servicio = 'S'
          and dc_sec_dep  = @i_ssn_deposito
          and dc_estado   = 'P'
    end

    return @w_return
  
end
else
begin
    --SE ACTUALIZA EL REGISTRO A PROCESADO
    update cob_ahorros..ah_transacciones_cm
    set tr_estado = 'P'
    where tr_servicio    = 'S'
      and tr_estado      = 'V'
      and tr_transaccion = 'DE'
      and tr_secuencial  = @i_ssn_deposito

end

return 0

go
