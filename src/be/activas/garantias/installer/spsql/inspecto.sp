/************************************************************************/
/*	Archivo: 	        inspecto.sp                             */
/*	Stored procedure:       sp_inspector                            */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
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
/*	Ingreso / Modificacion / Elimincion / Consulta y Busqueda       */
/*	de los Inspectores de las Garantias                             */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995  L. Castellanos       Emision Inicial			*/
/*      Nov/2002  Jennifer Velandia    inspector                        */
/*    --  and    is_tipo_inspector = @i_tipo_inspector  --jvc           */ 
/*      Ene/2003  A. Zuluaga           Especificacion CD00057           */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_inspector')
    drop proc sp_inspector


go
create proc sp_inspector (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user                login    = null,
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
   @i_inspector          int  = null,
   @i_ciudad             int      = null,	/*NVR-BE*/
   @i_regional           catalogo  = null,	/*NVR-BE*/
   @i_cta_inspector      ctacliente  = null,
   @i_nombre             descripcion  = null,
   @i_especialidad       catalogo  = null,
   @i_direccion          descripcion  = null,
   @i_telefono           varchar( 20)  = null,
   @i_principal          descripcion  = null,
   @i_cargo              descripcion  = null,
   @i_param1             descripcion  = null,
   @i_cliente_inspec     int = null,
   @i_tipo_cta           char(3) = null,
   @i_login              login = null,
   @i_tipo_inspector     char(1) = null    --jvc 
   
   
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_inspector          int,
   @w_ciudad             int,	
   @w_secservicio        int,	
   @w_regional           catalogo,	
   @w_cta_inspector      ctacliente,
   @w_nombre             descripcion,
   @w_especialidad       catalogo,
   @w_direccion          descripcion,
   @w_telefono           varchar( 20),
   @w_principal          descripcion,
   @w_cargo              descripcion,
   @w_des_especialidad   descripcion,
   @w_inspeccionado      int,
   @w_por_inspeccionar   int,
   @w_peso              int,
   @w_des_cuenta         descripcion,
   @w_error              int,
   @w_cliente_inspec     int,
   @w_tipo_cta           char(3),
   @w_evaluacion         varchar(10)

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_inspector'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19080 and @i_operacion = 'I') or
   (@t_trn <> 19081 and @i_operacion = 'U') or
   (@t_trn <> 19082 and @i_operacion = 'D') or
   (@t_trn <> 19083 and @i_operacion = 'V') or
   (@t_trn <> 19084 and @i_operacion = 'S') or
   (@t_trn <> 19085 and @i_operacion = 'Q') or
   (@t_trn <> 19086 and @i_operacion = 'A') or
   (@t_trn <> 19087 and @i_operacion = 'B') or
   (@t_trn <> 19084 and @i_operacion = "P") or
   (@t_trn <> 19084 and @i_operacion = "X") 

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
if @i_operacion <> 'S' and @i_operacion <> 'A' and @i_operacion <> 'P'
begin
   select 
   @w_inspector      = is_inspector,
   @w_cta_inspector  = is_cta_inspector,
   @w_nombre         = is_nombre,
   @w_especialidad   = is_especialidad,
   @w_direccion      = is_direccion,
   @w_telefono       = is_telefono,
   @w_principal      = is_principal,
   @w_cargo          = is_cargo,
   @w_cliente_inspec = is_cliente_inspec,
   @w_tipo_cta       = is_tipo_cta,
   @w_ciudad	     = is_ciudad,
   @w_regional 	     = is_regional
   from  cob_custodia..cu_inspector
   where is_inspector = @i_inspector
--   and   is_tipo_inspector = @i_tipo_inspector

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
   if @i_inspector is NULL 
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
-- pga18may2001
select @w_secservicio = @@spid
/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1
   begin
   /* Registro ya existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1901002
      return 1 
   end
   begin tran
      insert into cu_inspector(
      is_inspector,      is_cta_inspector,   is_nombre,
      is_especialidad,   is_direccion,       is_telefono,
      is_principal,      is_cargo,           is_cliente_inspec,
      is_tipo_cta,	 is_ciudad,          is_regional,
      is_tipo_inspector)
      values (
      @i_inspector,      @i_cta_inspector,   @i_nombre,
      @i_especialidad,   @i_direccion,       @i_telefono,
      @i_principal,      @i_cargo,           @i_cliente_inspec,
      @i_tipo_cta,	 @i_ciudad,	     @i_regional,
      @i_tipo_inspector)

      if @@error <> 0 
      begin
      /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
      end
 

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_inspector
      values (
      @w_secservicio,     @t_trn,              'N',
      @s_date,            @i_login,            @s_term,
      @s_ofi,             'cu_inspector',      @i_inspector,
      @i_cta_inspector,   @i_nombre,           @i_especialidad,
      @i_direccion,       @i_telefono,         @i_principal,
      @i_cargo,           @i_cliente_inspec,   @i_tipo_cta,
      @i_ciudad,	  @i_regional)

      if @@error <> 0 
      begin
      /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end


   commit tran 
   return 0
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

   -- PGA 18may2001
   select @w_secservicio = @@spid
   begin tran
      update cob_custodia..cu_inspector
      set 
      is_cta_inspector   = @i_cta_inspector,
      is_nombre          = @i_nombre,
      is_especialidad    = @i_especialidad,
      is_direccion       = @i_direccion,
      is_telefono        = @i_telefono,
      is_principal       = @i_principal,
      is_cargo           = @i_cargo,
      is_cliente_inspec  = @i_cliente_inspec,
      is_tipo_cta        = @i_tipo_cta,
      is_ciudad          = @i_ciudad,
      is_regional        = @i_regional
      where is_inspector = @i_inspector
--      and   is_tipo_inspector = @i_tipo_inspector

      if @@error <> 0 
      begin
      /* Error en actualizacion de registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_inspector
      values (
      @w_secservicio,     @t_trn,              'P',
      @s_date,            @i_login,    @s_term,
      @s_ofi,             'cu_inspector',      @w_inspector,
      @w_cta_inspector,   @w_nombre,           @w_especialidad,
      @w_direccion,       @w_telefono,         @w_principal,
      @w_cargo,           @w_cliente_inspec,   @w_tipo_cta,
      @w_ciudad,	  @w_regional)

      if @@error <> 0 
      begin
      /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/

      insert into ts_inspector
      values (
      @w_secservicio,     @t_trn,              'A',
      @s_date,            @i_login,            @s_term,
      @s_ofi,             'cu_inspector',      @i_inspector,
      @i_cta_inspector,   @i_nombre,           @i_especialidad,
      @i_direccion,       @i_telefono,         @i_principal,
      @i_cargo,           @i_cliente_inspec,   @i_tipo_cta,
      @i_ciudad,	  @i_regional)

      if @@error <> 0 
      begin
      /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end
   commit tran
   return 0
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
   /* Registro a eliminar no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file, 
      @t_from  = @w_sp_name,
      @i_num   = 1907002
      return 1 
   end

   /***** Integridad Referencial *****/
   if exists (select * 
              from  cu_control_inspector
              where ci_inspector = @i_inspector)
   begin
      select @w_error = 1907013
      goto error
   end

   if exists (select * from  cu_inspeccion
              where in_inspector = @i_inspector)
   begin
      select @w_error = 1907014
      goto error
   end

   if exists (select * from cu_por_inspeccionar
              where pi_inspector_asig = @i_inspector)
   begin
      select @w_error = 1907014
      goto error
   end

   begin tran
      delete cob_custodia..cu_inspector
   where 
      is_inspector = @i_inspector
--    and is_tipo_inspector = @i_tipo_inspector

      if @@error <> 0
      begin
      /* Error en eliminacion de registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1907001
         return 1 
      end

      /* Transaccion de Servicio */
      /***************************/
      insert into ts_inspector
      values (
      @w_secservicio,     @t_trn,              'B',
      @s_date,            @i_login,            @s_term,
      @s_ofi,             'cu_inspector',      @w_inspector,
      @w_cta_inspector,   @w_nombre,           @w_especialidad,
      @w_direccion,       @w_telefono,         @w_principal,
      @w_cargo,           @w_cliente_inspec,   @w_tipo_cta,
      @w_ciudad,          @w_regional)

      if @@error <> 0 
      begin
      /* Error en insercion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
         return 1 
      end
   commit tran
   return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   if @w_existe = 1
   begin
      select 
      @w_des_especialidad = A.valor
      from  cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and   B.tabla  = 'cu_esp_inspector'
      and   A.codigo = @w_especialidad
      set transaction isolation level read uncommitted
       
    /*  Nov 2002   JVC  */
      select 
      @w_evaluacion = A.valor
      from  cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and   B.tabla  = 'cu_evaluacion'
      and   A.codigo = @w_evaluacion
      set transaction isolation level read uncommitted


      select
      @w_inspector,
      @w_cta_inspector,
      @w_nombre,
      @w_especialidad,
      @w_des_especialidad,
      @w_direccion,
      @w_telefono,
      @w_principal,
      @w_cargo,
      @w_cliente_inspec,
      @w_tipo_cta,
      @w_ciudad,
      @w_regional, 
      @w_evaluacion
      return 0
   end
   else
   /*begin
    Registro no existe 
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901005*/
      return 1 
end

 /* Todos los datos de la tabla */
 /*******************************/
if @i_operacion = 'A'
begin

/* CREACION DE TABLA TEMPORAL DE CARGA DE LOS INSPECTORES */
create table #cu_carga_tmp
(inspector   int null,    carga       int null) 

   if @i_tipo_inspector is null
      select @i_tipo_inspector = 'A'
   
   if @i_inspector is null
      select @i_inspector = convert(int,@i_param1)
   if @i_inspector is null
      select @i_inspector = 0

   insert into #cu_carga_tmp (inspector , carga)
   select 
   pi_inspector_asig ,
   count(*) 
   from cu_por_inspeccionar
   where pi_inspeccionado = 'N'
   group by pi_inspector_asig
   order by pi_inspector_asig

   set rowcount 20

  select  
   (is_inspector),
   "NOMBRE"    = is_nombre,
   "CUENTA"    = is_cta_inspector,
   "ESPECIALIDAD" = B.valor,
   "CIUDAD"     = ci_descripcion,
   "VISITAS" = isnull(carga,0)
   from  cob_custodia..cu_inspector 
                    inner join cobis..cl_ciudad on
                           is_inspector > @i_inspector
                           and is_tipo_inspector = @i_tipo_inspector --emg                                                   
                           and ci_ciudad = is_ciudad
                                 left outer join #cu_carga_tmp on
                                        is_inspector = inspector
                                        left outer join cobis..cl_catalogo B on                                            
                                            is_especialidad = B.codigo
                                            left outer join cobis..cl_tabla A on
                                                    A.codigo = B.tabla
                                                where A.tabla = 'cu_esp_inspector'
                                            order by is_ciudad
end

if @i_operacion = 'S'
begin

   if @i_modo = 0 
   begin

      set rowcount 20 

      select distinct 
      "CODIGO" = is_inspector, 
      "NOMBRE" = substring(is_nombre,1,30) ,
      "CUENTA" = is_cta_inspector,
      "ESPECIALIDAD" = B.valor ,
      "CLIENTE" = is_cliente_inspec		
      from cob_custodia..cu_inspector,
      cobis..cl_tabla A, cobis..cl_catalogo B
      where  A.tabla  = 'cu_esp_inspector'
      and    A.codigo = B.tabla
      and    B.codigo = is_especialidad
      and    is_tipo_inspector = @i_tipo_inspector
          
      order by is_inspector
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
   end
   else 
   begin
      set rowcount 20 

      select 
      "CODIGO" = is_inspector, 
      "NOMBRE" = substring(is_nombre,1,30) ,
      "CUENTA" = is_cta_inspector,
      "ESPECIALIDAD" = B.valor, 
      "CLIENTE" = is_cliente_inspec		
      from cu_inspector ,
      cobis..cl_tabla A, cobis..cl_catalogo B
      where is_inspector > @i_inspector  
      and    A.tabla='cu_esp_inspector'
      and    A.codigo=B.tabla
      and    B.codigo=is_especialidad  
      and    is_tipo_inspector = @i_tipo_inspector 
        
      if @@rowcount = 0
         /*exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1901004 */
         return 2 
   end
end

/* Especificacion CD00057 */
/* LAZ Ene 16 2003        */

if @i_operacion = 'P'   --Solo Planificadores
begin
      select distinct 
      "CODIGO" = is_inspector, 
      "NOMBRE" = substring(is_nombre,1,30) ,
      "ESPECIALIDAD" = B.valor ,
      "CLIENTE" = is_cliente_inspec		
      from cob_custodia..cu_inspector,
      cobis..cl_tabla A, cobis..cl_catalogo B
      where  A.tabla  = 'cu_esp_inspector'
      and    A.codigo = B.tabla
      and    B.codigo = is_especialidad
      and    is_tipo_inspector = "P"          
      order by is_inspector

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
end

if @i_operacion = 'X'   --Solo Planificadores
begin
      select distinct 
      "NOMBRE" = substring(is_nombre,1,30)
      from cob_custodia..cu_inspector,
      cobis..cl_tabla A, cobis..cl_catalogo B
      where  A.tabla  = 'cu_esp_inspector'
      and    A.codigo = B.tabla
      and    B.codigo = is_especialidad
      and    is_tipo_inspector = "P"          
      and    is_inspector = @i_inspector

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end
end


/* Consulta opcion VALUE */
/*************************/

if @i_operacion = 'V'
begin

   if @i_tipo_inspector is null
      select @i_tipo_inspector = 'A'


   select is_nombre,is_cta_inspector 
   from cu_inspector 
   where is_inspector = @i_inspector
   and   is_tipo_inspector = @i_tipo_inspector    -- jvc
   
   if @@rowcount = 0 
   begin
   /* No existe el registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end
end 
return 0
error:    /* Rutina que dispara sp_cerror dado el codigo de error */
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = @w_error
   return 1
go