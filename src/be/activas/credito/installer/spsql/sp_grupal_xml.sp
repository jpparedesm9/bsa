/************************************************************************/
/*   Archivo:              sp_grupal_xml.sp                             */
/*   Stored procedure:     sp_grupal_xml                                */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         PXSG                                         */
/*   Fecha de escritura:   02/08/2017                                   */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      01/08/2017     PXSG             Emision Inicial                 */
/*      13/10/2017     P. Ortiz         Correccion de conversion True   */
/*      10/11/2017     P. Ortiz         Se agrega rowcount para temporal*/
/*      15/03/2019     SRO              Corrección esquema secuenciales */
/*                                      en si_sincroniza                */
/*      30/06/2021     SRO              #ERROR 161777                   */
/************************************************************************/
USE cob_credito
GO

if exists (select 1 from sysobjects where name = 'sp_grupal_xml')
drop proc sp_grupal_xml
go

create proc sp_grupal_xml (
    @i_en_linea  CHAR (1)     = 'S',
    @t_file       varchar(14) = null,
    @t_debug      char(1)     = 'N',
    @i_origen     varchar(32) = '',
    @i_inst_proc  int         = NULL
)
as
declare
    @w_tramite             INT,
    @w_error               INT,
    @w_sp_name             VARCHAR(32),
    @w_msg                 VARCHAR(100),
	@w_codigo              INT,
	@w_cod_entidad         VARCHAR(10),
    @w_fech_proc           DATETIME,
    @w_des_entidad         VARCHAR(64),
    @w_user                login

select @w_sp_name = 'sp_grupal_xml'

--Datos de la Entidad -- Grupal
select @w_cod_entidad = 3
SELECT @w_cod_entidad = codigo,
       @w_des_entidad = valor
FROM cobis..cl_catalogo
WHERE tabla = ( SELECT codigo  FROM cobis..cl_tabla
                WHERE tabla = 'si_sincroniza') AND codigo = @w_cod_entidad

SELECT @w_tramite = io_campo_3 FROM cob_workflow..wf_inst_proceso WHERE io_id_inst_proc = @i_inst_proc
if @@rowcount = 0
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'Solicitud Grupal: No existe información para esa instancia de proceso'
    goto ERROR
end


--Fecha de Proceso
SELECT @w_fech_proc = fp_fecha FROM cobis..ba_fecha_proceso



SELECT @w_user      = (SELECT fu_login from cobis..cl_funcionario, cobis..cc_oficial
                       WHERE oc_funcionario = fu_funcionario AND oc_oficial = TR.tr_oficial)
FROM cob_credito..cr_tramite TR
WHERE tr_tramite = @w_tramite

if @w_user is null
begin
    select @w_error = 150000 -- ERROR EN INSERCION,
    select @w_msg = 'No existe Oficial'
    goto ERROR
end

--Secuencial
exec 
@w_error     = cobis..sp_cseqnos
@t_debug     = @t_debug,
@t_file      = @t_file,
@t_from      = @w_sp_name,
@i_tabla     = 'si_sincroniza',
@o_siguiente = @w_codigo out

if @w_error <> 0 begin
   goto ERROR
end


if not exists (select 1 from cob_sincroniza..si_sincroniza where si_secuencial = @w_codigo) begin
   -- Insert en si_sincroniza
   INSERT INTO cob_sincroniza..si_sincroniza 
   (si_secuencial,       si_cod_entidad, si_des_entidad,
   si_usuario,           si_estado,      si_fecha_ing,
   si_fecha_sin,         si_num_reg)
   VALUES                             
   (@w_codigo,           @w_cod_entidad, @w_des_entidad,
   @w_user      ,        'P',            @w_fech_proc,
   NULL,                 1)
   
   if @@error <> 0
   begin
      select @w_error = 15000 -- ERROR EN INSERCION
      goto ERROR
   end
end else begin
   select @w_error = 2108087, @w_msg = 'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL ' + convert(varchar, @w_codigo)
   print @w_msg
   goto ERROR
end 


exec @w_error   = sp_grupal_xml_det 
@i_en_linea     = @i_en_linea,
@t_file         = @t_file,
@t_debug        = @t_debug,
@i_origen       = @i_origen,
@i_inst_proc    = @i_inst_proc,
@i_tramite      = @w_tramite,
@i_secuencial   = @w_codigo
   
if @w_error <> 0
begin
   select @w_msg = 'Solicitud Grupal: Error al guardar en la tabla de sincronización'
   goto ERROR
end
return 0

ERROR:
IF @i_en_linea = 'S'
begin --Devolver mensaje de Error
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_error,
@i_msg   = @w_msg
    return @w_error
END
ELSE
    return @w_error

go
