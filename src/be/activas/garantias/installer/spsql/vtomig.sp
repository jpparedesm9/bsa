/************************************************************************/
/*	Archivo: 	        vtomig.sp                               */ 
/*	Stored procedure:       sp_vencimiento_mig                      */ 
/*	Base de datos:  	cob_custodia			        */
/*	Producto:               GARANTIAS                      		*/
/*	Disenado por:           Milena Gonzalez                         */      
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
/*      Ingresa los datos desde un archivo hacia una tabla de migraci¢n */
/*      cu_vencimiento_mig Valida el tipo de dato, chequea consistencia */
/*      guarda los errores encontrados en la tabla cu_errores_mig       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		 RAZON				*/
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_vencimiento_mig')
    drop proc sp_vencimiento_mig
go
create proc sp_vencimiento_mig  (
   @s_ssn                          int          = NULL,
   @s_date                         datetime     = NULL,
   @s_user                         login        = NULL,
   @s_term                         descripcion  = NULL,
   @s_corr                         char(1)      = NULL,
   @s_ssn_corr                     int          = NULL,
   @s_ofi                          smallint     = NULL,
   @s_sesn                         int          = NULL,
   @t_rty                          char(1)      = NULL,
   @t_trn                          smallint     = NULL,
   @t_debug                        char(1)      = 'N',
   @t_file                         varchar(14)  = NULL,
   @t_from                         varchar(30)  = NULL,
   @i_formato_fecha                int          = NULL,
   @i_borrar                       char(1)      = "N",
   @i_em_archivo                   varchar(30)  = NULL,
   @i_datos_validos                char(1)      = NULL,
   @i_em_user                      login        = NULL,
   @i_garantia                     int          = NULL, 
   @i_tipo_cust                    descripcion  = NULL,
   @i_tipo_custfe                  descripcion  = NULL,
   @i_filial                       smallint     = NULL, 
   @i_sucursal                     smallint     = NULL, 
   @i_vencimiento                  smallint     = NULL, 
   @i_fecha                        varchar(20)  = NULL,
   @i_valor                        float        = NULL,  
   @i_instruccion                  varchar(255) = NULL,   
   @i_num_factura                  varchar(20)  = NULL, 
   @i_beneficiario                 varchar(64)  = NULL,
   @i_ente                         int          = NULL,
   @i_emisor                       varchar(64)  = NULL,
   @i_codigo_externo               varchar(64)  = NULL,
   @i_operacion                    char(1)      = NULL,
   @i_fecha_emision                varchar(20)  = NULL, --pga5jul2001    
   @o_total_vtos                   char(1)      = NULL out
)
as

declare
   @w_sp_name                   char(30),
   @w_msg                       varchar(255),
   @w_error                     char(1),
   @w_secuencia                 int,
   @w_moneda                    int,
   @w_contador                  int,
   @w_caracter                  char(1),
   @w_garantia                  int,
   @w_tipo_cust                 descripcion,
   @w_vencimiento               smallint, 
   @w_fecha                     datetime,
   @w_fecha_emision             datetime, -- pga5jul2001
   @w_dif                       int,      -- pga5jul2001
   @w_valor                     float,  
   @w_instruccion               varchar(255),   
   @w_num_factura               varchar(20),
   @w_beneficiario              varchar(64),
   @w_ente                      int,
   @w_emisor                    varchar(64), 
   @w_mes                       varchar(2),
   @w_dias                      varchar(2),
   @w_anio                      varchar(4),
   @w_codigo_externo            varchar(64),
   @w_string                    varchar(10)

select @w_sp_name = 'CARGA DE VENCIMIENTOS',
       @w_error = "N"

if (@t_trn <> 19912 and @i_operacion = 'S') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

 -- Borrar los errores generados en la primera corrida
 if @i_borrar = "S"
 begin
    delete cu_vencimiento_mig
     where vm_user = @s_user

    delete cu_error_mig
     where em_user = @s_user
       and em_sesn = @s_sesn
 end

 -- Verificar que los datos sean validos
    if @i_datos_validos = "N"
    begin
       select @w_msg = "Error en formato, Revise que los Datos sean 11 en cada linea y esten separados por coma"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user      = @s_user,
         @s_sesn      = @s_sesn,
         @s_date      = @s_date,
         @t_trn       = 19908,
         @i_msg       = @w_msg,
         @i_sp        = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I'
   
       -- Seleccionar los errores producidos hasta el momento
       select "NUMERO"    = em_num,
              "VENCIMIENTO" = em_secuencia, 
              "MENSAJE"   = em_msg, 
              "PROGRAMA"  = em_sp
         from cob_custodia..cu_error_mig
        where em_user = @s_user
          and em_date = @s_date
          and em_sesn = @s_sesn  
       return 0
    end  

-- Para cada uno de los parametros hacer las validaciones de tipo y consistencia
--valido el secuencial del ente
   if @i_vencimiento is null
   begin
       select @w_msg = "Un registro no tiene numero de vencimiento, Revise campo @i_vencimiento"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user      = @s_user,
         @s_sesn      = @s_sesn,
         @s_date      = @s_date,
         @t_trn       = 19908,
         @i_msg       = @w_msg,
         @i_sp        = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end

-- codigo cobis de la filial
   if @i_filial is null
   begin
       select @w_msg = "El codigo de la Filial es obligatorio. Revise el campo i_filial"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end

   if @i_filial is not null
   begin
    select @w_string = convert(char(10),@i_filial)
    if not exists (  select * from cobis..cl_filial where fi_filial = @i_filial)
    begin
       select @w_msg = "El codigo Cobis de la Filial "+  " " + @w_string + " no esta en el catalogo de Filial. Revise el campo i_filial"      
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end

-- codigo cobis de la sucursal
   if @i_sucursal is null
   begin
       select @w_msg = "El codigo de la Oficina es obligatorio. Revise el campo i_sucursal"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end

   if @i_sucursal is not null
   begin
       select @w_string = convert(char(10),@i_sucursal) 
      if not exists (  select * from cobis..cl_oficina where of_oficina= @i_sucursal)
    begin
       select @w_msg = "El codigo de la oficina es obligatorio" + " " + @w_string + " no esta en el catalogo de oficina. Revise el campo i_sucursal"      
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end

-- Validar que el tipo de garantia determinado sea igual al procesado 
if @i_tipo_cust <> @i_tipo_custfe
   begin
       select @w_msg = "El Tipo de Garantia " + @i_tipo_cust + " no es igual al definido para el Proceso " + @i_tipo_custfe + " Revise el campo i_sucursal"     
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end

-- valida tipo de garantia
   if @i_tipo_cust is null
   begin
       select @w_msg = "El Tipo de Garantia no esta definido. Revise el campo i_tipo_cust"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn    = 19908,
         @i_msg    = @w_msg,
         @i_sp     = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end

   if @i_tipo_cust is not null
   begin
      if not exists (  select * from cob_custodia..cu_tipo_custodia where tc_tipo = @i_tipo_cust)
    begin
       select @w_msg = "El Tipo de Garantia" + @i_tipo_cust + "no esta Definido. Revise el campo i_tipo_cust"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end


--consultar el codigo externo
   select
   @w_codigo_externo = cu_codigo_externo
   from cob_custodia..cu_custodia
   where 
   cu_filial   = @i_filial and
   cu_sucursal = @i_sucursal  and
   cu_tipo = @i_tipo_cust and
   cu_custodia = @i_garantia
   if @@rowcount = 0
   begin
    select @w_string = convert(char(10),@i_garantia)
    select @w_msg = "No existe Codigo Externo para el tipo y garantia" + " " + @i_tipo_cust + " " + @w_string + " dada en esta filial y oficina"
          exec cob_custodia..sp_cerror_mig
             @s_user   = @s_user,
             @s_sesn   = @s_sesn,
             @s_date   = @s_date,
             @t_trn       = 19908,
             @i_msg   = @w_msg,
             @i_sp = @w_sp_name,
             @i_secuencia = @i_vencimiento,
             @i_operacion = 'I' 
   end

-- pga 5jul2001   
-- verificar que el numero secuencial del vencimiento sea unico
     if exists( select * from cu_vencimiento_mig 
                 where vm_user        = @s_user 
                   and vm_sesn        = @s_sesn
                   and vm_vencimiento = @i_vencimiento
                   and vm_archivo     = @i_em_archivo
                   and vm_filial      = @i_filial
                   and vm_sucursal    = @i_sucursal
	           and vm_codigo_externo = @w_codigo_externo )
   begin
       select @w_msg = "Un numero de vencimiento debe ser unico, Revise campo @i_vencimiento"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user      = @s_user,
         @s_sesn      = @s_sesn,
         @s_date      = @s_date,
         @t_trn       = 19908,
         @i_msg       = @w_msg,
         @i_sp        = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end
-- pga 5jul2001


--fecha de vencimiento
if @i_fecha is not null
   begin 
      select @w_caracter = substring(@i_fecha,1,1),
            @w_contador = 1
      while @w_caracter is not null 
      begin 
         if not ((@w_caracter between '0' and '9') or @w_caracter = "/")
         begin  
            select @w_msg = "La Fecha de Vencimiento " + @i_fecha + "no es valida. Revise el campo i_fecha"
            select @w_error = "S"
            exec cob_custodia..sp_cerror_mig
               @s_user   = @s_user,
               @s_sesn   = @s_sesn,
               @s_date   = @s_date,
               @t_trn       = 19908,
               @i_msg   = @w_msg,
               @i_sp = @w_sp_name,
               @i_secuencia = @i_vencimiento,
               @i_operacion = 'I' 
            break
          end
         else
         begin
            select @w_contador = @w_contador + 1
            select @w_caracter = substring(@i_fecha,@w_contador,1)
          end
      end 

end
  select @w_mes = substring(@i_fecha,1,2)

  select @w_dias = substring(@i_fecha,4,5)
  select @w_anio = substring(@i_fecha,7,10)

  if @w_caracter is null
   begin 
      if not (convert(int,@w_mes) between 1 and 12)
      begin
         select @w_msg = "La Fecha de vencimiento " + @i_fecha + "no es v lida. Revise el mes del campo i_fecha"
         select @w_error = "S"
         exec cob_custodia..sp_cerror_mig
            @s_user   = @s_user,
            @s_sesn   = @s_sesn,
            @s_date   = @s_date,
            @t_trn       = 19908,
            @i_msg   = @w_msg,
            @i_sp = @w_sp_name,
            @i_secuencia = @i_vencimiento,
            @i_operacion = 'I' 
      end
      else
      begin 
         if not (convert(int,@w_dias) between 1 and 31)
         begin
            select @w_msg = "La Fecha de Vencimiento " + @i_fecha + "no es v lida. Revise el dia del campo i_fecha"
            select @w_error = "S"
            exec cob_custodia..sp_cerror_mig
               @s_user   = @s_user,
               @s_sesn   = @s_sesn,
               @s_date   = @s_date,
               @t_trn       = 19908,
               @i_msg   = @w_msg,
               @i_sp = @w_sp_name,
               @i_secuencia = @i_vencimiento,
               @i_operacion = 'I' 
         end
         else
         begin
           if (convert(int,@w_anio) < 1752)
            begin
               select @w_msg = "La Fecha de vencimiento " + @i_fecha + " no es v lida. Revise el a¤o del campo i_fecha"
               select @w_error = "S"
               exec cob_custodia..sp_cerror_mig
                  @s_user   = @s_user,
                  @s_sesn   = @s_sesn,
                  @s_date   = @s_date,
                  @t_trn       = 19908,
                  @i_msg   = @w_msg,
                  @i_sp = @w_sp_name,
                  @i_secuencia = @i_vencimiento,
                  @i_operacion = 'I' 
            end
            else 
               select @w_fecha= convert(datetime,@i_fecha)   
         end--emg
  end 
  end 


-- pga5jul2001 fecha de emision
if @i_fecha_emision is not null
   begin 
      select @w_caracter = substring(@i_fecha_emision,1,1),
            @w_contador = 1
      while @w_caracter is not null 
      begin 
         if not ((@w_caracter between '0' and '9') or @w_caracter = "/")
         begin  
            select @w_msg = "La Fecha de Emision " + @i_fecha_emision + "no es valida. Revise el campo i_fecha_emision"
            select @w_error = "S"
            exec cob_custodia..sp_cerror_mig
               @s_user   = @s_user,
               @s_sesn   = @s_sesn,
               @s_date   = @s_date,
               @t_trn       = 19908,
               @i_msg   = @w_msg,
               @i_sp = @w_sp_name,
               @i_secuencia = @i_vencimiento,
               @i_operacion = 'I' 
            break
          end
         else
         begin
            select @w_contador = @w_contador + 1
            select @w_caracter = substring(@i_fecha_emision,@w_contador,1)
          end
      end 

end
  select @w_mes = substring(@i_fecha_emision,1,2)

  select @w_dias = substring(@i_fecha_emision,4,5)
  select @w_anio = substring(@i_fecha_emision,7,10)

  if @w_caracter is null
   begin 
      if not (convert(int,@w_mes) between 1 and 12)
      begin
         select @w_msg = "La Fecha de emision " + @i_fecha_emision + "no es v lida. Revise el mes del campo i_fecha_emision"
         select @w_error = "S"
         exec cob_custodia..sp_cerror_mig
            @s_user   = @s_user,
            @s_sesn   = @s_sesn,
            @s_date   = @s_date,
            @t_trn    = 19908,
            @i_msg    = @w_msg,
            @i_sp     = @w_sp_name,
            @i_secuencia = @i_vencimiento,
            @i_operacion = 'I' 
      end
      else
      begin 
         if not (convert(int,@w_dias) between 1 and 31)
         begin
            select @w_msg = "La Fecha de emision " + @i_fecha_emision + "no es v lida. Revise el dia del campo i_fecha_emision"
            select @w_error = "S"
            exec cob_custodia..sp_cerror_mig
               @s_user   = @s_user,
               @s_sesn   = @s_sesn,
               @s_date   = @s_date,
               @t_trn       = 19908,
               @i_msg   = @w_msg,
               @i_sp = @w_sp_name,
               @i_secuencia = @i_vencimiento,
               @i_operacion = 'I' 
         end
         else
         begin
           if (convert(int,@w_anio) < 1752)
            begin
               select @w_msg = "La Fecha de emision " + @i_fecha_emision + " no es v lida. Revise el a¤o del campo i_fecha_emision"
               select @w_error = "S"
               exec cob_custodia..sp_cerror_mig
                  @s_user   = @s_user,
                  @s_sesn   = @s_sesn,
                  @s_date   = @s_date,
                  @t_trn       = 19908,
                  @i_msg   = @w_msg,
                  @i_sp = @w_sp_name,
                  @i_secuencia = @i_vencimiento,
                  @i_operacion = 'I' 
            end
            else 
               select @w_fecha_emision= convert(datetime,@i_fecha_emision)   
         end
  end 
  end 

-- valido que la fecha de emision sea menor que la fecha de vencimiento
if ( (@w_fecha_emision is not null) and (@w_fecha is not null))
begin 
   select @w_dif = 0
   select @w_dif = datediff(dd, @w_fecha_emision, @w_fecha)
   if @w_dif <= 0 
   begin
      select @w_msg = "La Fecha de emision " + @i_fecha_emision + " es mayor que la Fecha de vencimiento. Revise los campos i_fecha e i_fecha_emision"
      select @w_error = "S"
      exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn    = 19908,
         @i_msg    = @w_msg,
         @i_sp     = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end 
end
-- pga5jul2001 fecha de emision




--Validar la existencia del Aceptante en tabla mis
-- codigo cobis del Aceptante
   if @i_ente is null
   begin
       select @w_msg = "El codigo del Aceptante es obligatorio. Revise el campo i_ente"
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
   end
   if @i_ente is not null
   begin
      select @w_string = convert(char(10),@i_ente)
      if not exists (  select * from cobis..cl_ente where en_ente = @i_ente)
    begin
       select @w_msg = "El codigo del Aceptante " + @w_string + " no esta en Cobis. Revise el campo i_ente"      
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end


--Validar la existencia de la garantia 
   if @i_garantia is not null
   begin
      if not exists (  select * from cob_custodia..cu_custodia where cu_custodia = @i_garantia)
    begin
       select @w_string = convert(char(10),@i_garantia)
       select @w_msg = "El codigo de la Garantia " + @w_string + " no existe . Revise el campo i_garantia"      
       select @w_error = "S"
       exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end


--Validar que exista garantia para el tipo  de custodia
   if @i_garantia is not null and @i_tipo_cust is not null 
   begin
    if not exists (select * from cob_custodia..cu_custodia 
     where cu_custodia = @i_garantia and cu_tipo = @i_tipo_cust)
    begin
      select @w_string = convert(char(10),@i_garantia)
      select @w_msg = "El codigo de la Garantia " + @w_string + " no existe para el tipo " + @i_tipo_cust + " Indicado. Revise el campo i_garantia"      
      select @w_error = "S"
      exec cob_custodia..sp_cerror_mig
         @s_user   = @s_user,
         @s_sesn   = @s_sesn,
         @s_date   = @s_date,
         @t_trn       = 19908,
         @i_msg   = @w_msg,
         @i_sp = @w_sp_name,
         @i_secuencia = @i_vencimiento,
         @i_operacion = 'I' 
    end
 end




-- Insertar el dato siempre y cuando no haya errores.
 if @w_error = "N"
 begin
    insert into cu_vencimiento_mig ( 
        vm_user, vm_sesn, vm_archivo, vm_filial, vm_sucursal, 
	vm_tipo_cust, vm_custodia, vm_vencimiento, vm_fecha, 
	vm_valor, vm_instruccion, vm_sujeto_cobro, vm_num_factura,
	vm_cta_debito, vm_mora, vm_comision, vm_codigo_externo, 
	vm_estado_colateral, vm_fecha_salida, vm_fecha_retorno, 
	vm_destino_colateral,vm_segmento, vm_procesado, vm_cotizacion, 
	vm_beneficiario,vm_emisor, vm_fecha_emision, vm_tasa, vm_ente
        )
    values (
        @s_user, @s_sesn, @i_em_archivo, @i_filial, 
        @i_sucursal, @i_tipo_cust, @i_garantia, @i_vencimiento, @w_fecha, --pag5jul2001@i_fecha, 
	@i_valor, @i_instruccion, NULL, @i_num_factura,
        NULL, NULL, NULL, @w_codigo_externo,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        @i_beneficiario, @i_emisor, @w_fecha_emision, NULL, @i_ente         
       )
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
 end


 -- Seleccionar los errores producidos
 select "NUMERO"    = em_num,
        "VENCIMIENTO" = em_secuencia, 
        "MENSAJE"   = em_msg, 
        "PROGRAMA"  = em_sp
   from cob_custodia..cu_error_mig
  where em_user = @s_user
    and em_date = @s_date
    and em_sesn = @s_sesn  

return 0
go
