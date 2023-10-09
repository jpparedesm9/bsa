/************************************************************************/
/*	Archivo: 		realianz.sp                                         */
/*	Stored procedure: 	sp_consulta_alianza                             */
/*	Base de datos:  	cob_remesas                                     */
/*	Producto:               cob_ahorros                                 */
/*	Disenado por:           Julissa Colorado                            */
/*	Fecha de escritura:     18-Mar-2013                                 */
/************************************************************************/
/*				IMPORTANTE                                              */
/*	Este programa es parte de los paquetes bancarios propiedad de       */
/*	'MACOSA', representantes exclusivos para el Ecuador de la           */
/*	'NCR CORPORATION'.                                                  */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier alteracion o agregado hecho por alguno de sus	            */
/*	usuarios sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*				PROPOSITO                                               */
/*	Este programa realiza las consultas para alianza cormeciales 	    */
/*      de los archivos procesados.                                     */
/************************************************************************/
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON			                            */
/*	18/Mar/2013	J. Colorado	Emision inicial	                            */
/************************************************************************/
use cob_remesas
go

if exists (select 1 from sysobjects where name = 'sp_consulta_alianza')
	drop proc sp_consulta_alianza

go
create proc sp_consulta_alianza (
	@s_ssn                int=null, 
	@s_srv                varchar(30)=null,
	@s_user               varchar(30)=null,
	@s_sesn               int=null,
	@s_term               varchar(10)=null,
	@s_date               datetime=null,
	@s_ofi                smallint=null,    /* Localidad origen transaccion */
	@s_rol                smallint=null,
	@s_org_err            char(1) = null, /* Origen de error:[A], [S] */
	@s_error              int = null,
	@s_org		          char(1)=null,
	@s_msg                mensaje = null,
	@t_debug              char(1) = 'N',
	@t_file               varchar(14) = null,
	@t_from               varchar(32) = null,
	@t_rty                char(1) = 'N',
	@t_trn                smallint=null, 
     @t_show_version bit    = 0,
    @i_opcion	          char(1),
	@i_nombre             descripcion = null,
    @i_codigo_arch        int = null, 
	@i_cliente	          int = null,
	@i_tipo_ident         varchar(2) = null,
    @i_identificacion     varchar(20)= null, 
    @i_fecha              datetime,
    @i_secuencial         int = 0,
    @i_modo               tinyint = 0
	)
as
declare @w_usadeci              char(1),
	    @w_sp_name	            varchar(30),      
        @w_transferencia        money,
        @w_registros            int,
        @w_procesados           money, 
        @w_cont_procesados      int,
        @w_rechazados           money,
        @w_cont_rechazado       int,
        @w_estructura           money,
        @w_cont_estruct         int,
        @w_sec_archivo          money ,
        @w_cuenta               varchar(16),
        @w_mensaje              varchar(254),
        @w_concepto             varchar(254),
        @w_ce_ruc_pas           varchar(20),
        @w_tipo_iden            varchar(2),
        @w_nombre_completo_DE   varchar(256)


-- Captura nombre de Stored Procedure
select	@w_sp_name = 'sp_consulta_alianza'


       if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end


If @i_opcion = 'A'
Begin 


   set rowcount 20
   if @i_modo = 0

       select 'Nombre de Archivo'   = ar_archivo,
              'Secuencial       '   = ar_secuencial,
              'Tipo'                = ar_tipo_ident,
              'Indent'              = ar_identificacion 
         from  cob_remesas..re_archivo_alianza
        where ar_tipo_ident      = @i_tipo_ident
          and ar_identificacion  = @i_identificacion
          and ar_fecha           = @i_fecha
        order by ar_secuencial

  else
       select 'Nombre de Archivo'   = ar_archivo,
              'Secuencial       '   = ar_secuencial,
              'Tipo'                = ar_tipo_ident,
              'Indent'              = ar_identificacion
        from   cob_remesas..re_archivo_alianza
       where   ar_tipo_ident      = @i_tipo_ident
         and   ar_identificacion  = @i_identificacion
         and   ar_fecha       = @i_fecha
         and   ar_secuencial  > @i_secuencial
      order by ar_secuencial

  set rowcount 0

end 


If @i_opcion = 'T'
Begin 

   set rowcount 20
   if @i_modo = 0

       select 'Nombre de Archivo'   = ar_archivo,
              'Secuencial       '   = ar_secuencial,
              'Tipo'                = ar_tipo_ident,
              'Indent'              = ar_identificacion 
         from  cob_remesas..re_archivo_alianza
        where ar_fecha           = @i_fecha
        order by ar_secuencial

  else
       select 'Nombre de Archivo'   = ar_archivo,
              'Secuencial       '   = ar_secuencial,
              'Tipo'                = ar_tipo_ident,
              'Indent'              = ar_identificacion 
        from   cob_remesas..re_archivo_alianza
       where   ar_fecha       = @i_fecha
         and   ar_secuencial  > @i_secuencial
      order by ar_secuencial

  set rowcount 0

end 




If @i_opcion = 'C'
Begin 


   select @w_transferencia = ar_valor
     from cob_remesas..re_archivo_alianza
    where  ar_tipo_ident      = @i_tipo_ident
      and  ar_identificacion  = @i_identificacion
      and  ar_fecha           = @i_fecha
      and  ar_secuencial      = @i_codigo_arch


   select @w_registros = ar_regitros
     from cob_remesas..re_archivo_alianza
    where ar_tipo_ident      = @i_tipo_ident
      and ar_identificacion  = @i_identificacion
      and ar_fecha           = @i_fecha
      and ar_secuencial      = @i_codigo_arch
   
   select @w_procesados      = isnull(ar_monto_procesados,0), 
          @w_cont_procesados = isnull(ar_procesados, 0)
      from cob_remesas..re_archivo_alianza
    where ar_tipo_ident      = @i_tipo_ident
      and ar_identificacion  = @i_identificacion
      and ar_fecha           = @i_fecha
      and ar_secuencial      =  @i_codigo_arch


   select @w_rechazados     = isnull(ar_monto_error,0),
          @w_cont_rechazado = isnull(ar_error,0)
     from cob_remesas..re_archivo_alianza
    where ar_tipo_ident      = @i_tipo_ident
      and ar_identificacion  = @i_identificacion
      and ar_fecha           = @i_fecha
      and ar_secuencial      =  @i_codigo_arch



  select @w_cuenta   = ct_cuenta,
         @w_mensaje  = isnull(ct_mensaje, ''),
         @w_concepto = ar_concepto 
    from cob_remesas_his..re_cabecera_transfer_his,
         cob_remesas..re_archivo_alianza
   where ct_secuencial  = @i_codigo_arch
     and ct_fecha       = @i_fecha
     and ar_secuencial  = ct_secuencial
     and ar_fecha       = ct_fecha 

  Select  @w_transferencia,
          @w_registros,
          @w_procesados, 
          @w_cont_procesados,
          @w_rechazados,
          @w_cont_rechazado,
          @w_cuenta,
          @w_mensaje,
          @w_concepto
          
   
END


if @i_opcion = 'E' 
Begin 


     select 
           @w_ce_ruc_pas  = case en_ced_ruc
                            when '' then p_pasaporte
                            else isnull(en_ced_ruc,p_pasaporte)
                            end,
           @w_tipo_iden  = en_tipo_ced,
           @w_nombre_completo_DE = en_nomlar
      
      from cobis..cl_ente
      where en_ente = @i_cliente   

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror 
              /*error, no existe cliente */
              @t_debug      = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 101042 
         return 1
      end

      select @w_ce_ruc_pas,
             @w_tipo_iden,
             @w_nombre_completo_DE        
          
END


/*

if @i_opcion = 'D' 
Begin 

 

   set rowcount 20
   if @i_modo = 0
   
        select 'SECUENCIAL'     = dt_secuencial,
               'MOVIMIENTO'     = dt_signo,
               'IDENTIFICACION' = dt_identificacion,
               'CUENTA'         = dt_cuenta,
               'VALOR'          = dt_valor, 
               'MOTIVO'         = dt_mensaje
         from cob_remesas_his.. re_detalle_transfer_his
        where dt_codigo         = @i_codigo_arch
          and dt_fecha          = @i_fecha  
          and dt_estado         = 'E'
        order by dt_secuencial 
  else
        select 'SECUENCIAL'     = dt_secuencial,
               'MOVIMIENTO'     = dt_signo,
               'IDENTIFICACION' = dt_identificacion,
               'CUENTA'         = dt_cuenta,
               'VALOR'          = dt_valor, 
               'MOTIVO'         = dt_mensaje
         from cob_remesas_his.. re_detalle_transfer_his
        where dt_codigo      =  @i_codigo_arch
          and dt_fecha       = @i_fecha  
          and dt_estado     = 'E'
          and dt_secuencial > @i_secuencial
        order by dt_secuencial 

    set rowcount 0
end
*/


if @i_opcion = 'I'
Begin 

   set rowcount 20
   if @i_modo = 0
   
        select 'SECUENCIAL'     = dt_secuencial,
               'MOVIMIENTO'     = dt_signo,
               'IDENTIFICACION' = dt_identificacion,
               'CUENTA'         = dt_cuenta,
               'VALOR'          = dt_valor, 
               'MOTIVO'         = dt_mensaje
         from cob_remesas_his.. re_detalle_transfer_his
        where dt_codigo      =  @i_codigo_arch
          and dt_fecha       = @i_fecha          
        order by dt_secuencial 
  else
        select 'SECUENCIAL'     = dt_secuencial,
               'MOVIMIENTO'     = dt_signo,
               'IDENTIFICACION' = dt_identificacion,
               'CUENTA'         = dt_cuenta,
               'VALOR'          = dt_valor, 
               'MOTIVO'         = dt_mensaje
         from cob_remesas_his.. re_detalle_transfer_his
        where dt_codigo      =  @i_codigo_arch
          and dt_fecha       = @i_fecha  
          and dt_secuencial  > @i_secuencial
        order by dt_secuencial 

    set rowcount 0


end

return 0
go

