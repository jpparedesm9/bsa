/************************************************************************/
/*	Archivo: 	        ret_insp.sp                             */ 
/*	Stored procedure:       sp_retorna_inspeccion                   */
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
/*	Informacion que se retorna de las inspecciones                  */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*    Jun/1995		                Emision Inicial			*/
/*    Sep/4/1997   Fernando Patino FPL1 Agregar Campos Cliente, nombre  */
/*					del visitador			*/
/*    Abr/17/1998  L. Alvarado          Reorganizacion de datos para    */
/*                                      Mapeo                           */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_retorna_inspeccion')
    drop proc sp_retorna_inspeccion
go
create proc sp_retorna_inspeccion (
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
   @i_filial             tinyint  = null,
   @i_sucursal           smallint = null,
   @i_formato_fecha      int  = null,  --PGA 16/06/2000
   @i_custodia           int      = null,
   @i_tipo               descripcion = null
)
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint, 
   @w_sucursal           smallint,
   @w_tipo               descripcion,
   @w_custodia           int,
   @w_fultima_insp       datetime,
   @w_inspector          int,
   @w_estado             descripcion,
   @w_desc_tipo          descripcion,	--NVR-BE
   @w_codigo_externo     descripcion,
   @w_riesgos            money,
   @w_ciudad             int,
   @w_cliente   	 varchar (64),    --FPL1 Nombre del Cliente de garantia
   @w_nom_inspector      descripcion      --FPL1 Nombre del inspector

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_retorna_inspeccion'
/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19175 and @i_operacion = 'Q')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   select @w_riesgos = 0  
   -- CODIGO EXTERNO
   exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                   @w_codigo_externo out

   exec @w_return         = sp_riesgos
         @s_date           = @s_date, 
         @t_trn            = 19445,
         @i_operacion      = 'Q',
         @i_codigo_externo = @w_codigo_externo,
         @o_riesgos        = @w_riesgos out

      if @w_return  <> 0
      begin
      /*  Error en consulta de registro */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1909002
           return 1 
      end

    select @w_ciudad = cu_ciudad_prenda
    from cu_custodia
    where cu_codigo_externo = @w_codigo_externo 

    select 
        @w_filial       = in_filial, 
        @w_sucursal     = in_sucursal,
        @w_custodia     = in_custodia,
        @w_tipo         = in_tipo_cust,   
        @w_fultima_insp = in_fecha_insp,
        @w_inspector    = in_inspector,
        @w_estado       = in_estado,
        @w_cliente      = cu_propietario,    --FPL1
        @w_ciudad       = cu_ciudad_prenda   --FPL1
    from cob_custodia..cu_inspeccion,cu_custodia
    where
          in_filial    = @i_filial and
          in_sucursal  = @i_sucursal and
          in_tipo_cust = @i_tipo and
          in_custodia  = @i_custodia and 
          in_codigo_externo = cu_codigo_externo and  --FPL1
          in_fecha_insp in (select max(in_fecha_insp) 
                 from cu_inspeccion
                 where in_filial    = @i_filial and
                       in_sucursal  = @i_sucursal and
                       in_tipo_cust = @i_tipo and
                       in_custodia  = @i_custodia and 
		       datepart(year,@s_date) = datepart(year,in_fecha_insp))
    if @@rowcount > 0
       select @w_existe = 1
    else
       select @w_existe = 0

    if @w_existe = 1
    begin
       select @w_nom_inspector = is_nombre
       from cu_inspector
       where @w_inspector = is_inspector
      -- and   is_tipo_inspector = 'A' --emg

       select 
       @w_custodia,
       @w_tipo,
       (select tc_descripcion
        from cu_tipo_custodia
        where  tc_tipo = @w_tipo),
       @w_cliente,               
       "",                       
       convert(char(10),@w_fultima_insp,@i_formato_fecha),
       isnull(convert(char(10),@w_inspector),""),
       @w_nom_inspector,         
       @w_estado,
       (select ci_descripcion 
        from cobis..cl_ciudad
        where ci_ciudad  = @w_ciudad)
    end
    else
    begin
        select 
        @w_filial       = cu_filial,
        @w_sucursal     = cu_sucursal,
        @w_custodia     = cu_custodia,
        @w_tipo         = cu_tipo,
        @w_cliente      = cu_propietario,    --FPL1
        @w_ciudad       = cu_ciudad_prenda   --FPL1
	from cu_custodia
        where
        cu_filial    = @i_filial and
        cu_sucursal  = @i_sucursal and
        cu_tipo = @i_tipo and
        cu_custodia  = @i_custodia and
  	cu_inspeccionar = 'S'      

        if @@rowcount = 0
        begin  
        /*Registro no existe */
           exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 1901005
           return 1 
        end
  
        select
        @w_custodia,
        @w_tipo,
        (select tc_descripcion
        from cu_tipo_custodia
        where  tc_tipo = @w_tipo),
        @w_cliente,               --FPL1 Nombre cliente garnatia
        "",-- isnull(@w_riesgos,0),
        convert(char(10),@w_fultima_insp,@i_formato_fecha),
        isnull(convert(char(10),@w_inspector),""),
        @w_nom_inspector,           --FPL1 Nombre Inspector
        @w_estado,
        (select ci_descripcion 
         from cobis..cl_ciudad
         where ci_ciudad  = @w_ciudad)	
    end
return 0
end
go