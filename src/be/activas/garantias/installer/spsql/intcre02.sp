/************************************************************************/
/*	Archivo: 	        intcre02.sp                             */
/*	Stored procedure:       sp_intcre02                             */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de Garantias por Cliente                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      Oct/1995   L.Castellanos         Emision Inicial                */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_intcre02')
   drop proc sp_intcre02
go
create procedure sp_intcre02(
   @s_date               datetime    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_cliente            int         = null,
   @i_codigo_externo     varchar(64) = null,
   @i_opcion             tinyint     = null,
   @i_tipo_ctz           char(1)     = "B",
   @i_grupo              int         = null,
   @i_modo               tinyint     = null,
   @o_valor_total        money       = null out,     
   @o_valor_margen       money       = null out
)
as
declare  
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/ 
   @w_vcu               varchar(64), 
   @w_valor_total       money,
   @w_def_moneda        tinyint,
   @w_return		int,
   @w_spid_si2          int,
   @w_rowcount          int

select @w_today   = @s_date
select @w_sp_name = 'sp_intcre02'
select @w_spid_si2 = @@spid * 100


delete cu_cotizacion_moneda_si2 where sesion = @w_spid_si2
delete cu_cliente_si2 where sesion = @w_spid_si2
delete cu_gar_si2 where sesion = @w_spid_si2
delete cu_resultado_si2 where sesion = @w_spid_si2


/*SELECCION DE CODIGO DE MONEDA LOCAL*/
select	@w_def_moneda	= pa_tinyint
from	cobis..cl_parametro
where	pa_nemonico	= 'MLOCR'
and	pa_producto	= 'CRE'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount=0
begin
   /*REGISTRO NO EXISTE*/
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file = @t_file,
   @t_from = @w_sp_name,
   @i_num = 2101005
   return 1
end


insert into cu_cotizacion_moneda_si2
(moneda, cotizacion, sesion)               
select
cv_moneda, cv_valor, @w_spid_si2
from cob_conta..cb_vcotizacion a 
where cv_fecha =(select max(cv_fecha)
                 from cob_conta..cb_vcotizacion b 
                 where a.cv_moneda = b.cv_moneda)
and cv_fecha <= @w_today


/* Ingresar registro de moneda local si no existe */
if not exists (select 1 from cu_cotizacion_moneda_si2
               where moneda = @w_def_moneda
               and   sesion = @w_spid_si2)
   insert into cu_cotizacion_moneda_si2 values (@w_def_moneda, 1,@w_spid_si2)


/*VALIDACION DE PARAMETROS NULOS*/
if @i_cliente is null and @i_grupo is null
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 2101001
   return 1 	
end


--LLENAR TABLA TEMPORAL DE CLIENTES--
--INSERTAR UN REGISTRO CON EL CLIENTE
if @i_cliente is not null
begin
   insert into cu_cliente_si2(
   cl_cliente, cl_tipo, cl_rol, sesion)
   values(
   @i_cliente, "C", "D", @w_spid_si2)
   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name,
      @i_num    = 2103036
      return 1 
   end

   select @i_grupo = en_grupo
   from cobis..cl_ente
   where en_ente = @i_cliente
   set transaction isolation level read uncommitted
end

/* INSERTAR REGISTROS DE LOS MIEMBROS DEL GRUPO */
if @i_grupo is not null and @i_grupo > 0
begin
   insert into cu_cliente_si2(
   cl_cliente, cl_tipo, cl_rol, sesion)
   select en_ente, "G", "D",@w_spid_si2
   from	  cobis..cl_ente
   where  en_grupo	= @i_grupo
   and    en_ente	<> @i_cliente
   and    en_tipo_ced	> ''
   and    en_ced_ruc	> ''


   if @@error != 0
   begin
      exec cobis..sp_cerror
      @t_from   = @w_sp_name,
      @i_num    = 2103036 
      return 1 
   end
end

/* INSERTAR REGISTROS DE RELACIONADOS */
insert into cu_cliente_si2 (cl_cliente,cl_tipo,cl_rol, sesion)
select distinct convert(int,in_ente_d), "R", "D", @w_spid_si2
from cobis..cl_instancia
where convert(char(10),in_relacion) in (select c.codigo
                                       from cobis..cl_tabla t, cobis..cl_catalogo c
                                       where t.tabla = 'cr_relaciones'
                                       and   t.codigo = c.tabla)
and in_relacion > 0
and in_ente_d > 0
and in_ente_i = @i_cliente

                              
if @@error != 0
begin
   exec cobis..sp_cerror
   @t_from   = @w_sp_name,
   @i_num    = 2103036
   return 1 
end


--ELIMINAR CLIENTES DUPLICADOS
--(1) ELIMINAR R Y E QUE HAYAN SIDO INGRESADOS COMO CLIENTE Y MIEMBROS
--DEL GRUPO
delete cu_cliente_si2
where cl_tipo in ("R","E")
and cl_cliente in (select cl_cliente
                   from  cu_cliente_si2
                   where cl_tipo in ("G","C")
		   and   sesion =  @w_spid_si2)
and   sesion =  @w_spid_si2
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

--(2) ELIMINAR E QUE HAYAN SIDO INGRESADOS COMO RELACIONAODOS CON EL 
--CLIENTE
delete cu_cliente_si2
where cl_tipo = "E"
and   cl_cliente in (select cl_cliente
                   from cu_cliente_si2
                   where cl_tipo in ("R")
		   and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2

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

--INSERTAR LOS REGISTROS EN LA TABLA TEMPORAL DE GARANTIAS
insert into cu_gar_si2 (
ga_garantia, ga_estado, ga_est_credito,
ga_tipo, ga_valor, ga_cobertura,
ga_margen, ga_adec_noadec, ga_tipo_cl,
ga_rol_cl, sesion)
select 	cu_codigo_externo, 		cu_estado, 			cu_estado_credito,
	cu_tipo,			(cu_valor_inicial*cotizacion),  cu_porcentaje_cobertura,
	(cu_valor_cobertura*cotizacion),cu_clase_custodia,		cl_tipo,
	cl_rol,				@w_spid_si2
from 	cob_custodia..cu_custodia, 
	cob_custodia..cu_cliente_garantia,
	cu_cliente_si2, 
	cu_cotizacion_moneda_si2
where 	cg_ente 		= cl_cliente
and     cg_ente			>= 0
and 	cg_tipo_garante 	in ("J","C") 
and 	cu_codigo_externo 	= cg_codigo_externo
and 	cu_estado 		in("P","V","F")
and 	moneda 			= cu_moneda
and 	cu_codigo_externo 	> '0'
and     cu_cliente_si2.sesion   = cu_cotizacion_moneda_si2.sesion
and     cu_cliente_si2.sesion   = @w_spid_si2
and     cu_cotizacion_moneda_si2.sesion = @w_spid_si2

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
--CUANDO LOS CLIENTES SON AMPARADOS
insert into cu_gar_si2 (
ga_garantia, ga_estado,      ga_est_credito,
ga_tipo,     ga_valor,       ga_cobertura,
ga_margen,   ga_adec_noadec, ga_tipo_cl,
ga_rol_cl,   sesion)
select 	cu_codigo_externo, 		cu_estado,			cu_estado_credito,
	cu_tipo,           		(cu_valor_inicial*cotizacion), 	cu_porcentaje_cobertura, 
	(cu_valor_cobertura*cotizacion),cu_clase_custodia,		cl_tipo,	
	"A",				@w_spid_si2
from 	cob_custodia..cu_custodia, 
	cob_custodia..cu_cliente_garantia,
	cu_cliente_si2, 
	cu_cotizacion_moneda_si2
where 	cg_ente 		= cl_cliente
and     cg_ente 		>= 0
and 	cg_tipo_garante 	= "A"
and 	cu_codigo_externo 	= cg_codigo_externo
and 	cu_estado 		in ("F","V","P")
and 	moneda 			= cu_moneda
and 	cu_codigo_externo 	> '0'
and     cu_cliente_si2.sesion   = cu_cotizacion_moneda_si2.sesion
and     cu_cliente_si2.sesion   = @w_spid_si2
and     cu_cotizacion_moneda_si2.sesion = @w_spid_si2

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
delete cu_gar_si2
where ga_tipo_cl in ("G","R","E")
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "C"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2

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

--ELIMINAR GARANTIAS DE RELACIONADOS QUE SE HAN DUPLICADO CON GRUPO
delete cu_gar_si2
where ga_tipo_cl in ("R","E")
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "G"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2
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


--ELIMINAR GARANTIAS DEL CLIENTE DUPLICADAS Y LO QUE CAMBIA ES EL ROL
delete cu_gar_si2
where ga_tipo_cl = "C"
and ga_rol_cl = "C"
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "C"
                    and ga_rol_cl = "D"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2

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


--ELIMINAR GARANTIAS DEL GRUPO DUPLICADAS Y LO QUE CAMBIA ES EL ROL
delete cu_gar_si2
where ga_tipo_cl = "G"
and ga_rol_cl = "C"
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "G"
                    and ga_rol_cl = "D"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2
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

--ELIMINAR GARANTIAS DE RELACIONADOS DUPLICADAS Y LO QUE CAMBIA ES EL ROL
delete cu_gar_si2
where ga_tipo_cl = "R"
and ga_rol_cl = "C"
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "R"
                    and ga_rol_cl = "D"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2
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

--ELIMINAR GARANTIAS DE RELACIONADOS CON EL GRUPO QHE SE HAN DUPLICADO
--Y LO QUE CAMBIA ES EL ROL
delete cu_gar_si2
where ga_tipo_cl = "E"
and ga_rol_cl = "C"
and ga_garantia in (select ga_garantia
                    from cu_gar_si2
                    where ga_tipo_cl = "E"
                    and ga_rol_cl = "D"
		    and   sesion = @w_spid_si2)
and   sesion = @w_spid_si2
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

/******ACTUALIZAR EL CAMPO ga_est_credito A LOS VALORES ********/
--ACTUALIZAR EL ESTADO = "VIG"
update cu_gar_si2
set ga_est_credito = "VIG"
where ga_estado in ("F","V")  --VIGENTE FUTUROS CREDITOS Y VIGENTE
and   sesion = @w_spid_si2
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
update cu_gar_si2
set ga_est_credito = "REC"
where ga_estado = "P"  --PROPUESTAS
and ga_est_credito in ("R","A")
and   sesion = @w_spid_si2
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

--ACTUALIZAR EL ESTADO = "OFR"
update cu_gar_si2
set ga_est_credito = "OFR"
where ga_estado = "P"  --PROPUESTAS
and ga_est_credito = "O"
and   sesion = @w_spid_si2
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

/**********CALCULAR PARAMETROS DE OUTPUT*************/
--select @w_valor_total = sum(ga_margen)
--from cu_gar_si2

/************LLENAR TABLA DE RESULTADOS***************/
if @i_opcion = 1
begin
   if @i_cliente is not null
   --RESULTADOS DEL CLIENTE
   begin
      --INSERTAR GARANTIAS ADMISIBLES
      if exists (select 1
                from cu_gar_si2
                where ga_adec_noadec = "I"
		and   sesion = @w_spid_si2)
      begin
         --INSERTAR TITULO
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen, sesion)
         values(
         "1) IDONEAS", null, null,
         null,@w_spid_si2)
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
         --INSERTAR GARANTIAS DEL CLIENTE COMO DEUDOR
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl = "C"
                   and ga_rol_cl = "D"
                   and sesion = @w_spid_si2)
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            values(
            "a) CLIENTE", null, null,
            null,@w_spid_si2)
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

            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor), 
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl = "C"
            and ga_rol_cl = "D"
            and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end    --FIN DE GARANTIAS ADM. DEL CLIENTE COMO DEUDOR

         --INSERTAR GARANTIAS DEL CLIENTE COMO AMPARADO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl = "C"
                   and ga_rol_cl = "A"
		   and   sesion = @w_spid_si2 )--"C"   SBU 09/ene/2002
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            values(
            "b) COMO AMPARADO", null, null,
            null,@w_spid_si2)
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
            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl = "C"
            and ga_rol_cl = "A"		--"C"
            and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end   --FIN DE GARANTIAS ADM. DEL CLIENTE COMO CODEUDOR

         --INSERTAR GARANTIAS DEL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl in ("G","E")
                   and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DEL GRUPO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            select
            "c) GRUPO", null, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl in ("G","E")
            and sesion = @w_spid_si2
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
         end      --FIN GARANTIAS ADMISIBLES DEL GRUPO

         --INSERTAR GARANTIAS DE RELACIONADOS
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl = "R"
	           and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DE RELACIONADOS
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            select
            "d) RELACIONADOS", null, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl = "R"
            and sesion = @w_spid_si2
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
         end      --FIN GARANTIAS ADMISIBLES DE RELACIONADOS
         --INSERTAR SUBTOTAL
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         select
         "SUBTOTAL IDONEAS", null, sum(ga_valor),
         sum(ga_margen), @w_spid_si2
         from cu_gar_si2
         where ga_adec_noadec = "I"
         and   sesion = @w_spid_si2
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
      end       --FIN DE GARANTIAS ADMISIBLES

      --INSERTAR GARANTIAS NO ADMISIBLES
      if exists (select 1
                from cu_gar_si2
                where ga_adec_noadec = "O"
                and   sesion = @w_spid_si2)
      begin
         --INSERTAR TITULO
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen, sesion)
         values(
         "2) OTRAS GARANTIAS", null, null,
         null, @w_spid_si2)
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
         --INSERTAR GARANTIAS DEL CLIENTE COMO DEUDOR
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl = "C"
                   and ga_rol_cl = "D"
                   and sesion = @w_spid_si2)
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            values(
            "a) CLIENTE", null, null,
            null, @w_spid_si2)
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

            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl = "C"
            and ga_rol_cl = "D"
            and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end    --FIN DE GARANTIAS NOADM. DEL CLIENTE COMO DEUDOR

         --INSERTAR GARANTIAS DEL CLIENTE COMO AMPARADO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl = "C"
                   and ga_rol_cl = "A"
		   and sesion = @w_spid_si2)		--"C"   SBU 09/ene/2002
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen, sesion)
            values(
            "b) COMO AMPARADO", null, null,
            null, @w_spid_si2)
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
            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl = "C"
            and ga_rol_cl = "A"		--"C"
            and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end   --FIN DE GARANTIAS NOADM. DEL CLIENTE COMO CODEUDOR

         --INSERTAR GARANTIAS DEL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl in ("G","E")
                   and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DEL GRUPO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            "c) GRUPO", null, sum(ga_valor),
            sum(ga_margen),@w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl in("G","E")
	    and sesion = @w_spid_si2
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
         end         --FIN GARANTIAS NO ADMISIBLES DEL GRUPO

         --INSERTAR GARANTIAS DE RELACIONADOS
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl = "R"
                   and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DE RELACIONADOS
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            "d) RELACIONADOS", null, sum(ga_valor),
            sum(ga_margen),@w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl = "R"
	    and sesion = @w_spid_si2
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
         end      --FIN GARANTIAS NO ADMISIBLES DE RELACIONADOS
         --INSERTAR SUBTOTAL
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         select
         "SUBTOTAL OTRAS GARANTIAS", null, sum(ga_valor),
         sum(ga_margen),@w_spid_si2
         from cu_gar_si2
         where ga_adec_noadec = "O"
	 and sesion = @w_spid_si2
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
      end       --FIN DE GARANTIAS NO ADMISIBLES
   end      --FIN DE GARANTIAS DEL CLIENTE
   else
   --RESULTADOS DEL GRUPO
   begin
      --INSERTAR GARANTIAS ADMISIBLES
      if exists (select 1
                from cu_gar_si2
                where ga_adec_noadec = "I"
                and sesion = @w_spid_si2)
      begin
         --INSERTAR TITULO
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         values(
         "1) IDONEAS", null, null,
         null,@w_spid_si2)
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

         --INSERTAR GARANTIAS DEL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl = "G"
	 	   and sesion = @w_spid_si2)
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            values(
            "a) GRUPO", null, null,
            null,@w_spid_si2)
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
            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor),
            sum(ga_margen), @w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl = "G"
	    and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end   --FIN DE GARANTIAS ADM. DEL GRUPO

         --INSERTAR GARANTIAS DE RELACIONADOS CON EL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "I"
                   and ga_tipo_cl = "E"
     		   and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DEL GRUPO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            "b) RELACIONADOS", null, sum(ga_valor),
            sum(ga_margen),@w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "I"
            and ga_tipo_cl = "E"
	    and sesion = @w_spid_si2
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
         end      --FIN GARANTIAS ADMISIBLES DE RELACIONADOS AL GRUPO
         --INSERTAR SUBTOTAL
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         select
         "SUBTOTAL IDONEAS", null, sum(ga_valor),
         sum(ga_margen),@w_spid_si2
         from cu_gar_si2
         where ga_adec_noadec = "I"
	 and sesion = @w_spid_si2
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
      end       --FIN DE GARANTIAS ADMISIBLES

      --INSERTAR GARANTIAS NO ADMISIBLES
      if exists (select 1
                from cu_gar_si2
                where ga_adec_noadec = "O"
		and sesion = @w_spid_si2)
      begin
         --INSERTAR TITULO
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         values(
         "2) OTRAS GARANTIAS", null, null,
         null,@w_spid_si2)
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
         --INSERTAR GARANTIAS DEL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl = "G"
		   and sesion = @w_spid_si2)
         begin
            --INSERTAR TITULO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            values(
            "a) GRUPO", null, null,
            null,@w_spid_si2)
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
            --INSERTAR DETALLE
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            ga_tipo, ga_estado, sum(ga_valor),
            sum(ga_margen),@w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl = "G"
	    and sesion = @w_spid_si2
            group by ga_tipo, ga_estado -- ga_est_credito
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
         end      --FIN GARANTIAS NO ADMISIBLES DE GRUPO

         --INSERTAR GARANTIAS DE RELACIONADOS CON EL GRUPO
         if exists (select 1
                   from cu_gar_si2
                   where ga_adec_noadec = "O"
                   and ga_tipo_cl = "E"
		   and sesion = @w_spid_si2)
         begin
            --INSERTAR TOTAL DEL GRUPO
            insert into cu_resultado_si2(
            descripcion, estado, valor,
            margen,sesion)
            select
            "b) RELACIONADOS", null, sum(ga_valor),
            sum(ga_margen),@w_spid_si2
            from cu_gar_si2
            where ga_adec_noadec = "O"
            and ga_tipo_cl = "E"
	    and sesion = @w_spid_si2
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
         end      --FIN GARANTIAS NO ADMISIBLES DE RELACIONADOS CON EL GRUPO
         --INSERTAR SUBTOTAL
         insert into cu_resultado_si2(
         descripcion, estado, valor,
         margen,sesion)
         select
         "SUBTOTAL OTRAS GARANTIAS", null, sum(ga_valor),
         sum(ga_margen),@w_spid_si2
         from cu_gar_si2
         where ga_adec_noadec = "O"
	 and sesion = @w_spid_si2
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
      end       --FIN DE GARANTIAS NO ADMISIBLES
   end      --FIN DE GARANTIAS DEL GRUPO

   --INSERTAR LINEA DE TOTAL
   insert into cu_resultado_si2(
   descripcion, estado, valor,
   margen,sesion)
   select
   "TOTAL GARANTIAS", null, sum(ga_valor),
   sum(ga_margen),@w_spid_si2
   from cu_gar_si2
   where sesion = @w_spid_si2
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

   if @i_opcion is not null and @i_modo <> 0
   begin
      select descripcion,estado,valor,margen
      from cu_resultado_si2
      where sesion = @w_spid_si2
   end
   else
   begin
       select @o_valor_total  = valor,
          @o_valor_margen = margen
          from cu_resultado_si2
          where descripcion = "TOTAL GARANTIAS"
	  and sesion = @w_spid_si2
   end
   
end       --FIN DE @i_opcion = 1

return 0
go