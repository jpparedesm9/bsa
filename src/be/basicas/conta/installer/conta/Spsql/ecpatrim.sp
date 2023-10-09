/************************************************************************/
/*	Archivo: 		ecpatrim.sp			        */
/*	Stored procedure: 	sp_valida_ecuacion			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     					*/
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
/*	Reporte de diferencia en la ecuasión patrimonial        	*/
/*	                                        			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_valida_ecuacion')
	drop proc sp_valida_ecuacion
go


create proc sp_valida_ecuacion(
	@i_empresa 	  tinyint	= null,
        @i_oficina_ini    smallint      = null,
        @i_oficina_fin    smallint      = null,
        @i_nivel          tinyint       = null,
        @i_fecha          datetime      = null
)
as


declare @w_cuenta         char(14),
        @w_asociada       char(14),
        @w_parcial        money,
        @w_estado         char(1),
        @w_corte          smallint,
        @w_periodo        smallint,
        @w_multiplicador  smallint,
        @w_categoria      char(1)

set rowcount 0

select @w_multiplicador = 1

delete cb_totales_tmp
delete asociada

select cp_cuenta
into #cta_proc
from cob_conta..cb_cuenta_proceso
where cp_proceso = 6905
and   cp_empresa = @i_empresa


select @w_estado = co_estado,
       @w_corte  = co_corte,
       @w_periodo = co_periodo
from  cob_conta..cb_corte       
where co_fecha_ini = @i_fecha
and   co_empresa = @i_empresa


while 1 = 1
begin
     set rowcount 1

     select @w_cuenta = cp_cuenta
     from #cta_proc

     if @@rowcount = 0
         break

     delete #cta_proc
     where cp_cuenta = @w_cuenta
     
     select @w_categoria = cu_categoria
     from cob_conta..cb_cuenta
     where cu_cuenta = @w_cuenta
     and   cu_empresa = @i_empresa
     
     if @w_categoria = 'C'
          select @w_multiplicador = -1
     else 
          select @w_multiplicador = 1
          
     set rowcount 0

     if @w_estado = 'A'
     begin
          insert into cb_totales_tmp(ct_cuenta,ct_oficina,ct_cta_asoc,ct_saldo_cta)         
          select @w_cuenta,je_oficina_padre, sa_cuenta, sum(sa_saldo) * @w_multiplicador
          from cob_conta..cb_jerarquia, 
               cob_conta..cb_oficina, 
               cob_conta..cb_saldo
          where of_empresa = @i_empresa
          and   of_oficina >= @i_oficina_ini
          and   of_oficina <= @i_oficina_fin
          and   of_organizacion   = @i_nivel
          and   je_oficina_padre = of_oficina
          and   sa_corte   = @w_corte
          and   sa_periodo = @w_periodo
          and   sa_oficina = je_oficina
          and   sa_cuenta  = @w_cuenta
          group by je_oficina_padre, sa_cuenta
          order by je_oficina_padre, sa_cuenta
                    
          if @@rowcount = 0 or @@error <> 0
          begin
               print 'Error en inserción en tabla temporal'
               return 1
          end
     end
     else
     if (@w_estado = 'V') or (@w_estado = 'C')
     begin
          insert into cb_totales_tmp(ct_cuenta,ct_oficina,ct_cta_asoc,ct_saldo_cta)
          select @w_cuenta,je_oficina_padre, hi_cuenta, sum(hi_saldo) * @w_multiplicador
          from cob_conta..cb_jerarquia, 
               cob_conta..cb_oficina, 
               cob_conta_his..cb_hist_saldo
          where of_empresa = @i_empresa
          and   of_oficina >= @i_oficina_ini
          and   of_oficina <= @i_oficina_fin
          and   of_organizacion   = @i_nivel
          and   je_oficina_padre = of_oficina
          and   hi_corte   = @w_corte
          and   hi_periodo = @w_periodo
          and   hi_oficina = je_oficina
          and   hi_cuenta  = @w_cuenta
          group by je_oficina_padre, hi_cuenta
          order by je_oficina_padre, hi_cuenta    

          if @@rowcount = 0 or @@error <> 0
          begin
               print 'Error en inserción en tabla temporal 1'
          end          
     end

     insert into asociada
     select ca_cta_asoc
     from cob_conta..cb_cuenta_asociada
     where ca_empresa = @i_empresa
     and   ca_proceso = 6905
     and   ca_cuenta = @w_cuenta
     
     if @@rowcount = 0
          GOTO LABEL_1

     while 1 = 1
     begin
          set rowcount 1
          select @w_asociada = cuenta 
            from asociada
          order by cuenta
    
          if @@rowcount = 0
          begin
               break
          end

          delete asociada
          where cuenta  = @w_asociada

          select @w_categoria = cu_categoria
          from cob_conta..cb_cuenta
          where cu_cuenta = @w_asociada
          and   cu_empresa = @i_empresa
               
          if @w_categoria = 'C'
               select @w_multiplicador = -1
          else 
               select @w_multiplicador = 1
          

          set rowcount 0

          if @w_estado = 'A'
          begin
               insert into cb_totales_tmp(ct_cuenta,ct_oficina,ct_cta_asoc,ct_saldo_asoc)
               select @w_cuenta,je_oficina_padre, sa_cuenta, sum(sa_saldo) * @w_multiplicador
               from cob_conta..cb_jerarquia, 
                    cob_conta..cb_oficina, 
                    cob_conta..cb_saldo
               where of_empresa = @i_empresa
               and   of_oficina >= @i_oficina_ini
               and   of_oficina <= @i_oficina_fin
               and   of_organizacion   = @i_nivel
               and   je_oficina_padre = of_oficina
               and   sa_corte   = @w_corte
               and   sa_periodo = @w_periodo
               and   sa_oficina = je_oficina
               and   sa_cuenta  = @w_asociada
               group by je_oficina_padre, sa_cuenta
               order by je_oficina_padre, sa_cuenta

               if @@rowcount = 0 or @@error <> 0
               begin
                    print 'Error en inserción en tabla temporal cuenta asociada 1'
               end               
          end
          else
          if (@w_estado = 'V') or (@w_estado = 'C')
          begin
               insert into cb_totales_tmp(ct_cuenta,ct_oficina,ct_cta_asoc,ct_saldo_asoc)
               select @w_cuenta,je_oficina_padre, hi_cuenta, sum(hi_saldo) * @w_multiplicador
               from cob_conta..cb_jerarquia, 
                    cob_conta..cb_oficina, 
                    cob_conta_his..cb_hist_saldo
               where of_empresa = @i_empresa
               and   of_oficina >= @i_oficina_ini
               and   of_oficina <= @i_oficina_fin
               and   of_organizacion   = @i_nivel
               and   je_oficina_padre = of_oficina
               and   hi_corte   = @w_corte
               and   hi_periodo = @w_periodo
               and   hi_oficina = je_oficina
               and   hi_cuenta  = @w_asociada
               group by je_oficina_padre, hi_cuenta
               order by je_oficina_padre, hi_cuenta        
               
               if @@rowcount = 0 or @@error <> 0
               begin
                    print 'Error en inserción en tabla temporal cuenta asociada 2'
               end                              
          end          
     end

LABEL_1:
insert into cb_totales_tmp(ct_cuenta,ct_oficina,ct_cta_asoc,ct_saldo_asoc)
values(@w_cuenta, 255, '6', 0)     

end

set rowcount 0

delete asociada

drop table #cta_proc

return 0

go


