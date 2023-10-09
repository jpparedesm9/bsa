/************************************************************************/
/*      Archivo:                lcr_inccup.sp                           */
/*      Stored procedure:       sp_lcr_incrementar_cupo                 */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Dic/2018                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Incrementa el cupo de una linea de Credito                        */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    10/Dic/2018           TBA              Emision Inicial            */
/*    AGOSTO/2019           ANDY             COLECTIVOS                 */ 
/*    JULIO/2021            DCU              Caso: 154940               */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_lcr_incrementar_cupo')
    drop proc sp_lcr_incrementar_cupo
go

create proc sp_lcr_incrementar_cupo(
@s_ssn           int          = null,
@s_sesn          int          = null,
@s_date          datetime     = null,
@s_user          login        = null,
@s_term          varchar(30)  = null,
@s_ofi           smallint     = null,
@s_srv           varchar(30)  = null,
@s_lsrv          varchar(30)  = null,
@s_rol           smallint     = null,
@s_org           varchar(15)  = null,
@s_culture       varchar(15)  = null,
@t_rty           char(1)      = null,
@t_debug         char(1)      = 'N',
@t_file          varchar(14)  = null,
@t_trn           smallint     = null,
@i_cliente       int,
@i_banco         cuenta,
@i_msg_id        int,
@o_folio         varchar(20)  = null output,
@o_tipo_tran     varchar(50)  = null output,
@o_mensaje       varchar(200) = null output,
@o_msg           varchar(200) = null output
)
as
declare
@w_sp_name           varchar(25),
@w_tramite           int,
@w_cliente           int,
@w_sector            catalogo,
@w_operacionca       int,
@w_cupo              money,
@w_id_inst_proceso   int,
@w_incremento_str    varchar(50),
@w_limite_inc_str    varchar(50),
@w_incremento        money,
@w_limite_inc        money,
@w_commit            char(1),
@w_fecha_proceso     datetime,
@w_error             int,
@w_msg               varchar(200),
@w_diferencia        money,
@w_monto_fin         money,
@w_fecha_mensaje     datetime,
@w_secuencial        int,
@w_login             varchar(255),
@w_porc_incremento   float,
@w_incremento_val    float


select  
@w_sp_name        = 'sp_lcr_incrementar_cupo',
@w_incremento_str = '300', 
@w_limite_inc_str = '10000'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_fecha_mensaje = CONVERT (datetime, convert(char(10), ms_fecha_ing, 101))
from cob_bvirtual..bv_b2c_msg
where ms_msg_id = @i_msg_id

select 
@w_operacionca       = op_operacion,
@w_cliente           = op_cliente,
@w_sector            = op_sector, 
@w_cupo              = op_monto_aprobado,
@w_tramite           = op_tramite
from ca_operacion
where op_banco    = @i_banco

if @@rowcount = 0 begin
    select 
	@w_error = 724617, 
	@o_msg   = 'ERROR: ESTE CLIENTE NO TIENE OPERACION REVOLVENTE'
	goto ERROR_FIN
end

if @w_cliente <> @i_cliente begin
   select @w_error = 724617
   goto ERROR_FIN
end

select @w_id_inst_proceso = io_id_inst_proc
from cob_workflow..wf_inst_proceso
where io_campo_3 = @w_tramite

if @@rowcount <> 0 begin
   exec @w_error           = cob_cartera..sp_ejecutar_regla
   @s_ssn                  = @s_ssn,
   @s_ofi                  = @s_ofi,
   @s_user                 = @s_user,
   @s_date                 = @s_date,
   @s_srv                  = @s_srv,
   @s_term                 = @s_term,
   @s_rol                  = @s_rol,
   @s_lsrv                 = @s_lsrv,
   @s_sesn                 = @s_ssn,
   @i_regla                = 'LCRVALINC', 
   --@i_valor_variable_regla = @i_cliente,	 
   @i_id_inst_proc         = @w_id_inst_proceso,
   @o_resultado1           = @w_incremento_str out,  --3%
   @o_resultado2           = @w_limite_inc_str out   --10000
   
   if @w_error <> 0
   begin
   	select @w_msg   = 'ERROR AL CONSULTAR DATOS DE INCREMENTO DE CUPO'
   	goto ERROR_FIN
   end
end

select 
@w_porc_incremento = convert(float, isnull(@w_incremento_str,3))/100, --0.03
@w_limite_inc = convert(money, isnull(@w_limite_inc_str,10000))


--CALCULO DEL VALOR
select 
@w_incremento  = round(convert(float, @w_cupo)*@w_porc_incremento , 2)

                                              
select @w_diferencia = @w_limite_inc - @w_cupo

if @w_diferencia < 0
begin
   select @w_error = 70210--validar error
   goto ERROR_FIN
end

if @w_diferencia < @w_incremento select @w_incremento = @w_limite_inc - @w_cupo

--Validar que el cupo actual más el incremento no supere el tope
if (@w_cupo + @w_incremento) > @w_limite_inc begin
   select @w_error = 70210
   goto ERROR_FIN
end

--INICIO ATOMICIDAD
if @@trancount = 0 begin  
  select @w_commit = 'S'
  begin tran 
end

--Update a la tabla ca_operacion, el campo op_monto_aprobado, --Realizar update de op_monto_aprobado , valor actual del monto más el incremento
update ca_operacion
set op_monto_aprobado = op_monto_aprobado + isnull(@w_incremento,0)
where op_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR_FIN
end

update ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento_str,0)
where oph_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR_FIN
end

update cob_cartera_his..ca_operacion_his
set oph_monto_aprobado = oph_monto_aprobado + isnull(@w_incremento_str,0)
where oph_operacion = @w_operacionca

if @@error <> 0 begin
   select @w_error = 710002
   goto ERROR_FIN
end

select @o_folio = convert(varchar(10),@w_operacionca)+'_'+convert(varchar(10),@w_secuencial)

select 
@w_monto_fin              = op_monto_aprobado
from ca_operacion
where  op_banco    = @i_banco

select @w_secuencial = max(ic_secuencial)
from ca_incremento_cupo
where ic_operacion = @w_operacionca

if @w_secuencial is null
   select @w_secuencial = 0

insert into ca_incremento_cupo(
ic_operacion,   ic_fecha_proceso,      ic_monto_aprobado_ini,
ic_incremento,  ic_monto_aprobado_fin, ic_secuencial)
values (
@w_operacionca, @w_fecha_mensaje, @w_cupo, 
@w_incremento,  @w_monto_fin,     @w_secuencial)

if @@error <> 0 begin
   select @w_error = 710001
   goto ERROR_FIN
end

select 
@o_folio = convert(varchar(10),@w_operacionca)+'_'+convert(varchar(10),@w_secuencial),
@o_tipo_tran = 'AUTORIZAR INCREMENTO CUPO',
@o_mensaje = 'El nuevo cupo de tu Linea de Credito ya esta disponible'
	
select @w_login = te_valor
from cobis..cl_telefono, cob_bvirtual..bv_login
where te_ente = @w_cliente
and te_valor = lo_login
and te_valor is not null

exec cob_bvirtual..sp_b2c_registro_transacciones
	@s_ssn          = @s_ssn,
	@s_lsrv         = @s_lsrv,
	@s_date         = @s_date,
	@i_tipo_tran    = 7299,
	@i_login        = @w_login,
	@i_monto        = @w_incremento,
	@i_ref_interna  = @w_operacionca

--Cierre de transaccion(Commit tran)
if @w_commit = 'S'begin 
  select @w_commit = 'N'
  commit tran    
end

return 0

ERROR_FIN:

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end 

exec sp_errorlog 
@i_fecha     = @w_fecha_proceso,
@i_error     = @w_error,
@i_usuario   = @w_sp_name,
@i_tran      = 7299,
@i_tran_name = @w_sp_name,
@i_cuenta    = @i_banco,
@i_rollback  = 'N'

go
