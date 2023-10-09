/************************************************************************/
/*   Archivo:                         cb_concmayt.sqr			*/
/*   Stored procedure:                sp_concil_mayoriz_terc		*/
/*   Base de datos:                   cob_conta                         */
/*   Producto:                        CONTABILIDAD			*/
/*   Disenado por:                    Mauricio Rincon			*/
/*   Fecha de escritura:              22-Mar-2006                       */
/************************************************************************/
/*              IMPORTANTE                                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR         */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*              PROPOSITO                                               */
/*   Carga tabla cb_concil_mayoriz_terc Saldos de Contabilidad y Saldos */
/*   cuentas terceros,para ubicar diferencias en mayorizacion terceros. */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*   FECHA       AUTOR                    RAZON                         */
/*   22MAR2006   Mauricio Rincon          Emision inicial		*/
/************************************************************************/

use cob_conta
go

if exists (SELECT * FROM sysobjects WHERE name = 'sp_concil_mayoriz_terc')
   drop proc sp_concil_mayoriz_terc
go

create proc sp_concil_mayoriz_terc(
   @i_empresa      tinyint,
   @i_fecha        datetime,
   @i_proceso      int = null,
   @i_modo         tinyint -- 0: Cargar Saldos Contabilidad, 1: Actualizar Saldos Terceros
)
as

DECLARE
   @w_sp_name		varchar(30),
   @w_error		int,
   @w_mensaje		varchar(24),
   @w_retorno		int,
   @w_return		int,
   @w_co_periodo_fm	int,
   @w_co_corte_fm	int,
-- Variables para Cursor Fechas Corte Procesadas --
   @w_co_periodo			int,
   @w_co_corte				int,
   @w_co_fecha_ini			datetime,
   @w_co_estado				char(1),
-- Variables para Cursor Saldos Cuentas Terceros --
   @w_cm_empresa      	tinyint,
   @w_cm_periodo      	int,
   @w_cm_corte        	int,
   @w_cm_cuenta       	cuenta_contable,
   @w_cm_oficina      	smallint,
   @w_cm_area         	smallint,
   @w_cm_sdo_mn_ter   	money,
   @w_cm_sdo_me_ter   	money,
   @w_ttercero          int,
   @w_contador          int,
   @w_horaini           datetime,
   @w_horafin           datetime

SELECT @w_sp_name = 'sp_concil_mayoriz_terc',
       @w_retorno = 0,
       @w_ttercero = 0,
       @w_contador = 0


/*************************************************************/
/*****SE CREA TABLA TEMPORAL PARA MANEJO DE SALDO TERCEROS****/
/*************************************************************/

select @w_horaini = getdate()
print @w_horaini

if exists (select 1 from sysobjects where name = 'cb_concil_may_terc2')
    drop table cb_concil_may_terc2

create table cb_concil_may_terc2
(
st_secuencial  int identity     not null,
st_empresa     tinyint   	not null,
st_periodo     int		not null,
st_corte       int		not null,
st_cuenta      varchar(11)	not null,
st_oficina     smallint  	not null,
st_area        smallint  	not null,
st_saldo       money		not null,
st_saldo_me    money		not null
)

create index cb_concil_may_terc2_key on cb_concil_may_terc2 (st_secuencial) 


/************************************************************/
/* CALCULA LAS CUENTAS ASOCIADAS A LOS PROCESOS 6003 Y 6095 */
/************************************************************/

delete cob_conta..cb_ctaproc_tmp

insert into cb_ctaproc_tmp(cp_cuenta)
select cp_cuenta from cb_cuenta_proceso
where cp_empresa = @i_empresa
and   cp_proceso in (6003,6095)

/***************************************************/
/* CALCULA PERIODO Y CORTE DE LA FECHA DEL REPORTE */
/***************************************************/
set transaction ISOLATION level READ UNCOMMITTED
select @w_co_periodo = co_periodo,
       @w_co_corte   = co_corte
  from cob_conta..cb_corte
 where co_empresa = @i_empresa
   and co_periodo >= 0
   and co_corte >= 0
   and co_fecha_ini >= @i_fecha
   and co_fecha_fin <= @i_fecha
if @@rowcount = 0
begin
   print 'ERROR (1): Corte para fecha ingresada no encontrado'
   return 1
end
else
begin
   print 'Conciliacion Saldos Contables x Tercero Fecha '+ cast (@i_fecha as varchar)
   print 'Conciliacion Saldos Contables Periodo y Corte %1!,%2! '+ cast(@w_co_periodo as varchar) + ' ' + cast(@w_co_corte as varchar)
end

/*************************************************************/
/* CALCULA CORTE CORRESPONDE AL FIN DE MES DE FECHA INGRESADA*/
/*************************************************************/
set transaction ISOLATION level READ UNCOMMITTED
select @w_co_periodo_fm = co_periodo,
       @w_co_corte_fm   = max(co_corte)
  from cob_conta..cb_corte
 where co_empresa = convert(tinyint,@i_empresa)
   and co_periodo = @w_co_periodo
   and datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha)
 group by co_periodo
if @@rowcount = 0
begin
   print 'ERROR (2): Maximo Corte para Fin Mes de Fecha ingresada no encontrado'
   return 1
end
else
begin
   print 'Conciliacion Saldos x Tercero Periodo y Corte %1!,%2! ' + cast(@w_co_periodo_fm as varchar) + ' ' + cast(@w_co_corte_fm as varchar)
end

if @i_modo = 0
BEGIN
   DELETE cob_conta..cb_concil_may_terc
   DELETE cob_conta..cb_concil_may_terc2     

   if @@error != 0
      BEGIN
         /* Error al borrar saldos para conciliacion saldos de tercero */
         select @w_error = 1,
                @w_mensaje = 'Error al borrar saldos para conciliacion saldos de tercero'
         GOTO ERROR
      END
      
    Select @w_co_periodo = co_periodo,
           @w_co_corte = co_corte,
           @w_co_fecha_ini = co_fecha_ini,
           @w_co_estado = co_estado
      from cob_conta..cb_corte
     where co_fecha_ini = @i_fecha
       and co_empresa   = @i_empresa
       and co_periodo   = @w_co_periodo
       and co_corte     = @w_co_corte
     order by co_periodo, co_corte


      if @w_co_estado = 'A'
      begin
      --------------------------------------------------
      -- Inserta_Saldos_desde_Contabilidad_Actual (C) --
      --------------------------------------------------
         print 'Carga Saldos desde cob_conta *** Periodo y Corte '+ cast(@w_co_periodo as varchar) + cast(@w_co_corte as varchar)
         INSERT into cob_conta..cb_concil_may_terc
         SELECT @i_empresa,	@w_co_periodo,	@w_co_corte,	sa_cuenta,
	        sa_oficina,	sa_area,	sum(sa_saldo),	sum(sa_saldo_me),
	        0,		0
  	   from cob_conta..cb_saldo, cob_conta..cb_ctaproc_tmp
 	  where sa_cuenta > '0'
   	    and sa_oficina > 0
   	    and sa_area > 0
   	    and sa_corte = @w_co_corte
   	    and sa_periodo = @w_co_periodo
   	    and sa_empresa = @i_empresa
   	    and sa_cuenta  = cp_cuenta
 	  group by sa_cuenta,sa_oficina,sa_area
         if @@error != 0
         BEGIN
	    /* Error en insercion de registro */
            select @w_retorno = 1,
                   @w_mensaje = 'Error al insertar desde cob_conta'
            GOTO ERROR
         END
      end
      else
      begin
      -----------------------------------------------------
      -- Inserta_Saldos_desde_Contabilidad_Historica (H) --
      -----------------------------------------------------
         print 'Carga Saldos desde cob_conta_his Periodo y Corte %1!,%2! '+ cast(@w_co_periodo as varchar) + cast(@w_co_corte as varchar)
         INSERT into cob_conta..cb_concil_may_terc
         SELECT @i_empresa,	@w_co_periodo,	@w_co_corte,	hi_cuenta,
	        hi_oficina,	hi_area,	sum(hi_saldo),	sum(hi_saldo_me),
	        0,		0
  	   from cob_conta_his..cb_hist_saldo, cob_conta..cb_ctaproc_tmp
 	  where hi_cuenta > '0'
   	    and hi_oficina > 0
   	    and hi_area > 0
   	    and hi_corte = @w_co_corte
   	    and hi_periodo = @w_co_periodo
   	    and hi_empresa = @i_empresa
   	    and hi_cuenta  = cp_cuenta
 	  group by hi_cuenta,hi_oficina,hi_area
         if @@error != 0
         BEGIN
	    /* Error en insercion de registro */
            select @w_retorno = 1,
                   @w_mensaje = 'Error al insertar desde cob_conta_historico'
            GOTO ERROR
         END
      end
      /*********************************************************************/
      -- Seleccion Saldos Terceros para actualizar tabla Saldos Contables --
      /*********************************************************************/

       insert into cb_concil_may_terc2(st_empresa,st_periodo,st_corte,st_cuenta,st_oficina,st_area,st_saldo,st_saldo_me)
       select @i_empresa,	@w_co_periodo_fm,	@w_co_corte_fm,
              st_cuenta,	st_oficina,	st_area,
              sum(st_saldo),	sum(st_saldo_me)
         from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_ctaproc_tmp
        where st_corte    = @w_co_corte_fm
          and st_periodo  = @w_co_periodo_fm
          and st_cuenta   = cp_cuenta
          and st_empresa  = @i_empresa
	group by st_cuenta,st_oficina,st_area


/**********************************************************************/
/*********************SE MODIFICA CURSOR POR WHILE*********************/
/**********************************************************************/

       select @w_ttercero = count(1) from cb_concil_may_terc2

       while @w_contador <= @w_ttercero
       begin
          select @w_contador = @w_contador + 1
   
          select @w_cm_cuenta = st_cuenta,	@w_cm_oficina = st_oficina,	        @w_cm_area = st_area,
                 @w_cm_sdo_mn_ter = st_saldo,	@w_cm_sdo_me_ter = st_saldo_me
          from cb_concil_may_terc2 
          where st_secuencial = @w_contador


       /********************************************************/
       -- Valida_Existencia Registros Saldos Cuentas Terceros --
       /********************************************************/
          if exists (select 1
                  from cob_conta..cb_concil_may_terc
                  where cm_empresa  = @i_empresa
                  and cm_periodo  = @w_co_periodo
                  and cm_corte    = @w_co_corte
                  and cm_cuenta   = @w_cm_cuenta
                  and cm_oficina  = @w_cm_oficina
                  and cm_area     = @w_cm_area)
          begin
          -- Actualiza Saldos Terceros en el mismo registro de saldos contables --
             update cob_conta..cb_concil_may_terc
                set cm_sdo_mn_ter = @w_cm_sdo_mn_ter,
                    cm_sdo_me_ter = @w_cm_sdo_me_ter
              where cm_empresa = @i_empresa
                and cm_periodo = @w_co_periodo
                and cm_corte   = @w_co_corte
                and cm_cuenta  = @w_cm_cuenta
                and cm_oficina = @w_cm_oficina
                and cm_area    = @w_cm_area

               if @@error != 0
               BEGIN
                  /* Error en insercion de registro */
                  select @w_retorno = 1,
                         @w_mensaje = 'Error en Actualizar Saldos de Tercero'
                  GOTO ERROR
               END
            end
            else
	    begin
            -- Inserta registro Saldos de tercero no existe registro saldos contables --
               INSERT INTO cob_conta..cb_concil_may_terc
               	       (cm_empresa,	cm_periodo,	cm_corte,
                        cm_cuenta,	cm_oficina,	cm_area,
                        cm_sdo_mn_con,	cm_sdo_me_con,	cm_sdo_mn_ter,
                        cm_sdo_me_ter)
               values
               	    (@i_empresa,	@w_co_periodo,	@w_co_corte,
    	    	     @w_cm_cuenta,	@w_cm_oficina,	@w_cm_area,
   	    	     0,		0,		@w_cm_sdo_mn_ter,
   	    	     @w_cm_sdo_me_ter)

               if @@error != 0
               BEGIN
               /* Error en insercion de registro Saldos de Tercero */
                  select @w_retorno = 1,
                         @w_mensaje = 'Error en Inserta_BOC'
                  GOTO ERROR
               END
	    end
   end   

/**********************************************************************/

END 
select @w_horafin = getdate()
print @w_horafin

print 'sp_concil_mayoriz_terc OK'
return 0

ERROR:
print 'ERROR: %1!'+ @w_mensaje

while @@trancount > 0 rollback tran

return @w_retorno

go
