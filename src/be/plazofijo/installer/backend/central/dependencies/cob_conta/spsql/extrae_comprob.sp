/*****************************************************************************/
/*  ARCHIVO:         extrae_comprob.sp                                       */
/*  NOMBRE LOGICO:   sp_extrae_comprobantes                                  */
/*  PRODUCTO:        TODOS                                                   */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Descarga los comprobnantes de la coob_conta_tercero a un archivo plano    */
/*****************************************************************************/
use cob_conta
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_extrae_comprobantes')
   drop proc sp_extrae_comprobantes
go

create proc sp_extrae_comprobantes(
    @t_show_version           bit          = 0,
    @i_param1                 datetime,             -- @i_fecha    
    @i_param2                 varchar(10)  = null,  -- @i_producto 
    @i_param3                 varchar(100) = null,  -- @i_archivo  
    @i_param4                 varchar(300) = null   -- @i_ruta     
)
with encryption
as
declare @w_sp_name          varchar(64),
        @w_s_app            varchar(64),
        @w_comando          varchar(4000),
        @w_path             varchar(350),
        @w_archivo_tran     varchar(100),
        @w_archivo_det_chq  varchar(100),
        @w_error            int,
        @w_mensaje          varchar(150),
        @w_contador         int,
        @w_indice           int,
        @w_contador2        int,
        @w_indice2          int,
        @w_num_eje_tran     int,
        @w_num_eje_chq      int,
        @w_producto         int,
        @w_fecha            datetime,     -- @i_fecha    
        @w_archivo          varchar(100), -- @i_archivo  
        @w_ruta             varchar(300), -- @i_ruta     
        @w_formato_fecha    int
        
    select @w_fecha         = @i_param1,
           @w_archivo       = @i_param3 + '_' + isnull(@i_param2, 'T') + '_' + convert(varchar, @i_param1, 112) + '.txt', 
           @w_ruta          = @i_param4,
           @w_formato_fecha = 101

           
        if isnull(@i_param2, 'T') = 'T'
            select @w_producto = null
        else
            select @w_producto = cast(@w_producto as int)

    -----------------------------------------------------------------------------------------------------------
    -- CAPTURA NOMBRE DE STORED PROCEDURE
    -----------------------------------------------------------------------------------------------------------
    select @w_sp_name   =  'sp_extrae_comprobantes'

    -----------------------------------------------------------------------------------------------------------
    ---- VERSIONAMIENTO DEL PROGRAMA
    -----------------------------------------------------------------------------------------------------------
     if @t_show_version = 1
     begin
         print 'Stored Procedure = ' + @w_sp_name + ', Version = 4.0.0.0'
         return 0
     end
    
    -----------------------------------------------------------------------------------------------------------
    -- PARAMETRO S_APP
    -----------------------------------------------------------------------------------------------------------
    select @w_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
    and pa_nemonico = 'S_APP'

    -----------------------------------------------------------------------------------------------------------
    -- RUTA DEL ARCHIVO
    -----------------------------------------------------------------------------------------------------------
    set nocount on

        -----------------------------------------------------------------------------------------------------------
	    -- TRANSACCIONES
        -----------------------------------------------------------------------------------------------------------
        delete cob_conta_tercero..ct_extrae_compr
        where  ec_producto    = isnull(@w_producto, ec_producto)
        and    ec_fecha_tran  = @w_fecha

        
        
        insert into cob_conta_tercero..ct_extrae_compr
        select 'ec_empresa'        = sc_empresa,
               'ec_fecha_tran'     = convert(varchar, sc_fecha_tran, @w_formato_fecha), 
               'ec_comprobante'    = sc_comprobante, 
               'ec_oficina_orig'   = sc_oficina_orig, 
               'ec_descripcion'    = sc_descripcion, 
               'ec_tot_debito'     = sc_tot_debito, 
               'ec_tot_credito'    = sc_tot_credito, 
               'ec_tot_debito_me'  = sc_tot_debito_me,
               'ec_tot_credito_me' = sc_tot_credito_me, 
               'ec_estado'         = sc_estado,     
               'ec_producto'       = sa_producto,    
               'ec_perfil'         = sc_perfil,       
               'ec_detalles'       = sc_detalles,    
               'ec_asiento'        = sa_asiento,    
               'ec_cuenta'         = sa_cuenta,      
               'ec_oficina_dest'   = sa_oficina_dest,
               'ec_area_dest'      = sa_area_dest,    
               'ec_debito'         = sa_debito,     
               'ec_credito'        = sa_credito,     
               'ec_debito_me'      = sa_debito_me,    
               'ec_credito_me'     = sa_credito_me,  
               'ec_concepto'       = sa_concepto,   
               'ec_cotizacion'     = sa_cotizacion,  
               'ec_moneda'         = sa_moneda
        from   cob_conta_tercero..ct_scomprobante,
               cob_conta_tercero..ct_sasiento  
        where  sc_producto    = sa_producto 
        and    sa_comprobante = sc_comprobante 
        and    sa_empresa     = sc_empresa 
        and    sa_fecha_tran  = sc_fecha_tran
        and    sa_producto    = isnull(@w_producto, sa_producto)
        and    sc_fecha_tran  = @w_fecha
        order  by sc_fecha_tran, sa_producto, sc_comprobante , sa_asiento 
        
        if @@rowcount > 0
        begin
            select @w_comando = @w_s_app + 's_app' + ' bcp -auto -login cob_conta_tercero..ct_extrae_compr out ' + @w_ruta + @w_archivo +  ' -c -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
            -----------------------------------------------------------------------------------------------------------
            -- EJECUTAR CON CMDSHELL
            -----------------------------------------------------------------------------------------------------------
            exec xp_cmdshell @w_comando
        end
        else
        begin
            select @w_mensaje = 'NO HAY REGISTROS EN LA TABLA DE COMPROBANTES',
                   @w_error = 4000003      
             goto ERROR
        end

    return 0

    ERROR:
        exec cobis..sp_cerror
             @t_from = @w_sp_name,
             @i_num  = @w_error,
             @i_msg  = @w_mensaje
        return @w_error

go