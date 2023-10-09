/************************************************************************/
/*   Stored procedure:     sp_libromay_cons                               */
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
 
if exists (select 1 from sysobjects where name = 'sp_libromay_cons')
   drop proc sp_libromay_cons
go
 
 

create proc sp_libromay_cons (

       @t_trn       smallint = null,
       @t_debug     char(1)  = 'N',

       @t_file      varchar(14) = null,
       @i_empresa   tinyint 	= null,
       @i_fecha	    datetime	= null,
       @i_oficina   smallint	= null,
       @i_nivel_cuenta tinyint  = null,
       @i_nivel        tinyint  = null,
       @i_modo         tinyint  = null,
       @i_cuenta       varchar(15) = null   
)
as 
declare @w_cuenta   varchar(15), 

        @w_nombre   varchar(255), 

        @w_saldo    float,  

        @w_debito   float, 

        @w_credito  float,
        @w_sp_name  varchar(32), /* Nombre del Stored Procedure*/
        @w_today    datetime,       /* Fecha del dia */ 
        @w_fecha_ant datetime,       /* Fin de mes anterior */
        @w_estado   char(1),

        @w_corte    int,

        @w_periodo  int,
        @w_estado1   char(1),

        @w_corte1    int,

        @w_periodo1  int


select @w_today = getdate()

select @w_sp_name = 'sp_libromay_cons'

delete from cob_conta..cb_libromay
delete from cob_conta..cb_libromay_ant

select @w_fecha_ant = dateadd(day, -datepart(day,@i_fecha), @i_fecha)


if (@t_trn <> 6135)

begin

	/* 'Tipo de transaccion no corresponde' */

	exec cobis..sp_cerror

	@t_debug = @t_debug,

	@t_file	 = @t_file,

	@t_from	 = @w_sp_name,

	@i_num	 = 601077 -- ­Revisar codigo de error!

	return 1

end

select @w_estado = co_estado,
       @w_corte = co_corte,
       @w_periodo = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @i_fecha

if @@rowcount = 0

begin

   print "ERROR: Corte de la fecha de reporte no encontrado"

return 1

end


select @w_estado1 = co_estado,
       @w_corte1 = co_corte,
       @w_periodo1 = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_ant

if @@rowcount = 0

begin

   print "ERROR: Corte de la fecha1 de reporte no encontrado"

return 1

end



if @i_modo = 0

begin

        if @w_estado in ('C','V')
        begin

          delete from cob_conta..cb_hist_saldo_tmp

          insert into cob_conta..cb_hist_saldo_tmp
          select * from cob_conta_his..cb_hist_saldo
          where hi_empresa = @i_empresa 
          and   hi_corte   = convert(int,@w_corte)
          and   hi_periodo = convert(int,@w_periodo)
        end

        delete from cob_conta..cb_mayba_tmp
      
        exec cob_conta..sp_mayba 
        @i_empresa      = @i_empresa,
        @i_fecha        = @i_fecha,
        @i_oficina      = @i_oficina, 
        @i_nivel_cuenta = @i_nivel_cuenta,
        @i_nivel        = @i_nivel

        insert into cob_conta..cb_libromay
        select mt_cuenta, 
               mt_nombre, 
               mt_saldo, 
               mt_debito, 
               mt_credito 
        from cob_conta..cb_mayba_tmp
        group by mt_oficina, mt_cuenta, mt_nombre, mt_saldo, mt_debito, mt_credito
        order by mt_cuenta

        if @@rowcount = 0
        begin   
           print 'ERROR: Insercion cb_libromay - No hay registros'
           return 1
        end


        /*** PARA SALDO ANTERIOR ***/

        if @w_estado1 in ('C','V')
        begin

          delete from cob_conta..cb_hist_saldo_tmp

          insert into cob_conta..cb_hist_saldo_tmp
          select * from cob_conta_his..cb_hist_saldo
          where hi_empresa = @i_empresa 
          and   hi_corte   = convert(int,@w_corte1)
          and   hi_periodo = convert(int,@w_periodo1)
        end

        delete from cob_conta..cb_mayba_tmp

        exec cob_conta..sp_mayba 
        @i_empresa      = @i_empresa,
        @i_fecha        = @w_fecha_ant,
        @i_oficina      = @i_oficina, 
        @i_nivel_cuenta = @i_nivel_cuenta,
        @i_nivel        = @i_nivel

        insert into cob_conta..cb_libromay_ant
        select mt_cuenta, 
               mt_nombre, 
               mt_saldo 
        from cob_conta..cb_mayba_tmp
        group by mt_oficina, mt_cuenta, mt_nombre, mt_saldo
        order by mt_cuenta

        if @@rowcount = 0
        begin   
           print 'ERROR: Insercion cb_libromay_ant - No hay registros'
           return 1
        end

        set rowcount 30
        select lm_cuenta, 
               lm_nombre, 
               la_saldo, 
               lm_saldo, 
               lm_debito, 
               lm_credito 
        from cob_conta..cb_libromay, cob_conta..cb_libromay_ant
        where lm_cuenta = la_cuenta
        group by lm_cuenta, lm_nombre, lm_saldo, lm_debito, lm_credito, la_saldo
        order by lm_cuenta

end

else

begin    


        if @w_estado in ('C','V')
        begin

          delete from cob_conta..cb_hist_saldo_tmp

          insert into cob_conta..cb_hist_saldo_tmp
          select * from cob_conta_his..cb_hist_saldo
          where hi_empresa = @i_empresa 
          and   hi_corte   = convert(int,@w_corte)
          and   hi_periodo = convert(int,@w_periodo)
        end

        delete from cob_conta..cb_mayba_tmp

	exec cob_conta..sp_mayba 

	@i_empresa      = @i_empresa,
	@i_fecha        = @i_fecha,
	@i_oficina      = @i_oficina, 
	@i_nivel_cuenta = @i_nivel_cuenta,
	@i_nivel        = @i_nivel



	insert into cob_conta..cb_libromay

	select mt_cuenta, 

		   mt_nombre, 

		   mt_saldo, 

		   mt_debito, 

		   mt_credito 

	from cob_conta..cb_mayba_tmp

	group by mt_oficina, mt_cuenta, mt_nombre, mt_saldo, mt_debito, mt_credito

        order by mt_cuenta


	if @@rowcount = 0

	begin   

	   print 'ERROR: Insercion cb_libromay - No hay registros'

	   return 1

	end



        /*** PARA SALDO ANTERIOR ***/
        if @w_estado1 in ('C','V')
        begin

          delete from cob_conta..cb_hist_saldo_tmp

          insert into cob_conta..cb_hist_saldo_tmp
          select * from cob_conta_his..cb_hist_saldo
          where hi_empresa = @i_empresa 
          and   hi_corte   = convert(int,@w_corte1)
          and   hi_periodo = convert(int,@w_periodo1)
        end

        delete from cob_conta..cb_mayba_tmp

	exec cob_conta..sp_mayba 

	@i_empresa      = @i_empresa,
	@i_fecha        = @w_fecha_ant,
	@i_oficina      = @i_oficina, 
	@i_nivel_cuenta = @i_nivel_cuenta,
	@i_nivel        = @i_nivel



	insert into cob_conta..cb_libromay_ant

	select mt_cuenta, 

		   mt_nombre, 

		   mt_saldo 

	from cob_conta..cb_mayba_tmp

	group by mt_oficina, mt_cuenta, mt_nombre, mt_saldo
        order by mt_cuenta

	if @@rowcount = 0

	begin   

	   print 'ERROR: Insercion cb_libromay_ant - No hay registros'

	   return 1

	end


	set rowcount 30

	select lm_cuenta, 
               lm_nombre, 
               la_saldo, 
               lm_saldo, 
               lm_debito, 
               lm_credito 
        from cob_conta..cb_libromay, cob_conta..cb_libromay_ant

	where lm_cuenta = la_cuenta
        and   lm_cuenta > @i_cuenta

	group by lm_cuenta, lm_nombre, lm_saldo, lm_debito, lm_credito, la_saldo

        order by lm_cuenta

end



return 0

 
go