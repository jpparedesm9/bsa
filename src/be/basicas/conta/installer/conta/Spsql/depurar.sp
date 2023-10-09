/*depura.sp**************************************************************/
/*    Archivo:                depura.sp                                 */
/*    Stored procedure:       sp_depurar                                */
/*    Base de datos:          cob_conta                                 */
/*    Producto:               contabilidad                              */
/************************************************************************/
/*                            IMPORTANTE                                */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA".                                                         */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                            PROPOSITO                                 */
/*    Pasar a historicos movimientos y saldos contables.                */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_depurar')
   drop proc sp_depurar
go

create proc sp_depurar
@i_param1          varchar(255) = null,
@i_param2          varchar(255) = null,
@i_param3          varchar(255) = 'N'
                        
AS

DECLARE 
@i_empresa        tinyint,
@i_fecha_hasta    datetime,
@w_error          int,
@w_periodo        int,
@w_corte          int,
@w_contador       int,
@w_total          int,
@w_pri_diames     datetime,
@w_ult_diames     datetime,
@w_fecha          datetime,
@w_cantidad       int,
@w_fecha_proceso  datetime,
@w_commit         char(1),
@w_user           varchar(20),
@w_term           varchar(20),
@w_msg            varchar(200),
@w_return         int,
@w_count          int,
@w_fecha_ejec     datetime,
@w_path_listados  varchar(255),
@w_s_app          varchar(255),
@w_errores        varchar(255),
@i_crea_idxh      char(1),
@w_cmd            varchar(400),
@w_meses          tinyint,
@w_fecha_tmp      datetime,
@w_periodo_max    smallint,
@w_corte_max      int,
@w_periodo_min    smallint

/* VARIABLES DE TRABAJO */
select 
@w_commit         = 'N',
@w_user           = 'OPERADOR',
@w_term           = 'CONSOLA',
@w_periodo        = 0,
@w_corte          = 0,
@w_msg            = '',
@w_total          = 0,
@w_count          = 0,
@w_fecha_ejec     = getdate(),
@w_path_listados  = '',
@w_s_app          = '',
@w_errores        = '',
@w_count          = 0, 
@w_cantidad       = 0,
@w_meses          = 0

select @i_empresa     = convert(tinyint,  @i_param1)
select @i_fecha_hasta = convert(datetime, @i_param2)
select @i_crea_idxh   = convert(char(1),@i_param3)

if exists (select 1 from cob_conta..sysobjects where name = 'ts_depurado' and type = 'V')
   drop view ts_depurado

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_path_listados = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_meses = isnull(pa_tinyint, 0)
from cobis..cl_parametro
where pa_producto = 'CON'
and   pa_nemonico = 'MACD'

select @w_fecha_tmp = dateadd(mm,-@w_meses,@i_fecha_hasta)

select @w_periodo = datepart (yy, @w_fecha_tmp)

if exists (select 1 from cob_conta..cb_periodo where pe_periodo = @w_periodo and   pe_estado = 'V') begin
   select @w_msg = 'ERROR, FECHA NO SE PUEDE BORRAR PORQUE ESTA EN UN PERIODO VIGENTE'
   goto ERROR           
end
select @w_fecha = min(co_fecha_tran)
from cob_conta..cb_comprobante

if datediff(yy, @w_fecha,  @i_fecha_hasta) > 1 begin
   select @w_msg = 'ERROR, FECHA NO SE PUEDE BORRAR PORQUE ESTA FUERA DEL RANGO PERMITIDO'
   goto ERROR
end 

/* CONTROLAR NO DEPURAR TRANSACCIONES DENTRO DEL TRIMESTRE */ 
if @i_fecha_hasta >= dateadd(mm,-@w_meses,@w_fecha_proceso) begin
   select @w_msg = 'ERROR, FECHA NO SE PUEDE BORRAR PORQUE ESTA FUERA DEL RANGO PERMITIDO'
   goto ERROR
end 

/* VERIFICANDO PRODUCTO BANCARIO ACTIVO */
IF (SELECT COUNT(1) FROM cobis..cl_pro_moneda
     WHERE pm_producto = 6
       AND pm_estado = 'V') >0
BEGIN
    PRINT 'PRODUCTO CONTABILIDAD ESTA HABILITADO'
    INSERT INTO cob_conta..cb_depurar
    VALUES(@i_empresa, @i_fecha_hasta, @w_corte, @w_periodo, 'VBATCH' , 'OPERADOR' , GETDATE(), 0, 'PRODUCTO CONTABILIDAD ESTA HABILITADO')
    RETURN 600703
END 

select @w_periodo = 0

/* DETERMINAR PERIODO Y CORTE DE LA FECHA A BORRAR */
select 
@w_corte   = co_corte,
@w_periodo = co_periodo
from cob_conta..cb_corte
where co_empresa   = @i_empresa
and   co_fecha_ini = @i_fecha_hasta

if @@rowcount = 0 begin
   select @w_msg =  'ERROR, CORTE NO EXISTE PARA LA FECHA'
   goto ERROR
end

select 
@w_corte_max   = max(co_corte)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_periodo = @w_periodo 

if @w_corte_max > @w_corte 
   select @w_corte = @w_corte_max

/**********************************/
/*******    CB_HIST_SALDO   *******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%cb_hist_sa%'
           and   cbd_cantidad > 0) begin
           
   if exists (select 1 from cob_conta_his..sysobjects
              where type = 'U' and  name = 'cb_hist_saldo_old') begin
      select @w_msg = 'TABLA CB_HIST_SALDO_OLD YA EXISTE'
   
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)
         
      goto CB_ASIENTO
   end      
              
   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end
   
   /* RENOMBRAR TABLA CB_HIST_SALDO*/

   exec @w_return = cob_conta_his..sp_rename cb_hist_saldo, cb_hist_saldo_old
   if @w_return <> 0 
   begin
      print 'ERROR RENOMBRANDO LA TABLA CB_HIST_SALDO' 
      goto ERROR
   end
   
   print 'CB_HIST_SALDO'
   
   /* DEPURAR TABLA CB_HIST_SALDO */
   select *
   into   cob_conta_his..cb_hist_saldo
   from   cob_conta_his..cb_hist_saldo_old
   where  hi_corte >  @w_corte
   and    hi_periodo = @w_periodo
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      print 'ERROR DEPURANDO TABLA CB_HIST_SALDO'
      goto ERROR
   end
   
   select @w_periodo_max = max(hi_periodo)
   from cob_conta_his..cb_hist_saldo_old   
   
   if @w_periodo_max > @w_periodo begin   
      select @w_corte = 1

      insert into cob_conta_his..cb_hist_saldo            
      select *
      from   cob_conta_his..cb_hist_saldo_old
      where  hi_corte >  @w_corte
      and    hi_periodo = @w_periodo_max
      
      if @@error <> 0 begin
         print 'ERROR DEPURANDO TABLA CB_HIST_SALDO'
         goto ERROR
      end      
   end
   
   /* BORRAR INDICE DE TABLA CB_HIST_SALDO - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'cb_hist_saldo' and   o.id = i.id and   i.name = 'cb_hist_saldo_Key')   
   DROP INDEX [cb_hist_saldo_Key] ON [cob_conta_historico].[dbo].[cb_hist_saldo]
   
   /* RESPALDAR EN HISTORICOS TABLA CB_HIST_SALDO_OLD*/
   insert into cob_conta_historico..cb_hist_saldo
   select * 
   from cob_conta_his..cb_hist_saldo_old
   where hi_periodo  = @w_periodo
   and   hi_corte    <= @w_corte 
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      print 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_HIST_SALDO'
      goto ERROR
   end
   
   select @w_periodo_min = min(hi_periodo)
   from cob_conta_his..cb_hist_saldo_old   
   
   if @w_periodo_min > @w_periodo begin   
      select @w_corte = max(co_corte)
      from cob_conta..cb_corte
      where co_periodo = @w_periodo_min

      insert into cob_conta_historico..cb_hist_saldo            
      select *
      from   cob_conta_his..cb_hist_saldo_old
      where  hi_corte <=  @w_corte
      and    hi_periodo = @w_periodo_min
      
      if @@error <> 0 begin
         print 'ERROR DEPURANDO TABLA CB_HIST_SALDO'
         goto ERROR
      end      
   end   
   
   /* CREANDO INDICES TABLA CB_HIST_SALDO - PRODUCCION */
   CREATE UNIQUE NONCLUSTERED INDEX [cb_hist_saldo_key] ON [cob_conta_his].[dbo].[cb_hist_saldo] (hi_corte, hi_periodo, hi_oficina, hi_area, hi_cuenta)
   
   /* CREANDO INDICES TABLA CB_HIST_SALDO - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE UNIQUE NONCLUSTERED INDEX [cb_hist_saldo_Key] ON [cob_conta_historico].[dbo].[cb_hist_saldo] (hi_corte,hi_periodo,hi_oficina, hi_area, hi_cuenta)
   end
   
   select @w_count = count(1)
   from   cob_conta_his..cb_hist_saldo_old
   where  hi_corte <=  @w_corte
   and    hi_periodo <= @w_periodo
   
   if @w_count <> @w_cantidad begin
      select @w_msg = 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_ASIENTO NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta_his..cb_hist_saldo_old
   end   
      
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   select @w_msg = 'TABLA CB_HIST_SALDO DEPURADA'
   
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
   
   /* CERRAR TRANSACCION ASEGURANDO TABLAS */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

CB_ASIENTO:
/**********************************/
/******      CB_ASIENTO      ******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%cb_asi%'
           and   cbd_cantidad > 0) begin

   select @w_count = 0, @w_cantidad = 0
   
   if exists (select 1 from cob_conta..sysobjects
              where type = 'U' and  name = 'cb_asiento_old') begin
      select @w_msg = 'TABLA CB_ASIENTO_OLD YA EXISTE'
      
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)      
      
      goto CB_COMPROBANTE
   end     
   
   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end       
   
   /* RENOMBRAR TABLA CB_ASIENTO */
   exec @w_return = cob_conta..sp_rename cb_asiento, cb_asiento_old
   if @w_return <> 0 
   begin
      print 'ERROR RENOMBRANDO TABLA CB_ASIENTO' 
      goto ERROR
   end
   
   /* DEPURAR TABLA CB_ASIENTO*/
   select *
   into   cob_conta..cb_asiento
   from   cob_conta..cb_asiento_old
   where  as_fecha_tran >  @i_fecha_hasta
    
   if @@error <> 0 begin
      print 'ERROR DEPURANDO TABLA CB_ASIENTO'
      goto ERROR
   end
   
   /* BORRAR INDICES TABLA CB_ASIENTO - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'cb_asiento' and   o.id = i.id and   i.name = 'cb_asiento_key')
      DROP INDEX [cb_asiento_key] ON [cob_conta_historico].[dbo].[cb_asiento]
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'cb_asiento' and   o.id = i.id and   i.name = 'cb_asiento_key2')
      DROP INDEX [cb_asiento_key2] ON [cob_conta_historico].[dbo].[cb_asiento]
   
   /* PASAR A HISTORICOS TABLA CB_ASIENTO_OLD */
   insert into cob_conta_historico..cb_asiento
   select * 
   from cob_conta..cb_asiento_old
   where as_fecha_tran  <= @i_fecha_hasta
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      print 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_ASIENTO'
      goto ERROR
   end
   
   print 'CB_ASIENTO'
   
   /* CREAR INDICES TABLA CB_ASIENTO - PRODUCCION */
   CREATE UNIQUE NONCLUSTERED INDEX [cb_asiento_key] ON [cob_conta].[dbo].[cb_asiento] (as_comprobante, as_fecha_tran, as_asiento, as_oficina_orig, as_empresa)
   CREATE NONCLUSTERED INDEX [cb_asiento_key2] ON [cob_conta].[dbo].[cb_asiento] (as_cuenta, as_fecha_tran, as_oficina_dest, as_area_dest)
   
   /* CREANDO INDICES TABLA CB_ASIENTO - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE UNIQUE NONCLUSTERED INDEX [cb_asiento_key] ON [cob_conta_historico].[dbo].[cb_asiento] (as_comprobante, as_fecha_tran, as_asiento, as_oficina_orig, as_empresa)
      CREATE NONCLUSTERED INDEX [cb_asiento_key2] ON [cob_conta_historico].[dbo].[cb_asiento] (as_cuenta, as_fecha_tran, as_oficina_dest, as_area_dest)
   end
   
   select @w_count = count(1)
   from cob_conta..cb_asiento_old
   where as_fecha_tran  <= @i_fecha_hasta
   
   if @w_count <> @w_cantidad begin
      select @w_msg = 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_ASIENTO NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta..cb_asiento_old
   end
   
   select @w_msg = 'TABLA CB_ASIENTO DEPURADA'
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
   
   /* CERRAR TRANSACCION */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

CB_COMPROBANTE:
/**********************************/
/******     CB_COMPROBANTE   ******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%cb_comproba%'
           and   cbd_cantidad > 0) begin
           
   select @w_count = 0, @w_cantidad = 0

   if exists (select 1 from cob_conta..sysobjects
              where type = 'U' and  name = 'cb_comprobante_old') begin
      select @w_msg = 'TABLA CB_COMPROBANTE_OLD YA EXISTE'
      
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)            
      
      goto CB_RETENCION
   end      
              
   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end
 
   /* RENOMBRAR TABLA CB_COMPROBANTE */
   exec @w_return = cob_conta..sp_rename cb_comprobante, cb_comprobante_old
   if @w_return <> 0 
   begin
      print 'ERROR RENOMBRANDO TABLA CB_COMPROBANTE' 
      goto ERROR
   end
   
   print 'CB_COMPROBANTE'
   
   /* DEPURAR TABLA CB_COMPROBANTE*/
   select *
   into   cob_conta..cb_comprobante
   from   cob_conta..cb_comprobante_old
   where  co_fecha_tran >  @i_fecha_hasta
   
   if @@error <> 0 begin
      print 'ERROR DEPURANDO TABLA CB_COMPROBANTE'
      goto ERROR
   end
   
   /* BORRAR INDICES EN TABLA CB_COMPROBANTE - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'cb_comprobante' and   o.id = i.id and   i.name = 'cb_comprobante_key')                     
      DROP INDEX [cb_comprobante_key] ON [cob_conta_historico].[dbo].[cb_comprobante]
   
   /* PASAR A HISTORICOS TABLA CB_COMPROBANTE_OLD */
   insert into cob_conta_historico..cb_comprobante
   select * 
   from cob_conta..cb_comprobante_old
   where co_fecha_tran  <= @i_fecha_hasta
   
   select @w_error = @@error, @w_cantidad = @@rowcount

   if @w_error <> 0 begin
      select @w_msg = 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_COMPROBANTE'
      goto ERROR   
   end
   
   select @w_count = count(1)
   from cob_conta..cb_comprobante_old
   where co_fecha_tran  <= @i_fecha_hasta
   
   if @w_count <> @w_cantidad begin
      print 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_COMPROBANTE NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta..cb_comprobante_old
   end
   
   select @w_msg = 'TABLA CB_COMPROBANTE DEPURADA'
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
            
   /* CREANDO INDICES TABLA CB_COMPROBANTE - PRODUCCION */
   CREATE UNIQUE NONCLUSTERED INDEX [cb_comprobante_key] ON [cob_conta].[dbo].[cb_comprobante] (co_comprobante, co_fecha_tran, co_oficina_orig, co_empresa)
   
   /* CREANDO INDICES TABLA CB_COMPROBANTE - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE UNIQUE NONCLUSTERED INDEX [cb_comprobante_key] ON cob_conta_historico.[dbo].[cb_comprobante] (co_comprobante, co_fecha_tran, co_oficina_orig, co_empresa)
   end
      
   /* CERRAR TRANSACCION */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

CB_RETENCION:
/**********************************/
/******      CB_RETENCION    ******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%cb_retenci%'
           and   cbd_cantidad > 0) begin
           
   select @w_count = 0, @w_cantidad = 0
   
   if exists (select 1 from cob_conta..sysobjects
              where type = 'U' and  name = 'cb_retencion_old') begin
      select @w_msg = 'TABLA CB_RETENCION_OLD YA EXISTE'
      
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)
      
      goto CT_SASIENTO
   end                 

   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end
      
   /* RENOMBRAR TABLA CB_RETENCION */
   exec @w_return = cob_conta..sp_rename cb_retencion, cb_retencion_old
   if @w_return <> 0 
   begin
      select @w_msg = 'ERROR RENOMBRANDO TABLA CB_RETENCION' 
      goto ERROR
   end
   
   /* DEPURAR TABLA CB_RETENCION*/
   select *
   into   cob_conta..cb_retencion
   from   cob_conta..cb_retencion_old
   where  re_fecha >  @i_fecha_hasta
   
   if @@error <> 0 begin
      select @w_msg = 'ERROR DEPURANDO TABLA CB_RETENCION'
      goto ERROR
   end
   
   print 'CB_RETENCION'
   
   /* BORRAR INDICES TABLA CB_RETENCION - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'cb_retencion' and   o.id = i.id and   i.name = 'cb_retencion_Key')                  
      DROP INDEX [cb_retencion_Key] ON [cob_conta_historico].[dbo].[cb_retencion]
   
   /* PASAR A HISTORICOS TABLA CB_RETENCION_OLD */
   insert into cob_conta_historico..cb_retencion
   select * 
   from cob_conta..cb_retencion_old
   where re_fecha  <= @i_fecha_hasta
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      select @w_msg = 'ERROR RESPALDANDO A HISTORICOS TABLA CB_RETENCION'
      goto ERROR
   end   
   
   select @w_count = count(1)
   from cob_conta..cb_retencion_old
   where re_fecha  <= @i_fecha_hasta
   
   if @w_count <> @w_cantidad begin
      select @w_msg = 'ERROR RESPALDANDO EN HISTORICOS TABLA CB_RETENCION NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta..cb_retencion_old
   end      
   
   /* CREANDO INDICES TABLA CB_RETENCION - PRODUCCION */
   CREATE NONCLUSTERED INDEX [idx1] ON [cob_conta].[dbo].[cb_retencion] (re_fecha)
   CREATE UNIQUE NONCLUSTERED INDEX [cb_retencion_Key] ON [cob_conta].[dbo].[cb_retencion] (re_comprobante, re_asiento, re_fecha, re_oficina_orig)
   
   /* CREANDO INDICES TABLA CB_RETENCION - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE UNIQUE CLUSTERED INDEX [cb_retencion_Key] ON [cob_conta_historico].[dbo].[cb_retencion] (re_empresa, re_comprobante, re_asiento, re_fecha, re_oficina_orig)
   end
   
      
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   select @w_msg = 'TABLA CB_RETENCION DEPURADA' 
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
   
   /* CERRAR TRANSACCION */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

CT_SASIENTO:
/**********************************/
/******     CT_SASIENTO      ******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%ct_sasien%'
           and   cbd_cantidad > 0) begin
   
   select @w_count = 0, @w_cantidad = 0
           
   if exists (select 1 from cob_conta_tercero..sysobjects
              where type = 'U' and  name = 'ct_sasiento_old') begin
      select @w_msg = 'TABLA CT_SASIENTO_OLD YA EXISTE'
      
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)
            
      goto CT_SCOMPROBANTE
   end      
   
   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end
   
   
   /* RENOMBRAR TABLA CT_SASIENTO*/
   exec @w_return = cob_conta_tercero..sp_rename ct_sasiento, ct_sasiento_old
   if @w_return <> 0 
   begin
      select @w_msg = 'ERROR RENOMBRANDO TABLA CT_SASIENTO' 
      goto ERROR
   end
   
   /* DEPURAR TABLA CT_SASIENTO*/
   select *
   into   cob_conta_tercero..ct_sasiento
   from   cob_conta_tercero..ct_sasiento_old
   where  sa_fecha_tran >  @i_fecha_hasta
   
   if @@error <> 0 begin
      select @w_msg = 'ERROR DEPURANDO TABLA CT_SASIENTO'
      goto ERROR
   end
   
   print 'CT_SASIENTO'
   
   /* BORRAR INDICES TABLA CT_SASIENTO - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'ct_sasiento' and   o.id = i.id and   i.name = 'ct_sasiento_Key')               
      DROP INDEX [ct_sasiento_Key] ON [cob_conta_historico].[dbo].[ct_sasiento] 
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'ct_sasiento' and   o.id = i.id and   i.name = 'ct_sasiento_AKey1')                     
      DROP INDEX [ct_sasiento_AKey1] ON [cob_conta_historico].[dbo].[ct_sasiento] 
   
   /* PASAR A HISTORICOS TABLA CT_SASIENTO_OLD */
   insert into cob_conta_historico..ct_sasiento
   select 
   sa_producto,      sa_comprobante,     sa_empresa,       sa_fecha_tran,
   sa_asiento,       sa_cuenta,          sa_oficina_dest,  sa_area_dest,
   sa_credito,       sa_debito,          sa_concepto,      sa_credito_me,
   sa_debito_me,     sa_cotizacion,      sa_tipo_doc,      sa_tipo_tran,
   sa_moneda ,       sa_opcion,          sa_ente,          sa_con_rete,
   sa_base,          sa_valret,          sa_con_iva,       sa_valor_iva,
   sa_iva_retenido,  sa_con_ica,         sa_valor_ica,     sa_con_timbre,
   sa_valor_timbre,  sa_con_iva_reten,   sa_con_ivapagado, sa_valor_ivapagado,
   sa_documento,     sa_mayorizado,      sa_origen_mvto,   sa_con_dptales,
   sa_valor_dptales, sa_posicion,        sa_debcred,       sa_oper_banco,
   sa_cheque,        sa_doc_banco,       sa_fecha_est,     sa_detalle,
   sa_error,         sa_fecha_fin_difer, sa_plazo_difer,   sa_desc_difer  
   from cob_conta_tercero..ct_sasiento_old
   where sa_fecha_tran  <= @i_fecha_hasta
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      select @w_msg = 'ERROR RESPALDANDO A HISTORICOS TABLA CT_SASIENTO NO CORRESPONDEN REGISTROS'
      goto ERROR
   end
         
   /* CREANDO INDICES TABLA CT_SASIENTO - PRODUCCION */
   CREATE UNIQUE NONCLUSTERED INDEX [ct_sasiento_AKey0] ON [cob_conta_tercero].[dbo].[ct_sasiento] (sa_comprobante, sa_fecha_tran, sa_producto, sa_asiento)
   CREATE NONCLUSTERED INDEX [ct_sasiento_AKey1] ON [cob_conta_tercero].[dbo].[ct_sasiento] (sa_ente, sa_cuenta, sa_fecha_tran, sa_oficina_dest) 
   CREATE NONCLUSTERED INDEX [ct_sasiento_AKey2] ON [cob_conta_tercero].[dbo].[ct_sasiento] (sa_ente, sa_debito, sa_credito, sa_empresa, sa_producto, sa_comprobante, sa_cuenta, sa_fecha_tran, sa_oficina_dest )
   
   /* CREANDO INDICES TABLA CT_SASIENTO - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE NONCLUSTERED INDEX [ct_sasiento_AKey1] ON [cob_conta_historico].[dbo].[ct_sasiento] (sa_cuenta, sa_fecha_tran, sa_oficina_dest, sa_area_dest, sa_ente)
      CREATE NONCLUSTERED INDEX [ct_sasiento_Key] ON [cob_conta_historico].[dbo].[ct_sasiento] (sa_fecha_tran, sa_producto, sa_comprobante, sa_asiento)
   end
   
   select @w_count = count(1)
   from cob_conta_tercero..ct_sasiento_old
   where sa_fecha_tran  <= @i_fecha_hasta
   
   if @w_count <> @w_cantidad begin
      print 'ERROR RESPALDANDO EN HISTORICOS TABLA CT_SASIENTO NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta_tercero..ct_sasiento_old
   end      
         
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   select @w_msg = 'TABLA CT_SASIENTO DEPURADA'
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
   
   /* CERRAR TRANSACCION */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

CT_SCOMPROBANTE:
/**********************************/
/******   CT_SCOMPROBANTE    ******/
/**********************************/

if not exists (select 1 from cob_conta..cb_depurar
           where cbd_fecha_tran = @i_fecha_hasta
           and   lower(cbd_comentario) like '%ct_scomproban%'
           and   cbd_cantidad > 0) begin
           
   select @w_count = 0, @w_cantidad = 0        
   
   if exists (select 1 from cob_conta_tercero..sysobjects
              where type = 'U' and  name = 'ct_scomprobante_old') begin
      select @w_msg = 'TABLA CT_SCOMPROBANTE_OLD YA EXISTE'
      
      insert into cob_conta..cb_depurar values(
      @i_empresa,      @i_fecha_hasta, @w_corte, 
      @w_periodo,      @w_term ,       @w_user , 
      getdate(),       0,              @w_msg)
            
      goto FIN
   end     
   
   if @@trancount = 0 begin
      begin tran
      select @w_commit = 'S'
   end
   
   /* RENOMBRAR TABLA CT_SCOMPROBANTE */
   exec @w_return = cob_conta_tercero..sp_rename ct_scomprobante, ct_scomprobante_old
   if @w_return <> 0 
   begin
      print 'ERROR RENOMBRANDO TABLA CT_SCOMPROBANTE' 
      goto ERROR
   end
   
   /* DEPURAR TABLA CT_SCOMPROBANTE*/
   select *
   into   cob_conta_tercero..ct_scomprobante
   from   cob_conta_tercero..ct_scomprobante_old
   where  sc_fecha_tran >  @i_fecha_hasta
   
   if @@error <> 0 begin
      print 'ERROR DEPURANDO TABLA CT_SCOMPROBANTE'
      goto ERROR
   end
   
   print 'CT_SCOMPROBANTE'
   
   /* BORRAR INDICES TABLA CT_SCOMPROBANTE - HISTORICOS */
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'ct_scomprobante' and   o.id = i.id and   i.name = 'i_ct_scomp_1')
      DROP INDEX [i_ct_scomp_1] ON [cob_conta_historico].[dbo].[ct_scomprobante]
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'ct_scomprobante' and   o.id = i.id and   i.name = 'ct_scomprobante_Key')      
      DROP INDEX [ct_scomprobante_Key] ON [cob_conta_historico].[dbo].[ct_scomprobante]
   if exists (SELECT 1 from cob_conta_historico..sysindexes i, cob_conta_historico..sysobjects o
              where o.name = 'ct_scomprobante' and   o.id = i.id and   i.name = 'ct_scomprobante_AKey1')            
      DROP INDEX [ct_scomprobante_AKey1] ON [cob_conta_historico].[dbo].[ct_scomprobante]

   /*  PASAR A HISTORICOS TABLA CT_SCOMPROBANTE_OLD */
   insert into cob_conta_historico..ct_scomprobante
   select * 
   from cob_conta_tercero..ct_scomprobante_old
   where sc_fecha_tran  <= @i_fecha_hasta
   
   select @w_error = @@error, @w_cantidad = @@rowcount
   
   if @w_error <> 0 begin
      select @w_msg = 'ERROR RESPALDANDO A HISTORICOS TABLA CT_SCOMPROBANTE NO CORRESPONDEN REGISTROS'
      goto ERROR
   end

   
   /* CREANDO INDICES TABLA CT_SCOMPROBANTE - PRODUCCION */
   CREATE NONCLUSTERED INDEX [ct_scomprobante_AKey1] ON [cob_conta_tercero].[dbo].[ct_scomprobante] (sc_estado, sc_fecha_tran)
   CREATE UNIQUE NONCLUSTERED INDEX [ct_scomprobante_Key] ON [cob_conta_tercero].[dbo].[ct_scomprobante] (sc_estado, sc_fecha_tran, sc_producto, sc_comprobante, sc_empresa)
   CREATE NONCLUSTERED INDEX [i_ct_scomp_1] ON [cob_conta_tercero].[dbo].[ct_scomprobante] (sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil)
   CREATE NONCLUSTERED INDEX [idx1] ON [cob_conta_tercero].[dbo].[ct_scomprobante] (sc_fecha_tran, sc_mayorizado)
   
   /* CREANDO INDICES TABLA CT_SCOMPROBANTE - HISTORICOS */
   if @i_crea_idxh = 'S' begin
      CREATE NONCLUSTERED INDEX [ct_scomprobante_AKey1] ON [cob_conta_historico].[dbo].[ct_scomprobante] (sc_estado, sc_fecha_tran)
      CREATE UNIQUE CLUSTERED INDEX [ct_scomprobante_Key] ON [cob_conta_historico].[dbo].[ct_scomprobante] (sc_fecha_tran, sc_producto, sc_comprobante)
      CREATE NONCLUSTERED INDEX [i_ct_scomp_1] ON [cob_conta_historico].[dbo].[ct_scomprobante] (sc_fecha_tran, sc_producto, sc_oficina_orig, sc_area_orig, sc_perfil)
   end
   
   select @w_count = count(1)
   from cob_conta_tercero..ct_scomprobante_old
   where sc_fecha_tran  <= @i_fecha_hasta   
   
   if @w_count <> @w_cantidad begin
      print 'ERROR RESPALDANDO EN HISTORICOS TABLA CT_SCOMPROBANTE NO CORRESPONDEN REGISTROS'
      goto ERROR   
   end
   else begin
      drop table cob_conta_tercero..ct_scomprobante_old
   end         
  
   
   /* INSERTO REGISTRO DE FECHA DEPURADA */
   select @w_msg = 'TABLA CT_SCOMPROBANTE DEPURADA'
   insert into cob_conta..cb_depurar values(
   @i_empresa,      @i_fecha_hasta, @w_corte, 
   @w_periodo,      @w_term ,       @w_user , 
   getdate(),       @w_count,       @w_msg)
   
   /* CERRAR TRANSACCION */
   if @w_commit = 'S' begin
     commit tran
     select @w_commit = 'N'
   end
end

FIN:

select @w_cmd = 'create view ts_depurado as select * from cob_conta..cb_depurar where cbd_fecha_depura >= ' + '''' + cast(@w_fecha_ejec as varchar) + ''''

PRINT '@w_cmd'

PRINT @w_cmd

exec (@w_cmd)
if @@error <> 0
   print 'error generando vista'

select @w_errores  = @w_path_listados + 'cb_depurar.err'
select @w_cmd      = @w_s_app + 's_app bcp cob_conta..ts_depurado out '
select @w_cmd      = @w_cmd + @w_path_listados + 'cb_depurar.lis' + ' -b5000 -c -e' + @w_errores + ' -t' + '"' +'|'+ '"' + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_cmd
if @w_error <> 0 begin
    print 'Error generando Archivo: ' + 'cb_depurar.lis'
    print @w_cmd
end

return 0


ERROR:

if @w_commit = 'S' begin
   rollback tran
   select @w_commit = 'N'
end

print @w_msg

insert into cob_conta..cb_depurar values(
@i_empresa,      @i_fecha_hasta,       @w_corte, 
@w_periodo,      @w_term ,             @w_user , 
getdate(),       0,                    @w_msg)

return 1

go
