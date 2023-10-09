/************************************************************************/
/*	Archivo: 	        cart_abg.sp                                     */
/*	Stored procedure:       sp_carta_abogado            		        */
/*	Base de datos:  	cob_custodia				                    */
/*	Producto:               garantias               		            */
/*	Disenado por:           Rodrigo Garces                   	        */
/*			        Luis Alfredo Castellanos              	            */
/*	Fecha de escritura:     Junio-1995  				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Obtener la informacion necesaria para llenar la Carta               */
/*	del Abogado, ya sea que sea una nueva carta o una ya existente.     */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	Jun/1995  L.Castellanos       Emision Inicial			            */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_carta_abogado')
    drop proc sp_carta_abogado
go
create proc sp_carta_abogado (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_corr               char(1)     = null,
   @s_ssn_corr           int         = null,
   @s_ofi                smallint    = null,
   @t_rty                char(1)     = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_tipo               descripcion = null,
   @i_tipo_asig          descripcion = null,
   @i_custodia           int         = null,
   @i_status             char(  1)   = null,
   @i_fecha_max_rep      datetime    = null,
   @i_abogado		     char(10)    = null,
   @i_oficial            int         = null,
   @i_fecha_envio_carta  datetime    = null,
   @i_tipo_cust          descripcion = null,
   @i_lote               tinyint     = null,
   @i_filtro             tinyint     = null,
   @i_cond1		         char(10)    = null,
   @i_cond2              char(10)    = null,
   @i_cond3              char(10)    = null,
   @i_cond4              descripcion = null,
   @i_cond5              descripcion = null,
   @i_codigo_externo     varchar(64) = null
)
as

declare
   @w_today                datetime,     /* fecha del dia */ 
   @w_return               int,          /* valor que retorna */
   @w_sp_name              varchar(32),  /* nombre stored proc*/
   @w_existe               tinyint,      /* existe el registro*/
   @w_filial               tinyint,
   @w_sucursal             smallint,
   @w_tipo                 descripcion,
   @w_custodia             int,
   @w_status               char(  1),
   @w_fecha_ant            datetime,
   @w_abogado              char(10),
   @w_tipo_gar             char(10),
   @w_inspector_asig       int,
   @w_fecha                datetime,
   @w_direccion            descripcion,
   @w_descripcion          descripcion,
   @w_nombre               descripcion, 
   @w_nom_ejecutivo        descripcion, 
   @w_ejecutivo            smallint, 
   @w_estado               catalogo,
   @w_cliente              descripcion,
   @w_oficina              descripcion,
   @w_telefono             char(15),
   @w_nombre_oficial       char(25),
   @w_cont                 tinyint, /* Flag para saber si existen prendas */
   @w_nom_t_asig           descripcion,
   @w_lote                 tinyint,
   @w_val_anticipo         money,
   @w_identificacion       varchar(14),
   @w_tipo_asignacion      char(10),
   @w_desc_tipo_asignacion varchar(30),
   @w_valor                varchar(30),
   @w_registro_catastral   varchar(30),
   @w_codigo_externo       varchar(64),
   @w_ciudad               varchar(64),
   @w_tel_min              tinyint

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_carta_abogado'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19816 and @i_operacion = 'S')  or
   (@t_trn <> 19820 and @i_operacion = 'Q') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'Q'
begin
   if @i_operacion = 'S' 
   begin

      if @i_modo = 1                
      begin
         select distinct ga_lote
         from cu_gar_abogado
         where ga_fenvio_carta = @i_fecha_envio_carta
         and   ga_abogado_asig = @i_abogado
         and   ga_filial       = @i_filial
         and   ga_sucursal     = @i_sucursal 
         and   ga_tipo         = @i_tipo_cust
         and   ga_tipo_asig    = @i_tipo_asig
         return 0
      end 

      if @i_modo = 0                
      begin
         select distinct 
         "FECHA ENVIADA"       = convert(char(10),ga_fenvio_carta,101),
         "LOTE"                = ga_lote
         from cu_gar_abogado
         where ga_abogado_asig = @i_cond1
         and   ga_filial       = convert(tinyint,@i_cond2)
         and   ga_sucursal     = convert(smallint,@i_cond3)
         and   (ga_tipo         = @i_cond4 or @i_cond4 is null)
         and   (ga_tipo_asig    = @i_cond5 or @i_cond5 is null)
         and   ga_fenvio_carta is not null
         and   ga_lote         is not null     
         return 0
      end 

      if @i_lote is not null              --envia la fecha maxima
      begin
         select convert(char(10),ca_frecep_reporte,101)
         from cu_control_abogado
         where ca_lote         = @i_lote  
         and   ca_fenvio_carta = @i_fecha_envio_carta
         and   ca_abogado      = @i_abogado
      end
      set rowcount 20
      
      select
      SECUENCIAL     = ga_custodia,
      ABOGADO        = ga_abogado_asig,
      NOMBRE_ABOGADO = ab_nombre,
      TIPO           = ga_tipo, 
      CLIENTE        = cg_nombre,
      DIRECCION      = convert(varchar(30),cu_direccion_prenda),    
      Cod_direc      = en_direccion,
      Cod_ente       = cg_ente,
      TELEFONO       = convert(varchar(10),null),     
      No_GARANTIA    = ga_codigo_externo,
      --CLASE_GARANTIA = cu_adecuada_noadec, emg feb-16-02
      CLASE_GARANTIA   = cu_clase_custodia,
      COMPARTIDA     = cu_compartida,
      GRADO          = cu_grado_gar
      into #garabog 
      from cu_custodia,cu_gar_abogado,cobis..cl_ente,
      cu_cliente_garantia,cu_tipo_custodia ,cob_credito..cr_abogado,
      cobis..cl_funcionario, cobis..cc_oficial
      where ga_filial    = @i_filial
      and   ga_sucursal  = @i_sucursal
      and   en_ente      = cg_ente
      and   (cg_oficial  = @i_oficial or @i_oficial is null)
      and   (ga_tipo_asig = @i_tipo_asig or @i_tipo_asig is null) 
      and   ga_tipo = @i_tipo 
            -- and   ((ga_tipo = @i_tipo    -- pga 14jun2001
      and (ga_custodia >@i_custodia or @i_custodia is null)--)-- pga 14jun2001
             -- or (ga_tipo > @i_tipo and @i_filtro is null) -- pga 14jun2001
             -- or @i_tipo is null) -- pga 14jun2001
      and   cg_principal = 'D'
      and   ga_abogado_asig   = @i_abogado
      and   tc_tipo      = ga_tipo
      and   en_ente      = cg_ente
      and   cg_oficial   = oc_oficial
      and   fu_funcionario = oc_funcionario --en_oficial
      and   cg_codigo_externo = ga_codigo_externo
      and   cu_codigo_externo = cg_codigo_externo
      and   ab_abogado   = ga_abogado_asig
      and   ((@i_lote is null and ga_fenvio_carta is null)
             or (@i_lote is not null  and ga_lote =  @i_lote  
 	    and ga_fenvio_carta = @i_fecha_envio_carta))     
      and  ab_tipo = 'E'
      order by ga_tipo, ga_custodia

      update #garabog
      set DIRECCION = convert(varchar(30),di_descripcion)
      from  cobis..cl_direccion
      where  di_ente      = Cod_ente
      and    di_direccion = Cod_direc
      if @@error <> 0 
       begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
       end

 
      select @w_tel_min = convert(varchar(10),min(te_secuencial))
      from  cobis..cl_telefono, #garabog
      where te_ente       = Cod_ente
      and   te_direccion  = Cod_direc
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
      end

      update #garabog
      set TELEFONO =  isnull(te_valor,"")
      from  cobis..cl_telefono
      where te_ente       = Cod_ente
      and   te_direccion  = Cod_direc
      and   te_secuencial = @w_tel_min--convert(tinyint,TELEFONO)
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
      end

      select 
      SECUENCIAL, ABOGADO,  NOMBRE_ABOGADO,
      TIPO, CLIENTE, DIRECCION,
      TELEFONO, No_GARANTIA,    CLASE_GARANTIA, 
      COMPARTIDA, GRADO
      from #garabog
      order by TIPO, SECUENCIAL
 
 
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,    
         @i_num   = 1901003
         return 1 -- No existen registros
      end
      return 0
   end
end


/* VALIDACION DE CAMPOS NULOS */
/******************************/
/*Consultado de datos a Imprimir y actualizacion de la tabla de abogados*/
if @i_operacion = 'Q'
begin
   if @i_abogado is NULL 
   begin
   /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end

      Select @w_registro_catastral = pa_parametro
      from cobis..cl_parametro
      where pa_nemonico = 'REGCA'
      and   pa_producto = 'GAR'
      set transaction isolation level read uncommitted

/* Consulta opcion QUERY */
/*************************/

   select
   @w_abogado       	= ga_abogado_asig,
   @w_nombre        	= ab_nombre,
   @w_custodia      	= ga_custodia,
   @w_codigo_externo    = ga_codigo_externo,
   @w_tipo_gar      	= ga_tipo, 
   @w_descripcion   	= tc_descripcion,
   @w_direccion     	= substring(isnull(cu_direccion_prenda,""),1,20),
   @w_telefono      	= isnull(cu_telefono_prenda,""),
   @w_ejecutivo     	= cg_oficial, --en_oficial,
   @w_nom_ejecutivo 	= fu_nombre,
   @w_cliente       	= cg_nombre,
   @w_tipo_asignacion 	= ga_tipo_asig,
   @w_identificacion    = en_ced_ruc,
   @w_desc_tipo_asignacion = b.valor,
   @w_ciudad            = ci_descripcion
   from cu_custodia,cu_gar_abogado,
   cu_cliente_garantia,cu_tipo_custodia,cob_credito..cr_abogado,
   cobis..cl_funcionario,cobis..cc_oficial,cobis..cl_ente,cobis..cl_tabla a,
   cobis..cl_catalogo b,cobis..cl_ciudad
   where   ga_filial       = @i_filial
   and   ga_sucursal       = @i_sucursal
   and   ga_tipo           = @i_tipo
   and   tc_tipo           = ga_tipo
   and   cg_ente           = en_ente
   --and   en_ente           = cg_ente
   and   cg_oficial        = oc_oficial
   and   oc_funcionario    = fu_funcionario
   and   cg_codigo_externo = ga_codigo_externo
   and   cu_codigo_externo = cg_codigo_externo
   and   (cg_oficial       = @i_oficial or @i_oficial is null)
   and   ga_abogado_asig   = @i_abogado
   and   ab_abogado        = @i_abogado
   and   a.tabla           = 'cu_tipo_asig'
   and   a.codigo          = b.tabla
   and   b.codigo          = ga_tipo_asig
   and   (cu_codigo_externo = @i_codigo_externo or @i_codigo_externo is null)
   and   (cu_tipo           = @i_tipo or @i_tipo is null)
   and   ci_ciudad = cu_ciudad_prenda
   and   ab_tipo = 'E'
   order by ga_tipo, ga_custodia

   if @@rowcount = 0 
      select @w_existe = 0
   else
      select @w_existe = 1



   if @w_existe = 1
   begin


      select @w_oficina = of_nombre 
      from cobis..cl_oficina
      where of_oficina  = @s_ofi
      set transaction isolation level read uncommitted

      select @w_nom_t_asig = valor
      from   cobis..cl_catalogo A, cobis..cl_tabla B
      where  A.tabla  = B.codigo
      and    B.tabla  = "cu_tipo_asig"
      and    A.codigo = @i_tipo_asig
      set transaction isolation level read uncommitted


     select @w_valor = ic_valor_item 
     from   cu_item, cu_item_custodia
     where it_tipo_custodia  = @i_tipo
     and   it_item           = ic_item 
     and   ic_codigo_externo = @w_codigo_externo
     and   ic_tipo_cust      = it_tipo_custodia
     and   it_nombre         = @w_registro_catastral


     	
      if @i_lote is not null
      begin
         select
         (select convert(char(10),@i_fecha_max_rep,101)),
         @w_ciudad,
         @w_nombre,
         @w_nom_t_asig,
         convert(char(10),@i_fecha_envio_carta,101),
         @w_oficina
         return 0
      end
      select  @w_lote = (select isnull(max(ga_lote),0)+1
                         from cu_gar_abogado 
                         where ga_fenvio_carta = @s_date)


      update cu_gar_abogado set
      ga_fenvio_carta   = @s_date,
      ga_lote           = @w_lote
      where ga_tipo         = @i_tipo
      and ga_abogado_asig = @i_abogado
      and ga_fenvio_carta is null
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1905001
       return 1 
      end


      --Actualizar CONTROL DE ABOGADOS
      /* Se elimino de la tabla cu_control_abogado los campos*/
      /* f_envio_carta y frecep_reporte por lo tanto ya no se controlan*/
      /* fechas, solo se utilizara para valores facturados*/
         
      select  @w_val_anticipo = sum(ga_valor_anticipo)
      from cu_gar_abogado
      where ga_fenvio_carta = @s_date
      and   ga_lote         = @w_lote
       
      begin


         if not exists (select 1 from cu_control_abogado
                   where ca_abogado = @i_abogado 
                   and   ca_fenvio_carta = @s_date
                   and   ca_lote = @w_lote)
         begin    

         insert into cu_control_abogado (
         ca_abogado, ca_fenvio_carta, ca_frecep_reporte,
         ca_lote,    ca_valor_pagado, ca_pago)
         values (
         @i_abogado, @s_date,         @i_fecha_max_rep,
         @w_lote,    @w_val_anticipo,'N')
         if @@error <> 0 
         begin
          -- Error en insercion de registro 
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
         end
         end



      end
	 
     -- Datos a Imprimir


       select
       (select convert(char(10),@i_fecha_max_rep,101)),
       @w_ciudad,
       @w_nombre,
       @w_nom_t_asig,
       convert(char(10),@s_date,101),
       @w_direccion,
       @w_tipo_asignacion,
       @w_identificacion,
       @w_valor,
       @w_cliente

   end
   else
   begin
    /*Registro no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end
   return 0
end
go
