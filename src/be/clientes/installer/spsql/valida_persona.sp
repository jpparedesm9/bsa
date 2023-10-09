/************************************************************************/
/*  Archivo:              validar_persona.sp                            */
/*  Stored procedure:     sp_validar_persona                            */
/*  Base de datos:        cob_cartera                                   */
/*  Producto:             Cartera                                       */
/*  Disenado por:         Andy Gonzalez                                 */
/*  Fecha de escritura:   17/Diciembre/2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA'.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
 

use cobis
go
 
if exists (select 1 from sysobjects where name = 'sp_validar_persona')
   drop proc sp_validar_persona
go

create proc sp_validar_persona (
@i_valor_txt   varchar(255)    = null,
@i_opcion      varchar(30)     = null ,  --N  ( CARACTERES RAROS)  
@o_sev         int             = 0    out,
@o_msg         varchar(3000)   = null out 
) as

declare
@w_msg     varchar(3000),
@w_edad_min int, 
@w_edad_max int,   
@w_ventas_min float, 
@w_ventas_max float,
@w_anios_edad int,
@w_fecha    datetime  

select @o_sev = 0, @o_msg = ''

select @w_edad_min = pa_tinyint  --Edad minima
from cobis..cl_parametro 
where pa_nemonico = 'MDE'
and pa_producto = 'ADM'

select @w_edad_max = pa_tinyint --Edad maxima
from cobis..cl_parametro 
where pa_nemonico='EMAX'
and pa_producto = 'ADM'

select @w_ventas_min = pa_money  --ventas minima
from cobis..cl_parametro 
where pa_nemonico = 'VENMIN'
and pa_producto = 'CLI'

select @w_ventas_max = pa_money --ventas maxima
from cobis..cl_parametro 
where pa_nemonico='VENMAX'
and pa_producto = 'CLI'


if @i_valor_txt is not null and rtrim(ltrim(@i_valor_txt)) <> '' begin
   ---VALIDACION DE NOMBRES 
   if @i_opcion = 'NOMBRE1' or @i_opcion = 'NOMBRE2'  or @i_opcion = 'APELLIDO1'  or @i_opcion = 'APELLIDO2'    begin 
   
      if PATINDEX('%[^A-Z Ñ]%',upper(@i_valor_txt)) <> 0 begin
         
         select 
         @o_sev = 1,
         @o_msg = ' | '+'ERROR:EL VALOR DEL CAMPO '+
               case 
                  when @i_opcion = 'NOMBRE1' then 'PRIMER NOMBRE'
                  when @i_opcion = 'NOMBRE2' then 'SEGUNDO NOMBRE'
                  when @i_opcion = 'APELLIDO1' then 'APELLIDO PATERNO'
                  when @i_opcion = 'APELLIDO2' then 'APELLIDO MATERNO'
               end +
       ' NO ES VALIDO'
      end
   end 
   
   --VALIDACION DE CORREOS 
   if @i_opcion = 'EMAIL' begin 
   
      if not (@i_valor_txt like '%_@__%.__%' AND PATINDEX('%[^a-zA-Z,0-9,@,.,_,\-]%', @i_valor_txt) = 0)
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR:CORREO FORMATO NO VALIDO'	   
      
      if exists ( select 1 from cl_direccion where di_tipo = 'CE' and di_descripcion = @i_valor_txt)     
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR: ESTE CORREO ELECTRONICO YA ESTA ASIGNADO A OTRO CLIENTE'
   	  
   end
   
   --VALIDACIONES DE FECHA NACIMIENTO  --DD/MM/YYYY 
   if  @i_opcion = 'FECHA' begin 
   
   
      if isdate(@i_valor_txt) = 0
         select 
         @o_sev = 1,
         @o_msg = ' | '+'ERROR: FORMATO NO VALIDO PARA FECHA DE NACIMIENTO'
   
      --FORMATO [DD/MM/YYYY]
      set dateformat dmy 
      
      select 
      @w_anios_edad = datediff(yy, convert(datetime,case when isdate(@i_valor_txt)= 1 then @i_valor_txt else '01/01/1900' end) , fp_fecha) 
      from cobis..ba_fecha_proceso
    
      if not ((@w_anios_edad >= @w_edad_min) and (@w_anios_edad <= @w_edad_max))	 
         select 
         @o_sev =  @o_sev+1,
         @o_msg = @o_msg+' | '+'ERROR: LA EDAD DEL CLIENTE NO ES VALIDA' 
      
   end  
   
   --VALIDACIONES DE NUMERO DE CELULAR 
   if @i_opcion = 'CELULAR' begin 
   
      if not (PATINDEX('%[^0-9]%',@i_valor_txt ) = 0) begin
          select 
   	    @o_sev = 1,
           @o_msg = ' | '+'ERROR: FORMATO DE NUMERO DE CELULAR  NO VALIDO'  
      end 
      
      if not (len(@i_valor_txt) = 10 ) begin
         select 
   	   @o_sev = @o_sev + 1,
         @o_msg = @o_msg+' | '+'ERROR: EL NUMERO DE CIFRAS DEL CELULAR NO ES CORRECTO'  
      end 
      
      if exists (select 1 from cl_telefono where te_valor = @i_valor_txt) begin 
         select 
         @o_sev = @o_sev + 1,
         @o_msg = @o_msg+' | '+'ERROR: ESTE NUMERO CELULAR YA ESTA REGISTRADO PARA OTRO CLIENTE'
      end
   
   end 
   
   --NUMERO DE HIJOS 
   if @i_opcion = 'HIJOS'begin
   
      if not (PATINDEX('%[^0-9]%',@i_valor_txt ) = 0) begin
         select 
         @o_sev = 1,
         @o_msg = ' | '+'ERROR: FORMATO DE NUMERO DE HIJOS NO VALIDO'  
      end  
      
      if not (convert(int,@i_valor_txt) >=0 and convert(int,@i_valor_txt) <=20) begin
         select 
   	   @o_sev = @o_sev + 1,
         @o_msg = @o_msg+' | '+'ERROR: VALOR NO PERMITIDO EN CAMPO NUMERO HIJOS'
      end    
   
   end 
   
   --GENERO
   if @i_opcion = 'GENERO' begin
   
      if not( @i_valor_txt in ( 'M', 'F') ) begin 
         select 
   	   @o_sev = @o_sev + 1,
         @o_msg = @o_msg+' | '+'ERROR: GENERO NO VALIDO'
      end
   
   end
   
   --ENTIDAD 
   if @i_opcion = 'ENTIDAD' begin 
   
      if not exists (select 1 from cobis..cl_provincia 
              where pv_provincia = convert(int,@i_valor_txt) )begin 
      
         select 
         @o_msg = @o_msg+' | '+'ALERTA: NO EXISTE ENTIDAD EN CATALOGO COBIS'
      end 
   
   end 
   
   ---VALIDACION DE NOMBRES 
   if @i_opcion = 'DOMICILIO'  begin 
   
      if PATINDEX('%[^A-Z0-9 Ñ]%',upper(@i_valor_txt)) <> 0 
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR:EL VALOR DEL CAMPO DOMICILIO NO ES VALIDO'
      
   end

    ---VALIDACION DE NUMERO INTERNO DOMICILIO 
   if @i_opcion = 'NUMERO_INT_DOM'  begin 
   
      if isnumeric(@i_valor_txt) = 0 
         select 
   	     @o_sev = 1,
         @o_msg = ' | '+'ERROR:EL VALOR DEL CAMPO NUMERO INTERNO DE DOMICILIO NO ES NUMERICO'
      
   end    
   
   
   if @i_opcion = 'NUMERO_EXT_DOM'  begin 
   
      if isnumeric(@i_valor_txt) = 0 
         select 
   	     @o_sev = 1,
         @o_msg = ' | '+'ERROR:EL VALOR DEL CAMPO NUMERO EXTERNO DE DOMICILIO NO ES NUMERICO'
      
   end
   --COLECTIVO
   if @i_opcion = 'COLECTIVO'  begin 
   
      if not exists( select 1 from cl_catalogo c , cl_tabla t where  c.tabla = t.codigo and upper(c.codigo) in ( upper(@i_valor_txt)) and t.tabla = 'cl_tipo_mercado') begin 
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR: COLECTIVO NO VALIDO'   
      
      end 
      
   end 
   
   --NIVEL
   if @i_opcion = 'NIVEL'  begin 
   
      if not exists( select 1  from cobis..cl_catalogo c, cl_tabla t  where c.tabla = t.codigo and upper(c.codigo) in ( upper(@i_valor_txt)) and t.tabla = 'cl_nivel_cliente_colectivo' ) begin 
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR: NIVEL COLECTIVO NO VALIDO'   
      
      end 
      
   end 
   
   
   --NIVEL
   
   if @i_opcion = 'VENTAS'  begin 
   
      if not (convert(money,@i_valor_txt) >= @w_ventas_min and convert(money,@i_valor_txt) <=@w_ventas_max) begin 
         select 
   	   @o_sev = 1,
         @o_msg = ' | '+'ERROR: EL VALOR DE LAS VENTAS MENSUALES ESTA FUERA DE RANGO '+convert(varchar,@w_ventas_min)+' - '+convert(varchar,@w_ventas_max)  
      
      end 
      
   end 
   
   
   
   --ACTIVIDAD ECONOMICA 
   
   if @i_opcion = 'ACTIVIDAD'  begin 
   
      if not exists( select 1  from cobis..cl_actividad_ec WHERE ac_codigo = @i_valor_txt ) begin 
     
         select 
   	  @o_sev = 1,
         @o_msg = ' | '+'ERROR: LA ACTIVIDAD ECONOMICA NO EXISTE'   
      
      end 
      
   end 
end

return 0 
go