/************************************************************************/
/*   Stored procedure:     sp_maysifp                               */
/*   Base de datos:        cob_conta                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
 
use cob_conta
go
 
if exists (select 1 from sysobjects where name = 'sp_maysifp')
   drop proc sp_maysifp
go
 
create proc sp_maysifp (

      @s_ssn		  int = null,
      @s_date		  datetime = null,
      @s_user		  login = null,
      @s_term		  descripcion = null,
      @s_corr		  char(1) = null,
	@s_ssn_corr	        int = null,
      @s_ofi		  tinyint = null,
	@t_rty		  char(1) = null,
      @t_trn		  smallint = null,
	@t_debug	        char(1) = 'N',
	@t_file		  varchar(14) = null,
	@t_from		  varchar(30) = null,
	@i_empresa 	        tinyint = null,
      @i_fecha_tran 	  datetime = null,
	@i_nro_procesos	  int = null,		-- Particiones
      @i_opcion	        tinyint = 1,		-- 0 Genera Rangos, 1 Ejecuta proceso
	@i_proceso 	        int = null
)
as
declare @w_return         int,
	@w_sp_name        varchar(32),
	@w_cuenta 	  cuenta,
	@w_cuenta_ant 	  cuenta,
	@w_oficina 	  smallint,
	@w_area		  smallint,
    @w_fecha_tran 	  datetime,
    @w_fecha_min 	  datetime,
    @w_credito 	  money,
    @w_debito  	  money,
	@w_credito_me 	  money,
	@w_debito_me	  money,
	@w_i		  int,
	@w_error	  int,
	@w_cuenta_aux	  cuenta,
	-- PARALELISMO
    @w_comp_ini        numeric(10, 0),
    @w_comp_fin        numeric(10, 0),
    @w_comp_int_ini    int,
    @w_comp_int_fin    int,
    @w_total_comp      int,
    @w_contador        int,
    @w_proceso         int,
    @w_msg_error       varchar(150),
    @w_sqlstatus       int,
    @w_COMMIT	  int,
    @w_quiebre	  bit,
    @w_registros	  int,
    @w_maximo    	  int,
    @w_max_ant	  int,
    @_contador	  int,
    @w_filas		  int,
    @w_secuencial	  int,
    @w_fecha_tmp       datetime,
    @w_trancount       int

select @w_sp_name = 'sp_maysifp',
       @w_i = 1,
       @w_COMMIT = 3

select @w_fecha_min = min(co_fecha_fin)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_fecha_ini <= @i_fecha_tran
and   co_estado in ('A','V')
if  @w_fecha_min = null
begin	/* 'PERIODO O CORTE NO VIGENTE O CERRADO' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 603023
   return 1
end

select co_fecha_ini
into #fecha_tmp
from cob_conta..cb_corte
where co_empresa = 1
and   co_fecha_ini <= @i_fecha_tran
and   co_estado in ('A','V')
if  @@rowcount = 0
begin	/* 'PERIODO O CORTE NO VIGENTE O CERRADO' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 603023
   return 1
end

-- GENERA PARTICIONES
if @i_opcion = 0
begin

   truncate table cb_tmp_mayfp


   delete cb_procesos_paralelo
   where pp_programa = 'sp_maysifp'
   if @@error <> 0
   begin
      select @w_msg_error = 'Error en inicializacion de tabla de procesos paralelos'
      goto ERROR_1
   end


   insert into cb_tmp_mayfp 
   select as_empresa, as_cuenta, as_fecha_tran, as_oficina_dest, as_area_dest, 
          sum(as_debito), sum(as_credito), sum(as_debito_me), sum(as_credito_me),
          'N'
   from  cb_comprobante, cb_asiento
   where co_empresa       = @i_empresa
     and co_fecha_tran  in (select co_fecha_ini from #fecha_tmp)    --@i_fecha_tran
     and co_comprobante  >= 0
     and co_oficina_orig >= 0
     and co_autorizado    = 'S'
     and co_automatico   in (6057, 6078)
     and co_mayorizado    = 'N'
     and as_empresa       = co_empresa
     and as_fecha_tran    = co_fecha_tran
     and as_comprobante   = co_comprobante
     and as_oficina_orig  = co_oficina_orig
     and as_asiento      >= 0
     and as_mayorizado    = 'N'
   group by as_empresa, as_cuenta, as_fecha_tran, as_oficina_dest, as_area_dest
   select @w_filas = @@rowcount,
          @w_error = @@error

print 'error insert 1'

   if @w_filas = 0
      return 0

   if @w_error <> 0
   begin
      select @w_msg_error = 'Error en generacion de tabla de trabajo para comprobantes por mayorizar'
      goto ERROR_1
   end	        


print 'sale de begin tran'

   select @w_comp_ini   = 0,
          @w_comp_fin   = 0,
          @w_total_comp = 0,
          @w_contador   = 0,
          @w_proceso    = 0,
	  @w_quiebre    = 0,
	  @w_max_ant    = 0



   select @w_total_comp = count(secuencial)
   from	  cb_tmp_mayfp

   select @w_total_comp = (@w_total_comp / @i_nro_procesos) + 1 
      
   if @w_total_comp = 0
      select @w_total_comp = 1

print 'TOTAL REGISTROS %1!'+cast(@w_total_comp as varchar)

   declare cur_comp cursor for 
   select co_cuenta, min(secuencial), count(*), max(secuencial)
   from   cb_tmp_mayfp
   where co_empresa = @i_empresa
   group by co_cuenta
   
   open cur_comp
   
   fetch cur_comp
   into  @w_cuenta,
         @w_comp_int_fin,
         @w_registros,
	 @w_maximo
         
   if @@fetch_status = 1
   begin
      close cur_comp
      deallocate cur_comp
      select @w_msg_error = 'Error en Cursor cur_comp'
      goto ERROR_1
   end

   while @@fetch_status = 0
   begin

      --
      if (@w_contador + @w_registros) >  @w_total_comp
      begin
         select @w_proceso = @w_proceso + 1
         print 'INSERT %1! %2! %3!--%4!'+cast(@w_registros as varchar)+cast(@w_comp_int_ini as varchar)+cast(@w_max_ant as varchar) +cast(@w_proceso  as varchar)
         insert into cb_procesos_paralelo
	 (pp_programa, pp_proceso, pp_estado, pp_inicio, pp_comp_ini, pp_comp_fin, pp_intento)
         values
	 ('sp_mayfp', @w_proceso, 'C', getdate(), @w_comp_int_ini, @w_max_ant, 0)
	 if @@error <> 0
         begin
            select @w_msg_error = 'Error generacion de particion para proceso paralelo'
	    close cur_comp
            deallocate cur_comp
            goto ERROR_1
         end

         select @w_comp_int_ini = @w_comp_int_fin
         select @w_contador = 0,
		@w_quiebre = 1
      end
      else
      begin
         if @w_quiebre = 0
            select @w_comp_int_ini = @w_comp_int_fin,
		   @w_quiebre = 1

         select @w_contador = @w_contador + @w_registros
      end

      select @w_max_ant = @w_maximo

      fetch cur_comp
      into  @w_cuenta,
            @w_comp_int_fin,
            @w_registros,
     	    @w_maximo

   end

print 'INSERT %1! %2!'+cast(@w_comp_int_ini as varchar)+cast(@w_maximo  as varchar)
   select @w_proceso = @w_proceso + 1
   insert into cb_procesos_paralelo
   (pp_programa, pp_proceso, pp_estado, pp_inicio, pp_comp_ini, pp_comp_fin, pp_intento)
   values
   ('sp_maysi', @w_proceso, 'C', getdate(), @w_comp_int_ini, @w_maximo, 0)
   if @@error <> 0
   begin
      select @w_msg_error = 'Error generacion de particion para proceso paralelo. Final.'
      goto ERROR_1
   end

   close cur_comp
   deallocate cur_comp

   select @w_registros = 0

   select @w_registros = count(*)
   from cb_procesos_paralelo
   where pp_programa = @w_sp_name
   if @@rowcount = 0
      select @w_registros = 0

   if @w_registros > @i_nro_procesos
   begin
      select @w_msg_error = 'ERROR EN GENERACION DE TABLAS CON SEC. PARA HILOS'
      goto ERROR_1
   end

--1   COMMIT TRAN
print 'sale de commit'   

end  -- GENERA PARTICIONES


-- PROCESA
if @i_opcion = 1
begin

   select *
   into #_cuentas_tmp
   from cb_cuentas_tmp
   where 1=2

   create NONCLUSTERED INDEX cuentas_tmp_Key on #_cuentas_tmp (tmp_cuenta)

   if @i_proceso is not null
      update cb_procesos_paralelo
      set   pp_estado = 'P',
			pp_inicio = getdate(),
			pp_hostprocess = (select	hostprocess 
							  from		master..sysprocesses
							  where	spid = @@spid),
				 pp_spid = @@spid,
				 pp_intento = pp_intento + 1
      where pp_programa = 'sp_mayfp'
      and   pp_proceso = @i_proceso

   select @w_comp_ini = pp_comp_ini, 
          @w_comp_fin = pp_comp_fin
   from   cb_procesos_paralelo
   where  pp_programa = 'sp_mayfp'
   and    pp_proceso  = @i_proceso

   select co_cuenta, co_oficina_dest, co_area_dest, co_fecha_tran,
   	  co_credito, co_debito, co_credito_me, co_debito_me,
   	  secuencial
   into #_mayriza
   from   cb_tmp_mayfp
   where secuencial > 0 --between @w_comp_ini and @w_comp_fin
     and co_empresa = @i_empresa
     and co_estado  = 'N'  

   declare mayoriza cursor for
   select *
   from #_mayriza
   for READ ONLY

   open mayoriza
   fetch mayoriza into	@w_cuenta,@w_oficina,@w_area,@w_fecha_tran,
   			@w_credito,@w_debito,@w_credito_me,@w_debito_me,
   			@w_secuencial

--1 begin tran
print 'sale de begin tran1'
select @w_contador = 0,
       @w_cuenta_ant = '',
       @_contador = 0

   while (@@fetch_status = 0)
   begin

      if (@w_contador % @w_COMMIT) = 0
--   	begin
--1         begin tran
print 'sale de begin tran1'
--	 print '****************************'
--	 print 'BEGIN TRAN %1! --- %2!',@i_proceso,@w_contador
--	end

BEGIN TRAN --SVA

/*
      /**********************************/
      save tran CUENTA
      /**********************************/
*/      

	select @w_cuenta_aux = @w_cuenta

print '@w_cuenta1 ' + @w_cuenta 

if @w_cuenta <> @w_cuenta_ant
begin
         
   	delete #_cuentas_tmp
   	if @@error <> 0
   	begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
--1                rollback tran CUENTA
   		select @w_error = 603024
   		goto ERROR
   	end

	select @w_i = 1

	insert #_cuentas_tmp values (@w_i, @w_cuenta, 'U', 1)
	if @@error <> 0
	begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
--1	        rollback tran CUENTA
		select @w_error = 603024
		goto ERROR
	end

	while 1=1
	begin
		select @w_i = @w_i + 1

		select @w_cuenta = cu_cuenta_padre
		from   cb_cuenta
		where  cu_empresa = @i_empresa
		and    cu_cuenta  = @w_cuenta

		if @@rowcount = 0
		begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
--1                        rollback tran CUENTA
			select @w_error = 603024
			print 'Error: cuenta %1! no existe'+ @w_cuenta
			goto ERROR
		end


print '@w_cuenta3 ' + @w_cuenta 
		if @w_cuenta = '' or @w_cuenta is null
		break

		insert #_cuentas_tmp values (@w_i, @w_cuenta,'U', 0)
		if @@error <> 0
		begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
--1			rollback tran CUENTA
			select @w_error = 603024
			goto ERROR
		end
	end
print 'pasa 4'
print '@w_cuenta4 ' + @w_cuenta 
        select @w_cuenta_ant = @w_cuenta_aux
--print 'Cta %1! %2! %3!',@w_cuenta_aux,@w_oficina,@w_area
end

print '@w_cuenta ' + @w_cuenta
print '@w_oficina ' + cast(@w_oficina as varchar)
       
	execute @w_return = sp_mayorizafp
	@t_trn        = 6301,
	@i_empresa    = @i_empresa,
	@i_fecha_tran = @w_fecha_tran,
	@i_cuenta     = @w_cuenta_aux,
	@i_oficina    = @w_oficina,
	@i_area       = @w_area,
	@i_credito    = @w_credito,
	@i_debito     = @w_debito,
	@i_credito_me = @w_credito_me,
	@i_debito_me  = @w_debito_me,
	@p_operacion  = 1
--	@i_proceso = @i_proceso

	if @w_return <> 0
	begin
--1		rollback tran CUENTA
		select @w_error = 605036
		goto ERROR
	end
	

	update cb_asiento set as_mayorizado = 'S'
        from cb_comprobante
	where co_comprobante > 0
        and   as_empresa      = @i_empresa
	and   as_cuenta	      = @w_cuenta_aux
	and   as_oficina_dest = @w_oficina
	and   as_area_dest    = @w_area
	and   as_fecha_tran   = @w_fecha_tran
        and   as_mayorizado   = 'N'
        and   co_empresa       = as_empresa
        and   co_fecha_tran   = as_fecha_tran
        and   co_comprobante  = as_comprobante
        and   co_oficina_orig = as_oficina_orig
        and   co_autorizado   = 'S'
        and   co_automatico   in (6057, 6078)
	if @@error <> 0
	begin	-- 'ERROR EN LA ACTUALIZACION DE ASIENTO' 
--1		rollback tran CUENTA
		select @w_error = 605088
		goto ERROR
	end
	
	update cb_tmp_mayfp
	set co_estado = 'P'
	where secuencial = @w_secuencial
	if @@rowcount <> 1 or @@error <> 0
	begin	-- 'ERROR EN LA ACTUALIZACION DE TABLA TEMPORAL' 
--1		rollback tran CUENTA
		select @w_error = 603075
		goto ERROR
	end

	if (@@fetch_status = -2)
	begin	/* 'ERROR EN LA MAYORIZACION DEL COMPROBANTE' */
--1		rollback tran CUENTA
		select @w_error = 603021
		goto ERROR
	end

	goto SIGUIENTE
ERROR:
	print 'Error Fecha: %1!, Cuenta: %2!, Oficina: %3! --**-- %4!'+ cast(@w_fecha_tran as varchar)+ @w_cuenta + cast(@w_oficina as varchar)+ cast(@w_error as varchar)
       rollback tran -- SVA
	goto SIGUIENTE

SIGUIENTE:
 
	select @w_contador = @w_contador + 1,
               @_contador = @_contador + 1

if @_contador % 500 = 0
begin
	 print '****************************'
	 print 'PROCESO %1! -- %2!'+cast(@i_proceso as varchar)+cast(@_contador as varchar)
end


	if (@w_contador % @w_COMMIT) = 0
--	begin
--1           commit tran
print 'sale de commit2'
--	 print '****************************'
--	 print 'COMMIT TRAN %1! --- %2!',@i_proceso,@w_contador
--	end


COMMIT TRAN  --SVA

	fetch mayoriza into	@w_cuenta,@w_oficina,@w_area,@w_fecha_tran,
				@w_credito,@w_debito,@w_credito_me,@w_debito_me,
				@w_secuencial
  end

select @w_trancount = @@trancount
print '@w_trancount '+cast(@w_trancount as varchar)
if @w_trancount > 0
begin
--1    while @@trancount > 0
--1    begin
--1        commit tran
        print 'sale de commit3'
--1    end
end

   close mayoriza
   deallocate mayoriza

while @@trancount > 0  COMMIT TRAN  --SVA

   if @i_proceso is not null
      update cb_procesos_paralelo
      set    pp_estado = 'T',
				 pp_fin = getdate()
      where pp_programa = 'sp_mayfp'
      and   pp_proceso = @i_proceso

end -- PROCESA



-- ACTUALIZAR COMPROBANTES
if @i_opcion = 2
begin

/***
   -- Tabla Temporal para Comprobantes 
   create table #comprobantes
   (as_empresa		int,
    as_fecha_tran	datetime,
    as_comprobante	int,
    as_oficina_orig	smallint,
    as_asientos		int)

create unique index indice on #comprobantes
(as_empresa, as_fecha_tran, as_comprobante, as_oficina_orig)
***/


   while 1=1
   begin

   set rowcount 1
   select @w_fecha_tmp = co_fecha_ini
   from #fecha_tmp
   order by co_fecha_ini
 
   if @@rowcount = 0
      break 
   
   delete #fecha_tmp
   where co_fecha_ini = @w_fecha_tmp
   
   set rowcount 0
   print '****************---------------------------'
   print 'FECHA %1!'+cast(@w_fecha_tmp as varchar)

   select as_empresa, as_fecha_tran, as_comprobante, as_oficina_orig, 
          'as_asientos' = count(*)
   into #comprobantes
   from cb_asiento
   where as_empresa = @i_empresa
     and as_fecha_tran = @w_fecha_tmp
     and as_comprobante >= 0
     and as_asiento >= 0
     and as_oficina_orig >= 0
     and as_mayorizado = 'S'
   group by as_empresa, as_fecha_tran, as_comprobante, as_oficina_orig


      update cb_comprobante
      set co_mayorizado = 'S'
      from #comprobantes
      where co_empresa = as_empresa
        and co_fecha_tran = as_fecha_tran
        and co_comprobante = as_comprobante
        and co_oficina_orig = as_oficina_orig
        and co_detalles = as_asientos
        and co_autorizado = 'S'
        and co_automatico in (6057, 6078)
        and co_mayorizado = 'N'
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
    	 @i_msg   = 'ERROR EN ACTUALIZACION DE COMPROBANTES',
         @i_num   = 605088
         return 605088
      end

      drop table #comprobantes
   end

end

      
return 0

ERROR_1:

if @i_proceso is not null
   update cb_procesos_paralelo
   set    pp_estado = 'E',
			 pp_fin = getdate()
   where  pp_programa = 'sp_maysi' 
   and    pp_proceso  = @i_proceso

print '%1!'+ @w_msg_error
--1 while @@trancount > 0 ROLLBACK TRAN

return 1

