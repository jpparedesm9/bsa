/************************************************************************/
/*   Archivo:             buscacot.sp                                   */
/*   Stored procedure:    sp_buscar_cotizacion                          */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Fabian Quintero                               */
/*   Fecha de escritura:  Ene. 98.                                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Unifica la forma de buscar una cotizacion en la tabla de           */
/*   cotizaciones                                                       */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA              AUTOR             CAMBIOS                    */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_buscar_cotizacion')
    drop proc sp_buscar_cotizacion
go

create proc sp_buscar_cotizacion
                @i_moneda      int,
                @i_fecha       datetime,
                @o_cotizacion  float    out

as

declare @w_rowcount    int

begin
    select @o_cotizacion = convert(float,ct_valor)
    from   cob_conta..cb_cotizacion
    where  ct_moneda = @i_moneda
    and    ct_fecha  = @i_fecha
    select @w_rowcount = @@rowcount
    set transaction isolation level read uncommitted
  
    if @w_rowcount = 0
    begin
        select @o_cotizacion = convert(float,ct_valor)
        from   cob_conta..cb_cotizacion 
        noholdlock
        where  ct_moneda = @i_moneda
        and    ct_fecha  = (select max(ct_fecha) 
                            from   cob_conta..cb_cotizacion noholdlock
                            where  ct_moneda = @i_moneda
                            and    ct_fecha <= @i_fecha)
    end
end
go