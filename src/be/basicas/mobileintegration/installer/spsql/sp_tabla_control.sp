/*************************************************************************/
/*   Archivo:            sp_tabla_control.sp                             */
/*   Stored procedure:   sp_tabla_control                                */
/*   Base de datos:      cob_sincroniza                                  */
/*   Producto:           App mobil Santander                             */
/*   Disenado por:       Nelson Trujillo                                 */
/*   Fecha de escritura: 28/07/2017                                      */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla si_sincroniza             */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     Q            Consulta sincronizaciones en estado pendientes       */
/*     U            Actualiza estado 					                 */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 28-07-2017 Nelson Trujillo             Emisión inicial	             */
/*************************************************************************/

use cob_sincroniza
go 

if exists (select 1 from sysobjects where name = 'sp_tabla_control')
   drop proc sp_tabla_control
go

CREATE PROCEDURE sp_tabla_control(
   @s_ssn            int         = null,
   @s_user           login       = null,
   @s_term           varchar(32) = null,
   @s_date           datetime    = null,
   @s_sesn           int         = null,
   @s_culture        varchar(10) = null,
   @s_srv            varchar(30) = null,
   @s_lsrv           varchar(30) = null,
   @s_ofi            smallint    = null,
   @s_rol            smallint    = NULL,
   @s_org_err        char(1)     = NULL,
   @s_error          int         = NULL,
   @s_sev            tinyint     = NULL,
   @s_msg            descripcion = NULL,
   @s_org            char(1)     = NULL,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = null,
   @t_from           varchar(32) = null,
   @t_trn            smallint    = null,
   @t_show_version bit  = 0,   --* Mostrar la version del programa
   @i_operacion      char(1),             -- Opcion con la que se ejecuta el programa
   @i_tipo           char(1)     = null,  -- Tipo de busqueda
   @i_modo           int         = null,  -- Modo de consulta
   @i_user			 VARCHAR(50) = null,
   @i_id_sync        int  = 0,
   @i_estado         VARCHAR(1)  = NULL,
   @i_fecha_sin       DATETIME   = NULL
)
as
begin
declare @w_today   datetime,
  @w_sp_name       varchar(32),
  @w_return        INT,
  @w_error_number  int,
  @w_downloaded    int,
  @w_msg		   varchar(1000)


set @w_sp_name = 'sp_tabla_control'

--* VERSIONAMIENTO DEL PROGRAMA
  if @t_show_version = 1
  begin
    print 'Stored Procedure=sp_tabla_control Version=1.0.0'
    return 0
  end

if @i_operacion='Q'
begin
PRINT 'INGRESO A LA OPERACION Q --- --- >  ' +@i_estado
	if exists(select 1 from cob_sincroniza..si_sincroniza tc
		join cob_sincroniza..si_sincroniza_det sa
		on tc.si_secuencial    = sa.sid_secuencial
		where tc.si_estado = 'D'
		and sid_descargado = 0 -- 0:No descargado, 1: Descargada
		and si_usuario = @i_user)
		and
	   exists(select 1 from cob_sincroniza..si_sincroniza tc
		join cob_sincroniza..si_sincroniza_det sa
		on tc.si_secuencial    = sa.sid_secuencial
		where tc.si_estado = 'D'
		and sid_descargado = 1 -- 0:No descargado, 1: Descargada
		and si_usuario = @i_user)
	begin
	
		select @w_msg = 'Existe una sincronización en proceso.',
				@w_error_number = 70078
            goto ERROR
	end

 select 'tc_id_sync'	=  si_secuencial,
		'tc_id_entidad' =  si_cod_entidad,
		'tc_entidad' 	=  si_des_entidad,
		'tc_usuario'	=  si_usuario, 
		'tc_fecha'		=  si_fecha_ing,
		'tc_nro_registros'	= si_num_reg - (select count(sid_id) from si_sincroniza_det where sid_secuencial = si_secuencial and sid_descargado = 1),
		'tc_estado'			= (case si_estado when 'P' then 'P' when 'D' then 'P' else si_estado end)
  from si_sincroniza
  where si_usuario = @i_user
  AND  ( si_estado = 'P' OR si_estado='D')
  --AND  ( si_estado = 'P' OR si_estado='E' OR si_estado='D') --SRO. Se elimina estado E, por errores en móvil al sincronizar
end -- end @i_operacion Q


if @i_operacion = 'U'
begin
    PRINT 'INGRESO A LA OPERACION U --- --- >  ' +@i_estado
	update si_sincroniza
		set si_estado = isnull(@i_estado,si_estado),
			si_fecha_sin =   isnull(@i_fecha_sin,si_fecha_sin) 
	where si_secuencial = @i_id_sync
	
  if @i_estado = 'S'
  begin
    update si_sincroniza_det
    set sid_descargado = 1
    where sid_secuencial = @i_id_sync
    and sid_descargado = 0
  end

	if @@error <> 0
	begin
         set @w_error_number = 708152
         goto ERROR
     end

end  --end @i_operacion U

return 0

ERROR:
    EXEC cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error_number,
		@i_msg   = @w_msg

    RETURN 1
end
GO
