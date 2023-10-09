/************************************************************************/
/*    Base de datos:            cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Sonia Rojas                             */
/*      Fecha de escritura:     13/09/2017                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Tiene como propósito procesar los pagos de los corresponsales   */
/************************************************************************/  
/*                        MOFICACIONES                                  */
/* 24/07/2018    SRO    Generacion de referencias                       */
/*                      SANTANDER                                       */
/* 15/10/2021    AGO    167050 TRX SOCIO COMERCIAL                      */
/* 09/03/2022    AGO    129517 REF GENERICA f1                          */
/* 14/06/2022    SRO    185234 Garantia Liquida                         */
/*                      Individual                                      */
/************************************************************************/  
use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_santander_gen_ref')
	drop proc sp_santander_gen_ref
GO

CREATE proc sp_santander_gen_ref(
    @s_ssn              int                = null,
    @s_user             login              = null,
    @s_sesn             int                = null,
    @s_term             varchar(30)        = null,
    @s_date             datetime           = null,
    @s_srv              varchar(30)        = null,
    @s_lsrv             varchar(30)        = null,
    @s_ofi              smallint           = null,
    @s_servicio         int                = null,
    @s_cliente          int                = null,
    @s_rol              smallint           = null,
    @s_culture          varchar(10)        = null,
    @s_org              char(1)            = null,
    @i_tipo_tran        char(5)            = null,           -- (GL) Garantia Líquida, (PG) Préstamo Grupal, (PI) Préstamo Individual, 
	                                       -- (PR) Precancelación, (CG)Cancelación de Crédito Grupal, (CI)Cancelación de Crédito Individual
	@i_id_referencia    varchar(30)        = null,
	@i_canal            varchar(30)        = null,   --PROVIENE DE LA B2C PARA GENERAR DISPERSIONES DE UN DIA DE DURACION 
	@i_monto            money              = null, --valor sugerido a pagar
	@i_monto_cap        money              = null, -- para referencias socio comercial
	@i_monto_iva        money              = null, -- para referencias socio comercial
	@i_monto_com        money              = null, -- para referencias socio comercial
	@i_monto_desde      money              = null, 
	@i_monto_hasta      money              = null,
	@i_fecha_lim_pago   datetime		   = null,
	@i_es_conciliacion  char(1)			   = 'N',
	@i_trn_corresp		int				   = null,
	@i_fecha_valor      datetime		   = null,
	@o_referencia	    varchar(255)       = null out,
	@o_fecha_archivo    varchar(15)		   = null out,
	@o_trn_corresponsal varchar(20)		   = null out,
	@o_monto_archivo    money			   = null out
)
as
declare 
@w_error              int,
@w_sp_name            varchar(30),
@w_msg                varchar(255),
@w_referencia_in      varchar(30),
@w_referencia_out     varchar(30),
@w_monto              varchar(20),
@w_fecha              varchar(10),
@w_tipo_tran_corresp  varchar(4)

select @w_sp_name = 'sp_santander_gen_ref'

select @w_referencia_out = null

if @i_es_conciliacion='S'
begin
	select @o_trn_corresponsal =cob_cartera.dbo.LlenarI(convert(varchar(20),@i_trn_corresp), '0', 8)
	select @o_fecha_archivo = convert(varchar(10),@i_fecha_valor,101)
    select @o_fecha_archivo = replace(@o_fecha_archivo,'/','')	
	select @o_monto_archivo = @i_monto * 100 --MTA se corrije la asignacion del monto que ingresa al sp	
	return 0
end


if  @i_tipo_tran <> 'GL'
and @i_tipo_tran <> 'PG'
and @i_tipo_tran <> 'PI'
and @i_tipo_tran <> 'CG'
and @i_tipo_tran <> 'CI'
and @i_tipo_tran <> 'GI' begin
   select 
   @w_error = 70204,
   @w_msg   = 'ERROR: TIPO DE TRANSACCIÓN NO VÁLIDA'
   goto ERROR_FIN
end


select @w_tipo_tran_corresp = ctr_tipo
from   ca_corresponsal
inner join ca_corresponsal_tipo_ref 
on     co_id          = ctr_co_id
where  ctr_tipo_cobis = @i_tipo_tran
and    co_nombre      = 'SANTANDER'
and     ctr_tipo not in ( 70,71,72)

--Referencia Inicial de 14 digitos      
select 
@w_referencia_in = rtrim(ltrim(@w_tipo_tran_corresp)) + dbo.LlenarI(convert(varchar, @i_id_referencia), '0', 12),   
@w_fecha = replace(convert(varchar(10), @i_fecha_lim_pago, 103), '/', '')            --Fecha de Vencimiento/ de la Gar/ Precancelacion de la Op.

if @i_tipo_tran in ('GL', 'CI', 'GI')
begin

   --Genera el archivo xml si hay faltante
   if @i_monto > 0
   begin     

   select @w_monto = dbo.LlenarI(replace(convert(varchar(20), @i_monto), '.', ''), '0', 8)
      exec @w_error = sp_dv_base22
      @i_input = @w_referencia_in,
      @i_monto = @w_monto,
      @i_fecha = @w_fecha,
      @o_output= @w_referencia_out out
      
      if @w_error != 0 return @w_error
   end 

end else if (@i_canal = 'B2C' and @i_tipo_tran = 'PI') begin --TRANSACCION SOCIO COMERCIAL 



   exec @w_error       = sp_lcr_gen_ref 
   @s_user             = @s_user, 
   @s_term             = @s_term,
   @i_id_referencia    = @i_id_referencia,
   @i_monto            = @i_monto, 
   @i_monto_cap        = @i_monto_cap,
   @i_monto_iva        = @i_monto_iva,
   @i_monto_com        = @i_monto_com,
   @i_tipo_tran        = @i_tipo_tran,
   @o_referencia	   = @w_referencia_out out
   
   if @w_error != 0 return @w_error



end else begin
   select @w_referencia_out = @w_referencia_in + convert(varchar,dbo.fn_base10(@w_referencia_in))
end
--print '@w_referencia_out' +@w_referencia_out
select @o_referencia = @w_referencia_out


return 0

ERROR_FIN:

exec cobis..sp_cerror 
    @t_from = @w_sp_name, 
    @i_num  = @w_error, 
    @i_msg  = @w_msg
return @w_error

go