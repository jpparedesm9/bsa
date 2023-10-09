/************************************************************************/
/*      Archivo:                actdcli.sp                              */
/*      Stored procedure:       sp_actualiza_datos_cli                  */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 14/Dic/99                               */
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
/*      Este procedimiento almacenado realiza la actualizacion de datos */
/*      de clientes en Plazo Fijo cuando se han modificado en el MIS    */
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

if exists (select 1 from sysobjects where name = 'sp_actualiza_datos_cli')
   drop proc sp_actualiza_datos_cli 
go

create proc sp_actualiza_datos_cli  (
		@s_ssn        int           = null,
		@s_user       login         = null,
		@s_sesn		    int           = null,
		@s_term       varchar(30)   = null,
		@s_date       datetime      = null,
		@s_srv        varchar(30)   = null,
		@s_lsrv       varchar(30)   = null,
		@s_ofi        smallint      = null,
		@s_rol        smallint      = NULL,
		@t_debug      char(1)       = 'N',
		@t_file       varchar(10)   = null,
		@t_from       varchar(32)   = null,
		@t_trn        smallint,
    @i_operacion  char(1),
    @i_ente       int,
		@i_nombre     varchar,
    @i_ced_ruc    numero,
    @i_direccion  tinyint,
    @i_telefono   varchar,
    @i_tipo       char(1)
)
with encryption
as
declare         
  @w_sp_name    varchar(32)

select @w_sp_name = 'sp_actualiza_datos_cli'

if @t_trn <> 14642 and @i_operacion <> 'H'
begin
	exec cobis..sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 141112
	   /*  'Error en codigo de transaccion' */
  return 1
end
if @i_tipo = 'N'
  if exists (select * from pf_operacion
             where op_ente = @i_ente)
  begin
    update pf_operacion
    set op_descripcion = @i_nombre
    where op_ente = @i_ente
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 145001
      return   1
    end
  end

  if @i_tipo = 'C'
  begin
    if exists (select * from pf_operacion
               where op_ente = @i_ente)
    begin
      update pf_operacion
      set op_ced_ruc = @i_ced_ruc
      where op_ente = @i_ente
      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 145001
        return   1
      end
      
      update pf_beneficiario
      set be_ced_ruc = @i_ced_ruc
      where be_ente = @i_ente
      if @@rowcount = 0
      begin    
        exec cobis..sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 145009   
        return   1
      end           
    end
  end

  if @i_tipo = 'T'
  begin
    if exists (select * from pf_operacion
               where op_ente = @i_ente
                 and op_direccion = @i_direccion)
    begin
      update pf_operacion
      set op_telefono = @i_telefono
      where op_ente = @i_ente
        and op_direccion = @i_direccion
      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 145001
        return   1
      end         
    end 
  end
go
