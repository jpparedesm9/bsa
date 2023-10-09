/************************************************************************/
/*  Archivo           : ct_paso_def.sp                                  */
/*  Stored procedure  : sp_ct_paso_def                                  */
/*  Base de datos     : cob_pfijo                                       */
/*  Producto          : Plazo Fijo                                      */
/*  Disenado por      : Esteban Moran                                   */
/*  Fecha de escritura: 28-Sept-2016                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la generacion masiva comprobantes contable    */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA         AUTOR             RAZON                               */
/*  28-Sept-2016  Esteban Moran     Emisión Inicial                     */
/************************************************************************/

use cob_pfijo
go

if exists (select 1
           from sysobjects
           where name = 'sp_ct_paso_def')
    drop proc sp_ct_paso_def
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_ct_paso_def(
    @t_show_version bit = 0,
    @i_param1       tinyint,    --Filial
    @i_param2       int         --Producto
)
as
declare @w_return      int,
        @w_sp_name     varchar(30),
        @w_mensaje_err varchar(100)

    select @w_sp_name = 'sp_ct_paso_def'

    ----------------------- VERSIONAMIENTO DEL PROGRAMA -----------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure = ' + @w_sp_name + ', Version = ' + '4.0.0.0'
        return 0
    end
    ---------------------------------------------------------------------------

    exec @w_return = cob_conta..sp_sasiento_val
         @i_operacion = 'V',---(Validaciones)
         @i_empresa   = @i_param1,
         @i_producto  = @i_param2

    if @w_return <> 0
    begin
        select @w_mensaje_err = mensaje
        from   cobis..cl_errores
        where  numero = @w_return

        if @w_mensaje_err = null
            select @w_mensaje_err = 'ERROR EN VALIDACION PASO A DEFINITIVAS'

        print 'ERROR:' + @w_mensaje_err
        
        exec cobis..sp_cerror
             @i_num = 353016
        
        return 353016
    end

    ---------------------------------------------------------------
    ---- Actualiza registros Errorneos en tabla pf_transaccion ----
    ---------------------------------------------------------------
    begin tran

        print '****Inicia Actualizacion ERROR-PFI ****'
        update cob_pfijo..pf_transaccion
            set tr_estado = 'ERR'
            from cob_ccontable..cco_error_conaut,
                cob_remesas..re_trn_contable
            where  ec_empresa	  = @i_param1
            and    ec_producto	  = 14
            and    tr_fecha_mov   =  ec_fecha_conta
            and    tr_comprobante = ec_comprobante

        if @@error <> 0
        begin
            print ' ERROR: No actualizo la tabla re_total Ctacte'
            exec cobis..sp_cerror
                 @i_num = 203035
            return 203035
        end

    commit tran
    return 0
    

go
