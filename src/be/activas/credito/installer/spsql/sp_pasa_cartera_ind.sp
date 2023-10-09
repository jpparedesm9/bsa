/*****************************************************************************/
/*   ARCHIVO:         sp_pasa_cartera_ind.sp                                 */
/*   NOMBRE LOGICO:   sp_pasa_cartera_ind                                    */
/*   PRODUCTO:        COBIS WORKFLOW                                         */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios propiedad de        */
/*   MACOSA S.A.                                                             */
/*   Su uso no autorizado queda  expresamente  prohibido asi como cualquier  */
/*   alteracion o agregado hecho  por alguno de sus usuarios sin el          */
/*   debido consentimiento por escrito de MACOSA.                            */
/*   Este programa esta protegido por la ley de derechos de autor y por las  */
/*   convenciones  internacionales de propiedad intelectual.                 */
/*   Su uso  no  autorizado dara derecho a MACOSA para obtener ordenes  de   */
/*   secuestro o  retencion  y  para  perseguir  penalmente a  los autores   */
/*   de cualquier infraccion.                                                */
/*****************************************************************************/
/*                             PROPOSITO                                     */
/*   Desembolso de la operación individual con una forma de desembolso       */
/*   definida                                                                */
/*****************************************************************************/
/*                           MODIFICACIONES                                  */
/*   FECHA          AUTOR                    RAZON                           */
/* 03/Agosto/2017    VBR     Emision Inicial                                 */
/* 16/08/2022        ACH     #191441 Validar fecha de proceso vs fecha de cre*/
/*****************************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_pasa_cartera_ind')
   drop proc sp_pasa_cartera_ind
go
create proc sp_pasa_cartera_ind
        (@s_ssn        int         = null,
	     @s_ofi        smallint    = null,
	     @s_user       login       = null,
         @s_date       datetime    = null,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
         @s_sev        tinyint     = null,
         @s_msg        descripcion = null,
         @t_rty        char(1)     = null,
         @t_trn        int         = null,
         @t_debug      char(1)     = 'N',
         @t_file       varchar(14) = null,
         @t_from       varchar(30)  = null,
         --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
	   	 @i_id_empresa   int, 
		 @o_id_resultado  smallint  out
)as
declare
         @w_error INT,
         @w_sp_name VARCHAR(30),
         @w_tramite INT,
         @w_forma_des CHAR(10),
		 @w_fecha_dispersion datetime,
		 @w_fecha_proceso datetime,
		 @w_banco_real cuenta,
		 @w_operacionca int

SELECT @w_sp_name = 'sp_pasa_cartera_ind'

--PRINT '----->>>sp_pasa_cartera-SE ANADE rowcount'
set rowcount 0

SELECT @w_tramite = convert(int,io_campo_3)
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

SELECT @w_forma_des = pa_char
FROM cobis..cl_parametro
WHERE pa_nemonico = 'NCRAHO'
AND pa_producto = 'CCA'

-- Caso#191441
-- Fecha Proceso de Cartera
select @w_fecha_proceso = fc_fecha_cierre
from cobis..ba_fecha_cierre
where fc_producto = 7 -- CARTERA

select @w_fecha_dispersion = op_fecha_liq from cob_cartera..ca_operacion where op_tramite = @w_tramite

if @w_fecha_dispersion < @w_fecha_proceso  
begin

   select @w_banco_real = op_banco,
          @w_operacionca = op_operacion
   from cob_cartera..ca_operacion
   where op_tramite = @w_tramite   
   
   update cob_cartera..ca_operacion
   set op_fecha_ini = @w_fecha_proceso,
       op_fecha_liq = @w_fecha_proceso,
	   op_cuota = 0
   where op_tramite = @w_tramite

    exec @w_error     = cob_cartera..sp_borrar_tmp
    @i_banco           = @w_banco_real
    
    if @w_error <> 0     
	begin
           SELECT @o_id_resultado = 2 -- Error
		   return @w_error
      end
--Se agrega para no modificar el sp_desembolso y el sp_paso_cartera, porque estos tienen como variable  @i_tabla_nueva en 'D'

	  exec @w_error     = cob_cartera..sp_pasotmp
           @s_user            = @s_user,
           @s_term            = @s_term,
           @i_banco           = @w_banco_real,
           @i_operacionca     = 'S',
           @i_dividendo       = 'S',
           @i_amortizacion    = 'N',
           @i_cuota_adicional = 'S',
           @i_rubro_op        = 'S',
           @i_relacion_ptmo   = 'S',
           @i_nomina          = 'S',
           @i_acciones        = 'S',
           @i_valores         = 'S'

      if @w_error <> 0
      begin
           SELECT @o_id_resultado = 2 -- Error
		   return @w_error
      end

      exec @w_error = cob_cartera..sp_modificar_operacion_int
           @s_user              = @s_user,
           @s_sesn              = @s_sesn,
           @s_date              = @s_date,
           @s_ofi               = @s_ofi,
           @s_term              = @s_term,
           @i_calcular_tabla    = 'S',
           @i_tabla_nueva       = 'S',
           @i_salida            = 'N',
           @i_operacionca       = @w_operacionca,
           @i_banco             = @w_banco_real

      if @w_error <> 0
      begin
           SELECT @o_id_resultado = 2 -- Error
		   return @w_error
      end

      exec @w_error = cob_cartera..sp_pasodef
           @i_banco        = @w_banco_real,
           @i_operacionca  = 'S',
           @i_dividendo    = 'S',
           @i_amortizacion = 'S',
           @i_cuota_adicional = 'S',
           @i_rubro_op     = 'S',
           @i_relacion_ptmo = 'S',
           @i_nomina       = 'S',
           @i_acciones     = 'S',
           @i_valores      = 'S'

      if @w_error <> 0
      begin
           SELECT @o_id_resultado = 2 -- Error
		   return @w_error
      end

      exec @w_error = cob_cartera..sp_borrar_tmp
           @s_user       = @s_user,
           @s_sesn       = @s_sesn,
           @s_term       = @s_term,
           @i_desde_cre  = 'N',
           @i_banco      = @w_banco_real

      if @w_error <> 0
      begin
           SELECT @o_id_resultado = 2 -- Error
		   return @w_error
      end   

end
   
-- Ejecuta el desembolso de la operacion de CCA
EXEC @w_error = cob_cartera..sp_pasa_cartera 
     @s_ofi   = @s_ofi,
     @s_user  = @s_user,
     @s_date  = @s_date,
     @s_term  = @s_term,
     @s_ssn   = @s_ssn,
     @i_tramite = @w_tramite,
     @i_forma_desembolso = @w_forma_des
     
    IF @w_error <> 0 
       BEGIN 
           SELECT @o_id_resultado = 2 -- Error
           --@w_error = @@ERROR
		   return @w_error
       END

set @o_id_resultado = 1  --OK

return 0
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error
GO
