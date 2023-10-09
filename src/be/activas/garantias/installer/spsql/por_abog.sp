/************************************************************************/
/*	Archivo: 	        por_abogado.sp      		        */
/*	Stored procedure:       sp_asig_abogado                         */
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
/*	Este programa procesa las transacciones de:			*/
/*	Ingreso / Modificacion / Eliminacion / Consulta y Busqueda      */
/*	de las Garantias por asignar abogado                            */
/************************************************************************/
/*				MODIFICACIONES				*/
/*      FECHA        AUTOR	   RAZON				*/
/*	Jun/1995		   Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_asig_abogado')
    drop proc sp_asig_abogado
go
create proc sp_asig_abogado (
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
   @i_filial             tinyint  = null,
   @i_sucursal           smallint  = null,
   @i_tipo               descripcion  = null,
   @i_tipo_cust          descripcion  = null,
   @i_custodia           int  = null,
   @i_status             char(1)  = null,
   @i_fecha_ant          datetime  = null,
   @i_inspector_ant      int  = null,
   @i_estado_ant         catalogo  = null,
   @i_inspector_asig     int  = null,
   @i_fecha_asig         datetime  = null,
   @i_formato_fecha      int   = null,    --PGA 16/06/2000
   @i_inspector		 int   = null,
   @i_fecha_ini          datetime  = null,
   @i_fecha_insp         datetime  = null,
   @i_fecha_fin		 datetime  = null,
   @i_codigo_externo     varchar(64) = null,
   @i_oficial            int         = null,
   @i_tipo_asig          char(10)    = null,
   @i_abogado_asig  	 catalogo    = null,
   @i_valor_anticip      money       = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               varchar(64),
   @w_custodia           int,
   @w_status             char(1),
   @w_inspeccionado      char(1),
   @w_fecha_ant          datetime,
   @w_valor_anticip      money,
   @w_inspector_ant      int,
   @w_estado_ant         catalogo,
   @w_inspector_asig     int,
   @w_fecha_asig         datetime,
   @w_fecha_inspec       datetime,
   @w_cliente_principal  int,
   @w_riesgos            money, 
   @w_mes_actual         tinyint, 
   @w_nro_inspecciones   tinyint, 
   @w_intervalo          tinyint,
   @w_estado             catalogo,
   @w_fecha_insp         datetime,
   @w_gar_personal       descripcion,
   @w_scu                descripcion,
   @w_cont               tinyint, /* Flag para saber si existen prendas */
   @w_codigo_externo     varchar(64),
   @w_estado_gar         char(1),
   @w_tipo_asig          char(1),
   @w_fecha_prox_insp    datetime,
   @w_oficial            int,
   @w_fecha_ini          datetime, 	
   @w_fecha_fin          datetime, 	
   @w_abogado_ant        catalogo,	
   @w_abogado_asig	 catalogo,
   @w_error1 		 tinyint, /*Tramite Abierto.Ya se envio carta abg*/
   @w_error2		 tinyint, /*Proceso ya Terminado x 1 abg*/
   @w_error3		 tinyint, /*Garantia en Tramite*/ 
   @w_actualizar  	 tinyint,
   @w_nom_abogado        descripcion,
   @w_nom_cliente	 descripcion,
   @w_fenvio_carta       datetime,
   @w_valor_actual	 money,
   @w_ciudad_prenda      int,
   @w_oficina		 smallint

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_asig_abogado'

select @w_gar_personal = pa_char + '%'       
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'GARGPE' 
set transaction isolation level read uncommitted

/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19810 and @i_operacion = 'I') or
   (@t_trn <> 19811 and @i_operacion = 'U') or
   (@t_trn <> 19812 and @i_operacion = 'D') or
   (@t_trn <> 19813 and @i_operacion = 'Z') or
   (@t_trn <> 19814 and @i_operacion = 'Q') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencia de Registro */
/**************************/
if @i_operacion <> 'I' 
begin
    select 
         @w_filial = ga_filial,
         @w_sucursal = ga_sucursal,
         @w_tipo = ga_tipo,
         @w_custodia = ga_custodia,
         @w_codigo_externo = ga_codigo_externo
    from cob_custodia..cu_gar_abogado
    where 
         ga_filial = @i_filial and
         ga_sucursal = @i_sucursal and
         ga_tipo   = @i_tipo_cust   and
         ga_codigo_externo = @i_codigo_externo
    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/**************************/
if @i_operacion = 'I' 
begin
   if exists (select * 
               from cu_gar_abogado 
               where ga_codigo_externo = @i_codigo_externo
               and   ga_fenvio_carta   is null)
      select @w_actualizar = 1 
   else
      select @w_actualizar = 0
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_filial is NULL or 
         @i_sucursal is NULL or 
         @i_tipo_cust is NULL or 
         @i_custodia is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end
end

/* Insercion del registro */
/**************************/
if @i_operacion = 'I'
begin
   if @w_actualizar = 1
   begin
      update cu_gar_abogado
      set ga_abogado_asig = @i_abogado_asig,
      ga_fecha_asig   = @i_fecha_asig, 
      ga_valor_anticipo = @i_valor_anticip  
      where 
      ga_codigo_externo = @i_codigo_externo and
      ga_fenvio_carta   is null 
      
      if @@error <> 0 
      begin
         /* Error en actualizacion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end
   end
   else
   begin
      begin tran
         insert into cu_gar_abogado(
         ga_filial, ga_sucursal, ga_tipo,
         ga_custodia, ga_codigo_externo, ga_abogado_asig,
         ga_fecha_asig, ga_tipo_asig, ga_revisado,
         ga_valor_anticipo)
         values (
         @i_filial, @i_sucursal, @i_tipo_cust,
         @i_custodia, @i_codigo_externo, @i_abogado_asig,
         @i_fecha_asig, @i_tipo_asig, "N" ,
         @i_valor_anticip)
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1903001
            return 1 
         end
      commit tran 
      return 0
   end
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
    /* Registro a actualizar no existe */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905002
      return 1 
   end

   begin tran
      select
      @w_abogado_ant = ga_abogado_asig,
      @w_fecha_ant   = ga_fecha_asig
      from cu_gar_abogado
      where ga_codigo_externo = @i_codigo_externo

      update cob_custodia..cu_gar_abogado
      set ga_abogado_ant =  @w_abogado_ant,
      ga_fecha_ant   =  @w_fecha_ant,
      ga_tipo_asig   =  @i_tipo_asig,
      ga_abogado_asig = @i_abogado_asig,
      ga_valor_anticipo = @i_valor_anticip,
      ga_fecha_asig    = @i_fecha_asig -- LAL getdate()
      where ga_codigo_externo = @i_codigo_externo

      if @@error <> 0 
      begin
      /* Error en actualizacion de registro */
         exec cobis..sp_cerror
         @t_from = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end

   commit tran
   return 0
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
   begin tran
      delete cob_custodia..cu_gar_abogado
      where  ga_filial  = @i_filial 
      and ga_sucursal   = @i_sucursal 
      and ga_tipo       = @i_tipo_cust 
      and ga_custodia   = @i_custodia
      and ga_fenvio_carta is null          
       if @@error <> 0
       begin
         /*Error en eliminacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1907001
          return 1 
       end
    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   select
   "GARANTIA"=cu_custodia,
   "No.GTIA."=cu_codigo_externo,
   "TIPO"    = cu_tipo,
   "DESCRIPCION" = tc_descripcion, 
   "NOMBRE CLIENTE"=cg_nombre, 
   "VLR GTIA" = isnull(cu_valor_inicial, isnull(cu_valor_refer_comis,0)), 
   "CIUDAD"= ci_descripcion, 
   "OFICINA"=of_nombre, 
   "ABOGADO"=" ",
   "ESTADO"=cu_estado 
   from   cu_custodia
                inner join cu_tipo_custodia on
                    cu_filial    = @i_filial
                and cu_sucursal  = @i_sucursal
                and cu_tipo      = @i_tipo_cust
                and cu_custodia  = @i_custodia /*LAL Parametro necesario para cons*/
                AND tc_tipo = cu_tipo
                    inner join cu_cliente_garantia on
                         cg_codigo_externo = cu_codigo_externo
                         left outer join cobis..cl_oficina on
                             cu_oficina  = of_oficina
                            left outer join cobis..cl_ciudad on                                   
                                 cu_ciudad_prenda   = ci_ciudad
end

/* Operacion de Busqueda con cursor  */

if @i_operacion = 'Z'
begin
   create table #tmp_abogado (
   filial         tinyint,
   sucursal       smallint,
   tipo           varchar(64),
   custodia       int,
   codigo_externo varchar(64),
   abogado        varchar(10) null, 		--reemplaza tipo catalogo
   nom_abogado    varchar(64) null,          --reemplaza tipo descripcion
   valor_anticipo money null,
   abogado_ant    varchar(10) null, 
   fecha_ant      datetime null,
   nom_cliente    varchar(64),
   valor_actual   money null,
   ciudad_prenda  int null,
   oficina        smallint null,
   oficial        int null)

   declare busqueda cursor for --1
   select cu_tipo, cu_custodia, 
   cu_codigo_externo, cg_nombre, cu_valor_inicial,
   cu_ciudad_prenda, cu_oficina, cg_oficial
       from  cu_custodia, cu_cliente_garantia
       where cu_filial   =  @i_filial
	and  cu_sucursal  = @i_sucursal
        and  cu_estado    not in ('A','C')   -- No incluir las canceladas
        and (cu_tipo = @i_tipo_cust or @i_tipo_cust is null)
        and ((cu_tipo  > @i_tipo_cust or 
             (cu_tipo   = @i_tipo_cust and cu_custodia > @i_custodia)) or @i_custodia is null)
        and (cg_oficial  =  @i_oficial or @i_oficial is null)
	and cg_principal      =  'D' --LAL DE S
	and cg_codigo_externo = cu_codigo_externo
      order by cu_tipo, cu_custodia
      for read only

      open busqueda --1
      fetch busqueda into @w_tipo, @w_custodia,--1
                          @w_codigo_externo, @w_nom_cliente,
                          @w_valor_actual, @w_ciudad_prenda,
			              @w_oficina, @w_oficial
    while @@fetch_status = 0
    begin
      
      if (@@fetch_status = -1)    --  No existen garantias
      begin
         close busqueda--1
         deallocate busqueda 
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 -- No existen registros
      end
      
            select
            @w_valor_anticip = 0,
            @w_fenvio_carta = null

            select @w_abogado_asig = null, @w_nom_abogado = null
            select 
            @w_abogado_asig = ga_abogado_asig,          
            @w_nom_abogado  = ab_nombre,                
            @w_valor_anticip= ga_valor_anticipo,
            @w_fenvio_carta = ga_fenvio_carta
            from  cob_credito..cr_abogado, cu_gar_abogado
            where ga_abogado_asig    = ab_abogado
            and   ga_codigo_externo  = @w_codigo_externo
            and   ga_fecha_asig      = (select max(ga_fecha_asig)     
                                        from cu_gar_abogado
                                        where 
                                        ga_codigo_externo = @w_codigo_externo) 
            and   ga_revisado <> 'S'
            and   ab_tipo = 'E'
            /*traer los datos de Abg Anterior Feb-24-99 NVR*/ 
            select @w_abogado_ant=ga_abogado_ant,
                   @w_fecha_ant=ga_fecha_ant
              from cu_gar_abogado
             where ga_codigo_externo=@w_codigo_externo
             
            if @w_fenvio_carta is null 
            begin
               begin tran        
	          insert into #tmp_abogado values
                  (@i_filial,   @i_sucursal,       @w_tipo,
                   @w_custodia, @w_codigo_externo, @w_abogado_asig,
                   @w_nom_abogado, @w_valor_anticip,
		           @w_abogado_ant,@w_fecha_ant, @w_nom_cliente,
                   @w_valor_actual, @w_ciudad_prenda, @w_oficina, @w_oficial)
               commit tran
            end
            
            fetch busqueda into @w_tipo,@w_custodia,@w_codigo_externo, @w_nom_cliente,--1
                                @w_valor_actual, @w_ciudad_prenda, @w_oficina, @w_oficial

      end   --  FIN DEL WHILE
      close busqueda--1
      deallocate busqueda 
         
    
   set rowcount 20
        select "SECUENCIAL"=custodia,
              "No.GTIA."=codigo_externo,
              "TIPO"    = tipo,      
              "DESCRIPCION" = tc_descripcion,
              "NOMBRE CLIENTE"=nom_cliente,
              "Vlr.GTIA." = valor_actual,
              "CIUDAD"=ci_descripcion,
              "OFICINA"=of_nombre,
              "ABOGADO"= abogado,
	          "NOM.ABG"= nom_abogado,
              "VALOR ANTICIPO" = valor_anticipo,
	          "ABOGADO ANT"=abogado_ant,
	         "FECHA ANT"=fecha_ant
      from   cu_tipo_custodia 
                 inner join #tmp_abogado on filial    = @i_filial
                  and   sucursal  = @i_sucursal
                  and   tipo      = @i_tipo_cust
                  and   tc_tipo      = tipo
                     left outer join cobis..cl_ciudad on
                         ciudad_prenda = ci_ciudad
                           left outer join cobis..cl_oficina on
                             oficina = of_oficina
                             and (oficial  = @i_oficial or @i_oficial is null)
                             order by tipo, custodia                                          

     if @@rowcount = 0
      begin
         if @i_tipo_cust is null
         begin
        
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901003
            return 1 -- No existen registros
         end
      end
end
go