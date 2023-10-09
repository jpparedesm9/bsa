/* ********************************************************************* */
/*      Archivo:                sp_valida_grupo.sp                       */
/*      Stored procedure:       sp_valida_grupo                          */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Maria Jose Taco                          */
/*      Fecha de escritura:     02-Oct-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "COBIS", representantes exclusivos para el Ecuador de la         */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de COBIS o su representante.               */
/*                              PROPOSITO                                */
/*      Este programa consulta si un tramite grupal esta o no en curso   */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      02/Oct/2017     Ma. Jose Taco      Version Inicial               */
/* ********************************************************************* */
use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_valida_grupo')
   drop proc sp_valida_grupo
go
IF OBJECT_ID ('dbo.sp_valida_grupo') IS NOT NULL
    DROP PROCEDURE dbo.sp_valida_grupo
GO

create proc sp_valida_grupo (
    @t_show_version         bit         = 0,
    @t_trn                  smallint    = null,
    @i_operacion            char(1),            -- Opcion con que se ejecuta el programa 
    @i_grupo                int         = null  -- Codigo del grupo 
)
as
declare @w_sp_name            varchar(64),
        @w_actualiza        varchar(1) 

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_valida_grupo, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name   = 'sp_valida_grupo',
       @w_actualiza = 'S'

--Consulta si un grupo esta atado a una solicitud en curso   
if @i_operacion = 'Q'
begin
    --Valida que no exista una solicitud en curso
    if exists (SELECT 1 FROM cob_workflow..wf_inst_proceso
                WHERE io_campo_1 = @i_grupo
                  AND io_estado not in ('TER', 'CAN', 'SUS', 'ELI'))
    begin
        select @w_actualiza = 'N'
    end
    select @w_actualiza  
end -- Fin Operacion Q

return 0
go
