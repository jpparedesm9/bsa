/*cr_exgar.sp************************************************************/
/*   Archivo:             cu_exgar.sp                                   */
/*   Stored procedure:    sp_garantias_externo                          */
/*   Base de datos:       cob_credito                                   */
/*   Producto:            Credito                                       */
/*   Disenado por:        Monica Vidal                                  */
/*   Fecha de escritura:  May 1999.                                     */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*            PROPOSITO                                                 */
/*   Procedimiento llena las tablas de la base cob_externos que         */
/*   llena los datos de consolidador para credito.                      */
/*									*/
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  04/22/2009  ALFREDO ZULUAGA          NUEVO ESQUEMA BANCAMIA         */
/*  12/02/2016  JORGE SALAZAR            MIGRACION COBIS CLOUD          */
/*  12/05/2016  NOLBERTO VITE            COBIS CLOUD MEXICANIZACION     */
/*  21/05/2019  ANDY GONZALEZ            HISTORICO DE GARANTIAS.        */
/*  25/06/2019  DARIO CUMBAL             AJUSTE EN EL CONSOLIDADOR      */
/*  26/08/2019  ADRIANA CHILUISA         TRAMITE IND EN LUGAR DEL GRUPAL*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_garantias_externo')
   drop proc sp_garantias_externo
go

create proc sp_garantias_externo (
   @i_param1            varchar(255)
)

as 

declare
@w_sp_name              descripcion,
@w_aplicativo           int,
@w_mensaje              varchar(250),
@w_error                int,
@w_usuario              login,
@i_fecha                datetime,
@w_garantia             varchar(64),
@w_superior             varchar(64),
@w_tipo                 varchar(64)

select 
@w_error         = 21001,
@w_usuario       = 'crebatch',
@w_sp_name       = 'sp_garantias_externo',
@w_aplicativo    = 19,
@i_fecha         = convert(datetime, @i_param1)


delete cob_externos..ex_dato_custodia
where  dc_aplicativo = @w_aplicativo

if @@error <> 0 begin
   select @w_mensaje = 'Error Eliminando en cob_externos..ex_dato_custodia '
   goto ERRORFIN
end

delete cob_externos..ex_dato_garantia
where dg_aplicativo = @w_aplicativo

if @@error <> 0 begin
   select @w_mensaje = 'Error Eliminando en cob_externos..ex_dato_garantia '
   goto ERRORFIN
end

--Garantias
select distinct
fecha              = @i_fecha,
aplicativo         = @w_aplicativo,
garantia           = convert(varchar,null),--cu_codigo_externo,
tramite            = convert(int, null),
estado             = convert(varchar,null),
operacion          = convert(int, null),
oficina            = convert(int, null) ,--cu_oficina,
cliente            = gl_cliente,
documento_tipo     = null,
documento_numero   = null,
categoria          = 'O',    --Otros
tipo               = convert(varchar,null),--cu_tipo,
idonea             = convert(varchar,null),--(isnull((select case tc_clase when 'I' then 'S' else 'N' end from cob_custodia..cu_tipo_custodia where tc_tipo = x.cu_tipo),'N')),
moneda             = convert(int, null),   --cu_moneda,
fecha_avaluo       = convert(datetime , null), --isnull(cu_fecha_avaluo, cu_fecha_ingreso),
valor_avaluo       = convert(money,null), --round(cu_valor_inicial,0),
valor_actual       = convert(money, null), --round(cu_valor_actual,0),
id_garliquida      = gl_id,
tramite_grupal     = gl_tramite,
grupo              = gl_grupo,
monto_individual   = gl_monto_individual,
monto_garantia     = gl_monto_garantia,
fecha_vencimiento  = gl_fecha_vencimiento,
pag_estado         = gl_pag_estado,
pag_fecha          = gl_pag_fecha,
pag_valor          = gl_pag_valor,
dev_estado         = gl_dev_estado,
dev_fecha          = gl_dev_fecha,
dev_valor          = gl_dev_valor,
abierta            = convert(varchar,null),--cu_abierta_cerrada,
num_dcto           = convert(varchar,null),--cu_num_dcto,                          -- REQ 184 - COMPLEMENTO REPOSITORIO - 09/DIC/2010
calidad_gar        = convert(varchar,null),--cu_grado_gar,
valor_uti_opera    = 0
into #garantias
from  cob_cartera..ca_garantia_liquida x
where gl_pag_valor > 0

if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en #garantias '
   goto ERRORFIN
end

update #garantias set 
tramite   = op_tramite,
operacion = op_operacion,
oficina   = op_oficina 
from cob_cartera..ca_operacion   , cob_credito..cr_tramite_grupal,#garantias
where tg_operacion = op_operacion  
and   tg_tramite = tramite_grupal
and   tg_grupo   = grupo 
and   tg_cliente = op_cliente
and   cliente    = op_cliente 


update #garantias set 
garantia = gp_garantia  
from cob_credito..cr_gar_propuesta
where gp_tramite = tramite  

update #garantias set 
garantia          = isnull(garantia, ''),
tipo              = isnull(cu_tipo,''), 
estado            = isnull(cu_estado,0),
idonea            = isnull((select case tc_clase when 'I' then 'S' else 'N' end from cob_custodia..cu_tipo_custodia where tc_tipo = x.cu_tipo),'N'),
moneda            = isnull(cu_moneda,0),
fecha_avaluo      = isnull(cu_fecha_avaluo,'01/01/1900'),
valor_avaluo      = isnull(round(cu_valor_inicial,0),0),
valor_actual      = isnull(round(cu_valor_actual,0),0),
abierta           = isnull(cu_abierta_cerrada,''),
num_dcto          = isnull(cu_num_dcto,''),
calidad_gar       = isnull(cu_grado_gar,'')
from cob_custodia..cu_custodia x 
where cu_codigo_externo = garantia 


update #garantias set
categoria  =  (case  when tc_tipo_superior is null then tc_tipo_superior else  
                                                                           (case tipo
																		   when 'LIQ' then 'L' 
																		   when 'HIP' then 'H' 
																		   when 'AVAL' then 'A' 
																		   when 'PREN' then 'P' 
																		   when 'PERS' then 'E' 
																		   else 'O' end) end )
from cu_tipo_custodia 
where tc_tipo = tipo


select garantia, oficina, mensaje='Garantia sin relacion en cr_gar_propuesta'
into #error
from #garantias
where cliente = 0

insert into cob_credito..cr_errorlog
select @i_fecha, @w_error, @w_usuario, 21000, garantia, mensaje
from #error

if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando Error en cr_errorlog '
   goto ERRORFIN
end

delete #garantias
where cliente = 0

if @@error <> 0 begin
   select @w_mensaje = 'Error Eliminando en #garantias clientes sin gar_propuesta '
   goto ERRORFIN
end

update #garantias set
categoria = 'E'   --Especiales
from cob_credito..cr_corresp_sib
where tabla      = 'T65'
and   codigo_sib = tipo

if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en #garantias tipo E '
   goto ERRORFIN
end

update #garantias set
categoria = 'H'   --Hipotecaria
from cob_credito..cr_corresp_sib
where tabla      = 'T1'
and   codigo_sib = tipo

if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en #garantias tipo H '
   goto ERRORFIN
end

update #garantias set
categoria = 'I'   --Prendas
from cob_credito..cr_corresp_sib
where tabla      = 'T132'
and   codigo_sib = tipo

if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en #garantias tipo P '
   goto ERRORFIN
end




insert into cob_externos..ex_dato_custodia (
dc_fecha,                dc_aplicativo,           dc_garantia,
dc_oficina,              dc_cliente,              dc_documento_tipo, 
dc_documento_numero,     dc_categoria,            dc_tipo,           
dc_idonea,               dc_moneda,               dc_fecha_avaluo, 
dc_valor_avaluo,         dc_valor_actual,         dc_estado,       
dc_abierta,              dc_num_reserva,          dc_calidad_gar,                           -- REQ 184 - dc_num_reserva - COMPLEMENTO REPOSITORIO - 09/DIC/2010
dc_valor_uti_opera,      dc_gl_id      ,          dc_gl_tramite,
dc_gl_grupo ,            dc_gl_monto_individual  ,dc_gl_monto_garantia    ,
dc_gl_fecha_vencimiento ,dc_gl_pag_estado        ,dc_gl_pag_fecha         ,
dc_gl_pag_valor         ,dc_gl_dev_estado        ,dc_gl_dev_valor         ,
dc_gl_dev_fecha         
)
select distinct
fecha,                aplicativo,                garantia,
oficina,              cliente,                   documento_tipo,    
documento_numero,     categoria,                 tipo,              
idonea,               moneda,            fecha_avaluo,    
valor_avaluo,         valor_actual,      estado,          
abierta,              num_dcto,          calidad_gar,                                 -- REQ 184 - num_dcto - COMPLEMENTO REPOSITORIO - 09/DIC/2010
valor_uti_opera,      id_garliquida,     tramite,   
grupo,                monto_individual,  monto_garantia,   
fecha_vencimiento,    pag_estado,        pag_fecha,        
pag_valor,            dev_estado,        dev_valor,
dev_fecha
from #garantias




if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en cob_externos..ex_dato_custodia '
   goto ERRORFIN
end

insert into cob_externos..ex_dato_garantia (
dg_fecha,       dg_banco,        dg_toperacion,
dg_aplicativo,  dg_garantia
)
select 
fecha,          op_banco,        op_toperacion,
@w_aplicativo,  garantia
from #garantias, cob_credito..cr_gar_propuesta, cob_cartera..ca_operacion
where garantia    =  gp_garantia
and   gp_tramite  =  op_tramite
and   op_estado   in (1,2,4,9)

if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en cob_externos..ex_dato_garantia '
   goto ERRORFIN
end

return 0


ERRORFIN:

while @@trancount > 0 rollback tran

select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into cob_credito..cr_errorlog
values (@i_fecha, @w_error, @w_usuario, 21000, 'CONSOLIDADOR', @w_mensaje)

return 1

go

