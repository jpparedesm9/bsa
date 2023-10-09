/************************************************************************/
/*  Archivo:                sp_sincroniza_mobil.sp                      */
/*  Stored procedure:       sp_sincroniza_mobil                         */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 02/Ago/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Permite realizar el mantenimiento de los dispositivos móviles,       */
/* Insertar, actualizar, eliminar y consultar                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  02/Ago/2017 P. Ortiz             Emision Inicial                    */
/*  29/Ago/2017 P. Ortiz             Refactor Dispositivos Moviles      */
/*  30/Ago/2017 P. Ortiz             Refactor Dispositivos Moviles      */
/*  08/Sep/2017 P. Ortiz             Corregir extracción de Login       */
/*  20/Jun/2018 ACHP                 Validación por estado y usuario    */
/* **********************************************************************/

use cob_sincroniza
go

IF OBJECT_ID ('dbo.sp_sincroniza_mobil') IS NOT NULL
	DROP PROCEDURE dbo.sp_sincroniza_mobil
GO

create proc sp_sincroniza_mobil (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1),
   @i_codigo          int         = null,
   @i_tipo            varchar(10) = null,
   @i_imei            varchar(45) = null,
   @i_macaddress      varchar(60) = null,
   @i_oficial         varchar(10) = null,
   @i_login           login       = null,
   @i_estado          char(1)     = null,
   @i_alias			  varchar(45) = null,
   @i_fecha_reg       datetime    = null,
   @i_permite_matri	  char(1)	  = null,
   @o_codigo          int         = null  output
)as
declare 
   @w_ts_name         varchar(32),
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_codigo          int,
   @w_tipo            varchar(10),
   @w_imei            varchar(45),
   @w_macaddress      varchar(60),
   @w_oficial         varchar(10),
   @w_funcionario     varchar(10),
   @w_estado          char(1),
   @w_alias			  varchar(45),
   @w_login           login,
   @w_mensaje         varchar(132),
   @w_permite_mat	  char(1)
   
select @w_sp_name = 'sp_sincroniza_mobil'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1713 and @i_operacion = 'I') or
    (@t_trn <> 1714 and @i_operacion = 'U') or
    (@t_trn <> 1715 and @i_operacion = 'D') or
    (@t_trn <> 1716 and (@i_operacion = 'S' or @i_operacion = 'Q')) or
	(@t_trn <> 1717 and @i_operacion = 'F'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end

if @i_operacion = 'I'
begin
    begin tran
    exec @w_num_error = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'si_dispositivo',
        @o_siguiente = @w_codigo out
        
    select @o_codigo = @w_codigo
        

        if @w_num_error <> 0
        begin
            select @w_num_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
            goto errores
        end
    
    --Extraigo la fecha de proceso
    SELECT @i_fecha_reg = fp_fecha FROM cobis..ba_fecha_proceso
    
    --Extraigo el Login del Oficial
    select @i_login = fu_login from cobis..cl_funcionario 
    WHERE fu_funcionario = (SELECT oc_funcionario FROM cobis..cc_oficial WHERE oc_oficial = @i_oficial)
	
    --Se comenta hasta avisar a las personas del banco que se va limpiar las bases
    /*
    if exists (SELECT top 1 1 FROM cob_sincroniza..si_dispositivo
			WHERE di_oficial = @i_oficial AND di_estado <> 'L')
	BEGIN
		select @w_num_error = 2109105 --EL OFICIAL YA CUENTA CON UN DISPOSITIVO ACTIVO
            goto errores
   end*/
    
    if exists (select 1 from cob_sincroniza..si_dispositivo
	          where di_imei = @i_imei and di_estado in ('P','R')) begin
      select @w_num_error = 2109106 --EL DISPOSITIVO ESTA ASIGNADO A OTRO OFICIAL Y SE ENCUENTRA ACTIVO
       goto errores
	end

    if exists (select 1 from cob_sincroniza..si_dispositivo
	          where di_imei = @i_imei and di_oficial = @i_oficial) begin
      select @w_num_error = 2109115 --El Oficial ya tiene asignado este Telefono
       goto errores
	end	
	
    if exists (select 1 from cob_sincroniza..si_dispositivo 
    			where di_codigo = @w_codigo)
    begin
    	select @w_num_error = 2109100 --ERROR AL INSERTAR MOVIL DEL OFICIAL! 
         goto errores
    end
    
    insert into cob_sincroniza..si_dispositivo(
    		di_codigo,           di_tipo,             di_imei,            di_macaddress,
    		di_oficial,          di_login,            di_estado,          di_alias,
    		di_fecha_reg,        di_usuario_reg,	  di_permitir_matricula)
    values(
    		@w_codigo,           @i_tipo,             @i_imei,            @i_macaddress,
    		@i_oficial,          @i_login,            'P',                @i_alias,
    		@i_fecha_reg,        @s_user,			  @i_permite_matri)
   
   if @@error <> 0 begin 
         select @w_num_error = 2109100 --ERROR AL INSERTAR MOVIL DEL OFICIAL! 
         goto errores
      end
    
    commit tran
    goto fin
end

if @i_operacion = 'U'
begin
    
    --Extraigo el Login del Oficial
    select @i_login = fu_login from cobis..cl_funcionario 
    WHERE fu_funcionario = (SELECT oc_funcionario FROM cobis..cc_oficial WHERE oc_oficial = @i_oficial)
	
	if @@rowcount = 0
	begin
	    if(@i_estado <> 'L') --Estado Bloqueado mo_device_status
		begin
		    select @w_num_error =  201121 --NO EXISTE OFICIAL
			goto errores
		end
	end

    select
        @w_codigo            = di_codigo,
        @w_tipo              = di_tipo,
        @w_imei              = di_imei,
        @w_macaddress        = di_macaddress,
        @w_oficial           = di_oficial,
        @w_login             = di_login,
        @w_estado            = di_estado,
		@w_permite_mat		 = di_permitir_matricula        
    from cob_sincroniza..si_dispositivo
    where di_codigo = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  2109101 --NO EXISTE MOVIL DEL OFICIAL
         goto errores
      end 
	--Se comenta hasta avisar a las personas del banco que se va limpiar las bases
    /*
    if exists (SELECT top 1 1 FROM cob_sincroniza..si_dispositivo
			WHERE di_oficial = @i_oficial AND di_estado <> 'L')
	begin
		select @w_num_error = 2109105 --EL OFICIAL YA CUENTA CON UN DISPOSITIVO ACTIVO --CAMBIAR ERROR
            goto errores
	end*/

   if exists (select 1
       from cob_sincroniza..si_dispositivo
	   where di_imei = @i_imei 
	   and di_estado in ('P','R') 
	   and di_oficial <> @i_oficial
	   and di_codigo  <> @i_codigo
	   and @i_estado IN ('P','R')
	   ) begin
	   select @w_num_error = 2109106 --EL DISPOSITIVO ESTA ASIGNADO A OTRO OFICIAL Y SE ENCUENTRA ACTIVO
       goto errores
   end
   
   if exists (select 1
       from cob_sincroniza..si_dispositivo
	   where di_imei  = @i_imei 	   
	   and di_oficial = @i_oficial 
	   and ((di_estado  <> @i_estado
	   and di_codigo  <> @i_codigo)
	   or  (di_estado  = @i_estado
	   and di_codigo  <> @i_codigo)))
	   begin
	       select @w_num_error = 2109115--'El Oficial ya tiene asignado este Teléfono')
           goto errores
	   end  
    
    begin tran
      
    if @i_tipo is not null
        select @w_tipo = @i_tipo
    
    if @i_imei is not null
        select @w_imei = @i_imei
        
    if @i_macaddress is not null
        select @w_macaddress = @i_macaddress
    
    if @i_oficial is not null
        select @w_oficial = @i_oficial
    
    if @i_login is not null
        select @w_login = @i_login
    
    if @i_estado is not null
        select @w_estado = @i_estado
    
    if @i_alias is not null
        select @w_alias = @i_alias
	
	if @i_permite_matri is not null	
		select @w_permite_mat = @i_permite_matri
         
   update cob_sincroniza..si_dispositivo set 
		di_tipo                 = @w_tipo,
        di_imei              	= @w_imei,
        di_macaddress        	= @w_macaddress,
        di_oficial           	= @w_oficial,
        di_login             	= @w_login,
        di_estado            	= @w_estado,
        di_alias             	= isnull(@w_alias, di_alias),
        di_permitir_matricula	= @w_permite_mat
    where di_codigo = @i_codigo
      
      if @@error != 0
      begin
         select @w_num_error = 2109102 --ERROR AL ACTUALIZAR MOVIL DEL OFICIAL!
         goto errores
      end
      
      commit tran
goto fin
end

if @i_operacion = 'D'
begin
    select (1) from cob_sincroniza..si_dispositivo where di_codigo = @i_codigo
    if @@rowcount = 0
    begin
		select @w_num_error =  2109101 --NO EXISTE MOVIL DEL OFICIAL!
		goto errores
    end 
      begin tran
      select
        @w_codigo            = di_codigo,
        @w_tipo              = di_tipo,
        @w_imei              = di_imei,
        @w_macaddress        = di_macaddress,
        @w_oficial           = di_oficial,
        @w_login             = di_login,
        @w_estado            = di_estado,
        @w_alias             = di_alias
        
    from cob_sincroniza..si_dispositivo
    where di_codigo = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  2109101 --NO EXISTE MOVIL DEL OFICIAL
         goto errores
      end 
    
    
    update cob_sincroniza..si_dispositivo
    set di_estado = 'E'     --estado eliminado
    where di_codigo = @i_codigo
  
    if @@error <> 0
    begin
     select @w_num_error = 2109103 --ERROR AL ELIMINAR MOVIL DEL OFICIAL!
     goto errores
    end
    
    
    commit tran
goto fin
end

if @i_operacion = 'S'
begin
    set rowcount 0
    select 
        'codigo'             = di_codigo,
        'tipo'               = di_tipo,
        'desTipo'            = (SELECT valor FROM cobis..cl_catalogo 
								WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'si_tipo_movil')
								and codigo = di_tipo),
        'imei'               = di_imei,
        'macAddress'         = di_macaddress,
        'oficial'            = di_oficial,
        'desOficial'         = fu_nombre,
        'alias'              = di_alias,
        'fechaRegistro'      = convert(varchar(10), di_fecha_reg, 103),
        'usuarioRegistro'    = di_usuario_reg,
        'estado'             = di_estado,
        'desEstado'          = (SELECT valor FROM cobis..cl_catalogo 
								WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'mo_device_status')
								and codigo = di_estado),
		'permite_matricula'	 = di_permitir_matricula
    from cob_sincroniza..si_dispositivo, cobis..cl_funcionario, cobis..cc_oficial
    WHERE di_oficial = oc_oficial
    AND oc_funcionario = fu_funcionario
    ORDER BY fu_nombre ASC 
goto fin
end

if @i_operacion = 'Q'
begin
    select 
        'codigo'             = di_codigo,
        'tipo'               = di_tipo,
        'descTipo'           = (SELECT valor FROM cobis..cl_catalogo 
								WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'si_tipo_movil')
								and codigo = di_tipo),
        'imei'               = di_imei,
        'macAddress'         = di_macaddress,
        'oficial'            = di_oficial,
        'descOficial'        = fu_nombre,
        'alias'              = di_alias,
        'fechaRegistro'      = convert(varchar(10), di_fecha_reg, 103),
        'usuarioRegistro'    = di_usuario_reg,
        'estado'             = di_estado,
        'desEstado'          = (SELECT valor FROM cobis..cl_catalogo 
								WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'mo_device_status')
								and codigo = di_estado),
		'permite_matricula'	 = di_permitir_matricula						
    from cob_sincroniza..si_dispositivo, cobis..cl_funcionario, cobis..cc_oficial
    WHERE di_oficial = oc_oficial
    AND oc_funcionario = fu_funcionario
    and di_codigo = @i_codigo 
    ORDER BY fu_nombre ASC 
    
goto fin
end

if @i_operacion = 'F' --Busqueda por Filtro
begin

    IF @i_oficial IS NOT NULL begin
       SELECT @i_oficial = CASE WHEN ltrim(rtrim(@i_oficial)) = '' THEN NULL ELSE ltrim(rtrim(@i_oficial)) END
    END
    
    IF @i_imei IS NOT NULL begin
       SELECT @i_imei = CASE WHEN ltrim(rtrim(@i_imei)) = '' THEN NULL ELSE ltrim(rtrim(@i_imei)) END
    END 
    
    select @w_mensaje = upper(mensaje) from cobis..cl_errores where numero = 201121
	
    select 'codigo'             = di_codigo,
           'tipo'               = di_tipo,
           'descTipo'           = (SELECT valor FROM cobis..cl_catalogo 
								   WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'si_tipo_movil')
								   and codigo = di_tipo),
           'imei'               = di_imei,
           'macAddress'         = di_macaddress,
           'oficial'            = di_oficial,
           'descOficial'        = isnull((select fu_nombre from cobis..cl_funcionario, cobis..cc_oficial
                                   where  oc_funcionario = fu_funcionario
                                   and    oc_oficial = di_oficial
                                   ),@w_mensaje),
           'alias'              = di_alias,
           'fechaRegistro'      = convert(varchar(10), di_fecha_reg, 103),
           'usuarioRegistro'    = di_usuario_reg,
           'estado'             = di_estado,
           'desEstado'          = (SELECT valor FROM cobis..cl_catalogo 
								WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'mo_device_status')
								and codigo = di_estado),
			'permite_matricula'	 = di_permitir_matricula
	from cob_sincroniza..si_dispositivo--, cobis..cl_funcionario, cobis..cc_oficial
	where (@i_imei    is null or di_imei        = @i_imei)
	and (@i_oficial is null or di_oficial     = @i_oficial)
    
goto fin
END


--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0


GO
