/************************************************************************/
/*	Archivo:		cambioofi.sp				*/
/*	Stored procedure:	sp_cambioofi 				*/
/*	Base de datos:		cob_custodia				*/
/*	Producto: 		Garantias        			*/
/*	Disenado por:  		Milena Gonzalez 			*/
/*	Fecha de escritura:	Dic. 2003				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/  
/*				PROPOSITO				*/
/*	Genera los tramsacciones contables de Garantias asociadas a ope */
/*	que tienen cambio de calificacion.                              */
/************************************************************************/  
/*                             MODIFICACIONES               		*/
/************************************************************************/  

use cob_custodia
go

if exists (select 1 from sysobjects where name = "sp_cambioofi")
   drop proc sp_cambioofi
go
create proc sp_cambioofi
   @s_user		login    = null,
   @s_date              datetime = null,
   @s_ofi               smallint   = null,
   @s_term              descripcion = null,  
   @i_fecha             datetime      = null
            
as 
declare 
   @w_error          	int,
   @w_return         	int,
   @w_sp_name        	descripcion,
   @w_money          	money,
   @w_cliente           int,
   @w_garantia          varchar(64),
   @w_oficina_orig      smallint,
   @w_oficina_dest      smallint,
   @w_ult_oficina       smallint,
   @w_secuencial        int,
   @w_max_secuencial    int,
   @w_max_secuencial1   int,
   @w_acumulado         money,
   @w_valor_garantia    money,
   @w_operacion         int

select @w_sp_name = 'cambioofi.sp'

        declare cur_oficina cursor for
        select  trc_cliente,
                trc_oficina_origen,
                trc_oficina_destino,
                trc_operacion
        from cob_cartera..ca_traslados_cartera
        where datediff(mm,trc_fecha_proceso,@i_fecha) < 1
        --and ((trc_estado = 'P' and trc_garantias = 'I') or (trc_estado = 'R' and trc_garantias <> 'R')) validado epb no existe estado R
        and   trc_estado ='P' and trc_garantias <> 'P'
        and   trc_cliente > 0
        order by trc_cliente
        for read only

        open cur_oficina

        fetch cur_oficina into 
	@w_cliente,
        @w_oficina_orig,
        @w_oficina_dest,
        @w_operacion

	while @@fetch_status = 0
             begin
	      	if @@fetch_status = -1
		begin
  		  close cur_oficina
		  deallocate cur_oficina
                            rollback
		  return 1
		end

	--cursor de garantias por cliente

        if exists (select 1 from cu_transaccion,cu_cliente_garantia,cob_credito..cr_gar_propuesta,
                  cob_cartera..ca_operacion where tr_estado = 'I'
                  and tr_codigo_externo = cg_codigo_externo and cg_ente = @w_cliente
                  and gp_garantia = cg_codigo_externo
                  and gp_tramite = op_tramite
                  and op_operacion = @w_operacion)	        
        begin
              print 'Existen Transacciones Pendientes por Contabilizar'

              fetch cur_oficina into 
		@w_cliente,
        	@w_oficina_orig,
	        @w_oficina_dest,
                @w_operacion
        end

        declare cur_garantia cursor for
        select  cg_codigo_externo
        from cob_custodia..cu_cliente_garantia,cob_custodia..cu_custodia,cob_cartera..ca_operacion,cob_credito..cr_gar_propuesta
        where cg_ente = @w_cliente
        and cu_codigo_externo = cg_codigo_externo
        and cu_oficina_contabiliza = @w_oficina_orig
        and   cg_tipo_garante in ('J','C')
        and gp_garantia = cg_codigo_externo
        and gp_tramite = op_tramite
        and op_operacion = @w_operacion
        --order by cg_codigo_externo
        for read only

        open cur_garantia

        fetch cur_garantia into 
	@w_garantia

	while @@fetch_status = 0
             begin
	      	if @@fetch_status = -1
		begin
  		  close cur_garantia
		  deallocate cur_garantia
                            rollback
		  return 1
		end

           if exists (select 1 from cu_transaccion,cob_custodia..cu_cliente_garantia,
                      cob_credito..cr_gar_propuesta,cob_cartera..ca_operacion
                     where tr_codigo_externo = @w_garantia
                     and tr_estado = 'I' and tr_codigo_externo = cg_codigo_externo and cg_ente = @w_cliente
                     and gp_garantia = cg_codigo_externo
                     and gp_tramite = op_tramite
                     and op_operacion = @w_operacion)	        
           begin
                print 'La Garantia %1! Tiene Transacciones Pendientes por Contabilizar' + @w_garantia

		fetch cur_garantia into 
		@w_garantia

                continue
           end

           select @w_max_secuencial = max(tr_secuencial),@w_ult_oficina = tr_oficina_dest  
           from   cu_transaccion
           where  tr_codigo_externo = @w_garantia
           and    tr_estado  ='C'
           group by tr_oficina_dest

           if @w_ult_oficina = @w_oficina_dest  and @w_ult_oficina is not null
           begin
		fetch cur_garantia into 
		@w_garantia

                continue
           end 
         
           --Insertar transaccion anterior contabilizada con oficina anterior
	   exec @w_secuencial = sp_gen_sec
	        @i_garantia = @w_garantia
       
          if exists (select 1 from cu_transaccion where tr_codigo_externo = @w_garantia
                     and tr_estado = 'C')
          begin

	  Print 'Ejecutando Traslado Contable Garantia:' + @w_garantia


          insert into cu_transaccion 
          select @w_secuencial,tr_codigo_externo,@i_fecha,
                 tr_hora,tr_descripcion,tr_usuario,tr_terminal,
                 tr_tran,tr_oficina_orig,tr_oficina_dest,'I',tr_estado_gar
          from   cu_transaccion
          where tr_codigo_externo = @w_garantia
          and   tr_secuencial = @w_max_secuencial
         
	  if @@rowcount = 0 
	  begin
	     select @w_error = 1901013
             goto ERROR
	  End

          insert into cu_det_trn
          select 
          @w_secuencial,dtr_codigo_externo,dtr_codvalor,dtr_valor * -1,dtr_clase_cartera,dtr_calificacion
          from cu_det_trn
          where dtr_codigo_externo = @w_garantia
          and   dtr_secuencial = @w_max_secuencial
        
          if @@rowcount = 0 
	  begin

	      select @w_error = 1901013
              goto ERROR
	  end
          end

          --Insertar transaccion con oficina nueva

	   exec @w_secuencial = sp_gen_sec
	        @i_garantia = @w_garantia
       

          if exists (select 1 from cu_transaccion where tr_codigo_externo = @w_garantia
                     and tr_estado = 'C')
          begin

          insert into cu_transaccion 
          select @w_secuencial,tr_codigo_externo,@i_fecha,
                 tr_hora,tr_descripcion,tr_usuario,tr_terminal,
                 tr_tran,@w_oficina_dest,@w_oficina_dest,'I',tr_estado_gar
          from   cu_transaccion
          where  tr_codigo_externo = @w_garantia
          and    tr_estado = 'C'
          and   tr_secuencial = @w_max_secuencial

	  if @@rowcount = 0 
	  begin
	     select @w_error = 1901013
             goto ERROR
	  end

          insert into cu_det_trn
          select 
          @w_secuencial,dtr_codigo_externo,dtr_codvalor,dtr_valor,dtr_clase_cartera,dtr_calificacion
          from cu_det_trn
          where dtr_codigo_externo = @w_garantia
          and   dtr_secuencial = @w_max_secuencial
        
          if @@rowcount = 0 
	  begin
	      select @w_error = 1901013
              goto ERROR
	  end
          end


          select @w_acumulado = sum(dtr_valor)
          from   cu_det_trn
          where  dtr_codigo_externo = @w_garantia
          and    dtr_secuencial = @w_max_secuencial

          select @w_valor_garantia = cu_valor_inicial
          from   cob_custodia..cu_custodia
          where  cu_codigo_externo = @w_garantia
         
	  --procesar para parte de la garantia con otro secuencial

          if @w_acumulado < @w_valor_garantia          
          begin

           select @w_max_secuencial1 = max(tr_secuencial-1),@w_ult_oficina = tr_oficina_dest  
           from   cu_transaccion
           where  tr_codigo_externo = @w_garantia
           and    tr_estado  ='C'
           group by tr_oficina_dest


           if @w_ult_oficina = @w_oficina_dest  and @w_ult_oficina is not null
           begin
		fetch cur_garantia into 
		@w_garantia

                continue
           end 
         
           --Insertar transaccion anterior contabilizada con oficina anterior
	   exec @w_secuencial = sp_gen_sec
	        @i_garantia = @w_garantia
       
          if exists (select 1 from cu_transaccion where tr_codigo_externo = @w_garantia
                     and tr_estado = 'C')
          begin

	  Print 'Ejecutando Traslado Contable Garantia:' + @w_garantia


          insert into cu_transaccion 
          select @w_secuencial,tr_codigo_externo,@i_fecha,
                 tr_hora,tr_descripcion,tr_usuario,tr_terminal,
                 tr_tran,tr_oficina_orig,tr_oficina_dest,'I',tr_estado_gar
          from   cu_transaccion
          where tr_codigo_externo = @w_garantia
          and   tr_secuencial = @w_max_secuencial1
         
	  if @@rowcount = 0 
	  begin
	     select @w_error = 1901013
             goto ERROR
	  End

          insert into cu_det_trn
          select 
          @w_secuencial,dtr_codigo_externo,dtr_codvalor,dtr_valor * -1,dtr_clase_cartera,dtr_calificacion
          from cu_det_trn
          where dtr_codigo_externo = @w_garantia
          and   dtr_secuencial = @w_max_secuencial1
        
          if @@rowcount = 0 
	  begin

	      select @w_error = 1901013
              goto ERROR
	  end
          end


          --Insertar transaccion con oficina nueva

	   exec @w_secuencial = sp_gen_sec
	        @i_garantia = @w_garantia
       

          if exists (select 1 from cu_transaccion where tr_codigo_externo = @w_garantia
                     and tr_estado = 'C')
          begin

          insert into cu_transaccion 
          select @w_secuencial,tr_codigo_externo,@i_fecha,
                 tr_hora,tr_descripcion,tr_usuario,tr_terminal,
                 tr_tran,@w_oficina_dest,@w_oficina_dest,'I',tr_estado_gar
          from   cu_transaccion
          where  tr_codigo_externo = @w_garantia
          and    tr_estado = 'C'
          and   tr_secuencial = @w_max_secuencial1

         
	  if @@rowcount = 0 
	  begin

	     select @w_error = 1901013
             goto ERROR
	  end


          insert into cu_det_trn
          select 
          @w_secuencial,dtr_codigo_externo,dtr_codvalor,dtr_valor,dtr_clase_cartera,dtr_calificacion
          from cu_det_trn
          where dtr_codigo_externo = @w_garantia
          and   dtr_secuencial = @w_max_secuencial1
        
        
          if @@rowcount = 0 
	  begin

	      select @w_error = 1901013
              goto ERROR
	  end
          end


          end
	  --fin procesar para parte de la garantia con otro secuencial


        update cu_custodia
        set    cu_oficina_contabiliza = @w_oficina_dest
        where  cu_oficina_contabiliza = @w_oficina_orig
        and    cu_codigo_externo = @w_garantia
        if @@error <> 0 
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
        end


	update cob_cartera..ca_traslados_cartera
	set trc_garantias = 'P' 
        where (trc_estado = 'P' and trc_garantias = 'I') 
        and trc_operacion = @w_operacion
        and trc_cliente = @w_cliente
        if @@error <> 0 
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
        end


	/*update cob_cartera..ca_traslados_cartera
	set trc_garantias = 'R' where (trc_estado = 'R' and trc_garantias <> 'R')
        and trc_operacion = @w_operacion
        and trc_cliente = @w_cliente
        if @@error <> 0 
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
        end*/
   

	fetch cur_garantia into   
        @w_garantia

 	end   	
     
        close cur_garantia
   	deallocate cur_garantia


        --fin cursor de garantias por cliente	


	fetch cur_oficina into   
	@w_cliente,
        @w_oficina_orig,
        @w_oficina_dest,
        @w_operacion
 	end   	
     
        close cur_oficina
   	deallocate cur_oficina


return 0

ERROR: 
    return 1
go