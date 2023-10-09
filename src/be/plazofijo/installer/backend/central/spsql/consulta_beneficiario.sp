/************************************************************************/
/*      Archivo:                consben.sp                              */
/*      Stored procedure:       sp_consulta_beneficiario                */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 29/Ago/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa la consulta de los Beneficiarios de una   */
/*      operacion especifica, en la tabla pf_beneficiariodos.           */
/*                                                                      */
/*                                                                      */
/*      24-May-2005        N. Silva            Indentaciones y cambios  */
/*      01-Dic-2005        R Garcia            Ajustes para Firmas      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_beneficiario')
   drop proc sp_consulta_beneficiario 
go

create proc sp_consulta_beneficiario (   
@s_ssn                  int         = null,
@s_user                 login       = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint    = null,
@i_operacion            char(1),
@i_tipo                 char(1),
@i_modo                 smallint    = null,
@i_codigo               int         = null,    
@i_num_banco            cuenta,
@i_tipo_beneficiario    char(1)     = 'T',
@i_nombre_beneficiario  descripcion = null
)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_operacionpf          int,
@w_num_ben              smallint

select @w_sp_name = 'sp_consulta_beneficiario', 
       @w_num_ben = 0

/*---------------------------------*/
/* Verificar Codigo de transaccion */
/*---------------------------------*/
if (@t_trn <> 14438 or @i_operacion <> 'H')
begin
  exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 141112
  return 141112
end

----------------------------------------------
-- Busqueda de codigo secuencial de operacion
----------------------------------------------
select @w_operacionpf  = op_operacion
  from pf_operacion
 where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
  exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
  return 141051
end

select @w_num_ben = isnull(count(*), 0)
  from pf_beneficiario
 where be_operacion = @w_operacionpf
   and be_tipo = @i_tipo_beneficiario
-------------------------------------------------
-- Proceso de busqueda para ayudas tipo catalogo
-------------------------------------------------
If @i_operacion = 'H'
begin

   ---------------------------------------   
   -- Proceso para eleccion tipo catalogo
   ---------------------------------------
   if @i_tipo = 'A'
   begin
      set rowcount 20
      if @w_num_ben <= 0
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
            /* Extrae los primeros veinte tipos de plazo */
            select 'BENEFICIARIO'  = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                     end,
                   'COD.'     	   = be_ente
              from pf_beneficiario,cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
               and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                    end,
                   'COD.'         = be_ente       
              from pf_beneficiario,cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente  
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
	       and be_ente > @i_codigo
             order by be_secuencia
         end
      end
      else
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
            /* Extrae los primeros veinte tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end,
                   'COD.'     	   = be_ente
              from pf_beneficiario,cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end,
                   'COD.'         = be_ente       
              from pf_beneficiario,cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente  
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
               and be_ente > @i_codigo
             order by be_secuencia
         end
      end
      set rowcount 0 
      return 0   
   end

   ---------------------------------------   
   -- Proceso para eleccion tipo catalogo
   ---------------------------------------
   if @i_tipo = 'B'
   begin
      set rowcount 20
      if @w_num_ben <= 0
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
            /* Extrae los primeros veinte tipos de plazo */
            select 'BENEFICIARIO'  = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                     end,
                   'COD.'     	   = be_ente
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
               and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
               and en_nomlar like @i_nombre_beneficiario
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                    end,
                   'COD.'         = be_ente       
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente  
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
	       and be_ente > @i_codigo
               and en_nomlar like @i_nombre_beneficiario
             order by be_secuencia
         end
      end
      else
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
            /* Extrae los primeros veinte tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end,
                   'COD.'     	   = be_ente
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
               and en_nomlar like @i_nombre_beneficiario
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
            select 'BENEFICIARIO' = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end,
                   'COD.'         = be_ente       
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente  
	       and be_estado_xren = 'N'
               and be_tipo = @i_tipo_beneficiario
               and be_ente > @i_codigo
               and en_nomlar like @i_nombre_beneficiario
             order by be_secuencia
         end
      end
      set rowcount 0 
      return 0   
   end


   --------------------------------------------------------
   -- Proceso adicional de consultas para modulo de firmas
   --------------------------------------------------------
   if @i_tipo = 'F'
   begin
      set rowcount 20
      if @w_num_ben <= 0
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
             select 'Codigo'         = be_ente,
                    'Identificacion' = en_ced_ruc,
                    'Id'             = '',
                    'BENEFICIARIO'   = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                       else en_nomlar
                                       end,
                    'Rol'            = be_tipo,
                    'Tipo'           = en_subtipo
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
               and be_estado_xren = 'N'
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
             select 'Codigo'         = be_ente,
                    'Identificacion' = en_ced_ruc,
                    'Id'             = '',
                    'BENEFICIARIO'   = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                     end,
                    'Rol'            = be_tipo,
                    'Tipo'           = en_subtipo
              from pf_beneficiario,
                   cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente  
	       and be_estado_xren = 'N'
	       and be_ente > @i_codigo
             order by be_secuencia
         end
      end
      else
      begin

         -----------------------------
         -- Proceso para boton Buscar
         -----------------------------
         if @i_modo = 0
         begin
             select 'Codigo'         = be_ente,
                    'Identificacion' = en_ced_ruc,
                    'Id'             = '',
                    'BENEFICIARIO'   = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                      end,
                    'Rol'            = be_tipo,
                    'Tipo'           = en_subtipo
              from pf_beneficiario,cobis..cl_ente
  	     where be_operacion = @w_operacionpf
	       and be_ente = en_ente   
	       and be_estado_xren = 'N'
             order by be_secuencia
         end

         ---------------------------------
         -- Proceso para boton Siguientes
         ---------------------------------
         if @i_modo = 1
         begin
            /* Extrae los siguientes 20 tipos de plazo */
             select 'Codigo'         = be_ente,
                    'Identificacion' = en_ced_ruc,
                    'Id'             = '',
                    'BENEFICIARIO'   = case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                       else en_nomlar
                                       end,
                    'Rol'            = be_tipo,
                    'Tipo'           = en_subtipo
              from pf_beneficiario,cobis..cl_ente
  	          where be_operacion = @w_operacionpf
	            and be_ente = en_ente  
	            and be_estado_xren = 'N'
                and be_ente > @i_codigo
              order by be_secuencia
         end
      end
   end

   --------------------------------------
   -- Mapeo de datos por lotes a un grid
   --------------------------------------   
   if @i_tipo = 'V'
   begin
      if @w_num_ben <= 0
      begin
         select case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end
           from  pf_beneficiario,cobis..cl_ente
          where be_operacion = @w_operacionpf
            and be_ente = en_ente  
            and be_ente = @i_codigo
	    and be_estado_xren = 'N'
            and be_tipo = @i_tipo_beneficiario
          order by be_secuencia
         if @@rowcount = 0
         begin
	    exec cobis..sp_cerror
	         @t_debug        = @t_debug,
		 @t_file         = @t_file,
  		 @t_from         = @w_sp_name,
	  	 @i_num          = 141130
            return 141130
         end
      end
      else 
      begin
         select case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else en_nomlar
                                end
  	   from  pf_beneficiario,cobis..cl_ente
	  where be_operacion = @w_operacionpf
	    and be_ente = en_ente  
  	    and be_ente = @i_codigo
	    and be_estado_xren = 'N'
            and be_tipo = @i_tipo_beneficiario
          order by be_secuencia

         if @@rowcount = 0
         begin
	    exec cobis..sp_cerror
	         @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 141130
            return 1
         end
      end
      return 0
   end         
end	
go

