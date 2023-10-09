/************************************************************************/
/*	Archivo: 	                credito4.sp                             */ 
/*	Stored procedure:           sp_credito4                             */ 
/*	Base de datos:  	        cob_custodia				            */
/*	Producto:                   garantias               		        */
/*	Disenado por:               Rodrigo Garces			      	        */
/*  Luis Alfredo Castellanos              	                            */
/*	Fecha de escritura:         Junio-1995  				            */
/************************************************************************/
/*				            IMPORTANTE				                    */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/
/*              				PROPOSITO				                */
/*	Dado el cliente o el grupo entrega los totales de garantias por     */
/*      tipo de garantia  en moneda nacional.                           */
/************************************************************************/
/*	            			MODIFICACIONES				                */
/*	FECHA		AUTOR		RAZON				                        */
/*	Oct/1995     L.Castellanos      Emision Inicial			            */
/*  Mar/2006     John Jairo Rendon  Optimizacion                        */
/*  jun/2008     Jonnatan Peña      Migracion a SQL                     */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_credito4')
drop proc sp_credito4
go
create proc sp_credito4  (
   @s_date               datetime      = null,
   @t_trn                smallint      = null,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(30)   = null,
   @i_modo               smallint      = null,
   @i_cliente            int           = null, 
   @i_codigo_externo     varchar(64)   = null,
   @i_tipo_ctz           char(1)       = "B",
   @i_grupo              int           = null,
   @i_tipo_cl            char(1)       = null,
   @i_adec_noadec        char(1)       = null
)
as

declare
   @w_today              datetime,     
   @w_sp_name            varchar(32),  
   @w_def_moneda         tinyint,
   @w_valor_total        money,
   @w_return		 int,
   @w_conexion		 int,
   @w_rowcount           int

select @w_today 	= @s_date
select @w_sp_name 	= 'sp_credito4'
select @w_conexion	= @@spid*100

delete cu_cot_mon_cred4
where sesion = @w_conexion

delete cu_cliente_cred4
where sesion = @w_conexion

delete cu_gar_cred4
where sesion = @w_conexion

delete cu_resultado_cred4
where sesion = @w_conexion

if (@t_trn <> 19384 )
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 1901006
   return 1 
end


select 	@w_def_moneda 	= pa_tinyint
from 	cobis..cl_parametro
where 	pa_nemonico 	= 'MLOCR'
and   	pa_producto 	= 'CRE'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
begin
   /*REGISTRO NO EXISTE*/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 2101005
   return 1
end

insert into cu_cot_mon_cred4
(moneda, cotizacion,sesion)               
select	a.ct_moneda, 
	a.ct_valor,
        @w_conexion
from 	cob_conta..cb_cotizacion a, cob_conta..cb_cotiz_mon_fechamax m
where a.ct_moneda = m.cv_moneda
and a.ct_fecha = m.cv_fecha_max
and a.ct_fecha <= @s_date

if @@error <> 0
  begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101091
      return 1
   end


if @i_cliente is null and @i_grupo is null
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2101001
   return 1 	
end

if @i_cliente is not null
begin
   insert into cu_cliente_cred4(
   	cl_cliente, 	cl_tipo, 	cl_rol,	sesion)
   values(
   	@i_cliente, 	"C", 		"D",	@w_conexion)

   if @@error <> 0 
   begin
      /* ERROR, INSERTANDO DATOS EN TABLA TEMPORAL DE CLIENTES */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 2103036
      return 1 
   end

--INSERTAR REGISTROS DE LOS RELACIONADOS
insert into cu_cliente_cred4(
cl_cliente, 	cl_tipo, 	cl_rol,	sesion)
select distinct 
in_ente_d, 	"R", 		"D",	@w_conexion
from cobis..cl_instancia
where in_relacion in 	(select	convert(int,c.codigo)
		   	from 	cobis..cl_tabla t, 
			cobis..cl_catalogo c
			where 	t.tabla = 'cr_relaciones'
			and   	t.codigo = c.tabla)
and in_relacion > 0
and in_ente_d 	> 0
and in_ente_i 	= @i_cliente


if @@error <> 0 
begin
   /* ERROR, INSERTANDO DATOS EN TABLA TEMPORAL DE CLIENTES */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2103036
   return 1 
end

--ELIMINAR CLIENTES DUPLICADOS
delete 	cu_cliente_cred4
where 	cl_tipo 	= "R"
and 	cl_cliente 	in (select cl_cliente
                   	    from   cu_cliente_cred4
                   	    where  cl_tipo = "C"
			    and    sesion  = @w_conexion)
and     sesion		= @w_conexion

if @@error <> 0 
begin
   /* ERROR, ELIMINANDO DUPLICADOS EN TABLA TEMPORAL DE CLIENTES */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2107015
   return 1 
end
end

/********LLENAR LA TABLA TEMPORAL CON LAS GARANTIAS A CONSULTAR*******/

insert into cu_gar_cred4 (
ga_garantia, 	ga_estado, 		ga_est_credito,
ga_tipo, 	ga_valor, 		ga_cobertura,
ga_margen, 	ga_adec_noadec, 	ga_tipo_cl,
ga_rol_cl,	sesion)
select distinct
cu_codigo_externo,		cu_estado,			cu_estado_credito,
cu_tipo,			(cu_valor_inicial*cotizacion),  cu_porcentaje_cobertura, 
(cu_valor_cobertura*cotizacion),cu_clase_custodia, 		cl_tipo,                      
"D",				@w_conexion
from cob_custodia..cu_custodia x, 
     cob_custodia..cu_cliente_garantia,
     cu_cliente_cred4, 
     cu_cot_mon_cred4
where cg_ente = cl_cliente
and   cg_ente > 0
and   cg_tipo_garante = "J"
and   cu_codigo_externo = cg_codigo_externo
and   cu_codigo_externo > '0'
and   cu_estado 	in ('P','F','V')
and   moneda 		= cu_moneda
and   cu_cliente_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = cu_cliente_cred4.sesion 

if @@error <> 0 
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2103040
   return 1 
end


--INSERTAR LOS REGISTROS EN LA TABLA TEMPORAL DE GARANTIAS
insert into cu_gar_cred4 (
ga_garantia, 	ga_estado, 		ga_est_credito,
ga_tipo, 	ga_valor, 		ga_cobertura,
ga_margen, 	ga_adec_noadec, 	ga_tipo_cl,
ga_rol_cl,	sesion)
select distinct
cu_codigo_externo,  		cu_estado,         			cu_estado_credito,
cu_tipo,           		(cu_valor_inicial*cotizacion),  	cu_porcentaje_cobertura, 
(cu_valor_cobertura*cotizacion),cu_clase_custodia, 			cl_tipo,                      
"A",				@w_conexion
from 	cob_custodia..cu_custodia x, 
	cob_custodia..cu_cliente_garantia,
	cu_cliente_cred4, 
	cu_cot_mon_cred4
where cg_ente = cl_cliente
and   cg_ente > 0
and   cg_tipo_garante = "A"   --PGA 3may2001
and   cu_codigo_externo = cg_codigo_externo
and   cu_codigo_externo > '0'
and   cu_estado 	in ('P','F','V')
and   moneda 		= cu_moneda
and   cu_cliente_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = cu_cliente_cred4.sesion 

if @@error <> 0 
begin
   /* ERROR, INSERTANDO DATOS EN TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2103040
   return 1 
end


--INSERTAR LOS REGISTROS EN LA TABLA TEMPORAL DE GARANTIAS
--CUANDO LOS CLIENTES SON COPROPIETARIOS
insert into cu_gar_cred4 (
ga_garantia, 		ga_estado, 		ga_est_credito,
ga_tipo, 		ga_valor, 		ga_cobertura,
ga_margen, 		ga_adec_noadec, 	ga_tipo_cl,
ga_rol_cl,		sesion)
select distinct
cu_codigo_externo, 	cu_estado,            		cu_estado_credito,
cu_tipo,                (cu_valor_inicial*cotizacion),  cu_porcentaje_cobertura, 
(cu_valor_cobertura*cotizacion), 			cu_clase_custodia, 
cl_tipo,              	"C",				@w_conexion
from 	cob_custodia..cu_custodia x, 
	cob_custodia..cu_cliente_garantia,
	cu_cliente_cred4, 
	cu_cot_mon_cred4
where cg_ente = cl_cliente
and   cg_ente > 0
and   cg_tipo_garante = "C"   
and   cu_codigo_externo = cg_codigo_externo
and   cu_codigo_externo > '0'
and   cu_estado 	in ('P','F','V')
and   moneda 		= cu_moneda
and   cu_cliente_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = @w_conexion
and   cu_cot_mon_cred4.sesion = cu_cliente_cred4.sesion 


if @@error <> 0 
begin
   /* ERROR, INSERTANDO DATOS EN TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2103040
   return 1 
end


--ELIMINAR GARANTIAS QUE SE HAN DUPLICADO CON LAS DEL CLIENTE
delete cu_gar_cred4
where  ga_tipo_cl = "R"
and    ga_garantia in (select ga_garantia
                    from   cu_gar_cred4
                    where  ga_tipo_cl = "C"
		    and	   sesion = @w_conexion)
and    sesion = @w_conexion

if @@error <> 0 
begin
   /* ERROR, ELIMINANDO DUPLICADOS EN TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2107017
   return 1 
end



update 	cu_gar_cred4
set 	ga_est_credito 	= "VIG"
where 	ga_estado 	in ("F","V")  --VIGENTE FUTUROS CREDITOS Y VIGENTE
and	sesion    	= @w_conexion

if @@error <> 0 
begin
   /* ERROR, ACTUALIZANDO TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2105036
   return 1 
end

--ACTUALIZAR EL ESTADO = "REC"
update 	cu_gar_cred4
set 	ga_est_credito = "REC"
where 	ga_estado = "P"  
and 	ga_est_credito in ("R","A")
and	sesion    	= @w_conexion

if @@error <> 0 
begin
   /* ERROR, ACTUALIZANDO TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2105036
   return 1 
end

update cu_gar_cred4
set    ga_est_credito  = "OFR"
where  ga_estado = "P"  
and    ga_est_credito  = "O"
and    sesion          = @w_conexion

if @@error <> 0 
begin
   /* ERROR, ACTUALIZANDO TABLA TEMPORAL DE GARANTIAS */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2105036
   return 1 
end


/************LLENAR TABLA DE RESULTADOS***************/
/*ENVIO DE RESULTADOS*/
if @i_modo = 0
begin
   select
   'TIPO DE GARANTIA' = ga_adec_noadec,
   'VALOR'            = sum(ga_valor),
   'MARGEN'           = sum(ga_margen)
   from   cu_gar_cred4
   where  sesion      = @w_conexion
   group by ga_adec_noadec
   order by ga_adec_noadec desc
end --FIN MODO 0



--AGRUPADOS POR TIPO DE CLIENTE PARA UN TIPO DE GARANTIA
if @i_modo = 1
begin
   --PARA GARANTIAS DE UN CLIENTE
   if @i_cliente is not null
   begin
      --INSERTAR DATOS DE GARANTIAS DEL CLIENTE
      if exists (select 1
                 from cu_gar_cred4
                 where ga_adec_noadec = @i_adec_noadec
		 and   ga_tipo_cl     = "C"
		 and   sesion 	      = @w_conexion)
      begin
         insert into cu_resultado_cred4(
         descripcion, valor, margen,sesion)
         select
         ga_rol_cl, sum(ga_valor), sum(ga_margen),@w_conexion
         from cu_gar_cred4
         where ga_adec_noadec = @i_adec_noadec
	 and   sesion = @w_conexion
         and ga_tipo_cl = "C"
         group by ga_rol_cl

         if @@error <> 0 
         begin
            /* ERROR, INSERTANDO DATOS EN TABLA DE RESULTADOS */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 2103039
            return 1 
         end
      end

      --INSERTAR DATOS DE GARANTIAS RELACIONADOS CON EL CLIENTE
      if exists (select 1
                 from cu_gar_cred4
                 where ga_adec_noadec = @i_adec_noadec
		 and ga_tipo_cl = "R"
		 and sesion = @w_conexion)
      begin
         insert into cu_resultado_cred4(
         descripcion, valor, margen, sesion)
         select
         "R", sum(ga_valor), sum(ga_margen),@w_conexion
         from cu_gar_cred4
         where ga_adec_noadec = @i_adec_noadec
         and ga_tipo_cl = "R"
	 and sesion = @w_conexion

         if @@error <> 0 
         begin
            /* ERROR, INSERTANDO DATOS EN TABLA DE RESULTADOS */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 2103039
            return 1 
         end
      end
   end   -- FIN INGRESO DE DATOS DE MODO1 DE CLIENTE
   --ENVIO DE RESULTADOS
   select
   'TIPO DE CLIENTE' = descripcion,
   'VALOR'            = valor,
   'MARGEN'           = margen
   from cu_resultado_cred4
   where sesion = @w_conexion
end --FIN MODO 1

--DETALLADO POR GARANTIAS PARA UN TIPO DE GARANTIA Y TIPO DE CLIENTE
if @i_modo = 2
begin
   --INICIALIZAR EL PARAMETRO PARA SIGUIENTES
   select @i_codigo_externo = isnull(@i_codigo_externo, " ")
   --ENVIAR LOS RESULTADOS DE GARANTIAS DE CLIENTE
   if @i_tipo_cl in ("D","A","C")		--SBU 09/ene/2002
   begin
      select
      'Numero'          = ga_garantia,
      'Descripcion'     = isnull((select cu_descripcion from cu_custodia where cu_codigo_externo = c.ga_garantia), ""),
      'Estado'          = ga_estado,     
      'Valor'           = ga_valor,
      'Cobertura'       = ga_cobertura,
      'Margen'          = ga_margen
      from cu_gar_cred4 c
      where sesion = @w_conexion
      and ga_garantia       > @i_codigo_externo
      and ga_tipo_cl        = "C"
      and ga_rol_cl         = @i_tipo_cl
      and ga_adec_noadec = @i_adec_noadec
      order by ga_garantia
   end

   --ENVIAR LOS RESULTADOS DE GARANTIAS DE RELACIONADOS
   if @i_tipo_cl in ("R","E")
   begin
      select
      'Numero'          = ga_garantia,
      'Descripcion'     = isnull((select cu_descripcion from cu_custodia where cu_codigo_externo = c.ga_garantia), ""),
      'Estado'          = ga_estado,       
      'Valor'           = ga_valor,
      'Cobertura'       = ga_cobertura,
      'Margen'          = ga_margen
      from cu_gar_cred4 c
      where sesion = @w_conexion
      and ga_garantia       > @i_codigo_externo
      and ga_tipo_cl        = @i_tipo_cl
      and ga_adec_noadec  = @i_adec_noadec
      order by ga_garantia
   end
end  --FIN MODO 2   

--GARANTIAS DE UN CLIENTE O DEL GRUPO
if @i_modo = 3
begin


--   print "Modo 3, conexion" + cast(@w_conexion as varchar)

   --INICIALIZAR EL PARAMETRO PARA SIGUIENTES
   select @i_codigo_externo = isnull(@i_codigo_externo, " ")

   --ENVIAR LOS RESULTADOS DE GARANTIAS DE CLIENTE
   if @i_cliente is not null
   begin

      select
      'Numero'          = ga_garantia,
      'Descripcion'     = isnull((select cu_descripcion from cu_custodia where cu_codigo_externo = c.ga_garantia), ""),
      'Estado'          = ga_estado,        
      'Valor'           = ga_valor,
      'Cobertura'       = ga_cobertura,
      'Margen'          = ga_margen
      from cu_gar_cred4 c
      where sesion = @w_conexion
      and ga_garantia       > @i_codigo_externo
      and ga_tipo_cl      = "C"
      and ga_rol_cl         in ("D","A","C")	--SBU 09/ene/2002
      order by ga_garantia

   end

end   --FIN MODO 3


if @i_modo = 4  --VALOR DE LAS GARANTIAS SIN TOMAR CUENTA LAS PROPUESTAS. ANALISIS DEL RIESGO
begin
   select
   'TIPO DE GARANTIA' = ga_adec_noadec,
   'VALOR'            = sum(ga_valor),
   'MARGEN'           = sum(ga_margen)
   from   cu_gar_cred4
   where  sesion      = @w_conexion
   and    ga_estado <> 'P'
   group by ga_adec_noadec
   order by ga_adec_noadec desc

end  --if @i_modo = 4

delete cu_cot_mon_cred4
where sesion = @w_conexion

delete cu_cliente_cred4
where sesion = @w_conexion

delete cu_gar_cred4
where sesion = @w_conexion

delete cu_resultado_cred4
where sesion = @w_conexion

return 0
go