/************************************************************************/
/*	Archivo: 	        intcre04.sp                             */
/*	Stored procedure:       sp_intcre04                             */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces			      	*/
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
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995      L.Castellanos     Emision Inicial			*/
/*      Jul/17/97     Fernando Patino   Agregar Valor de Cobertura en   */
/*	Oct/24/2002   Alfredo zuluaga   Parametros tipo garantias       */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_intcre04')
    drop proc sp_intcre04
go
create procedure sp_intcre04(
        @s_ssn                int      = null,
        @s_date               datetime = null,
        @s_user               login    = null,
        @s_term               varchar(64) = null,
        @s_corr               char(1)  = null,
        @s_ssn_corr           int      = null,
        @s_ofi                smallint  = null,
        @t_rty                char(1)  = null,
        @t_trn                smallint = null,
        @t_debug              char(1)  = 'N',
        @t_file               varchar(14) = null,
        @t_from               varchar(30) = null,
        @i_operacion          char(1)     = null,
        @i_modo               smallint    = null,
        @i_cliente            int         = null,
        @i_estado             catalogo    = null,
        @i_estado1            tinyint     = null,
        @i_codigo_externo     varchar(64) = null,
        @i_opcion             tinyint     = null,
        @i_opcion1            tinyint     = null,
        @i_abierta_cerrada    char(1)     = 'A',
        @i_tramite            int         = null)
as
declare  
        @w_today              datetime,     /* fecha del dia */ 
        @w_return             int,          /* valor que retorna */
        @w_sp_name            varchar(32),  /* nombre stored proc*/

        /* Variables de la operacion de Consulta */
        @w_custodia          int,
        @w_tipo              varchar(64),
        @w_descripcion       varchar(64),
        @w_codigo_externo    varchar(64),
        @w_producto          char(3),
        @w_moneda            tinyint,
        @w_valor_actual      money,
        @w_total             money,
        @w_cotizacion        money,
        @w_valor_mn          money,
        @w_valor_me          money,
        @w_total_op          money,
        @w_estado            catalogo,
        @w_ayer              datetime,
        @w_contador          smallint,
        @w_gar               varchar(64), 
        @w_gac               varchar(64), 
        @w_vcu               varchar(64), 
        @w_valor_total       money,
        @w_valor_totalp      money,
        @w_valor_otras_op    money,
        @w_garante           int,
        @w_nombre_garante    varchar(64),
        @w_abierta_cerrada   char(1),
        @w_adecuada          char(1), 
        @w_clasificacion     char(1),
        @w_poliza            varchar(20),
        @w_polizas           tinyint,
        @w                   tinyint,
        @w_poliza_aux        varchar(20),
        @w_poliza_1          varchar(20),
        @w_fec_avaluo        datetime,
        @w_valor_cobertura   money,
        @w_gargpe            varchar(30) /*LAZ */


select @w_today   = @s_date
select @w_sp_name = 'sp_intcre04'
select @w_ayer    = convert(char(10),dateadd(dd,-1,@s_date),101)

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19524 and @i_operacion = 'S') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* TOTAL DE GARANTIAS REGISTRADAS EN EL BANCO */

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

      declare cursor_garantia cursor for
       select distinct cu_codigo_externo,cu_tipo,cu_estado,gp_clasificacion,
              cu_descripcion,cu_valor_inicial,cu_moneda,cu_abierta_cerrada,
              cu_adecuada_noadec,cu_garante,
              convert(char(10),cu_fecha_insp,101),
              cu_valor_cobertura      --FPL1
         from cu_custodia, cob_credito..cr_gar_propuesta
        where gp_deudor          = @i_cliente 
          and (gp_tramite = @i_tramite or @i_tramite is null)
          and cu_codigo_externo  = gp_garantia
          and cu_estado          not in ('A','C') -- No las Canceladas
          and cu_tipo     not like @w_vcu -- Excluir Valores en custodia
          and cu_abierta_cerrada = @i_abierta_cerrada
          and (cu_codigo_externo > @i_codigo_externo or @i_codigo_externo is null)
        order by cu_codigo_externo,cu_estado
          for read only

      -- CREACION DE LA TABLA TEMPORAL PARA LA CONSULTA
 
      create table #cu_seleccion   (estado      char(1)     null, 
                                    clasificacion char (1)  null,
                                    tipo        varchar(64) null,
                                    custodia    varchar(64) null,
                                    descripcion varchar(64) null,
                                    valor_mn    money       null,
                                    moneda      tinyint     null,
                                    valor_me    money       null,
                                    adecuada    char(1)     null,
                                    poliza       varchar(20) null,
                                    fec_avaluo   datetime   null,
                                    valor_cobertura money   null )   --FPL1

      select @w_valor_total    = 0,
             @w_valor_totalp   = 0
            

      -- EXTRACCION DE DATOS

      open cursor_garantia
      fetch cursor_garantia into @w_codigo_externo,@w_tipo,@w_estado,
                          @w_clasificacion,@w_descripcion,@w_valor_actual,
                          @w_moneda,@w_abierta_cerrada,@w_adecuada,@w_garante,
                          @w_fec_avaluo, 
                          @w_valor_cobertura     --FPL1

      if (@@fetch_status != 0)    --  No existen garantias
      begin
        --print "No existen garantias para este cliente"
         close cursor_garantia
         deallocate cursor_garantia
         select * from #cu_seleccion
         return 0
      end

      select @w_contador = 1   -- Para ingresar solo 20 registros
      while (@@fetch_status = 0)  and (@w_contador <=20) -- Lazo de busqueda
      begin
         select @w_contador = @w_contador + 1


         select @w_cotizacion = cv_valor 
           from cob_conta..cb_vcotizacion
          where cv_moneda = @w_moneda
            and cv_fecha in (select max(cv_fecha)
                               from cob_conta..cb_vcotizacion
                              where cv_fecha <= @w_today
                                and cv_moneda = @w_moneda)

         if @w_cotizacion is null or @w_cotizacion = 0
            select @w_valor_mn = @w_valor_actual,
                   @w_valor_me = 0
         else
            select @w_valor_mn = @w_valor_actual * @w_cotizacion,
                   @w_valor_me = @w_valor_actual

         if @w_garante is not null 
         begin
            select @w_nombre_garante= p_p_apellido+p_s_apellido+en_nombre
            from cobis..cl_ente
            where en_ente = @w_garante
	    set transaction isolation level read uncommitted

            select @w_descripcion   ="["+convert(varchar(10),@w_garante)+"] "+ @w_nombre_garante 
         end                        
 
         select @w_polizas = count(*)
           from cu_poliza
          where po_codigo_externo = @w_codigo_externo
 
         select @w_poliza = ""
         select @w = 0
         
         while @w < @w_polizas 
         begin 
            select @w = @w + 1 
            select @w_poliza_aux = ""

            select @w_poliza_aux = po_poliza 
              from cu_poliza
             where po_codigo_externo = @w_codigo_externo
               and po_poliza != @w_poliza_1   
            order by po_poliza

            select @w_poliza_1 = @w_poliza_aux

            if @w_poliza_aux is null
               break
            select @w_poliza = ltrim(@w_poliza + "  " + @w_poliza_aux)
         end

 	/* LAZG OCT. 24 2002 */
 	/* LEER POR PARAMETRO EL TIPO DE CUSTODIA */
 	select
 	@w_gargpe = pa_char
 	from cobis..cl_parametro
 	where pa_producto = "GAR"
 	and   pa_nemonico = "GARGPE"
 	set transaction isolation level read uncommitted

 	/* FIN LAZG */
 	
         if @w_tipo = @w_gargpe
            select @w_fec_avaluo = null

         /* Se suman los valores al gran total */
         select @w_valor_totalp      = @w_valor_totalp+@w_valor_mn

         /* Insercion en la tabla temporal     */
         insert into #cu_seleccion (estado,clasificacion,tipo,custodia,
                                    descripcion,valor_mn,moneda,valor_me,
                                    adecuada,poliza,fec_avaluo,
                                    valor_cobertura)    --FPL1
                    values(@w_estado,@w_clasificacion,@w_tipo,@w_codigo_externo,
                           @w_descripcion,@w_valor_mn,@w_moneda,@w_valor_me,
                           @w_adecuada,@w_poliza,@w_fec_avaluo,
                           @w_valor_cobertura)    --FPL1

         select @w_estado         = null,
                @w_clasificacion  = null,
                @w_codigo_externo = null,
                @w_descripcion    = null,
                @w_valor_mn       = null,
                @w_valor_me       = null,
                @w_moneda         = null,   
                @w_abierta_cerrada = null,
                @w_poliza          = null,
                @w_adecuada        = null,
                @w_fec_avaluo      = null,
                @w_cotizacion      = null,
                @w_valor_cobertura = null


         fetch cursor_garantia into @w_codigo_externo,@w_tipo,@w_estado,
                               @w_clasificacion,@w_descripcion,@w_valor_actual,
                               @w_moneda,@w_abierta_cerrada,@w_adecuada,
                               @w_garante,@w_fec_avaluo,
                               @w_valor_cobertura    

      end   --  FIN DEL WHILE

      select @w_valor_total       = @w_valor_total+@w_valor_totalp
      select @w_valor_totalp      = 0


      if (@@fetch_status = -1)  -- ERROR DEL CURSOR
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
      end
      close cursor_garantia
      deallocate cursor_garantia
      if @i_opcion = 1
         select * from #cu_seleccion
      select @w_valor_total       
end     
go