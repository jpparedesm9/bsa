/************************************************************************/
/*      Archivo:                distribu.sp                             */
/*      Stored procedure:       sp_distribucion                         */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               garantias                               */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     Abril-1997                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Realiza los cambios de estado para todas las garantias que no   */
/*      entran en el proceso de distribucion del consolidador, de igual */
/*      forma se inserta o actualiza un registro por garantia en la     */
/*      cu_distribucion                                                 */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      Mayo-1998       Laura Alvarado  Emision Inicial                 */ 
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_distribucion')
    drop proc sp_distribucion
go
create proc sp_distribucion(
   @s_date               datetime    = null,
   @s_term               descripcion = null,
   @s_user               login        = null,   
   @i_fecha              datetime    = null,
   @i_user               login       = null,
   @i_term               descripcion = null,
   @i_ofi                smallint    = null,
   @i_operacion          char(1)     = null,
   @i_estado_ini         char(1)     = null,
   @i_estado_fin         char(1)     = null,
   @i_abierta_cerrada    char(1)     = null,
   @i_admisible          char(1)     = null,
   @i_codigo_externo     varchar(64) = null,
   @i_valor_actual       money       = null,
   @i_valor_compartida   money       = null,
   @i_acum_ajuste        money       = null,
   @i_secuencial         int         = null,
   @i_descripcion        varchar(64) = null,
   @i_valor              money       = null
)
as
declare
   @w_today              datetime,
   @w_sp_name            varchar(32),  /* nombre stored proc          */
   @w_error              int,
   @w_descripcion        varchar(64),
   @w_secuencial         int,
   @w_valor_actual       money,
   @w_valor_fut          money,
   @w_valor_hip          money,
   @w_valor_com          money,
   @w_valor_con          money,
   @w_valor_ajfut        money,
   @w_valor_ajvig        money,
   @w_acum_ajuste        money,
   @w_op_clase           catalogo,
   @w_op_monto           money,
   @w_perfil             catalogo,
   @w_codvalor_ini       int,
   @w_codvalor_fin       int,
   @w_valor_cont         money,
   @w_valor_dist         money,
   @w_hora               varchar(8),
   @w_codvalor		 int,
   @w_monetaria		 char(1),
   @w_moneda		 tinyint,
   @w_filial             tinyint,
   @w_ajuste             money,
   @w_valor_respaldo     money,
   @w_clase_cartera      catalogo,
   @w_calificacion       char(1),
   @w_signo              smallint,
   @w_valor_contab       money,
   @w_codigo_externo_rev varchar(64),
   @w_secuencial_rev     int,
   @w_clase_custodia     char(1),
   @w_valor_futuros      money

   

select @w_sp_name = 'sp_distribucion'
select @i_fecha = isnull(@i_fecha,@s_date)  
select @w_today = convert(varchar(10),@s_date,101)
select @w_hora = convert(varchar(8),getdate(),108)



/* INICIALIZO LAS VARIABLES DE LOS VALORES POR CLASE DE CARTERA Y ESTADO DE LA GARANTIA */

select @w_monetaria = tc_monetaria,
       @w_moneda    = cu_moneda,
       @w_filial    = cu_filial,
       @w_clase_custodia    = cu_clase_custodia
from cu_custodia, cu_tipo_custodia
where cu_codigo_externo = @i_codigo_externo
and cu_tipo = tc_tipo


select
@w_valor_com = 0,
@w_valor_con = 0,
@w_valor_hip = 0,
@w_valor_fut = 0,
@w_valor_ajfut = 0,
@w_valor_ajvig = 0
 



   if @i_estado_ini = 'P'
      select @w_perfil = 'ING'
   else
      select @w_perfil = 'EST'

   select @w_valor_cont = isnull(@i_valor_actual,0)


   exec @w_secuencial = sp_gen_sec
        @i_garantia   = @i_codigo_externo  

   -- print "into cu_transaccion %1! %2! ",@w_secuencial ,@i_codigo_externo

   insert into cu_transaccion (
   tr_secuencial, tr_codigo_externo, tr_fecha_tran,
   tr_hora,tr_descripcion,tr_usuario,
   tr_terminal, tr_tran, tr_oficina_orig,
   tr_oficina_dest, tr_estado, tr_estado_gar)
   values (
   @w_secuencial, @i_codigo_externo, @i_fecha,
   @w_hora,@i_descripcion,@i_user,
   @i_term, @w_perfil, @i_ofi,
   @i_ofi, 'I', @i_estado_fin)

   if @@error != 0
      return 1901013


   if @i_estado_ini = 'P' 
   begin
      if @i_estado_fin = 'F'
      begin

         if @w_clase_custodia = 'I'
           select @w_codvalor = 0
       if @w_clase_custodia = 'O'
           select @w_codvalor = 31
         insert into cu_det_trn(
         dtr_secuencial, dtr_codigo_externo, dtr_codvalor, dtr_valor,dtr_clase_cartera,dtr_calificacion)
         values (@w_secuencial, @i_codigo_externo, @w_codvalor, @w_valor_cont,null,null)
         if @@error != 0
              return 1901012
        end


   end

if (@i_estado_fin = 'F' and @i_estado_ini <> 'P' and @i_estado_ini <> 'F' ) and @w_clase_custodia = 'I'
begin     


      if @i_estado_ini = 'V'
           select @w_codvalor = 4

      if @i_estado_ini = 'X'
         select @w_codvalor = 24


         select @w_signo = 1


          select @w_valor_futuros = cu_acum_ajuste
          from cob_custodia..cu_custodia
          where cu_codigo_externo = @i_codigo_externo

          select @w_valor_futuros = isnull(@w_valor_futuros,0)

  	  -- print "@w_valor_futuros %1!",@w_valor_futuros 

	  if @w_valor_futuros > 0
	  begin
              insert into cu_det_trn(
             dtr_secuencial, dtr_codigo_externo, dtr_codvalor, 
             dtr_valor,dtr_clase_cartera,dtr_calificacion)
             values (
             @w_secuencial, @i_codigo_externo,@w_codvalor,
             @w_valor_futuros ,null,null)
             if @@error != 0 
             begin
                select @w_error = 1901012
             End  
	  end

	--calcular diferencia para enviar a Futuros Creditos
        select @w_valor_contab = sum(dg_valor_resp_garantia)
        from   cu_distr_garantia
	where  dg_garantia = @i_codigo_externo

	select @w_valor_contab = isnull(@w_valor_contab, 0)

  	  -- print "@w_valor_contab  %1!",@w_valor_contab 

        if @w_valor_contab > 0
        begin

      declare cur_transacc cursor for
      select sum(dg_valor_resp_garantia)*@w_signo,dg_clase_cartera,dg_calificacion
      from   cu_distr_garantia
      where  dg_garantia = @i_codigo_externo
      group by dg_clase_cartera,dg_calificacion       
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

      if @w_valor_respaldo <> 0
      begin

	if @i_estado_fin <> "V" 
	begin
	select 	@w_clase_cartera = null,
		@w_calificacion  = null
	end

        insert into cu_det_trn(
        dtr_secuencial, dtr_codigo_externo, dtr_codvalor, dtr_valor,dtr_clase_cartera,dtr_calificacion)
        values (
        @w_secuencial, @i_codigo_externo, @w_codvalor, @w_valor_respaldo,@w_clase_cartera,@w_calificacion)

        if @@error != 0
           return 1901012
      end

      fetch cur_transacc into   
      @w_valor_respaldo,
      @w_clase_cartera,
      @w_calificacion

      end


      close cur_transacc
      deallocate cur_transacc
 end

      --emg mar-11-03 control de cambio fin


end   
   
return 0  
go