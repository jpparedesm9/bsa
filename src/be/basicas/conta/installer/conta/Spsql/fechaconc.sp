/************************************************************************/
/*  Archivo:                         co_conci.sp                        */
/*  Stored procedure:                sp_conciliacion                    */
/*  Base de datos:                   cob_ conta                         */
/*  Producto:                        Contabilidad                       */
/*  Disenado por:                    Jose Rafael Molano Z.              */
/*  Fecha de escritura:              Mayo de 2008                       */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  */
/**/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*                                                                      */
/************************************************************************/
use cob_conta
go
if exists (select 1 from sysobjects where name = 'sp_fechaconc' and xtype = 'P')
    drop proc sp_fechaconc
go

create proc sp_fechaconc
(
   @t_trn                smallint = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_empresa            tinyint  = null,
   @i_estado             char(1)  = null,
   @i_fecha              datetime  = null,
   @i_banco              char(3),
   @i_formato_fecha      tinyint
)
as
declare 
        @w_sp_name   varchar(20)
   
select @w_sp_name = 'sp_fechaconc'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6430 and @i_operacion = 'Q') or
   (@t_trn <> 6431 and @i_operacion = 'U')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
--    @t_debug = @t_debug,
--    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end

if @i_operacion = 'Q'
begin
    set rowcount 20
    
    if @i_modo = 0
    begin
        select 
        'EMPRESA' = fc_empresa, 
        'BANCO'   = fc_banco,   
        'FECHA'   = convert(varchar(10),fc_fecha,@i_formato_fecha),   
        'ESTADO'  = fc_estado
        from cob_conta_tercero..cb_fecha_conciliacion
        where fc_banco = @i_banco
        and   fc_estado = @i_estado
        and   (fc_fecha = @i_fecha or @i_fecha is NULL)
        and   fc_empresa = @i_empresa
        order by fc_fecha
    end
    if @i_modo = 1
    begin
        select 
        'EMPRESA' = fc_empresa, 
        'BANCO'   = fc_banco,   
        'FECHA'   = convert(varchar(10),fc_fecha,@i_formato_fecha),   
        'ESTADO'  = fc_estado
        from cob_conta_tercero..cb_fecha_conciliacion
        where fc_banco = @i_banco
        and   fc_estado = @i_estado
        and   fc_fecha > @i_fecha
        and   fc_empresa = @i_empresa
        order by fc_fecha
    end
end

if @i_operacion = 'U'
begin
    update cob_conta_tercero..cb_fecha_conciliacion
    set fc_estado = @i_estado
    where fc_banco = @i_banco
    and   fc_fecha = @i_fecha
    and   fc_empresa = @i_empresa    
    
    if @@error <> 0 or @@rowcount = 0
    begin
        print 'Registro no pudo ser actualizado'
        return 1
    end
end

return 0

go