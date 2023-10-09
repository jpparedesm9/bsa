/************************************************************************/
/*	Archivo: 	        intcre03.sp                             */ 
/*	Stored procedure:       sp_intcre03                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces/Luis Alfredo Castellanos */
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
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Dado el grupo   entrega los totales de garantias por tipo       */
/*	de garantia                                                     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995   L. Castellanos      Emision Inicial			*/
/*      DIC/2002   Jennifer Velandia   inclucion de tramite             */
/*	18-Oct_2016	N.Vite		Migracion Cobis Cloud	                    */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_intcre03')
drop proc sp_intcre03
go
create proc sp_intcre03  (
   @s_date               datetime    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_grupo              int         = null, 
   @i_tipo_cust          varchar(64) = null,
   @i_cliente            int         = null,
   @i_ente               int         = null,
   @i_codigo_externo     varchar(64) = null,
   @i_tipo_ctz           char(1)     = "B",
   @i_limite             char(1)     = null,
   @i_tipo_tramite       int         =  null,
   @o_valor_total_g      money       = null out

)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_ayer               datetime,
   @w_valor              money,
   @w_cliente            int,
   @w_contador           tinyint,
   @w_tipo               varchar(64),
   @w_gar                varchar(64),
   @w_gac                varchar(64), 
   @w_vcu                varchar(64),
   @w_total              money,
   @w_garantia           varchar(64),
   @w_porcen_cobertura   float,           --FPL1
   @w_def_moneda         tinyint,
   @w_return		 int  ,
   @w_pid_cus	         int,
   @w_rowcount		 int
   

select @w_today   = @s_date
select @w_sp_name = 'sp_intcre03',
@w_ayer    = convert(char(10),dateadd(dd,-1,@s_date),101)
select @w_pid_cus = @@spid * 100 

delete from cu_tmp_cotizacion_moneda
where  sesion =@w_pid_cus

delete from cu_tmp_grupos
where  sesion = @w_pid_cus


/***********************************************************/
/* CODIGOS DE TRANSACCIONES                                */

if (@t_trn <> 19514 and @i_operacion = 'S') 
     
begin
/* TIPO DE TRANSACCION NO CORRESPONDE */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 1901006
   return 1 
end

/*CREACION DE TABLA TEMPORAL PARA COTIZACIONES*/
   /*SELECCION DE CODIGO DE MONEDA LOCAL*/
select @w_def_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLOCR'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
begin
   /*REGISTRO NO EXISTE*/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file = @t_file,
   @t_from = @w_sp_name,
   @i_num = 2101005
   return 1
end
/*
create table #cotizacion_moneda
(moneda		tinyint null,
 cotizacion	money null
)*/
insert into cu_tmp_cotizacion_moneda
(moneda, cotizacion,sesion)
select
a.cv_moneda, a.cv_valor,@w_pid_cus
from cob_conta..cb_vcotizacion a
where cv_fecha =(select max(b.cv_fecha)
                 from cob_conta..cb_vcotizacion b
                 where b.cv_moneda = a.cv_moneda)
and cv_fecha <= @w_today

--INSERTAR UN REGISTRO PARA LA MONEDA LOCAL
if not exists(select * from cu_tmp_cotizacion_moneda
where moneda = @w_def_moneda
and sesion=@w_pid_cus)
insert into cu_tmp_cotizacion_moneda (moneda, cotizacion,sesion)
values(@w_def_moneda,1,@w_pid_cus)


if @w_return <> 0
  begin
      /* NO HAY COTIZACION */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101091
      return 1
   end


if @i_operacion = 'S'
begin
   select @w_gar = pa_char + '%' -- TIPOS GARANTIA
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'GAR'
   set transaction isolation level read uncommitted

   select @w_gac = pa_char + '%' -- TIPOS GARANTIA AL COBRO
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'GAC'
   set transaction isolation level read uncommitted

   select @w_vcu = pa_char + '%' -- TIPOS VALORES EN CUSTODIA
   from cobis..cl_parametro
   where pa_producto = 'GAR'
   and pa_nemonico = 'VCU'
   set transaction isolation level read uncommitted

   if @i_modo = 1
   begin

     /* create table #cu_grupos (Ente      int          null,
                               Producto  varchar(64)  null,
                               Valor     money        null,
                               porcen_cobertura float null)    --FPL1*/

      declare grupos cursor for
      select distinct en_ente, cu_codigo_externo,
      tc_porcen_cobertura      --FPL1
      from cobis..cl_ente,cu_custodia,cob_credito..cr_gar_propuesta,
      cu_tipo_custodia     --FPL1
      where en_grupo          = @i_grupo
      and gp_deudor         = en_ente
      and gp_deudor        <> @i_ente   -- NO INCLUIR AL ENTE DADO
      and gp_garantia       = cu_codigo_externo
      and cu_tipo    not like @w_vcu   -- EXCLUIR VALORES EN CUSTODIA
      and cu_estado        not in ('A','C')  
      and cu_garante        is null    -- EXCLUIR GARANTE
      and (en_ente > @i_cliente or @i_cliente is null)
      and cu_tipo = tc_tipo     --FPL1
      order by en_ente
      for read only

      open grupos
      fetch grupos into @w_cliente,@w_garantia,
      @w_porcen_cobertura     --FPL1

      if (@@fetch_status != 0 )    --  NO EXISTEN GRUPOS
      begin
         --print "No existen clientes para este grupo"
         select * from cu_tmp_grupos
         where sesion=@w_pid_cus
         close grupos
         --return 0
      end

      select @w_contador = 1   -- PARA INGRESAR SOLO 20 REGISTROS
      while (@@fetch_status = 0)  and (@w_contador <=20) -- LAZO DE BUSQUEDA
      begin
         select @w_contador = @w_contador + 1

         select @w_valor =sum(isnull(cu_valor_inicial,0) * isnull(cotizacion,1)), --pga22may2001
                @w_tipo  = cu_tipo 
         from cob_credito..cr_gar_propuesta,--cu_custodia, -- cob_conta..cb_vcotizacion,              
			  cu_tmp_cotizacion_moneda RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
         where gp_deudor          = @w_cliente
         and cu_codigo_externo    = @w_garantia
         and cu_estado            not in ('A')
         --and moneda               =* cu_moneda  
         and sesion =@w_pid_cus
         group by cu_tipo
         order by cu_tipo

         insert into cu_tmp_grupos values (@w_cliente,
         @w_tipo, @w_valor, @w_porcen_cobertura,@w_pid_cus)    
 
         fetch grupos into @w_cliente,@w_garantia

      end   --  FIN DEL WHILE

      if (@@fetch_status = -1)  -- ERROR DEL CURSOR
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
      end
      close grupos
      deallocate grupos
      select * from cu_tmp_grupos
      where  sesion =@w_pid_cus
   end 
   else  -- *****************    TOTALES POR TIPOS    *****************
   begin
      if @i_modo = 2  
      begin
         set rowcount 20
         select 'TIPO'     = cu_tipo,
         'TOTAL VALOR'     = sum(cu_valor_inicial*isnull(cotizacion,1))
         from cobis..cl_ente, cob_credito..cr_gar_propuesta,--cu_custodia, -- pga22may2001 cob_credito..cr_cotizacion,              
			  cu_tmp_cotizacion_moneda RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
         where en_grupo     = @i_grupo 
         and gp_deudor    = en_ente
         and gp_deudor   <> @i_ente   -- NO INCLUIR AL ENTE DADO
         and gp_garantia  = cu_codigo_externo
         and cu_tipo    not like @w_vcu   -- EXCLUIR VALORES EN CUSTODIA
         and cu_garante   is null   --  EXCLUYE GARANTES PERSONALES
         and cu_estado    not in ('C','A')    
         --and moneda    =* cu_moneda  
         and (cu_tipo > @i_tipo_cust or @i_tipo_cust is null)
         and sesion =@w_pid_cus
         group by cu_tipo
         order by cu_tipo
      end

      if @i_modo = 3  --  TOTAL DEL GRUPO
      begin
         select  @w_total   = sum(cu_valor_inicial * isnull(cotizacion,1))
         from cob_credito..cr_gar_propuesta, cobis..cl_ente, --cu_custodia, --pga 2may2001 ,cob_credito..cr_cotizacion
         cu_tmp_cotizacion_moneda RIGHT OUTER JOIN cu_custodia ON (moneda = cu_moneda)
		 where en_grupo     = @i_grupo
         and gp_deudor    = en_ente
         and gp_deudor   <> @i_ente   -- NO INCLUIR AL ENTE DADO
         and gp_garantia  = cu_codigo_externo
         and cu_tipo    not like @w_vcu   -- EXCLUIR VALORES EN CUSTODIA
         and cu_garante   is null   --  EXCLUYE GARANTES PERSONALES
         and cu_estado    not in ('A','C')    
         --and moneda    =* cu_moneda  
         and sesion =@w_pid_cus
         if @i_limite is not null
            select @o_valor_total_g = @w_total
         else
            select @w_total
      end
      /* Para mensajes de error */
      /*if @@rowcount = 0
      begin
         if (@i_modo = 2 and @i_tipo_cust is null) or 
         (@i_modo = 3 and @i_codigo_externo is null)
         return 1 
         else
         return 0 
      end  */
   end -- FIN DEL ELSE
end
go