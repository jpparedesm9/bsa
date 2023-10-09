/*pf_repgmf.sp***********************************************************/
/*  Archivo:                         pf_repgmf.sp                       */
/*  Stored procedure:                sp_reportes_gmf                    */
/*  Base de datos:                   cob_credito                        */
/*  Producto:                        Credito                            */
/*  Disenado por:                    Myriam Davila                      */
/*  Fecha de escritura:              27-Jul-1998                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Generar BCPS de tablas despues de Generado el Cierre Mensual y      */
/*  Reportes para entregar a Usuario                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  04/02/2012  Alfredo Zuluaga          Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects WHERE name = 'sp_reportes_gmf')
   drop proc sp_reportes_gmf
go

create proc sp_reportes_gmf(
@i_param1            varchar(255),  --Fecha Proceso
@i_param2            varchar(255)   --proceso
)
with encryption
as
declare
@i_fecha_ini         datetime,
@i_fecha_fin         datetime,
@w_sp_name           varchar(30),
@w_s_app             varchar(255),
@w_path              varchar(255),
@w_nombre            varchar(255),
@w_nombre_cab        varchar(255),
@w_destino           varchar(2500),
@w_errores           varchar(1500),
@w_error             int,
@w_comando           varchar(3500),
@w_nombre_plano      varchar(2500),
@w_msg               varchar(255),
@w_col_id            int,
@w_columna           varchar(100),
@w_cabecera          varchar(2500),
@w_cont              int,
@w_nom_tabla         varchar(100),
@w_return            int,
@w_dia               int,
@w_gmf               float


select 
@i_fecha_fin     = convert(datetime, @i_param1),
@w_sp_name       = 'sp_reportes_gmf',
@w_cont          = 0

select	@w_gmf = pa_float
from	cobis..cl_parametro 
where	pa_producto = 'PFI'
and		pa_nemonico = 'IMDB'

exec @w_return          = cob_interfase..sp_iremesas
     @i_operacion       = 'AA',
	 @i_operacion_fecha = 'D',
	 @i_numdias         = null,
     @i_fecha           = @i_fecha_fin,
	 @o_dia             = @w_dia out	 

if @w_return <> 0
begin
   select
   @w_error = 2902797,
   @w_msg   = 'ERROR EN EJECUCION DE <cob_remesas..sp_mant_fecha> (1) '
   goto ERRORFIN
end

if @w_dia <> 6  return 0

exec @w_return          = cob_interfase..sp_iremesas
     @i_operacion       = 'AA',
	 @i_operacion_fecha = 'M',
	 @i_numdias         = 6,
     @i_fecha           = @i_fecha_fin,
	 @o_fecha_proc      = @i_fecha_ini out

if @w_return <> 0
begin
   select
   @w_error = 2902797,
   @w_msg   = 'ERROR EN EJECUCION DE <cob_remesas..sp_mant_fecha> (2) '
   goto ERRORFIN
end

if @i_fecha_ini is null
begin
   select @w_error = 2902797, @w_msg = 'ERROR ENCONTRANDO FECHA INICIAL PARA REPORTE '
   goto ERRORFIN
end

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 14093


/********************************/
/*             CDT              */
/********************************/

if @i_param2 = 'CDT'
begin

   truncate table pf_reporte_gmf_cdt

   select 
   tr_banco,
   ret_practicadaT = isnull(sum(case when tr_tran = 14905 and td_concepto = 'RET' then td_monto else 0 end),0),
   int_pagadosT    = isnull(sum(case when tr_tran = 14905 and td_concepto = 'INT' then td_monto else 0 end),0),
   valor_gmf_capT  = isnull(sum(case when tr_tran = 14903 and td_concepto = 'GMF' then td_monto else 0 end),0),
   valor_gmf_intT  = isnull(sum(case when tr_tran = 14905 and td_concepto = 'GMF' then td_monto else 0 end),0)
   into #temporal
   from cob_pfijo..pf_transaccion with (nolock), cob_pfijo..pf_transaccion_det with (nolock)
   where tr_operacion  = td_operacion
   and   tr_secuencial = td_secuencial
   and   tr_estado     = 'CON'
   and   tr_tran       in( 14905, 14903)
   and   tr_fecha_mov between @i_fecha_ini and @i_fecha_fin
   group by tr_banco
   
   /*REQ 329 */
   truncate table pf_reporte_gmf_cdt_det
   
   select tr_banco,
   tr_operacion, 
   tr_secuencia ,
   td_concepto,
   tr_tran,
   tr_tipo_tran = case when tr_tran = 14905 then 'INT'
   when tr_tran = 14903 then 'CAP' end,
   tr_valor = isnull(sum(td_monto),0)
   into #datos_cdt_det
   from cob_pfijo..pf_transaccion with (nolock),
   cob_pfijo..pf_transaccion_det with (nolock)
   where tr_operacion = td_operacion
   and tr_secuencial = td_secuencial
   and tr_estado = 'CON'
   and tr_tran in (14903,14905)
   and td_concepto not in ('VXP','OTROS','PCHC')
   and tr_fecha_mov between @i_fecha_ini and @i_fecha_fin
   and td_concepto in (select fp_mnemonico from cob_pfijo..pf_fpago where fp_estado = 'A')
   group by tr_banco, tr_operacion,tr_secuencia ,td_concepto, tr_tran
   order by tr_banco
   
   select 
   'sec_aux'    = isnull(M.mm_cuenta,'-1'), 
   'banco'      = tr_banco,
   'operacion'  = tr_operacion, 
   'fecha'      = tr_fecha_mov,  
   'valor'      = td_monto, 
   'forma_pago' = td_concepto,
   'cod_ofi'    = tr_ofi_usu, 
   'cod_tran'   = '            ', 
   'num_tran'   = convert(int,0),
   'monto'      = op_monto,
   'gmf'		= isnull(mm_emerg_eco,0),
   'secuencial' = mm_secuencia 
   into #aux
   from	cob_pfijo..pf_transaccion T, 
        cob_pfijo..pf_transaccion_det,
        cob_pfijo..pf_mov_monet M,
   		cob_pfijo..pf_operacion
   where   T.tr_operacion = op_operacion
   and	   T.tr_operacion = M.mm_operacion
   and     T.tr_operacion = td_operacion 
   and     T.tr_secuencial = td_secuencial
   and     T.tr_tran = 14943 
   and     T.tr_estado = 'CON'
   and     T.tr_secuencia = M.mm_secuencia  
   and     T.tr_fecha_mov between @i_fecha_ini and @i_fecha_fin
   and     td_concepto not in ('VXP','OTROS','PCHC')
   and     td_aux = mm_sub_secuencia
   order by T.tr_operacion, T.tr_secuencial
   
   
   
   select operacion, secuencial , sec_aux
   into	#auxG
   from	#aux
   where  forma_pago = 'EFEC'
   group by operacion, secuencial, sec_aux

   update #aux 
   set     sec_aux = G.sec_aux
   from	#aux A, 	
		#auxG G
   where	A.operacion = G.operacion
   and		A.secuencial = G.secuencial
   
      
   update	#aux 
   set	cod_tran =	(case when M.mm_tran = 14905 then 'INT' 
   					      when M.mm_tran = 14903 then 'CAP'
   					      else 'X' end),
        num_tran = isnull(M.mm_tran,0) 
   from	#aux A, pf_mov_monet M
   where	M.mm_operacion = operacion
   and		convert(varchar(50),M.mm_secuencial) = sec_aux
   and		M.mm_tran in (14903,14905)
   
   update	#aux 
   set	cod_tran =	(case when valor = monto then 'CAP' else 'INT' end)
   from	#aux A, pf_mov_monet M
   where	cod_tran = '            '
   and		M.mm_tran in (14903,14905)
   
   update	#aux 
   set	num_tran =	(case when cod_tran = 'CAP' then 14903 
   				          when cod_tran = 'INT' then 14905 else 0 end)
   from	#aux 
   where num_tran = 0
 
   insert into pf_reporte_gmf_cdt_det
   select banco, forma_pago, num_tran, cod_tran, valor from #aux     
   
   if @@error <> 0  begin
      select @w_msg = 'Error. pf_reporte_gmf_cdt_det'
      goto ERRORFIN
   end

   insert into pf_reporte_gmf_cdt_det
   select tr_banco,
   td_concepto, 
   tr_tran,
   tr_tipo_tran,
   tr_valor 
   from #datos_cdt_det
   
   if @@error <> 0  begin
      select @w_msg = 'Error. pf_reporte_gmf_cdt_det'
      goto ERRORFIN
   end
   
   /*FIN REQ 329*/

   create index idx1 on #temporal (tr_banco)

   select 
   codigo_ofi       = op_oficina,
   desc_ofi         = (select top 1 of_nombre from cobis..cl_oficina where of_oficina = X.op_oficina),
   nombre_titular   = en_nomlar,
   ident_titular    = en_ced_ruc,
   estado_cdt       = op_estado,
   nro_cdt          = op_num_banco,
   fecha_aper_cdt   = op_fecha_valor,
   fecha_canc_cdt   = op_fecha_ven,
   vlr_cdt          = op_monto,
   int_pagados      = convert(money, 0),
   ret_practicada   = convert(money, 0),
   base_gmf_int     = convert(money, 0),
   base_gmf_cap     = convert(money, 0),
   valor_gmf_cap    = convert(money, 0),
   valor_gmf_int    = convert(money, 0),
   opciones         = case when op_estado = 'CAN' then 'C' else '' end,
   nro_op           = op_operacion 
   into #datos_cdt
   from cob_pfijo..pf_operacion X with (nolock), cobis..cl_ente with (nolock), #temporal
   where op_ente       = en_ente
   and   op_num_banco  = tr_banco

   delete #datos_cdt
   where nro_cdt not in (select tr_banco from #temporal)

   update #datos_cdt set
   opciones = case when re_incremento < 0 then 'A' else 'R' end
   from cob_pfijo..pf_renovacion, cob_pfijo..pf_operacion, cobis..cl_ente, #temporal
   where op_ente       = en_ente
   and   op_num_banco  = tr_banco
   and   re_operacion  = op_operacion
   and   op_num_banco  = nro_cdt
   and   re_fecha_valor between @i_fecha_ini and @i_fecha_fin

   create index idx1 on #datos_cdt (nro_cdt)

   update #datos_cdt set
   int_pagados    = int_pagadosT,
   ret_practicada = ret_practicadaT,
   base_gmf_int   = (isnull(int_pagadosT,0) - isnull(ret_practicadaT,0)),
   base_gmf_cap   = 0,
   valor_gmf_cap  = valor_gmf_capT,
   valor_gmf_int  = valor_gmf_intT
   from #temporal
   where tr_banco = nro_cdt

   update #datos_cdt set
   base_gmf_cap   =    (select ISNULL(sum(mm_valor),0) from  #datos_cdt_det, pf_mov_monet   where tr_banco =  D.nro_cdt and mm_operacion = tr_operacion   and mm_secuencia = tr_secuencia   and mm_tran = 14903    and td_concepto = mm_producto     and mm_emerg_eco > 0   and mm_valor = tr_valor   and mm_estado ='A')
                     + (select ISNULL(sum(valor),0) FROM  #aux where banco = D.nro_cdt and num_tran = 14903 and forma_pago <> 'GMF' and gmf > 0 ),
   valor_gmf_cap  = valor_gmf_cap + (select ISNULL(sum(gmf),0) FROM #aux where banco  = D.nro_cdt and num_tran = 14903 ),
   valor_gmf_int  = valor_gmf_int + (select ISNULL(sum(gmf),0) FROM #aux where banco  = D.nro_cdt and num_tran = 14905 )
   from #datos_cdt  D


   update #datos_cdt set
   base_gmf_cap =( valor_gmf_cap)/@w_gmf 
   from #datos_cdt, pf_fusfra 
   where (fu_operacion = nro_op and fu_mnemonico = 'FRA')
   or (fu_operacion_new  = nro_op and fu_mnemonico = 'FUS')
   and fu_estado ='A'

   --insercion en tabla del reporte
   insert into pf_reporte_gmf_cdt
   select 
   codigo_ofi,			
   desc_ofi,
   nombre_titular,
   ident_titular,
   estado_cdt,
   nro_cdt,
   fecha_aper_cdt,
   fecha_canc_cdt,
   vlr_cdt,
   int_pagados,
   ret_practicada,
   base_gmf_int,
   base_gmf_cap,
   valor_gmf_cap,
   valor_gmf_int,
   opciones
   from #datos_cdt


   if @@error <> 0
   begin
      select @w_msg = 'Error. Insertando en pf_reporte_gmf_cdt'
      goto ERRORFIN
   end 
end

 
/********************************/
/*      CHEQUES GERENCIA        */
/********************************/

if @i_param2 = 'CHE'
begin

   truncate table pf_reporte_gmf_che
   
   if OBJECT_ID(N'tempdb..#cheques', N'U') is not null
      drop table #cheques
	  
   create table #cheques(
   oficina               smallint,
   des_oficina           varchar(160),
   cheque                int,
   fecha_emision         datetime,
   nom_benef             varchar(40),
   ide_benef             varchar(24),
   valor                 money,
   concepto              varchar(255),
   destino               varchar(160),
   base_gmf              money,
   valor_gmf             money,
   estado                varchar(21),
   usuario               varchar(64))

   exec @w_return    = cob_interfase..sp_icuentas
        @i_operacion = 'AA',
        @i_fecha_ini = @i_fecha_ini,
        @i_fecha_fin = @i_fecha_fin
   
   if @w_return <> 0 begin
      select @w_msg = 'Error, Insertando en Tabla Temporal Informacion de Cuentas'
      goto ERRORFIN
   end

   update #cheques set
   ide_benef = il_campo1,
   concepto  = il_campo21,
   estado    = case when il_estado = 'A' then 'Anulado Fisico' 
                    when il_estado = 'R' then 'Reposicion' 
                    when il_estado = 'T' then 'Anulado' 
                    when il_estado = 'I' then 'Impreso' 
                    when il_estado = 'S' then 'Suspendido' 
                    when il_estado = 'D' then 'Disponible' 
                    when il_estado = 'P' then 'Pendiente' 
               else 'No Emitido' end
   from cob_sbancarios..sb_impresion_lotes
   where il_oficina_destino = oficina
   and   il_serie_numerica  = cheque

   insert into pf_reporte_gmf_che
   select * from #cheques

   if @@error <> 0
   begin
      select @w_msg = 'Error. Insertando en pf_reporte_gmf_che'
      goto ERRORFIN
   end
end

return 0

ERRORFIN: 

   select @w_msg = @w_sp_name + ' --> ' + @w_msg
   print @w_msg
   
   return 1

go