/************************************************************************/
/*   Archivo:              sp_verificar_contactos.sp                    */
/*   Stored procedure:     sp_verificar_contactos.sp                    */
/*   Base de datos:        cobis                                        */
/*   Producto:             Clientes                                     */
/*   Disenado por:         KVI                                          */
/*   Fecha de escritura:   Mayo 2023                                    */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Registro de Verificacion de Medios de Contacto                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA         AUTOR                   RAZON                        */
/*   17/05/2023    KVI         Emision Inicial                          */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_verificar_contactos')
   drop proc sp_verificar_contactos
go

create proc sp_verificar_contactos
(
    @s_ssn             int          = null,
    @s_user            login        = null,
    @s_sesn            int          = null,
    @s_term            varchar(30)  = null,
    @s_date            datetime     = null,
    @s_srv             varchar(30)  = null,
    @s_lsrv            varchar(30)  = null,
    @s_ofi             smallint     = null,
    @s_servicio        int          = null,
    @s_cliente         int          = null,
    @s_rol             smallint     = null,
    @s_culture         varchar(10)  = null,
    @s_org             char(1)      = null,
	@t_debug           char(1)      = 'N',
	@t_file            varchar(10)  = null,
	@i_operacion       char(1)      = null,
	@i_canal           int          = null,
	@i_ente            int,         
	@i_tipo            varchar(10)  = null,
    @i_valor           varchar(254) = null,
	@i_direccion       int          = null
)
as
declare
    @w_sp_name          varchar(100),
	@w_return        	int,
    @w_error            int,
    @w_msg              varchar(255),
	@w_condiciones      varchar(255),
	@w_resultado1       varchar(255),
	@w_variables        varchar(255),
	@w_result_values    varchar(255),
	@w_parent           int,
	@w_regla            varchar(10),
	@w_resultado        int
	

select @w_sp_name    = 'sp_verificar_contactos'

if @i_operacion = 'I' --Registro Verificacion Telefono O Correo		    
begin		    
    if not exists (select 1 from cobis..cl_verif_co_tel 
                   where ct_valor = ltrim(rtrim(@i_valor)) 
                   and   ct_tipo  = @i_tipo 
                   and   ct_ente  = @i_ente
    			   and   ct_verificacion = 'S') 
    begin
        print 'sp_verificar_contactos -->> Ingresa Verificacion Insert'
        insert into cobis..cl_verif_co_tel
               (ct_ente, ct_direccion, ct_valor, ct_tipo, ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
        values (@i_ente, @i_direccion, @i_valor, @i_tipo, 'S',             @i_canal, @s_date,       getdate()) 
    end
    else
    begin
	    print 'sp_verificar_contactos -->> Ingresa Verificacion Update'
        update cobis..cl_verif_co_tel
    	set ct_fecha_proc = @s_date,
    	    ct_fecha      = getdate()
        where ct_valor = ltrim(rtrim(@i_valor)) 
        and   ct_tipo  = @i_tipo 
        and   ct_ente  = @i_ente
        and   ct_verificacion = 'N'
    end
end		   

return 0

ERROR:
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = @w_error
    
    return @w_error

go
