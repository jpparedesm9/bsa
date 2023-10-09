use cob_workflow
go

IF OBJECT_ID ('sp_anular_tramite') IS NOT NULL
	DROP PROCEDURE sp_anular_tramite
GO
/*************************************************************************/
/*   Archivo:            sp_anular_tramite.sp                            */
/*   Stored procedure:   sp_anular_tramite                               */
/*   Base de datos:      cob_workflow                                    */
/*   Producto:           Originación			                 */
/*   Disenado por:       VBR                                             */
/*   Fecha de escritura: 28/12/2016                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, anula el trámite y la operación      */
/*   asociada desde una actividad automática  en el flujo                */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   28-12-2016          VBR                   Emision Inicial           */
/*************************************************************************/

go
CREATE PROCEDURE sp_anular_tramite
        ( @s_ssn        int         = null,
	     @s_ofi        smallint,
	     @s_user       login,
          @s_date       datetime,
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
		@i_id_inst_act  int = null,    
	   	@i_id_empresa   int = null, 
		@o_id_resultado  smallint = null out
)as
DECLARE
@w_error          		   int,
@w_return          		   int,
@w_tramite         		   int,
@w_tramite_op      		   int,
@w_codigo_proceso  		   int,
@w_version_proceso 		   int,
@w_cliente			   INT,
@w_codigo_tramite           CHAR(50),
@w_sp_name                  VARCHAR(30),
@w_est_anulado              INT,
@w_banco                    VARCHAR(64),
@w_estado 		            tinyint,
@w_ente                     INT,
@w_estado_fin               TINYINT,
@w_toperacion				VARCHAR(10),
@w_registros                INT,
@w_grupo                    int

set rowcount 0

select @w_sp_name = 'sp_anular_tramite',
@w_error = 0

exec @w_error  = cob_cartera..sp_estados_cca
@o_est_anulado = @w_est_anulado out

IF @w_error <> 0 
BEGIN 
  SELECT @o_id_resultado = 3
  GOTO ERROR
END


select @w_tramite = convert(int, io_campo_3),
	   @w_codigo_proceso = io_codigo_proc,
	   @w_version_proceso = io_version_proc,
	   @w_codigo_tramite  = io_campo_3,
	   @w_grupo           = io_campo_1
from wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

PRINT 'ENTRA A SP_ANULAR_TRAMITE'
PRINT 'TRAMITE'
PRINT @w_codigo_tramite
PRINT 'INSTANCIA PROCESO'
PRINT @i_id_inst_proc

BEGIN TRANSACTION

if  (select gr_num_ciclo from cobis..cl_grupo where gr_grupo = @w_grupo) = 0
and exists(select 1 from cob_credito..cr_tramite where tr_tramite = @w_tramite and tr_promocion = 'S')
begin
     delete from cob_credito..cr_grupo_promo_inicio where gpi_grupo= @w_grupo
end

declare cur_tramite_grupal cursor for
select gl_cliente
from   cob_cartera..ca_garantia_liquida
where  gl_tramite =  @w_tramite
order  by gl_cliente

open cur_tramite_grupal

fetch cur_tramite_grupal into @w_ente

while @@fetch_status = 0
begin

/*Se agrega el codigo para la devolucion de la garantia liquida*/
        exec @w_return     = cob_custodia..sp_contabiliza_garantia
        @s_date            = @s_date,
        @s_user            = @s_user,
        @s_ofi             = @s_ofi ,
        @s_term            = @s_term,
        @i_operacion       = 'PD',
        @i_tramite         = @w_tramite,
        @i_ente            = @w_ente
        if @@error != 0
        begin
          select @w_error = 1901020 -- ERROR EN LA ACTUALIZACION DEL REGISTRO
          close cur_tramite_grupal
          deallocate cur_tramite_grupal
          goto ERROR
        end
        
 SIGUIENTE:
      fetch cur_tramite_grupal into  @w_ente
   
end

close cur_tramite_grupal
deallocate cur_tramite_grupal

PRINT 'SALE DE CONTABILIZAR GARANTIA LIQUIDA'
--DEVOLUCION SEGURO EXTERNO
update cob_cartera..ca_seguro_externo set
se_monto         = 0,
se_usuario       = @s_user,
se_terminal      = @s_term
where se_tramite = @w_tramite

/*CAMBIAR ESTADO DE OPERACIONES MADRE E HIJAS A ANULADO*/

select @w_registros = count(1)
FROM cob_credito..cr_tramite_grupal,
     cob_cartera..ca_operacion
WHERE tg_tramite         = @w_tramite
AND   tg_participa_ciclo = 'S'
AND   op_operacion       = tg_operacion
AND   op_estado         <> @w_est_anulado

PRINT 'OPERACIONES HIJAS: ' + convert(varchar(10), @w_registros)

SELECT @w_registros = count(1)
FROM cob_cartera..ca_operacion
WHERE op_tramite = @w_tramite
and   op_estado  <> @w_est_anulado -- Estado Anulado

PRINT 'OPERACIONE PADRE: ' + convert(varchar(10), @w_registros)  

declare cur_cambio_estado cursor FOR
select distinct op_banco,
op_estado,
op_toperacion,
op_tramite
FROM cob_credito..cr_tramite_grupal,
     cob_cartera..ca_operacion
WHERE tg_tramite         = @w_tramite
AND   tg_participa_ciclo = 'S'
AND   op_operacion       = tg_operacion
AND   op_estado         <> @w_est_anulado 
union
SELECT op_banco,
op_estado,
op_toperacion,
op_tramite
FROM cob_cartera..ca_operacion
WHERE op_tramite = @w_tramite
and   op_estado  <> @w_est_anulado -- Estado Anulado

open cur_cambio_estado

fetch cur_cambio_estado into @w_banco, @w_estado, @w_toperacion, @w_tramite_op

while @@fetch_status = 0
BEGIN

  PRINT 'ENTRA AL CURSOR CAMBIO DE ESTADO'

  SELECT @w_estado_fin = em_estado_fin
  FROM cob_cartera..ca_estados_man
  WHERE em_toperacion  = @w_toperacion
  AND   em_tipo_cambio = 'M'  --manual
  AND   em_estado_ini  = @w_estado
  AND   em_estado_fin  = @w_est_anulado

  IF @@ROWCOUNT = 0
  BEGIN
    PRINT 'NO EXISTE PARAMETRIZADO: '+ @w_toperacion
    
    SELECT @w_error = 710217, --NO EXISTE ESTADO
    @o_id_resultado = 3 -- Error
    
    close cur_cambio_estado
    deallocate cur_cambio_estado
   
    ROLLBACK TRAN
    GOTO ERROR  --rollback se realiza en el sp_cerror
  END

 PRINT 'VA A ACTUALIZAR ESTADO DEL TRAMITE:'
 PRINT @w_tramite_op
 
 PRINT 'VA A ACTUALIZAR ESTADO DE OPERACION #:'
 PRINT @w_banco
 
 select @s_ssn = @s_ssn + 1
  
 exec @w_error = cob_cartera..sp_cambio_estado_op_ext
      @s_ssn        = @s_ssn,
      @s_user       = @s_user,
      @s_term       = @s_term,
      @s_date       = @s_date,
      @s_ofi        = @s_ofi,
      @i_banco      = @w_banco,  --NUMERO DE OPERACION BANCO 
      @i_estado_fin = "ANULADO"

  IF @w_error <> 0
  BEGIN    
     PRINT 'ERROR AL CAMBIAR EL ESTADO'
     
    SELECT @o_id_resultado = 3 -- Error
    
    close cur_cambio_estado
    deallocate cur_cambio_estado
   
    ROLLBACK TRAN
    GOTO ERROR  --rollback se realiza en el sp_cerror
  END
  
  PRINT 'VA A LEER SIGUIENTE REGISTRO DEL CURSOR'
  fetch cur_cambio_estado into  @w_banco, @w_estado, @w_toperacion, @w_tramite_op
end

close cur_cambio_estado
deallocate cur_cambio_estado

select @o_id_resultado = 1 --OK

COMMIT TRANSACTION
  
return 0
ERROR:
    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error, @i_sev=1
    return @w_error
GO
