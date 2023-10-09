/************************************************************************/
/*	Archivo: 	        cestajte.sp                             */ 
/*	Stored procedure:       sp_cambio_ajuste                        */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           					*/
/*	Fecha de escritura:     Abril-1997  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa genera las transacciones contables al momento que */
/*      se realizan cambios a los ajustes por inflacion.                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Mayo-1998       Laura Alvarado	Emision Inicial         	*/	
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cambio_ajuste')
    drop proc sp_cambio_ajuste
go
create proc sp_cambio_ajuste (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @i_fecha              datetime = null,
   @i_usuario            login    = null,
   @i_term               descripcion = null,
   @i_tran               catalogo  = null,
   @i_oficina_contabiliza   int  = null,
   @i_codvalor_ini          int  = null,  
   @i_codvalor_fin          int  = null,
   @i_acum_ajuste           money = null,
   @i_codigo_externo        varchar(64) = null,
   @i_descripcion           varchar(64) = null
)
as

declare
   @w_today              datetime,
   @w_retorno            int,          /* valor que retorna           */
   @w_sp_name            varchar(32),  /* nombre stored proc          */
   @w_existe             tinyint,      /* existe el registro          */
   @w_perfil             catalogo,      /* perfil del cambio de estado */
   @w_contabiliza        char(1),      /* indica si se contabiliza    */
   @w_tran               catalogo,
   @w_error		 int,
   @w_var1		 varchar(60),
   @w_secuencial         int,
   @w_codvalor_ini       int,
   @w_codvalor_fin       int,
   @w_hora               varchar(8),
   @w_valor_respaldo     money,
   @w_clase_cartera      catalogo,
   @w_calificacion       char(1),
   @w_valor_futuros      money

   
select @w_sp_name = 'sp_cambio_ajuste'
select @w_today = convert(varchar(10),@s_date,101)
select @w_hora = convert(varchar(8),getdate(),108)

/***********************************************************/

   exec @w_secuencial = sp_gen_sec
   select @w_codvalor_ini = @i_codvalor_ini * 100 
   select @w_codvalor_fin = @i_codvalor_fin * 100 
   select @i_acum_ajuste = isnull(@i_acum_ajuste,0)
   if @i_acum_ajuste != 0
   begin
      insert into cu_transaccion (
      tr_secuencial, tr_codigo_externo, tr_fecha_tran,
      tr_hora,tr_descripcion,tr_usuario,
      tr_terminal, tr_tran, tr_oficina_orig,
      tr_oficina_dest, tr_estado)
      values (
      @w_secuencial, @i_codigo_externo, @i_fecha,
      @w_hora,@i_descripcion,@i_usuario,
      @i_term, @i_tran, @i_oficina_contabiliza,
      @i_oficina_contabiliza, 'I')
      if @@rowcount = 0 
      begin
         select @w_error = 1901013
         goto ERROR
      End

      --emg mar-11-03 control cambio

print 'cestajte'
      exec sp_distr @i_garantia = @i_codigo_externo

     declare cur_transacc cursor for
     select sum(dg_valor_resp_garantia),dg_clase_cartera,dg_calificacion
     from   cu_distr_garantia
     where  dg_garantia = @i_codigo_externo
     group by dg_clase_cartera,dg_clase_cartera,dg_calificacion       
     for read only

     open cur_transacc
       fetch cur_transacc into 
	@w_valor_respaldo,
	@w_clase_cartera,
        @w_calificacion
	while @@fetch_status = 0
             begin
	      	if @@fetch_status = -1
		begin
  		  close cur_transacc
		  deallocate cur_transacc
                            rollback
		  return 1
		end        


      insert into cu_det_trn(
      dtr_secuencial, dtr_codigo_externo, dtr_codvalor, 
      dtr_valor,dtr_clase_cartera, dtr_calificacion)
      values (
      @w_secuencial, @i_codigo_externo, @w_codvalor_ini,
      @i_acum_ajuste * -1,@w_clase_cartera,@w_calificacion)
      if @@rowcount = 0 
      begin
         select @w_error = 1901012
         goto ERROR
      End

     fetch cur_transacc into   
     @w_valor_respaldo,
     @w_clase_cartera,
     @w_calificacion

     end
   	
     close cur_transacc
     deallocate cur_transacc



      --emg mar-11-03 control cambio fin



      --emg mar-11-03 
      exec sp_distr @i_garantia = @i_codigo_externo

      declare cur_transacc cursor for
      select sum(dg_valor_resp_garantia),dg_clase_cartera,dg_calificacion
      from   cu_distr_garantia
      where  dg_garantia = @i_codigo_externo
      group by dg_clase_cartera,dg_clase_cartera,dg_calificacion       
      for read only

      open cur_transacc
        fetch cur_transacc into 
 	@w_valor_respaldo,
	@w_clase_cartera,
        @w_calificacion
	while @@fetch_status = 0
             begin
	      	if @@fetch_status = -1
		begin
  		  close cur_transacc
		  deallocate cur_transacc
                            rollback
		  return 1
		end   

	      insert into cu_det_trn(
	      dtr_secuencial, dtr_codigo_externo, dtr_codvalor, 
	      dtr_valor,dtr_clase_cartera,dtr_calificacion)
      	      values (
	      @w_secuencial, @i_codigo_externo, @w_codvalor_fin,
	      @i_acum_ajuste,@w_clase_cartera,@w_calificacion)
	      if @@rowcount = 0 
	      begin
        	 select @w_error = 1901012
	         goto ERROR
      	      End  

        fetch cur_transacc into   
	@w_valor_respaldo,
        @w_clase_cartera,
        @w_calificacion

   	end


	close cur_transacc
	deallocate cur_transacc       


      --emg mar-11-03
   end 
   return 0
   ERROR:
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = @w_error
      return 1 
go