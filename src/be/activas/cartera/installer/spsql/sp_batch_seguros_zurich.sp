/************************************************************************/
/*   Archivo:              sp_batch_seguros_zurich.sp                   */
/*   Stored procedure:     sp_batch_seguros_zurich                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Johan Castro                                 */
/*   Fecha de escritura:   26/08/2020                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Genera un archivo plano para reportar los préstamos que de los que */
/*  no se ha podido cobrar el seguro                                    */
/************************************************************************/
/*                               CAMBIOS                                */
/*     FECHA      AUTOR                 CAMBIO                          */
/*   26/08/2020    JCA    Emision Inicial                               */
/*   05/11/2020    SRO    Error #148949                                 */
/*   26/11/2020    ACH    Error #149973                                 */
/*   17/11/2020    JCA    REQ#149235                                    */
/*   15/06/2022    DCU    Req.#168293                                   */
/*   19/07/2021    ACH    REQ 185234-V2 se agrega op individuales       */
/*   28/08/2023    ACH    ERR#213798 Apellido ZURICH - '' a 'NA'        */
/************************************************************************/
use cob_cartera
go 

if exists (select 1 from sysobjects where name = 'sp_batch_seguros_zurich')
   drop proc sp_batch_seguros_zurich
go 

create proc sp_batch_seguros_zurich
       @i_param1 datetime = null
as
declare
@w_sp_name             varchar(32),          
@w_path_destino        varchar(200),  
@w_s_app               varchar(40),
@w_cmd                 varchar(5000),
@w_destino             varchar(255),
@w_errores             varchar(255),
@w_comando             varchar(6000),
@w_error               int, 
@w_path                varchar(255),
@w_mensaje             varchar(100),
@w_nro_poliza          varchar(30),
@w_anio_poliza         int,
@w_producto            varchar(30),
@w_long_cobertura      int,
@w_seguro_vida         money,
@w_seguro_infarto_cer  money,
@w_seguro_infarto_mioc money,
@w_seguro_cancer       money,
@w_porc_comision       float,
@w_fecha_proc          datetime,
@w_fecha_fin           datetime,
@w_ffecha              int,
@w_pais                varchar(10),
@w_gen_arch_dom_seg    char(1),
@w_ciudad_nacional     int,
@w_fecha_ini           DATETIME,
@w_est_vigente         tinyint,
@w_est_novigente       tinyint,
@w_est_vencido         tinyint,
@w_est_cancelado       tinyint,
@w_est_suspenso        tinyint, 
@w_est_castigado       tinyint,
@w_est_diferido        tinyint,
@w_meses_reporte_cons  int,
@w_monto_seguro        money,
@w_query               varchar(255),
@w_col_id              int,
@w_columna             varchar(255),
@w_ambiente            varchar(8),
@w_cabecera            varchar(2000),
@w_nombre_a            varchar(50),
@w_nombre_p            varchar(50),
@w_nombre_m            varchar(50),
@w_dir1                varchar(50),
@w_dir2                varchar(50),
@w_estado              varchar(50),
@w_ciudad              varchar(50),
@w_ente                int,
@w_fec_ini_zurich      datetime,
@w_fec_feriado         datetime    = null,
@w_dias_diff           int         = 0,
@w_cont_dias           int         = 0,
@w_meses_reporte_ind   int         = 0
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
create table  #seguros_zurich (
sz_nro_poliza          varchar (18)   null,
sz_anio_poliza         int            null,
sz_producto            varchar (20)   null,
sz_ente                int            null, 
sz_sucursal            varchar (5)    null,
sz_nro_prestamo        varchar (12)   null,
sz_nro_certificado     varchar (12)   null,
sz_mes_emision         varchar (2)    null,
sz_fecha_endoso        varchar (10)   null,
sz_fecha_efectiva      varchar (10)   null,
sz_fecha_expiracion    varchar (10)   null,
sz_long_cobertura      int            null,
sz_pais                varchar (6)    null,
sz_moneda              varchar (3)    null,
sz_vendedor            varchar (20)   null,
sz_nombre_asegurado    varchar (20)   null,
sz_apellido_paterno    varchar (20)   null,
sz_apellido_materno    varchar (20)   null,
sz_direccion1          varchar (40)   null,
sz_direccion2          varchar (40)   null,
sz_ciudad              varchar (40)   null,
sz_estado              varchar (40)   null,
sz_cod_postal          varchar (5)    null,
sz_telefono            varchar (10)   null,
sz_email               varchar (50)   null,
sz_genero              CHAR (1)       null,
sz_rfc                 varchar (13)   null,
sz_edad                int            null,
sz_fecha_nac           varchar (10)   null,
sz_nombre_1            varchar (20)   null,
sz_rfc_1               varchar (13)   null,
sz_fecha_nac_1         varchar (10)   null,
sz_sexo_1              varchar (2)    null,
sz_porcentaje_1        varchar (2)    null,
sz_nombre_2            varchar (20)   null,
sz_rfc_2               varchar (13)   null,
sz_fecha_nac_2         varchar (10)   null,
sz_sexo_2              varchar (2)    null,
sz_porcentaje_2        varchar (2)    null,
sz_nombre_3            varchar (20)   null,
sz_rfc_3               varchar (13)   null,
sz_fecha_nac_3         varchar (10)   null,
sz_sexo_3              varchar (2)    null,
sz_porcentaje_3        varchar (2)    null,
sz_cta_banco           varchar (45)   null,
sz_seguro_vida         numeric (10,2) null,
sz_seguro_infarto_cer  numeric (10,2) null,
sz_seguro_infarto_mioc numeric (10,2) null,
sz_seguro_cancer       numeric (10,2) null,
sz_monto_prima         numeric (10,2) null,
sz_comision            numeric (6,2)  null,
sz_direccion           varchar (255)  null,
sz_meses_expiracion    int            null,
sz_nro_reporte         int            null,
sz_monto_credito       numeric (10,2) null,
sz_tipo_seguro         varchar (16)   null
)
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
select @w_sp_name  = 'sp_batch_seguros_zurich'

if @i_param1 is null 
   select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso 
else 
   select @w_fecha_proc = @i_param1
   

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
select @w_ffecha              = 103
select @w_long_cobertura      = 4
select @w_fecha_fin           = @w_fecha_proc
select @w_nro_poliza          = pa_char  from cobis..cl_parametro where pa_nemonico='NRPOLZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_anio_poliza         = pa_int   from cobis..cl_parametro where pa_nemonico='ANPOLZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_producto            = pa_char  from cobis..cl_parametro where pa_nemonico='SEPROZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_seguro_vida         = pa_money from cobis..cl_parametro where pa_nemonico='SVIDAZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_seguro_infarto_cer  = pa_money from cobis..cl_parametro where pa_nemonico='SIFCEZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_seguro_infarto_mioc = pa_money from cobis..cl_parametro where pa_nemonico='SIFMIZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_seguro_cancer       = pa_money from cobis..cl_parametro where pa_nemonico='SCANZ'  and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_porc_comision       = pa_float from cobis..cl_parametro where pa_nemonico='COMSEZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_ambiente            = pa_char  from cobis..cl_parametro where pa_nemonico='AMBISZ' and pa_producto='CCA' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_monto_seguro        = pa_money from cobis..cl_parametro where pa_nemonico='MONSEZ' and pa_producto='ADM' if @@rowcount = 0 begin select @w_error = 101077 goto ERROR end
select @w_meses_reporte_cons  = isnull(pa_int,4)  from cobis..cl_parametro where pa_nemonico='MERECO' and pa_producto='CCA'
select @w_meses_reporte_ind   = isnull(pa_int,4)  from cobis..cl_parametro where pa_nemonico='MEREIN' and pa_producto='CCA'

select @w_fec_ini_zurich      = isnull(pa_datetime, '10/24/2020')  from cobis..cl_parametro where pa_nemonico='FEINZU' and pa_producto='CCA'

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
SELECT @w_pais = valor 
FROM   cobis..cl_catalogo 
WHERE  tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_pais') 
AND    codigo  = 484 --mexico
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

--PARAMETRO PARA INDICAR SI SE PAGA O NO EL SEGURO
select @w_gen_arch_dom_seg = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'GADOSE'   
   
select @w_gen_arch_dom_seg = isnull(@w_gen_arch_dom_seg, 'N')  

--CIUDAD DE FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--SRO. Encontrar Feriado/Fin de semana anterior
select @w_fec_feriado = dateadd(dd, -1, @w_fecha_proc)

if exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fec_feriado and df_ciudad = @w_ciudad_nacional) begin

   while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fec_feriado and df_ciudad = @w_ciudad_nacional)
   begin   
      select @w_fec_feriado = dateadd(dd, -1,@w_fec_feriado)   
      if not exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fec_feriado and df_ciudad = @w_ciudad_nacional) begin
         select @w_fec_feriado = dateadd(dd, 1,@w_fec_feriado)
   	     break
      end
   end
   
end else begin
   select @w_fec_feriado = null
end


print 'Fecha Proceso:'+ convert (varchar, @w_fecha_proc)
print 'Fecha Feriados/Fines de semana: '+ convert (varchar, @w_fec_feriado)

 /* ESTADOS DE CARTERA */
exec @w_error = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  OUT

--CONDICION DE SALIDA EN CASO DE DOBLE CIERRE POR FIN DE MES NO SE DEBE EJECUTAR
if exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_fin) 
   return 0 
 	  

insert into #seguros_zurich
select distinct
sz_nro_poliza                 =    tg_prestamo,  
sz_anio_poliza                =    @w_anio_poliza,
sz_producto                   =    substring(@w_producto,1,20),
sz_ente                       =    se_cliente,
sz_sucursal                   =    convert(varchar, op_oficina),
sz_nro_prestamo               =    op_banco, 
sz_nro_certificado            =    convert(varchar, op_oficina),
sz_mes_emision                =    convert(varchar(2),datepart(mm,op_fecha_liq)),
sz_fecha_endoso               =    ' ',
sz_fecha_efectiva             =    convert(varchar(10), op_fecha_liq, @w_ffecha),
sz_fecha_expiracion           =    CONVERT(varchar(10), dateadd(mm,ceiling((op_plazo) / 4.0),op_fecha_liq), @w_ffecha),
sz_long_cobertura             =    ceiling((op_plazo) / 4.0),
sz_pais                       =    @w_pais,
sz_moneda                     =    'MXN',
sz_vendedor                   =    op_oficial, 
sz_nombre_asegurado           =    ' ',
sz_apellido_paterno           =    ' ',
sz_apellido_materno           =    ' ',
sz_direccion1                 =    ' ',
sz_direccion2                 =    ' ', 
sz_ciudad                     =    ' ',
sz_estado                     =    ' ',
sz_cod_postal                 =    ' ',
sz_telefono                   =    ' ',
sz_email                      =    ' ',
sz_genero                     =    ' ',
sz_rfc                        =    ' ',
sz_edad                       =     0,
sz_fecha_nac                  =    ' ',
sz_nombre_1                   =    ' ',
sz_rfc_1                      =    ' ',
sz_fecha_nac_1                =    ' ',
sz_sexo_1                     =    ' ',
sz_porcentaje_1               =    ' ',
sz_nombre_2                   =    ' ',
sz_rfc_2                      =    ' ',
sz_fecha_nac_2                =    ' ',
sz_sexo_2                     =    ' ',
sz_porcentaje_2               =    ' ',
sz_nombre_3                   =    ' ',
sz_rfc_3                      =    ' ',
sz_fecha_nac_3                =    ' ',
sz_sexo_3                     =    ' ',
sz_porcentaje_3               =    ' ',
sz_cta_banco                  =    ' ',
sz_seguro_vida                =    round(@w_seguro_vida,2),
sz_seguro_infarto_cer         =    round(@w_seguro_infarto_cer,2),
sz_seguro_infarto_mioc        =    round(@w_seguro_infarto_mioc,2),
sz_seguro_cancer              =    round(@w_seguro_cancer,2),
sz_monto_prima                =    0,
sz_comision                   =    round((se_monto*@w_porc_comision)/100,2),
sz_direccion                  =    ' ',
sz_meses_expiracion           =    datediff(mm,op_fecha_ini, op_fecha_fin),
sz_nro_reporte                =    1,
sz_monto_credito              =    0,
sz_tipo_seguro                =    se_tipo_seguro
from  cob_cartera..ca_seguro_externo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion 
where se_cliente              =  op_cliente
and   tg_operacion            =  op_operacion
and   tg_tramite              =  se_tramite
and   (isnull(se_monto_pagado,0)-isnull(se_monto_devuelto,0)) >= 0
and   datediff(dd,op_fecha_liq, @w_fecha_proc) = 0
and   op_estado               =  @w_est_vigente
and se_tipo_seguro           in ('BASICO', 'EXTENDIDO')
and   se_fecha_reporte is null 
order by op_banco asc

--SRO.Se agrega para seguros de operaciones de 8 meses (2da poliza por 4 meses)
insert into #seguros_zurich
select 
sz_nro_poliza                 =    tg_prestamo,  
sz_anio_poliza                =    @w_anio_poliza,
sz_producto                   =    substring(@w_producto,1,20),
sz_ente                       =    se_cliente,
sz_sucursal                   =    convert(varchar, op_oficina),
sz_nro_prestamo               =    op_banco, 
sz_nro_certificado            =    convert(varchar, op_oficina), 
sz_mes_emision                =    convert(varchar(2),  datepart(mm, dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)))),
sz_fecha_endoso               =    ' ',
sz_fecha_efectiva             =    convert(varchar(10), dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)), @w_ffecha),
sz_fecha_expiracion           =    convert(varchar(10), dateadd(mm, @w_meses_reporte_cons * 2 , dateadd( dd, 1, op_fecha_liq)), @w_ffecha),
sz_long_cobertura             =    @w_meses_reporte_cons,
sz_pais                       =    @w_pais,
sz_moneda                     =    'MXN',
sz_vendedor                   =    op_oficial, 
sz_nombre_asegurado           =    ' ',
sz_apellido_paterno           =    ' ',
sz_apellido_materno           =    ' ',
sz_direccion1                 =    ' ',
sz_direccion2                 =    ' ', 
sz_ciudad                     =    ' ',
sz_estado                     =    ' ',
sz_cod_postal                 =    ' ',
sz_telefono                   =    ' ',
sz_email                      =    ' ',
sz_genero                     =    ' ',
sz_rfc                        =    ' ',
sz_edad                       =    0,
sz_fecha_nac                  =    ' ',
sz_nombre_1                   =    ' ',
sz_rfc_1                      =    ' ',
sz_fecha_nac_1                =    ' ',
sz_sexo_1                     =    ' ',
sz_porcentaje_1               =    ' ',
sz_nombre_2                   =    ' ',
sz_rfc_2                      =    ' ',
sz_fecha_nac_2                =    ' ',
sz_sexo_2                     =    ' ',
sz_porcentaje_2               =    ' ',
sz_nombre_3                   =    ' ',
sz_rfc_3                      =    ' ',
sz_fecha_nac_3                =    ' ',
sz_sexo_3                     =    ' ',
sz_porcentaje_3               =    ' ',
sz_cta_banco                  =    ' ',
sz_seguro_vida                =    round(@w_seguro_vida,2),
sz_seguro_infarto_cer         =    round(@w_seguro_infarto_cer,2),
sz_seguro_infarto_mioc        =    round(@w_seguro_infarto_mioc,2),
sz_seguro_cancer              =    round(@w_seguro_cancer,2),
sz_monto_prima                =    0,
sz_comision                   =    round((se_monto*@w_porc_comision)/100,2),
sz_direccion                  =    ' ',
sz_meses_expiracion           =    datediff(mm,op_fecha_ini, op_fecha_fin),
sz_nro_reporte                =    2,
sz_monto_credito              =    0,
sz_tipo_seguro                =    se_tipo_seguro
from cob_cartera..ca_seguro_externo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
where se_cliente              = op_cliente
and   tg_operacion            = op_operacion
and   tg_tramite              = se_tramite
and   (isnull(se_monto_pagado,0)-isnull(se_monto_devuelto,0)) > 0
and   datediff(dd,dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)), @w_fecha_proc) = 0
and   datediff(mm,op_fecha_ini, op_fecha_fin)  > 4
and   op_estado               = @w_est_vigente
and   se_tipo_seguro          in ('BASICO', 'EXTENDIDO')
and   datediff(dd, @w_fec_ini_zurich, op_fecha_liq) < 0
order by op_banco asc

-- OBTENER SEGUNDA PARTE REPORTE DE SEGUROS PARA OPERACIONES DESPLAZADAS CUYO SEGURO EMPICE EN SABADO, DOMINGO Y FERIADO
if @w_fec_feriado is not null begin
   print 'Entro Feriado'
   select 
   @w_dias_diff = datediff(dd, @w_fec_feriado, @w_fecha_proc),
   @w_cont_dias = 1
   
   while @w_cont_dias <= @w_dias_diff begin
      
      insert into #seguros_zurich
      select 
      sz_nro_poliza                 =    tg_prestamo,
      sz_anio_poliza                =    @w_anio_poliza,
      sz_producto                   =    @w_producto,
      sz_ente                       =    se_cliente,
      sz_sucursal                   =    convert(varchar, op_oficina),
      sz_nro_prestamo               =    op_banco, 
      sz_nro_certificado            =    convert(varchar, op_oficina),
      sz_mes_emision                =    convert(varchar(2),  datepart(mm, dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)))),
      sz_fecha_endoso               =    ' ',
      sz_fecha_efectiva             =    convert(varchar(10), dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)), @w_ffecha),
      sz_fecha_expiracion           =    convert(varchar(10), dateadd(mm, @w_meses_reporte_cons * 2 , dateadd( dd, 1, op_fecha_liq)), @w_ffecha),
      sz_long_cobertura             =    @w_long_cobertura, 
      sz_pais                       =    @w_pais,
      sz_moneda                     =    'MXN',
      sz_vendedor                   =    op_oficial, 
      sz_nombre_asegurado           =    '',
      sz_apellido_paterno           =    '',
      sz_apellido_materno           =    '',
      sz_direccion1                 =    '',
      sz_direccion2                 =    '', 
      sz_ciudad                     =    '',
      sz_estado                     =    '',
      sz_cod_postal                 =    '',
      sz_telefono                   =    '',
      sz_email                      =    '',
      sz_genero                     =    '',
      sz_rfc                        =    '',
      sz_edad                       =     0,
      sz_fecha_nac                  =    '',
      sz_nombre_1                   =    '',
      sz_rfc_1                      =    '',
      sz_fecha_nac_1                =    '',
      sz_sexo_1                     =    '',
      sz_porcentaje_1               =    '',
      sz_nombre_2                   =    '',
      sz_rfc_2                      =    '',
      sz_fecha_nac_2                =    '',
      sz_sexo_2                     =    '',
      sz_porcentaje_2               =    '',
      sz_nombre_3                   =    '',
      sz_rfc_3                      =    '',
      sz_fecha_nac_3                =    '',
      sz_sexo_3                     =    '',
      sz_porcentaje_3               =    '',
      sz_cta_banco                  =    '',
      sz_seguro_vida                =    round(@w_seguro_vida,2),
      sz_seguro_infarto_cer         =    round(@w_seguro_infarto_cer,2),
      sz_seguro_infarto_mioc        =    round(@w_seguro_infarto_mioc,2),
      sz_seguro_cancer              =    round(@w_seguro_cancer,2),
      sz_monto_prima                =    case when se_tipo_seguro = 'BASICO' then @w_monto_seguro
      									    else round(isnull(se_monto_pagado,0) - isnull(se_monto_devuelto,0),2)                                       
      								     end,
      sz_comision                   =    round((se_monto*@w_porc_comision)/100,2),
      sz_direccion                  =    '',
      sz_meses_expiracion           =    datediff(mm,op_fecha_ini, op_fecha_fin),
      sz_nro_reporte                =    2,
      sz_monto_credito              =    0,
      sz_tipo_seguro                =    se_tipo_seguro	  
      from cob_cartera..ca_seguro_externo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion
      where se_cliente              = op_cliente
      and   tg_operacion            = op_operacion
      and   tg_tramite              = se_tramite
      and   (isnull(se_monto_pagado,0)-isnull(se_monto_devuelto,0)) > 0
      and   datediff(dd,dateadd( dd, 1, dateadd(mm, @w_meses_reporte_cons , op_fecha_liq)), dateadd(dd, -@w_cont_dias, @w_fecha_proc) ) = 0
      and   datediff(mm,op_fecha_ini, op_fecha_fin)  > 4
      and   op_estado                                = @w_est_vigente
      and   se_tipo_seguro          in ('BASICO', 'EXTENDIDO')
      and   datediff(dd, @w_fec_ini_zurich, op_fecha_liq) < 0
      order by op_banco asc
	  
	  select @w_cont_dias = @w_cont_dias + 1
   end
   
end

--------------------------Otros tipos de creditos INDIVIDUALES------------------------------
select distinct
banco       = op_banco,
plazo       = op_plazo,
tplazo      = op_tplazo, 
periodo_cap = op_periodo_cap,
plazo_mes = ceiling(op_plazo /case 
					when op_tplazo = 'M' then 1.0
					when op_tplazo = 'W' and op_periodo_cap = 1 then 30.0/7.0
					when op_tplazo = 'W' and op_periodo_cap = 2 then 30.0/14.0
					when op_tplazo = 'Q' and op_periodo_cap = 2 then 2.0
					when op_tplazo = 'D' then 30.0
					else 
					   1.0
					end )
into #plazo_operacion
from  cob_cartera..ca_seguro_externo, cob_cartera..ca_operacion 
where se_cliente              =  op_cliente
and   op_toperacion           = 'INDIVIDUAL'
and   op_tramite              =  se_tramite
and   (isnull(se_monto_pagado,0)-isnull(se_monto_devuelto,0)) >= 0
and   datediff(dd,op_fecha_liq, @w_fecha_proc) = 0
and   op_estado               =  @w_est_vigente
and se_tipo_seguro           in ('BASICO', 'EXTENDIDO')
and   se_fecha_reporte is null 
order by op_banco asc

insert into #seguros_zurich
select distinct
sz_nro_poliza                 =    op_banco,  
sz_anio_poliza                =    @w_anio_poliza,
sz_producto                   =    substring(@w_producto,1,20),
sz_ente                       =    se_cliente,
sz_sucursal                   =    convert(varchar, op_oficina),
sz_nro_prestamo               =    op_banco, 
sz_nro_certificado            =    convert(varchar, op_oficina),
sz_mes_emision                =    convert(varchar(2),datepart(mm,op_fecha_liq)),
sz_fecha_endoso               =    ' ',
sz_fecha_efectiva             =    convert(varchar(10), op_fecha_liq, @w_ffecha),
sz_fecha_expiracion           =    case when plazo_mes < @w_meses_reporte_ind   then
                                       CONVERT(varchar(10), dateadd(dd, 0,dateadd(mm, @w_meses_reporte_ind ,op_fecha_liq)),@w_ffecha)
									else 
									   CONVERT(varchar(10),dateadd(dd, 0,dateadd(mm,plazo_mes,op_fecha_liq)),@w_ffecha)
									end,
sz_long_cobertura             =    case when plazo_mes < @w_meses_reporte_ind then
										@w_meses_reporte_ind
                                    else 
									    plazo_mes
				                    end,
sz_pais                       =    @w_pais,
sz_moneda                     =    'MXN',
sz_vendedor                   =    op_oficial, 
sz_nombre_asegurado           =    ' ',
sz_apellido_paterno           =    ' ',
sz_apellido_materno           =    ' ',
sz_direccion1                 =    ' ',
sz_direccion2                 =    ' ', 
sz_ciudad                     =    ' ',
sz_estado                     =    ' ',
sz_cod_postal                 =    ' ',
sz_telefono                   =    ' ',
sz_email                      =    ' ',
sz_genero                     =    ' ',
sz_rfc                        =    ' ',
sz_edad                       =     0,
sz_fecha_nac                  =    ' ',
sz_nombre_1                   =    ' ',
sz_rfc_1                      =    ' ',
sz_fecha_nac_1                =    ' ',
sz_sexo_1                     =    ' ',
sz_porcentaje_1               =    ' ',
sz_nombre_2                   =    ' ',
sz_rfc_2                      =    ' ',
sz_fecha_nac_2                =    ' ',
sz_sexo_2                     =    ' ',
sz_porcentaje_2               =    ' ',
sz_nombre_3                   =    ' ',
sz_rfc_3                      =    ' ',
sz_fecha_nac_3                =    ' ',
sz_sexo_3                     =    ' ',
sz_porcentaje_3               =    ' ',
sz_cta_banco                  =    ' ',
sz_seguro_vida                =    round(@w_seguro_vida,2),
sz_seguro_infarto_cer         =    round(@w_seguro_infarto_cer,2),
sz_seguro_infarto_mioc        =    round(@w_seguro_infarto_mioc,2),
sz_seguro_cancer              =    round(@w_seguro_cancer,2),
sz_monto_prima                =    0,
sz_comision                   =    round((se_monto*@w_porc_comision)/100,2),
sz_direccion                  =    ' ',
sz_meses_expiracion           =    case when plazo_mes < @w_meses_reporte_ind then
                                      @w_meses_reporte_ind
                                   else 
                                      plazo_mes
								   end,
sz_nro_reporte                =    1,
sz_monto_credito              =    0,
sz_tipo_seguro                =    se_tipo_seguro
from   cob_cartera..ca_operacion , #plazo_operacion, cob_cartera..ca_seguro_externo
where op_banco                =  banco
and   se_cliente              =  op_cliente
and   se_tramite              =  op_tramite
order by op_banco asc

--------------------------FIN Otros tipos de creditos INDIVIDUALES------------------------------

/*SRO. Se borra las operaciones que no nacieron desplazadas */
delete #seguros_zurich
from ca_desplazamiento
where sz_nro_prestamo = de_banco
and   sz_nro_reporte  = 2
and   de_archivo      <> 'WORKFLOW'
and   de_estado       = 'A'

update #seguros_zurich set 
sz_monto_prima = @w_monto_seguro * sz_long_cobertura

update #seguros_zurich set 
sz_monto_prima = @w_monto_seguro * sz_long_cobertura
from cob_cartera..ca_operacion
where op_banco = sz_nro_poliza
and op_toperacion not in ('INDIVIDUAL')

update #seguros_zurich set 
sz_monto_prima = (sz_long_cobertura * se_valor )
from cob_cartera..ca_operacion, cob_cartera..ca_param_seguro_externo
where op_banco = sz_nro_poliza
and op_toperacion = 'INDIVIDUAL'
and sz_long_cobertura between se_mes_inicial and se_mes_final

--DIRECCIONES
select di_ente as ente, max(di_direccion) direccion
into #dir_actuales 
from cobis..cl_direccion
where di_tipo='RE'
and   di_ente in (select sz_ente from #seguros_zurich)
group by di_ente

select 
di_ente        = di_ente,       
di_delegacion  = (select ltrim(rtrim(ci_descripcion)) from cobis..cl_ciudad where ci_ciudad    = di_ciudad),    
di_estado      = (select ltrim(rtrim(pv_descripcion)) from cobis..cl_provincia where pv_provincia = di_provincia),
di_colonia     = (select ltrim(rtrim(pq_descripcion)) from cobis..cl_parroquia where pq_parroquia = di_parroquia),
di_poblacion   = isnull(di_poblacion , ''),
di_nro         = isnull(convert(varchar,di_nro),''),
di_nro_interno = isnull(convert(varchar,di_nro_interno),''),
di_codpostal   = isnull(di_codpostal,''),
di_calle       = isnull(di_calle,'')
into #direcciones
from cobis..cl_direccion,#dir_actuales
where di_ente = ente
and di_direccion = direccion

update #direcciones
set di_nro_interno = ''
where di_nro_interno in ('0' ,'-1')

update #direcciones
set di_nro = ''
where di_nro in ('0' ,'-1') 

update #seguros_zurich set
sz_direccion1 =  substring(ltrim(rtrim(di_calle)) + 
                 case when di_nro_interno <> '' then ',' +  ltrim(rtrim(di_nro_interno)) else ',0' end +                          
                 case when di_nro <> '' then ',' + ltrim(rtrim(di_nro)) else ',0' end,1,40),
sz_direccion2 =  substring(case when di_colonia <> '' then ltrim(rtrim(isnull(di_colonia,'NA'))) else 'NA' end,1,40),    --149235
sz_ciudad     =  substring(di_delegacion,1,40),
sz_estado     =  substring(di_estado,1,40),
sz_cod_postal =  substring(di_codpostal,1,5)
from #direcciones
where sz_ente = di_ente 

-- TELEFONOS --   
select te_ente as ente, te_valor, max(te_secuencial) as secuencial
into   #telefonos
from   cobis..cl_telefono 
where  te_ente in (select sz_ente from #seguros_zurich)
and    te_valor is not null
group by te_ente,te_valor 
		   
update #seguros_zurich set
       sz_telefono = substring(te_valor,1,10)
from   #telefonos
where  sz_ente = ente

--EMAIL 
select di_ente as ente, max(di_direccion) direccion
into   #mail_actuales 
from   cobis..cl_direccion
where  di_tipo='CE'
and    di_ente in (select sz_ente from #seguros_zurich)
group by di_ente		   
		   
select di_ente        = di_ente,       
       di_mail        = di_descripcion
into   #mails
from   cobis..cl_direccion,#mail_actuales
where  di_ente = ente
and    di_direccion = direccion		   

update #seguros_zurich set 
       sz_email = substring(di_mail,1,50)
from   #mails
where  sz_ente = di_ente 

--DATOS DEL CLIENTE 		   
update #seguros_zurich set 
sz_nombre_asegurado    =  substring(isnull(en_nombre,'')+' '+isnull(p_s_nombre,''),1,20),  	   
sz_apellido_paterno    =  substring(isnull(p_p_apellido,' '),1,20),  		   
sz_apellido_materno    =  substring(case when p_s_apellido <> '' then ltrim(rtrim(isnull(p_s_apellido,'NA'))) else 'NA' end,1,20),  --149235--213798
sz_genero              =  isnull(p_sexo,''), 
sz_rfc                 =  (case when @w_ambiente = 'PROD' then substring(isnull(en_rfc,''),1,13) else 'RCF' + isnull(convert(varchar(6),p_fecha_nac,12),'000000') end),                 		   
sz_edad                =  (cast(datediff(dd, isnull(p_fecha_nac,@w_fecha_proc), @w_fecha_proc)/365.25 as INT)),             		   
sz_fecha_nac           =  convert(varchar(10), isnull(p_fecha_nac,@w_fecha_proc), @w_ffecha),   		   
sz_cta_banco           =  (select convert(bigint,substring(ltrim(rtrim(ea_cta_banco)),1,45)) from cobis..cl_ente_aux where ea_ente = sz_ente)
from cobis..cl_ente 
where en_ente = sz_ente 

update #seguros_zurich set
sz_apellido_materno = cobis.dbo.fn_filtra_acentos(sz_apellido_materno), 
sz_apellido_paterno = cobis.dbo.fn_filtra_acentos(sz_apellido_paterno), 
sz_nombre_asegurado = cobis.dbo.fn_filtra_acentos(sz_nombre_asegurado), 
sz_estado           = cobis.dbo.fn_filtra_acentos(sz_estado), 
sz_ciudad           = cobis.dbo.fn_filtra_acentos(sz_ciudad), 
sz_direccion2       = cobis.dbo.fn_filtra_acentos(replace(sz_direccion2,'"','')),
sz_direccion1       = cobis.dbo.fn_filtra_acentos(replace(sz_direccion1,'"',''))
from  #seguros_zurich
where sz_ente = sz_ente

--CERTIFICADO
update #seguros_zurich set
sz_nro_certificado = substring((convert(varchar, sz_ente) + '' + sz_nro_certificado),1,12)

--FUNCIONARIO
update #seguros_zurich set
sz_vendedor = substring(ltrim(rtrim(fu_nombre)),1,20)
from cobis..cl_funcionario where fu_funcionario = convert( int, sz_vendedor)

select @w_ente = max(sz_ente) from #seguros_zurich
update #seguros_zurich set
sz_nombre_1 = ''
from  #seguros_zurich
where sz_ente = @w_ente

-----caso #149973 quitar los clientes que superen el parametro de seguro según su tipo
-----se_paquete = 'BASICO' , 'EXTENDIDO' , 'NINGUNO' -- se_edad_max
delete #seguros_zurich
from ca_param_seguro_externo
where sz_edad >= se_edad_max
and sz_tipo_seguro = se_paquete


-- Actualizacion de montos
select op_banco, sum(am_cuota + am_gracia) AS monto_credito 
into #valores_credito
from #seguros_zurich,
cob_cartera..ca_operacion,
cob_cartera..ca_amortizacion 
where op_banco = sz_nro_prestamo
and am_operacion = op_operacion
and am_concepto in ('CAP', 'INT', 'INT_ESPERA', 'IVA_ESPERA', 'IVA_INT')
group BY op_banco

update #seguros_zurich set
sz_monto_credito = monto_credito 
from  #valores_credito 
where op_banco = sz_nro_prestamo


/* INSERTAR EN LA TABLA DEFINITIVA PARA EL BCP */
TRUNCATE TABLE ca_seguros_zurich

INSERT into ca_seguros_zurich (
sz_nro_poliza          ,sz_anio_poliza         ,sz_producto            ,sz_id_cliente          ,
sz_sucursal            ,sz_nro_prestamo        ,sz_nro_certificado     ,sz_mes_emision         ,
sz_fecha_endoso        ,sz_fecha_efectiva      ,sz_fecha_expiracion    ,sz_long_cobertura      ,
sz_pais                ,sz_moneda              ,sz_vendedor            ,sz_nombre_asegurado    ,
sz_apellido_paterno    ,sz_apellido_materno    ,sz_direccion1          ,sz_direccion2          ,
sz_ciudad              ,sz_estado              ,sz_cod_postal          ,sz_telefono            ,
sz_email               ,sz_genero              ,sz_rfc                 ,sz_edad                ,
sz_fecha_nac           ,sz_seguro_vida         ,sz_seguro_infarto_cer  ,sz_seguro_infarto_mioc ,
sz_seguro_cancer       ,sz_monto_prima         ,sz_comision            ,
sz_nombre_1            ,sz_rfc_1               ,sz_fecha_nac_1         ,
sz_sexo_1              ,sz_porcentaje_1        ,sz_nombre_2            ,
sz_rfc_2               ,sz_fecha_nac_2         ,sz_sexo_2              ,
sz_porcentaje_2        ,sz_nombre_3            ,sz_rfc_3               ,
sz_fecha_nac_3         ,sz_sexo_3              ,sz_porcentaje_3        ,
sz_cta_banco           ,sz_monto_credito     
)
SELECT 
sz_nro_poliza       ,sz_anio_poliza      ,sz_producto                       ,sz_ente,
sz_sucursal         ,sz_nro_prestamo     ,RTRIM(LTRIM(sz_nro_certificado))  ,sz_mes_emision,
sz_fecha_endoso     ,sz_fecha_efectiva   ,sz_fecha_expiracion               ,sz_long_cobertura,
sz_pais             ,sz_moneda           ,sz_vendedor                       ,sz_nombre_asegurado,
sz_apellido_paterno ,sz_apellido_materno ,sz_direccion1                     ,sz_direccion2,
sz_ciudad           ,sz_estado           ,sz_cod_postal                     ,sz_telefono,
sz_email            ,sz_genero           ,substring(sz_rfc,1,13)            ,sz_edad,
sz_fecha_nac        ,sz_seguro_vida      ,sz_seguro_infarto_cer             ,sz_seguro_infarto_mioc,
sz_seguro_cancer    ,sz_monto_prima      ,sz_comision,
sz_nombre_1         ,sz_rfc_1            ,sz_fecha_nac_1,
sz_sexo_1           ,sz_porcentaje_1     ,sz_nombre_2,
sz_rfc_2            ,sz_fecha_nac_2      ,sz_sexo_2,
sz_porcentaje_2     ,sz_nombre_3         ,sz_rfc_3,
sz_fecha_nac_3      ,sz_sexo_3           ,sz_porcentaje_3,
sz_cta_banco        ,sz_monto_credito
FROM #seguros_zurich 
order by sz_nro_prestamo
	   				
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
		
select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
       
while 1 = 1 begin
   set rowcount 1
   select @w_columna = substring(COLUMN_NAME,4,len(COLUMN_NAME)),
          @w_col_id = ORDINAL_POSITION
   from   INFORMATION_SCHEMA.COLUMNS
   where  TABLE_NAME = 'ca_seguros_zurich'
   and   ORDINAL_POSITION > @w_col_id
   order by ORDINAL_POSITION
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_comando = 'echo ' + substring(@w_cabecera,1,len(@w_cabecera) - 1) + ' > ' + @w_path + 'cabecera.txt'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error generando Archivo de Nuevos Seguros'
END

----------------------------------------
--Generar Archivo Datos
----------------------------------------		
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_seguros_zurich out '

select @w_destino  = @w_path + 'DATOSSEGUROSZURICH_' +  replace(convert(varchar(10), @w_fecha_proc, @w_ffecha),'/', '') + '.txt ',
       @w_errores  = @w_path + 'SEGUROSZURICH_' +  replace(convert(varchar(10), @w_fecha_proc, @w_ffecha),'/', '') + '.err '

select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -C ACP -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error generando Archivo de Nuevos Seguros'
   goto ERROR
END

----------------------------------------
--Generar Archivo Resultado
----------------------------------------
select @w_comando = 'copy ' + @w_path + 'cabecera.txt + ' + @w_destino + ' ' +  @w_path + 'SEGUROSZURICH_' +  replace(convert(varchar(10), @w_fecha_proc, @w_ffecha),'/', '') + '.csv /A'
--select @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error generando Archivo de Definitivo'
   goto ERROR
END

----------------------------------------
--Borrar Archivo temporal de datos
----------------------------------------
select @w_comando = 'del /F ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error eliminando archivo temporal de datos'
   goto ERROR
END


----------------------------------------
--Borrar Archivo de Cabeceras
----------------------------------------
select @w_comando = 'del /F ' + @w_path + 'cabecera.txt'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error eliminando archivo temporal de cabeceras'
   goto ERROR
END   
   
return 0  
 
ERROR:
     exec cobis..sp_errorlog 
     @i_fecha        = @w_fecha_proc,
     @i_error        = @w_error,
     @i_usuario      = 'userbatch',
     @i_tran         = 26004,
     @i_descripcion  = @w_mensaje,
     @i_tran_name    =null,
     @i_rollback     ='S'
     return @w_error

go
