use cob_credito
go
/*************************************************************************/
/*   ARCHIVO:         sp_traslada_tramite.sp                             */
/*   NOMBRE LOGICO:   sp_traslada_tramite                                */
/*   Base de datos:   cob_cartera                                        */
/*   PRODUCTO:        Cartera                                            */
/*   Fecha de escritura:   Junio 2018                                    */
/*************************************************************************/
/*                            IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*  El sp permite realizar traspasos de tramites de clientes y grupos    */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/*   FECHA           AUTOR                    RAZON                      */
/* 23/Ago/2018   Paul Ortiz Vera   Emision inicial                       */
/*  07-05-2021   ACH               Caso#158146 - Error se actualizaban   */
/*                                 operaciones grupales por traspaso de  */
/*                                 cliente, cuando tenian el mismo codigo*/
/*************************************************************************/

if exists(select 1 from sysobjects where name = 'sp_traslada_tramite')
    drop proc sp_traslada_tramite
go

create  proc sp_traslada_tramite
@t_trn                  int          = null,
@t_debug                char(1)      = 'N',
@t_file                 varchar(10)  = null,
@i_operacion            char(1)      = null,    
@i_cliente           	int      = null,
@i_oficina_destino   	smallint = null,
@i_oficial_origen   	smallint = null,
@i_oficial_destino   	smallint = null,
@i_es_grupo             char(1)  = null

as
declare
@w_error                 int,
@w_sp_name               varchar(32),
@w_msg                   varchar(255),
@w_estacion              smallint,
@w_est_castigado         tinyint,
@w_est_novigente         tinyint,
@w_est_vigente           tinyint,
@w_est_vencido           tinyint,
@w_est_cancelado         tinyint,
@w_est_credito           tinyint,
@w_est_diferido          int,
@w_est_anulado           tinyint

select @w_sp_name = 'sp_traslada_tramite'

if @t_debug = 'S' print '@i_operacion  ' +  cast(@i_operacion  as varchar)

--- ESTADOS DE CARTERA 
exec @w_error = cob_cartera..sp_estados_cca
@o_est_novigente = @w_est_novigente out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_castigado = @w_est_castigado out,
@o_est_credito   = @w_est_credito   out,
@o_est_diferido  = @w_est_diferido  out,
@o_est_anulado   = @w_est_anulado   out

if @i_operacion = 'F' --Trasladar Creditos
begin
  
    if (@i_es_grupo = 'S')
	begin

		select cliente = tg_cliente,
		       operacion = tg_operacion
		into #cr_tramite_grupal
		from cr_tramite_grupal
		where tg_cliente =  @i_cliente
		
		delete #cr_tramite_grupal
		from cob_cartera..ca_operacion
		where op_operacion = operacion
		and op_estado = @w_est_cancelado
		
	    --GRUPALES
        /*update cob_credito..cr_tramite
        set tr_oficina = isnull(@i_oficina_destino,0),
            tr_oficial = isnull(@i_oficial_destino,0)
        from cob_credito..cr_tramite, cob_cartera..ca_operacion, cr_tramite_grupal
        where tr_cliente = @i_cliente
		and tr_tramite = op_tramite
		and tr_estado not in ('X', 'Z')
        and op_banco = tg_prestamo
        and op_estado <> @w_est_cancelado*/
	   
	    update cob_credito..cr_tramite
        set tr_oficina = isnull(@i_oficina_destino,0),
            tr_oficial = isnull(@i_oficial_destino,0)
        from #cr_tramite_grupal, cob_cartera..ca_operacion
		where operacion = op_operacion
		and op_tramite = tr_tramite
		--and tr_estado not in ('X', 'Z')		
        if @@error <> 0 begin
           select @w_error = 710033, @w_msg = 'ERROR AL TRASLADAR CUPOS'
           goto ERROR
        end

	    --OPERACIONES <> GRUPALES
	    update cob_credito..cr_tramite
        set tr_oficina = isnull(@i_oficina_destino,0),
            tr_oficial = isnull(@i_oficial_destino,0)
        from cob_credito..cr_tramite, cob_cartera..ca_operacion
        where tr_cliente = @i_cliente
		and tr_tramite = op_tramite
		--and tr_estado not in ('X', 'Z')
        and op_toperacion <> 'GRUPAL'

        if @@error <> 0 begin
           select @w_error = 710033, @w_msg = 'ERROR AL TRASLADAR CUPOS'
           goto ERROR
        end

	end 
	else if (@i_es_grupo = 'N' or @i_es_grupo is null)
    begin

        update cob_credito..cr_linea
        set li_oficina = @i_oficina_destino
        where li_cliente = @i_cliente
        and li_estado in ('V','D','B')
        
        if @@error <> 0 begin
           select @w_error = 710033, @w_msg = 'ERROR AL TRASLADAR CUPOS EN LINEA'
           goto ERROR
        end
    
        update cob_credito..cr_tramite
        set tr_oficina = isnull(@i_oficina_destino,0),
            tr_oficial = isnull(@i_oficial_destino,0)
        from cob_credito..cr_tramite, cob_cartera..ca_operacion
        where tr_cliente = @i_cliente		
		and tr_tramite = op_tramite		
		--and tr_estado not in ('X', 'Z')
        and op_toperacion <> 'GRUPAL'
				
        if @@error <> 0 begin
           select @w_error = 710033, @w_msg = 'ERROR AL TRASLADAR CUPOS'
           goto ERROR
        end
		
	end	
end 
return 0

ERROR:

exec cobis..sp_cerror
@t_debug  = @t_debug,
@t_file   = @t_file,
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_msg

return 1

go
