/************************************************************************/
/*	Archivo: 		traslsald.sp                            */
/*	Stored procedure: 	sp_traslado_saldos                      */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTA                                   */
/*	Disenado por:           Ocrios        .                         */
/*	Fecha de escritura:     01/sept/2005                            */
/************************************************************************/
/*				IMPORTANTE		                */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus	        */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.	        */
/************************************************************************/
/*				PROPOSITO			        */
/*  Traslado de Saldos para Certificados de Timbre y reteica            */
/************************************************************************/
/*				MODIFICACIONES	                        */
/*	FECHA		AUTOR		RAZON 	                        */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_traslado_saldos')
	drop proc sp_traslado_saldos
go

create proc sp_traslado_saldos (
   @i_empresa  int,
   @i_proceso  int,
   @i_user     char(30),
   @i_fecha    datetime,
   @i_areaorig smallint,
   @t_debug    char(1) = 'N',
   @t_file     varchar(14) = null
)
as
        
/*DECLARACION DE VARIABLES TEMPORALES DE TRABAJO*/

declare @w_sp_name              descripcion,
        @w_corte 		int,
	@w_periodo		int,
	@w_estado_corte		char(1),
	@w_fecha_ant		datetime,
	@w_dia_sig              int,
	@w_corte_ant 		int,
	@w_periodo_ant		int,
	@w_estado_corte_ant	char(1),
	@w_cuenta		cuenta_contable,
	@w_pagadora		smallint,
	@w_asociada		smallint,
	@w_saldo                money,
	@w_saldo_me             money,
	@w_saldo_ant            money,
	@w_saldo_ant_me         money,
	@w_saldo_asiento        money,
	@w_saldo_asiento_me     money,
	@w_debito               money,
	@w_credito              money,
        @w_debito_me            money,
        @w_credito_me           money,
	@w_statussp             int,
	@w_fecha_hoy            datetime,
	@w_descripcion_comp     descripcion,
	@w_descripcion_asi      descripcion,
	
	@w_comprobante          int,
	@w_asiento              int,
	@w_area                 smallint,
	@w_empresa              tinyint,
	@w_cotiza               tinyint,
	@w_cp_condicion         char(4),
	@w_detalles             int,
	@w_totdeb               money,
	@w_totcred              money,
	@w_totdeb_me            money,
	@w_totcred_me           money,
	@w_movimientos          char(1)
                              
begin
select  @w_sp_name ='sp_traslado_saldos'

select @w_movimientos = 'N'  -- solo traslada saldos

select @w_fecha_hoy = convert(varchar, getdate(), 101)
select @w_cotiza = 0

     
-- validar que la fecha final sea la del ultimo dia del mes

   select @w_dia_sig = datepart (dd, Dateadd(dd,1,@i_fecha))
   
   if @w_dia_sig != 1
   begin
      print 'Fecha no corresponde al ultimo dia del mes'
      return 1
   end

/**    buscar periodo corte  de la fecha a realizar el traslado */ 

select @w_corte   = co_corte,  
       @w_periodo = co_periodo,
       @w_estado_corte  = co_estado  
from cob_conta..cb_corte
where co_empresa = @i_empresa
  and co_fecha_ini >= @i_fecha
  and co_fecha_fin <= @i_fecha

if @@rowcount = 0
begin
     print 'No existe periodo-corte para la fecha dada'
     return 1
end      

/*
print 'Corte %1!'+ @w_corte
print 'Periodo %1!'+ @w_periodo
print 'Estado %1!'+ @w_estado_corte

*/

if @w_estado_corte != 'A' and @w_estado_corte != 'V'
  begin
    exec cobis..sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 2805044
	return 1
   end


-- limpia tabla temporal

truncate table  tmp_saldo_traslado  

/* busca las cuentas a las que hay que hacer traslado */ 

declare cuenta_proceso cursor for 
  select  cp_cuenta, cp_condicion 
  from cob_conta..cb_cuenta_proceso
  where cp_empresa    = @i_empresa
   and cp_proceso     = @i_proceso
 for read only
  
 declare  c_asociadas  cursor for
  select  ao_oficina_consolida, ao_oficina_asociada
  from cob_conta..cb_ofpagadora, 
       cob_conta..cb_aso_oficonsol
      where of_cod_declaracion = @w_cp_condicion
      and   of_oficina_consolida = ao_oficina_consolida 
      and   of_cod_declaracion = ao_cod_declaracion
      and   ao_oficina_consolida !=  ao_oficina_asociada

 for read only


open cuenta_proceso

fetch cuenta_proceso into @w_cuenta, @w_cp_condicion

 while @@fetch_status = 0
 begin 
         if @@fetch_status = -1 
           begin
             print 'Error en Fetch de cursor cuenta_proceso'
             return 1
           end
 
   -- busca relacion de oficinas asociadas a la pagadora
  
  
     open c_asociadas
     fetch c_asociadas into @w_pagadora,  @w_asociada

     while @@fetch_status = 0
      begin 
         if @@fetch_status = -1 
           begin
             print 'Error en Fetch de cursor c_asociadas'
             return 1
           end


select @w_saldo_ant = 0
select @w_saldo_ant_me = 0           


if @w_movimientos = 'S'
begin

/*  busca periodo y corte del ultimo dia del mes anterior*/ 

 
    Select @w_fecha_ant = Dateadd(dd,-1,Convert(varchar(2),Datepart(mm,@i_fecha))+'/01/'+
                          Convert(varchar(4),Datepart(yy,@i_fecha)))

    select @w_corte_ant   = co_corte,  
           @w_periodo_ant = co_periodo,
           @w_estado_corte_ant = co_estado
           from cob_conta..cb_corte
    where co_empresa = @i_empresa
    and co_fecha_ini >= @w_fecha_ant
    and co_fecha_fin <=@w_fecha_ant
    
    if @@rowcount = 0
    begin
      print 'No existe periodo-corte para el ultimo dia del mes anterior'
      return 1
    end 
   

       -- Busca el saldo del ultimo dia del mes anterior -- para tomar solamente los movimientos del mes

         if @w_estado_corte_ant = 'A'
         begin
           select @w_saldo_ant = sa_saldo, 
                 @w_saldo_ant_me = sa_saldo_me 
           from cob_conta..cb_saldo
           where  sa_corte =   @w_corte_ant
           and sa_periodo = @w_periodo_ant
           and sa_oficina =  @w_asociada
           and sa_area >= 0
           and sa_cuenta =  @w_cuenta
           and sa_empresa = @i_empresa 
        
           if @@rowcount = 0
           begin
             select @w_saldo_ant = 0
             select @w_saldo_ant_me = 0
           end
          end
          else
          begin
             select @w_saldo_ant= hi_saldo, 
                   @w_saldo_ant_me = hi_saldo_me
             from cob_conta_his..cb_hist_saldo
             where  hi_corte =   @w_corte_ant
             and    hi_periodo = @w_periodo_ant
             and    hi_oficina =  @w_asociada
             and    hi_area > 0
             and    hi_cuenta =  @w_cuenta
             and    hi_empresa = @i_empresa 

            if @@rowcount = 0
            begin
              select @w_saldo_ant = 0
              select @w_saldo_ant_me = 0
            end
          end

end

   
          -- busca el saldo a la fecha de la cuenta
   
 
           if @w_estado_corte = 'A'  --  busca el saldo en la cb_saldo
           begin
      
             insert into tmp_saldo_traslado (ts_corte, ts_periodo, ts_oficina_pag, ts_oficina_aso, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_saldo_ant, ts_saldo_ant_me, ts_cod_declar )
                     
             select  sa_corte, sa_periodo, @w_pagadora,  @w_asociada, sa_area, sa_cuenta, 
                     sa_empresa, sa_saldo, sa_saldo_me, @w_saldo_ant,  @w_saldo_ant_me, @w_cp_condicion
             from cob_conta..cb_saldo
             where  sa_corte =   @w_corte
             and sa_periodo = @w_periodo
             and sa_oficina =  @w_asociada
             and sa_area >= 0
             and sa_cuenta =  @w_cuenta
             and sa_empresa = @i_empresa 
             and ( (sa_saldo - @w_saldo_ant )  <> 0  or  (sa_saldo_me - @w_saldo_ant_me ) <>0 )
           end

           else
           begin   -- busca el saldo en cob_conta_his..cb_hist_saldo
              insert into tmp_saldo_traslado ( ts_corte, ts_periodo, ts_oficina_pag, ts_oficina_aso, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me,  ts_saldo_ant, ts_saldo_ant_me, ts_cod_declar)   
        
              select  hi_corte, hi_periodo, @w_pagadora, hi_oficina,  hi_area, 
                    hi_cuenta, hi_empresa, hi_saldo, hi_saldo_me, @w_saldo_ant,  @w_saldo_ant_me, @w_cp_condicion
              from cob_conta_his..cb_hist_saldo
              where hi_corte =   @w_corte
              and hi_periodo = @w_periodo
              and hi_oficina =  @w_asociada
              and hi_area >= 0
              and hi_cuenta =  @w_cuenta
              and hi_empresa = @i_empresa 
              and ((hi_saldo - @w_saldo_ant )  <> 0  or  (hi_saldo_me - @w_saldo_ant_me ) <> 0 )
          end

          --print 'antes del segundo fetch c_asociadas'
     
          fetch c_asociadas into @w_pagadora,  @w_asociada
     
        end -- end while c_asociadas
     
        --print 'antes de cerrar c_asociadas'
     
        close c_asociadas
        
     
     fetch cuenta_proceso into @w_cuenta, @w_cp_condicion
    
 end  -- end while cuanta_proceso
   
   
 close cuenta_proceso
 
 deallocate c_asociadas   
 deallocate cuenta_proceso
  
  
  --  Abre cursor de oficinas pagadoras para crear los comprobantes de traslado
  
   declare c_pagadora cursor for
   select distinct ts_oficina_pag
   from tmp_saldo_traslado
   

   select @w_descripcion_comp = 'TRASLADO DE SALDOS'

   open c_pagadora
   fetch c_pagadora into @w_pagadora
   
   while @@fetch_status = 0
      begin 
         if @@fetch_status = -1 
           begin
             print 'Error en Fetch de cursor c_pagadora'
             return 1
           end
  
       select @w_asiento = 1
       
      -- inserta el comprobante temporal
      
        exec  @w_statussp =  sp_comprobt
	@t_trn          = 6111,
	@i_automatico   = @i_proceso,
	@i_operacion    = 'I',
	@i_modo         = 0,
	@i_empresa      = @i_empresa,
	@i_oficina_orig = @w_pagadora,              
	@i_area_orig    = @i_areaorig,              
	@i_fecha_tran   = @i_fecha,
	@i_fecha_dig    = @w_fecha_hoy,
	@i_fecha_mod    = @w_fecha_hoy,
	@i_digitador    = @i_user,
	@i_descripcion  = @w_descripcion_comp,
	@i_mayorizado   = 'N',
	@i_mayoriza     = 'N',
	@i_autorizado   = 'S',
	@i_autorizante  = @i_user,
	@i_reversado    = 'N',
	@o_tcomprobante = @w_comprobante out  
	
	if @w_statussp <>0
	
	begin
	   print 'Error en la creacion de Comprobante'
	   return 1
	end
	
	--print 'Comprobante %1!'+ @w_comprobante



        declare c_asociadas_tmp cursor for
        select ts_oficina_aso, ts_area, ts_cuenta, ts_empresa, ts_saldo, ts_saldo_me, ts_saldo_ant, ts_saldo_ant_me
        from tmp_saldo_traslado
        where ts_oficina_pag =  @w_pagadora 

        open c_asociadas_tmp
        
        fetch c_asociadas_tmp into @w_asociada, @w_area, @w_cuenta, @w_empresa, 
        @w_saldo, @w_saldo_me, @w_saldo_ant, @w_saldo_ant_me

        while @@fetch_status = 0
        begin 
         if @@fetch_status = -1 
           begin
             print 'Error en Fetch de cursor c_asociadas_tmp'
             return 1
           end
           
          select @w_saldo_asiento = @w_saldo -  @w_saldo_ant
          select @w_saldo_asiento_me = @w_saldo_me -  @w_saldo_ant_me
   
          if @w_saldo_asiento > 0  -- saldo debito
          begin
            select @w_debito = 0
            select @w_debito_me = 0

            select @w_credito = @w_saldo_asiento
            select @w_credito_me = @w_saldo_asiento_me
       
          end
          else  -- saldo credito
          begin
            select @w_debito = abs(@w_saldo_asiento)
            select @w_debito_me = abs(@w_saldo_asiento_me)
            
            select @w_credito = 0
            select @w_credito_me = 0
            
          end
       
        -- genera asiento de retiro - temporal
        
           select @w_descripcion_asi = 'TRASLADO DE SALDOS - RETIRO'
       
         exec  @w_statussp = sp_asientot
           @t_trn          = 6341,
	   @i_operacion    = 'I',
	   @i_modo         = 0,
	   @i_empresa      = @i_empresa,
	   @i_comprobante  = @w_comprobante,
	   @i_fecha_tran   = @i_fecha,
	   @i_asiento      = @w_asiento,
	   @i_cuenta       = @w_cuenta,
	   @i_oficina_dest = @w_asociada,
	   @i_area_dest    = @w_area,
	   @i_credito      = @w_credito,
	   @i_debito       = @w_debito,
	   @i_concepto     = @w_descripcion_asi,
	   @i_credito_me   = @w_credito_me,
	   @i_debito_me    = @w_debito_me,
	   @i_cotizacion   = @w_cotiza,
	   @i_tipo_doc     = 'N',
	   @i_mayorizado   = 'N',
           @i_tipo_tran    = 'N',
           @i_oficina_orig = @w_pagadora

	if @w_statussp <>0
	begin
	  print 'Error en la creacion del Asiento origen'
	  return 1
	end

        --print 'Asiento origen %1!'+ @w_asiento

        select @w_asiento = @w_asiento + 1

          -- genera asiento de traslado - temporal
          
         select @w_descripcion_asi = 'TRASLADO DE SALDOS - INGRESO'

         exec  @w_statussp = sp_asientot
           @t_trn          = 6341,
	   @i_operacion    = 'I',
	   @i_modo         = 0,
	   @i_empresa      = @i_empresa,
	   @i_comprobante  = @w_comprobante,
	   @i_fecha_tran   = @i_fecha,
	   @i_asiento      = @w_asiento,
	   @i_cuenta       = @w_cuenta,
	   @i_oficina_dest = @w_pagadora,
	   @i_area_dest    = @w_area,
	   @i_credito      = @w_debito,-- se invierten
	   @i_debito       = @w_credito,
	   @i_concepto     = @w_descripcion_asi,
	   @i_credito_me   = @w_credito_me,
	   @i_debito_me    = @w_debito_me,
	   @i_cotizacion   = @w_cotiza,
	   @i_tipo_doc     = 'N',
	   @i_mayorizado   = 'N',
           @i_tipo_tran    = 'N',
           @i_oficina_orig = @w_pagadora

   	if @w_statussp <>0
	begin
	  print 'Error en la creacion del Asiento destino'
	  return 1
	end
	
        --print 'Asiento destino %1!'+ @w_asiento	

        select @w_asiento = @w_asiento + 1
          
   
         fetch c_asociadas_tmp into @w_asociada, @w_area, @w_cuenta, @w_empresa, 
         @w_saldo, @w_saldo_me, @w_saldo_ant, @w_saldo_ant_me

       end -- fin cursor de asociadas

        close c_asociadas_tmp
        deallocate c_asociadas_tmp
      
       
      -- busca detalles del comprobante
      
      select  @w_detalles = max(ta_asiento),
              @w_totdeb   = sum(ta_debito),
              @w_totcred  = sum(ta_credito),
              @w_totdeb_me = sum(ta_debito_me),
              @w_totcred_me = sum(ta_credito_me)
      from cb_tasiento
      where ta_empresa     = @i_empresa
      and ta_fecha_tran    = @i_fecha
      and ta_comprobante   = @w_comprobante
      and ta_oficina_orig  = @w_pagadora
      
      -- Inserta el comprobante definitivo por pagadora
      
      exec  @w_statussp = sp_compmig
           @t_trn          = 6342,
           @i_operacion    = 'I',
           @i_empresa      = @i_empresa,
           @i_fecha_tran   = @i_fecha,
           @i_comprobante  = @w_comprobante,
           @i_oficina_orig = @w_pagadora,
           @i_detalles     = @w_detalles,
           @i_tot_debito   = @w_totdeb,
           @i_tot_credito  = @w_totcred,
           @i_tot_debito_me = @w_totdeb_me,
           @i_tot_credito_me = @w_totcred_me,
           @i_mayorizar      = 'S' 
           
   	if @w_statussp <>0
	begin
	  print 'Error en la creacion del Comprobante Definitivo Pagadora %1!+ Comprobante %2!'+ @w_pagadora+ @w_comprobante
	  return 1
	end
           
      
      fetch c_pagadora into @w_pagadora
   end
   
   
   close c_pagadora
   deallocate c_pagadora
   return 0      
end   
go