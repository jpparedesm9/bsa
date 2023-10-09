   /*vpn.sp*****************************************************************/
/*      Archivo:                vpn.sp                                  */
/*      Stored Procedure:       sp_vpn                                  */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Luis Castellanos                        */
/*      Fecha de escritura:     19/JUL/2007                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA" del Ecuador.                                           */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Calculo del Valor Presente Neto (VPN)                           */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    19/Jul/07             LCA                   Revision indices      */
/*    21/Ene/19             SRO                   Mejoras               */
/************************************************************************/
use cob_cartera
go

if exists (select * from sysobjects where name = 'sp_vpn')
   drop proc sp_vpn
go


create proc sp_vpn(
   @i_operacionca         int,
   @i_monto               money=NULL,
   @i_tdivi               smallint=NULL,
   @i_tasa                float,
   @i_des_seg             char(1)=NULL,
   @i_deuda               money=NULL,
   @i_periodica           char(1) = 'S',
   @i_fecha_desde         datetime=NULL,
   @i_seguro              money  = 0,
   @o_vpn                 float out
)  
as

declare
   @w_intentos             int,
   @w_vp                   float,
   @w_vpn                  float,
   @w_monto                money,
   @w_dividendo            smallint,
   @w_cuota                money,
   @w_tdivi                smallint,
   @w_tasa                 float,
   @w_proporcion           float,
   @w_aux                  float,
   @w_int_proporcion       float,
   @w_cap_proporcion       float,
   @w_pagado               money,
   @w_int                  money,
   @w_int_pag              money,
   @w_pdias                int,
   @w_fecha_ven            datetime

select @w_proporcion = 0, @w_aux = 0, @w_int_proporcion = 0, @w_cap_proporcion = 0
select @w_vpn = -1 * @i_monto
select @w_dividendo = 0

while 1= 1 begin 

   select top 1
   @w_dividendo = dct_dividendo,
   @w_fecha_ven = dct_fecha_vencimiento, 
   @w_cuota     = sum(dct_cuota + dct_gracia), 
   @w_pagado    = sum(dct_pagado)
   from ca_dividendo_concepto_tmp
   where (dct_concepto in ('CAP','INT','COM')) 
   and   dct_operacion = @i_operacionca
   and   dct_dividendo > @w_dividendo   
   group by  dct_dividendo, dct_fecha_vencimiento
   order by  dct_dividendo asc

   if @@rowcount = 0 break

  
   select 
   @w_int      = sum(dct_cuota + dct_gracia),
   @w_int_pag =  sum(dct_cuota)
   from ca_dividendo_concepto_tmp
   where dct_dividendo = @w_dividendo
   and dct_concepto  = 'INT'

      if @w_proporcion = 0 select @w_int_proporcion = 0
      else select @w_int_proporcion = @w_cap_proporcion * @w_int/@w_proporcion

      if @i_des_seg = 'A'
         select @w_cuota = @w_cuota - @w_int_pag
   
  
   if @i_periodica = 'S'
      select @w_vp  = convert(float,@w_cuota-@w_cap_proporcion-@w_int_proporcion)*power(1+@i_tasa*1.00,-1*(@w_dividendo))
   else begin
      select @w_pdias = datediff(dd,@i_fecha_desde, @w_fecha_ven)
      select @w_vp  = convert(float,@w_cuota-@w_cap_proporcion-@w_int_proporcion)*power(1+@i_tasa*1.00,-1*(@w_pdias))
   end
   
   select @w_vpn = @w_vpn + @w_vp
   
   select @w_aux = @w_aux + @w_cap_proporcion + @w_int_proporcion

end

select @o_vpn = @w_vpn
return 0
go





