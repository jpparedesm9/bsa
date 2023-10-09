/********************************************************************/
/*  Archivo:            creactah.sp                                 */
/*  Stored procedure:   sp_crea_num_ctah_mig                        */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas de Ahorros                          */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura: 01-Mar-1993                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa realiza la generacion del numero de cuenta        */
/*  de ahorros tanto del banco como el interno del sistema.         */
/********************************************************************/
/*                       MODIFICACIONES                             */
/*  FECHA          AUTOR          RAZON                             */
/*  31/Agos/2016    P. Mena        Emision inicial                   */
/********************************************************************/

use cob_externos
go

if exists (select * from sysobjects where name = 'sp_crea_num_ctah_mig')
drop proc sp_crea_num_ctah_mig
go


create proc sp_crea_num_ctah_mig (
@t_debug            char(1) = 'N',
@t_file             varchar(14) = null,
@t_from             varchar(32) = null,
@i_atm             char(1) = 'N'
)
as

    declare @w_return    int,
    @w_sp_name           varchar(30),
    @w_cta_sec           int,
    @w_cuenta            int,
    @w_cuenta_mig        int, 
    @w_producto          int ,
    @w_prodbanc          int, 
    @w_cli               int, 
    @w_mon               tinyint  , 
    @w_filial            smallint, 
    @w_ofi               smallint,
    @w_cta_banco         cuenta,
    @w_banco             cuenta,
    @w_conteo            int,
    @w_maximo            int,
    @w_minimo            int
    

     select @w_conteo = count(1)
     from   ah_cuenta_mig
     where  ah_estado_mig = 'VE'

     if @w_conteo = 0  return 0

    --Captura del nombre del Store Procedure 
    
    select @w_sp_name = 'sp_crea_num_ctah_mig',
    @w_maximo = (select count(*) from ah_cuenta_mig where ah_estado_mig = 'VE'),
    @w_minimo = 0 ,
    @w_cta_sec =0

    --delete from ah_numero_cuenta
    truncate table ah_numero_cuenta
        
    while  @w_cta_sec < @w_maximo
    begin
     
     select @w_cuenta_mig = cm.ah_cuenta, @w_producto = cm.ah_producto, @w_banco = cm.ah_cta_banco,
            @w_prodbanc = cm.ah_prod_banc,   @w_cli = cm.ah_cliente, 
            @w_mon = cm.ah_moneda, @w_filial= cm.ah_filial, @w_ofi = cm.ah_oficina
     from ah_cuenta_mig cm where not exists (select 1 from ah_numero_cuenta nc where  nc.nc_cuenta_mig = cm.ah_cuenta and nc.nc_cta_banco_mig = cm.ah_cta_banco)   
     and ah_estado_mig = 'VE'
     order by cm.ah_cuenta desc
    
      exec @w_return = cob_ahorros..sp_crea_num_ctah
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_cli        = @w_cli,
      @i_filial     = @w_filial,
      @i_oficina    = @w_ofi,
      @i_producto   = @w_producto,
      @i_tipo_cta   = @w_prodbanc,
      @i_mon        = @w_mon,
      @o_cuenta_int = @w_cuenta out,
      @o_cta_banco  = @w_cta_banco out
      if @w_return <> 0
       begin
         return @w_return
       end       
     
         -- print ' @o_cta_banco %1!, @o_cuenta_int %2!', @o_cta_banco, @o_cuenta_int
        insert into ah_numero_cuenta 
        values(@w_cta_sec, @w_cuenta, @w_cta_banco, @w_cuenta_mig, @w_banco)
        
        select @w_cta_sec = @w_cta_sec + 1
        
       
    end
    
    return 0
    
go
