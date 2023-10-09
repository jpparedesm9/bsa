/****************************************************************************/
/*     Archivo:          ahaccupr.sp                                        */
/*     Stored procedure: sp_activa_cta_provisional                          */ 
/*     Base de datos:    cob_ahorros                                        */
/*     Producto:         Ahorros                                            */
/*     Disenado por:     Edwin Jimenez                                      */
/*     Fecha de escritura: 14-Dic-2011                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa se encarga del mantenimiento  de la pantalla de        */
/*     excepciones para topes de retiro de cuentas de ahorro.               */
/****************************************************************************/ 
/*                           MODIFICACIONES                                 */
/*  FECHA          AUTOR           RAZON                                    */
/*  14-Dic-2011    Edwin Jimenez   Emision Inicial                          */
/*  02-May-2016    Ignacio Yupa    Migración a CEN                          */
/*  21-Jul-2016    J.Tagle         Aporte Social Impedir Activación         */
/****************************************************************************/    

use cob_ahorros
go

if exists (select 1 from sysobjects where id = object_id('sp_activa_cta_provisional'))
   drop proc sp_activa_cta_provisional
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_activa_cta_provisional   
   @s_ssn           int,
   @t_debug         char(1) = 'N',
   @t_file          char(1) = NULL,
   @t_show_version  bit = 0,
   @s_user          login   = NULL,
   @s_date          datetime,
   @s_term          varchar(10),
   @s_ofi           smallint,
   @t_trn           smallint,
   @i_operacion     char(1),
   @i_cta_banco     cuenta
   
as
declare 
   @w_sp_name      varchar(32),
   @w_fecha        datetime,
   @w_producto     tinyint,
   @w_cliente      int,
   @w_estado       char(1),
   @w_moneda       money,
   @w_oficina      smallint,
   @w_fecha_aper   datetime,
   @w_prod_banc        smallint,
   @w_cta_asa          smallint,
   @w_cta_aso          smallint   

select @w_sp_name         = 'sp_activa_cta_provisional'
---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
return 0
end

select @w_fecha    = fp_fecha
from cobis..ba_fecha_proceso

/* CONTROL DE TRANSACCION */
if @t_trn <> 4145 
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 201048,     
   @i_sev    = 0
   
   return 201048
end

Select 
@w_estado   = ah_estado,
@w_producto = ah_producto,
@w_cliente  = ah_cliente,
@w_moneda   = ah_moneda,
@w_oficina  = ah_oficina,
@w_fecha_aper = ah_fecha_aper
from cob_ahorros..ah_cuenta 
where ah_cta_banco = @i_cta_banco

if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 201004,  -- Cuenta no existe
   @i_sev    = 0,
   @i_msg = 'Cuenta de Ahorros no existe'
   
   return 201004
end

if @w_estado = 'A'
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 201005,
   @i_sev    = 0,
   @i_msg    = 'La Cuenta de Ahorros ya se encuentra ACTIVA'
   
   return 201005
end

if @w_estado = 'N'
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 201006,
   @i_sev    = 0,
   @i_msg = 'La Cuenta de Ahorros se encuentra ANULADA. No se puede activar'
       
   return 201006
end


/* VALIDA ACTIVACIONES DE CUENTAS */
if @i_operacion = 'A'
begin

	------------------------------------------------------------------------------------------------------------------
	-- Verificación para Prod. Bancacio APORTE SOCIAL no permite activacion sin autorización
	------------------------------------------------------------------------------------------------------------------
	--Buscar Prod Bancario de esa Cuenta
	select @w_prod_banc = ah_prod_banc
	from   cob_ahorros..ah_cuenta
	where  ah_cta_banco = @i_cta_banco	
    -- Producto Final Aporte Social Ordinario
	select @w_cta_aso  = pa_int
	from   cobis..cl_parametro
	where  pa_producto = 'AHO'
	and    pa_nemonico = 'PCAASO'
	-- Producto Final Aporte Social Adicional
	select @w_cta_asa = pa_int
	from   cobis..cl_parametro
	where  pa_producto = 'AHO'
	and    pa_nemonico = 'PCAASA'
	
	if (@w_prod_banc = @w_cta_aso) OR (@w_prod_banc = @w_cta_asa) 
	begin
		/* PRODUCTO BANCARIO NO PERMITE ACTIVACION */		
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 357567
		return 357567	
	end		
	------------------------------------------------------------------------------------------------------------------

   update cob_ahorros..ah_cuenta with(rowlock) set
   ah_estado = 'A',
   ah_dep_ini = 0
   where ah_cta_banco = @i_cta_banco
   and ah_estado  = 'G'
   and ah_oficina = @w_oficina
   and ah_moneda  = @w_moneda

   
   /* INSERTAR TRANSACCION DE SERVICIO */   
   insert into ah_tran_servicio (
   ts_secuencial,  ts_ssn_branch, ts_tipo_transaccion,
   ts_tsfecha,     ts_usuario,    ts_terminal, 
   ts_filial,      ts_oficina,    ts_oficina_cta, 
   ts_hora,        ts_estado,     ts_cta_banco,  
   ts_producto,    ts_descripcion_ec,
   ts_cliente)
   values (
   @s_ssn,         0,             @t_trn,
   @w_fecha,       @s_user,       @s_term,
   1,              @s_ofi,        @s_ofi, 
   getdate(),      'A',           @i_cta_banco,  
   @w_producto,    'ACTIVACION DE CUENTA SIN DEPOSITO INICIAL',
   @w_cliente)
   if @@error <> 0
   begin
       exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 253004
           -- Error Insercion Transaccion de Servicio
       return 253004
    end
   
   if exists(select 1 from ah_tran_servicio
             where ts_cta_banco = @i_cta_banco
             and     ts_tipo_transaccion = 201
             and     ts_oficina_cta =  @w_oficina
             and     ts_moneda = @w_moneda)
   begin            
      update ah_tran_servicio with(rowlock) set
      ts_fecha_ven = getdate(),
      ts_estado = 'A',
      ts_sec_correccion = 0
      where ts_cta_banco = @i_cta_banco
      and     ts_tipo_transaccion = 201
      and     ts_oficina_cta =  @w_oficina
      and     ts_moneda = @w_moneda
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 145005
         -- Error Actualizacion Transaccion de Servicio
         
         return 145005
      end
   end
   else
   begin
      update cob_ahorros_his..ah_his_servicio with(rowlock) set
      hs_fecha_ven = getdate(),
      hs_estado = 'A',
      hs_sec_correccion = 0
      where hs_cta_banco = @i_cta_banco
      and     hs_tipo_transaccion = 201
      and     hs_tsfecha = @w_fecha_aper
      and     hs_oficina =  @w_oficina
      and     hs_moneda = @w_moneda
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 145005
         -- Error Actualizacion Transaccion de Servicio
         
         return 145005
      end
   end
end

return 0


go

