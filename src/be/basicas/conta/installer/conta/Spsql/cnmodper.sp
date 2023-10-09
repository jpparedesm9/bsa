/************************************************************************/
/*           Archivo:                cnmodpe.sp                         */
/*           Stored procedure:       sp_cnmodper.sp                     */
/*           Base de datos:          cob_conta                          */
/*           Producto:               contabilidad                       */
/*           Disenado por:                                              */
/*           Fecha de escritura:     28-03-2008                         */
/************************************************************************/
/*                            IMPORTANTE                                */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                             PROPOSITO                                */
/*      Este programa consulta las transacciones de servicio            */
/*      Pertenecientes a las modificaciones de perfiles.                */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*        FECHA           AUTOR           RAZON                         */
/*        28/03/2008                      Emision Inicial               */
/************************************************************************/
use cob_conta
go
if exists(select 1 from sysobjects where name = 'sp_cnmodper' and xtype = 'P')
     drop proc sp_cnmodper
go

create proc sp_cnmodper
(
     @s_ssn         int         = null,
     @s_date        datetime    = null,
     @s_user        login       = null,
     @s_term        descripcion = null,
     @s_corr        char(1)     = null,
     @s_ssn_corr    int         = null,
     @s_ofi         smallint    = null,
     @t_rty         char(1)     = null,
     @t_trn         smallint    = null,
     @t_debug       char(1)     = 'N',
     @t_file        varchar(14) = null,
     @t_from        varchar(30) = null,
     @i_usuario     login,
     @i_fecha_ini   datetime    = '01/01/1900',
     @i_fecha_fin   datetime    = '12/31/2200',
     @i_perfil      varchar(14) = '%',
     @i_operacion   char(1),
     @i_modo        tinyint,
     @i_secuencial  int         = null,
     @i_empresa     tinyint     = 1
)
as
declare
     @w_existe      tinyint,
     @w_today       datetime,    /* fecha del dia               */
     @w_return      int,         /* valor que retorna           */
     @w_sp_name     varchar(32)  /* nombre del stored procedure */

select @w_today = getdate()
select @w_sp_name = 'sp_cnmodper'
                    
if (@t_trn <> 6213 and @i_operacion = 'Q') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

if @t_debug = 'S'
begin
     exec cobis..sp_begin_debug @t_file = @t_file
     select '/** Store Procedure **/ ' = @w_sp_name,
          t_file      = @t_file,
          t_from      = @t_from,
          i_operacion = @i_operacion,
          i_empresa   = @i_empresa,      
          i_perfil    = @i_perfil,
          i_fecha_ini = @i_fecha_ini,
          i_fecha_fin = @i_fecha_fin,
          i_usuario   = @i_usuario,
          i_modo      = @i_modo
     exec cobis..sp_end_debug
end

if @i_operacion = 'Q'
Begin
     set rowcount 20
     if @i_modo = 0
     Begin
          select
                "SECUENCIAL"   = secuencial, 
                "TIPO.TRANSAC" = tipo_transaccion,
                "CLASE"        = clase,
                "FECHA"        = fecha,
                "USUARIO"      = usuario,
                "TERMINAL"     = terminal,
                "OFICINA"      = oficina,
                "EMPRESA"      = empresa,
                "PERFIL"       = perfil          
          from cob_conta..ts_perfil
          where fecha >= @i_fecha_ini
          and   fecha <= @i_fecha_fin
          and   usuario like @i_usuario
          and   perfil like @i_perfil
          and    secuencial > 0
          order by secuencial
          
          if @@rowcount = 0
          begin
              /* 'No existen Registros para la consulta dada' */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601153
              return 1
          end     
     End
     if @i_modo = 1
     Begin
          select
                "SECUENCIAL"   = secuencial, 
                "TIPO.TRANSAC" = tipo_transaccion,
                "CLASE"        = clase,
                "FECHA"        = fecha,
                "USUARIO"      = usuario,
                "TERMINAL"     = terminal,
                "OFICINA"      = oficina,
                "EMPRESA"      = empresa,
                "PERFIL"       = perfil          
          from cob_conta..ts_perfil
          where fecha       >= @i_fecha_ini
          and   fecha       <= @i_fecha_fin
          and   usuario     like @i_usuario
          and   perfil      like @i_perfil
          and    secuencial > @i_secuencial
          order by secuencial
          
          if @@rowcount = 0
          begin
              /* 'No existen Registros para la consulta dada' */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601153
              return 1
          end
     End
End

return 0
go
     