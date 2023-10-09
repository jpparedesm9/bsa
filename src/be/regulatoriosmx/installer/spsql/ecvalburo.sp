/*************************************************************************/
/*   Archivo             :       ecvalburo.sp                            */
/*   Stored procedure    :       sp_buro_credito                         */
/*   Base de datos       :       cob_conta_super                         */
/*   Producto            :       REC                                     */
/*   Disenado por        :                                               */
/*   Fecha de escritura  :       Julio 2017                              */
/*************************************************************************/
/*                                IMPORTANTE                             */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      'Cobiscorp', representantes exclusivos para el Ecuador de la     */
/*      'NCR CORPORATION'.                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de Cobiscorp o su representante.           */
/*************************************************************************/
/*                             PROPOSITO                                 */
/*   Este programa genera la estimacion de provisiones por tipo de oper  */
/*************************************************************************/
/*                          MODIFICACIONES                               */
/*   Jorge Salazar          12/Jul/2017      CGS-S115717                 */
/*   Sandra Echeverri       31/Jul/2017      CGS-113134 calcular variable*/
/*                                           %MTOSDO                     */
/*   Darío Cumbal           16/Feb/2018      Cambios de validación       */
/*   srojas                05-07-2019       Reestructuración Buro histórico */
/*************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_buro_credito')
   drop proc sp_buro_credito
go

create proc sp_buro_credito (
   @i_cliente           int,
   @i_tipo              catalogo,
   @i_saldo             money,             --CORRESPONDE AL VALOR DEL do_saldo DE LA OPERACION 
   @i_monto_pagar       money,             --CORRESPONDE AL VALOR DE LA CUOTA do_valor_cuota
   @i_meses_vto         float,               --CORRESPONDE AL MAX @w_unidad_atraso_max DE LA ESTIMACION DE PROVISION      
   @i_fecha_proceso     datetime,          
   @i_antiguedad        int,               --ANTIGUEDAD DEL CLIENTE EN MESES
   @i_param_mtosdo      float,             --CORRESPONDE AL PARAMETRO DE MTOSDO INDIVIDUAL
   @i_param_antiguedad  int,               --CORRESPNDE AL PARAMETRO DE ANTIGUEDAD CLIENTE
   @i_param_ncliclo4    int,
   @i_param_num_int4    int,
   @i_param_ncliclo6    int,
   @i_param_num_int6    int,
   @i_numero_ciclos     int,
   @i_num_integrantes   int,   
   @o_riesgo            catalogo = null out,         
   @o_meses             int      = null out
)
as

declare 
   @w_mtosdo            float,
   @w_saldo_actual      money,
   @w_monto_pagar       money,
   @w_fecha             datetime,       --FECHA MAX PARA ID LOS REG A TENER EN CUENTA
   @w_forma_pago        catalogo,
   @w_fecha_proc        varchar(8)  
   

if @i_tipo  = 'INDIVIDUAL' begin  
--SACAR FECHA MAX  PARA IDENTIFICAR LOS REGISTROS A TENER EN CUENTA
select @w_fecha = isnull(max(ib_fecha), '01/01/1900') 
from cob_credito..cr_interface_buro
where ib_cliente   = @i_cliente 
and   ib_estado    = 'V'
and   ib_fecha    <= @i_fecha_proceso          

--CONVERTIR FECHA 
select @w_fecha_proc = replace( (convert(varchar(10), @w_fecha, 101)), '/' , '') 

if @w_fecha = '01/01/1900' begin
   select 
   @o_riesgo = 'MEDIO',
   @o_meses  = 13   
   
   return 0
   
end

--SACAR EL SALDOS
select 
@w_saldo_actual = sum(isnull(try_cast(bc_saldo_actual as money),0)),
@w_monto_pagar  = sum(isnull(try_cast(bc_monto_pagar as money),0)),
@w_forma_pago   = max(bc_forma_pago_actual)
from cob_credito..cr_buro_cuenta, cob_credito..cr_interface_buro
where  bc_ib_secuencial      = ib_secuencial 
and    ib_cliente            = @i_cliente
and    ib_estado             = 'V'
--and    bc_fecha_apertura_cuenta =  @w_fecha_proc 

if (isnull(@w_saldo_actual,0) + @i_saldo)  <> 0  begin
   ---%MTOSDO se calcula como el resultado de dividir Monto a Pagar / Saldo reportado del buro      
   select  @w_mtosdo =  (isnull(@w_monto_pagar,0) + @i_monto_pagar )/ (isnull(@w_saldo_actual,0) + @i_saldo)   
end else begin
   select  @w_mtosdo =  0
end
select @o_riesgo = case 
                   when @w_mtosdo >= @i_param_mtosdo and @i_antiguedad <= @i_param_antiguedad then 'ALTO' 
                   when @w_mtosdo <= @i_param_mtosdo and @i_antiguedad  > @i_param_antiguedad then 'BAJO' 
                   else 'MEDIO'
                   end

select @o_meses  = case 
                   when @w_forma_pago in ('UR','00','01')      then 0
                   when @w_forma_pago in ('02')                then 1
                   when @w_forma_pago in ('03')                then 2
                   when @w_forma_pago in ('04')                then 3
                   when @w_forma_pago in ('05')                then 4
                   when @w_forma_pago in ('06')                then 5
                   when @w_forma_pago in ('07')                then 6
                   when @w_forma_pago in ('96','97','99')      then 12
                   end             


/* SI EL VENCIMIENTO DEL PRESTAMO ACTUAL ES MAYOR QUE EL DEL BURO TOMAMOS EL VENCIMIENTO ACTUAL */
if @i_meses_vto > @o_meses 
   select @o_meses = @i_meses_vto 

end 
if @i_tipo = 'GRUPAL' begin
select @o_riesgo = case 
                   when @i_numero_ciclos <= @i_param_ncliclo4 and @i_num_integrantes <= @i_param_num_int4 then 'ALTO' 
                   when @i_numero_ciclos  > @i_param_ncliclo6 and @i_num_integrantes  > @i_param_num_int6 then 'BAJO' 
                   else 'MEDIO'
                   end	

select @o_riesgo

end

return 0

go
