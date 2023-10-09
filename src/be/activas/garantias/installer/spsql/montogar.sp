/************************************************************************/
/*	Archivo: 	        montogar.sp                             */ 
/*	Stored procedure:       sp_monto_garantia                       */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
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
/*       Montos totales por tipo de Garantias de Cliente y Grupo        */
/*       y miembros de un grupo Economico                               */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_monto_garantia')
    drop proc sp_monto_garantia
go
create proc sp_monto_garantia (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_tipo               descripcion = null,
   @i_filial             tinyint = null,
   @i_cliente            int = null,
   @i_moneda             tinyint = null,
   @i_opcion             tinyint = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_grupo              int,
   @w_def_moneda         tinyint,
   @w_fecha	         datetime,
   @w_pid_buscus	     int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_monto_garantia'
select @w_pid_buscus = @@spid * 100 


delete from cu_tmp_cotizacion_monedagar
where  sesion =@w_pid_buscus




/*SELECCION DE CODIGO DE MONEDA LOCAL*/
select @w_def_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLOCR'
set transaction isolation level read uncommitted

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19224 and @i_operacion = 'S')      
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
/*
create table #cotizacion_moneda
       (moneda tinyint,
        cotizacion float null)*/

insert into cu_tmp_cotizacion_monedagar
(moneda, cotizacion,sesion)
select
a.cv_moneda, a.cv_valor,@w_pid_buscus
from cob_conta..cb_vcotizacion a
where cv_fecha =(select max(b.cv_fecha)
                 from cob_conta..cb_vcotizacion b
                 where b.cv_moneda = a.cv_moneda
                 and b.cv_fecha <= @w_today)

--INSERTAR UN REGISTRO PARA LA MONEDA LOCAL
if not exists(select * from cu_tmp_cotizacion_monedagar
              where moneda = @w_def_moneda
              and sesion =@w_pid_buscus)
insert into cu_tmp_cotizacion_monedagar (moneda, cotizacion,sesion)
values(@w_def_moneda,1,@w_pid_buscus)

if @w_return <> 0
  begin
      /* NO HAY COTIZACION */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101091
      return 1
   end

      set rowcount 20
      if @i_opcion = 1 -- MONTO DE LAS GARANTIAS DEL CLIENTE
      begin
         select cu_tipo,sum(cu_valor_inicial)*isnull(cotizacion,1),cu_moneda,sum(cu_valor_inicial)
           from cu_cliente_garantia, --,cu_tmp_cotizacion_monedagar, cu_custodia
			cu_tmp_cotizacion_monedagar RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
          where cu_filial     = @i_filial
            and sesion        = @w_pid_buscus
            and cg_ente       = @i_cliente
            and cg_filial     = cu_filial
            and cg_sucursal   = cu_sucursal
            and cg_tipo_cust  = cu_tipo
            and cg_custodia   = cu_custodia
            and cu_estado in ('V','E') -- (V)igente,(E)xcepcionada
            --and moneda     =* cu_moneda 
            and (   (cu_tipo > @i_tipo 
                 or (cu_tipo = @i_tipo and cu_moneda > @i_moneda))
                 or @i_tipo is null)
          group by cu_tipo,cu_moneda,cotizacion
          order by cu_tipo,cu_moneda,cotizacion
      end
      
      if @i_opcion = 2 -- MONTO DE LAS GARANTIAS DE LOS MIEMBROS DEL GRUPO EC.
      begin 
         select @w_grupo = en_grupo 
         from cobis..cl_ente
         where en_ente = @i_cliente
	 set transaction isolation level read uncommitted


         select cu_tipo,sum(cu_valor_inicial)*isnull(cotizacion,1),cu_moneda,sum(cu_valor_inicial)
           from cu_cliente_garantia, --cu_custodia,cu_tmp_cotizacion_monedagar,
		   cu_tmp_cotizacion_monedagar RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
          where cu_filial    = @i_filial
            and sesion        = @w_pid_buscus
            and cu_estado in ('V','E') -- (V)igente,(E)xcepcionada
            and cg_ente    in (select en_ente
                                 from cobis..cl_ente
                                where en_grupo = @w_grupo
                                  and en_ente <> @i_cliente)
            and cg_filial    = cu_filial 
            and cg_sucursal  = cu_sucursal
            and cg_tipo_cust = cu_tipo
            and cg_custodia  = cu_custodia 
            --and moneda    =* cu_moneda 
            and (   (cu_tipo > @i_tipo 
                 or (cu_tipo = @i_tipo and cu_moneda > @i_moneda))
                 or @i_tipo is null)
          group by cu_tipo,cu_moneda,cotizacion
          order by cu_tipo,cu_moneda,cotizacion
      end

      if @i_opcion = 3 -- TOTAL DEL CLIENTE Y DEL GRUPO
      begin 
         select @w_grupo = en_grupo from cobis..cl_ente
         where en_ente = @i_cliente
         set transaction isolation level read uncommitted

         select sum(cu_valor_inicial)*isnull(cotizacion,1)
           from cu_cliente_garantia, --cu_custodia,cu_tmp_cotizacion_monedagar,
		   cu_tmp_cotizacion_monedagar RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
          where cu_filial     = @i_filial
            and sesion        = @w_pid_buscus
            and cu_estado in ('V','E') -- (V)igente,(E)xcepcionada
            and cg_ente    in (select en_ente
                                 from cobis..cl_ente
                                where en_grupo = @w_grupo)
            and cg_filial     = cu_filial
            and cg_sucursal   = cu_sucursal
            and cg_tipo_cust  = cu_tipo 
            and cg_custodia   = cu_custodia 
            --and moneda     =* cu_moneda 
            
            GROUP BY isnull(cotizacion,1)
       end
         if @@rowcount = 0
         begin
           if @i_tipo is null
              select @w_error = 1901003
           else
              select @w_error = 1901004

           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = @w_error
           return 1 
         end
end
go