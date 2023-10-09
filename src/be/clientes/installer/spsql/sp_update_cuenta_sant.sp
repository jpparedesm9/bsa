/*************************************************************************/
/*   Archivo:            update_cuenta_sant.sp                           */
/*   Stored procedure:   update_cuenta_sant                              */
/*   Base de datos:      cobis                                           */
/*   Producto:           Actualizacion de cuenta                         */
/*   Disenado por:       ACH                                             */
/*   Fecha de escritura: 21-12-2020                                      */
/*************************************************************************/
/*                               PROPOSITO                               */
/*   Este programa da mantenimiento a la tabla cl_ente y cl_enteaux      */
/*************************************************************************/
/*                              OPERACIONES                              */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     U               Actualiza la cuenta de un cliente                 */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                      RAZON                       */
/*  21-12-2020     ACH       Basado en script de actualizacion de cuentas*/
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'update_cuenta_sant')
   drop proc update_cuenta_sant
go

IF OBJECT_ID ('dbo.update_cuenta_sant') IS NOT NULL
	DROP PROCEDURE dbo.update_cuenta_sant
GO

create proc update_cuenta_sant (
	@t_debug	   char(1) = 'N',
	@t_file		   varchar(30) = null,
	@t_from		   varchar(30) = null,
	@s_user        login = null,
	@i_num		   int = 0,
	@i_sev 		   int = null,
	@i_msg		   varchar(132) = null,
	@s_date        datetime = null,
    @i_cliente     int,
	@i_cuenta      varchar(45),
	@i_operacion   char(1) = 'U'
)
as
declare @w_today                 datetime,
        @w_sp_name               varchar(32),
        @w_return                int,
        @w_error                 int,
	    @w_estado_std            varchar(10),
        @w_msg                   varchar(255),
		@i_cuenta_act            varchar(45)
		
select @w_sp_name = 'update_cuenta_sant'
select @w_estado_std = 'CLI' ----Por defecto, viene de la consulta a santander

if ( @i_operacion = 'U' )
begin	   

    select 1 from cl_ente_aux where ea_cta_banco = @i_cuenta and ea_ente <> @i_cliente
    if @@rowcount = 1
    begin
	   select @w_error = 109007,
              @w_msg   = 'LA CUENTA YA EXISTE'
       goto ERRORFIN
    end

	select @i_cuenta_act = ea_cta_banco
	  from cl_ente_aux
	 where ea_ente = @i_cliente
	
    update cl_ente_aux 
       set ea_cta_banco = isnull (@i_cuenta, ea_cta_banco),
           ea_estado_std = isnull (@w_estado_std, ea_estado_std)
    where ea_ente = @i_cliente
        
    --select dm_cuenta, * from cob_cartera..ca_desembolso where dm_operacion in (select op_operacion from cob_cartera..ca_operacion where op_cliente = @i_cliente)
    update cob_cartera..ca_desembolso 
    set    dm_cuenta = @i_cuenta
    where  dm_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    	    
    --select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @i_cliente
    --select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @i_cliente
    update cob_cartera..ca_operacion 
    set    op_cuenta    = @i_cuenta
    where  op_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2,0)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera..ca_operacion_his
    set    oph_cuenta    = @i_cuenta
    where  oph_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera_his..ca_operacion
    set    op_cuenta    = @i_cuenta
    where  op_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera_his..ca_operacion_his
    set    oph_cuenta    = @i_cuenta
    where  oph_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera..ca_det_trn
    set    dtr_cuenta = @i_cuenta
    where  dtr_secuencial in (1)
    and    dtr_operacion  in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @i_cliente
    						and   tg_monto > 0
    						and   tg_prestamo <> tg_referencia_grupal)
    --and    dtr_cuenta     = @i_cuenta_act

end

return 0

ERRORFIN:
exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = @w_error,
       @i_msg   = @w_msg
       return @w_error

return @w_error
go




