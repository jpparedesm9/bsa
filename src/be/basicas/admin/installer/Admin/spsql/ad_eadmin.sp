/******************************************************************/
/*  ARCHIVO:         ad_eadmin.sp                                 */
/*  NOMBRE LOGICO:   sp_ad_eadmin                                 */
/*  PRODUCTO:        REMESAS                                      */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de COBISCORP S.A. Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  COBISCORP S.A. */
/*  o su representante                                            */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este programa llena los datos calculados de la tabla          */
/*  re_ex_tran_contable para el data warehouse                    */
/******************************************************************/
/*                        MODIFICACIONES                          */
/*  FECHA         AUTOR            RAZON                          */
/*  10/Ago/11     B. Ron           Emision Inicial                */
/*  04/ABR/12     Angelo Andy     Versionamiento del SP           */
/*  11-03-2016    BBO             Migracion Sybase-Sqlserver FAL  */
/******************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_ad_eadmin')
   drop proc sp_ad_eadmin
go

create proc sp_ad_eadmin (
   @t_show_version  bit       = 0,    -- show the version of the stored procedure  
   @i_fecha_proceso datetime, -- Fecha de proceso
    -- Parametros para registro de log de ejecucion
   @i_sarta         int       = null,
   @i_batch         int       = null,
   @i_secuencial    int       = null,
   @i_corrida       int       = null,
   @i_intento       int       = null
)
as

/* Declaracion de variables de uso interno */ 
declare
   @w_return              int,          -- valor retorno SPs
   @w_sp_name             varchar(32), -- nombre del stored procedure
   @w_error_msg           descripcion,   -- mensaje de error para tabla sb_error_conta
   @w_secuencial          int,
   @w_tipo_tran           smallint,
   @w_causa_dst           varchar(12),
   @w_dwh_trn_tipo        char(1),
   @w_tipo_carga          char(1),       -- Carga inicial o diaria
   --@w_moneda_local        tinyint,
   @w_fec_ext_cot         datetime,
   @w_moneda_int          tinyint,
   @w_moneda_nac          tinyint,
   @w_ciudad_fer_nac      smallint 

   
--print 'INICIA sp_ad_eadmin ...'
-- Asignar el nombre del stored procedure
select @w_sp_name = 'sp_ad_eadmin'

--------------------------------- VERSIONAMIENTO DE PROGRAMA ---------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.8'
   return 0
end
----------------------------------------------------------------------------------------------

declare trancont cursor for 
   select 
      tc_secuencial,
      tc_tipo_tran,
      tc_causa_dst    
   from cob_remesas..re_ex_tran_contable
   for update of tc_dwh_trn_tipo

-- Abrir cursor
open trancont
-- Ubicar primer registro del cursor
fetch trancont into @w_secuencial, @w_tipo_tran, @w_causa_dst


-- Manejo estado del cursor
if @@fetch_status = -1      --sqlstatus: mig syb-sqls 11032016
begin
      close trancont 
      deallocate trancont 

      select @w_error_msg='ERROR EN CURSOR'
      exec @w_return = cobis..sp_ba_error_log
            @i_sarta         = @i_sarta,
            @i_batch         = @i_batch,
            @i_secuencial    = @i_secuencial,
            @i_corrida       = @i_corrida,
            @i_intento       = @i_intento,
            @i_error         = 808070,
            @i_detalle       = @w_error_msg
            --print "ERROR: " + @w_error_msg

      return 1
end


-- Proceso para cada cuenta
while @@fetch_status = 0    --sqlstatus: mig syb-sqls 11032016
begin 
   -- M
   if (@w_tipo_tran = 48 and @w_causa_dst in ('206', '217', '269', '270', '271', '306', '307', '308', '309', '315')) or
      (@w_tipo_tran = 50 and @w_causa_dst in ('1',   '10', '100', '118', '133', '154', '16', '17', '208', '21', '211',
                                              '217', '218', '225', '245', '246', '263', '276', '278', '279', '29',
                                              '30',  '46', '48', '59', '64', '73', '74', '75', '76', '77', '78', '83',
                                              '84',  '93', '94', '95', '96')) or         
      (@w_tipo_tran = 253 and @w_causa_dst in ('15', '213', '223', '240', '268', '269', '270', '271', '272', '273', '4')) or         
      (@w_tipo_tran = 264 and @w_causa_dst in ('10', '100', '11', '12', '13', '133', '154', '221', '224', '228', '230',
                                               '233', '234', '235', '238', '251', '268', '269', '278', '279', '29', '4',
                                               '57', '58', '6', '7', '73', '74', '9'))
      select @w_dwh_trn_tipo = 'M'
   else
   if (@w_tipo_tran = 48 and @w_causa_dst in ('146', '229')) or   
      (@w_tipo_tran = 50 and @w_causa_dst in ('3', '52', '53', '54', '57'))            
      select @w_dwh_trn_tipo = 'C'   
   else
      select @w_dwh_trn_tipo = 'N'
      
   begin tran
      -- ACTUALIZA REGISTROS
         update cob_remesas..re_ex_tran_contable
         set tc_dwh_trn_tipo = @w_dwh_trn_tipo          
         where current of trancont
      
         if @@rowcount != 1
         begin
         -- Manejo de error
            rollback tran 

            select @w_error_msg    = 'ERROR AL ACTUALIZAR, re_ex_tran_contable'
            exec @w_return = cobis..sp_ba_error_log
                @i_sarta         = @i_sarta,
                @i_batch         = @i_batch,
                @i_secuencial    = @i_secuencial,
                @i_corrida       = @i_corrida,
                @i_intento       = @i_intento,
                @i_error         = 808070,
                @i_detalle       = @w_error_msg
            --print "ERROR: "+  @w_error_msg
            close trancont
            deallocate trancont

            return 1
         end
   commit tran

   -- SIGUIENTE REGISTRO
   fetch trancont into @w_secuencial, @w_tipo_tran, @w_causa_dst

   if @@fetch_status = -1   --sqlstatus: mig syb-sqls 11032016
   begin
      close trancont
      deallocate trancont

      select @w_error_msg='ERROR EN FETCH CURSOR'
      exec @w_return = cobis..sp_ba_error_log
             @i_sarta         = @i_sarta,
             @i_batch         = @i_batch,
             @i_secuencial    = @i_secuencial,
             @i_corrida       = @i_corrida,
             @i_intento       = @i_intento,
             @i_error         = 808070,
             @i_detalle       = @w_error_msg
      --print "ERROR: " +  @w_error_msg
      return 1
   end
end -- while

close trancont
deallocate trancont


-- PARAMETRO DE CIUDAD FERIADOS NACIONALES
select @w_ciudad_fer_nac = pa_smallint
from cobis..cl_parametro
where pa_nemonico = 'CFN' 
and pa_producto = 'ADM'


--PARAMETRO CARGA INICIAL O DIARIA
select @w_tipo_carga = pa_char 
from cobis..cl_parametro 
where pa_producto = 'ADM'
and pa_nemonico = 'TEDWH'


if @w_tipo_carga = 'I'
   --PARAMETRO FECHA INICIAL DE EXTRACCION COTIZACION
   select @w_fec_ext_cot = pa_datetime
   from cobis..cl_parametro
   where pa_producto='ADM'
   and pa_nemonico='FIEC'
else
begin
   select @w_fec_ext_cot = @i_fecha_proceso 
   while 1=1
   begin
   if exists(select df_fecha
             from cobis..cl_dias_feriados
             where df_ciudad = @w_ciudad_fer_nac
               and df_fecha = dateadd(dd,-1,@w_fec_ext_cot))
      select @w_fec_ext_cot = dateadd(dd,-1,@w_fec_ext_cot)
   else
      break
   end              
end

-- PARAMETRO MONEDA INTERMEDIA
select @w_moneda_int = pa_smallint 
from cobis..cl_parametro 
where pa_nemonico='MINT'
and pa_producto='CON'

-- PARAMETRO MONEDA NACIONAL 
select @w_moneda_nac = pa_tinyint 
from cobis..cl_parametro 
where pa_nemonico='CMNAC'
and pa_producto='ADM'


   insert into cob_conta..cb_ex_cotizacion (ct_empresa   ,ct_fecha ,ct_moneda ,ct_valor)
      select a.cmc_empresa, 
             a.cmc_fecha, 
             a.cmc_moneda,  
             case  
                  when isnull(a.cmc_valor_orig_mint , 0) = 0
                     then 0
                  when a.cmc_operador = '*' and isnull(a.cmc_valor_orig_mint , 0) > 0 and a.cmc_moneda <> @w_moneda_nac
                     then a.cmc_valor_orig_mint
                  when a.cmc_operador = '/' and isnull(a.cmc_valor_orig_mint , 0) > 0 and a.cmc_moneda <> @w_moneda_nac
                     then 1 / a.cmc_valor_orig_mint
                  when isnull(a.cmc_valor_orig_mint , 0) > 0 and a.cmc_moneda = @w_moneda_nac
                     then  isnull((select  1 / ct_valor 
                           from cob_conta..cb_cotizacion cot
                           where ct_empresa  = a.cmc_empresa
                           and  ct_moneda = @w_moneda_int
                           and ct_fecha    in (select max(ct_fecha)
                                              from cob_conta..cb_cotizacion
                                              where ct_empresa  = a.cmc_empresa
                                              and  ct_moneda = @w_moneda_int
                                              and ct_fecha <= a.cmc_fecha)),0)                
            end         
      from cob_conta..cb_cotizacion_mint_corte a
      where  a.cmc_fecha >= @w_fec_ext_cot and a.cmc_fecha <= @i_fecha_proceso 
--print 'FINALIZA sp_ad_eadmin ...'



set rowcount 0
return 0
go


