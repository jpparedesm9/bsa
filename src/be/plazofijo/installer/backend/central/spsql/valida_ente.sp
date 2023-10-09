/************************************************************************/
/*      Archivo:                valente.sp                              */
/*      Stored procedure:       sp_valida_ente                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Katty Tamayo                            */
/*      Fecha de documentacion: 10/Mar/05                               */
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
/*      Este procedimiento almacenado realiza la validaci¢n del ente    */
/*      menor de edad cuando la operacion est  pignorada                */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR             RAZON                             */
/*      10/Mar/05   Katty Tamayo      Emisi¢n Inicial                   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_valida_ente')
   drop proc sp_valida_ente
go

create proc sp_valida_ente (
   @s_ssn            int         = NULL,
   @s_user           login       = NULL,
   @s_sesn           int         = NULL,
   @s_term           varchar(30) = NULL,
   @s_date           datetime    = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv           varchar(30) = NULL,
   @s_ofi            smallint    = NULL,
   @s_rol            smallint    = NULL,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = NULL,
   @t_from           varchar(32) = NULL,
   @t_trn            smallint,
   @i_ente           int,   
   @i_pignorado      char(1)
)
with encryption
as
declare @w_sp_name           varchar(32),
        @w_mayor_edad        tinyint,
        @w_par_cliente_menor char(1),
        @w_en_subtipo        char(1), 
        @w_fecha_nac         datetime,
        @w_diff              tinyint,
        @w_est_civil         catalogo		--LIM 09/DIC/2005

-----------------------------
--Inicializaci¢n de Variables
-----------------------------
select @w_sp_name = 'sp_valida_ente'

select @w_mayor_edad = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'MDE' 
   and pa_producto = 'ADM'
   and pa_tipo     = 'T'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end

select @w_par_cliente_menor = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'BME' 
   and pa_producto = 'PFI'
if @@rowcount = 0
begin
   return 101077  -- No existe parametro
end

--------------------------
--Codigos de Transacciones
--------------------------
if (@t_trn <> 14988)
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141112  --Error en codigo de transaccion
   return 1
end

---------------
--Procedimiento
---------------
select @w_en_subtipo = en_subtipo,
       @w_fecha_nac  = p_fecha_nac,
       @w_est_civil = p_estado_civil		--09/DIC/2005
  from cobis..cl_ente
 where en_ente = @i_ente

if @w_en_subtipo = 'P'
begin
   select @w_diff = datediff (yy,@w_fecha_nac, @s_date)

   --if @i_pignorado = 'S' and @w_diff < @w_mayor_edad and @w_par_cliente_menor = 'N'
   if @i_pignorado = 'S' and (@w_diff < @w_mayor_edad or @w_est_civil = 'ME') and @w_par_cliente_menor = 'N'  --LIM 09/DIC/2005	

   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141179  --Operacion esta pignorada. No se puede ingresar un propietario menor de edad.
      return 1
   end
end

return 0
go
