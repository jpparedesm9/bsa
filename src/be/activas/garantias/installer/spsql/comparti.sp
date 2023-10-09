/************************************************************************/
/*	Archivo: 	        compartida.sp                           */
/*	Stored procedure:       sp_compartida                           */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Ximena Vega                      	*/
/*	Fecha de escritura:     Junio-1999  				*/
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
/*	Maneja la informaci¢n de las Garantias Compartidas.             */
/*				MODIFICACIONES				*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_compartida')
    drop proc sp_compartida
go
create proc sp_compartida (
   @s_ssn                int          = null,
   @s_date               datetime     = null,
   @s_user               login        = null,
   @s_term               varchar(64)  = null,
   @s_corr               char(1)      = null,
   @s_ssn_corr           int          = null,
   @s_ofi                smallint     = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @t_rty                char(1)      = null,
   @t_from               varchar(30)  = null,
   @t_trn                smallint     = null, 
   @i_operacion          char(1)      = null,
   @i_modo               smallint     = null,
   @i_filial             tinyint      = null,
   @i_sucursal           smallint     = null,
   @i_tipo               varchar(64)  = null,
   @i_custodia           int          = null,  
   @i_valor_compartida   float        = null,
   @i_fecha_comp         datetime     = null,
   @i_grado_comp         catalogo     = null,
   @i_porcentaje_comp    float        = null,
   @i_entidad            int          = null,
   @i_valor_contable     float        = null,
   @i_porcentaje_banco   float        = null,
   @i_formato_fecha      int          = null  --PGA 16/06/2000
)
as
declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_retorno            int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               varchar(64),
   @w_secuencial         int,
   @w_valor_compartida   float,
   @w_fecha_comp         datetime,
   @w_grado_comp         tinyint,
   @w_porcentaje_comp    float,
   @w_entidad            int,
   @w_valor_contable     float,
   @w_porcentaje_banco   float, 
   @w_codigo_externo     varchar(64),
   @w_secservicio        int,
   @w_tot_compartida     float,
   @w_tot_porcentaje     float

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_compartida'
/***********************************************************/


    -- CODIGO EXTERNO
      exec sp_externo
      @i_filial,@i_sucursal,
      @i_tipo,
      @i_custodia,
      @w_codigo_externo out                            
 

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion =  'I' 
begin
   if @i_filial is NULL or @i_sucursal is NULL or @i_tipo is NULL 
      or @i_entidad is NULL or @i_valor_compartida is NULL 
 
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
   -- PGA 18may2001      
--    exec @w_secservicio = sp_gen_sec
--         @i_garantia    = @w_codigo_externo

    select @w_secservicio = @@spid
--         @i_garantia    = @w_codigo_externo

    begin tran
      select @w_secuencial = isnull(max(co_secuencial),0)+1 
      from cu_compartida
      where co_codigo_externo = @w_codigo_externo

       
      insert into cu_compartida 
      (co_codigo_externo, co_secuencial, co_valor_compartida,
       co_entidad, co_fecha_comp, co_grado_comp,
       co_porcentaje_comp, co_valor_contable, co_porcentaje_banco)      
      values 
      (@w_codigo_externo, @w_secuencial, @i_valor_compartida,
       @i_entidad, @i_fecha_comp, @i_grado_comp,
       @i_porcentaje_comp, @i_valor_contable, @i_porcentaje_banco)
  
      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
     end 

   select @w_tot_compartida =isnull(sum(co_valor_compartida),0)
   from cu_compartida
   where co_codigo_externo = @w_codigo_externo
 
   update cu_custodia     
   set cu_valor_compartida = @w_tot_compartida
   where cu_codigo_externo = @w_codigo_externo

      if @@error <> 0 
      begin
       /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
         return 1 
     end 


     /*** Transaccion de Servicio****/ 
     /*******************************/

     
     insert into ts_compartida	--1 ya
     values (
     @w_secservicio,@t_trn,'N',
     @s_date,@s_user,@s_term,
     @s_ofi,'cu_compartida', @w_codigo_externo, 
     @w_secuencial, @w_valor_compartida, @w_entidad,
     @w_fecha_comp)
 

     if @@error <> 0 
     begin
          /*Error en insercion de transaccion de servicio*/ 
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1903003
        return 1 
     end 
 commit tran 
 end


/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   select
	"SECUENCIAL"       = X.co_codigo_externo,
        "CODIGO ENTIDAD"   = X.co_entidad,
        "NOMBRE ENTIDAD"   = (select ba_descripcion
                             from cobis..cl_banco_rem
                             where ba_banco = X.co_entidad), 
        "VALOR COMPARTIDO" = X.co_valor_compartida,
        "GRADO"            = X.co_grado_comp,
        "NOMBRE GRADO"     = (select B.valor
                             from cobis..cl_tabla A, cobis..cl_catalogo B
       			     where A.tabla = 'cu_grado_gtia'
			     and B.tabla = A.codigo 
	       	             and B.codigo = X.co_grado_comp), 
   	"PORCENTAJE"       = X.co_porcentaje_comp,
	"VALOR CONTABLE"   = X.co_valor_contable,
 	"PORCENAJE BANCO"  = X.co_porcentaje_banco,
	"FECHA"		   = convert(char(10),X.co_fecha_comp,103)
        from cu_compartida X
        where X.co_codigo_externo = @w_codigo_externo
end
		
       
return 0
go