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
/*                        MOFICACIONES                                  */
/* 24/07/2018    SRO    SP generación y validación de referencia OXXO   */
/* 06/11/2019    SRO    Mejora 129659                                   */
/* 07/01/2020    ACH    Caso#133012, no valide la ofi                   */
/* 07/01/2020    AGO    Referencia Generica F1                          */
/************************************************************************/  
use cob_cartera
go


if exists(select 1 from sysobjects where name ='sp_oxxo_gen_ref')
	drop proc sp_oxxo_gen_ref
GO

CREATE proc sp_oxxo_gen_ref(
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
    @i_tipo_tran        char(5),           -- (GL) Garantia Líquida, (PG) Préstamo Grupal, (PI) Préstamo Individual, 
	                                       -- (PR) Precancelación, (CG)Cancelación de Crédito Grupal, (CI)Cancelación de Crédito Individual
	@i_id_referencia    varchar(30),
	@i_monto            money              = null, --valor sugerido a pagar
	@i_monto_desde      money              = null,
	@i_monto_hasta      money              = null,
	@i_fecha_lim_pago   datetime,
	@o_referencia	    varchar(255)       out	
)
as
declare 
@w_error                   int,
@w_sp_name                 varchar(30),
@w_msg                     varchar(255),
@w_referencia_in           varchar(30),
@w_referencia_out          varchar(30),
@w_op_toperacion           varchar(10),
@w_cliente                 int,
@w_tramite                 int,
@w_tipo_tran_corresp       varchar(4),
@w_long_referencia         int,
@w_id_oxxo                 varchar(10),
@w_oficina                 int, --TEMPORAL 129499
@w_tramite_grupal          int  --TEMPORAL 129499


select 
@w_sp_name = 'sp_oxxo_gen_ref',
@w_referencia_out = null,
@w_long_referencia = 14

select @w_id_oxxo = pa_char 
from cobis..cl_parametro
where pa_nemonico = 'IDOXXO'


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

--INICIO MODIFICACION TEMPORAL 129499. Validacion Pago por Sucursal
if @i_tipo_tran in ('GL', 'PG', 'CG') begin
   select @w_oficina = gr_sucursal 
   from cobis..cl_grupo
   where gr_grupo    = convert(int,@i_id_referencia)
   
   if not exists (select 1 from cobis..cl_oficina where of_oficina = @w_oficina) begin
      select @w_tramite_grupal = max(tg_tramite)
	  from cob_credito..cr_tramite_grupal
	  where tg_grupo     = convert(int, @i_id_referencia)
	  
	  select @w_oficina = op_oficina
	  from cob_cartera..ca_operacion 
	  where op_tramite = @w_tramite_grupal  
	  
   end
   
   /* se comenta por el caso #133012
   if not exists (select 1 from ca_corresponsal_oficina where co_oficina_id = @w_oficina) begin
      select 
      @w_error = 70214,
      @w_msg   = 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO'
      goto ERROR_FIN	
   end   
   end else if @i_tipo_tran in ('PI', 'CI')  begin
   select @w_oficina   = op_oficina
   from   cob_cartera..ca_operacion 
   where  op_operacion = convert(int,@i_id_referencia)
   
   if not exists (select 1 from ca_corresponsal_oficina where co_oficina_id = @w_oficina) begin    
      select 
      @w_error = 70215,
      @w_msg   = 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO'
      goto ERROR_FIN
   end	*/  
end
--FIN MODIFICACION TEMPORAL 129499. ValidaciÃ³n Pago por Sucursal



select @w_tipo_tran_corresp =  ctr_tipo from cob_cartera..ca_corresponsal_tipo_ref 
where ctr_co_id       = (select co_id from cob_cartera..ca_corresponsal where co_nombre = 'OXXO')
and   ctr_tipo_cobis  = @i_tipo_tran
and   ctr_tipo not in ( 70,71,72)  --EXCLUIR LAS GENERICAS 

select @w_referencia_out = @w_id_oxxo 
                           + rtrim(ltrim(@w_tipo_tran_corresp)) 
                           + rtrim(ltrim(dbo.LlenarI(@i_id_referencia, '0', (@w_long_referencia - (len(@w_tipo_tran_corresp) + len(@w_id_oxxo) +1))))) 
select @w_referencia_out = @w_referencia_out + convert(char(1),dbo.fn_base10(@w_referencia_out))
select @o_referencia = @w_referencia_out 

return 0

ERROR_FIN:

--exec cobis..sp_cerror 
--    @t_from = @w_sp_name, 
--    @i_num  = @w_error, 
--    @i_msg  = @w_msg
return @w_error

go
