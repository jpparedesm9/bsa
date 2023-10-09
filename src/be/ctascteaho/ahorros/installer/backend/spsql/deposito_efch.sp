/************************************************************************/
/*  Archivo:            deposito_efch.sp                                */
/*  Stored procedure:   sp_reg_deposito_efch                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Tania Baidal                                    */
/*  Fecha de escritura: 13-Sep-2016                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa registra los datos de deposito y detalle de cheques.  */
/*  en estructuras que son accedidas por el proceso de deposito         */
/*  C = Cabecera del deposito                                           */
/*  D = Detalle de cheques                                              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR            RAZON                                */
/*  13/Sep/2016   T. Baidal        Emision inicial                      */
/************************************************************************/

use cob_interfase
go

if exists (select  1
           from   sysobjects
           where  name = 'sp_reg_deposito_efch')
    drop proc sp_reg_deposito_efch
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_reg_deposito_efch
(
    @s_ssn            int,
    @s_ssn_branch     int,
    @s_ofi            smallint,
    @s_user           varchar(30),
    @s_term           varchar(10),
    @s_srv            varchar(30),
    @s_date           datetime,
    @s_rol            smallint,
    @s_org            char(1)     = 'U',  
    @t_corr           char(1)     = 'N',
    @t_ssn_corr       int         = null,
    @t_show_version   bit         = 0,
    @t_trn            int,
    
    @i_filial         int         = 1,
    @i_operacion      char(1),    -- C = Cabecera de Deposito, D = Detalle de cheque
    @i_fecha          datetime,
    @i_mon            tinyint     = null,
    
    --Cabecera de Deposito
    @i_cta_banco      cuenta      = null,
    @i_cta_mig        varchar(64) = null,
    @i_efe            money       = 0,
    @i_prop           money       = 0,
    @i_loc            money       = 0,
    @i_total          money       = 0,
    @i_plaz           money       = 0,
    @i_remesas        char(1)     = null,
    @i_ActTot         char(1)     = 'N',
    @i_canal          tinyint     = 4,
    
    --Detalle de cheques
    @i_sec_chq        int         = null,
    @i_cod_banco      smallint    = null,
    @i_cta_chq        varchar(64) = null,
    @i_num_chq        int         = null,
    @i_fecha_emi      datetime    = null,
    @i_valor_chq      money       = null,
    @i_ssn_deposito   int         = null,
    @i_ssn_branch_dep int         = null,
    
    @o_ssn            int out,--Retorno ssn de la cabecera del deposito
    @o_ssn_branch     int out --Retorno ssn branch de la cabecera del deposito
)
as
declare
    @w_sp_name        varchar(30),
    @w_total          money,
    @w_sec_chq        int,
    @w_dias_vigen_ant int,
    @w_dias_vigen_pos int,
    @w_fec_min_chq    datetime,
    @w_fec_max_chq    datetime
 /*@w_ah_prod_ban     int,
    @w_ofi_matriz      int,
    @w_nombre_bco      varchar(64),
    @w_monto           money,
    @w_remesas         char(1)
   
    */
    
select @w_sp_name = 'sp_reg_deposito_efch',
       @w_total   = 0

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
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


--INSERCION DE CABECERA DE DEPOSITO

if @i_operacion = 'C'
begin
    --VALIDACION DE CAMPOS DEL DEPOSITO QUE NO SEAN NULOS
    --SECUENCIAL DE CHEQUE REPETIDO
		
    if exists (select 1
                     from cob_ahorros..ah_transacciones_cm
                     where tr_servicio    = 'S'
					   and tr_secuencial  = @s_ssn)
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357056,     
        @i_sev    = 0
        return 357056
    end
    
    if @i_cta_banco is null and @i_cta_mig is null
    begin 

       exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 101127,
         @i_sev   = 0
       return 101127
    end
        
    select @w_total = isnull(@i_efe,0)  + isnull(@i_loc,0) + isnull(@i_prop,0) + isnull(@i_plaz,0)
	
    if @w_total <= 0
    begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 357031
         return 357031
    end


	if isnull(@i_total, 0) <>  @w_total
    begin
        exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 357044
         return 357044
    end
   
    if @i_fecha is null
    begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357045
        return 357045
    end
      
    if @i_filial is null
    begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357046
        return 357046
    end



	--ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO
	if @i_remesas is not null and (isnull(@i_loc,0) <> 0 or isnull(@i_prop,0) <> 0 or isnull(@i_plaz,0) <> 0 ) 
	begin
	    exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 357042
         return 357042
	end
	--ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO DE ORIGEN DE REMESAS
	else if @i_remesas is not null 
        and  not exists (select 1
                               from cobis..cl_catalogo c, cobis..cl_tabla  t
                               where c.tabla = t.codigo 
							   and t.tabla = 'ah_ori_remesas'
							   and c.codigo = upper(@i_remesas)
                        )
    begin
       exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 357041
         return 357041
    end
	
    ------------------------------------
    insert into cob_ahorros..ah_transacciones_cm(tr_nom_archivo, tr_secuencial, tr_transaccion, tr_cta_cobis, 
                                   tr_cta_mig, tr_monto_efe, tr_monto_chq, tr_fecha_carga, tr_remesas,
                                   tr_estado, tr_moneda, tr_total, tr_ssn_branch,
                                   tr_ofi, tr_user, tr_term, tr_corr, 
                                   tr_ssn_corr, tr_srv, tr_date, tr_rol, 
                                   tr_org, tr_num_ejecucion, tr_servicio)
                            values (@s_ssn, @s_ssn, 'DE', @i_cta_banco, 
                                    @i_cta_mig, @i_efe, @i_loc, @i_fecha, upper(@i_remesas),
                                    'V', @i_mon, @i_total, @s_ssn_branch,
                                    @s_ofi, @s_user, @s_term, @t_corr,
                                    @t_ssn_corr, @s_srv, @s_date, @s_rol, 
                                    @s_org, 1, 'S')
    if @@error <> 0
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357043,     
        @i_sev    = 0
        return 357043
    end
    
    select @o_ssn = @s_ssn, @o_ssn_branch = @s_ssn_branch
        
end

if @i_operacion = 'D'
begin

    if @i_ssn_deposito is null or @i_ssn_branch_dep is null
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357047,     
        @i_sev    = 0
        return 35704
    end
	
	if not exists (select 1
                     from cob_ahorros..ah_transacciones_cm
                     where tr_servicio    = 'S'
					   and tr_secuencial  = @i_ssn_deposito
					   and tr_ssn_branch  = @i_ssn_branch_dep
                       and tr_estado      = 'V')
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357054,     
        @i_sev    = 0
        return 357054
    end
	
	
	if @i_fecha is null
    begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357045
        return 357045
    end
	
	
	if @i_sec_chq is null
	begin
	    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357049
        return 357049
	end
	
	if @i_cod_banco is null
	begin
	    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357050
        return 357050
	end
	
    if @i_cta_chq is null
	begin
	    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357051
        return 357051
	end
	
    if @i_num_chq is null
	begin
	    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357052
        return 357052
	end
	
    if @i_fecha_emi is null
	begin
	    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 357053
        return 357053
	end
        
    --VALIDACIONES DEL CHEQUE
    --VALIDACION DEL MONTO DEL CHEQUE
    if isnull(@i_valor_chq, 0) <= 0
    begin
            exec cobis..sp_cerror
            @t_from   = @w_sp_name,
            @i_num    = 357031,     
            @i_sev    = 0
            return 357031
    end
  

    --SECUENCIAL DE CHEQUE REPETIDO
    if exists (select 1
               from cob_ahorros..ah_det_cheq_cm
               where dc_servicio     = 'S'
				 and dc_sec_dep      = @i_ssn_deposito
				 and dc_sec_chq_aux  = @i_sec_chq)
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357040,     
        @i_sev    = 0
        return 357040
    end
    
	--DATOS DEL CHEQUE REPETIDO
    if exists (select 1
                     from cob_ahorros..ah_det_cheq_cm
                     where dc_servicio   = 'S'
					   and dc_sec_dep    = @i_ssn_deposito
					   and dc_cod_ban    = @i_cod_banco
                       and dc_cuenta_chq = @i_cta_chq
                       and dc_num_chq    = @i_num_chq				   
                       )
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357040,     
        @i_sev    = 0
        return 357040
    end
	
    --FECHA MINIMA ANTERIOR
    select @w_dias_vigen_ant = pa_int 
    from cobis..cl_parametro
    where pa_nemonico = 'DVCH'
      and pa_producto = 'CTE'
      
    if @w_dias_vigen_ant is not null  
    begin 
        select @w_fec_min_chq = dateadd( dd, -@w_dias_vigen_ant,@i_fecha)
        
        if @i_fecha_emi  < @w_fec_min_chq
        begin
            exec cobis..sp_cerror
            @t_from   = @w_sp_name,
            @i_num    = 357039,     
            @i_sev    = 0
            return 357039
        end
    end

    --FECHA MAXIMA DE VIGENCIA
    select @w_dias_vigen_pos = pa_int 
    from cobis..cl_parametro
    where pa_nemonico = 'DFMCH'
      and pa_producto = 'CTE'
      
    if @w_dias_vigen_pos is not null  
    begin 
        select @w_fec_max_chq = dateadd( dd, @w_dias_vigen_pos,@i_fecha)
        
    
        if @i_fecha_emi  > @w_fec_max_chq
        begin
            exec cobis..sp_cerror
            @t_from   = @w_sp_name,
            @i_num    = 357039,     
            @i_sev    = 0
            return 357039
        end
    end

    --EL CODIGO DEL BANCO DEL CHEQUE NO ES VALIDO
    if @i_cod_banco not in (select ba_banco from cob_remesas..re_banco)
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357037,     
        @i_sev    = 0
        return 357037
    end
    
    --NUMERO DE DEPOSITO DEL CHEQUE NO SE ENCUENTRA EN EL ARCHIVO DE TRANSACCIONES
    if @i_ssn_deposito not in (select tr_secuencial 
                         from cob_ahorros..ah_transacciones_cm
                         where tr_servicio = 'S'
                         and tr_transaccion = 'DE'
                         and tr_estado = 'V')                           
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357030,     
        @i_sev    = 0
        return 357030
    end

    --------------------------------------
        
    select @w_sec_chq = isnull(max (dc_sec_chq), 0) + 1
    from cob_ahorros..ah_det_cheq_cm
    where dc_sec_dep = @i_ssn_deposito
    
    
    --INSERCION DE DETALLE DE CHEQUE
    insert into cob_ahorros..ah_det_cheq_cm (dc_nom_archivo, dc_sec_dep, dc_sec_chq, dc_sec_chq_aux,
                                dc_cod_ban, dc_cuenta_chq, dc_num_chq, dc_monto, 
                                dc_fecha_emi, dc_fecha_carga, dc_estado, dc_ssn_branch_dep,
                                dc_ssn, dc_ssn_branch, dc_ofi, dc_user,
                                dc_term, dc_corr, dc_ssn_corr, dc_srv,
                                dc_date, dc_rol,    dc_org, dc_num_ejecucion,
                                dc_servicio)
    values (@s_ssn, @i_ssn_deposito, @w_sec_chq, @i_sec_chq,
            @i_cod_banco, @i_cta_chq, @i_num_chq, @i_valor_chq, 
            @i_fecha_emi, @i_fecha, 'V', @i_ssn_branch_dep,
            @s_ssn, @s_ssn_branch, @s_ofi, @s_user,
            @s_term, @t_corr,@t_ssn_corr, @s_srv,
            @s_date, @s_rol, @s_org, 1,
            'S')
                        
    if @@error <> 0
    begin
        exec cobis..sp_cerror
        @t_from   = @w_sp_name,
        @i_num    = 357043,     
        @i_sev    = 0
        return 357043
    end
            
end

return 0

go
