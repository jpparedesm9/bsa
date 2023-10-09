/****************************************************************************/
/*     Archivo:     cierre.sp                                               */
/*     Stored procedure: sp_cierre                                          */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
USE cob_remesas
GO
if exists (select
             1
           from   sysobjects
           where  name = 'sp_cierre')
  drop proc sp_cierre
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_cierre (
  @s_user		varchar(32),
  @s_date		datetime ,
  @s_ofi		smallint,
  @t_rty		char(1) = 'N',
  @t_trn		int,
  @i_filial		int = 1,
  @i_mon		tinyint,
  @i_tipo		char(1) = 'T', -- Tipo de Cierre Total(T), Parcial (P)
  @i_idcaja		int,
  @i_sldini		money = null,
  @i_sldfin		money = null,
  @i_idcierre		int = null,
  @i_pit		char(1) = 'N',
  @i_oficaja		smallint = null
)
as
declare
  @w_sp_name		varchar(64),
  @w_tipo		varchar(3),
  @w_return		int,
  @w_horaini		datetime,
  @w_horafin		datetime,
  @w_saldo_final	money,
  @w_idcierre		int

select @w_saldo_final	= 0,
       @w_return	= 0,
       @w_sp_name	= 'sp_cierre'

-- Validaciones
-- Si es el reentry no cierre pues la transaccion ya fue cerrada en el estado de fuera de linea
if @t_rty = 'S'
  return 0

-- Transacciones
-- 496 Insercion o inicio de un nuevo periodo 
-- 497 Actualizacion o cuadre/proceso de cierre del periodo
-- 499 Eliminacion del estatus "cerrado " a un periodo de cierre

-- Insercion de un nuevo periodo o apertura de un periodo
if @t_trn = 496
begin
  begin tran
  
  -- Obtenga la hora de inicio
  select  @w_horaini	= convert(datetime,convert(char(6), @s_date, 12) + ' ' +
			  convert(char(8), getdate(), 8) )
  insert into cob_remesas..re_cierre
	  ( ci_filial, ci_oficina,
	    ci_fecha, ci_id_caja, ci_id_cierre,
	    ci_moneda,ci_tipo,  ci_usuario,
	    ci_hora_ini, ci_hora_fin, ci_efectivo_ini, 
	    ci_efectivo_fin)
  values
	  (@i_filial, @s_ofi,@s_date, @i_idcaja, @i_idcierre,
	   @i_mon,'T', @s_user,
	   @w_horaini,null, @i_sldini,
	   null)
  if @@error <> 0  
    begin
     if @i_pit = 'N'
     begin
      exec cobis..sp_cerror
	      @t_from   = @w_sp_name,
	      @i_num    = 353029,
	      @i_sev 	= 1
      return 353029    
     end
    end

  commit tran
end

-- Actualizacion por cuadre o proceso de cierre del periodo
if @t_trn = 497
begin
  -- Obtenga el efectivo final existente en caja al cerrar la misma
  -- Leer el saldo de la caja antes de ser afectado por la transaccion
  -- si es que no se ha podido leer en la primera ejecucion

    select @w_saldo_final = @i_sldfin

  -- Cierre el registro colocando la hora y efectivo final del periodo e indicando si
  -- es un cierre Total o Parcial.
  begin tran

  -- Calculo de la hora actual - final
  select  @w_horafin =  convert(datetime,convert(char(6), @s_date, 12) + ' ' +
			convert(char(8), getdate(), 8) )
      
  update cob_remesas..re_cierre
     set ci_hora_fin		= @w_horafin,
	 ci_tipo		= @i_tipo,
	 ci_efectivo_fin	= @w_saldo_final
   where ci_filial		= @i_filial
     and ci_oficina		= @i_oficaja
     and ci_fecha		= @s_date
     and ci_id_caja		= @i_idcaja
     and ci_moneda		= @i_mon
     and ci_id_cierre		= @i_idcierre
  if @@error <> 0
  begin
    -- No se pudo efectuar el cierre
    exec cobis..sp_cerror
	    @t_from   = @w_sp_name,
	    @i_num    = 355032,
	    @i_sev 	= 1
    return 355032 /* GEB: Interface PIT */
  end

  -- Abra un periodo de cierre automaticamente si el cierre fue parcial
  if @i_tipo = 'P'
  begin
    -- Obtenga el secuencial para el siguiente Cierre
    select @w_idcierre = @i_idcierre + 1
          
    -- Obtenga la hora de inicio
    select  @w_horaini = convert(datetime,convert(char(6), @s_date, 12) + ' ' +
			 convert(char(8), getdate(), 8) )
    insert into cob_remesas..re_cierre
	    (ci_filial, ci_oficina,
	     ci_fecha, ci_id_caja, ci_id_cierre,
	     ci_moneda, ci_tipo, ci_usuario,
	     ci_hora_ini, ci_hora_fin, ci_efectivo_ini, 
	     ci_efectivo_fin)
    values
	    (@i_filial, @i_oficaja,
	     @s_date, @i_idcaja, @w_idcierre,
	     @i_mon, 'T', @s_user,
	     @w_horaini,null, @w_saldo_final,
	     null)
    if @@error <> 0      
      begin
        exec cobis..sp_cerror
	        @t_from   = @w_sp_name,
	        @i_num    = 355032,
		@i_sev 	= 1
           return 355032     
      end
  end

  commit tran   
end -- Fin Actualizacion de un nuevo periodo

-- Eliminacion del status "Cerrado" a un periodo de cierre
if @t_trn = 499
begin
  begin tran
    /** Si elimino un cierre Parcial entonces elimino el registro existente y anulo en 
        el anterior registro los campos de fecha y efetivo final. **/
    if @i_tipo = 'P'
      begin
        delete from cob_remesas..re_cierre
         where ci_filial	= @i_filial
           and ci_oficina	= @i_oficaja
           and ci_fecha		= @s_date
           and ci_id_caja	= @i_idcaja
           and ci_moneda	= @i_mon
           and ci_id_cierre	= @i_idcierre
        if @@error <> 0
        begin
          -- No se pudo eliminar  el cierre
          exec cobis..sp_cerror
	          @t_from   = @w_sp_name,
	          @i_num    = 357011,
		  @i_sev 	= 1 
          return 357011
        end
        select @w_idcierre = @i_idcierre - 1 
        update cob_remesas..re_cierre
           set ci_hora_fin		= null,
	             ci_tipo		= 'T',
	             ci_efectivo_fin	= null
         where ci_filial		= @i_filial
           and ci_oficina		= @i_oficaja
           and ci_fecha		= @s_date
           and ci_id_caja		= @i_idcaja
           and ci_moneda		= @i_mon
           and ci_id_cierre		= @w_idcierre
           and ci_hora_fin		is not null -- Periodo de Cierre ya cuadrado
           and ci_efectivo_fin	is not null -- Periodo de Cierre ya cuadrado
        if @@error <> 0
        begin
          -- No se pudo reactivar el anterior periodo de cierre
          exec cobis..sp_cerror
	          @t_from   = @w_sp_name,
	          @i_num    = 357011,
		  @i_sev 	= 1
          return 357011
        end
    end
    else
      begin
        /** 
         Si elimino un cierre Total solamente anulo en el anterior registro los campos 
         de fecha y efectivo final. 
        **/

        select @w_idcierre = @i_idcierre  
        update cob_remesas..re_cierre
           set  ci_hora_fin		= null,
	        ci_tipo		= 'T',
	        ci_efectivo_fin	= null
         where ci_filial		= @i_filial
           and ci_oficina		= @i_oficaja
           and ci_fecha		        = @s_date
           and ci_id_caja		= @i_idcaja
           and ci_moneda		= @i_mon
           and ci_id_cierre		= @w_idcierre
           and ci_hora_fin		is not null -- Periodo de Cierre ya cuadrado
           and ci_efectivo_fin	is not null -- Periodo de Cierre ya cuadrado

        if @@error <> 0
          begin
            -- No se pudo reactivar el anterior periodo de cierre
            exec cobis..sp_cerror
	      @t_from   = @w_sp_name,
	      @i_num    = 357011,
	      @i_sev 	= 1
            return 357011
          end
      end
  commit tran   
end
  
return 0


GO


