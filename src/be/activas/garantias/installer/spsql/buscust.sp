/***********************************************************************/
/*	Archivo:			        buscust.sp                             */
/*	Archivo:			        buscust.sp                             */
/*	Stored procedure:		    sp_buscar_custodia                     */
/*	Base de Datos:			    cob_custodia                            */
/*	Producto:			        Credito	                               */
/*	Disenado por:			    Myriam Davila                          */
/*	Fecha de Documentacion: 	26/Jun/95                              */
/***********************************************************************/
/*			IMPORTANTE		       		                               */
/*	Este programa es parte de los paquetes bancarios propiedad de      */
/*	'MACOSA',representantes exclusivos para el Ecuador de la           */
/*	AT&T							                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como         */
/*	cualquier autorizacion o agregado hecho por alguno de sus          */
/*	usuario sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante	               */
/***********************************************************************/
/*			PROPOSITO				                                   */
/* Busqueda de Garantías      	                                       */
/***********************************************************************/
/*			MODIFICACIONES				                               */
/*	FECHA			AUTOR				RAZON		                   */
/*  27-04-2017      Sonia Rojas         Popover más información gar web*/
/***********************************************************************/

use cob_custodia
go
 
if exists (select 1 from sysobjects where name = 'sp_buscar_custodia')
   drop proc sp_buscar_custodia
go
create proc sp_buscar_custodia (
   @s_date               datetime    = null,
   @t_trn                smallint    = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_formato_fecha      int         = null,     
   @i_filial             tinyint     = null,
   @i_moneda             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_oficina            smallint    = null,
   @i_tipo               varchar(64) = null,
   @i_estado             catalogo    = null,
   @i_custodia1          int         = null,
   @i_custodia2          int         = null,
   @i_custodia3          int         = null,
   @i_fecha_ingreso1     datetime    = null,
   @i_fecha_ingreso2     datetime    = null,
   @i_tipo1              descripcion = null,
   @i_cliente            int         = null,
   @i_oficial            int         = null,
   @i_codigo_externo     varchar(64) = null,
   @i_siguiente          varchar(64) = '0',
   @i_condicion_est      tinyint     = null,
   @i_caracter           char(1)     = null,      
   @i_cuantia            char(1)     = null,      
   @i_clase              char(1)     = null,      
   @i_compartida         char(1)     = null,      
   @i_ofi_sig            smallint    = 0,
   @i_tipo_sig           varchar(64) = '0',
   @i_cust_sig           int         = 0,
   @i_llama_estado       char(1)     = 'S',
   @i_fecha_ingreso3     datetime    = null,
   @i_fecha_ingreso4     datetime    = null,
   @i_fecha_ingreso5     datetime    = null,
   @i_fecha_ingreso6     datetime    = null,
   @i_certificado        smallint    = null
)
as
declare
   @w_return             int,          
   @w_opcion             int,
   @w_error              int,          
   @w_sp_name            varchar(32),  
   @w_garesp             varchar(30),  
   @w_valor              char(10),
   @w_valor1             smallint,
   @w_siguiente_tipo     descripcion,
   @w_conexion           int,
   @w_pid_buscus         int,
   @w_tipo_personal      char,
   @w_fecha_max          datetime




select  @w_sp_name      = 'sp_buscar_custodia',
        @w_pid_buscus   = @@spid * 100 
select  @w_conexion = @w_pid_buscus,
        @w_error    = 0

delete  cu_tmp_cotizacion_moneda
where   sesion      = @w_pid_buscus

delete  cu_tmp_custodia
where   cu_idconn   = @w_conexion

select @w_opcion = 1000
if @i_caracter        is not null  select @w_opcion = 13      
if @i_cuantia         is not null  select @w_opcion = 12      
if @i_clase           is not null  select @w_opcion = 11      
if @i_compartida      is not null  select @w_opcion = 10      
if @i_moneda          is not null  select @w_opcion = 14
if @i_estado          is not null  select @w_opcion = 7
if @i_custodia1       is not null  or 
   @i_custodia2       is not null  select @w_opcion = 6
if @i_oficina         is not null  select @w_opcion = 5
if @i_tipo            is not null  select @w_opcion = 4
if @i_oficial         is not null  select @w_opcion = 3
if @i_sucursal        is not null  select @w_opcion = 0
if @i_cliente         is not null  select @w_opcion = 2
if @i_codigo_externo  is not null  select @w_opcion = 1
if @i_fecha_ingreso3  is not null  or 
   @i_fecha_ingreso4  is not null  select @w_opcion = 15
if @i_oficina         is not null  and
   @i_tipo            is not null  select @w_opcion = 16
if(@i_fecha_ingreso3  is not null  or 
   @i_fecha_ingreso4  is not null) and
   @i_oficina         is not null  and
   @i_tipo            is not null  select @w_opcion = 17



select  @w_garesp   = pa_char
from    cobis..cl_parametro 
where   pa_nemonico = 'GARESP' 
and     pa_producto = 'GAR'
set transaction isolation level read uncommitted

set rowcount 1 
select  @w_siguiente_tipo   = tc_tipo
from    cu_tipo_custodia
where   tc_tipo_superior    is null
and     tc_tipo         > isnull(@i_tipo,@w_garesp)
order by tc_tipo
set rowcount 0

insert  into    cu_tmp_cotizacion_moneda
(
    moneda,     
    cotizacion,     
    sesion
)
select  cv_moneda,
    cv_valor,
    @w_pid_buscus
from    cob_conta..cb_vcotizacion a
where   cv_fecha    = (select   max(cv_fecha) 
                   from     cob_conta..cb_vcotizacion b
                           where    b.cv_moneda     = a.cv_moneda)
and     cv_fecha    <= @s_date 
        

if @w_opcion = 1 
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,       cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,           cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,  cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura, 
   cg_ente,           cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,    cu_oficina,         cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia
   where    cu_codigo_externo   = @i_codigo_externo
   and      cg_principal        = 'D'
   and      cg_codigo_externo   = cu_codigo_externo   
end


  
if @w_opcion = 2 
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,        
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,          
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura, 
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,     
   cu_fecha_hasta,      cu_oficina,         cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia
   where    cg_ente             = @i_cliente 
   and      cu_codigo_externo   = cg_codigo_externo
end

if @w_opcion = 3 
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,      cu_oficina,         cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia
   where    cg_oficial          = @i_oficial
   and      cg_principal        = 'D'
   and      cu_codigo_externo   = cg_codigo_externo
end

if @w_opcion = 4 
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,      cu_oficina,         cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia
   where    cu_tipo           = @i_tipo 
   and      cg_principal      = 'D'
   and      cu_codigo_externo = cg_codigo_externo
end

if @w_opcion = 0  or @w_opcion = 5
begin
   insert into cu_tmp_custodia
   select       
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,      cu_fecha_desde,
   cu_fecha_hasta,      cu_oficina,         cu_fecha_vencimiento
   from cu_custodia,cu_cliente_garantia
   where    (cu_sucursal        = @i_sucursal or cu_sucursal = @i_oficina)  
   and      cg_principal        = 'D'
   and      cu_codigo_externo   = cg_codigo_externo
end

if @w_opcion = 15
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,      cu_oficina,         cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia,
            cob_credito..cr_gar_propuesta,
            cob_cartera..ca_operacion,
            cu_tipo_custodia
   where    op_fecha_liq        >= @i_fecha_ingreso3 
   and      op_fecha_liq        <= @i_fecha_ingreso4
   and      cg_principal        = 'D'
   and      cu_codigo_externo   = cg_codigo_externo
   and      tc_tipo_superior    >= @w_garesp 
   and      tc_tipo_superior    < @w_siguiente_tipo
   and      tc_tipo             = cu_tipo
   and      gp_tramite          = op_tramite
   and      gp_garantia         = cu_codigo_externo
end

if @w_opcion = 16
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,     
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,      cu_oficina,     cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia
   where    cu_tipo                 = @i_tipo 
   and      cg_principal            = 'D'
   and      cu_codigo_externo       = cg_codigo_externo
   and     (cu_sucursal             = @i_sucursal or cu_sucursal = @i_oficina)  

end

if @w_opcion = 17
begin
   insert into cu_tmp_custodia
   select 
   @w_conexion,         cu_filial,          cu_sucursal,        cu_custodia,     
   cu_tipo,             cu_estado,          cu_fecha_ingreso,   cu_moneda,        
   cu_valor_inicial,    cu_valor_actual,    cu_codigo_externo,  cu_valor_cobertura,
   cg_ente,             cg_oficial,         cg_nombre,          cu_fecha_desde,
   cu_fecha_hasta,  cu_oficina,     cu_fecha_vencimiento
   from     cu_custodia,
            cu_cliente_garantia,
            cob_credito..cr_gar_propuesta,
            cob_cartera..ca_operacion,
            cu_tipo_custodia
   where    op_fecha_liq        >= @i_fecha_ingreso3 
   and      op_fecha_liq        <= @i_fecha_ingreso4
   and      cg_principal        = 'D'
   and      cu_codigo_externo   = cg_codigo_externo
   and      tc_tipo_superior    >= @w_garesp 
   and      tc_tipo_superior    < @w_siguiente_tipo
   and      tc_tipo             = cu_tipo
   and      gp_tramite          = op_tramite
   and      gp_garantia         = cu_codigo_externo
   and      (cu_sucursal        = @i_sucursal or cu_sucursal = @i_oficina)  
   and      cu_tipo             = @i_tipo 
end



/** ENVIO DE DATOS AL FRONT END **/

if @i_operacion = 'S'
if @i_condicion_est = 7
begin


   set rowcount 10
   select 
   'GARANTIA'               = B.cu_custodia, 
   'CODIGO'                 = B.cu_codigo_externo,
   'TIPO'                   = B.cu_tipo,
   'DESCRIPCION'            = substring(tc_descripcion,1,10),B.cu_sucursal AS ' ',
   'OFICINA'                = substring(of_nombre,1,20),
   'COD.ESTADO'             = B.cu_estado, 
   'ESTADO'                 = (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y
                            where X.tabla = Y.codigo
                            and Y.tabla = 'cu_est_custodia'
                            and B.cu_estado = X.codigo),
   'INGRESO'                = convert(char(10),B.cu_fecha_ingreso,@i_formato_fecha),
   'MON'                    = (select mo_descripcion from cobis..cl_moneda
                                  where mo_moneda = B.cu_moneda),
   'VALOR GARANTIA'         = isnull(B.cu_valor_inicial,isnull(B.cu_valor_refer_comis,0)),  --XTA 21/JUL/1999
   'VALOR ACEPTADO'         = isnull(B.cu_valor_actual, isnull(B.cu_valor_refer_comis,0)),--XTA 21/JUL/1999
   'VALOR GARANTIA (M/L)'   =  convert(money,isnull(B.cu_valor_actual,isnull(B.cu_valor_refer_comis,0)) * isnull(cotizacion,1)), 
   'VALOR COBERTURA'        = isnull(B.cu_valor_cobertura,isnull(B.cu_valor_refer_comis,0)), --XTA 21/JUL/1999
   'CLIENTE'                = cg_ente,
   'NOMBRE CLIENTE'         = substring(cg_nombre,1,30),     --15
   'N. TITULO'              = 1, --ve_vencimiento,
   'FEC. VENCIMIENTO'       = convert(char(10),B.cu_fecha_vencimiento,@i_formato_fecha),
   'ADMISIBILIDAD '         = D.valor,  --jvc
   'COMPARTIDA'             = cu_compartida, --NVR1 
   'CONTABLE'               =(isnull(B.cu_valor_actual, isnull(B.cu_valor_refer_comis,0))), 
   'VALOR COBERTURA (M/L)'  =  convert(money,(isnull(B.cu_valor_cobertura, isnull(B.cu_valor_refer_comis,0)) * isnull(cotizacion,1))), 
   'CONTABILIZA'            = tc_contabilizar
   from cu_custodia B
     inner join cu_tmp_custodia A on
       A.cu_idconn = @w_conexion 
   and B.cu_codigo_externo  = A.cu_codigo_externo
   and A.cu_filial      = @i_filial
   and (A.cu_sucursal   = @i_sucursal or @i_sucursal is null)
   and (A.cu_fecha_ingreso >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null) 
   and (A.cu_fecha_ingreso <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null)    
   and (A.cu_estado = 'X' or A.cu_estado = 'V') 
   and (B.cu_inspeccionar <> 'N' or @i_condicion_est <> 4) 
  -- and ((A.cu_oficina = @i_oficina or @i_oficina is null) or (A.cu_oficina is null and A.cu_sucursal = @i_oficina))
   and (A.cu_custodia >= @i_custodia1 or @i_custodia1 is null)
   and (A.cu_tipo = @i_tipo or @i_tipo is null)   
   and (A.cu_moneda = @i_moneda or @i_moneda is null)
   and (B.cu_abierta_cerrada = @i_caracter or @i_caracter is null)
   and (B.cu_cuantia = @i_cuantia or @i_cuantia is null)
   and (B.cu_clase_custodia =  @i_clase or @i_clase is null) 
   and (B.cu_compartida = @i_compartida or @i_compartida is null)
   and (cu_fnro_documento is null or @i_llama_estado ='S')
   and (((A.cu_tipo = @i_tipo_sig and A.cu_sucursal = @i_ofi_sig and  A.cu_custodia >@i_cust_sig) 
   or (A.cu_tipo = @i_tipo_sig and A.cu_sucursal > @i_ofi_sig ) 
   or (A.cu_tipo > @i_tipo_sig)))
            inner join cobis..cl_oficina on 
                of_oficina = A.cu_sucursal                
                     inner join cu_tipo_custodia on
                      A.cu_tipo = tc_tipo                                         
                         inner join cobis..cl_catalogo D on
                              D.codigo = cu_clase_custodia
                             inner join cobis..cl_tabla C on
                             C.tabla= 'cu_clase_custodia'       
                             and C.codigo = D.tabla 
                             left outer join cu_tmp_cotizacion_moneda on
                               moneda  =  A.cu_moneda 
                               and sesion =  @w_pid_buscus 
   order by B.cu_codigo_externo
   if @@rowcount = 0
   begin

      select @w_error = 1
      goto ERROR
   end

end
else
begin
   set rowcount 10

   select 
   'GARANTIA' = B.cu_custodia, 
   'CODIGO'   = B.cu_codigo_externo,
   'TIPO' = B.cu_tipo,
   'DESCRIPCION'=substring(tc_descripcion,1,10),B.cu_sucursal AS ' ',
   'OFICINA'=substring(of_nombre,1,20),
   'COD.ESTADO' = B.cu_estado, 
   'ESTADO' = (select valor from cobis..cl_catalogo X, cobis..cl_tabla Y
                            where X.tabla = Y.codigo
                            and Y.tabla = 'cu_est_custodia'
                            and B.cu_estado = X.codigo),
   'INGRESO' = convert(char(10),B.cu_fecha_ingreso,@i_formato_fecha),
   'MON' = (select mo_descripcion from cobis..cl_moneda
                                  where mo_moneda = B.cu_moneda),
   'VALOR GARANTIA' = isnull(B.cu_valor_inicial,isnull(B.cu_valor_refer_comis,0)),  
   'VALOR ACEPTADO' = isnull(B.cu_valor_actual, isnull(B.cu_valor_refer_comis,0)),
   'VALOR ACEPTADO (M/L)' =  convert(money,isnull(B.cu_valor_actual,isnull(B.cu_valor_refer_comis,0)) * isnull(cotizacion,1)), 
   'VALOR COBERTURA' = isnull(B.cu_valor_cobertura,isnull(B.cu_valor_refer_comis,0)), 
   'CLIENTE' = cg_ente,
   'NOMBRE CLIENTE' = substring(cg_nombre,1,30),     --15
   'N. TITULO' = 1, 
   'FEC. VENCIMIENTO' = convert(char(10),B.cu_fecha_vencimiento,@i_formato_fecha),
   'ADMISIBILIDAD ' = D.valor,
   'COMPARTIDA' = cu_compartida,
   'CONTABLE'=(isnull(B.cu_valor_actual, isnull(B.cu_valor_refer_comis,0))), 
   'VALOR COBERTURA (M/L)' =  convert(money,(isnull(B.cu_valor_cobertura, isnull(B.cu_valor_refer_comis,0)) 
                * isnull(cotizacion,1))), 
   'CONTABILIZA' = tc_contabilizar
   from cu_custodia B
   inner join cu_tmp_custodia A on
   A.cu_idconn   = @w_conexion   
   and B.cu_codigo_externo = A.cu_codigo_externo
   and A.cu_filial      = @i_filial
   and (A.cu_sucursal   = @i_sucursal or @i_sucursal is null)
   and (A.cu_fecha_ingreso >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null) 
   and (A.cu_fecha_ingreso <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null) 
   and (A.cu_moneda = @i_moneda or @i_moneda is null)
   and (A.cu_estado = @i_estado or @i_estado is null)
   and (A.cu_estado = 'P' or @i_condicion_est <> 1 or @i_condicion_est is null  ) 
   and (A.cu_estado = 'X'  or @i_condicion_est <> 3 or @i_condicion_est is null ) 
   and ((A.cu_estado <> 'C' and A.cu_estado <> 'A') or  @i_condicion_est <> 4 or  @i_condicion_est is null) 
   and (B.cu_inspeccionar <> 'N' or @i_condicion_est <> 4 or  @i_condicion_est is null) 
   and ((A.cu_estado <> 'C' and A.cu_estado <> 'A' or  @i_condicion_est <> 5 or  @i_condicion_est is null))   
   and ((A.cu_estado <> 'A' and A.cu_estado <> 'C'  or @i_condicion_est <> 6 or  @i_condicion_est is null ))  
  -- and ((A.cu_oficina = @i_oficina or @i_oficina is null) or (A.cu_oficina is null and A.cu_sucursal = @i_oficina))
   and (A.cu_custodia >= @i_custodia1 or @i_custodia1 is null)
   and (A.cu_tipo = @i_tipo or @i_tipo is null)      
   and B.cu_codigo_externo > @i_siguiente   
   and (B.cu_abierta_cerrada = @i_caracter or @i_caracter is null)
   and (B.cu_cuantia = @i_cuantia or @i_cuantia is null)
   and (B.cu_clase_custodia =  @i_clase or @i_clase is null) 
   and (B.cu_compartida = @i_compartida or @i_compartida is null)
   and (cu_fnro_documento is null or @i_llama_estado ='S')
   and (((A.cu_tipo = @i_tipo_sig and A.cu_sucursal = @i_ofi_sig and  A.cu_custodia >@i_cust_sig) 
   or (A.cu_tipo = @i_tipo_sig and A.cu_sucursal > @i_ofi_sig ) 
   or (A.cu_tipo > @i_tipo_sig)) )
                inner join cobis..cl_oficina on
                          of_oficina = A.cu_sucursal
                          inner join cu_tipo_custodia on
                                A.cu_tipo = tc_tipo
                               and ((A.cu_estado <> 'C' and A.cu_estado <> 'A' and A.cu_estado <> 'P' or @i_condicion_est <> 2) or (A.cu_estado = 'A' and tc_tipo_superior = @w_valor))
                                inner join cobis..cl_catalogo D on
                                     D.codigo = cu_clase_custodia
                                     inner join cobis..cl_tabla C on
                                     C.tabla= 'cu_clase_custodia'       
                                     and C.codigo = D.tabla                                      
                                             left outer join cu_tmp_cotizacion_moneda on
                                                  moneda  =   A.cu_moneda
                                                   and sesion =  @w_pid_buscus  
   
   order by B.cu_codigo_externo
   if @@rowcount = 0
   begin

      select @w_error = 1
      goto ERROR
   end
end

if @i_operacion = 'W'
begin

  select @w_valor = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'COMISIOFAG'
  and pa_producto = 'GAR'
  set transaction isolation level read uncommitted


  select @w_valor1 = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'NUMDIA'
  and pa_producto = 'GAR'
  set transaction isolation level read uncommitted


if @i_modo <> 1
begin
     if @i_certificado = 0
   begin
  
   set rowcount 20

   select
   'GARANTIA' = B.cu_codigo_externo,
   'OFICINA' = of_nombre,
   'CLIENTE' = substring(A.cg_nombre,1,30),
   'No GARANTIA' = B.cu_custodia,  
   'TIPO GARANTIA' = substring(tc_descripcion,1,10),
   'No CERTIFICADO' = B.cu_num_dcto,
   'FECHA DESDE' = convert(char(10),B.cu_fecha_desde  ,@i_formato_fecha),
   'FECHA HASTA' = convert(char(10),B.cu_fecha_hasta  ,@i_formato_fecha),
   'ADMISIBILIDAD ' = D.valor,
   'FECHA SOL.RECON.' = convert(char(10),B.cu_fecha_sol_rec,@i_formato_fecha),
   'FECHA SOL.RENOV.' = convert(char(10),B.cu_fecha_sol_ren,@i_formato_fecha),
   'FECHA SOL.EXP.' = convert(char(10),B.cu_fecha_sol_exp,@i_formato_fecha),
   'FECHA PRORROGA SOL.' = convert(char(10),B.cu_fecha_pro,@i_formato_fecha),
   'No.ACTA APROB' =B.cu_num_acta_apr ,
   'FECHA APROB.PREVIA' = convert(char(10),B.cu_fecha_apr_pre,@i_formato_fecha),
   'No ACTA APROB PREVIA' = B.cu_num_acta_apr,
   'FECHA VTO GTIA' = convert(char(10),B.cu_fecha_vencimiento,@i_formato_fecha),
   'DIAS TRANSC.' =  isnull(DATEDIFF(dd,B.cu_fecha_sol_exp,@s_date),0),
   'FECHA LIMITE SOL CERT.' = convert(char(10),dateadd(dd,@w_valor1,B.cu_fecha_sol_exp),101), 
   'DIAS PRORROGA'= isnull(DATEDIFF(dd,B.cu_fecha_pro,@s_date),0),
   'No OBLIGACION' = (select distinct(op_banco) from cob_cartera..ca_operacion where op_tramite = G.gp_tramite),
   'DIAS VTO OBL.' = isnull(datediff(dd,(select min(di_fecha_ven) 
                    from cob_cartera..ca_dividendo ,cob_cartera..ca_operacion X
                    where di_operacion = X.op_operacion 
                    and di_estado = 2 and G.gp_tramite = X.op_tramite),@s_date),0)
   from cu_custodia B
             inner join cu_tmp_custodia A on
              A.cu_idconn       = @w_conexion
             and B.cu_codigo_externo = A.cu_codigo_externo
             and A.cu_filial     = @i_filial
             and (A.cu_sucursal  = @i_sucursal or @i_sucursal is null)
             and (A.cu_fecha_ingreso >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null) 
             and (A.cu_fecha_ingreso <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null) 
             and (A.cu_moneda = @i_moneda or @i_moneda is null)
             and (A.cu_estado = @i_estado or @i_estado is null)
             and ((A.cu_custodia = @i_custodia1 and A.cu_custodia <= @i_custodia2)
             --and ((A.cu_oficina = @i_oficina or @i_oficina is null) or (A.cu_oficina is null and A.cu_sucursal = @i_oficina))
             or (@i_custodia1 is null and @i_custodia2 is null))
             and (A.cu_tipo = @i_tipo or @i_tipo is null)
             and B.cu_codigo_externo >= @i_siguiente
             and (A.cu_fecha_vencimiento >= @i_fecha_ingreso5 or @i_fecha_ingreso5 is null)
             and (A.cu_fecha_vencimiento <= @i_fecha_ingreso6 or @i_fecha_ingreso6 is null)
             and B.cu_num_dcto is not null
                    inner join cobis..cl_oficina on
                    of_oficina = A.cu_sucursal
                           inner join cu_tipo_custodia on
                           (tc_tipo_superior >= @w_garesp and tc_tipo_superior < @w_siguiente_tipo)
                            and (A.cu_tipo = tc_tipo)
                                     inner join cobis..cl_catalogo D on
                                     D.codigo= cu_clase_custodia
                                             inner join cobis..cl_tabla C on
                                             C.tabla= 'cu_clase_custodia'    
                                             and C.codigo= D.tabla
                                                 inner join cob_credito..cr_gar_propuesta G on
                                                 A.cu_codigo_externo = G.gp_garantia
                                                 and (G.gp_est_garantia <> 'A' and G.gp_est_garantia <> 'C')
                                                      left outer join cu_tmp_cotizacion_moneda on
                                                       moneda  =   A.cu_moneda
                                                       and sesion =  @w_pid_buscus   
                                                 order by B.cu_codigo_externo
  
   if @@rowcount = 0
   begin

      select @w_error = 1
      goto ERROR
   end
   end 

   if @i_certificado = 1
   begin
   set rowcount 20
   select  
  'GARANTIA' = B.cu_codigo_externo,
   'OFICINA' = of_nombre,
   'CLIENTE' = substring(A.cg_nombre,1,30),
   'No GARANTIA' = B.cu_custodia,  
   'TIPO GARANTIA' = substring(tc_descripcion,1,10),
   'No CERTIFICADO' = B.cu_num_dcto,
   'FECHA DESDE' = convert(char(10),B.cu_fecha_desde  ,@i_formato_fecha),
   'FECHA HASTA' = convert(char(10),B.cu_fecha_hasta  ,@i_formato_fecha),
   'ADMISIBILIDAD ' = D.valor,
   'FECHA SOL.RECON.' = convert(char(10),B.cu_fecha_sol_rec,@i_formato_fecha),
   'FECHA SOL.RENOV.' = convert(char(10),B.cu_fecha_sol_ren,@i_formato_fecha),
   'FECHA SOL.EXP.' = convert(char(10),B.cu_fecha_sol_exp,@i_formato_fecha),
   'FECHA PRORROGA SOL.' = convert(char(10),B.cu_fecha_pro,@i_formato_fecha),
   'No.ACTA APROB' =B.cu_num_acta_apr ,
   'FECHA APROB.PREVIA' = convert(char(10),B.cu_fecha_apr_pre,@i_formato_fecha),
   'No ACTA APROB PREVIA' = B.cu_num_acta_apr,  
   'FECHA VTO GTIA' = convert(char(10),B.cu_fecha_vencimiento,@i_formato_fecha),
   'DIAS TRANSC.' =  isnull(DATEDIFF(dd,B.cu_fecha_sol_exp,@s_date),0),
   'FECHA LIMITE SOL CERT.' = convert(char(10),dateadd(dd,@w_valor1,B.cu_fecha_sol_exp),101), 
   'DIAS PRORROGA'= isnull(DATEDIFF(dd,B.cu_fecha_pro,@s_date),0),
   'No OBLIGACION' = (select distinct(op_banco) from cob_cartera..ca_operacion where op_tramite = G.gp_tramite),
   'DIAS VTO OBL.' = isnull(datediff(dd,(select min(di_fecha_ven) 
                     from cob_cartera..ca_dividendo ,cob_cartera..ca_operacion X
                     where di_operacion = X.op_operacion 
                     and di_estado = 2 and G.gp_tramite = X.op_tramite),@s_date),0)
   from cu_custodia B
             inner join cu_tmp_custodia A on
             A.cu_idconn       = @w_conexion
             and B.cu_codigo_externo = A.cu_codigo_externo
             and A.cu_filial     = @i_filial
             and (A.cu_sucursal   = @i_sucursal or @i_sucursal is null)
             and (A.cu_fecha_ingreso >= @i_fecha_ingreso1 or @i_fecha_ingreso1 is null) 
             and (A.cu_fecha_ingreso <= @i_fecha_ingreso2 or @i_fecha_ingreso2 is null) 
             and (A.cu_moneda = @i_moneda or @i_moneda is null)
             and (A.cu_estado = @i_estado or @i_estado is null)
             and ((A.cu_custodia = @i_custodia1 and A.cu_custodia <= @i_custodia2)
             or (@i_custodia1 is null and @i_custodia2 is null))
             and (A.cu_tipo = @i_tipo or @i_tipo is null)      
             and B.cu_codigo_externo >= @i_siguiente   
             and (A.cu_fecha_vencimiento >= @i_fecha_ingreso5 or @i_fecha_ingreso5 is null)
             and (A.cu_fecha_vencimiento <= @i_fecha_ingreso6 or @i_fecha_ingreso6 is null)
             and B.cu_num_dcto is not null
         --    and ((A.cu_oficina = @i_oficina or @i_oficina is null) or (A.cu_oficina is null and A.cu_sucursal = @i_oficina)) 
                   inner join cobis..cl_oficina on
                   of_oficina = A.cu_sucursal                         
                            inner join cu_tipo_custodia on
                            (tc_tipo_superior >= @w_garesp and tc_tipo_superior < @w_siguiente_tipo)
                            and (A.cu_tipo = tc_tipo) 
                                inner join cobis..cl_catalogo D on
                                D.codigo= cu_clase_custodia
                                    inner join cobis..cl_tabla C on
                  C.tabla= 'cu_clase_custodia'    
                                    and C.codigo= D.tabla 
                                        inner join cob_credito..cr_gar_propuesta G on
                                        A.cu_codigo_externo = G.gp_garantia
                                        and (G.gp_est_garantia <> 'A' and G.gp_est_garantia <> 'C')  
                                             left outer join cu_tmp_cotizacion_moneda on
                                             moneda  =   A.cu_moneda
                                             and sesion =  @w_pid_buscus
                               order by B.cu_codigo_externo
   if @@rowcount = 0
   begin
      select @w_error = 1
      goto ERROR
   end
   end
end --modo 1
else
begin
   set rowcount 20
   select   GARANTIA      = cu_codigo_externo,
        VALOR_GARANTIA    = cu_valor_inicial,
        PORCENTAJE    = cu_porcentaje_cobertura,
        CLASE         = cu_abierta_cerrada,
        IDONEIDAD     = cu_clase_custodia,
        CUANTIA       = cu_cuantia,
        AGOTADA       = cu_agotada
   from     cob_custodia..cu_custodia
   where    cu_codigo_externo = @i_codigo_externo

   if @@rowcount = 0
   begin

      select @w_error = 1
      goto ERROR
   end
end
end

if @i_operacion = 'Q'
begin
            
    select @w_tipo_personal = pa_char
    from cobis..cl_parametro
    where pa_producto = 'GAR'
      and pa_nemonico = 'GPE'
      
    --SRO Popover Mas Informacion Garantias
    select 	@w_fecha_max = max(dc_fecha)
    from cob_conta_super..sb_dato_custodia
    where dc_garantia = @i_codigo_externo
    and datediff(dd,  getdate(),dc_fecha) < 0 



    select  	'codigo_externo' 	=  cu_codigo_externo,
					'tipo' 				=  cu_tipo,
					'descripcion'    	=  substring(tc_descripcion,1,35),
					'abierta_cerrada'	=  (select valor from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cu_caracter'and c.codigo = cu_abierta_cerrada),
					'id_garante' 		=  cu_garante,
					'id_cliente' 		=  cg_ente,
					'nombre_gar' 		=  isnull(substring(b.en_nomlar,1,datalength(b.en_nomlar)),''), 		  
					'custodia' 			=  cu_custodia,
					'sucursal' 			=  cu_sucursal,
					'nombre_of'      	=  of_nombre,
					'moneda' 			=  cu_moneda,
					'valor_actual' 		=  cu_valor_actual,
					'valor_inicial' 	=  cu_valor_inicial, 	
					'fecha_avaluo' 		=  case when dc.dc_fecha_avaluo is null 
                                                    then convert(varchar(10), cu_fecha_avaluo,103)
                                                else convert(varchar(10), dc.dc_fecha_avaluo,103)
                                           end,
					'estado' 			=  (select valor from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cu_est_custodia 'and c.codigo = cu_estado),
					'usuario_crea'		=  cu_usuario_crea,
					'esPersonal'    	=  case when cu_tipo = @w_tipo_personal then 'S' else  'N' end,
					'nombre_cli'        =  isnull(substring(a.en_nomlar,1,datalength(a.en_nomlar)),''),
					'ubicacion'         =  c.valor,
					'moneda_desc'       = (select mo_nemonico from cobis..cl_moneda where mo_moneda = convert(char(10),cu_moneda)),
					'fecha_ing' 		= convert(varchar(10), cu_fecha_ingreso, 103), 
					'fecha_ven'			= convert(varchar(10), cu_fecha_vencimiento, 103),
                    'disponible'        = cu_disponible,
                    'calidad'           = (select A.valor from cobis..cl_catalogo A, cobis..cl_tabla B
                                            where B.codigo = A.tabla
                                            and B.tabla = 'cu_grado_gtia'
                                            and A.codigo = cu_grado_gar),
                    'valor_comercial'   = dc.dc_valor_avaluo,
                    'valor_utilizado'   = dc.dc_valor_uti_opera,
					'oficina_contable'  = cu_oficina_contabiliza,
					'oficina_cont_desc' = (select of_nombre from cobis..cl_oficina where of_oficina = cu_oficina_contabiliza),
					'estado_cod'        = cu_estado
		   from  cob_custodia..cu_custodia WITH (index (cu_custodia_Key))LEFT JOIN cobis..cl_ente b ON cu_garante = b.en_ente  
                 LEFT JOIN cob_conta_super..sb_dato_custodia dc ON dc.dc_garantia = cu_codigo_externo,
				 cob_custodia..cu_cliente_garantia with(index (cu_cliente_garantia_Key)) LEFT JOIN cobis..cl_ente a ON cg_ente = a.en_ente ,
				 cob_custodia..cu_tipo_custodia,
                 cobis..cl_oficina,
				 cobis..cl_catalogo c,
				 cobis..cl_tabla t                 
           where (cu_filial   = 1) 
             and (cu_sucursal = of_oficina) 
             and (cu_tipo     = tc_tipo) 
             and (cg_codigo_externo = cu_codigo_externo)
			 and c.tabla = t.codigo
			 and t.tabla = 'cu_ubicacion_doc'
			 and cu_ubicacion = c.codigo
             and cu_codigo_externo = @i_codigo_externo
			 and (convert(char(10),dc.dc_fecha,103) = convert(char(10),@w_fecha_max,103) OR @w_fecha_max is null)
             --and (dc.dc_fecha = @w_fecha_max or @w_fecha_max is null)
        order by cg_codigo_externo
	
end


delete from cu_tmp_custodia
where  cu_idconn = @w_conexion

return 0

ERROR:

delete from cu_tmp_custodia
where  cu_idconn = @w_conexion


if @w_error = 1 print 'No existen mas garantias'
else 
  if @w_error <> 0 
begin
print  'Ingrese al menos un criterio de busqueda principal'
return 1 
end
go
