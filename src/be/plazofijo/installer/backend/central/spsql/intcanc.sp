/************************************************************************/
/*      Archivo:                intcanc.sp                              */
/*      Stored procedure:       sp_intereses_cancelados                 */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Genera un reporte con los CDTS con capital e intereses          */
/*      cancelados y no entregados al cliente                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      08-Jul-13  Dlozano            Creacion                          */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'pf_intereses_canc')
   drop table pf_intereses_canc

create table pf_intereses_canc(
pc_num_banco            varchar(24)   null,
pc_estado               varchar(10)   null,
pc_fecha_can            datetime      null,
pc_num_id               varchar(30)   null,
pc_nombre           	varchar(255)  null,
pc_tipo_op        		varchar(30)   null,
pc_valor                money         null,
pc_oficina  			smallint	  null)

if exists(select 1 from sysobjects where name = 'sb_data_bcp')
   drop table sb_data_bcp 

create table sb_data_bcp(dt_data varchar(1000))

if object_id('sp_intereses_cancelados') is not null
   drop proc sp_intereses_cancelados
go

create proc sp_intereses_cancelados
with encryption
as
declare
@w_sp_name              varchar(32),
@w_path                 varchar(64),
@w_s_app                varchar(30),
@w_cmd                  varchar(250),
@w_archivo              varchar(64),
@w_archivo_bcp          varchar(64),
@w_errores              varchar(64),
@w_cabecera             varchar(255),
@w_comando              varchar(255),
@w_fecha                varchar(10),
@w_error                int,
@w_destino              varchar(100)
   
select
@w_sp_name = 'sp_intereses_cancelados',
@w_fecha   = convert(varchar(10),getdate(),101)
	   
truncate table pf_intereses_canc
truncate table sb_data_bcp
   
insert into pf_intereses_canc
select
op_num_banco,
op_estado,
ec_fecha_mov,
(select en_ced_ruc from cobis..cl_ente where en_ente = op_ente),
op_descripcion,
case ec_tran when 14905 then 'PAGO DE INTERESES' when 14903 then 'CANCELACION DE PLAZO FIJO' end,
ec_valor,
op_oficina
from pf_emision_cheque inner join pf_operacion on  op_operacion     = ec_operacion
                       inner join pf_mov_monet on  ec_operacion     = mm_operacion
					                           and ec_secuencia     = mm_secuencia
											   and ec_sub_secuencia = mm_sub_secuencia
											   and ec_tran          = mm_tran
                       left outer join cobis..cl_ttransaccion on ec_tran = tn_trn_code
where ec_fecha_emision is null
and   ec_tipo     = 'C'
and   mm_estado   = 'A'
and   op_estado   = 'CAN'
and   tn_trn_code > 14000
and   ec_estado is null
and   rtrim(ltrim(mm_producto)) not in('TRANS', 'SUSP')
order by op_descripcion, ec_fecha_mov 

-- Consulta path de s_app
select	@w_s_app = pa_char
from   	cobis..cl_parametro
where  	pa_nemonico = 'S_APP'
and     pa_producto = 'ADM'

if @w_s_app is null begin
   exec  sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @w_error,
   @i_usuario     = 'opbatch',
   @i_tran        = 29397,
   @i_cta_pagrec  = 'No existe Parametro General S_APP',
   @i_descripcion = @w_sp_name
end

-- Consulta path de salida de pfijo en donde se guardara el archivo de salida
select @w_path = pp_path_destino 
from   cobis..ba_path_pro 
where  pp_producto = 14

insert into sb_data_bcp values('Numero del Deposito|Estado del Deposito|Fecha de Cancelacion|Numero de Identificacion|Nombre del Cliente|Tipo Operacion|Valor|Codigo Oficina')

insert into sb_data_bcp 
select isnull(pc_num_banco,'') + '|' + isnull(pc_estado,'') + '|' + isnull(convert(varchar(10),pc_fecha_can,101),'') + '|' + isnull(pc_num_id,'') + '|' + isnull(pc_nombre,'') + '|'+ isnull(pc_tipo_op,'') + '|'+ isnull(convert(varchar(20),pc_valor),'')+ '|'+ isnull(convert(varchar(6),pc_oficina),'')
from  pf_intereses_canc

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_pfijo..sb_data_bcp out '

select 
@w_destino  = @w_path + 'interes_causado_'+convert(varchar, getdate(),112)+'.txt',
@w_errores  = @w_path + 'interes_causado_'+convert(varchar, getdate(),112)+'.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin 
   exec  sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @w_error,
   @i_usuario     = 'opbatch',
   @i_tran        = 29397,
   @i_cta_pagrec  = 'Error Generando BCP',
   @i_descripcion = @w_sp_name
end 

return 0
go
