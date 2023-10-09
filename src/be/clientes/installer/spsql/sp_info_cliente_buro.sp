--set replication off
--go
/*************************************************************************/
/*   Archivo:            sp_info_cliente_buro.sp                         */
/*   Stored procedure:   sp_info_cliente_buro                            */
/*   Base de datos:      cobis                                           */
/*   Producto:           Cliente                                         */
/*   Disenado por:       MBA                                             */
/*   Fecha de escritura: 27-01-2011                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP"                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa recupera la informacion del cliente solicitada por    */
/*   el Buro de Credito                                                  */
/*                                                                       */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*   FECHA         AUTOR      RAZON                                      */
/*   21-06-2017    MBA       Recupera la información del cliente         */
/*                           solicitada por el Buró de Crédito           */
/*   06-07-2017    NTR       Add subtipo para evitar doble consulta      */
/*   06-07-2017    P. Ortiz  Agregar consulta de Segundo Nombre          */
/*   07-11-2017    P. Ortiz  Formato de fecha, quitar etiquetas Direccion*/
/*   19-03-2018    P. Ortiz  Opcion Consulta clientes para reportes buro */
/*   05-07-2019    srojas    Reestructuración Buro histórico             */
/*   05-08-2019    M.Taco    Caso 113432 optimizacion                    */
/*   05-03-2020    M.Taco    Caso 136291 Validacion de la colonia para   */
/*                           cuando la descripcion son numeros           */
/*   20/01/2020   ACH        Se añade parametro por caso                 */
/*                           #133126 en fn_filtra_acentos                */
/*   30/03/2023   ACH        REQ#203112                                  */
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_info_cliente_buro')
   drop proc sp_info_cliente_buro
go


create proc sp_info_cliente_buro (
   @s_ssn                         int           = null,
   @s_user                        login         = null,
   @s_sesn                        int           = null,
   @s_term                        varchar(30)   = null,
   @s_date                        datetime      = null,
   @s_srv                         varchar(30)   = null,
   @s_lsrv                        varchar(30)   = null,
   @s_rol                         smallint      = null,
   @s_ofi                         smallint      = null,
   @s_org                         char(1)       = null,
   @t_debug                       char(1)       = 'N',
   @t_file                        varchar(14)   = null,
   @t_from                        varchar(32)   = null,
   @t_trn                         int           = null,
   @i_operacion                   char(1)       = null,
   @i_transaccion                 char(1)       = 'S',   -- Transaccion que se va a aplicar
   @i_sub_tipo                    char(1)       = null,  -- Consulta un tipo de consulta por el codigo actual
   -----------------------------------------
   --Variables de la info del cliente
   -----------------------------------------
   @i_codigo_cliente              int           = null,  -- Codigo para identificar al cliente
   @i_tipo_para_n                 varchar(2)    = 'N',   -- Campo para enviar X o N en lugar de Ñ
   @i_dias_vigencia               int           = null   -- debe tener la misma funcionalidad del parametro BCPC
   )
as
declare
   -----------------------------------------
   --Variables de info del cliente
   -----------------------------------------
   @w_codigo                        int,                  -- Codigo de la info del cliente
   @w_sp_name                       varchar(32),          -- Nombre del store procedure de la info del cliente
   @w_datetime                      datetime,             -- Variable para insertar la fecha
   @w_num_error                     int,                  -- Numero de error que se envia al store procedure sp_cerror
   @w_fecha_buro                    datetime,
   @w_fecha_report                  datetime,
   @w_name_report                   varchar(45),
   @w_print_report                  char(1),
   @w_days_param                    int,
   @w_fecha_proeso                  datetime,
   @w_num_ciclo                     int
-----------------------------------------
--Inicializacion de Variables
-----------------------------------------
select @w_sp_name               = 'sp_info_cliente_buro',
       @w_datetime              = convert(varchar,@s_date,101) + ' ' + convert(varchar,getdate(),108)


-----------------------------------------
--ControlTransacciones vs. Operaciones
-----------------------------------------

if @i_operacion = 'Q'
begin

   if @i_sub_tipo = '0'  --ENCABEZADO
   begin
      select DISTINCT 'Versión' = 13,
              'NumeroReferenciaOperador' =tg_prestamo,
              'ProductoRequerido' = 509, 
              'ClavePais' = 'MX',
              'ClaveUsuario' = 'XXXXXXXXX',
              'Password' = 'XXXXXXX',
              'Tipoconsulta' = 'I',
              'Tipocontrato' = 'PA',
              'ClaveUnidadMonetaria'  = 'MX',
              'ImporteContrato' = isnull(tg_monto, op_monto), op_cliente,
              'Idioma' = 'SP',
              'TipoSalida' = '01'
      from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
      where op_estado not in ( 0,99,3)
      and op_cliente = @i_codigo_cliente
      and tg_prestamo = op_banco
      AND tg_cliente = op_cliente
   end
   
      if @i_sub_tipo = '1' OR  @i_sub_tipo = '4'   --NOMBRE
	  begin
          select 'ApellidoPaterno' = cobis.dbo.fn_filtra_acentos(convert(varchar(26), ltrim(rtrim(upper(p_p_apellido))))),
                 'ApellidoMaterno' = cobis.dbo.fn_filtra_acentos(convert(varchar(26), isnull(ltrim(rtrim(upper(p_s_apellido))),''))),
                 'PrimerNombre'    = cobis.dbo.fn_filtra_acentos(convert(varchar(26), ltrim(rtrim(upper(en_nombre))))),
				 'FechaNacimiento' = convert(varchar(26), p_fecha_nac),
                 'FechaNacimientoFormat' = replace(convert(varchar(10), p_fecha_nac,103),'/',''),           
                 'RFC'             = isnull(convert(varchar(13), en_rfc),''),
                 'Nacionalidad'    = 'MX',
                 'EstadoCivil'     =  convert(varchar(1),p_estado_civil),
                 'Sexo'            =  convert(varchar(1),p_sexo),
                 'FechaNacimientoDate'   = p_fecha_nac,
                 'SegundoNombre'   = cobis.dbo.fn_filtra_acentos(convert(varchar(26), ltrim(rtrim(upper(p_s_nombre)))))
          from cobis..cl_ente
          where en_ente = @i_codigo_cliente
   end
   
   if @i_sub_tipo = '2' OR  @i_sub_tipo = '4'   --DOMICILIO
   begin
      select 'Direccion'        = (SELECT  di_calle + ' ' + convert(VARCHAR(10),di_nro)),
             'Estado-Provincia' = e2.eq_valor_arch,
             'Municipio-Ciudad' = isnull(convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(ci_descripcion,'A'))),''),
             'Colonia-Parroquia' = isnull(convert(varchar(40),(SELECT cob_conta_super.dbo.fn_formatea_ascii_ext(pq_descripcion,'AN'))),''),
             'CP' = isnull(convert(varchar(5),di_codpostal),''),                                     
             'CodPais' = 'MX'                     
        from cobis..cl_ente e
       inner join cobis..cl_direccion d on (d.di_ente = e.en_ente)	 
       inner join cobis..cl_parroquia p on (pq_parroquia = di_parroquia)
       inner join cobis..cl_ciudad c on (c.ci_ciudad = d.di_ciudad)
       inner join cob_conta_super..sb_equivalencias e1 on (e1.eq_valor_cat = convert(varchar, d.di_provincia)) 
       inner join cob_conta_super..sb_equivalencias e2 on (e2.eq_valor_cat = e1.eq_valor_arch)
          where d.di_tipo in ('RE','AE')
          and en_ente = @i_codigo_cliente
         and e1.eq_catalogo = 'ENT_FED'
         and e2.eq_catalogo = 'ENT_BURO'
         AND p.pq_ciudad = c.ci_ciudad
   end
   
    if @i_sub_tipo = '3'    --CUENTA
   begin
      select      'NumeroCuenta' = op_banco, 
                'ClaveOtorgante' = 'XXXXXXXXXX',
               'NombreOtorgante' = 'SOFOME'
      from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
      where op_estado not in ( 0,99,3)
      and op_cliente = @i_codigo_cliente
      and tg_prestamo = op_banco
   end
   
   return 0
end --@i_operacion = 'Q'


if @i_operacion = 'C'
begin
	select @w_fecha_buro 	= ib_fecha FROM cob_credito..cr_interface_buro WHERE ib_cliente = @i_codigo_cliente and ib_estado = 'V' --12531
	select @w_fecha_report 	= ea_fecha_report FROM cobis..cl_ente_aux WHERE ea_ente = @i_codigo_cliente  --12531
	select @w_days_param 	= @i_dias_vigencia
	select @w_fecha_proeso 	= fp_fecha FROM cobis..ba_fecha_proceso
	select @w_num_ciclo     = en_nro_ciclo  from cobis..cl_ente where en_ente = @i_codigo_cliente
	select @w_num_ciclo     = isnull(@w_num_ciclo,0)
	
    if (@w_fecha_report IS NULL) or (DATEDIFF(day, @w_fecha_report, @w_fecha_proeso) > @w_days_param)
	begin
		select @w_print_report = 'S'
		select @w_name_report = 'BuroCreditoHistorico'
		
		print 'ES HOY Y ESTA NULL o Supero los ' + convert(varchar, @w_days_param) + ' dias de vigencia'
		
		update cobis..cl_ente_aux
		set ea_fecha_report_resp = ea_fecha_report
		where ea_ente = @i_codigo_cliente
		
		if @@error <> 0
		begin   
			select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
			goto errores
		end		
			
		update cobis..cl_ente_aux
		set ea_fecha_report = @w_fecha_proeso
		where ea_ente = @i_codigo_cliente
			
		if @@error <> 0
		begin   
			select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
			goto errores
		end		
	end
	else
	begin
	    if @w_num_ciclo > 0
		begin
			select @w_print_report = 'S'
			select @w_name_report = 'BuroCreditoInternoExterno'
			PRINT 'es menor a los dias preguntados'
			
			/*update cobis..cl_ente_aux
		    set ea_fecha_report_resp = ea_fecha_report
		    where ea_ente = @i_codigo_cliente
		    
		    if @@error <> 0
		    begin   
			   select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
			   goto errores
		    end	
			
			update cobis..cl_ente_aux
			set ea_fecha_report = @w_fecha_proeso
			where ea_ente = @i_codigo_cliente
				
			if @@error <> 0
			begin   
				select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
				goto errores
			end*/			
		end
		else
		begin
			select @w_print_report = 'N'
			select @w_name_report = ''
			PRINT 'NO IMPRIME'
		end
	end
	
	/* Devuelve al servicio */
	SELECT 	'cliente'	= @i_codigo_cliente,
			'nombre'	= @w_name_report,
			'print'     = @w_print_report
	
	
   return 0
end --@i_operacion = 'C'


if @i_operacion = 'F'
begin
     update cobis..cl_ente_aux
	 set ea_fecha_report = ea_fecha_report_resp
	 where ea_ente       = @i_codigo_cliente
				
     if @@error <> 0
	 begin   
	      select @w_num_error = 190515 --ERROR AL REGISTRAR TRANSACCION DE SERVICIO
		  goto errores
	 end	
	 return 0		
end  --@i_operacion = 'E' 

--Control errores
errores:
-------------------------
   -- Utilizando transaccion
   if @i_transaccion = 'S'
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   end
   return @w_num_error

GO
