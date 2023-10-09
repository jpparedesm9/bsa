/************************************************************************/
/*      Archivo:                cu_hiscus.sp                            */
/*      Stored procedure:       sp_historial_custodia                   */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Silvia Portilla S.                      */
/*      Fecha de escritura:     10/02/2006                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite almacenar la informacion del historial    */
/*      de los estados de las garantias en custodia                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      11/Mayo/2006     Silvia Portilla S.      Emision Inicial        */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_historial_custodia')
   drop proc sp_historial_custodia
go


create proc sp_historial_custodia
(
   @s_ssn              int          = null,
   @s_date             datetime     = null,
   @s_user             login        = null,
   @s_term             varchar(64)  = null,
   @s_corr             char(1)      = null,   
   @s_ssn_corr         int          = null,
   @s_ofi              smallint     = null,
   @s_srv              varchar(30)  = null,
   @s_lsrv             varchar(30)  = null,
   @t_rty              char(1)      = null,
   @t_from             varchar(30)  = null,
   @t_trn              smallint     = null,
   @i_operacion        char(1)      = null,
   @i_codigo_externo   varchar(64)  = null,
   @i_estado           char(3)      = null,
   @i_dep_origen       char(1)      = null,
   @i_dep_destino      char(1)      = '',
   @i_comentario       varchar(255) = '',
   @i_dependencia      catalogo     = ''

)

as
declare
   @w_sp_name      varchar(60),
   @w_secuencial   int

select @w_sp_name = 'sp_historial_custodia'


if @i_operacion = 'I'
begin
   select @w_secuencial = isnull(max(hc_secuencia),0) + 1
   from 	cu_historial_custodia
   where hc_codigo_externo = @i_codigo_externo

   insert into cu_historial_custodia
	   (hc_codigo_externo,   hc_secuencia,     hc_fecha,     hc_estado, 
	   hc_dep_origen,        hc_dep_destino,   hc_usuario,   hc_comentario,
	   hc_dependencia)
   values
	   (@i_codigo_externo,   @w_secuencial,    @s_date,      @i_estado, 
	    @i_dep_origen,       @i_dep_destino,   @s_user,      @i_comentario,
	    @i_dependencia)

    if @@error <> 0 
    begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903001
      return 1903001
    end 

    insert into ts_historia_custodia
	    (secuencial,   tipo_transaccion,   clase, 
	     fecha,        usuario,            terminal,   
	     tabla,        codigo_externo,     estado,
	     dep_origen,   dep_dest,           comentario)
    values
	    (@s_ssn,                   @t_trn,              'N',			
	    getdate(),                 @s_user,             @s_term,		
	    'cu_historia_custodia',    @i_codigo_externo,   @i_estado,   
	    @i_dep_origen,             @i_dep_destino,      @i_comentario)

    if @@error <> 0 
    begin
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1903003
      return 1903003
    end 
end


return 0
go


