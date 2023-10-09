/************************************************************************/
/*      Archivo:                renben.sp                               */
/*      Stored procedure:       sp_consulta_benef                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 06/Sep/95                               */
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
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_benef')
   drop proc sp_consulta_benef 
go

create proc sp_consulta_benef (   
@s_ssn                  int = null,
@s_user                 login = null,
@s_term                 varchar(30) = null,
@s_date                 datetime = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint = null,
@s_rol                  smallint = NULL,
@t_debug                char(1) = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint = null,
@i_operacion            char(1) = 'H',
@i_tipo                 char(1) = 'A',
@i_modo                 smallint = null,
@i_codigo               int = null,    
@i_num_banco            cuenta,
@i_tipo_beneficiario    char(1) = 'T',
@i_tipo_renovacion      char(2) = null
)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_operacionpf		    int,
@w_fecha_ven		    datetime

select @w_sp_name = 'sp_consulta_benef' 


if   (@t_trn <> 14637 or @i_operacion <> 'H')

begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 1
end

select  @w_operacionpf  = op_operacion,
	@w_fecha_ven = op_fecha_ven        
from pf_operacion
where op_num_banco = @i_num_banco


if @@rowcount = 0

   begin
     exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
     return 1

   end

If @i_operacion = 'H'
begin

 if @i_tipo = 'A'
   begin
     set rowcount 20
     if @i_modo = 0
     begin
        /* Extrae los primeros veinte beneficiarios  */
        select 	'ROL'	=	be_rol, 
                'CLIENTE'=	be_ente,
	        'NOMBRE'=       case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else isnull(en_nomlar,en_nombre)
                                end,
                'CEDULA'=	en_ced_ruc,
                'SUBTIPO'=      en_subtipo, --GAR GB-DP00129
                'CONDICION'=    be_condicion,
                'SECUENCIA' =   be_secuencia
        from pf_beneficiario,cobis..cl_ente
	where be_operacion = @w_operacionpf
          and be_ente = en_ente   
          and be_estado <> 'E'
          and be_tipo = @i_tipo_beneficiario
          and be_estado_xren = 'N'
        order by be_secuencia --I.1220 CVA Set-03-05 desc

      end

     if @i_modo = 1
      begin
         select 	'ROL'=		be_rol,
                'CLIENTE'=	be_ente,      
	        'NOMBRE'=       case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else isnull(en_nomlar,en_nombre)
                                end,
                'CEDULA'=	en_ced_ruc,
                'SUBTIPO'=      en_subtipo, --GAR GB-DP00129    
                'CONDICION'=    be_condicion,
                'SECUENCIA' =   be_secuencia
         from pf_beneficiario,cobis..cl_ente
	 where be_operacion = @w_operacionpf
           and be_ente = en_ente  
           and be_estado <> 'E'
           and be_tipo = @i_tipo_beneficiario
           and be_estado_xren = 'N'
           and be_ente > @i_codigo
        order by be_secuencia --I.1220 CVA Set-03-05 desc 
      end
 set rowcount 0 
   return 0   

 end
   
 if @i_tipo = 'V'
 begin
       select  p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre
	from  pf_beneficiario,cobis..cl_ente
	where be_operacion = @w_operacionpf
		and be_ente = en_ente  
		and be_ente = @i_codigo
                and be_tipo = @i_tipo_beneficiario

   
      if @@rowcount = 0
      begin
	 exec cobis..sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 141130
		/* 'No existe dato solicitado ' */
	  return 1
      end


   return 0
  end      


 if @i_tipo = 'F'
   begin
     set rowcount 20
     if @i_modo = 0
     begin
        /* Extrae los primeros veinte beneficiarios  */
        select 	'CODIGO'        = be_ente,
                'IDENTIFICACION'= en_ced_ruc,
                'ID'            = ' ',
	        'NOMBRE'        = isnull(en_nomlar,en_nombre),
                'ROL'           = be_tipo,
                'TIPO'       = en_subtipo
        from pf_beneficiario,cobis..cl_ente
	where be_operacion = @w_operacionpf
          and be_ente = en_ente   
          and be_estado <> 'E'
          --*-* REQ FIRMAS 12-02-2005 and be_tipo = @i_tipo_beneficiario
          and be_estado_xren = 'N'
        order by be_secuencia --I.1220 CVA Set-03-05 desc
      end

     if @i_modo = 1
      begin
         select 'CODIGO'        = be_ente,
                'IDENTIFICACION'= en_ced_ruc,
                'ID'            = ' ',
	        'NOMBRE'        = isnull(en_nomlar,en_nombre),
                'ROL'           = be_tipo,
                'TIPO'       = en_subtipo
         from pf_beneficiario,cobis..cl_ente
	 where be_operacion = @w_operacionpf
           and be_ente = en_ente  
           and be_estado <> 'E'
           --*-* REQ FIRMAS 12-02-2005 and be_tipo = @i_tipo_beneficiario
           and be_estado_xren = 'N'
           and be_ente > @i_codigo
        order by be_secuencia --I.1220 CVA Set-03-05 desc 
      end
 set rowcount 0 
   return 0   

 end   

 if @i_tipo = 'R'
   begin
     set rowcount 0
     if @i_tipo_renovacion = 'IR'
     begin
        /* Extrae los beneficiarios  */
      select 'NOMBRE' = isnull(en_nomlar,en_nombre),
      	     'CONDICION' = be_condicion
        from pf_beneficiario,cobis..cl_ente
	where be_operacion = @w_operacionpf
          and be_ente = en_ente   
          and be_estado = 'I'
          and be_tipo = 'T'
          and be_estado_xren = 'S'
        order by be_secuencia 

        /* Extrae las firmas autorizantes */
       select 'NOMBRE' = isnull(en_nomlar,en_nombre),
       	      'CONDICION' = be_condicion
           from pf_beneficiario,cobis..cl_ente
 	  where be_operacion = @w_operacionpf
            and be_ente = en_ente  
            and be_estado = 'I'
            and be_tipo = 'F'
            and be_estado_xren = 'S'
         order by be_secuencia 

      end

      else
       begin
        /* Extrae los beneficiarios  */
	      	select 'NOMBRE' = isnull(en_nomlar,en_nombre),
	       	       'CONDICION' = be_condicion
	          from pf_beneficiario,cobis..cl_ente
		 where be_operacion = @w_operacionpf
	           and be_ente = en_ente   
	           and be_estado = 'I'
	           and be_tipo = 'T'
	           and be_estado_xren = 'N'
 	         order by be_secuencia 

	        /* Extrae las firmas autorizantes */
	         select 'NOMBRE' = isnull(en_nomlar,en_nombre),
	       	        'CONDICION' = be_condicion
	           from pf_beneficiario,cobis..cl_ente
	 	  where be_operacion = @w_operacionpf
	            and be_ente = en_ente  
	            and be_estado = 'I'
	            and be_tipo = 'F'
	            and be_estado_xren = 'N'
	         order by be_secuencia 
       end
 set rowcount 0 
   return 0   

 end



end
		
go
