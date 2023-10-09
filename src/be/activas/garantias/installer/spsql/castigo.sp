/************************************************************************/
/*	Archivo: 	        castigo.sp 				*/
/*	Stored procedure:       sp_castigo                              */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Milena Gonzalez                   	*/
/*	Fecha de escritura:     Diciembre-2000                          */	
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*      Este programa permite realizar el castido de una garantia, rea- */
/*      marcando la garantia como castigada  (S/N) y realizando el res- */
/*      pectivo cambio de estado (X,V). Adem s genera las transacciones */
/*      contables por los cambios de estado.                            */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_castigo')
    drop proc sp_castigo
go
create proc sp_castigo (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint = null,
   @t_trn                smallint = null,
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @t_debug                char(1) = null,
   @i_castigo            char(1)      = null,
   @i_codigo_externo     varchar(64) = null,
   @i_operacion          varchar(64) = null,
   @i_descripcion        varchar(64) = null, --pga18jul2001
   @o_estado             char(1) = null out
)
as
declare
   @w_today              datetime,     
   @w_sp_name            varchar(32)  ,
   @w_estado             char(1),
   @w_castigo            char(1),
   @w_codigo_externo      varchar(64)

select @w_sp_name = 'sp_castigo'

if @t_trn <> 19910  and @i_operacion = 'U'
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'U'
begin
if @i_codigo_externo IS NULL 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901005 
    return 1 
end
else
begin
--begin tran
   select @w_estado = cu_estado
   from cob_custodia..cu_custodia
   where cu_codigo_externo = @i_codigo_externo
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end

if (@i_castigo = 'S' and @w_estado = 'X') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1905021
    return 1 
end

if (@i_castigo = 'N' and @w_estado = 'V') 
begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1905022
    return 1 
end
if @i_castigo = 'S' and @w_estado = 'V' 
begin
   select @i_descripcion = "CAMBIO DE ESTADO POR CASTIGO"
   exec cob_custodia..sp_cambios_estado
   @s_user = @s_user,
   @s_date = @s_date,
   @s_term = @s_term,
   @s_ofi = @s_ofi,
   @i_operacion = 'I',
   @i_estado_ini = @w_estado,
   @i_estado_fin = 'X',
   @i_codigo_externo = @i_codigo_externo,
   @i_descripcion    = @i_descripcion, 
   @i_banderafe = 'S'

  update cob_custodia..cu_custodia
  set    cu_castigo = @i_castigo
  where  cu_codigo_externo = @i_codigo_externo
end

if @i_castigo = 'N' and @w_estado = 'X' --Reversa
begin
   select @i_descripcion = "CAMBIO DE ESTADO POR REVERSA DE CASTIGO"
   exec cob_custodia..sp_cambios_estado
   @s_user = @s_user,
   @s_date = @s_date,
   @s_term = @s_term,
   @s_ofi = @s_ofi,
   @i_operacion = 'I',
   @i_estado_ini = @w_estado,
   @i_estado_fin = 'V',
   @i_codigo_externo = @i_codigo_externo,
   @i_descripcion    = @i_descripcion, 
   @i_banderafe = 'S'

  update cob_custodia..cu_custodia
  set    cu_castigo ='N' 
  where  cu_codigo_externo = @i_codigo_externo
end

--commit tran
--return 0
end --if codigo externo no es null
end

   select @o_estado = cu_estado
   from cob_custodia..cu_custodia
   where cu_codigo_externo = @i_codigo_externo
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901003
      return 1 
   end

select @o_estado

return 0
go
