/* ********************************************************************* */
/*      Archivo:                sp_validar_grupo.sp                      */
/*      Stored procedure:       sp_validar_grupo                         */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           Patricio Samueza                         */
/*      Fecha de escritura:     01-Noviembre-2017                        */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Validaciones de los clientes de un grupo                         */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      01/11/2017     PXSG                   Version Inicial            */
/*      08/01/2021     SRO                   Requerimiento #147999       */
/*                                                                       */
/* ********************************************************************* */
USE cobis
go
IF OBJECT_ID ('dbo.sp_validar_grupo') IS NOT NULL
	DROP PROCEDURE dbo.sp_validar_grupo
GO

create proc sp_validar_grupo(
    @s_ssn                  int             = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_grupo                int             = null, -- Codigo del grupo
    @i_toperacion           varchar(30)     = 'NOR' -- Tipo de Solicitud Grupal: NOR: GRUPAL, REN: RENOVACION 
)
as
declare 
@w_return         INT,
@w_sp_name               varchar(32),
@numIntegrantesGrupo     INT,
@w_sum_parentesco        INT,
@w_porcentaje            INT,
@w_param_max_inte        INT,
@w_param_min_inte        INT,
@w_param_porc_parentesco FLOAT,
@w_param_rel_cony		  INT ,
@w_param_porc_mujeres 	  FLOAT,
@w_porc_mujeres 	      FLOAT,
@w_cliente_gr            INT,
@w_num_sexo_feme         INT,
@w_param_porc_emp        FLOAT,
@w_sum_enprender         INT,
@w_error                 INT,
@w_validated             INT
  

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name   = 'sp_validar_grupo'

exec @w_validated = cobis..sp_validar_condiciones_grupo
     @i_grupo     = @i_grupo
	 
PRINT 'resultado validated '+ convert(VARCHAR(10),@w_validated)+' del grupo '+convert(varchar(10),@i_grupo)
IF @w_validated<>0
BEGIN
   select @w_error = @w_validated 
   goto ERROR
END        
ELSE begin
     
   --Agregar validacion de si el grupo tiene un tr�mite vigente (grupo_busin)
    
   if exists (SELECT 1 FROM cob_workflow..wf_inst_proceso
              WHERE io_campo_1 = @i_grupo
                AND io_estado not in ('TER', 'CAN', 'SUS', 'ELI'))
   begin
       select @w_error = 103156
       goto ERROR
   end
   
end

return 0

ERROR:
begin --Devolver mensaje de Error
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_error
    return @w_error
end

go
