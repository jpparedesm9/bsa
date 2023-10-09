/*************************************************************************/
/*     Archivo:              rptprami.sp                                 */
/*     Stored procedure:     sp_rptprami.sp                              */
/*     Base de datos:        cob_pfijo                                   */
/*     Producto:             Plazo Fijo                                  */
/*     Disenado por:         J.chacon                                    */
/*     Fecha de escritura:   14/08/1995                                  */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de     */
/*     "MACOSA", representantes exclusivos para el Ecuador de la         */
/*     "NCR CORPORATION".                                                */
/*     Su uso no autorizado queda expresamente prohibido asi como        */
/*     cualquier alteracion o agregado hecho por alguno de sus           */
/*     usuarios sin el debido consentimiento por escrito de la           */
/*     Presidencia Ejecutiva de MACOSA o su representante.               */
/*                              PROPOSITO                                */
/*     Este reporte, lista las provisiones hechas para cada deposito     */
/*     ordenada en los plazos que tenga cada deposito EJ Polizas de      */
/*     30 a 60 y dentro con quiebres por  moneda, ciudad y oficina,      */   
/*     luego vendrian las mismas Polizas pero con plazo de 60 a 90,..    */   
/*                            MODIFICACIONES                             */
/*     FECHA        AUTOR                RAZON                           */
/*    03/10/2016    j.chacon             Migracion de Sqr -Sps           */ 
/*    05-Ene-2017   N. Martillo          Ajustes VBatch                  */                                 
/*************************************************************************/

use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go
 
if exists (select 1 from sysobjects where name = 'sp_rptprami')
  drop procedure sp_rptprami
go

create procedure  sp_rptprami(
       @i_param1     varchar(255),
       @i_param2     varchar(255),
       @i_param3     varchar(255),
       @i_param4     varchar(255)
)
with encryption
as 
   declare 
          @w_return          int ,
          @w_sp_name         varchar (250),
          @w_cadena          varchar (max),
          @w_fecha           varchar (10),  
          @w_toperacion      varchar (255),
          @w_ciudad          int,
          @w_oficina         varchar (1),
          @w_retorno         int,
          @w_tabla           varchar(250),
          @w_error_msg       varchar(250),
          @w_retorno_ej      int,
          @w_fecha_proceso   datetime
        
begin

  select @w_sp_name = 'cob_pfijo..sp_rptprami'
  
  select @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso
  
  select @w_fecha       = convert(datetime     , @i_param1),
         @w_toperacion  = convert(varchar (255), @i_param2),
         @w_ciudad      = convert(int          , @i_param3),
         @w_oficina     = convert(varchar (1)  , @i_param4)
 
  truncate table cob_reportes..rep_dpf_parami
     
    if (@w_ciudad <> ''  or  @w_oficina <> ''  or @w_toperacion <> '' )
        begin   
        select @w_cadena           = isnull(@w_toperacion,'') +'|' +  convert(varchar, isnull(@w_oficina,'')) + '|'+convert(varchar,isnull(@w_ciudad,''))+'|||'
         exec  @w_return           =  sp_verifica_existencia
               @w_cadena_evaluar   =  @w_cadena,
               @o_mensaje          =  @w_error_msg  out
            
             if @w_return <>0
                begin
                 select @w_retorno_ej = 14000, 
                        @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al ejecutar sp_verifica_existencia'
                 goto ERROR
                end        
           end             
--- Detalle del reporte 
insert into cob_reportes..rep_dpf_parami
select 
     of_regional    ,                                   (select of_nombre from cobis..cl_oficina WHERE of_oficina=o.of_regional )    ,
     of_zona        ,                                   (select of_nombre from cobis..cl_oficina WHERE of_oficina =o.of_zona)        ,
     of_ciudad      ,                                   (select ci_descripcion from cobis..cl_ciudad  WHERE ci_ciudad = o.of_ciudad ),                       
     op_oficina     ,                                   (select of_nombre from cobis..cl_oficina WHERE of_oficina =o.of_oficina)     ,                                    
     op_toperacion  ,                                   
     op_moneda      ,                                   (select mo_descripcion FROM cobis..cl_moneda WHERE mo_moneda = op_moneda)    ,  
     pl_descripcion ,                                   op_num_banco   ,  
     op_dia_pago    ,                                   op_preimpreso  ,                                           
     (select isnull (ct_valor,1) *op_monto  from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda)), --se realiza calculo en base a la corizacion de la moneda local
     op_estado             ,                            op_tasa       ,
     op_fpago              ,                            op_retienimp  ,
     op_fecha_valor        ,                            op_fecha_ven          ,
     op_total_int_estimado ,                            op_total_int_ganados  ,
     op_total_int_retenido ,                            op_total_int_pagados  ,  
     abs(op_total_int_ganados - op_total_int_pagados),  op_num_dias,  
     datediff(dd,op_fecha_valor,op_ult_fecha_calculo),  datediff(dd,op_fecha_ult_pg_int,op_ult_fecha_calculo), 
     op_int_provision                                ,  (select isnull (ct_valor,1) *op_int_provision  from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda)),
     substring(op_descripcion,1,40),
     (select isnull (ct_valor,1) *op_total_int_ganados  from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda)),
     case op_fpago  when  'PER' then datediff(dd,op_fecha_ult_pg_int,op_ult_fecha_calculo) + op_dia_pago else 0  end,
     case  op_fpago when  'ANT' then  op_total_int_ganados else op_total_int_pagados  end,
     (select isnull(ct_valor,1) *op_total_int_pagados  from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda))         
FROM pf_operacion p, cobis..cl_ciudad, cobis..cl_oficina o , pf_plazo
WHERE op_oficina    = of_oficina
  and (op_oficina   = @w_oficina or @w_oficina is null)
  and(op_toperacion = @w_toperacion or @w_toperacion is null)
  and of_ciudad     = ci_ciudad
  and (ci_ciudad    = @w_ciudad or @w_ciudad is null) 
  and datediff(dd,op_ult_fecha_calculo,isnull (convert (datetime ,@w_fecha),op_ult_fecha_calculo))=0
  and op_tipo_plazo = pl_mnemonico
  and op_int_provision <> 0 
ORDER BY of_regional, of_zona, ci_ciudad, op_oficina,op_toperacion, op_moneda, pl_plazo_contable, op_fecha_ven

if @@error <> 0 
    begin 
         select @w_retorno_ej = 14000, @w_tabla = 'cob_reporte..rep_dpf_parami',
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al insertar en -' + @w_tabla
         goto ERROR 
    end   
     
return 0

ERROR:

    exec @w_retorno     = cob_pfijo..sp_errorlog
         @i_fecha       = @w_fecha_proceso, 
         @i_error       = @w_retorno_ej, 
         @i_usuario     = 'OPERADOR',
         @i_tran        = 14000, 
         @i_tran_name   = @w_sp_name, 
         @i_rollback    = 'N',
         @i_cuenta      = 'sp_rptloger', 
         @i_descripcion = @w_error_msg
    
    if @w_retorno > 0
        return @w_retorno
    else
        return @w_retorno_ej
 
end

GO



