/************************************************************************/
/*  Archivo:                sp_estado_cuenta.sp                         */
/*  Stored procedure:       sp_estado_cuenta                            */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 29/Ene/2018                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Permite realizar la generación del reporte de estado de cuenta       */
/* y prepara la informació para el envío del correo                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*29/01/2018   P. Ortiz              Emision Inicial                    */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_estado_cuenta')
	drop proc sp_estado_cuenta
go

create proc sp_estado_cuenta (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1),
   @i_ente            int         = null,
   @i_fecha           datetime    = null,
   @i_tramite         int         = null,
   @i_banco           varchar(15) = null,
   @i_correo          varchar(64) = null,
   @i_estado          char(1)     = null,
   @o_codigo          int         = null  output
   
)as
declare 
   @w_ts_name         varchar(32),
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_codigo          int
   
select @w_sp_name = 'sp_estado_cuenta'

   -- Validar codigo de transacciones --
if ((@t_trn <> 36006 and @i_operacion = 'I') or
    (@t_trn <> 36007 and @i_operacion = 'S'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end


if @i_operacion = 'I'
begin
	begin tran
	exec @w_num_error = cobis..sp_cseqnos
		@t_debug     = @t_debug,
	    @t_file      = @t_file,
	    @t_from      = @w_sp_name,
	    @i_tabla     = 'sb_ns_estado_cuenta',
	    @o_siguiente = @w_codigo out
        
        if @w_num_error <> 0
        begin
            select @w_num_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
            goto errores
        end
        
    select @o_codigo = @w_codigo
    
    
    insert into cob_conta_super..sb_ns_estado_cuenta(
    nec_codigo,         nec_banco,          nec_fecha,          nec_correo,          nec_estado)
    values(
    @w_codigo,          @i_banco,           @i_fecha,           @i_correo,           @i_estado )
	if @@error <> 0
	begin   
		select @w_num_error = 108003 --ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
		goto errores
	end
      
    commit tran
    
    goto fin
end

if @i_operacion = 'S'
begin
    
    if @i_ente = 0 set @i_ente = null
    
    
    set rowcount 20
    
	select 
    	'codigo'			= dc_cliente,
    	'numeroBanco'       = do_banco,
    	'nombre'            = isnull(dc_nombre, '')+' '+ isnull(dc_p_apellido, '')+' '+ isnull(dc_s_apellido, ''),
     	'grupo'             = (select gr_nombre from cob_credito..cr_tramite_grupal, cobis..cl_grupo where tg_prestamo  = do_banco
                                   and tg_grupo = gr_grupo),
     	'fecha'             = convert(char(10), do_fecha, 103),
		'email'             = (SELECT TOP 1 di_descripcion FROM cobis..cl_direccion WHERE di_tipo = 'CE' and di_ente = do_codigo_cliente)
    from cob_conta_super..sb_dato_cliente, cob_conta_super..sb_dato_operacion
    where do_fecha = dc_fecha
    and do_codigo_cliente = dc_cliente
    and (do_fecha = @i_fecha or @i_fecha is null)
    and (do_codigo_cliente = @i_ente or @i_ente is null)
    and do_aplicativo = 7
    order by dc_cliente
    
    if @@ROWCOUNT = 0
    begin
    	
    	select @w_num_error = 108003 --ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
		goto errores
    	
    end
    
    
goto fin
end



--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0


go