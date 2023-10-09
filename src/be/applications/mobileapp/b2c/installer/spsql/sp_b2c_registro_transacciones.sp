/************************************************************************/
/*      Archivo:                sp_b2c_registro_transacciones.sp        */
/*      Stored procedure:       sp_b2c_registro_transacciones           */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Santander                               */
/*      Disenado por:           Brayan Batista/Jonathan Ramirez         */
/*      Fecha de escritura:     26-Sep-2019                             */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                          PROPOSITO                                   */
/*      Generar un log de transacciones que permita verificar la        */
/*      actividad del cliente en la B2C.                                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*         FECHA               AUTOR               RAZON                */
/*      26/Sep/2019       Brayan Batista       Emision Inicial          */
/*      10/Oct/2019       Jonathan Ramirez     Ajustes para dispersion  */
/************************************************************************/
use cob_bvirtual
go

if exists (select * from sysobjects where name = 'sp_b2c_registro_transacciones')
      drop proc sp_b2c_registro_transacciones
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_b2c_registro_transacciones]   (
    @t_show_version         bit             = 0,
    @s_date                 datetime        = null,
    @s_ssn                  int             = null,
    @s_lsrv                 varchar(30)     = null,
    @t_debug                char(1)         = 'N',
    @i_login                varchar(128)    = null,
    @i_tipo_tran            int             ,
    @i_monto                money           = null,
    @i_ref_interna          varchar(30)     = null,
    @i_ref_externa          varchar(30)     = null,
    @i_ip_origen            varchar(15)     = null
) 
as  
declare 
    @w_error                int             ,
    @w_msg                  varchar(250)    ,
    @w_fecha_proceso        date            ,    /* fecha del dia */
    @w_sp_name              varchar(32)     ,    /* nombre del stored procedure*/
    @w_hora                 varchar(8)      ,
    @w_tabla                varchar(30)     ,
	@w_rowcount             int             ,
	@w_clase                char(1)         ,
    @w_cliente              int
 
---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if (@t_show_version = 1) begin
   select @w_msg = 'Stored procedure ' + @w_sp_name + ', Version 1.0.0.0'
   print @w_msg
   return 0
end

select @w_sp_name = 'sp_b2c_registro_transacciones'

select @w_hora = convert(varchar(8), getdate(), 108)
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

if(@i_login is null) begin
	select  @w_error = 1,
            @w_msg  = 'El usuario no se encuentra registrado'
    goto ERROR_FIN
end

select @w_cliente = te_ente from cobis..cl_telefono where te_valor = @i_login
if(@@rowcount = 0) begin
    select  @w_error = 1,
            @w_msg  = 'Error al obtener el id de cliente'
    goto ERROR_FIN
end
    
/*SOLICITUD DE PAGO. ???*/

if (@s_ssn is null) begin
	select @s_ssn = ABS(CAST(NEWID() as binary(6)) % 100000000) + 1
end

if (@i_ip_origen is null) begin
	select @i_ip_origen = ts_varchar1 from cob_bvirtual..bv_tran_servicio
	where ts_varchar25501 = @i_login
	and ts_tipo_transaccion = 1500
	order by ts_fecha desc, ts_hora desc
end

if (@s_date is null) begin
	select @s_date = @w_fecha_proceso
end

/*REGISTRO B2C - 1890023*/
if(@i_tipo_tran = 1890023) begin
	select @w_clase = 'I'
	select @w_tabla = 'bv_login'
end

/*INICIO DE SESION - 1500*/
if(@i_tipo_tran = 1500) begin
	select @w_clase = 'I'
	select @w_tabla = 'bv_in_login'
end

/*CIERRE DE SESION - 1502*/
if(@i_tipo_tran = 1502) begin
	select @w_clase = 'D'
	select @w_tabla = 'bv_in_login'
end

/*CAMBIO DE FRASE Y/O IMAGEN DE BIENVENIDA - 1800266*/
if(@i_tipo_tran = 1800266) begin
	select @w_clase = 'U'
	select @w_tabla = 'bv_login_imagen'
end

/*CAMBIO DE CLAVE - 17006*/
if(@i_tipo_tran = 17006) begin
	select @w_clase = 'U'
	select @w_tabla = 'bv_login'
end

/*BLOQUEO - 1890030*/
if(@i_tipo_tran = 1890030) begin
	select @w_clase = 'U'
	select @w_tabla = 'bv_login'
end

/*DESBLOQUEO - 1890031*/
if(@i_tipo_tran = 1890031) begin
	select @w_clase = 'U'
	select @w_tabla = 'bv_login'
end

/*SOLICITUD DE DISPERSION - 7297*/
if(@i_tipo_tran = 7297) begin
    select @w_clase = 'U'
	select @w_tabla = 'ca_desembolso'
    if(@i_monto is null) begin 
        select  @w_error = 1,
                @w_msg  = 'El monto no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
    if(@i_ref_interna is null) begin 
        select  @w_error = 1,
                @w_msg  = 'la referencia interna no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
    if(@i_ref_externa is null) begin 
        select  @w_error = 1,
                @w_msg  = 'la referencia externa no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
end
    
/*INCREMENTO DE CUPO - 7299*/
if(@i_tipo_tran = 7299) begin
    select @w_clase = 'U'
	select @w_tabla = 'ca_operacion'
    if(@i_monto is null) begin 
        select  @w_error = 1,
                @w_msg  = 'El monto no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
    if(@i_ref_interna is null) begin 
        select  @w_error = 1,
                @w_msg  = 'la referencia interna no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
end

/*SOLICITUD DE PAGO.*/
if(@i_tipo_tran = 0) begin
    if(@i_monto is null) begin 
        select  @w_error = 1,
                @w_msg  = 'El monto no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
    if(@i_ref_interna is null) begin 
        select  @w_error = 1,
                @w_msg  = 'la referencia interna no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
    if(@i_ref_externa is null) begin 
        select  @w_error = 1,
                @w_msg  = 'la referencia externa no puede estar vacio para el tipo de transacción: ' + convert(varchar, @i_tipo_tran)
        goto ERROR_FIN
    end
end
    
begin tran
    insert into cob_bvirtual..bv_tran_servicio(
		ts_secuencial,
        ts_clase,
        ts_cod_alterno,
        ts_tabla,
        ts_lsrv,
        ts_int01, /* Id Cliente*/
        ts_varchar25501, /* Id login*/
		ts_fecha, /*Fecha*/
        ts_hora, /*Hora*/
        ts_tipo_transaccion, /*Tipo de Transacción*/
        ts_money01, /*Monto*/
        ts_descripcion03, /*Referencia Interna*/
        ts_descripcion04, /*Referencia Externa*/
        ts_varchar1) /*Ip Origen*/
    values (
        @s_ssn,
        @w_clase,
        1,
        @w_tabla,
        @s_lsrv,
        @w_cliente,
        @i_login,
		@s_date,
        @w_hora,
        @i_tipo_tran,
        @i_monto,
        @i_ref_interna,
        @i_ref_externa,
        @i_ip_origen)

	select @w_rowcount = @@rowcount
commit tran
if (@w_rowcount = 0) begin
    select  @w_error = 1,
            @w_msg  = 'Error en la inserción de registro'
    goto ERROR_FIN
end
return 0

ERROR_FIN:
    exec cobis..sp_cerror
        @i_num = @w_error,
        @i_msg = @w_msg,
		@t_from = @w_sp_name
    return @w_error
GO