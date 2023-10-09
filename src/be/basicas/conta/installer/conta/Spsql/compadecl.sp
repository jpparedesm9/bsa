/************************************************************************/
/*	Archivo: 		compadecl.sp                            */
/*	Stored procedure: 	sp_comp_pag_decl                        */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTA                                   */
/*	Disenado por:           Ocrios        .                         */
/*	Fecha de escritura:     07/mar/2007                             */
/************************************************************************/
/*				PROPOSITO			        */
/*  Comprobante de pago de declaraciones de reteica o  estampilla       */
/************************************************************************/
/*				MODIFICACIONES	                        */
/*	FECHA		AUTOR		RAZON 	                        */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comp_pag_decl')
	drop proc sp_comp_pag_decl
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_comp_pag_decl (
   @i_empresa  int,
   @i_proceso  int,
   @i_user     char(30),
   @i_fecha_proceso    datetime,
   @i_areaorig smallint,
   @t_debug    char(1) = 'N',
   @t_file     varchar(14) = null
)
as
        
/*DECLARACION DE VARIABLES TEMPORALES DE TRABAJO*/

declare @w_sp_name              descripcion,
        @w_corte 		int,
	@w_periodo		int,
	@w_corte_pte		int,
	@w_periodo_pte		int,
	@w_estado_corte		char(1),
	@w_fecha_ant		datetime,
	@w_dia_sig              int,
	@w_estado_corte_pte	char(1),
	@w_cuenta		cuenta_contable,
	@w_cta_pte		cuenta_contable,
	@w_cta_difmay		cuenta_contable,
	@w_cta_difmen		cuenta_contable,
	@w_oficina_pag		smallint,
	@w_asociada		smallint,
	@w_saldo                money,
	@w_saldo_me             money,
	@w_saldo_ant            money,
	@w_saldo_ant_me         money,
	@w_debito               money,
	@w_credito              money,
        @w_debito_me            money,
        @w_credito_me           money,
	@w_valor_cta_pte	money,
	@w_valor_cta_ret	money,
	@w_diferencia		money,
	@w_statussp             int,
	@w_fecha_hoy            datetime,
	@w_descripcion_comp     descripcion,
	@w_descripcion_asi      descripcion,
	@w_categoria		char(1),
	@w_tip_reg		char(1),
	@w_comprobante          int,
	@w_asiento              int,
	@w_area                 smallint,
	@w_empresa              tinyint,
	@w_cotiza		tinyint,
	@w_cod_declaracion      char(4),
	@w_detalles             int,
	@w_totdeb               money,
	@w_totcred              money,
	@w_totdeb_me            money,
	@w_totcred_me           money,
	@w_movimientos          char(1),
	@w_ente                 int,
	@w_condicion            char(1),
	@w_saldo_ret            money,
    	@w_identifica           varchar(30),
    	@w_tipoced              char(2),
    	@w_conc_imp		char(6),
    	@w_autorizante 		descripcion,
    	@w_error		int,
    	@w_cont			int,
    	@w_comprobante_def      int
                              
--begin



select  @w_sp_name = 'sp_comp_pag_decl'

select @w_fecha_hoy = convert(varchar, getdate(), 101)


select @w_cotiza = 0


--print 'Busca corte de la fecha de proceso '+ cast(@i_fecha_proceso as varchar)

     
/* *****    buscar periodo corte  a fecha de la cancelacion para cuentas puente */ 

select @w_corte_pte   = co_corte,  
       @w_periodo_pte = co_periodo,
       @w_estado_corte_pte  = co_estado  
from cob_conta..cb_corte
where co_empresa = @i_empresa
  and co_fecha_ini >= @i_fecha_proceso
  and co_fecha_fin <= @i_fecha_proceso

if @@rowcount = 0
begin
    /* Corte especificado no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601078
        return 1
end  


if @w_estado_corte_pte != 'A' and @w_estado_corte_pte != 'V'
begin
    /* Periodo o Corte no vigente o Cerrado */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 603023
        return 1
end  


--print 'Asigna estado del corte'

update cb_ctrl_proceso_comp_pag_decl
set cp_corte =  co_corte,
    cp_periodo = co_periodo,
    cp_estado_corte =  co_estado

from cob_conta..cb_corte
where  co_empresa = @i_empresa
  and co_fecha_ini >= cp_fecha_corte
  and co_fecha_fin <= cp_fecha_corte
  and (cp_estado is null or cp_estado = 'E')


truncate table cb_ofi_pag_decl_tmp

truncate table saldo_pago_declar_ret_tmp


--print 'Selecciona oficinas a procesar'

insert into cb_ofi_pag_decl_tmp
(
op_empresa, 		
op_oficina,		
op_cod_declaracion, 	
op_cuenta,
op_nit,		
op_fecha_proc,		
op_fecha_corte,
op_fecha_ejec,
op_periodo,
op_corte,
op_estado_corte	
)
select 
 b.cp_empresa, 
 of_oficina_consolida, 
 of_cod_declaracion,
 cp_cuenta,
 no_ente,
 @i_fecha_proceso,
 cp_fecha_corte,
 getdate(),
 cp_periodo,
 cp_corte,
 cp_estado_corte
  from cob_conta..cb_ofpagadora a, 
       cb_ctrl_proceso_comp_pag_decl b, 
       cob_conta..cb_cuenta_proceso  c,
       cob_conta..cb_nits_ofi_pag_decl
       where b.cp_oficina = a.of_oficina_consolida
       and  b.cp_cod_declaracion = a.of_cod_declaracion 
       and  (cp_estado is null or cp_estado = 'E')
       and  c.cp_empresa     = @i_empresa
       and  c.cp_proceso     = 6083 --  proceso de traslado de saldos
       and  c.cp_condicion =  a.of_cod_declaracion 
       and no_oficina =  of_oficina_consolida
       and no_empresa = @i_empresa


-- busca las oficinas pagadoras, cuentas  y declaracion a procesar



 
 select @w_cta_pte =  cp_cuenta
  from cob_conta..cb_cuenta_proceso
  where cp_empresa    = @i_empresa
   and cp_proceso     = @i_proceso --  proceso de comprobante de pago
   and cp_condicion  = 'CPTE'
   
 select @w_cta_difmay =  cp_cuenta
  from cob_conta..cb_cuenta_proceso
  where cp_empresa    = @i_empresa
   and cp_proceso     = @i_proceso --  proceso de comprobante de pago
   and cp_condicion  = 'CDMA'

   
  select @w_cta_difmen =  cp_cuenta
  from cob_conta..cb_cuenta_proceso
  where cp_empresa    = @i_empresa
   and cp_proceso     = @i_proceso --  proceso de comprobante de pago
   and cp_condicion  = 'CDME'
   

  select @w_conc_imp = pa_char
  from cobis..cl_parametro
  where pa_producto = 'CON'
  and pa_nemonico = 'CICPR'
     

  select @w_autorizante = pa_char
  from cobis..cl_parametro
  where pa_producto = 'CON'
  and pa_nemonico = 'USCPR'


            if exists (select 'x' from  cb_ofi_pag_decl_tmp
                         where op_estado_corte = 'A')
            begin


            -- inserta saldos de las cuentas auxiliares
                            
             insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_cod_declar, ts_ente, ts_tip_reg )
                     
             select 
                   sa_corte, sa_periodo, sa_oficina, sa_area, sa_cuenta,
                   sa_empresa, sa_saldo, sa_saldo_me, op_cod_declaracion, 
                   op_nit, 'A'
                   
             from cob_conta..cb_saldo,  cb_ofi_pag_decl_tmp
             where sa_cuenta = op_cuenta
             and   sa_oficina = op_oficina
             and   sa_area > 0
	     and   sa_corte  = op_corte
             and   sa_periodo = op_periodo
             and   sa_empresa = @i_empresa 
             and   sa_saldo  <> 0  
             and   op_estado_corte = 'A'
	    end

            
            else
                         
             begin            

             	insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_cod_declar, ts_ente, ts_tip_reg )
                     
             	select 
                   hi_corte, hi_periodo, hi_oficina, hi_area, hi_cuenta,
                   hi_empresa, hi_saldo, hi_saldo_me, op_cod_declaracion, 
                   op_nit, 'A'
             from  cob_conta_his..cb_hist_saldo,  cb_ofi_pag_decl_tmp
             where hi_cuenta = op_cuenta
             and   hi_oficina = op_oficina
             and   hi_area > 0
	     and   hi_corte  = op_corte
             and   hi_periodo = op_periodo
             and   hi_empresa = @i_empresa 
             and   hi_saldo  <> 0  
             and   op_estado_corte != 'A'
             
            end 


	 -- Inserta el saldo de la cuenta puente
	 
	  if @w_estado_corte_pte = 'A'
	  begin
	  
             insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_cod_declar, ts_ente, ts_tip_reg )
                     
             select 
                   sa_corte, sa_periodo, sa_oficina, sa_area, sa_cuenta,
                   sa_empresa, sa_saldo, sa_saldo_me, null, 
                   no_ente, 'P'
             from cob_conta..cb_saldo   a,  cb_nits_ofi_pag_decl
             where sa_cuenta = @w_cta_pte
             and   sa_oficina  in (select ts_oficina_pag  from saldo_pago_declar_ret_tmp)
             and   sa_area > 0
	     and   sa_corte  = @w_corte_pte
             and   sa_periodo = @w_periodo_pte
             and   sa_empresa = @i_empresa 
             and   sa_saldo  <> 0  
	     and   no_empresa = @i_empresa
             and   no_oficina = sa_oficina
         end

	
	 else
         begin

             insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_cod_declar, ts_ente, ts_tip_reg )
                     
             select 
                   hi_corte, hi_periodo, hi_oficina, hi_area, hi_cuenta,
                   hi_empresa, hi_saldo, hi_saldo_me, null, 
                   no_ente, 'P'
             from cob_conta_his..cb_hist_saldo, cb_nits_ofi_pag_decl
             where hi_cuenta = @w_cta_pte
             and   hi_oficina  in (select ts_oficina_pag  from saldo_pago_declar_ret_tmp)
             and   hi_area > 0
	     and   hi_corte  = @w_corte_pte
             and   hi_periodo = @w_periodo_pte
             and   hi_empresa = @i_empresa 
             and   hi_saldo  <> 0  
	     and   no_empresa = @i_empresa
             and   no_oficina = hi_oficina
	 end





 -- cursor de oficinas pagadoras a procesar con asientos a cancelar


select @w_cont = count(0) from  saldo_pago_declar_ret_tmp

if @w_cont = 0
begin
--   print 'No hay saldos para procesar'
   return 0
end

 declare c_oficinas_pag  cursor for
  select distinct ts_oficina_pag  
  from  saldo_pago_declar_ret_tmp
  order by ts_oficina_pag  
  for read only
  
  

 open  c_oficinas_pag
 fetch c_oficinas_pag into  @w_oficina_pag



while @@fetch_status = 0
begin 
         if @@fetch_status = -1 
           begin
--             print 'Error en Fetch de cursor c_oficinas_pag'
             return 1
           end

  select @w_cod_declaracion = op_cod_declaracion
    from  cb_ofi_pag_decl_tmp 
    where op_oficina = @w_oficina_pag
    
    if @w_cod_declaracion = '01'
        select @w_descripcion_comp = 'PAGO RETENCION DE ICA'  
    
    if @w_cod_declaracion = '03'
        select @w_descripcion_comp = 'PAGO RETENCION DE ESTAMPILLAS'  


        -- calcula diferencias 
        
        select @w_valor_cta_pte = 0,
               @w_valor_cta_ret = 0,
               @w_diferencia = 0
        

        select @w_valor_cta_pte  = isnull(sum(ts_saldo),0)
            from  saldo_pago_declar_ret_tmp
            where ts_oficina_pag = @w_oficina_pag
            and   ts_tip_reg = 'P'    
        
        select  @w_valor_cta_ret =  isnull( sum(ts_saldo),0)
         from  saldo_pago_declar_ret_tmp
            where ts_oficina_pag = @w_oficina_pag
            and   ts_tip_reg = 'A' 
            
--         print 'Valor cta puente  %1!  Oficina %2!'+ cast(@w_valor_cta_pte as varchar)+ cast(@w_oficina_pag as varchar)
--         print 'Valor cta de retencion %1!  Oficina %2!'+ cast(@w_valor_cta_ret as varchar) + cast(@w_oficina_pag as varchar)
         
        if @w_valor_cta_pte = 0 
        begin        
--           print 'Error. No hay saldo para la cuenta puente'
           update cb_ctrl_proceso_comp_pag_decl  
	   set cp_fecha_ejec =  @w_fecha_hoy,
           cp_estado = 'E'
           where cp_oficina = @w_oficina_pag
           and  cp_empresa = @i_empresa
           and  (cp_estado is null or cp_estado = 'E')
 
           return 1          
        end    

        if @w_valor_cta_ret = 0 
        begin        
--           print 'Error. No hay saldo para las cuentas de retencion'
           update cb_ctrl_proceso_comp_pag_decl  
	   set cp_fecha_ejec =  @w_fecha_hoy,
           cp_estado = 'E'
           where cp_oficina = @w_oficina_pag
           and  cp_empresa = @i_empresa
           and  (cp_estado is null or cp_estado = 'E')
 
           return 1          
           
        end    
        
            
        select @w_diferencia = abs(@w_valor_cta_pte) - abs( @w_valor_cta_ret)
         
--	print 'Inserta los registros de diferencia  Oficina %1!' + cast(@w_oficina_pag as varchar)


        if  abs(@w_valor_cta_pte) <  abs(@w_valor_cta_ret) 
        begin
--            print 'Insertando diferencia por menor valor Cuenta %1!'+ cast(@w_cta_difmen as varchar)
            
             insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_ente, ts_tip_reg )
                     
                  select 
                  @w_corte_pte, 
                  @w_periodo_pte, 
                  @w_oficina_pag, 
                  @i_areaorig, 
                  @w_cta_difmen,
                  @i_empresa, 
                  @w_diferencia, 
                  0,
                  no_ente,
		  'D'  
                  from cb_nits_ofi_pag_decl
                  where no_empresa = @i_empresa and no_oficina = @w_oficina_pag 
                  
                  select @w_error = @@error
                  if @w_error != 0 
                  begin
--                     print 'Error en Asiento de diferencia menor'
                      	update cb_ctrl_proceso_comp_pag_decl  
	        	set cp_fecha_ejec =  @w_fecha_hoy,
         		cp_estado = 'E'
         		where cp_oficina = @w_oficina_pag
         		and  cp_empresa = @i_empresa
         		and  (cp_estado is null or cp_estado = 'E')
                    return 1        
                  end    
                  
        
        end

        if  abs(@w_valor_cta_pte) >   abs(@w_valor_cta_ret) 
        begin
        
--        print 'Insertando diferencia por mayor valor %1!'+ cast(@w_cta_difmen as varchar)
             insert into saldo_pago_declar_ret_tmp 
                   (ts_corte, ts_periodo, ts_oficina_pag, ts_area, ts_cuenta,
                    ts_empresa, ts_saldo, ts_saldo_me, ts_ente, ts_tip_reg )
                     
                  select 
                  @w_corte_pte, 
                  @w_periodo_pte, 
                  @w_oficina_pag, 
                  @i_areaorig, 
                  @w_cta_difmay,
                  @i_empresa, 
                  @w_diferencia,  
                  0,    
                  no_ente,
                  'D'  
                  from cb_nits_ofi_pag_decl
                  where no_empresa = @i_empresa
                  and no_oficina = @w_oficina_pag 
                  
                  select @w_error = @@error
                  if @w_error != 0 
                  begin
--                     print 'Error en Asiento de diferencia mayor'
                      	update cb_ctrl_proceso_comp_pag_decl  
	        	set cp_fecha_ejec =  @w_fecha_hoy,
         		cp_estado = 'E'
         		where cp_oficina = @w_oficina_pag
         		and  cp_empresa = @i_empresa
         		and  (cp_estado is null or cp_estado = 'E')
                    return 1        
                  end    

       end
        
--       print ' -- inserta el comprobante temporal'
       
--       print 'Proceso %1!'+ cast(@i_proceso as varchar)
--       print 'Oficina Pagadora %1!'+ cast(@w_oficina_pag as varchar)
--       print 'Area origen %1!'+ cast(@i_areaorig as varchar)
--       print 'Fecha proceso %1!'+ cast(@i_fecha_proceso as varchar)
--       print 'Fecha digit %1!'+ cast(@w_fecha_hoy as varchar)
--       print 'User %1!'+ cast(@i_user as varchar)
--       print 'Autorizante %1!'+ cast(@w_autorizante as varchar)
       
      
        exec  @w_statussp =  sp_comprobt
	    @t_trn          = 6111,
	    @i_automatico   = @i_proceso,
	    @i_operacion    = 'I',
	    @i_modo         = 0,
	    @i_empresa      = @i_empresa,
	    @i_oficina_orig = @w_oficina_pag,              
	    @i_area_orig    = @i_areaorig,              
	    @i_fecha_tran   = @i_fecha_proceso,
	    @i_fecha_dig    = @w_fecha_hoy,
	    @i_fecha_mod    = @w_fecha_hoy,
	    @i_digitador    = @i_user,   
	    @i_descripcion  = @w_descripcion_comp,
	    @i_mayorizado   = 'N',
	    @i_mayoriza     = 'N',
	    @i_autorizado   = 'S',
	    @i_autorizante  = @w_autorizante,
	    @i_reversado    = 'N',
	    @o_tcomprobante = @w_comprobante out  
	    
	    if @w_statussp <>0
	    
	    begin
--	       print 'Error en la creacion de Comprobante temporal'
	        update cb_ctrl_proceso_comp_pag_decl  
	        set cp_fecha_ejec =  @w_fecha_hoy,
         	cp_estado = 'E'
         	where cp_oficina = @w_oficina_pag
         	and  cp_empresa = @i_empresa
         	and  (cp_estado is null or cp_estado = 'E')

	       return 1
	    end
	    
--	    print 'Comprobante %1!'+ cast(@w_comprobante as varchar)


          
           -- busca los asientos
           
           declare c_asientos cursor for
           select ts_area, ts_cuenta, ts_empresa, isnull(ts_saldo,0), isnull(ts_saldo_me,0), ts_ente, ts_tip_reg
           from saldo_pago_declar_ret_tmp
           where ts_oficina_pag =  @w_oficina_pag 
           

           select @w_asiento = 1   
           
           open c_asientos
           
           fetch c_asientos into   @w_area,  @w_cuenta, @w_empresa, @w_saldo, @w_saldo_me, @w_ente, @w_tip_reg
           
           while @@fetch_status = 0
	   begin 
           if @@fetch_status = -1 
            begin
--              print 'Error en Fetch de cursor c_asientos'
         	update cb_ctrl_proceso_comp_pag_decl  
         	set cp_fecha_ejec =  @w_fecha_hoy,
         	cp_estado = 'E'
         	where cp_oficina = @w_oficina_pag
         	and  cp_empresa = @i_empresa
         	and  (cp_estado is null or cp_estado = 'E')
              
              return 1
            end

           select @w_condicion   = null
     	   select @w_descripcion_asi = @w_descripcion_comp


        if @w_tip_reg != 'D' --  se cancela contra si misma la cuenta
        begin
        -- verifica el saldo de la cuenta para cancelarlo
        

          if @w_saldo > 0  -- saldo debito
          begin
            select @w_debito = 0
            select @w_debito_me = 0

            select @w_credito = @w_saldo
            select @w_credito_me = 0
       
          end
          else  -- saldo credito
          begin
            select @w_debito = abs(@w_saldo)
            select @w_debito_me = abs(@w_saldo_me)
            
            select @w_credito = 0
            select @w_credito_me = 0
            
          end
          
        end
        else
        begin
        
          select @w_categoria = cu_categoria
             from cob_conta..cb_cuenta
             where cu_empresa = @i_empresa
             and cu_cuenta = @w_cuenta
             
          if @w_categoria = 'C'
          begin
            select @w_debito = 0
            select @w_debito_me = 0

            select @w_credito = abs(@w_saldo)
            select @w_credito_me = abs(@w_saldo_me)
          
          end
          else
          begin
            select @w_debito = abs(@w_saldo)
            select @w_debito_me = abs(@w_saldo_me)
            
            select @w_credito = 0
            select @w_credito_me = 0
            
          end
         end   
       
--        print 'genera asiento'
--        print 'Empresa %1!'+ cast(@i_empresa as varchar)
--        print 'Comprobante %1!'+ cast(@w_comprobante as varchar)
--        print 'Fecha tran %1!'+ cast(@i_fecha_proceso as varchar)
--        print 'Asiento %1!'+ cast(@w_asiento as varchar)
--        print 'Cuenta %1!'+ @w_cuenta
--        print 'Oficina dest %1!'+ cast(@w_oficina_pag as varchar)
--        print 'Area dest %1!'+ cast(@w_area as varchar)
--        print 'Credito %1!'+ cast(@w_credito as varchar)
--        print 'Debito %1!'+ cast (@w_debito as varchar)
--        print 'Cotiza %1!'+ cast(@w_cotiza as varchar)
--        print 'Credito_me %1!'+ cast(@w_credito_me as varchar)
--        print 'Debito_me %1!'+ cast(@w_debito_me as varchar)
--        print 'Descripcion %1!'+ @w_descripcion_asi
        

       

         exec  @w_statussp = sp_asientot
             @t_trn          = 6341,
             @i_operacion    = 'I',
             @i_modo         = 0,
             @i_empresa      = @i_empresa,
             @i_comprobante  = @w_comprobante,
             @i_fecha_tran   = @i_fecha_proceso,
             @i_asiento      = @w_asiento,
             @i_cuenta       = @w_cuenta,
             @i_oficina_dest = @w_oficina_pag,
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
	     @i_oficina_orig = @w_oficina_pag 
		     
	     
 	     if @w_statussp <> 0 	     
               begin 	       
--               print 'Error en la creacion del Asiento origen' 	       

               update cb_ctrl_proceso_comp_pag_decl  
               set cp_fecha_ejec =  @w_fecha_hoy,
               cp_estado = 'E'
               where cp_oficina = @w_oficina_pag
               and  cp_empresa = @i_empresa
               and  (cp_estado is null or cp_estado = 'E')

               return 1 	     
             end 	



         SELECT @w_condicion =  cp_condicion
         from cob_conta..cb_cuenta_proceso
         where cp_proceso  =  6095
         and  cp_cuenta   = @w_cuenta	
            
            
--         print 'Condicion    %1!' + cast(@w_condicion as varchar)
         if @w_condicion is not null
         begin
          
         
           select @w_identifica = en_ced_ruc,
                @w_tipoced = en_tipo_ced
           from  cobis..cl_ente
           where en_ente = @w_ente


	   select @w_saldo_ret = abs(@w_saldo)     


--           print 'retencion '
--           print 'Ente %1!'+ cast(@w_ente as varchar)
--           print 'Concepto %1!'+ cast( @w_conc_imp as varchar)
--           print 'Cuenta %1!'+ @w_cuenta
         
         

           EXECUTE @w_statussp = cob_conta..sp_retenciont
           @t_trn          = 6299,
           @i_operacion    = 'I',
           @i_comprobante  = @w_comprobante,
           @i_empresa      = @i_empresa,
           @i_asiento      = @w_asiento,
           @i_identif      = @w_identifica,
           @i_tipoid       = @w_tipoced,
           @i_concepto     = @w_conc_imp, 
           @i_cuenta       = @w_cuenta,
           @i_ente         = @w_ente,
           @i_fecha        = @i_fecha_proceso,
           @i_documento    = '.',
           @i_oficina_orig = @w_oficina_pag,
           @i_operrete     = @w_condicion,
           @i_retencion    = @w_saldo_ret,
           @i_valorete     = @w_saldo_ret
   	     if @w_statussp <>0
	     begin
--             print 'Error en la creacion de registro de retencion'
           
             update cb_ctrl_proceso_comp_pag_decl  
             set cp_fecha_ejec =  @w_fecha_hoy,
             cp_estado = 'E'
             where cp_oficina = @w_oficina_pag
             and  cp_empresa = @i_empresa
             and  (cp_estado is null or cp_estado = 'E')
           
	       return 1
	     end   
	     
	end -- si es de tercero          

--        print 'Asiento origen %1!'+ cast(@w_asiento as varchar)

        select @w_asiento = @w_asiento + 1


           fetch c_asientos into   @w_area,  @w_cuenta, @w_empresa, @w_saldo, @w_saldo_me, @w_ente, @w_tip_reg

      end  -- c_asientos


       close c_asientos
       deallocate  c_asientos   


--      print '-- Inserta el comprobante definitivo por pagadora'
      
--      print 'busca detalles del comprobante'
    
      select  @w_detalles = max(ta_asiento),
              @w_totdeb   = sum(ta_debito),
              @w_totcred  = sum(ta_credito),
              @w_totdeb_me = sum(ta_debito_me),
              @w_totcred_me = sum(ta_credito_me)
      from cb_tasiento
      where ta_empresa     = @i_empresa
      and ta_fecha_tran    = @i_fecha_proceso
      and ta_comprobante   = @w_comprobante
      and ta_oficina_orig  = @w_oficina_pag      


--     print 'Comprobante definitivo'
--     print 'Fecha tran %1!'+ cast(@i_fecha_proceso as varchar)
--     print 'Comprobante %1!'+ cast(@w_comprobante as varchar)
--     print 'Detalles %1!'+ cast(@w_detalles as varchar)
--     print 'Tot debito %1!'+ cast(@w_totdeb as varchar)
--     print 'Tot credito %1!'+ cast(@w_totcred as varchar)
--     print 'Tot debito me %1!'+ cast(@w_totdeb_me as varchar)
--     print 'Oficina orig %1!'+ cast(@w_oficina_pag as varchar)
     

        if @w_totdeb <> @w_totcred
	begin
              begin
       /* Debitos y Creditos no Cuadran */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 607124
        end

          update cb_ctrl_proceso_comp_pag_decl  
          set cp_fecha_ejec =  @w_fecha_hoy,
          cp_estado = 'E'
          where cp_oficina = @w_oficina_pag
          and  cp_empresa = @i_empresa
          and  (cp_estado is null or cp_estado = 'E')

	  return 1
	end   

           
      EXECUTE @w_statussp = cob_conta..sp_comprobante
              @t_trn            = 6342,
              @i_operacion      = 'I',
              @i_empresa        = @i_empresa,
              @i_fecha_tran     = @i_fecha_proceso,
              @i_comprobante    = @w_comprobante,
              @i_detalles       = @w_detalles,
              @i_tot_debito     = @w_totdeb,
              @i_tot_credito    = @w_totcred,
              @i_tot_debito_me  = @w_totdeb_me,
              @i_tot_credito_me = @w_totcred_me,
              @i_oficina_orig   = @w_oficina_pag,
              @s_ofi            = 9000,
              @s_term           = 'vbatch',
              @s_user           = 'operador',
              @i_proceso        = 'R'

            
   	if @w_statussp <>0
	begin
--	  print 'Error en la creacion del Comprobante Definitivo Pagadora %1!, Comprobante %2!'+ cast(@w_oficina_pag as varchar) + cast(@w_comprobante as varchar)
        
         update cb_ctrl_proceso_comp_pag_decl  
         set cp_fecha_ejec =  @w_fecha_hoy,
         cp_estado = 'E'
         where cp_oficina = @w_oficina_pag
         and  cp_empresa = @i_empresa
         and  (cp_estado is null or cp_estado = 'E')
	  
	  return 1
	end
	
	-- busca el numero de comprobante
	
	select @w_comprobante_def =  max(co_comprobante)
	   from cob_conta..cb_comprobante
	   where co_fecha_tran = @i_fecha_proceso
	   and  co_comprobante > 0
	   and  co_oficina_orig =  @w_oficina_pag
	   and  co_empresa =  @i_empresa
	   and  co_mayorizado = 'N'
	   and  co_automatico =  @i_proceso
	   
   
        update cb_ctrl_proceso_comp_pag_decl  
        set cp_fecha_ejec =  @w_fecha_hoy,
            cp_estado = 'P',
            cp_fecha_comprob = @i_fecha_proceso,
            cp_comprobante = @w_comprobante_def
        where cp_oficina = @w_oficina_pag
        and  cp_empresa = @i_empresa
        and  (cp_estado is null or cp_estado = 'E')   
       
       
        fetch c_oficinas_pag  into  @w_oficina_pag

 end --while

  close c_oficinas_pag
  deallocate  c_oficinas_pag

   
 return 0      

--end   
go
