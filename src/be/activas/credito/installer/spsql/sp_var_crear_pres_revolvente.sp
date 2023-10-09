/************************************************************************/
/*  Archivo:                sp_var_crear_pres_revolvente.sp             */
/*  Stored procedure:       sp_var_crear_pres_revolvente                */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           E. Báez                                     */
/*  Fecha de Documentacion: 24/Abr/2017                                 */
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
/*  Permite determinar si el cliente cumple con todas las validaciones  */
/*  requeridas para acceder a un crédito revolvente                     */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 15/Nov/2018   E. Báez              Emision Inicial                   */
/* 06/Mar/2020   P. Ortiz             No enviar si ya existe codigo     */
/* 18/AGO/2021   AGO                  MANEJO DE ERRORES                 */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_crear_pres_revolvente')
	drop proc sp_var_crear_pres_revolvente
GO


CREATE PROC sp_var_crear_pres_revolvente
(@s_ssn          int         = null,
@s_ofi          smallint    = null,
@s_user         login       = null,
@s_date         datetime    = null,
@s_srv          varchar(30) = null,
@s_term	       descripcion = null,
@s_rol          smallint    = null,
@s_lsrv	       varchar(30) = null,
@s_sesn	       int 	       = null,
@s_org          char(1)     = null,
@s_org_err      int 	       = null,
@s_error        int 	       = null,
@s_sev          tinyint     = null,
@s_msg          descripcion = null,
@t_rty          char(1)     = null,
@t_trn          int         = null,
@t_debug        char(1)     = 'N',
@t_file         varchar(14) = null,
@t_from         varchar(30) = null,
--variables
@i_id_inst_proc int,    --codigo de instancia del proceso
@i_id_inst_act  int,    
@i_id_empresa   int, 
@o_id_resultado smallint  out
)
AS
DECLARE @w_sp_name         varchar(32),
        @w_tramite         int,
        @w_return          int,
        ---var variables   
        @w_asig_actividad  int,
        @w_valor_ant       varchar(255),
        @w_valor_nuevo     varchar(255),
        @w_ente            int,
        @w_observaciones   varchar(1000),
        @w_fecha           datetime,
        @w_nombre          varchar(64),
        @w_p_apellido      varchar(64),
        @w_s_apellido      varchar(64),
        @w_correo          varchar(64),
        @w_error_1         int,
        @w_error_2         int,
        @w_ttramite        varchar(255),
        @w_banco           cuenta,
        @w_registro_id 	   varchar(100),
        @w_msg             varchar(255),
		@w_error           int 
	    
       
print 'Inicio Paul'

select @w_sp_name='sp_var_crear_pres_revolvente'

select @w_ente       = convert(int,io_campo_1),
	   @w_tramite    = convert(int,io_campo_3),
	   @w_ttramite   = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


--llamada a sp de apertura de línea de crédito revolvente

if @w_ttramite = 'REVOLVENTE'
begin
	print 'Antes de ejecutar lcr'
	exec @w_error_1 = cob_cartera..sp_lcr_crear
	@s_ssn              = @s_ssn,
	@s_ofi              = @s_ofi,
	@s_user             = @s_user,
	@s_sesn             = @s_sesn,
	@s_term             = @s_term,
	@s_date             = @s_date,
	@i_id_inst_proc     = @i_id_inst_proc,
	@o_banco            = @w_banco out  
   print 'Antes de ejecutar digito'
   
     
	if @w_error_1 <> 0 begin
       select
       @w_error        = @w_error_1,
       @w_sp_name      = 'cob_cartera..sp_lcr_crear'
       goto ERROR
    end
       
	
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
   
   if exists (select 1 from  cob_credito..cr_b2c_registro 
               where rb_cliente = @w_ente and rb_fecha_vigencia >= @w_fecha)
   begin
      select @o_id_resultado = 1
      return 0
   end
   else
   begin
      exec @w_error_2 = cob_credito..sp_lcr_ingresar_registro 
      @i_id_inst_proc	= @i_id_inst_proc, 
      @o_registro_id	= @w_registro_id output, 
      @o_msg        	= @w_msg output     
      print 'Pasa digito'
	  
	 if @w_error_2 <> 0 begin
       select
       @w_error        = @w_error_2,
       @w_sp_name      = 'cob_cartera..sp_lcr_crear'
       goto ERROR
    end
       
      select 	@w_nombre   = en_nombre,
         @w_p_apellido	= p_p_apellido,
         @w_s_apellido  = p_s_apellido,
         @w_correo      = (select top 1 di_descripcion from cobis..cl_direccion 
                           	where di_ente = en_ente and di_tipo = 'CE')
      from cobis..cl_ente
      where en_ente = @w_ente
      
      print 'Imprime @w_error_1' + convert(varchar,@w_error_1)
      print 'Imprime @w_error_2' + convert(varchar,@w_error_2)

      if((@w_error_1 = 0) and (@w_error_2 = 0))
      begin
         print 'Antes de insertar cr_ns_creacion_lcr'
         insert into cob_credito..cr_ns_creacion_lcr
              (nc_tramite, nc_fecha_reg, nc_cliente, nc_nombre, nc_apellido_paterno, nc_apellido_materno, nc_correo, nc_digito, nc_estado)
         values (@w_tramite, @w_fecha, @w_ente, @w_nombre, @w_p_apellido, @w_s_apellido, @w_correo, @w_registro_id, 'P')

         select @o_id_resultado = 1
      end
   end
end
else
begin
	select @o_id_resultado = 3
end

return 0

ERROR:

select 
@w_error = isnull( @w_error, 999999) ,
@o_id_resultado = 3

return @w_error

go


