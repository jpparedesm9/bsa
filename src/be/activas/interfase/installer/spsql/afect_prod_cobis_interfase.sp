/************************************************************************/
/*      Archivo:                afect_prod_cobis_interfase.sp           */
/*      Stored procedure:       sp_afect_prod_cobis_interfase           */
/*      Producto:               cob_interfase                           */
/*      Disenado por:           Jorge Baque H                           */
/*      Fecha de escritura:     ENE 04 2017                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      SP INTERFASE DE DESACOPLAMIENTO                                 */
/************************************************************************/
/*   FECHA                 AUTOR                RAZON                   */
/* ENE 04/2017             JBA              DESACOPLAMIENTO             */     
/************************************************************************/
use cob_interfase
go
if exists (select 1 from sysobjects where name = 'sp_afect_prod_cobis_interfase')
   drop proc sp_afect_prod_cobis_interfase 
go

create proc sp_afect_prod_cobis_interfase(
   @i_cuenta         cuenta     = null,
   @i_pcobis         int        = null,
   @i_operacion      char       = null,
   @i_instrumento    int        = null,
   @o_ah_cuenta      int        = null out,
   @o_ah_disponible  money      = null out,
   @o_cat_ahorro     char(1)    = null out,
   @o_tipocta        char(1)    = null out,
   @o_rolente        char(1)    = null out,
   @o_tipo_def       char(1)    = null out,
   @o_prod_banc      smallint   = null out,
   @o_producto       char(1)    = null out,
   @o_moneda         tinyint    = null out,
   @o_estado         char(1)    = null out,
   @o_cuenta_int     int        = null out,
   @o_subtipo        int        = null out
)
as
declare @w_error int, 
		@w_sp_name varchar(100),
		@w_msg     varchar(256)
        
select @w_sp_name      =  'sp_afect_prod_cobis_interfase'

if exists(select 1 from cobis..cl_producto where pd_producto = 4)
begin
if @i_pcobis = 4
begin
   select @o_ah_cuenta     = ah_cuenta,
          @o_ah_disponible = ah_disponible,
          @o_cat_ahorro    = ah_categoria,
          @o_tipocta       = ah_tipocta,
          @o_rolente       = ah_rol_ente,
          @o_tipo_def      = ah_tipo_def,
          @o_prod_banc     = ah_prod_banc,
          @o_producto      = ah_producto,
          @o_moneda        = ah_moneda,
          @o_estado        = ah_estado
   from   cob_ahorros..ah_cuenta
   where  ah_cta_banco = @i_cuenta
   and    ah_estado in ('A','G')  --REQ 306 Validacion Monto Apertura

   end
if @i_operacion = 'C'
    begin
          select @o_cuenta_int = cc_ctacte
          from   cob_cuentas..cc_ctacte
          where  cc_cta_banco = @i_cuenta     
          and    cc_estado = 'A'
          
          if @@rowcount <> 1   return 701043
    end
if @i_operacion = 'S'
begin
    select @o_subtipo  =  si_cod_subtipo                                                                                                                                                                                                            
      from  cob_sbancarios..sb_subtipos_ins                                                                                                                                                                                                                                   
      where si_estado           = 'A'
      and   si_cod_producto     =  4
      and   si_cod_instrumento  =  @i_instrumento
end
end
else
begin
	select @w_error = 404000, @w_msg = 'PRODUCTO NO INSTALADO'
    GOTO ERROR
end
return 0
ERROR:
exec cobis..sp_cerror
@t_debug  = 'N',          
@t_file = null,
@t_from   = @w_sp_name,   
@i_num = @w_error,
@i_msg = @w_msg
return @w_error
go

