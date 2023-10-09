/*  Base de datos:      cob_credito                                     */
/*  Producto:           Tramites                                        */
/*  Disenado por:       Julian Mendigaña                                */
/*  Fecha de escritura: 16-Abr-2015                                     */
/*  nombre fisico:      cr_valfag                                       */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Stored Procedure para validar segun el parametro si se debe exigir  */
/*  garantia FAG para el tramite en cuestion                            */
/************************************************************************/
USE cob_credito
go
if exists (select 1 from sysobjects where name = 'SP_VAL_OBLI_FAG')
   drop proc SP_VAL_OBLI_FAG
go
CREATE proc SP_VAL_OBLI_FAG(  
	@i_tramite         int      = null,
	@o_retorno         int      output    
)  
  
as  
declare  
   @w_sp_name                   varchar(60),
   @w_par_obl_fag               varchar(10), 
   @w_cod_fag                   varchar(30),
   @w_linea_tramite             catalogo

select @w_sp_name = 'SP_VAL_OBLI_FAG' 
select @o_retorno = 0

if @i_tramite is null
begin
   print 'NO EXISTEN DATOS PARA EL TRAMITE ENVIADO'    
   select @o_retorno = 710391
   return 710391
end	   

-- Lectura Parametro obligatoriedad FAG
select @w_par_obl_fag = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CRE'
and pa_nemonico = 'OBLFAG'

if @@rowcount = 0 begin
   print 'ERROR AL LEER PARAMETRO GENERAL PARA OBTENER OBLIGATORIEDAD FAG'
   select @o_retorno = 710391   
   return 710391
end

select @w_cod_fag = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFAG'

if @@rowcount = 0
begin
   print  'ERROR PARAMETRO CODFAG NO EXISTE'
   select @o_retorno = 1   
   return 708153
end

if @w_par_obl_fag = 'S'
begin

   -- obtiene linea de credito del tramite
   select @w_linea_tramite = tr_toperacion
   from cob_credito..cr_tramite
   where tr_tramite = @i_tramite

   if exists (select top 1 1
              from cob_credito..cr_corresp_sib s, cobis..cl_tabla t, cobis..cl_catalogo c  
              where s.descripcion_sib = t.tabla
              and s.tabla             = 'T301'
              and t.codigo            = c.tabla      
              and c.estado            = 'V'
              and c.codigo            = @w_linea_tramite)
   begin   
      if not exists (select 1 
                 from cob_custodia..cu_custodia, 
                 cob_credito..cr_gar_propuesta, 
                 cob_credito..cr_tramite,
                 cob_custodia..cu_tipo_custodia
                 where gp_tramite  = @i_tramite
                 and gp_garantia = cu_codigo_externo 
                 and cu_estado   not in ('A','C')   -- Anulada y Cancelada
                 and tr_tramite  = gp_tramite
                 and tc_tipo_superior = ltrim(rtrim(@w_cod_fag))
                 and cu_tipo = tc_tipo 
                 )
      begin
         --print 'TRAMITE NO TIENE ASOCIADA GARANTIA FAG  - ' + cast(@i_tramite as varchar)
         select @o_retorno = 2101279	   
         return 2101279
      end
   end
end	
return 0

go
