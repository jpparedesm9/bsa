/************************************************************************/
/*	Archivo: 		    libdia.sp                                       */
/*	Stored procedure: 	sp_extramov_dia  			                    */
/*	Base de datos:  	cob_conta  				                        */
/*	Producto:           Contabilidad               	                    */
/*	Disenado por:       Andres Muñoz       	                            */
/*	Fecha de escritura: Febrero de 2012				                    */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*                  PROPOSITO                                           */
/*                                                                      */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		  RAZON				                        */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_extramov_dia')
   drop proc sp_extramov_dia
go
   
create proc sp_extramov_dia(
@i_param1       varchar(10),     --Fecha inicial
@i_param2       varchar(10),     --Fecha final
@i_param3       varchar(1)       --Empresa
)

as 
declare

@i_fecha_ini        datetime,
@i_fecha_fin        datetime,
@i_empresa          tinyint,
@w_msg              varchar(255),
@w_secuencial       int,
@w_cuenta           varchar(15),
@w_fecha            datetime

/*INICIALIZACION VARIABLES DE TRABAJO*/
select
@i_fecha_ini = convert(datetime, @i_param1),
@i_fecha_fin = convert(datetime, @i_param2),
@i_empresa   = convert(tinyint, @i_param3)

delete from cob_conta..cb_libromov_dia

if ((@i_fecha_fin - @i_fecha_ini) <= 31) 
begin 

   /* EXTRAE LOS MOVIMIENTOS A GENERAR POR FECHAS ESPECIFICAS*/ 

   select 
   as_fecha_tran,
   as_cuenta,
   sum(as_debito) as  as_debito,
   sum(as_credito) as as_credito
   into #mov_dia         
   from cob_conta..cb_comprobante with(nolock),
        cob_conta..cb_asiento with(nolock)
   where co_empresa = @i_empresa
   and   co_fecha_tran between @i_fecha_ini and @i_fecha_fin
   and   co_comprobante > 0
   and   co_oficina_orig > 0
   and   as_empresa = co_empresa
   and   as_fecha_tran = co_fecha_tran
   and   as_comprobante = co_comprobante
   and   as_oficina_orig = co_oficina_orig
   and   as_mayorizado = 'S'
   and   as_cuenta >'0'
   group by as_fecha_tran,as_cuenta
   order by as_fecha_tran,as_cuenta

   while 1 = 1 -- generacion de secuencial para libdia
   begin 

      set rowcount 1

      select 
      @w_cuenta = as_cuenta,
      @w_fecha  = as_fecha_tran
      from #mov_dia

      if @@rowcount = 0 begin
         set rowcount 0
         break
      end

      set rowcount 0

      select @w_secuencial = isnull(max(ld_secuencia), 0) + 1 from cb_libromov_dia
   
      insert into cb_libromov_dia
      select 
      ld_secuencia  = @w_secuencial,
      ld_fecha_tran = as_fecha_tran,
      ld_cuenta     = as_cuenta, 
      ld_nombre_cta = cu_nombre,
      ld_debito     = as_debito,
      ld_credito    = as_credito
      from #mov_dia, cb_cuenta with(nolock)
      where as_cuenta = cu_cuenta
      and   as_cuenta = @w_cuenta
      and   as_fecha_tran = @w_fecha
      order by as_fecha_tran, cu_cuenta

      if @@error <> 0 begin
         select @w_msg = 'Error insertando libros Diarios'
         GOTO ERRORFIN
      end
 
      delete #mov_dia
      where as_cuenta = @w_cuenta
      and   as_fecha_tran = @w_fecha

   end -- END WHILE
  
end else begin
   select @w_msg 'ERROR: RANGO DE FECHAS SUPERIOR A UN MES'
   GOTO ERRORFIN
end

return 0

ERRORFIN:
   print @w_msg
   return 1
go